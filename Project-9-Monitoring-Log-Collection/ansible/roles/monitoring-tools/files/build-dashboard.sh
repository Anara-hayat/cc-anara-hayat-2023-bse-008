#!/bin/bash

OUTPUT_DIR="/var/www/html"
mkdir -p "$OUTPUT_DIR"

cat > "$OUTPUT_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project 9 Monitoring Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #667eea;
            --secondary: #764ba2;
            --success: #22c55e;
            --danger: #ef4444;
            --warning: #f59e0b;
            --dark: #1f2937;
            --light: #f9fafb;
            --border: #e5e7eb;
        }

        body {
            font-family: 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header */
        header {
            background: white;
            padding: 40px;
            border-radius: 20px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        header h1 {
            color: var(--dark);
            font-size: 2.5em;
            margin-bottom: 10px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .timestamp {
            color: #6b7280;
            font-size: 1em;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .timestamp::before {
            content: 'Ìµê';
        }

        /* Status Indicators */
        .status-indicator {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            margin-top: 15px;
        }

        .status-up {
            background: rgba(34, 197, 94, 0.1);
            color: var(--success);
        }

        .status-down {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        /* Grid */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        /* Cards */
        .card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
        }

        .card h2 {
            color: var(--primary);
            font-size: 1.4em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-content {
            background: var(--light);
            padding: 20px;
            border-radius: 12px;
            font-family: 'Monaco', 'Courier New', monospace;
            font-size: 0.9em;
            line-height: 1.6;
            color: var(--dark);
            max-height: 250px;
            overflow-y: auto;
            white-space: pre-wrap;
            word-break: break-word;
        }

        /* Scrollbar */
        .card-content::-webkit-scrollbar {
            width: 8px;
        }

        .card-content::-webkit-scrollbar-track {
            background: var(--border);
            border-radius: 4px;
        }

        .card-content::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 4px;
        }

        /* Reports Section */
        .reports-section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border);
        }

        .reports-section h2 {
            color: var(--dark);
            font-size: 1.8em;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .report-link {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 25px;
            border-radius: 15px;
            text-decoration: none;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            border: none;
            cursor: pointer;
        }

        .report-link:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .report-link:active {
            transform: scale(0.98);
        }

        /* Footer */
        footer {
            text-align: center;
            margin-top: 50px;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95em;
        }

        footer p {
            margin: 5px 0;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card, header, .reports-section {
            animation: fadeIn 0.6s ease-out;
        }

        /* Loading State */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid var(--border);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            header {
                padding: 25px;
            }

            header h1 {
                font-size: 1.8em;
            }

            .grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .reports-grid {
                grid-template-columns: 1fr;
            }

            body {
                padding: 20px 10px;
            }
        }

        /* Stats */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .stat {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            padding: 15px;
            border-radius: 10px;
            border-left: 4px solid var(--primary);
        }

        .stat-label {
            color: #6b7280;
            font-size: 0.85em;
            font-weight: 500;
        }

        .stat-value {
            color: var(--dark);
            font-size: 1.3em;
            font-weight: 700;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <header>
            <h1>Ì≥ä Project 9 Monitoring Dashboard</h1>
            <div class="timestamp" id="timestamp">Last updated: <span id="time"></span></div>
            <div class="status-indicator status-up">‚óè System Status: HEALTHY</div>
        </header>

        <!-- Main Grid -->
        <div class="grid">
            <!-- System Metrics Card -->
            <div class="card">
                <h2>Ì≤ª System Metrics</h2>
                <div class="card-content" id="metrics">
                    <div class="loading"></div> Loading metrics...
                </div>
            </div>

            <!-- Service Status Card -->
            <div class="card">
                <h2>‚öôÔ∏è Service Status</h2>
                <div class="card-content" id="services">
                    <div class="loading"></div> Loading services...
                </div>
            </div>

            <!-- Health Checks Card -->
            <div class="card">
                <h2>Ìø• Health Checks</h2>
                <div class="card-content" id="health">
                    <div class="loading"></div> Loading health checks...
                </div>
            </div>
        </div>

        <!-- Reports Section -->
        <div class="reports-section">
            <h2>Ì≥Å Reports & Monitoring Data</h2>
            <div class="reports-grid">
                <a href="reports/latest-metrics.txt" target="_blank" class="report-link">
                    Ì≥à Latest Metrics
                </a>
                <a href="reports/service-status.txt" target="_blank" class="report-link">
                    ‚öôÔ∏è Service Status
                </a>
                <a href="reports/health-checks.txt" target="_blank" class="report-link">
                    Ìø• Health Checks
                </a>
                <a href="reports/" target="_blank" class="report-link">
                    Ì≥Ç All Reports
                </a>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <p>Ì∫Ä Project 9 - Infrastructure Monitoring and Log Collection System</p>
            <p>Monitoring powered by Terraform, Ansible, and Bash</p>
            <p style="margin-top: 15px; font-size: 0.85em; opacity: 0.8;">Last refresh: <span id="footer-time">Just now</span></p>
        </footer>
    </div>

    <!-- JavaScript -->
    <script>
        // Update timestamp
        function updateTime() {
            const now = new Date();
            document.getElementById('time').textContent = now.toLocaleString();
            document.getElementById('footer-time').textContent = now.toLocaleTimeString();
        }

        // Load metrics
        function loadData() {
            // Load metrics
            fetch('reports/latest-metrics.txt')
                .then(r => r.text())
                .then(data => {
                    document.getElementById('metrics').innerHTML = data || '‚ö†Ô∏è No data available';
                })
                .catch(e => {
                    document.getElementById('metrics').innerHTML = '‚ö†Ô∏è Unable to load metrics';
                });

            // Load service status
            fetch('reports/service-status.txt')
                .then(r => r.text())
                .then(data => {
                    document.getElementById('services').innerHTML = data || '‚ö†Ô∏è No data available';
                })
                .catch(e => {
                    document.getElementById('services').innerHTML = '‚ö†Ô∏è Unable to load service status';
                });

            // Load health checks
            fetch('reports/health-checks.txt')
                .then(r => r.text())
                .then(data => {
                    document.getElementById('health').innerHTML = data || '‚ö†Ô∏è No data available';
                })
                .catch(e => {
                    document.getElementById('health').innerHTML = '‚ö†Ô∏è Unable to load health checks';
                });

            updateTime();
        }

        // Initial load
        loadData();

        // Refresh every 30 seconds
        setInterval(loadData, 30000);

        // Update time every second
        setInterval(updateTime, 1000);
    </script>
</body>
</html>
EOF

echo "Dashboard built at $OUTPUT_DIR/index.html"
