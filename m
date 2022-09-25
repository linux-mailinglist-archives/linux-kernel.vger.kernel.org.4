Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271E75E9336
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIYMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIYMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:50:36 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2884646A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:50:35 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 12A2E28CCE; Sun, 25 Sep 2022 14:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1664110232;
        bh=4DfUdS7gOFXto5AEf06cLYJgjinITWXTI+qH+utb5DQ=;
        h=From:To:Cc:Subject:Date:From;
        b=0izvRzlXtF9SXkTq73lyGmOnkc5WK/jFxowpTBFJFWujhbmDmH/SJTyHetu1MkJLG
         PeGJcM6+wj11Uh5MOsqootr4HQHnkgV2q/3pcGJ0MHuO2+VvJ7kjAVPlZ4j2JrNAze
         ckuSkLbj0fUQ99vO4EyoAK8cmzlXm0bkn3KoFv6haaHPokD0Xw9jYQdmgXiLXBMgaT
         t3+EwSH6z6AC5XLfLFv6v/TXIh5gx7rvpgLXV5Yydiw8edKDj/RoLpwr0JHdabADc/
         aGJ/GoCwx0Ma4aS5ZtjAOwAP/B0HqApR2UgyB14lU8JjGJQES+iLFgFKR4+mretms+
         RrdbtFGamyAeDUqV4s0mkgpQIiEb9vrzVC4w+D01vmAxd9ZiXQxu25EAHGqTcCpcKe
         H9pdaKTrRVEIf1Bs+54rx3FbYyCnL0rMCd7bIKe5R8tmwdRcsBpEUfHyPg52MiE2an
         zCRTYImb1P2jXkJFEO6gQ3dfg0Ig1nLanvBlGAfLB4YhfPZejbpMgyMdHzOJgbGk1G
         EpZmHZ6UsIBGeQdstOOyNqzClTzuDrPHpFKsghplx2lT/s57fJblRexEpkIDaUT/Nl
         W7sMtughvi77g59Xt+wYULkT6zPkFOjleyvAVUvptKxnBbbUSm+2IX3IiKdpC0qoFS
         /lmrffxXAq0z4RvQ1qPtaxgA=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: rtl8192e: cleanup if statements
Date:   Sun, 25 Sep 2022 14:50:28 +0200
Message-Id: <20220925125028.2495822-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings for if statements in rtl_wx.c

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index bfb963768fc3..2db98d4ddb1b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -313,7 +313,7 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
 	/* ~130 Mb/s real (802.11n) */
 	range->throughput = 130 * 1000 * 1000;
 
-	if (priv->rf_set_sens != NULL)
+	if (priv->rf_set_sens)
 		/* signal level threshold range */
 		range->sensitivity = priv->max_sens;
 
@@ -395,7 +395,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 	rt_state = priv->rtllib->eRFPowerState;
 	if (!priv->up)
 		return -ENETDOWN;
-	if (priv->rtllib->LinkDetectInfo.bBusyTraffic == true)
+	if (priv->rtllib->LinkDetectInfo.bBusyTraffic)
 		return -EAGAIN;
 
 	if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
@@ -582,9 +582,9 @@ static int _rtl92e_wx_set_frag(struct net_device *dev,
 	if (priv->hw_radio_off)
 		return 0;
 
-	if (wrqu->frag.disabled)
+	if (wrqu->frag.disabled) {
 		priv->rtllib->fts = DEFAULT_FRAG_THRESHOLD;
-	else {
+	} else {
 		if (wrqu->frag.value < MIN_FRAG_THRESHOLD ||
 		    wrqu->frag.value > MAX_FRAG_THRESHOLD)
 			return -EINVAL;
@@ -821,7 +821,7 @@ static int _rtl92e_wx_get_sens(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->rf_set_sens == NULL)
+	if (!priv->rf_set_sens)
 		return -1; /* we have not this support for this radio */
 	wrqu->sens.value = priv->sens;
 	return 0;
@@ -839,7 +839,7 @@ static int _rtl92e_wx_set_sens(struct net_device *dev,
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
-	if (priv->rf_set_sens == NULL) {
+	if (!priv->rf_set_sens) {
 		err = -1; /* we have not this support for this radio */
 		goto exit;
 	}
@@ -882,7 +882,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 		u8 idx = 0, alg = 0, group = 0;
 
 		if ((encoding->flags & IW_ENCODE_DISABLED) ||
-		     ext->alg == IW_ENCODE_ALG_NONE) {
+		    ext->alg == IW_ENCODE_ALG_NONE) {
 			ieee->pairwise_key_type = ieee->group_key_type
 						= KEY_TYPE_NA;
 			rtl92e_cam_reset(dev);
@@ -919,7 +919,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 					 key, 0);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
-			     ieee->pHTInfo->bCurrentHTSupport)
+			    ieee->pHTInfo->bCurrentHTSupport)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
@@ -993,7 +993,7 @@ static int _rtl92e_wx_get_gen_ie(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 
-	if (ieee->wpa_ie_len == 0 || ieee->wpa_ie == NULL) {
+	if (ieee->wpa_ie_len == 0 || !ieee->wpa_ie) {
 		data->data.length = 0;
 		return 0;
 	}
-- 
2.30.2

