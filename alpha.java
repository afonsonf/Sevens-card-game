package app;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import org.jpl7.Query;
import org.jpl7.Term;

import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionListener;
import java.awt.image.FilteredImageSource;
import java.awt.image.RGBImageFilter;
import java.util.Map;
import java.awt.event.ActionEvent;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Image;
import java.awt.Toolkit;

import javax.swing.UIManager;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.ImageIcon;
import javax.swing.SwingConstants;

public class alpha extends JFrame {

	static final long serialVersionUID = 1;

	private JPanel contentPane;
	private JTextField cardSelc;
	private JButton[] cardsM;
	private JTextPane logP;
	private JPanel deckM;

	private Term board; // board
	private Term players; // lista de players
	private Term hand; // cartas na mao
	private Term card; // carta jogada
	private String sh; // hand como string
	private String sb; // board como string
	private String sp; // players como string
	private int k; // flag para quando o jogo acabou
	private int j; // jogador a jogar
	private int sem; // semaforo
	private int qa4;
	private int gstart;
	private JLabel label_1copas;
	private JLabel label_2copas;
	private JLabel label_3copas;
	private JLabel label_4copas;
	private JLabel label_5copas;
	private JLabel label_6copas;
	private JLabel label_7copas;
	private JLabel label_8copas;
	private JLabel label_9copas;
	private JLabel label_10copas;
	private JLabel label_11copas;
	private JLabel label_12copas;
	private JLabel label_13copas;
	private JLabel label_1espadas;
	private JLabel label_2espadas;
	private JLabel label_3espadas;
	private JLabel label_4espadas;
	private JLabel label_5espadas;
	private JLabel label_6espadas;
	private JLabel label_7espadas;
	private JLabel label_8espadas;
	private JLabel label_9espadas;
	private JLabel label_10espadas;
	private JLabel label_11espadas;
	private JLabel label_12espadas;
	private JLabel label_13espadas;
	private JPanel panel_ouros;
	private JLabel label_1ouros;
	private JLabel label_13ouros;
	private JLabel label_2ouros;
	private JLabel label_3ouros;
	private JLabel label_4ouros;
	private JLabel label_5ouros;
	private JLabel label_6ouros;
	private JLabel label_7ouros;
	private JLabel label_8ouros;
	private JLabel label_9ouros;
	private JLabel label_10ouros;
	private JLabel label_11ouros;
	private JLabel label_12ouros;
	private JPanel panel_paus;
	private JLabel label_13paus;
	private JLabel label_1paus;
	private JLabel label_2paus;
	private JLabel label_3paus;
	private JLabel label_4paus;
	private JLabel label_5paus;
	private JLabel label_6paus;
	private JLabel label_7paus;
	private JLabel label_8paus;
	private JLabel label_9paus;
	private JLabel label_10paus;
	private JLabel label_11paus;
	private JLabel label_12paus;
	private JPanel copas0;
	private JPanel copas1;
	private JPanel espadas0;
	private JPanel espadas1;
	private JPanel ouros0;
	private JPanel ouros1;
	private JPanel paus0;
	private JPanel paus1;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		Query q = new Query("['Sevens.pl']");
		q.hasSolution();

		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					alpha frame = new alpha();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public alpha() {
		gstart=0;
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 1243, 490);
		contentPane = new JPanel();
		contentPane.setLocation(-124, -52);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		JPanel panel_copas = new JPanel();
		panel_copas.setBounds(304, 75, 602, 68);
		contentPane.add(panel_copas);
		panel_copas.setBackground(UIManager.getColor("OptionPane.questionDialog.titlePane.shadow"));
		panel_copas.setLayout(null);
		
		copas0 = new JPanel();
		copas0.setBounds(8, 5, 268, 58);
		FlowLayout flowLayout = (FlowLayout) copas0.getLayout();
		flowLayout.setAlignment(FlowLayout.RIGHT);
		flowLayout.setVgap(0);
		flowLayout.setHgap(4);
		copas0.setBackground(null);
		panel_copas.add(copas0);

		label_1copas = new JLabel("");
		copas0.add(label_1copas);
		label_1copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/A de copas.jpg")));

		label_2copas = new JLabel("");
		copas0.add(label_2copas);
		label_2copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/2 de copas.jpg")));

		label_3copas = new JLabel("");
		copas0.add(label_3copas);
		label_3copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/3 de copas.jpg")));

		label_4copas = new JLabel("");
		copas0.add(label_4copas);
		label_4copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/4 de copas.jpg")));

		label_5copas = new JLabel("");
		copas0.add(label_5copas);
		label_5copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/5 de copas.jpg")));

		label_6copas = new JLabel("");
		copas0.add(label_6copas);
		label_6copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/6 de copas.jpg")));

		label_7copas = new JLabel("");
		label_7copas.setBounds(281, 5, 40, 58);
		label_7copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/7 de copas.jpg")));
		panel_copas.add(label_7copas);
		
