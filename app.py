from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route('/execute', methods=['POST'])
def execute():
    data = request.get_json()
    script_content = data.get('script')
    
    if not script_content:
        return jsonify({"error": "No script provided"}), 400

    # Write the script to the /tmp directory
    tmp_script_path = '/tmp/script.py'
    
    with open(tmp_script_path, 'w') as script_file:
        script_file.write(script_content)
    
    # Execute the script within nsjail
    try:
        result = subprocess.run(
            ['/usr/bin/nsjail', '-C', '/app/nsjail.cfg', '/usr/bin/python3', tmp_script_path],
            capture_output=True, text=True, timeout=10  # Adjust timeout as needed
        )
    except subprocess.TimeoutExpired:
        return jsonify({"error": "Script execution timed out"}), 500
    except Exception as e:
        return jsonify({"error": "Script execution error", "message": str(e)}), 500
    
    if result.returncode != 0:
        return jsonify({"error": "Script execution error", "message": result.stderr}), 500
    
    return jsonify({"result": result.stdout})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
