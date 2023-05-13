Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D930D7018DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjEMR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjEMR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3D2D48;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974D561CCF;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607F8C43326;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=ghEPnmKSURwfpwiTzrGTNQFmgy7I2n4yUutlf3ADrFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/Q/4Myv1vuO7E3DAPpTm/XzCyyYcIzphjEhDjoiJ/9Aeg01vfT6tVQr5YqEqPe3D
         4Hznjh4CX/DQnbPV7XdX8kI9ZQ6FE9FKjMDmgwUFqkhc9i53ESzNu+sjqCk4yPVhJX
         OrG/reEuZ/SN9xCbHoBEgtAqlDClEO3j21QfkqVWj3sPpm82AajSERfAE6PpplZP0e
         2STlsa5rV4tSesjCUNN50KJicOUNuQTqUwaDAU/NAZ71IDTdsNR+hF34hW9gPgP1KR
         LPjB6GSO7yyNmwtR+E/xf5ptL5R7OpTBvIbs7djjwYDfPO9K1L34F+dQkIOVJZh0Qe
         4TqTrS0aI75RA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyQ-1y;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yu Zhe <yuzhe@nfschina.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 21/24] media: dvb-usb: remove unnecessary (void*) conversions
Date:   Sat, 13 May 2023 18:57:38 +0100
Message-Id: <bf4768f0684aa8f5c641bae8305cb49a75e8012b.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhe <yuzhe@nfschina.com>

Pointer variables of void * type do not require type cast.

Link: https://lore.kernel.org/linux-media/20230320064039.5670-1-yuzhe@nfschina.com
Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/usb/dvb-usb/af9005-fe.c  |  3 +--
 drivers/media/usb/dvb-usb/az6027.c     | 34 +++++++++++++-------------
 drivers/media/usb/dvb-usb/dtt200u-fe.c |  2 +-
 drivers/media/usb/dvb-usb/dw2102.c     | 20 ++++++---------
 drivers/media/usb/dvb-usb/opera1.c     |  3 +--
 drivers/media/usb/dvb-usb/pctv452e.c   | 20 +++++++--------
 6 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/af9005-fe.c b/drivers/media/usb/dvb-usb/af9005-fe.c
index 9d6fa0556d7b..404e56b32145 100644
--- a/drivers/media/usb/dvb-usb/af9005-fe.c
+++ b/drivers/media/usb/dvb-usb/af9005-fe.c
@@ -1412,8 +1412,7 @@ static int af9005_fe_get_frontend(struct dvb_frontend *fe,
 
 static void af9005_fe_release(struct dvb_frontend *fe)
 {
-	struct af9005_fe_state *state =
-	    (struct af9005_fe_state *)fe->demodulator_priv;
+	struct af9005_fe_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index a31c6f82f4e9..2bc27710427d 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -407,8 +407,8 @@ static int az6027_ci_read_attribute_mem(struct dvb_ca_en50221 *ca,
 					int slot,
 					int address)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -449,8 +449,8 @@ static int az6027_ci_write_attribute_mem(struct dvb_ca_en50221 *ca,
 					 int address,
 					 u8 value)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -480,8 +480,8 @@ static int az6027_ci_read_cam_control(struct dvb_ca_en50221 *ca,
 				      int slot,
 				      u8 address)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -526,8 +526,8 @@ static int az6027_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 				       u8 address,
 				       u8 value)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -557,7 +557,7 @@ static int az6027_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 
 static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
+	struct dvb_usb_device *d = ca->data;
 
 	int ret;
 	u8 req;
@@ -588,8 +588,8 @@ static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6027_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret, i;
 	u8 req;
@@ -644,8 +644,8 @@ static int az6027_ci_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6027_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -673,8 +673,8 @@ static int az6027_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 
 static int az6027_ci_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int open)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct az6027_device_state *state = d->priv;
 	int ret;
 	u8 req;
 	u16 value;
@@ -719,7 +719,7 @@ static void az6027_ci_uninit(struct dvb_usb_device *d)
 	if (NULL == d)
 		return;
 
