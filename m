Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BC6DBC5D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDHRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHRjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:39:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55506AF12
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:39:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w11so1394063plp.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680975574;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+3r3yk+kfxynNWjdV5lv3xdBpQII9pMefQwWf4bW4A=;
        b=Dxo/UCpQX9rqJQBDM/Fo/0UIAtIp03qgtEemAN9BCraMhHTcbjkeHcH5bOnZs/DHlw
         3WbqVHHg6qPpxKCkPKzucozOY11Ay3xSDCkdUV3v2fNzjZS3JyRLgrNY6JnFu8PuOxik
         FvkjSn5x8wkemb5PnMls5UCXLbwELQi26KsaW5LDMwVw3XsDsJtHKrqjL4gzhJfFB4Qg
         GtXqHY686cuhGtdAIykHjhQCnxoT2BjaYQcvCxkMeQp/UvSLfYirQtJRuo8cZ2PM199u
         V9yWmZhRRhrDZ0SLe+k4vTQfTEn6E4aU/EBuKHVlSzTSkzgzWA2eUBGQZt9mOwNjWx54
         OeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680975574;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+3r3yk+kfxynNWjdV5lv3xdBpQII9pMefQwWf4bW4A=;
        b=fop6oqXejxZM1h0ThCcGUuo7PMmiAZChNyDxjMhonIUUGebcvArKvWGRKOf02xcoeL
         fQ8z9oP7CfIjkjq5oZwMCeA1mnXiJi/PVN9aGIFSp/wjYSdBoYpNYNY0nX+woYNHMCSv
         Bo7ekVICvz77KzSpQpcEbuWkTnTzJp30HXZhpu9/Hr2tJh04lowWBmoa7Av0yTAxvvs+
         qicen52lVq9fF4jdt2X3daB4eku5jww45IP4K2+ECTc5/VfjA+ALgMXZvGjNbYdQZaOh
         Q/WK30sWhUr7CTfHEcJacvPqMpdO9celqBpX4ZJjdXlyzBhr3zy3olJP1G/2VdjQCstS
         ksAQ==
X-Gm-Message-State: AAQBX9fXQPJZZ2siKUbxChkGrCGbVm1hzH58eUn7lH9lYw6tbgJ7jRx7
        ++Q4aR5lXTEQX3iUoZu/4tM=
X-Google-Smtp-Source: AKy350bdQ/AvL59WCeJbiT8FVpDzYGphoQ0LYx7T7f1QFObta4YR/VsFU9jKPbJaurEfLutPsI97Og==
X-Received: by 2002:a17:902:d411:b0:19c:e405:4446 with SMTP id b17-20020a170902d41100b0019ce4054446mr2680142ple.30.1680975573682;
        Sat, 08 Apr 2023 10:39:33 -0700 (PDT)
