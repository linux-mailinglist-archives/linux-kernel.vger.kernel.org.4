Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6C6C8CB2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjCYIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjCYIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:36:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268871816D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so16447337edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733405; x=1682325405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK9U2QkxOq0arIBvwJf/Y9U+J4k5u5Usg6iA4O1ZSC0=;
        b=G/Y87BKXeInyi0J58Okc4ggwBPOYlsX6hM8e43vTAhoJVoxerBpyss6UfYV9oYSyqK
         huDJwuyRRxGXS+XQG0N15UIYtC+4nPXdFcgbJfRK+60LO0lzngBk4cMpn8PhOhoRh5z+
         jLKkbAmv13wATgYQ5AUZ07A40MqUTVt4jVI9ThBu6RDk1z00zyMZFJAnrmK7AzzzjZc4
         4nnqBqsshG1eVwhSy8uPVWyNSCsaIbASiaRpb53VrKOMIThCp+qBsX36N33+UCqHFxgE
         FMy49BqKL33KkBhtJdZdYeTFpHwCtW0LiHcKm5zTgYDqP8dlmndq3oJtmrp9Wb91rWMg
         wnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733405; x=1682325405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK9U2QkxOq0arIBvwJf/Y9U+J4k5u5Usg6iA4O1ZSC0=;
        b=xf2yu6d82uTMDvm7dpocfiPI+yR9d+tEYigfOgDNTJQ9FaoH5aeRgqdD00iqO4Mo1G
         2bJV9phkDPC1tOf+rFP9DkBwEjG3gFxHzR3OsKlD/54Xtw9N9qHTZjE/nybr4ZZJ4Ped
         YW8Ih18Y/qgpzIIK6Z3H1nSMW3p8PNiio1j4OQB7RMOd3RKCDZUQM3jEh9a+X6Q7/V5q
         CL09v3uyBFEo/eia27y9Kma3cUFh2oUYFQPHMf4ciWVZJahsm3pgMLwu6GJpwwcntEsB
         B60VJmq9Irh8w+q7vCWd02cHhE5jiTD8hTAhgD8CsPetdlb9B0OnSnaVzfw0ev3jGFZ+
         /OAQ==
X-Gm-Message-State: AAQBX9cI96/tPrFciNUAZTBGjIJYcszCoqAc0mQ48ptHGcmDIyydU3cA
        R45cK9+54WuGQzzcLXpRCDLcUJVBP90=
X-Google-Smtp-Source: AKy350b9dPv/JAUc54uyUKi90ulvDyIfwFV/h1A93eUf5qb39BxndmMphfj/sUf7Owbfwa0nIbEmyg==
X-Received: by 2002:a17:906:1001:b0:93f:e5e4:8c13 with SMTP id 1-20020a170906100100b0093fe5e48c13mr216269ejm.5.1679733405688;
        Sat, 25 Mar 2023 01:36:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906110d00b009333aa81446sm9790043eja.115.2023.03.25.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:45 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:36:43 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_set_rf_power_state
Message-ID: <a83b95c68697e6eade68bfd0bf8e22a1340c1457.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
conditions in function _rtl92e_set_rf_power_state as those are dead
code. Removed unnecessary blank lines to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 186 +++++++-----------
 1 file changed, 76 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 1f0d3654c6a0..b1c297d2ae36 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1040,129 +1040,95 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 		return false;
 	priv->set_rf_pwr_state_in_progress = true;
 