		copas1 = new JPanel();
		copas1.setBounds(326, 5, 268, 58);
		FlowLayout flowLayout_1 = (FlowLayout) copas1.getLayout();
		flowLayout_1.setAlignment(FlowLayout.LEFT);
		flowLayout_1.setVgap(0);
		flowLayout_1.setHgap(4);
		copas1.setBackground(null);
		panel_copas.add(copas1);

		label_8copas = new JLabel("");
		copas1.add(label_8copas);
		label_8copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/8 de copas.jpg")));

		label_9copas = new JLabel("");
		copas1.add(label_9copas);
		label_9copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/9 de copas.jpg")));

		label_10copas = new JLabel("");
		copas1.add(label_10copas);
		label_10copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/10 de copas.jpg")));

		label_11copas = new JLabel("");
		copas1.add(label_11copas);
		label_11copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/J de copas.jpg")));

		label_12copas = new JLabel("");
		copas1.add(label_12copas);
		label_12copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/Q de copas.jpg")));

		label_13copas = new JLabel("");
		copas1.add(label_13copas);
		label_13copas.setIcon(new ImageIcon(alpha.class.getResource("/cards_copas/K de copas.jpg")));

		JPanel panel_espadas = new JPanel();
		panel_espadas.setBackground((Color) null);
		panel_espadas.setBounds(304, 142, 602, 68);
		contentPane.add(panel_espadas);
		panel_espadas.setBackground(UIManager.getColor("OptionPane.questionDialog.titlePane.shadow"));
		panel_espadas.setLayout(null);
		
		espadas0 = new JPanel();
		espadas0.setBounds(8, 5, 268, 58);
		FlowLayout flowLayout_2 = (FlowLayout) espadas0.getLayout();
		flowLayout_2.setAlignment(FlowLayout.RIGHT);
		flowLayout_2.setVgap(0);
		flowLayout_2.setHgap(4);
		espadas0.setBackground(null);
		panel_espadas.add(espadas0);

		label_1espadas = new JLabel("");
		espadas0.add(label_1espadas);
		label_1espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/A de espadas.jpg")));

		label_2espadas = new JLabel("");
		espadas0.add(label_2espadas);
		label_2espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/2 de espadas.jpg")));

		label_3espadas = new JLabel("");
		espadas0.add(label_3espadas);
		label_3espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/3 de espadas.jpg")));

		label_4espadas = new JLabel("");
		espadas0.add(label_4espadas);
		label_4espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/4 de espadas.jpg")));

		label_5espadas = new JLabel("");
		espadas0.add(label_5espadas);
		label_5espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/5 de espadas.jpg")));

		label_6espadas = new JLabel("");
		espadas0.add(label_6espadas);
		label_6espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/6 de espadas.jpg")));

		label_7espadas = new JLabel("");
		label_7espadas.setBounds(281, 5, 40, 58);
		label_7espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/7 de espadas.jpg")));
		panel_espadas.add(label_7espadas);
		
		espadas1 = new JPanel();
		espadas1.setBounds(326, 5, 268, 58);
		FlowLayout flowLayout_3 = (FlowLayout) espadas1.getLayout();
		flowLayout_3.setAlignment(FlowLayout.LEFT);
		flowLayout_3.setVgap(0);
		flowLayout_3.setHgap(4);
		espadas1.setBackground(null);
		panel_espadas.add(espadas1);

		label_8espadas = new JLabel("");
		espadas1.add(label_8espadas);
		label_8espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/8 de espadas.jpg")));

		label_9espadas = new JLabel("");
		espadas1.add(label_9espadas);
		label_9espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/9 de espadas.jpg")));

		label_10espadas = new JLabel("");
		espadas1.add(label_10espadas);
		label_10espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/10 de espadas.jpg")));

		label_11espadas = new JLabel("");
		espadas1.add(label_11espadas);
		label_11espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/J de espadas.jpg")));

		label_12espadas = new JLabel("");
		espadas1.add(label_12espadas);
		label_12espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/Q de espadas.jpg")));

		label_13espadas = new JLabel("");
		espadas1.add(label_13espadas);
		label_13espadas.setIcon(new ImageIcon(alpha.class.getResource("/cards_espadas/K de espadas.jpg")));

		panel_ouros = new JPanel();
		panel_ouros.setBackground((Color) null);
		panel_ouros.setBounds(304, 210, 602, 68);
		contentPane.add(panel_ouros);
		panel_ouros.setBackground(UIManager.getColor("OptionPane.questionDialog.titlePane.shadow"));
		panel_ouros.setLayout(null);
		
		ouros0 = new JPanel();
		ouros0.setBounds(8, 5, 268, 58);
		ouros0.setBackground(null);
		FlowLayout flowLayout_4 = (FlowLayout) ouros0.getLayout();
		flowLayout_4.setAlignment(FlowLayout.RIGHT);
		flowLayout_4.setVgap(0);
		flowLayout_4.setHgap(4);
		panel_ouros.add(ouros0);

		label_1ouros = new JLabel("");
		ouros0.add(label_1ouros);
		label_1ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/A de ouros.jpg")));

		label_2ouros = new JLabel("");
		ouros0.add(label_2ouros);
		label_2ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/2 de paus.jpg")));

