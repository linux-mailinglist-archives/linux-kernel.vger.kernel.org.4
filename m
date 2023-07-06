Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0850D749365
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGFCAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGFCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:00:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B881BC3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:00:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A38C918D092;
        Wed,  5 Jul 2023 22:00:08 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        v3tlSDOLl+PJCTa5s1wtQ0rrm99f1OUsOyDNa/2p6gs=; b=SV0sfyWKKYRMVcsv
        iqIX6uui+4nbPJQAl2Plk32fzMyFYTBn/BWa1zo40Fn8iI7g0E+AtrGxv+6NJ7X4
        lnEuaidNSL7gh4Y21lQ2uI6PkzuJPuP2pELmWnAf5SQMsGobyVfyO4uf835mrhmh
        sxsUzzqI6poRiRRCiq7X6oLVTnc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83F9518D091;
        Wed,  5 Jul 2023 22:00:08 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=v3tlSDOLl+PJCTa5s1wtQ0rrm99f1OUsOyDNa/2p6gs=;
 b=GxbOfB300L4K+p/zWDpfBQlNmkm+0CVSePchc0kxb53gWJL4mrIBFjBtsUuTZzDFbefgjn24cKVP0/HjFR8iTv37FXP/8sefO2NH0c6NPvrZeqRio8srhni6VFMSBVWWbYvJwxD/eM+g7S7l+3PfdA4qsF13687t8mBZRIpYtRw=
Received: from kimchi.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB3F818D090;
        Wed,  5 Jul 2023 22:00:06 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 5 Jul 2023 18:59:59 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Rename variable bCurrentHTSupport
Message-ID: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: D4D2A322-1BA0-11EE-8866-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames variable bCurrentHTSupport to bcurrent_ht_support
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 12 ++++++------
 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c         |  8 ++++----
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4447489a16ea..8b784af7da3a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -313,7 +313,7 @@ static void _rtl92e_update_beacon(void *data)
 	struct rtllib_device *ieee = priv->rtllib;
 	struct rtllib_network *net = &ieee->current_network;
 
-	if (ieee->ht_info->bCurrentHTSupport)
+	if (ieee->ht_info->bcurrent_ht_support)
 		HT_update_self_and_peer_setting(ieee, net);
 	ieee->ht_info->current_rt2rt_long_slot_time = net->bssht.bd_rt2rt_long_slot_time;
 	ieee->ht_info->RT2RT_HT_Mode = net->bssht.rt2rt_ht_mode;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 88975dc804c6..b2a4c02a41b5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -866,7 +866,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 					 key, 0);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
