Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407BA6C0C04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCTIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCTIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:17:47 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4310EE;
        Mon, 20 Mar 2023 01:17:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 569EA1A00A43;
        Mon, 20 Mar 2023 16:17:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yjJT4zyJO7LD; Mon, 20 Mar 2023 16:17:43 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9D1FF1A00A28;
        Mon, 20 Mar 2023 16:17:42 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] media: ttpci: remove unnecessary (void*) conversions
Date:   Mon, 20 Mar 2023 16:16:51 +0800
Message-Id: <20230320081651.23840-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/media/pci/ttpci/budget-av.c   | 34 +++++++++++++++++-----------------
 drivers/media/pci/ttpci/budget-ci.c   | 30 +++++++++++++++---------------
 drivers/media/pci/ttpci/budget-core.c | 10 +++++-----
 drivers/media/pci/ttpci/budget.c      | 20 ++++++++++----------
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 3cb83005cf09..bdecb714e335 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -122,7 +122,7 @@ static int i2c_writereg(struct i2c_adapter *i2c, u8 id, u8 reg, u8 val)
 
 static int ciintf_read_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int address)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	int result;
 
 	if (slot != 0)
@@ -141,7 +141,7 @@ static int ciintf_read_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int ad
 
 static int ciintf_write_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int address, u8 value)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	int result;
 
 	if (slot != 0)
@@ -160,7 +160,7 @@ static int ciintf_write_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int a
 
 static int ciintf_read_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 address)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	int result;
 
 	if (slot != 0)
@@ -180,7 +180,7 @@ static int ciintf_read_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 addre
 
 static int ciintf_write_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 address, u8 value)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	int result;
 
 	if (slot != 0)
@@ -199,7 +199,7 @@ static int ciintf_write_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 addr
 
 static int ciintf_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
 
 	if (slot != 0)
@@ -228,7 +228,7 @@ static int ciintf_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 
 static int ciintf_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
 
 	if (slot != 0)
@@ -244,7 +244,7 @@ static int ciintf_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 
 static int ciintf_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
 
 	if (slot != 0)