		label_3ouros = new JLabel("");
		ouros0.add(label_3ouros);
		label_3ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/3 de paus.jpg")));

		label_4ouros = new JLabel("");
		ouros0.add(label_4ouros);
		label_4ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/4 de paus.jpg")));

		label_5ouros = new JLabel("");
		ouros0.add(label_5ouros);
		label_5ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/5 de paus.jpg")));

		label_6ouros = new JLabel("");
		ouros0.add(label_6ouros);
		label_6ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/6 de paus.jpg")));

		label_7ouros = new JLabel("");
		label_7ouros.setBounds(281, 5, 40, 58);
		label_7ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/7 de paus.jpg")));
		panel_ouros.add(label_7ouros);
		
		ouros1 = new JPanel();
		ouros1.setBounds(326, 5, 268, 58);
		ouros1.setBackground(null);
		FlowLayout flowLayout_5 = (FlowLayout) ouros1.getLayout();
		flowLayout_5.setAlignment(FlowLayout.LEFT);
		flowLayout_5.setVgap(0);
		flowLayout_5.setHgap(4);
		panel_ouros.add(ouros1);

		label_8ouros = new JLabel("");
		ouros1.add(label_8ouros);
		label_8ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/8 de paus.jpg")));

		label_9ouros = new JLabel("");
		ouros1.add(label_9ouros);
		label_9ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/9 de paus.jpg")));

		label_10ouros = new JLabel("");
		ouros1.add(label_10ouros);
		label_10ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/10 de paus.jpg")));

		label_11ouros = new JLabel("");
		ouros1.add(label_11ouros);
		label_11ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/J de ouros.jpg")));

		label_12ouros = new JLabel("");
		ouros1.add(label_12ouros);
		label_12ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/Q de ouros.jpg")));

		label_13ouros = new JLabel("");
		ouros1.add(label_13ouros);
		label_13ouros.setIcon(new ImageIcon(alpha.class.getResource("/cards_ouros/K de ouros.jpg")));

		deckM = new JPanel();

		panel_paus = new JPanel();
		panel_paus.setBackground((Color) null);
		panel_paus.setBounds(304, 277, 602, 68);
		contentPane.add(panel_paus);
		panel_paus.setBackground(UIManager.getColor("OptionPane.questionDialog.titlePane.shadow"));
		panel_paus.setLayout(null);
		
		paus0 = new JPanel();
		paus0.setBounds(8, 5, 268, 58);
		paus0.setBackground(null);
		FlowLayout fl_paus0 = (FlowLayout) paus0.getLayout();
		fl_paus0.setAlignment(FlowLayout.RIGHT);
		fl_paus0.setVgap(0);
		fl_paus0.setHgap(4);
		panel_paus.add(paus0);

		label_1paus = new JLabel("");
		paus0.add(label_1paus);
		label_1paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/A de paus.jpg")));

		label_2paus = new JLabel("");
		paus0.add(label_2paus);
		label_2paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/2 de paus.jpg")));

		label_3paus = new JLabel("");
		paus0.add(label_3paus);
		label_3paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/3 de paus.jpg")));

		label_4paus = new JLabel("");
		paus0.add(label_4paus);
		label_4paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/4 de paus.jpg")));

		label_5paus = new JLabel("");
		paus0.add(label_5paus);
		label_5paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/5 de paus.jpg")));

		label_6paus = new JLabel("");
		paus0.add(label_6paus);
		label_6paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/6 de paus.jpg")));

		label_7paus = new JLabel("");
		label_7paus.setBounds(281, 5, 40, 58);
		label_7paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/7 de paus.jpg")));
		panel_paus.add(label_7paus);
		
		paus1 = new JPanel();
		paus1.setBounds(326, 5, 268, 58);
		paus1.setBackground(null);
		FlowLayout flowLayout_6 = (FlowLayout) paus1.getLayout();
		flowLayout_6.setAlignment(FlowLayout.LEFT);
		flowLayout_6.setVgap(0);
		flowLayout_6.setHgap(4);
		panel_paus.add(paus1);

		label_8paus = new JLabel("");
		paus1.add(label_8paus);
		label_8paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/8 de paus.jpg")));

		label_9paus = new JLabel("");
		paus1.add(label_9paus);
		label_9paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/9 de paus.jpg")));

		label_10paus = new JLabel("");
		paus1.add(label_10paus);
		label_10paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/10 de paus.jpg")));

		label_11paus = new JLabel("");
		paus1.add(label_11paus);
		label_11paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/J de paus.jpg")));

		label_12paus = new JLabel("");
		paus1.add(label_12paus);
		label_12paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/Q de paus.jpg")));

		label_13paus = new JLabel("");
		paus1.add(label_13paus);
		label_13paus.setIcon(new ImageIcon(alpha.class.getResource("/cards_paus/K de paus.jpg")));
		JLabel lblCartasNaMao = new JLabel("Cartas na mao");
		lblCartasNaMao.setHorizontalAlignment(SwingConstants.CENTER);
		lblCartasNaMao.setFont(new Font("Tahoma", Font.PLAIN, 18));
		lblCartasNaMao.setBounds(916, 46, 301, 22);
		contentPane.add(lblCartasNaMao);
		deckM.setBackground(new Color(222, 184, 135));

