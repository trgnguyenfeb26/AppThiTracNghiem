﻿
namespace AppThiTracNghiem
{
    partial class FormThi
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.Label mAMHLabel;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormThi));
            this.bdsGVDK = new System.Windows.Forms.BindingSource(this.components);
            this.dS = new AppThiTracNghiem.DS();
            this.bdsMH = new System.Windows.Forms.BindingSource(this.components);
            this.mONHOCTableAdapter = new AppThiTracNghiem.DSTableAdapters.MONHOCTableAdapter();
            this.tableAdapterManager = new AppThiTracNghiem.DSTableAdapters.TableAdapterManager();
            this.gIAOVIEN_DANGKYTableAdapter = new AppThiTracNghiem.DSTableAdapters.GIAOVIEN_DANGKYTableAdapter();
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar2 = new DevExpress.XtraBars.Bar();
            this.btnNopBai = new DevExpress.XtraBars.BarButtonItem();
            this.btnXemKQ = new DevExpress.XtraBars.BarButtonItem();
            this.btnThoat = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.barStaticItem1 = new DevExpress.XtraBars.BarStaticItem();
            this.panelControl2 = new DevExpress.XtraEditors.PanelControl();
            this.panelControl5 = new DevExpress.XtraEditors.PanelControl();
            this.lb_TENLOP = new System.Windows.Forms.Label();
            this.lb_4 = new System.Windows.Forms.Label();
            this.lb_MALOP = new System.Windows.Forms.Label();
            this.lb_3 = new System.Windows.Forms.Label();
            this.lb_TENSV = new System.Windows.Forms.Label();
            this.lb_2 = new System.Windows.Forms.Label();
            this.lb_MASV = new System.Windows.Forms.Label();
            this.lb_1 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panelControl4 = new DevExpress.XtraEditors.PanelControl();
            this.lblTime = new System.Windows.Forms.Label();
            this.lb_SoCauThi = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.lb_TrinhDo = new System.Windows.Forms.Label();
            this.lb_So = new System.Windows.Forms.Label();
            this.lb = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.spin_LanThi = new DevExpress.XtraEditors.SpinEdit();
            this.label2 = new System.Windows.Forms.Label();
            this.date_NgayThi = new DevExpress.XtraEditors.DateEdit();
            this.cmb_MonHoc = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.btn_BatDau = new System.Windows.Forms.Button();
            this.panelControl3 = new DevExpress.XtraEditors.PanelControl();
            this.bar3 = new DevExpress.XtraBars.Bar();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.gcNoiDung = new DevExpress.XtraEditors.GroupControl();
            this.rdbListQS = new DevExpress.XtraEditors.RadioGroup();
            this.rdbDA = new DevExpress.XtraEditors.RadioGroup();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.lblCauHoi = new System.Windows.Forms.Label();
            mAMHLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.bdsGVDK)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsMH)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl2)).BeginInit();
            this.panelControl2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl5)).BeginInit();
            this.panelControl5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl4)).BeginInit();
            this.panelControl4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spin_LanThi.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.date_NgayThi.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.date_NgayThi.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl3)).BeginInit();
            this.panelControl3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gcNoiDung)).BeginInit();
            this.gcNoiDung.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.rdbListQS.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.rdbDA.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            this.SuspendLayout();
            // 
            // mAMHLabel
            // 
            mAMHLabel.AutoSize = true;
            mAMHLabel.Font = new System.Drawing.Font("Times New Roman", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            mAMHLabel.Location = new System.Drawing.Point(13, 50);
            mAMHLabel.Name = "mAMHLabel";
            mAMHLabel.Size = new System.Drawing.Size(83, 19);
            mAMHLabel.TabIndex = 19;
            mAMHLabel.Text = "Môn Học:";
            // 
            // bdsGVDK
            // 
            this.bdsGVDK.DataMember = "GIAOVIEN_DANGKY";
            this.bdsGVDK.DataSource = this.dS;
            // 
            // dS
            // 
            this.dS.DataSetName = "DS";
            this.dS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // bdsMH
            // 
            this.bdsMH.DataMember = "MONHOC";
            this.bdsMH.DataSource = this.dS;
            // 
            // mONHOCTableAdapter
            // 
            this.mONHOCTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.BAITHITableAdapter = null;
            this.tableAdapterManager.BANGDIEMTableAdapter = null;
            this.tableAdapterManager.BODETableAdapter = null;
            this.tableAdapterManager.COSOTableAdapter = null;
            this.tableAdapterManager.GIAOVIEN_DANGKYTableAdapter = this.gIAOVIEN_DANGKYTableAdapter;
            this.tableAdapterManager.GIAOVIENTableAdapter = null;
            this.tableAdapterManager.KHOATableAdapter = null;
            this.tableAdapterManager.LOPTableAdapter = null;
            this.tableAdapterManager.MONHOCTableAdapter = this.mONHOCTableAdapter;
            this.tableAdapterManager.SINHVIENTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = AppThiTracNghiem.DSTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // gIAOVIEN_DANGKYTableAdapter
            // 
            this.gIAOVIEN_DANGKYTableAdapter.ClearBeforeFill = true;
            // 
            // barManager1
            // 
            this.barManager1.Bars.AddRange(new DevExpress.XtraBars.Bar[] {
            this.bar2});
            this.barManager1.DockControls.Add(this.barDockControlTop);
            this.barManager1.DockControls.Add(this.barDockControlBottom);
            this.barManager1.DockControls.Add(this.barDockControlLeft);
            this.barManager1.DockControls.Add(this.barDockControlRight);
            this.barManager1.Form = this;
            this.barManager1.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.btnNopBai,
            this.btnThoat,
            this.btnXemKQ,
            this.barStaticItem1});
            this.barManager1.MainMenu = this.bar2;
            this.barManager1.MaxItemId = 4;
            // 
            // bar2
            // 
            this.bar2.BarName = "Main menu";
            this.bar2.DockCol = 0;
            this.bar2.DockRow = 0;
            this.bar2.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar2.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(this.btnNopBai),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnXemKQ),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnThoat)});
            this.bar2.OptionsBar.MultiLine = true;
            this.bar2.OptionsBar.UseWholeRow = true;
            this.bar2.Text = "Main menu";
            // 
            // btnNopBai
            // 
            this.btnNopBai.Caption = "Nộp bài";
            this.btnNopBai.Id = 0;
            this.btnNopBai.ImageOptions.SvgImage = ((DevExpress.Utils.Svg.SvgImage)(resources.GetObject("btnNopBai.ImageOptions.SvgImage")));
            this.btnNopBai.Name = "btnNopBai";
            this.btnNopBai.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnNopBai.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnNopBai_ItemClick);
            // 
            // btnXemKQ
            // 
            this.btnXemKQ.Caption = "Xem kết quả";
            this.btnXemKQ.Id = 2;
            this.btnXemKQ.ImageOptions.SvgImage = ((DevExpress.Utils.Svg.SvgImage)(resources.GetObject("btnXemKQ.ImageOptions.SvgImage")));
            this.btnXemKQ.Name = "btnXemKQ";
            this.btnXemKQ.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            // 
            // btnThoat
            // 
            this.btnThoat.Caption = "Thoát";
            this.btnThoat.Id = 1;
            this.btnThoat.ImageOptions.SvgImage = ((DevExpress.Utils.Svg.SvgImage)(resources.GetObject("btnThoat.ImageOptions.SvgImage")));
            this.btnThoat.Name = "btnThoat";
            this.btnThoat.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnThoat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnThoat_ItemClick);
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Margin = new System.Windows.Forms.Padding(2);
            this.barDockControlTop.Size = new System.Drawing.Size(1690, 30);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 802);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Margin = new System.Windows.Forms.Padding(2);
            this.barDockControlBottom.Size = new System.Drawing.Size(1690, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 30);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Margin = new System.Windows.Forms.Padding(2);
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 772);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1690, 30);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Margin = new System.Windows.Forms.Padding(2);
            this.barDockControlRight.Size = new System.Drawing.Size(0, 772);
            // 
            // barStaticItem1
            // 
            this.barStaticItem1.Caption = "Time";
            this.barStaticItem1.Id = 3;
            this.barStaticItem1.Name = "barStaticItem1";
            // 
            // panelControl2
            // 
            this.panelControl2.Controls.Add(this.panelControl5);
            this.panelControl2.Controls.Add(this.panelControl4);
            this.panelControl2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelControl2.Location = new System.Drawing.Point(0, 30);
            this.panelControl2.Name = "panelControl2";
            this.panelControl2.Size = new System.Drawing.Size(1690, 175);
            this.panelControl2.TabIndex = 9;
            // 
            // panelControl5
            // 
            this.panelControl5.Controls.Add(this.lb_TENLOP);
            this.panelControl5.Controls.Add(this.lb_4);
            this.panelControl5.Controls.Add(this.lb_MALOP);
            this.panelControl5.Controls.Add(this.lb_3);
            this.panelControl5.Controls.Add(this.lb_TENSV);
            this.panelControl5.Controls.Add(this.lb_2);
            this.panelControl5.Controls.Add(this.lb_MASV);
            this.panelControl5.Controls.Add(this.lb_1);
            this.panelControl5.Controls.Add(this.label1);
            this.panelControl5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelControl5.Location = new System.Drawing.Point(954, 2);
            this.panelControl5.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panelControl5.Name = "panelControl5";
            this.panelControl5.Size = new System.Drawing.Size(734, 171);
            this.panelControl5.TabIndex = 5;
            // 
            // lb_TENLOP
            // 
            this.lb_TENLOP.AutoSize = true;
            this.lb_TENLOP.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_TENLOP.Location = new System.Drawing.Point(573, 102);
            this.lb_TENLOP.Name = "lb_TENLOP";
            this.lb_TENLOP.Size = new System.Drawing.Size(60, 23);
            this.lb_TENLOP.TabIndex = 25;
            this.lb_TENLOP.Text = "label7";
            // 
            // lb_4
            // 
            this.lb_4.AutoSize = true;
            this.lb_4.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_4.Location = new System.Drawing.Point(463, 102);
            this.lb_4.Name = "lb_4";
            this.lb_4.Size = new System.Drawing.Size(103, 23);
            this.lb_4.TabIndex = 24;
            this.lb_4.Text = "TÊN LỚP:";
            // 
            // lb_MALOP
            // 
            this.lb_MALOP.AutoSize = true;
            this.lb_MALOP.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_MALOP.Location = new System.Drawing.Point(573, 46);
            this.lb_MALOP.Name = "lb_MALOP";
            this.lb_MALOP.Size = new System.Drawing.Size(60, 23);
            this.lb_MALOP.TabIndex = 23;
            this.lb_MALOP.Text = "label5";
            // 
            // lb_3
            // 
            this.lb_3.AutoSize = true;
            this.lb_3.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_3.Location = new System.Drawing.Point(463, 46);
            this.lb_3.Name = "lb_3";
            this.lb_3.Size = new System.Drawing.Size(104, 23);
            this.lb_3.TabIndex = 22;
            this.lb_3.Text = "MÃ LỚP : ";
            // 
            // lb_TENSV
            // 
            this.lb_TENSV.AutoSize = true;
            this.lb_TENSV.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_TENSV.Location = new System.Drawing.Point(201, 102);
            this.lb_TENSV.Name = "lb_TENSV";
            this.lb_TENSV.Size = new System.Drawing.Size(60, 23);
            this.lb_TENSV.TabIndex = 21;
            this.lb_TENSV.Text = "label3";
            // 
            // lb_2
            // 
            this.lb_2.AutoSize = true;
            this.lb_2.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_2.Location = new System.Drawing.Point(114, 102);
            this.lb_2.Name = "lb_2";
            this.lb_2.Size = new System.Drawing.Size(85, 23);
            this.lb_2.TabIndex = 20;
            this.lb_2.Text = "TÊN SV:";
            // 
            // lb_MASV
            // 
            this.lb_MASV.AutoSize = true;
            this.lb_MASV.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_MASV.Location = new System.Drawing.Point(200, 46);
            this.lb_MASV.Name = "lb_MASV";
            this.lb_MASV.Size = new System.Drawing.Size(60, 23);
            this.lb_MASV.TabIndex = 19;
            this.lb_MASV.Text = "label2";
            // 
            // lb_1
            // 
            this.lb_1.AutoSize = true;
            this.lb_1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_1.Location = new System.Drawing.Point(114, 46);
            this.lb_1.Name = "lb_1";
            this.lb_1.Size = new System.Drawing.Size(77, 23);
            this.lb_1.TabIndex = 18;
            this.lb_1.Text = "MÃ SV:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.label1.Location = new System.Drawing.Point(6, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(150, 21);
            this.label1.TabIndex = 17;
            this.label1.Text = "Thông tin sinh viên";
            // 
            // panelControl4
            // 
            this.panelControl4.Controls.Add(this.lblTime);
            this.panelControl4.Controls.Add(this.lb_SoCauThi);
            this.panelControl4.Controls.Add(this.label10);
            this.panelControl4.Controls.Add(this.lb_TrinhDo);
            this.panelControl4.Controls.Add(this.lb_So);
            this.panelControl4.Controls.Add(this.lb);
            this.panelControl4.Controls.Add(this.label4);
            this.panelControl4.Controls.Add(this.spin_LanThi);
            this.panelControl4.Controls.Add(this.label2);
            this.panelControl4.Controls.Add(this.date_NgayThi);
            this.panelControl4.Controls.Add(mAMHLabel);
            this.panelControl4.Controls.Add(this.cmb_MonHoc);
            this.panelControl4.Controls.Add(this.label3);
            this.panelControl4.Dock = System.Windows.Forms.DockStyle.Left;
            this.panelControl4.Location = new System.Drawing.Point(2, 2);
            this.panelControl4.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panelControl4.Name = "panelControl4";
            this.panelControl4.Size = new System.Drawing.Size(952, 171);
            this.panelControl4.TabIndex = 4;
            // 
            // lblTime
            // 
            this.lblTime.AutoSize = true;
            this.lblTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTime.Location = new System.Drawing.Point(816, 65);
            this.lblTime.Name = "lblTime";
            this.lblTime.Size = new System.Drawing.Size(107, 39);
            this.lblTime.TabIndex = 11;
            this.lblTime.Text = "00:00";
            // 
            // lb_SoCauThi
            // 
            this.lb_SoCauThi.AutoSize = true;
            this.lb_SoCauThi.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_SoCauThi.Location = new System.Drawing.Point(517, 101);
            this.lb_SoCauThi.Name = "lb_SoCauThi";
            this.lb_SoCauThi.Size = new System.Drawing.Size(61, 23);
            this.lb_SoCauThi.TabIndex = 28;
            this.lb_SoCauThi.Text = "< 100 ";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(655, 72);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(155, 29);
            this.label10.TabIndex = 10;
            this.label10.Text = "THỜI GIAN:";
            // 
            // lb_TrinhDo
            // 
            this.lb_TrinhDo.AutoSize = true;
            this.lb_TrinhDo.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_TrinhDo.Location = new System.Drawing.Point(270, 99);
            this.lb_TrinhDo.Name = "lb_TrinhDo";
            this.lb_TrinhDo.Size = new System.Drawing.Size(71, 23);
            this.lb_TrinhDo.TabIndex = 27;
            this.lb_TrinhDo.Text = "A, B, C";
            // 
            // lb_So
            // 
            this.lb_So.AutoSize = true;
            this.lb_So.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_So.Location = new System.Drawing.Point(399, 100);
            this.lb_So.Name = "lb_So";
            this.lb_So.Size = new System.Drawing.Size(115, 23);
            this.lb_So.TabIndex = 26;
            this.lb_So.Text = "Số Câu Thi :";
            // 
            // lb
            // 
            this.lb.AutoSize = true;
            this.lb.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb.Location = new System.Drawing.Point(176, 99);
            this.lb.Name = "lb";
            this.lb.Size = new System.Drawing.Size(98, 23);
            this.lb.TabIndex = 25;
            this.lb.Text = "Trình độ : ";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(23, 105);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(37, 19);
            this.label4.TabIndex = 24;
            this.label4.Text = "Lần";
            // 
            // spin_LanThi
            // 
            this.spin_LanThi.EditValue = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.spin_LanThi.Location = new System.Drawing.Point(67, 99);
            this.spin_LanThi.Margin = new System.Windows.Forms.Padding(4);
            this.spin_LanThi.Name = "spin_LanThi";
            this.spin_LanThi.Properties.Appearance.Font = new System.Drawing.Font("Tahoma", 10F);
            this.spin_LanThi.Properties.Appearance.Options.UseFont = true;
            this.spin_LanThi.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.spin_LanThi.Properties.MaxValue = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.spin_LanThi.Properties.MinValue = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.spin_LanThi.Size = new System.Drawing.Size(78, 28);
            this.spin_LanThi.TabIndex = 23;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(351, 51);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(75, 19);
            this.label2.TabIndex = 22;
            this.label2.Text = "Ngày Thi";
            // 
            // date_NgayThi
            // 
            this.date_NgayThi.EditValue = new System.DateTime(2022, 5, 17, 0, 0, 0, 0);
            this.date_NgayThi.Location = new System.Drawing.Point(433, 46);
            this.date_NgayThi.Margin = new System.Windows.Forms.Padding(4);
            this.date_NgayThi.Name = "date_NgayThi";
            this.date_NgayThi.Properties.Appearance.Font = new System.Drawing.Font("Tahoma", 10F);
            this.date_NgayThi.Properties.Appearance.Options.UseFont = true;
            this.date_NgayThi.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.date_NgayThi.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.date_NgayThi.Size = new System.Drawing.Size(148, 28);
            this.date_NgayThi.TabIndex = 21;
            // 
            // cmb_MonHoc
            // 
            this.cmb_MonHoc.DataSource = this.bdsMH;
            this.cmb_MonHoc.DisplayMember = "TENMH";
            this.cmb_MonHoc.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_MonHoc.Font = new System.Drawing.Font("Times New Roman", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_MonHoc.FormattingEnabled = true;
            this.cmb_MonHoc.Location = new System.Drawing.Point(102, 47);
            this.cmb_MonHoc.Name = "cmb_MonHoc";
            this.cmb_MonHoc.Size = new System.Drawing.Size(210, 27);
            this.cmb_MonHoc.TabIndex = 20;
            this.cmb_MonHoc.ValueMember = "MAMH";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.label3.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.label3.Location = new System.Drawing.Point(5, 11);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(131, 21);
            this.label3.TabIndex = 18;
            this.label3.Text = "Thông tin bài thi";
            // 
            // btn_BatDau
            // 
            this.btn_BatDau.AutoSize = true;
            this.btn_BatDau.Font = new System.Drawing.Font("Times New Roman", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_BatDau.Location = new System.Drawing.Point(11, 19);
            this.btn_BatDau.Name = "btn_BatDau";
            this.btn_BatDau.Size = new System.Drawing.Size(110, 48);
            this.btn_BatDau.TabIndex = 29;
            this.btn_BatDau.Text = "Bắt Đầu";
            this.btn_BatDau.UseVisualStyleBackColor = true;
            this.btn_BatDau.Click += new System.EventHandler(this.btn_BatDau_Click);
            // 
            // panelControl3
            // 
            this.panelControl3.Controls.Add(this.btn_BatDau);
            this.panelControl3.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelControl3.Location = new System.Drawing.Point(0, 205);
            this.panelControl3.Name = "panelControl3";
            this.panelControl3.Size = new System.Drawing.Size(1690, 74);
            this.panelControl3.TabIndex = 10;
            // 
            // bar3
            // 
            this.bar3.BarName = "Status bar";
            this.bar3.CanDockStyle = DevExpress.XtraBars.BarCanDockStyle.Bottom;
            this.bar3.DockCol = 0;
            this.bar3.DockRow = 0;
            this.bar3.DockStyle = DevExpress.XtraBars.BarDockStyle.Bottom;
            this.bar3.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(this.barStaticItem1)});
            this.bar3.OptionsBar.AllowQuickCustomization = false;
            this.bar3.OptionsBar.DrawDragBorder = false;
            this.bar3.OptionsBar.UseWholeRow = true;
            this.bar3.Text = "Status bar";
            // 
            // timer1
            // 
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // gcNoiDung
            // 
            this.gcNoiDung.Controls.Add(this.rdbDA);
            this.gcNoiDung.Controls.Add(this.panelControl1);
            this.gcNoiDung.Controls.Add(this.rdbListQS);
            this.gcNoiDung.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gcNoiDung.Location = new System.Drawing.Point(0, 279);
            this.gcNoiDung.Name = "gcNoiDung";
            this.gcNoiDung.Size = new System.Drawing.Size(1690, 523);
            this.gcNoiDung.TabIndex = 24;
            this.gcNoiDung.Text = "Nội dung";
            // 
            // rdbListQS
            // 
            this.rdbListQS.AllowDrop = true;
            this.rdbListQS.Dock = System.Windows.Forms.DockStyle.Left;
            this.rdbListQS.Location = new System.Drawing.Point(2, 28);
            this.rdbListQS.MenuManager = this.barManager1;
            this.rdbListQS.Name = "rdbListQS";
            this.rdbListQS.Properties.Appearance.BackColor = System.Drawing.SystemColors.HighlightText;
            this.rdbListQS.Properties.Appearance.Font = new System.Drawing.Font("Tahoma", 11F);
            this.rdbListQS.Properties.Appearance.Options.UseBackColor = true;
            this.rdbListQS.Properties.Appearance.Options.UseFont = true;
            this.rdbListQS.Properties.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.HotFlat;
            this.rdbListQS.Size = new System.Drawing.Size(90, 493);
            this.rdbListQS.TabIndex = 2;
            this.rdbListQS.SelectedIndexChanged += new System.EventHandler(this.rdbListQS_SelectedIndexChanged);
            // 
            // rdbDA
            // 
            this.rdbDA.Dock = System.Windows.Forms.DockStyle.Top;
            this.rdbDA.Location = new System.Drawing.Point(92, 200);
            this.rdbDA.MenuManager = this.barManager1;
            this.rdbDA.Name = "rdbDA";
            this.rdbDA.Properties.Appearance.BackColor = System.Drawing.Color.Transparent;
            this.rdbDA.Properties.Appearance.Font = new System.Drawing.Font("Tahoma", 12F);
            this.rdbDA.Properties.Appearance.Options.UseBackColor = true;
            this.rdbDA.Properties.Appearance.Options.UseFont = true;
            this.rdbDA.Properties.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.rdbDA.Size = new System.Drawing.Size(1596, 139);
            this.rdbDA.TabIndex = 1;
            this.rdbDA.SelectedIndexChanged += new System.EventHandler(this.rdbDA_SelectedIndexChanged);
            // 
            // panelControl1
            // 
            this.panelControl1.Controls.Add(this.lblCauHoi);
            this.panelControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelControl1.Location = new System.Drawing.Point(92, 28);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(1596, 172);
            this.panelControl1.TabIndex = 4;
            // 
            // lblCauHoi
            // 
            this.lblCauHoi.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblCauHoi.AutoSize = true;
            this.lblCauHoi.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblCauHoi.Location = new System.Drawing.Point(5, 12);
            this.lblCauHoi.Name = "lblCauHoi";
            this.lblCauHoi.Size = new System.Drawing.Size(68, 24);
            this.lblCauHoi.TabIndex = 1;
            this.lblCauHoi.Text = "Câu 1:";
            // 
            // FormThi
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1690, 802);
            this.Controls.Add(this.gcNoiDung);
            this.Controls.Add(this.panelControl3);
            this.Controls.Add(this.panelControl2);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "FormThi";
            this.Text = "Thi";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.FormThi_Load);
            ((System.ComponentModel.ISupportInitialize)(this.bdsGVDK)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dS)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsMH)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl2)).EndInit();
            this.panelControl2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl5)).EndInit();
            this.panelControl5.ResumeLayout(false);
            this.panelControl5.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl4)).EndInit();
            this.panelControl4.ResumeLayout(false);
            this.panelControl4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spin_LanThi.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.date_NgayThi.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.date_NgayThi.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl3)).EndInit();
            this.panelControl3.ResumeLayout(false);
            this.panelControl3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gcNoiDung)).EndInit();
            this.gcNoiDung.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.rdbListQS.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.rdbDA.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private DS dS;
        private System.Windows.Forms.BindingSource bdsMH;
        private DSTableAdapters.MONHOCTableAdapter mONHOCTableAdapter;
        private DSTableAdapters.TableAdapterManager tableAdapterManager;
        private DSTableAdapters.GIAOVIEN_DANGKYTableAdapter gIAOVIEN_DANGKYTableAdapter;
        private System.Windows.Forms.BindingSource bdsGVDK;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar2;
        private DevExpress.XtraBars.BarButtonItem btnNopBai;
        private DevExpress.XtraBars.BarButtonItem btnXemKQ;
        private DevExpress.XtraBars.BarButtonItem btnThoat;
        private DevExpress.XtraBars.BarStaticItem barStaticItem1;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.XtraEditors.PanelControl panelControl3;
        private DevExpress.XtraEditors.PanelControl panelControl2;
        private DevExpress.XtraEditors.PanelControl panelControl5;
        private System.Windows.Forms.Label label1;
        private DevExpress.XtraEditors.PanelControl panelControl4;
        private System.Windows.Forms.Label label3;
        private DevExpress.XtraBars.Bar bar3;
        private System.Windows.Forms.Label lb_TENLOP;
        private System.Windows.Forms.Label lb_4;
        private System.Windows.Forms.Label lb_MALOP;
        private System.Windows.Forms.Label lb_3;
        private System.Windows.Forms.Label lb_TENSV;
        private System.Windows.Forms.Label lb_2;
        private System.Windows.Forms.Label lb_MASV;
        private System.Windows.Forms.Label lb_1;
        private System.Windows.Forms.Label lb;
        private System.Windows.Forms.Label label4;
        private DevExpress.XtraEditors.SpinEdit spin_LanThi;
        private System.Windows.Forms.ComboBox cmb_MonHoc;
        private System.Windows.Forms.Label lb_SoCauThi;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label lb_TrinhDo;
        private System.Windows.Forms.Label lb_So;
        private System.Windows.Forms.Label label2;
        private DevExpress.XtraEditors.DateEdit date_NgayThi;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Button btn_BatDau;
        private DevExpress.XtraEditors.GroupControl gcNoiDung;
        private System.Windows.Forms.Label lblTime;
        private DevExpress.XtraEditors.RadioGroup rdbListQS;
        private DevExpress.XtraEditors.RadioGroup rdbDA;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private System.Windows.Forms.Label lblCauHoi;
    }
}