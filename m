Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE65E905A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiIXWvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIXWvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:51:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6BA4505B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:51:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so2757738wml.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=heMq8ZyNcby7A2cMF3qI/WZaLnJ9T+jpUMoUVSz+v/Q=;
        b=eT0jFR8ExgGkkw3jXjOsHCjkqf/punsrb1XIJ5x6mSgxSDmahwOF/et/MWA+50l4kW
         w8/nykJZTYoJfyOIuIJir9xSjF0wUz8eGR4h7JRLs7bW/y+M7A/0fTeat99zH9V/p0il
         EQqOjn78Z7KphXqYezcIIfTuQ0uDa2KkXf+BADX1Vapohvbjt6UYiS/7CsmAERn+ZeRi
         6avYoDhmetxD3TOQbm1P/S0My6VKDqmQvDtZsT0aeoAz4GQK5ltfyeKVr4mh/2ikgFcV
         jPa7P4mprdXyGAIyaUVHbSJC16b4PCdZlS+Rq87X7exBWSE942f0Kq/Nqhxf/EA8KxV9
         pMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=heMq8ZyNcby7A2cMF3qI/WZaLnJ9T+jpUMoUVSz+v/Q=;
        b=e03KOhd0VLwTz+fVnVz6RsqXUazWP1s7Pr9WXjh7sG0Dxxo2/kuY3PFcaYh8c3sbdE
         mtkP+cDptPvCNWy5JlGMC6yNXZ1XneIIHpuKdfg7SoQYSXhS027RYtiwh/XuGn9aFaBa
         PPyAqnUujhD+NZ/n2ltrwcs/CuQ9kffRxg6ZhQm3R9A2KGDpjV6INFLwbluuk5v8B+ay
         ayIlYtdxPSu6L0trM4fLYZ7ZLQ3q+9Zda9dIJ/gyjnYGg2R7n+Rn8s9Kk8m+uwhzHO8N
         Juq4PEOk1JYkierk/El7Y0W9j09tXzoRJtsh10wFaGUC2kLXnzOdImAK/im8g+rgc1hK
         Ha5w==
X-Gm-Message-State: ACrzQf2ETv0yHqW0z97jep4p+n3o6lojrzSqxgISERPfhEeb4ypznz+v
        oskrnTH+fJPifEpmn9Z72Vw=
X-Google-Smtp-Source: AMsMyM5hJfDdbCxRzZdmGTtj+Cg22JT701S+ABKtsJzDOkw7JaxxGN2ZtCiWp+NgFF90PlI26RlBsw==
X-Received: by 2002:a05:600c:284:b0:3b5:3360:3f8c with SMTP id 4-20020a05600c028400b003b533603f8cmr29380wmk.83.1664059890910;
        Sat, 24 Sep 2022 15:51:30 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id bj4-20020a0560001e0400b0022a403954c3sm11143165wrb.42.2022.09.24.15.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:51:30 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH] staging: rtl8192e: Rename Tx_Retry_Count_Reg
Date:   Sat, 24 Sep 2022 23:51:26 +0100
Message-Id: <20220924225126.10527-1-dragan.m.cvetic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename: Current_Tx_Rate_Reg to CURRENT_TX_RATE_REG, Initial_Tx_Rate_Reg to
INITIAL_TX_RATE_REG and Tx_Retry_Count_Reg to TX_RETRY_COUNT_REG to avoid
CamelCase which is not accepted by checkpatch.pl.

Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 11 +++--------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  6 +++---
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 3ee52147960e..9fefa1a7ae75 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -2499,14 +2499,9 @@ static void _rtl92e_dm_check_txrateandretrycount(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 
-	ieee->softmac_stats.CurrentShowTxate = rtl92e_readb(dev,
-						 Current_Tx_Rate_Reg);
-
-	ieee->softmac_stats.last_packet_rate = rtl92e_readb(dev,
-						 Initial_Tx_Rate_Reg);
-
-	ieee->softmac_stats.txretrycount = rtl92e_readl(dev,
-						 Tx_Retry_Count_Reg);
+	ieee->softmac_stats.CurrentShowTxate = rtl92e_readb(dev, CURRENT_TX_RATE_REG);
+	ieee->softmac_stats.last_packet_rate = rtl92e_readb(dev, INITIAL_TX_RATE_REG);
+	ieee->softmac_stats.txretrycount = rtl92e_readl(dev, TX_RETRY_COUNT_REG);
 }
 
 static void _rtl92e_dm_send_rssi_to_fw(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index ea1b14bbcdcd..51e295d389a8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -42,9 +42,9 @@
 #define	 TX_POWER_ATHEROAP_THRESH_HIGH	   78
 #define		TX_POWER_ATHEROAP_THRESH_LOW		72
 
-#define			Current_Tx_Rate_Reg	 0x1e0
-#define			Initial_Tx_Rate_Reg	 0x1e1
-#define			Tx_Retry_Count_Reg	 0x1ac
+#define		CURRENT_TX_RATE_REG		0x1e0
+#define		INITIAL_TX_RATE_REG		0x1e1
+#define		TX_RETRY_COUNT_REG		0x1ac
 #define		RegC38_TH				 20
 
 #define		DM_Type_ByDriver		1
-- 
2.25.1