@@ -259,7 +259,7 @@ static int ciintf_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 
 static int ciintf_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int open)
 {
-	struct budget_av *budget_av = (struct budget_av *) ca->data;
+	struct budget_av *budget_av = ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
 	int result;
 
@@ -490,7 +490,7 @@ static int philips_su1278_ty_ci_tuner_set_params(struct dvb_frontend *fe)
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	u32 div;
 	u8 buf[4];
-	struct budget *budget = (struct budget *) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	struct i2c_msg msg = {.addr = 0x61,.flags = 0,.buf = buf,.len = sizeof(buf) };
 
 	if ((c->frequency < 950000) || (c->frequency > 2150000))
@@ -603,7 +603,7 @@ static const struct stv0299_config cinergy_1200s_1894_0010_config = {
 static int philips_cu1216_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct budget *budget = (struct budget *) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	u8 buf[6];
 	struct i2c_msg msg = {.addr = 0x60,.flags = 0,.buf = buf,.len = sizeof(buf) };
 	int i;
@@ -667,7 +667,7 @@ static struct tda10023_config philips_cu1216_tda10023_config = {
 
 static int philips_tu1216_tuner_init(struct dvb_frontend *fe)
 {
-	struct budget *budget = (struct budget *) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	static u8 tu1216_init[] = { 0x0b, 0xf5, 0x85, 0xab };
 	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tu1216_init,.len = sizeof(tu1216_init) };
 
@@ -684,7 +684,7 @@ static int philips_tu1216_tuner_init(struct dvb_frontend *fe)
 static int philips_tu1216_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct budget *budget = (struct budget *) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	u8 tuner_buf[4];
 	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tuner_buf,.len =
 			sizeof(tuner_buf) };
@@ -768,7 +768,7 @@ static int philips_tu1216_tuner_set_params(struct dvb_frontend *fe)
 static int philips_tu1216_request_firmware(struct dvb_frontend *fe,
 					   const struct firmware **fw, char *name)
 {
-	struct budget *budget = (struct budget *) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 
 	return request_firmware(fw, name, &budget->dev->pci->dev);
 }
@@ -1352,7 +1352,7 @@ static void frontend_init(struct budget_av *budget_av)
 
 static void budget_av_irq(struct saa7146_dev *dev, u32 * isr)
 {
-	struct budget_av *budget_av = (struct budget_av *) dev->ext_priv;
+	struct budget_av *budget_av = dev->ext_priv;
 
 	dprintk(8, "dev: %p, budget_av: %p\n", dev, budget_av);
 
@@ -1362,7 +1362,7 @@ static void budget_av_irq(struct saa7146_dev *dev, u32 * isr)
 
 static int budget_av_detach(struct saa7146_dev *dev)
 {
-	struct budget_av *budget_av = (struct budget_av *) dev->ext_priv;
+	struct budget_av *budget_av = dev->ext_priv;
 	int err;
 
 	dprintk(2, "dev: %p\n", dev);
@@ -1411,7 +1411,7 @@ static int vidioc_enum_input(struct file *file, void *fh, struct v4l2_input *i)
 static int vidioc_g_input(struct file *file, void *fh, unsigned int *i)
 {
 	struct saa7146_dev *dev = ((struct saa7146_fh *)fh)->dev;
-	struct budget_av *budget_av = (struct budget_av *)dev->ext_priv;
+	struct budget_av *budget_av = dev->ext_priv;
 
 	*i = budget_av->cur_input;
 
@@ -1422,7 +1422,7 @@ static int vidioc_g_input(struct file *file, void *fh, unsigned int *i)
 static int vidioc_s_input(struct file *file, void *fh, unsigned int input)
 {
 	struct saa7146_dev *dev = ((struct saa7146_fh *)fh)->dev;
-	struct budget_av *budget_av = (struct budget_av *)dev->ext_priv;
+	struct budget_av *budget_av = dev->ext_priv;
 
 	dprintk(1, "VIDIOC_S_INPUT %d\n", input);
 	return saa7113_setinput(budget_av, input);
diff --git a/drivers/media/pci/ttpci/budget-ci.c b/drivers/media/pci/ttpci/budget-ci.c
index d59d18647371..66e1a004ee43 100644
--- a/drivers/media/pci/ttpci/budget-ci.c
+++ b/drivers/media/pci/ttpci/budget-ci.c
@@ -251,7 +251,7 @@ static void msp430_ir_deinit(struct budget_ci *budget_ci)
 
 static int ciintf_read_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int address)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 
 	if (slot != 0)
 		return -EINVAL;
@@ -262,7 +262,7 @@ static int ciintf_read_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int ad
 
 static int ciintf_write_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int address, u8 value)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 
 	if (slot != 0)
 		return -EINVAL;
@@ -273,7 +273,7 @@ static int ciintf_write_attribute_mem(struct dvb_ca_en50221 *ca, int slot, int a
 
 static int ciintf_read_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 address)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 
 	if (slot != 0)
 		return -EINVAL;
@@ -284,7 +284,7 @@ static int ciintf_read_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 addre
 
 static int ciintf_write_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 address, u8 value)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 
 	if (slot != 0)
 		return -EINVAL;
@@ -295,7 +295,7 @@ static int ciintf_write_cam_control(struct dvb_ca_en50221 *ca, int slot, u8 addr
 
 static int ciintf_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 	struct saa7146_dev *saa = budget_ci->budget.dev;
 
 	if (slot != 0)
@@ -318,7 +318,7 @@ static int ciintf_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 
 static int ciintf_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 	struct saa7146_dev *saa = budget_ci->budget.dev;
 
 	if (slot != 0)
@@ -331,7 +331,7 @@ static int ciintf_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 
 static int ciintf_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 	struct saa7146_dev *saa = budget_ci->budget.dev;
 	int tmp;
 
@@ -400,7 +400,7 @@ static void ciintf_interrupt(struct tasklet_struct *t)
 
 static int ciintf_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int open)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) ca->data;
+	struct budget_ci *budget_ci = ca->data;
 	unsigned int flags;
 
 	// ensure we don't get spurious IRQs during initialisation
@@ -553,7 +553,7 @@ static void ciintf_deinit(struct budget_ci *budget_ci)
 
 static void budget_ci_irq(struct saa7146_dev *dev, u32 * isr)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) dev->ext_priv;
+	struct budget_ci *budget_ci = dev->ext_priv;
 
 	dprintk(8, "dev: %p, budget_ci: %p\n", dev, budget_ci);
 
@@ -648,7 +648,7 @@ static int philips_su1278_tt_set_symbol_rate(struct dvb_frontend *fe, u32 srate,
 static int philips_su1278_tt_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
+	struct budget_ci *budget_ci = fe->dvb->priv;
 	u32 div;
 	u8 buf[4];
 	struct i2c_msg msg = {.addr = 0x60,.flags = 0,.buf = buf,.len = sizeof(buf) };
@@ -698,7 +698,7 @@ static const struct stv0299_config philips_su1278_tt_config = {
 
 static int philips_tdm1316l_tuner_init(struct dvb_frontend *fe)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
+	struct budget_ci *budget_ci = fe->dvb->priv;
 	static u8 td1316_init[] = { 0x0b, 0xf5, 0x85, 0xab };
 	static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
 	struct i2c_msg tuner_msg = {.addr = budget_ci->tuner_pll_address,.flags = 0,.buf = td1316_init,.len =
@@ -729,7 +729,7 @@ static int philips_tdm1316l_tuner_init(struct dvb_frontend *fe)
 static int philips_tdm1316l_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
+	struct budget_ci *budget_ci = fe->dvb->priv;
 	u8 tuner_buf[4];
 	struct i2c_msg tuner_msg = {.addr = budget_ci->tuner_pll_address,.flags = 0,.buf = tuner_buf,.len = sizeof(tuner_buf) };
 	int tuner_frequency = 0;
@@ -815,7 +815,7 @@ static int philips_tdm1316l_tuner_set_params(struct dvb_frontend *fe)
 static int philips_tdm1316l_request_firmware(struct dvb_frontend *fe,
 					     const struct firmware **fw, char *name)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
+	struct budget_ci *budget_ci = fe->dvb->priv;
 
 	return request_firmware(fw, name, &budget_ci->budget.dev->pci->dev);
 }
@@ -845,7 +845,7 @@ static struct tda1004x_config philips_tdm1316l_config_invert = {
 static int dvbc_philips_tdm1316l_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
+	struct budget_ci *budget_ci = fe->dvb->priv;
 	u8 tuner_buf[5];
 	struct i2c_msg tuner_msg = {.addr = budget_ci->tuner_pll_address,
 				    .flags = 0,
@@ -1494,7 +1494,7 @@ static int budget_ci_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 
 static int budget_ci_detach(struct saa7146_dev *dev)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) dev->ext_priv;
+	struct budget_ci *budget_ci = dev->ext_priv;
 	struct saa7146_dev *saa = budget_ci->budget.dev;
 	int err;
 
diff --git a/drivers/media/pci/ttpci/budget-core.c b/drivers/media/pci/ttpci/budget-core.c
index 5d5796f24469..25f44c3eebf3 100644
--- a/drivers/media/pci/ttpci/budget-core.c
+++ b/drivers/media/pci/ttpci/budget-core.c
@@ -147,7 +147,7 @@ static int start_ts_capture(struct budget *budget)
 static int budget_read_fe_status(struct dvb_frontend *fe,
 				 enum fe_status *status)
 {
-	struct budget *budget = (struct budget *) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	int synced;
 	int ret;
 
@@ -308,7 +308,7 @@ int ttpci_budget_debiwrite(struct budget *budget, u32 config, int addr,
 static int budget_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct budget *budget = (struct budget *) demux->priv;
+	struct budget *budget = demux->priv;
 	int status = 0;
 
 	dprintk(2, "budget: %p\n", budget);
@@ -327,7 +327,7 @@ static int budget_start_feed(struct dvb_demux_feed *feed)
 static int budget_stop_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct budget *budget = (struct budget *) demux->priv;
+	struct budget *budget = demux->priv;
 	int status = 0;
 
 	dprintk(2, "budget: %p\n", budget);
@@ -570,7 +570,7 @@ int ttpci_budget_deinit(struct budget *budget)
 
 void ttpci_budget_irq10_handler(struct saa7146_dev *dev, u32 * isr)
 {
-	struct budget *budget = (struct budget *) dev->ext_priv;
+	struct budget *budget = dev->ext_priv;
 
 	dprintk(8, "dev: %p, budget: %p\n", dev, budget);
 
@@ -580,7 +580,7 @@ void ttpci_budget_irq10_handler(struct saa7146_dev *dev, u32 * isr)
 
 void ttpci_budget_set_video_port(struct saa7146_dev *dev, int video_port)
 {
-	struct budget *budget = (struct budget *) dev->ext_priv;
+	struct budget *budget = dev->ext_priv;
 
 	spin_lock(&budget->feedlock);
 	budget->video_port = video_port;
diff --git a/drivers/media/pci/ttpci/budget.c b/drivers/media/pci/ttpci/budget.c
index a88711a3ac7f..b76a1b330b50 100644
--- a/drivers/media/pci/ttpci/budget.c
+++ b/drivers/media/pci/ttpci/budget.c
@@ -144,7 +144,7 @@ static int SetVoltage_Activy(struct budget *budget,
 static int siemens_budget_set_voltage(struct dvb_frontend *fe,
 				      enum fe_sec_voltage voltage)
 {
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 
 	return SetVoltage_Activy (budget, voltage);
 }
@@ -152,7 +152,7 @@ static int siemens_budget_set_voltage(struct dvb_frontend *fe,
 static int budget_set_tone(struct dvb_frontend *fe,
 			   enum fe_sec_tone_mode tone)
 {
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 
 	switch (tone) {
 	case SEC_TONE_ON:
@@ -172,7 +172,7 @@ static int budget_set_tone(struct dvb_frontend *fe,
 
 static int budget_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
 {
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 
 	SendDiSEqCMsg (budget, cmd->msg_len, cmd->msg, 0);
 
@@ -182,7 +182,7 @@ static int budget_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_dis
 static int budget_diseqc_send_burst(struct dvb_frontend *fe,
 				    enum fe_sec_mini_cmd minicmd)
 {
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 
 	SendDiSEqCMsg (budget, 0, NULL, minicmd);
 
@@ -192,7 +192,7 @@ static int budget_diseqc_send_burst(struct dvb_frontend *fe,
 static int alps_bsrv2_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	u8 pwr = 0;
 	u8 buf[4];
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = buf, .len = sizeof(buf) };
@@ -234,7 +234,7 @@ static struct ves1x93_config alps_bsrv2_config =
 static int alps_tdbe2_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	u32 div;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x62, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -320,7 +320,7 @@ static u8 tuner_address_grundig_29504_401_activy = 0x60;
 static int grundig_29504_451_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	u32 div;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -344,7 +344,7 @@ static struct tda8083_config grundig_29504_451_config = {
 static int s5h1420_tuner_set_params(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct budget* budget = (struct budget*) fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 	u32 div;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -405,7 +405,7 @@ static const struct stv0299_config alps_bsbe1_config_activy = {
 
 static int alps_tdhd1_204_request_firmware(struct dvb_frontend *fe, const struct firmware **fw, char *name)
 {
-	struct budget *budget = (struct budget *)fe->dvb->priv;
+	struct budget *budget = fe->dvb->priv;
 
 	return request_firmware(fw, name, &budget->dev->pci->dev);
 }
@@ -800,7 +800,7 @@ static int budget_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_
 
 static int budget_detach (struct saa7146_dev* dev)
 {
-	struct budget *budget = (struct budget*) dev->ext_priv;
+	struct budget *budget = dev->ext_priv;
 	int err;
 
 	if (budget->dvb_frontend) {
-- 
2.11.0

