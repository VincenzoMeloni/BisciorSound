package GUI;

import java.awt.BorderLayout;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.EmptyBorder;
import java.awt.Color;
import javax.swing.JButton;
import java.awt.Font;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.SQLException;
import Controller.*;

public class lista_cover extends JFrame {

	private JPanel contentPane;
	private Controller controller;
	Connection conn = null;
	boolean checkAdmin = false;
	String user = GUI.admin_login.getNomeLoginAdmin();
	String scelta = null;
	private JFrame frame;

	/**
	 * Create the frame.
	 */
	public lista_cover(Controller c, JFrame frameChiamante) {
		frame = this;
		controller = c;
		setTitle("Lista Cover");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(255, 204, 0));
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton back_button = new JButton("Home");
		back_button.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					checkAdmin = controller.ControlloAdmin(controller.UserData());
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				if (checkAdmin == true) {
					home_admin home_admin = new home_admin(controller, frameChiamante);
					home_admin.setVisible(true);
					dispose();
				}
				else {
				    home_utente home_utente = new home_utente(controller, frameChiamante);
				    home_utente.setVisible(true);
				    dispose();
				}
			}
		});
		back_button.setBounds(10, 232, 85, 21);
		contentPane.add(back_button);
		
		JList listaCover = new JList();

		listaCover.setBounds(190, 235, 160, 197);
		contentPane.add(listaCover);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 11, 315, 210);
		contentPane.add(scrollPane);
		
		controller.ListaCover(listaCover);
		
		JButton button_tracce = new JButton("Mostra Tracce");
		button_tracce.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				lista_tracce lista_tracce = new lista_tracce(controller, frameChiamante);
				lista_tracce.setVisible(true);
				dispose();
			}
		});
		button_tracce.setBounds(296, 231, 128, 21);
		contentPane.add(button_tracce);
		
		JButton btnPreferiti = new JButton("<html>Aggiungi ai<br />Preferiti</html>");
		btnPreferiti.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				scelta = (String) listaCover.getSelectedValue();
				if (scelta == null)
					JOptionPane.showMessageDialog(null, "Errore. Nessuna cover scelta!");
				else
					DAELIMINARE.gestionePreferiti.aggiungi_preferito_cover(scelta);
			}
		});
		btnPreferiti.setBounds(335, 50, 89, 49);
		contentPane.add(btnPreferiti);
		
		scrollPane.setViewportView(listaCover);
	}
}