-	switch (priv->rf_chip) {
-	case RF_8256:
-		switch (rf_power_state) {
-		case rf_on:
-			if ((priv->rtllib->rf_power_state == rf_off) &&
-			     RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
-				bool rtstatus;
-				u32 InitilizeCount = 3;
-
-				do {
-					InitilizeCount--;
-					rtstatus = rtl92e_enable_nic(dev);
-				} while (!rtstatus && (InitilizeCount > 0));
-
-				if (!rtstatus) {
-					netdev_err(dev,
-						   "%s(): Failed to initialize Adapter.\n",
-						   __func__);
-					priv->set_rf_pwr_state_in_progress = false;
-					return false;
-				}
-
-				RT_CLEAR_PS_LEVEL(psc,
-						  RT_RF_OFF_LEVL_HALT_NIC);
-			} else {
-				rtl92e_writeb(dev, ANAPAR, 0x37);
-				mdelay(1);
-				rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
-						 0x4, 0x1);
-				priv->hw_rf_off_action = 0;
-
-				rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE,
-						  BIT4, 0x1);
-				rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4,
-						  0x300, 0x3);
-				rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
-						  0x18, 0x3);
-				rtl92e_set_bb_reg(dev, rOFDM0_TRxPathEnable,
-						  0x3, 0x3);
-				rtl92e_set_bb_reg(dev, rOFDM1_TRxPathEnable,
-						  0x3, 0x3);
-				rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
-						  0x60, 0x3);
-
+	switch (rf_power_state) {
+	case rf_on:
+		if ((priv->rtllib->rf_power_state == rf_off) &&
+		     RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
+			bool rtstatus;
+			u32 InitilizeCount = 3;
+
+			do {
+				InitilizeCount--;
+				rtstatus = rtl92e_enable_nic(dev);
+			} while (!rtstatus && (InitilizeCount > 0));
+			if (!rtstatus) {
+				netdev_err(dev,
+					   "%s(): Failed to initialize Adapter.\n",
+					   __func__);
+				priv->set_rf_pwr_state_in_progress = false;
+				return false;
 			}
-
+			RT_CLEAR_PS_LEVEL(psc,
+					  RT_RF_OFF_LEVL_HALT_NIC);
+		} else {
+			rtl92e_writeb(dev, ANAPAR, 0x37);
+			mdelay(1);
+			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
+					 0x4, 0x1);
+			priv->hw_rf_off_action = 0;
+			rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE,
+					  BIT4, 0x1);
+			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4,
+					  0x300, 0x3);
+			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
+					  0x18, 0x3);
+			rtl92e_set_bb_reg(dev, rOFDM0_TRxPathEnable,
+					  0x3, 0x3);
+			rtl92e_set_bb_reg(dev, rOFDM1_TRxPathEnable,
+					  0x3, 0x3);
+			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
+					  0x60, 0x3);
+		}
+		break;
+	case rf_sleep:
+		if (priv->rtllib->rf_power_state == rf_off)
 			break;
-
-		case rf_sleep:
-			if (priv->rtllib->rf_power_state == rf_off)
+		for (QueueID = 0, i = 0; QueueID < MAX_TX_QUEUE; ) {
+			ring = &priv->tx_ring[QueueID];
+			if (skb_queue_len(&ring->queue) == 0) {
+				QueueID++;
+				continue;
+			} else {
+				udelay(10);
+				i++;
+			}
+			if (i >= MAX_DOZE_WAITING_TIMES_9x)
 				break;
-
-
-			for (QueueID = 0, i = 0; QueueID < MAX_TX_QUEUE; ) {
-				ring = &priv->tx_ring[QueueID];
-
-				if (skb_queue_len(&ring->queue) == 0) {
-					QueueID++;
-					continue;
-				} else {
-					udelay(10);
-					i++;
-				}
-
-				if (i >= MAX_DOZE_WAITING_TIMES_9x)
-					break;
+		}
+		rtl92e_set_rf_off(dev);
+		break;
+	case rf_off:
+		for (QueueID = 0, i = 0; QueueID < MAX_TX_QUEUE; ) {
+			ring = &priv->tx_ring[QueueID];
+			if (skb_queue_len(&ring->queue) == 0) {
+				QueueID++;
+				continue;
+			} else {
+				udelay(10);
+				i++;
 			}
+			if (i >= MAX_DOZE_WAITING_TIMES_9x)
+				break;
+		}
+		if (psc->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
+		    !RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
+			rtl92e_disable_nic(dev);
+			RT_SET_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
+		} else if (!(psc->RegRfPsLevel &
+			   RT_RF_OFF_LEVL_HALT_NIC)) {
 			rtl92e_set_rf_off(dev);
-			break;
-
-		case rf_off:
-			for (QueueID = 0, i = 0; QueueID < MAX_TX_QUEUE; ) {
-				ring = &priv->tx_ring[QueueID];
-
-				if (skb_queue_len(&ring->queue) == 0) {
-					QueueID++;
-					continue;
-				} else {
-					udelay(10);
-					i++;
-				}
-
-				if (i >= MAX_DOZE_WAITING_TIMES_9x)
-					break;
-			}
-
-			if (psc->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
-			    !RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
-				rtl92e_disable_nic(dev);
-				RT_SET_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
-			} else if (!(psc->RegRfPsLevel &
-				   RT_RF_OFF_LEVL_HALT_NIC)) {
-				rtl92e_set_rf_off(dev);
-			}
-
-			break;
-
-		default:
-			bResult = false;
-			netdev_warn(dev,
-				    "%s(): Unknown state requested: 0x%X.\n",
-				    __func__, rf_power_state);
-			break;
 		}
-
 		break;
-
 	default:
-		netdev_warn(dev, "%s(): Unknown RF type\n", __func__);
+		bResult = false;
+		netdev_warn(dev,
+			    "%s(): Unknown state requested: 0x%X.\n",
+			    __func__, rf_power_state);
 		break;
 	}
 
 	if (bResult) {
 		priv->rtllib->rf_power_state = rf_power_state;
-
-		switch (priv->rf_chip) {
-		case RF_8256:
-			break;
-
-		default:
-			netdev_warn(dev, "%s(): Unknown RF type\n", __func__);
-			break;
-		}
 	}
 
 	priv->set_rf_pwr_state_in_progress = false;
-- 
2.39.2

