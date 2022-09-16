Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DCE5BA50D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIPDIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIPDHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:07:52 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA27330D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:07:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=momi.ca; s=key1;
        t=1663297665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jh0ugHIzU1ssKWGRd6CmYhecjCNbV/ZWfBZL0gM5nKY=;
        b=ABw6TJ32Z6tvZ5enyMzb4lCl2hEWUTh+ULxZtgbnsDkMAOxlkXs3zh6uwIzE9cH5GoAy41
        4DFjSFO+YkRrdS74RlUaSiAj4SWmErboNBKHhsbitg061/u4J995b2NfMEJ7nNn1WdWGRS
        fBDI+pQPl1l8n/CC3mEScbxlG3VcMDQ5liAOUuOAKir2iJIiNh0z7qQO6mhJ0CTL/RQm4L
        J8t/0XWlMv2bItwArQnYLn9hRsTML0eAQ9Ta6itNviCP9dtfmfRVQtoFi3U9iWfQ/3asct
        P4dfQunOuHJGC1PjSDq5XW0b0blU/REP1mwUXuVpM9/9U8wvQzRc3lS2xw+bGA==
From:   Anjandev Momi <anjan@momi.ca>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Anjandev Momi <anjan@momi.ca>
Subject: [PATCH] Staging: rtl8192e: fixed brace, space, and align coding style issues
Date:   Thu, 15 Sep 2022 23:06:55 -0400
Message-Id: <20220916030655.11105-1-anjan@momi.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: momi.ca
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying this patch, file drivers/staging/rtl8192e/rtl819x_BAProc.c only
has "Avoid CamelCase" coding style issue

Signed-off-by: Anjandev Momi <anjan@momi.ca>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 7d04966af..b4e565af1 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -62,6 +62,7 @@ void ResetBaEntry(struct ba_record *pBA)
 	pBA->dialog_token		  = 0;
 	pBA->ba_start_seq_ctrl.short_data = 0;
 }
+
 static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 				    struct ba_record *pBA,
 				    u16 StatusCode, u8 type)
@@ -113,7 +114,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	tag += 2;
 
 	if (type == ACT_ADDBAREQ) {
-		memcpy(tag, (u8 *)&(pBA->ba_start_seq_ctrl), 2);
+		memcpy(tag, (u8 *)&pBA->ba_start_seq_ctrl, 2);
 		tag += 2;
 	}
 
@@ -161,7 +162,6 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	*tag++ = ACT_CAT_BA;
 	*tag++ = ACT_DELBA;
 
-
 	put_unaligned_le16(DelbaParamSet.short_data, tag);
 	tag += 2;
 
@@ -258,8 +258,8 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->pHTInfo->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
-	if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
-	    (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
+	if (!GetTs(ieee, (struct ts_common_info **)(&pTS),
+		   dst, (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
@@ -282,7 +282,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBA->ba_start_seq_ctrl = *pBaStartSeqCtrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
-	   (ieee->pHTInfo->IOTAction & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
+	    (ieee->pHTInfo->IOTAction & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		pBA->ba_param_set.field.buffer_size = 1;
 	else
 		pBA->ba_param_set.field.buffer_size = 32;
@@ -380,7 +380,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			goto OnADDBARsp_Reject;
 		}
 
-
 		pAdmittedBA->dialog_token = *pDialogToken;
 		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
 		pAdmittedBA->ba_start_seq_ctrl = pPendingBA->ba_start_seq_ctrl;
@@ -419,8 +418,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		return -1;
 	}
 
-	if (!ieee->current_network.qos_data.active ||
-		!ieee->pHTInfo->bCurrentHTSupport) {
+	if (!ieee->current_network.qos_data.active || !ieee->pHTInfo->bCurrentHTSupport) {
 		netdev_warn(ieee->dev,
 			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
 			    ieee->current_network. qos_data.active,
@@ -440,7 +438,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct rx_ts_record *pRxTs;
 
 		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
-		    (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
+			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
 				    __func__, dst,
-- 
2.36.2

