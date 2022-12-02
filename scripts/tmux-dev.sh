SESSION=dev
tmux new-session -d -s $SESSION

tmux split-window -v -p 12 
tmux select-pane -t 0
tmux send-keys "vim" C-m 

tmux attach -t $SESSION