		deckM.setBounds(916, 75, 301, 272);
		contentPane.add(deckM);
		deckM.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));

		cardSelc = new JTextField();
		cardSelc.setHorizontalAlignment(SwingConstants.CENTER);
		cardSelc.setFont(new Font("Tahoma", Font.PLAIN, 15));
		cardSelc.setEditable(false);
		cardSelc.setBounds(523, 356, 161, 35);
		contentPane.add(cardSelc);
		cardSelc.setColumns(10);

		JButton btnPlay = new JButton("Jogar carta");
		btnPlay.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnPlay.setBackground(Color.ORANGE);
		btnPlay.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(gstart==1)playCard();
			}
		});
		btnPlay.setBounds(533, 393, 141, 35);
		contentPane.add(btnPlay);

		cardsM = new JButton[20];
		for (int i = 0; i < 20; i++) {
			cardsM[i] = new JButton();
		}
		JButton btnNewGame = new JButton("Novo jogo");
		btnNewGame.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnNewGame.setBackground(Color.ORANGE);
		btnNewGame.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				iniciar();

				Query q;
				Map<String, Term> solution;

				q = new Query("getPlayer(" + sp + ",j(N,H,B,P),1)");
				solution = q.oneSolution();
				hand = solution.get("H");
				String[] cNaMao = getcards(hand); // cada string da forma "A de
													// B", para alterar alterar
													// getcards()
				for (int i = 0; i < 13; i++) {

					String ax = cardgetA(cNaMao[i]);
					String b = cardgetB(cNaMao[i]);

					if (ax.compareTo("1") == 0)
						ax = new String("A");
					if (ax.compareTo("11") == 0)
						ax = new String("J");
					if (ax.compareTo("12") == 0)
						ax = new String("Q");
					if (ax.compareTo("13") == 0)
						ax = new String("K");

					//ao invez de nome botar as imgs
					
					cardsM[i].setText(new String(ax + " de " + b));
					cardsM[i].setFont(new Font("Arial", Font.PLAIN, 0));
					cardsM[i].setIcon(new ImageIcon(alpha.class.getResource("/cards_top/"+ax + " de " + b+".jpg")));
					cardsM[i].setAlignmentX(CENTER_ALIGNMENT);;
					cardsM[i].setAlignmentY(CENTER_ALIGNMENT);
					cardsM[i].setHorizontalAlignment(SwingConstants.CENTER);
					cardsM[i].setBackground((Color) null);
					cardsM[i].setPreferredSize(new Dimension(125, 30));
					JButton x = cardsM[i];
					cardsM[i].addActionListener(new ActionListener() {
						public void actionPerformed(ActionEvent e) {
							if (sem == 0) {
								gstart=1;
								cardSelc.setText(x.getText());
							}
						}
					});
					deckM.add(cardsM[i]);
				}
				q = new Query("getPlayer(" + sp + ",j(N,H,B,P),1)");
				solution = q.oneSolution();
				hand = solution.get("H");
				sb = putBnice(board);
				sh = toStringnice(hand);

				for (int i = 0; i < 13; i++) {

					String cardk = cardsM[i].getText();
					String ax = cardgetA(cardk);
					String b = cardgetB(cardk);
					int a;
					//System.out.println(ax+" "+cardsM.length);
					if (ax.compareTo("A") == 0)
						a = 1;
					else if (ax.compareTo("J") == 0)
						a = 11;
					else if (ax.compareTo("Q") == 0)
						a = 12;
					else if (ax.compareTo("K") == 0)
						a = 13;
					else
						a = Integer.parseInt(ax);

					String r = a + " de " + b;

					q = new Query("permitted_play(card(" + r + ")," + sb + "),member(card(" + r + ")," + sh + ")");
					// System.out.println(q.toString());
					if (q.hasSolution()) {
						Image im  = (new ImageIcon(alpha.class.getResource("/cards_top/"+ax + " de " + b+".jpg"))).getImage();
						Image img = Toolkit.getDefaultToolkit().createImage(
								new FilteredImageSource(im.getSource(),new greenfilter()));
						cardsM[i].setIcon(new ImageIcon(img));
						break;
					}
				}

				bots();
			}
		});
		btnNewGame.setBounds(95, 370, 135, 38);
		contentPane.add(btnNewGame);

		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(40, 75, 241, 272);
		contentPane.add(scrollPane);

		logP = new JTextPane();
		logP.setEditable(false);
		scrollPane.setViewportView(logP);

		JLabel lblTabuleiro = new JLabel("Tabuleiro");
		lblTabuleiro.setHorizontalAlignment(SwingConstants.CENTER);
		lblTabuleiro.setFont(new Font("Tahoma", Font.PLAIN, 20));
		lblTabuleiro.setBounds(304, 46, 602, 22);
		contentPane.add(lblTabuleiro);

		JLabel lblJogadasAnteriores = new JLabel("Jogadas anteriores");
		lblJogadasAnteriores.setHorizontalAlignment(SwingConstants.CENTER);
		lblJogadasAnteriores.setFont(new Font("Tahoma", Font.PLAIN, 18));
		lblJogadasAnteriores.setBounds(40, 46, 241, 22);
		contentPane.add(lblJogadasAnteriores);

	}

	// inicializa
	private void iniciar() {
		Query q;
		Map<String, Term> solution;

		// inicializa variaveis board,players,j,k,...
		q = new Query("playX(Board,Players,FirstNj)");
		solution = q.oneSolution();
		board = solution.get("Board");
		players = solution.get("Players");
		j = solution.get("FirstNj").intValue();
		k = 0;
		sem = 0;
		sb = putBnice(board);
		sp = putPnice(players);

		logP.setText("Novo jogo:\n\n");
		qa4 = 0;
		cardSelc.setText("");

		// set all cards invisible
		clearBoard();

	}

	// Da print ao rank
	private void endgame() {
		String r = new String("\nAcabou o jogo!\n\nRanking:\n");
		sp = putPnice(players);
		Query q = new Query("rank(" + sp + ",Lrank)");
		Map<String, Term> sol = q.oneSolution();
		Term[] t = sol.get("Lrank").toTermArray();
		for (int i = 0; i < t.length; i++) {
			if (t[i].arg(2).intValue() == 1)
				r += (i + 1) + " lugar: Human (" + t[i].arg(1) + ")\n";
			else
				r += (i + 1) + " lugar: Bot " + (t[i].arg(2).intValue() - 1) + " (" + t[i].arg(1) + ")\n";
		}
		logP.setText(logP.getText() + r);
	}

	// simula os bots
	private void bots() {
		Query q;
		Map<String, Term> solution;
		int temp;

		while (j != 1 && k == 0) {
			q = new Query("play_round((" + sb + "),(" + sp + "),(" + Integer.toString(j) + "),B2,P2,J2,K,C)");
			solution = q.oneSolution();
			board = solution.get("B2");
			players = solution.get("P2");
			k = solution.get("K").intValue();
			temp = j - 1;
			j = solution.get("J2").intValue();
			card = solution.get("C");
			sb = putBnice(board);
			sp = putPnice(players);
			if (card.toString().compareTo("a") == 0) { // deu burry
				qa4++;
				if (qa4 % 4 == 0)
					logP.setText(logP.getText() + ("Bot " + temp + " deu burry a uma carta!\n\n"));
				else
					logP.setText(logP.getText() + ("Bot " + temp + " deu burry a uma carta!\n"));

			} else { // jogou uma carta
				String x = card.arg(1).arg(1).toString();
				if (x.compareTo("1") == 0) {
					x = new String("A");
				}
				if (x.compareTo("11") == 0) {
					x = new String("J");
				}
				if (x.compareTo("12") == 0) {
					x = new String("Q");
				}
				if (x.compareTo("13") == 0) {
					x = new String("K");
				}

				cardtoBoard(x + " de " + card.arg(1).arg(2).toString());

				qa4++;
				if (qa4 % 4 == 0)
					logP.setText(
							logP.getText() + ("Bot " + temp + " jogou " + x + " de " + card.arg(1).arg(2) + "!\n\n"));
				else
					logP.setText(
							logP.getText() + ("Bot " + temp + " jogou " + x + " de " + card.arg(1).arg(2) + "!\n"));
			}
		}
		if (k == 1) {
			endgame();
			return;
		}

		q = new Query("getPlayer(" + sp + ",j(N,H,B,P),1)");
		solution = q.oneSolution();
		hand = solution.get("H");
		sb = putBnice(board);
		sh = toStringnice(hand);

		for (int i = 0; i < 13; i++) {

			String card = cardsM[i].getText();
			String ax = cardgetA(card);
			int a;
			String b = cardgetB(card);

			if (ax.compareTo("A") == 0)
				a = 1;
			else if (ax.compareTo("J") == 0)
				a = 11;
			else if (ax.compareTo("Q") == 0)
				a = 12;
			else if (ax.compareTo("K") == 0)
				a = 13;
			else
				a = Integer.parseInt(ax);

			String r = a + " de " + b;

			q = new Query("permitted_play(card(" + r + ")," + sb + "),member(card(" + r + ")," + sh + ")");
			// System.out.println(q.toString());
			if (q.hasSolution()) {
				Image im  = (new ImageIcon(alpha.class.getResource("/cards_top/"+ax + " de " + b+".jpg"))).getImage();
				Image img = Toolkit.getDefaultToolkit().createImage(
						new FilteredImageSource(im.getSource(),new greenfilter()));
				cardsM[i].setIcon(new ImageIcon(img));
				break;
			}
		}

	}

	// joga a carta selecionada
	private void playCard() {
		Query q;
		Map<String, Term> solution;

		q = new Query("getPlayer(" + sp + ",j(N,H,B,P),1)");
		solution = q.oneSolution();
		hand = solution.get("H");
		sb = putBnice(board);
		sh = toStringnice(hand);
		for (int i = 0; i < 13; i++) {

			String card = cardsM[i].getText();
			String ax = cardgetA(card);
			int a;
			String b = cardgetB(card);

			if (ax.compareTo("A") == 0)
				a = 1;
			else if (ax.compareTo("J") == 0)
				a = 11;
			else if (ax.compareTo("Q") == 0)
				a = 12;
			else if (ax.compareTo("K") == 0)
				a = 13;
			else
				a = Integer.parseInt(ax);

			String r = a + " de " + b;

			q = new Query("permitted_play(card(" + r + ")," + sb + "),member(card(" + r + ")," + sh + ")");
			// System.out.println(q.toString());
			if (q.hasSolution()) {
				Image im  = (new ImageIcon(alpha.class.getResource("/cards_top/"+ax + " de " + b+".jpg"))).getImage();
				Image img = Toolkit.getDefaultToolkit().createImage(
						new FilteredImageSource(im.getSource(),new greenfilter()));
				cardsM[i].setIcon(new ImageIcon(img));
				break;
			}
		}

		sem = 1;
		q = new Query("possiblePlays(" + sb + "," + sh + ")");
		if (q.hasSolution()) { // joga
			String cardS = cardSelc.getText();
			String ax = cardgetA(cardS);
			int a;
			String b = cardgetB(cardS);

			if (ax.compareTo("A") == 0)
				a = 1;
			else if (ax.compareTo("J") == 0)
				a = 11;
			else if (ax.compareTo("Q") == 0)
				a = 12;
			else if (ax.compareTo("K") == 0)
				a = 13;
			else
				a = Integer.parseInt(ax);

			q = new Query("legal_play_card(card(" + a + " de " + b + ")," + sh + "," + sb + ")");
			// System.out.println(card);
			// System.out.println(sh);
			// System.out.println(sb);
			// System.out.println(q.toString());
			if (!q.hasSolution()) {
				sem = 0;
				// System.out.println("a");
				return;// carta nao valida
			}

			q = new Query("playFinalCard(card(" + a + " de " + b + ")," + sb + "," + sp + ",1,B2,P2,J2)");
			solution = q.oneSolution();
			board = solution.get("B2");
			players = solution.get("P2");
			j = solution.get("J2").intValue();
			sb = putBnice(board);
			sp = putPnice(players);

			qa4++;
			if (qa4 % 4 == 0)
				logP.setText(logP.getText() + ("Human jogou " + ax + " de " + b + "!\n\n"));
			else
				logP.setText(logP.getText() + ("Human jogou " + ax + " de " + b + "!\n"));

			for (int i = 0; i < 13; i++) {
				if (cardsM[i].getText().compareTo(ax + " de " + b) == 0) {
					Image im  = (new ImageIcon(alpha.class.getResource("/cards_top/"+ax + " de " + b+".jpg"))).getImage();
					Image img = Toolkit.getDefaultToolkit().createImage(
							new FilteredImageSource(im.getSource(),new grayfilter()));
					cardsM[i].setIcon(new ImageIcon(img));
					break;
				}
			}

			cardtoBoard(cardS);

		} else { // da burry
			String cardS = cardSelc.getText();

			String ax = cardgetA(cardS);
			String b = cardgetB(cardS);

			int a;

			if (ax.compareTo("A") == 0)
				a = 1;
			else if (ax.compareTo("J") == 0)
				a = 11;
			else if (ax.compareTo("Q") == 0)
				a = 12;
			else if (ax.compareTo("K") == 0)
				a = 13;
			else
				a = Integer.parseInt(ax);

			q = new Query("legal_burry_card(card(" + a + " de " + b + ")," + sh + ")");
			// System.out.println(q.toString());
			if (!q.hasSolution()) {
				sem = 0;
				return;// carta nao valida
			}
			qa4++;
			if (qa4 % 4 == 0)
				logP.setText(logP.getText() + ("Human deu burry a " + ax + " de " + b + "!\n\n"));
			else
				logP.setText(logP.getText() + ("Human deu burry a " + ax + " de " + b + "!\n"));

			for (int i = 0; i < 13; i++) {

				if (cardsM[i].getText().compareTo(ax + " de " + b) == 0) {
					Image im  = (new ImageIcon(alpha.class.getResource("/cards_top/"+ax + " de " + b+".jpg"))).getImage();
					Image img = Toolkit.getDefaultToolkit().createImage(
							new FilteredImageSource(im.getSource(),new redfilter()));
					cardsM[i].setIcon(new ImageIcon(img));
					break;
				}
			}

			Query game = new Query("burryFinalCard(card(" + a + " de " + b + ")," + sb + "," + sp + ",1,B2,P2,J2)");
			solution = game.oneSolution();
			board = solution.get("B2");
			players = solution.get("P2");
			j = solution.get("J2").intValue();
			sb = putBnice(board);
			sp = putPnice(players);

		}
		sem = 0;

		Query test = new Query("end(" + sp + ")");
		// System.out.println(test.toString());
		if (test.hasSolution()) {// jogo terminou, mostrar caixa dialogo com
									// rank e fechar
			k = 1;
			endgame();
		} else {
			k = 0;
			//limpa carta selecionada
			cardSelc.setText("");
			gstart=0;
			bots();
		}
		
		
		
		
	}

	// adiciona a carta ao tabuleiro
	private void cardtoBoard(String cardS) {

		String ax = cardgetA(cardS);
		int a;
		String b = cardgetB(cardS);

		if (ax.compareTo("A") == 0)
			a = 1;
		else if (ax.compareTo("J") == 0)
			a = 11;
		else if (ax.compareTo("Q") == 0)
			a = 12;
		else if (ax.compareTo("K") == 0)
			a = 13;
		else
			a = Integer.parseInt(ax);

		if (b.compareTo("copas") == 0) {
			if (a == 1)
				label_1copas.setVisible(true);
			if (a == 2)
				label_2copas.setVisible(true);
			if (a == 3)
				label_3copas.setVisible(true);
			if (a == 4)
				label_4copas.setVisible(true);
			if (a == 5)
				label_5copas.setVisible(true);
			if (a == 6)
				label_6copas.setVisible(true);
			if (a == 7)
				label_7copas.setVisible(true);
			if (a == 8)
				label_8copas.setVisible(true);
			if (a == 9)
				label_9copas.setVisible(true);
			if (a == 10)
				label_10copas.setVisible(true);
			if (a == 11)
				label_11copas.setVisible(true);
			if (a == 12)
				label_12copas.setVisible(true);
			if (a == 13)
				label_13copas.setVisible(true);
		}

		else if (b.compareTo("espadas") == 0) {
			if (a == 1)
				label_1espadas.setVisible(true);
			if (a == 2)
				label_2espadas.setVisible(true);
			if (a == 3)
				label_3espadas.setVisible(true);
			if (a == 4)
				label_4espadas.setVisible(true);
			if (a == 5)
				label_5espadas.setVisible(true);
			if (a == 6)
				label_6espadas.setVisible(true);
			if (a == 7)
				label_7espadas.setVisible(true);
			if (a == 8)
				label_8espadas.setVisible(true);
			if (a == 9)
				label_9espadas.setVisible(true);
			if (a == 10)
				label_10espadas.setVisible(true);
			if (a == 11)
				label_11espadas.setVisible(true);
			if (a == 12)
				label_12espadas.setVisible(true);
			if (a == 13)
				label_13espadas.setVisible(true);	
		} 
		
		else if (b.compareTo("ouros") == 0) {
			if (a == 1)
				label_1ouros.setVisible(true);
			if (a == 2)
				label_2ouros.setVisible(true);
			if (a == 3)
				label_3ouros.setVisible(true);
			if (a == 4)
				label_4ouros.setVisible(true);
			if (a == 5)
				label_5ouros.setVisible(true);
			if (a == 6)
				label_6ouros.setVisible(true);
			if (a == 7)
				label_7ouros.setVisible(true);
			if (a == 8)
				label_8ouros.setVisible(true);
			if (a == 9)
				label_9ouros.setVisible(true);
			if (a == 10)
				label_10ouros.setVisible(true);
			if (a == 11)
				label_11ouros.setVisible(true);
			if (a == 12)
				label_12ouros.setVisible(true);
			if (a == 13)
				label_13ouros.setVisible(true);
		} 
		
		else if (b.compareTo("paus") == 0) {
			if (a == 1)
				label_1paus.setVisible(true);
			if (a == 2)
				label_2paus.setVisible(true);
			if (a == 3)
				label_3paus.setVisible(true);
			if (a == 4)
				label_4paus.setVisible(true);
			if (a == 5)
				label_5paus.setVisible(true);
			if (a == 6)
				label_6paus.setVisible(true);
			if (a == 7)
				label_7paus.setVisible(true);
			if (a == 8)
				label_8paus.setVisible(true);
			if (a == 9)
				label_9paus.setVisible(true);
			if (a == 10)
				label_10paus.setVisible(true);
			if (a == 11)
				label_11paus.setVisible(true);
			if (a == 12)
				label_12paus.setVisible(true);
			if (a == 13)
				label_13paus.setVisible(true);
		}
	}

	// passa para um board que pode ser enviado para um query
	private String putBnice(Term b) {
		String s = new String("[");
		Term[] t1 = b.toTermArray();
		for (int i = 0; i < t1.length - 1; i++) {
			s += "t(" + toStringnice(t1[i].arg(1)) + "," + t1[i].arg(2).toString() + "),";
		}
		s += "t(" + toStringnice(t1[t1.length - 1].arg(1)) + "," + t1[t1.length - 1].arg(2).toString() + ")]";
		// System.out.println(b.toString());
		// System.out.println(s);
		return s;
	}

	// passa para um players que pode ser enviado para um query
	private String putPnice(Term p) {
		String s = new String("[");
		Term[] t1 = p.toTermArray();
		for (int i = 0; i < t1.length - 1; i++) {
			s += "j(" + t1[i].arg(1).toString() + ",";
			s += toStringnice(t1[i].arg(2)) + ",";
			s += toStringnice(t1[i].arg(3)) + ",";
			s += t1[i].arg(4).toString() + "),";
		}
		s += "j(" + t1[t1.length - 1].arg(1).toString() + "," + toStringnice(t1[t1.length - 1].arg(2)) + ","
				+ toStringnice(t1[t1.length - 1].arg(3)) + "," + t1[t1.length - 1].arg(4).toString() + ")]";
		// System.out.println(p.toString());
		// System.out.println(s);
		return s;
	}

	// passa a string coiso que o java recebe para uma string que pode ser
	// enviado para um query
	private String toStringnice(Term t) {
		// System.out.println(t.arity());
		if (t.arity() == 0)
			return new String("[]");
		String s = new String("[");
		Term[] t1 = t.toTermArray();
		for (int i = 0; i < t1.length - 1; i++) {
			s += t1[i].toString() + ",";
		}
		s += t1[t1.length - 1].toString() + "]";

		return s;
	}

	// dada a lista de cardas em prolog converte para lista de strings das
	// cartas
	private String[] getcards(Term hand) {
		Term[] hs = hand.toTermArray();
		String[] r = new String[hs.length];
		for (int i = 0; i < hs.length; i++) {
			r[i] = new String(hs[i].arg(1).arg(1) + " de " + hs[i].arg(1).arg(2));
		}
		return r;
	}

	// Dado 'A de B' retorna 'A'
	private String cardgetA(String s) {
		String a = new String("");
		int i;
		for (i = 0; i < s.length(); i++) {
			if (s.charAt(i) == ' ')
				break;
			a += "" + s.charAt(i);
		}
		return a;
	}

	// Dado 'A de B' retorna 'B'
	private String cardgetB(String s) {
		String b = new String("");
		int i;
		for (i = 0; i < s.length(); i++) {
			if (s.charAt(i) == ' ')
				break;
		}
		for (i++; i < s.length(); i++) {
			if (s.charAt(i) == ' ')
				break;
		}
		for (i++; i < s.length(); i++) {
			b += "" + s.charAt(i);
		}
		return b;
	}

	class grayfilter extends RGBImageFilter {
	   public int filterRGB(int x, int y, int rgb) {
		   //System.out.println(rgb);
		   if(rgb>-1081922)return -0x272726;
		   return rgb;
	   }
	}
	class redfilter extends RGBImageFilter {
	   public int filterRGB(int x, int y, int rgb) {
		   //System.out.println(rgb);
		   if(rgb>-1081922)return -0x145966;
		   return rgb;
	   }
	}
	class greenfilter extends RGBImageFilter {
	   public int filterRGB(int x, int y, int rgb) {
		   //System.out.println(rgb);
		   if(rgb>-1081922)return -0x9b1771;
		   return rgb;
	   }
	}
	//		      return (((rgb & 0xff00ff00)) | ((rgb & 0xff00ff00)>>10) | ((rgb & 0xff00ff00)<<10));

	// make all cards invisible
	private void clearBoard() {

		// copas
		label_1copas.setVisible(false);
		label_2copas.setVisible(false);
		label_3copas.setVisible(false);
		label_4copas.setVisible(false);
		label_5copas.setVisible(false);
		label_6copas.setVisible(false);
		label_7copas.setVisible(false);
		label_8copas.setVisible(false);
		label_9copas.setVisible(false);
		label_10copas.setVisible(false);
		label_11copas.setVisible(false);
		label_12copas.setVisible(false);
		label_13copas.setVisible(false);

		// espadas
		label_1espadas.setVisible(false);
		label_2espadas.setVisible(false);
		label_3espadas.setVisible(false);
		label_4espadas.setVisible(false);
		label_5espadas.setVisible(false);
		label_6espadas.setVisible(false);
		label_7espadas.setVisible(false);
		label_8espadas.setVisible(false);
		label_9espadas.setVisible(false);
		label_10espadas.setVisible(false);
		label_11espadas.setVisible(false);
		label_12espadas.setVisible(false);
		label_13espadas.setVisible(false);
		
		// ouros
		label_1ouros.setVisible(false);
		label_2ouros.setVisible(false);
		label_3ouros.setVisible(false);
		label_4ouros.setVisible(false);
		label_5ouros.setVisible(false);
		label_6ouros.setVisible(false);
		label_7ouros.setVisible(false);
		label_8ouros.setVisible(false);
		label_9ouros.setVisible(false);
		label_10ouros.setVisible(false);
		label_11ouros.setVisible(false);
		label_12ouros.setVisible(false);
		label_13ouros.setVisible(false);
		
		// paus
		label_1paus.setVisible(false);
		label_2paus.setVisible(false);
		label_3paus.setVisible(false);
		label_4paus.setVisible(false);
		label_5paus.setVisible(false);
		label_6paus.setVisible(false);
		label_7paus.setVisible(false);
		label_8paus.setVisible(false);
		label_9paus.setVisible(false);
		label_10paus.setVisible(false);
		label_11paus.setVisible(false);
		label_12paus.setVisible(false);
		label_13paus.setVisible(false);
	}
}