-	state = (struct az6027_device_state *)d->priv;
+	state = d->priv;
 	if (NULL == state)
 		return;
 
@@ -735,7 +735,7 @@ static void az6027_ci_uninit(struct dvb_usb_device *d)
 static int az6027_ci_init(struct dvb_usb_adapter *a)
 {
 	struct dvb_usb_device *d = a->dev;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct az6027_device_state *state = d->priv;
 	int ret;
 
 	deb_info("%s", __func__);
diff --git a/drivers/media/usb/dvb-usb/dtt200u-fe.c b/drivers/media/usb/dvb-usb/dtt200u-fe.c
index 9f83560ba63d..586afe22d817 100644
--- a/drivers/media/usb/dvb-usb/dtt200u-fe.c
+++ b/drivers/media/usb/dvb-usb/dtt200u-fe.c
@@ -195,7 +195,7 @@ static int dtt200u_fe_get_frontend(struct dvb_frontend* fe,
 
 static void dtt200u_fe_release(struct dvb_frontend* fe)
 {
-	struct dtt200u_fe_state *state = (struct dtt200u_fe_state*) fe->demodulator_priv;
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 8747960e6146..2a048499468b 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -903,7 +903,7 @@ static int su3000_streaming_ctrl(struct dvb_usb_adapter *adap, int onoff)
 
 static int su3000_power_ctrl(struct dvb_usb_device *d, int i)
 {
-	struct dw2102_state *state = (struct dw2102_state *)d->priv;
+	struct dw2102_state *state = d->priv;
 	int ret = 0;
 
 	info("%s: %d, initialized %d", __func__, i, state->initialized);
@@ -978,8 +978,7 @@ static int dw210x_set_voltage(struct dvb_frontend *fe,
 		.len = 2,
 	};
 
-	struct dvb_usb_adapter *udev_adap =
-		(struct dvb_usb_adapter *)(fe->dvb->priv);
+	struct dvb_usb_adapter *udev_adap = fe->dvb->priv;
 	if (voltage == SEC_VOLTAGE_18)
 		msg.buf = command_18v;
 	else if (voltage == SEC_VOLTAGE_13)
@@ -993,9 +992,8 @@ static int dw210x_set_voltage(struct dvb_frontend *fe,
 static int s660_set_voltage(struct dvb_frontend *fe,
 			    enum fe_sec_voltage voltage)
 {
-	struct dvb_usb_adapter *d =
-		(struct dvb_usb_adapter *)(fe->dvb->priv);
-	struct dw2102_state *st = (struct dw2102_state *)d->dev->priv;
+	struct dvb_usb_adapter *d = fe->dvb->priv;
+	struct dw2102_state *st = d->dev->priv;
 
 	dw210x_set_voltage(fe, voltage);
 	if (st->old_set_voltage)
@@ -1014,8 +1012,7 @@ static void dw210x_led_ctrl(struct dvb_frontend *fe, int offon)
 		.buf = led_off,
 		.len = 1
 	};
-	struct dvb_usb_adapter *udev_adap =
-		(struct dvb_usb_adapter *)(fe->dvb->priv);
+	struct dvb_usb_adapter *udev_adap = fe->dvb->priv;
 
 	if (offon)
 		msg.buf = led_on;
@@ -1025,9 +1022,8 @@ static void dw210x_led_ctrl(struct dvb_frontend *fe, int offon)
 static int tt_s2_4600_read_status(struct dvb_frontend *fe,
 				  enum fe_status *status)
 {
-	struct dvb_usb_adapter *d =
-		(struct dvb_usb_adapter *)(fe->dvb->priv);
-	struct dw2102_state *st = (struct dw2102_state *)d->dev->priv;
+	struct dvb_usb_adapter *d = fe->dvb->priv;
+	struct dw2102_state *st = d->dev->priv;
 	int ret;
 
 	ret = st->fe_read_status(fe, status);
@@ -2576,7 +2572,7 @@ static int dw2102_probe(struct usb_interface *intf,
 static void dw2102_disconnect(struct usb_interface *intf)
 {
 	struct dvb_usb_device *d = usb_get_intfdata(intf);
-	struct dw2102_state *st = (struct dw2102_state *)d->priv;
+	struct dw2102_state *st = d->priv;
 	struct i2c_client *client;
 
 	/* remove I2C client for tuner */
diff --git a/drivers/media/usb/dvb-usb/opera1.c b/drivers/media/usb/dvb-usb/opera1.c
index 0da86f58aff6..98b2177667d2 100644
--- a/drivers/media/usb/dvb-usb/opera1.c
+++ b/drivers/media/usb/dvb-usb/opera1.c
@@ -172,8 +172,7 @@ static int opera1_set_voltage(struct dvb_frontend *fe,
 	struct i2c_msg msg[] = {
 		{.addr = ADDR_B600_VOLTAGE_13V,.flags = 0,.buf = command_13v,.len = 1},
 	};
-	struct dvb_usb_adapter *udev_adap =
-	    (struct dvb_usb_adapter *)(fe->dvb->priv);
+	struct dvb_usb_adapter *udev_adap = fe->dvb->priv;
 	if (voltage == SEC_VOLTAGE_18) {
 		msg[0].addr = ADDR_B601_VOLTAGE_18V;
 		msg[0].buf = command_18v;
diff --git a/drivers/media/usb/dvb-usb/pctv452e.c b/drivers/media/usb/dvb-usb/pctv452e.c
index da42c989e071..2aab49003493 100644
--- a/drivers/media/usb/dvb-usb/pctv452e.c
+++ b/drivers/media/usb/dvb-usb/pctv452e.c
@@ -108,7 +108,7 @@ struct pctv452e_state {
 static int tt3650_ci_msg(struct dvb_usb_device *d, u8 cmd, u8 *data,
 			 unsigned int write_len, unsigned int read_len)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *buf;
 	u8 id;
 	unsigned int rlen;
@@ -159,8 +159,8 @@ static int tt3650_ci_msg_locked(struct dvb_ca_en50221 *ca,
 				u8 cmd, u8 *data, unsigned int write_len,
 				unsigned int read_len)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct pctv452e_state *state = d->priv;
 	int ret;
 
 	mutex_lock(&state->ca_mutex);
@@ -292,8 +292,8 @@ static int tt3650_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 
 static int tt3650_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
-	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct dvb_usb_device *d = ca->data;
+	struct pctv452e_state *state = d->priv;
 	u8 buf[1];
 	int ret;
 
@@ -361,7 +361,7 @@ static void tt3650_ci_uninit(struct dvb_usb_device *d)
 	if (NULL == d)
 		return;
 
-	state = (struct pctv452e_state *)d->priv;
+	state = d->priv;
 	if (NULL == state)
 		return;
 
@@ -379,7 +379,7 @@ static void tt3650_ci_uninit(struct dvb_usb_device *d)
 static int tt3650_ci_init(struct dvb_usb_adapter *a)
 {
 	struct dvb_usb_device *d = a->dev;
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	int ret;
 
 	ci_dbg("%s", __func__);
@@ -417,7 +417,7 @@ static int pctv452e_i2c_msg(struct dvb_usb_device *d, u8 addr,
 				const u8 *snd_buf, u8 snd_len,
 				u8 *rcv_buf, u8 rcv_len)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *buf;
 	u8 id;
 	int ret;
@@ -516,7 +516,7 @@ static u32 pctv452e_i2c_func(struct i2c_adapter *adapter)
 
 static int pctv452e_power_ctrl(struct dvb_usb_device *d, int i)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *b0, *rx;
 	int ret;
 
@@ -567,7 +567,7 @@ static int pctv452e_power_ctrl(struct dvb_usb_device *d, int i)
 
 static int pctv452e_rc_query(struct dvb_usb_device *d)
 {
-	struct pctv452e_state *state = (struct pctv452e_state *)d->priv;
+	struct pctv452e_state *state = d->priv;
 	u8 *b, *rx;
 	int ret, i;
 	u8 id;
-- 
2.40.1