-			     ieee->ht_info->bCurrentHTSupport)
+			     ieee->ht_info->bcurrent_ht_support)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index acc19514bca6..d9d0476bfd0f 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -244,13 +244,13 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->bCurrentHTSupport ||
+	    !ieee->ht_info->bcurrent_ht_support ||
 	    (ieee->ht_info->iot_action & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev,
 			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
 			    ieee->current_network.qos_data.active,
-			    ieee->ht_info->bCurrentHTSupport);
+			    ieee->ht_info->bcurrent_ht_support);
 		goto OnADDBAReq_Fail;
 	}
 	if (!GetTs(ieee, (struct ts_common_info **)&pTS, dst,
@@ -326,12 +326,12 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->bCurrentHTSupport ||
+	    !ieee->ht_info->bcurrent_ht_support ||
 	    !ieee->ht_info->bCurrentAMPDUEnable) {
 		netdev_warn(ieee->dev,
 			    "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",
 			    ieee->current_network.qos_data.active,
-			    ieee->ht_info->bCurrentHTSupport,
+			    ieee->ht_info->bcurrent_ht_support,
 			    ieee->ht_info->bCurrentAMPDUEnable);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -413,11 +413,11 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->bCurrentHTSupport) {
+	    !ieee->ht_info->bcurrent_ht_support) {
 		netdev_warn(ieee->dev,
 			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
 			    ieee->current_network. qos_data.active,
-			    ieee->ht_info->bCurrentHTSupport);
+			    ieee->ht_info->bcurrent_ht_support);
 		return -1;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2bbd01048561..4ac66835f3d3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -93,7 +93,7 @@ enum ht_aggre_mode {
 
 struct rt_hi_throughput {
 	u8 enable_ht;
-	u8 bCurrentHTSupport;
+	u8 bcurrent_ht_support;
 	u8 bRegBW40MHz;
 	u8 bCurBW40MHz;
 	u8 bRegShortGI40MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..86cef86ea9c8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -516,7 +516,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	static const u8 EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 	static const u8 EWC11NHTInfo[] = { 0x00, 0x90, 0x4c, 0x34 };
 
-	if (!ht_info->bCurrentHTSupport) {
+	if (!ht_info->bcurrent_ht_support) {
 		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);
 		return;
 	}
@@ -621,7 +621,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->bCurrentHTSupport = false;
+	ht_info->bcurrent_ht_support = false;
 
 	ht_info->bCurBW40MHz = false;
 	ht_info->cur_tx_bw40mhz = false;
@@ -692,7 +692,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 	 * function rtllib_softmac_new_net. WB 2008.09.10
 	 */
 	if (pNetwork->bssht.bd_support_ht) {
-		ht_info->bCurrentHTSupport = true;
+		ht_info->bcurrent_ht_support = true;
 		ht_info->ePeerHTSpecVer = pNetwork->bssht.bd_ht_spec_ver;
 
 		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
@@ -746,7 +746,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_CDD_FSYNC;
 	} else {
-		ht_info->bCurrentHTSupport = false;
+		ht_info->bcurrent_ht_support = false;
 		ht_info->current_rt2rt_aggregation = false;
 		ht_info->current_rt2rt_long_slot_time = false;
 		ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
@@ -763,7 +763,7 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 	struct ht_info_ele *pPeerHTInfo =
 		 (struct ht_info_ele *)pNetwork->bssht.bd_ht_info_buf;
 
-	if (ht_info->bCurrentHTSupport) {
+	if (ht_info->bcurrent_ht_support) {
 		if (pNetwork->bssht.bd_ht_info_len != 0)
 			ht_info->current_op_mode = pPeerHTInfo->OptMode;
 	}
@@ -775,7 +775,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	if (ht_info->enable_ht) {
-		ht_info->bCurrentHTSupport = true;
+		ht_info->bcurrent_ht_support = true;
 		ht_info->bCurSuppCCK = ht_info->bRegSuppCCK;
 
 		ht_info->bCurBW40MHz = ht_info->bRegBW40MHz;
@@ -802,13 +802,13 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 		ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
 	} else {
-		ht_info->bCurrentHTSupport = false;
+		ht_info->bcurrent_ht_support = false;
 	}
 }
 
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
 {
-	if (ieee->ht_info->bCurrentHTSupport) {
+	if (ieee->ht_info->bcurrent_ht_support) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 425d4acbcdf0..3bd8ebbad5a6 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -816,7 +816,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
-	if (ieee->ht_info->bCurrentHTSupport) {
+	if (ieee->ht_info->bcurrent_ht_support) {
 		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
 		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
 		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);
@@ -1135,7 +1135,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		ieee->mode = WIRELESS_MODE_G;
 	}
 
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->bcurrent_ht_support && ieee->ht_info->enable_ht) {
 		ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
 		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len,
@@ -1274,7 +1274,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		memcpy(tag, osCcxVerNum.Octet, osCcxVerNum.Length);
 		tag += osCcxVerNum.Length;
 	}
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->bcurrent_ht_support && ieee->ht_info->enable_ht) {
 		if (ieee->ht_info->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_HT_CAP;
@@ -1308,7 +1308,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		rtllib_TURBO_Info(ieee, &tag);
 	}
 
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->bcurrent_ht_support && ieee->ht_info->enable_ht) {
 		if (ieee->ht_info->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
@@ -1474,13 +1474,13 @@ static void rtllib_associate_complete_wq(void *data)
 		ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->bcurrent_ht_support && ieee->ht_info->enable_ht) {
 		netdev_info(ieee->dev, "Successfully associated, ht enabled\n");
 		HTOnAssocRsp(ieee);
 	} else {
 		netdev_info(ieee->dev,
 			    "Successfully associated, ht not enabled(%d, %d)\n",
-			    ieee->ht_info->bCurrentHTSupport,
+			    ieee->ht_info->bcurrent_ht_support,
 			    ieee->ht_info->enable_ht);
 		memset(ieee->dot11ht_oper_rate_set, 0, 16);
 	}
@@ -1645,7 +1645,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 					HTResetSelfAndSavePeerSetting(ieee,
 						 &(ieee->current_network));
 				else
-					ieee->ht_info->bCurrentHTSupport =
+					ieee->ht_info->bcurrent_ht_support =
 								 false;
 
 				ieee->link_state = RTLLIB_ASSOCIATING;
@@ -2579,7 +2579,7 @@ static void rtllib_start_ibss_wq(void *data)
 	if (ieee->mode == WIRELESS_MODE_N_24G)
 		HTUseDefaultSetting(ieee);
 	else
-		ieee->ht_info->bCurrentHTSupport = false;
+		ieee->ht_info->bcurrent_ht_support = false;
 
 	ieee->SetHwRegHandler(ieee->dev, HW_VAR_MEDIA_STATUS,
 			      (u8 *)(&ieee->link_state));
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 2de63d1f2009..feb656103147 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -330,7 +330,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht &&
+	if (ieee->ht_info->bcurrent_ht_support && ieee->ht_info->enable_ht &&
 	    ieee->ht_info->bCurBW40MHz) {
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index ec038ef806c3..08235ad1cbc5 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -273,7 +273,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (rtllib_act_scanning(ieee, false))
 		return;
 
-	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
+	if (!ht_info->bcurrent_ht_support || !ht_info->enable_ht)
 		return;
 	if (!IsQoSDataFrame(skb->data))
 		return;
@@ -354,7 +354,7 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 
 	tcb_desc->bUseShortGI		= false;
 
-	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
+	if (!ht_info->bcurrent_ht_support || !ht_info->enable_ht)
 		return;
 
 	if (ht_info->forced_short_gi) {
@@ -375,7 +375,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	tcb_desc->bPacketBW = false;
 
-	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
+	if (!ht_info->bcurrent_ht_support || !ht_info->enable_ht)
 		return;
 
 	if (tcb_desc->bMulticast || tcb_desc->bBroadcast)
@@ -438,7 +438,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			tcb_desc->rts_rate = MGN_24M;
 			break;
 		}
-		if (ht_info->bCurrentHTSupport  && ht_info->enable_ht) {
+		if (ht_info->bcurrent_ht_support  && ht_info->enable_ht) {
 			u8 HTOpMode = ht_info->current_op_mode;
 
 			if ((ht_info->bCurBW40MHz && (HTOpMode == 2 ||
-- 
2.30.2

