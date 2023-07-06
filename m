Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCF7493A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjGFCXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGFCXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:23:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D71730
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:23:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B0841A64EA;
        Wed,  5 Jul 2023 22:23:29 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        /NVXDdfY8UM9GKXKRR9vkGmJTmSHNnysR/wQRuQoyGQ=; b=CvTMm/aw9FSyiZJP
        1E2YrRILpes53hhoaSzqWPF4j/HeOtPmkaTDGDIPQ2baA505v7iUQ/31+SqXC6uT
        iq3G/fA1vPMYAbgPl4EFqXFn2Bz1wtwdVqk0sEGz39pR3w1UKnE6837qDwWPoo3+
        KnWPukcsb1mcsKq+cc2ErRHbU7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91F171A64E9;
        Wed,  5 Jul 2023 22:23:29 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=/NVXDdfY8UM9GKXKRR9vkGmJTmSHNnysR/wQRuQoyGQ=;
 b=uN1khaU5mAnetUva9eBxc7qYj+K2JglfmP1SaCRyHylasCZtPMWTAJk+6+A/H0nm+5A+qAtBLpCWb1iuWVjo9u5Guk2nm0rExa731P1ogrHQHq+nr557smp6edJRNRE7HXSOdEi90IHpGUkf0oS2DcrPNuHmcIjcQtqqUAOUq6g=
Received: from kimchi.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F7F71A64E6;
        Wed,  5 Jul 2023 22:23:28 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 5 Jul 2023 19:23:22 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Rename variable bCurBW40MHz
Message-ID: <ZKYlmrHHALEdyxS+@kimchi.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 182E672A-1BA4-11EE-84E1-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames variable bCurBW40MHz to bcur_bw_40MHz
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 20 ++++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c         | 10 +++++-----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2bbd01048561..3bfb87bdb3fc 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -95,7 +95,7 @@ struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 bCurrentHTSupport;
 	u8 bRegBW40MHz;
-	u8 bCurBW40MHz;
+	u8 bcur_bw_40MHz;
 	u8 bRegShortGI40MHz;
 	u8 bCurShortGI40MHz;
 	u8 bRegShortGI20MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..99b65b5b9ed9 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -107,8 +107,8 @@ static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	u8	is40MHz = (ht_info->bCurBW40MHz) ? 1 : 0;
-	u8	isShortGI = (ht_info->bCurBW40MHz) ?
+	u8	is40MHz = (ht_info->bcur_bw_40MHz) ? 1 : 0;
+	u8	isShortGI = (ht_info->bcur_bw_40MHz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
@@ -623,7 +623,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	ht_info->bCurrentHTSupport = false;
 
-	ht_info->bCurBW40MHz = false;
+	ht_info->bcur_bw_40MHz = false;
 	ht_info->cur_tx_bw40mhz = false;
 
 	ht_info->bCurShortGI20MHz = false;
@@ -778,7 +778,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 		ht_info->bCurrentHTSupport = true;
 		ht_info->bCurSuppCCK = ht_info->bRegSuppCCK;
 
-		ht_info->bCurBW40MHz = ht_info->bRegBW40MHz;
+		ht_info->bcur_bw_40MHz = ht_info->bRegBW40MHz;
 		ht_info->bCurShortGI20MHz = ht_info->bRegShortGI20MHz;
 
 		ht_info->bCurShortGI40MHz = ht_info->bRegShortGI40MHz;
@@ -821,7 +821,7 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (ht_info->bCurBW40MHz) {
+	if (ht_info->bcur_bw_40MHz) {
 		if (ht_info->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel + 2);
@@ -866,19 +866,19 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
 		if (Offset == HT_EXTCHNL_OFFSET_UPPER ||
 		    Offset == HT_EXTCHNL_OFFSET_LOWER) {
-			ht_info->bCurBW40MHz = true;
+			ht_info->bcur_bw_40MHz = true;
 			ht_info->CurSTAExtChnlOffset = Offset;
 		} else {
-			ht_info->bCurBW40MHz = false;
+			ht_info->bcur_bw_40MHz = false;
 			ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 		}
 	} else {
-		ht_info->bCurBW40MHz = false;
+		ht_info->bcur_bw_40MHz = false;
 		ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 	}
 
-	netdev_dbg(ieee->dev, "%s():ht_info->bCurBW40MHz:%x\n", __func__,
-		   ht_info->bCurBW40MHz);
+	netdev_dbg(ieee->dev, "%s():ht_info->bcur_bw_40MHz:%x\n", __func__,
+		   ht_info->bcur_bw_40MHz);
 
 	ht_info->sw_bw_in_progress = true;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 2de63d1f2009..59ea210e8bb1 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -331,10 +331,10 @@ void rtllib_wx_sync_scan_wq(void *data)
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht &&
-	    ieee->ht_info->bCurBW40MHz) {
+	    ieee->ht_info->bcur_bw_40MHz) {
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
-		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
+		bandwidth = (enum ht_channel_width)ieee->ht_info->bcur_bw_40MHz;
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index ec038ef806c3..c9bb350d8881 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -362,9 +362,9 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 		return;
 	}
 
-	if (ht_info->bCurBW40MHz && ht_info->bCurShortGI40MHz)
+	if (ht_info->bcur_bw_40MHz && ht_info->bCurShortGI40MHz)
 		tcb_desc->bUseShortGI = true;
-	else if (!ht_info->bCurBW40MHz && ht_info->bCurShortGI20MHz)
+	else if (!ht_info->bcur_bw_40MHz && ht_info->bCurShortGI20MHz)
 		tcb_desc->bUseShortGI = true;
 }
 
@@ -383,7 +383,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
-	if (ht_info->bCurBW40MHz && ht_info->cur_tx_bw40mhz &&
+	if (ht_info->bcur_bw_40MHz && ht_info->cur_tx_bw40mhz &&
 	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW = true;
 }
@@ -441,9 +441,9 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		if (ht_info->bCurrentHTSupport  && ht_info->enable_ht) {
 			u8 HTOpMode = ht_info->current_op_mode;
 
-			if ((ht_info->bCurBW40MHz && (HTOpMode == 2 ||
+			if ((ht_info->bcur_bw_40MHz && (HTOpMode == 2 ||
 						      HTOpMode == 3)) ||
-			     (!ht_info->bCurBW40MHz && HTOpMode == 3)) {
+			     (!ht_info->bcur_bw_40MHz && HTOpMode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
-- 
2.30.2

