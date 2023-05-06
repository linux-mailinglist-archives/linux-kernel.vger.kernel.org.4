Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963026F8DBA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEFBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjEFBpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:45:13 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CA0C249D4;
        Fri,  5 May 2023 18:45:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E76F8180104BD0;
        Sat,  6 May 2023 09:44:55 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Baisong Zhong <zhongbaisong@huawei.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH]  media: dvb-usb: remove unnecessary (void*) conversions
Date:   Sat,  6 May 2023 09:44:47 +0800
Message-Id: <20230506014447.32746-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct az6027_device_state *) or
(struct dw2102_state *).

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/media/usb/dvb-usb/az6027.c | 16 ++++++++--------
 drivers/media/usb/dvb-usb/dw2102.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 7d78ee09be5e..f7a6ab29e530 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -408,7 +408,7 @@ static int az6027_ci_read_attribute_mem(struct dvb_ca_en50221 *ca,
 					int address)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -481,7 +481,7 @@ static int az6027_ci_read_cam_control(struct dvb_ca_en50221 *ca,
 				      u8 address)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -527,7 +527,7 @@ static int az6027_ci_write_cam_control(struct dvb_ca_en50221 *ca,
 				       u8 value)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -589,7 +589,7 @@ static int CI_CamReady(struct dvb_ca_en50221 *ca, int slot)
 static int az6027_ci_slot_reset(struct dvb_ca_en50221 *ca, int slot)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct az6027_device_state *state = d->priv;
 
 	int ret, i;
 	u8 req;
@@ -645,7 +645,7 @@ static int az6027_ci_slot_shutdown(struct dvb_ca_en50221 *ca, int slot)
 static int az6027_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
+	struct az6027_device_state *state = d->priv;
 
 	int ret;
 	u8 req;
@@ -674,7 +674,7 @@ static int az6027_ci_slot_ts_enable(struct dvb_ca_en50221 *ca, int slot)
 static int az6027_ci_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int open)
 {
 	struct dvb_usb_device *d = (struct dvb_usb_device *)ca->data;
-	struct az6027_device_state *state = (struct az6027_device_state *)d->priv;
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
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 0ca764282c76..d34d53c651c2 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -903,7 +903,7 @@ static int su3000_streaming_ctrl(struct dvb_usb_adapter *adap, int onoff)
 
 static int su3000_power_ctrl(struct dvb_usb_device *d, int i)
 {
-	struct dw2102_state *state = (struct dw2102_state *)d->priv;
+	struct dw2102_state *state = d->priv;
 	int ret = 0;
 
 	info("%s: %d, initialized %d", __func__, i, state->initialized);
@@ -2576,7 +2576,7 @@ static int dw2102_probe(struct usb_interface *intf,
 static void dw2102_disconnect(struct usb_interface *intf)
 {
 	struct dvb_usb_device *d = usb_get_intfdata(intf);
-	struct dw2102_state *st = (struct dw2102_state *)d->priv;
+	struct dw2102_state *st = d->priv;
 	struct i2c_client *client;
 
 	/* remove I2C client for tuner */
-- 
2.30.2