Received: from sumitra.com ([117.207.136.97])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902b70d00b001a1d553de0fsm4780391pls.271.2023.04.08.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 10:39:33 -0700 (PDT)
Date:   Sat, 8 Apr 2023 10:39:27 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix alignment to match open parenthesis
Message-ID: <20230408173927.GA262840@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix alignment to match opening parenthesis as suggested by Linux
kernel coding-style. Check reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 31 +++++++++-----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7506d7eb7b4c..1e16bfc9d52c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -285,7 +285,7 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		u8	cur_slot_time = priv->slot_time;
 
 		if ((cap & WLAN_CAPABILITY_SHORT_SLOT_TIME) &&
-		   (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
+		    (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
 			if (cur_slot_time != SHORT_SLOT_TIME) {
 				slot_time_val = SHORT_SLOT_TIME;
 				priv->rtllib->SetHwRegHandler(dev,
@@ -354,14 +354,12 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 		return ret;
 
 	if (network->flags & NETWORK_HAS_QOS_MASK) {
-		if (active_network &&
-				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
+		if (active_network && (network->flags & NETWORK_HAS_QOS_PARAMETERS))
 			network->qos_data.active = network->qos_data.supported;
 
 		if ((network->qos_data.active == 1) && (active_network == 1) &&
-				(network->flags & NETWORK_HAS_QOS_PARAMETERS) &&
-				(network->qos_data.old_param_count !=
-				network->qos_data.param_count)) {
+		    (network->flags & NETWORK_HAS_QOS_PARAMETERS) &&
+		    (network->qos_data.old_param_count != network->qos_data.param_count)) {
 			network->qos_data.old_param_count =
 				network->qos_data.param_count;
 			priv->rtllib->wmm_acm = network->qos_data.wmm_acm;
@@ -423,7 +421,7 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
 			network->qos_data.param_count;
 	} else {
 		memcpy(&priv->rtllib->current_network.qos_data.parameters,
-		&def_qos_parameters, size);
+		       &def_qos_parameters, size);
 		priv->rtllib->current_network.qos_data.active = 0;
 		priv->rtllib->current_network.qos_data.supported = 0;
 		set_qos_param = 1;
@@ -439,8 +437,8 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
 }
 
 static int _rtl92e_handle_assoc_response(struct net_device *dev,
-				 struct rtllib_assoc_response_frame *resp,
-				 struct rtllib_network *network)
+					 struct rtllib_assoc_response_frame *resp,
+					 struct rtllib_network *network)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
@@ -935,7 +933,7 @@ static short _rtl92e_is_tx_queue_empty(struct net_device *dev)
 			continue;
 		if (skb_queue_len(&(&priv->tx_ring[i])->queue) > 0) {
 			netdev_info(dev, "===>tx queue is not empty:%d, %d\n",
-			       i, skb_queue_len(&(&priv->tx_ring[i])->queue));
+				    i, skb_queue_len(&(&priv->tx_ring[i])->queue));
 			return 0;
 		}
 	}
@@ -1213,7 +1211,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	if ((ieee->state == RTLLIB_LINKED) && (ieee->iw_mode ==
 	     IW_MODE_INFRA) && (!ieee->net_promiscuous_md)) {
 		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
-		ieee->link_detect_info.NumTxOkInPeriod > 100)
+		    ieee->link_detect_info.NumTxOkInPeriod > 100)
 			bBusyTraffic = true;
 
 		if (ieee->link_detect_info.NumRxOkInPeriod > 4000 ||
@@ -1397,8 +1395,7 @@ static void _rtl92e_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 				    MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
 
-	if ((priv->rtllib->rf_power_state == rf_off) || !priv->up ||
-	     priv->reset_in_progress) {
+	if ((priv->rtllib->rf_power_state == rf_off) || !priv->up || priv->reset_in_progress) {
 		kfree_skb(skb);
 		return;
 	}
@@ -1431,7 +1428,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (queue_index != TXCMD_QUEUE) {
 		if ((priv->rtllib->rf_power_state == rf_off) ||
-		     !priv->up || priv->reset_in_progress) {
+		    !priv->up || priv->reset_in_progress) {
 			kfree_skb(skb);
 			return 0;
 		}
@@ -1879,7 +1876,7 @@ static void _rtl92e_tx_resume(struct net_device *dev)
 	for (queue_index = BK_QUEUE;
 	     queue_index < MAX_QUEUE_SIZE; queue_index++) {
 		while ((!skb_queue_empty(&ieee->skb_waitQ[queue_index])) &&
-		(priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) {
+		       (priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) {
 			skb = skb_dequeue(&ieee->skb_waitQ[queue_index]);
 			ieee->softmac_data_hard_start_xmit(skb, dev, 0);
 		}
@@ -1948,7 +1945,7 @@ static int _rtl92e_close(struct net_device *dev)
 	int ret;
 
 	if ((rtllib_act_scanning(priv->rtllib, false)) &&
-		!(priv->rtllib->softmac_features & IEEE_SOFTMAC_SCAN)) {
+	    !(priv->rtllib->softmac_features & IEEE_SOFTMAC_SCAN)) {
 		rtllib_stop_scan(priv->rtllib);
 	}
 
@@ -2272,7 +2269,7 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
 		if (dev->mem_start != 0) {
 			iounmap((void __iomem *)dev->mem_start);
 			release_mem_region(pci_resource_start(pdev, 1),
-					pci_resource_len(pdev, 1));
+					   pci_resource_len(pdev, 1));
 		}
 
 		free_rtllib(dev);
-- 
2.25.1

