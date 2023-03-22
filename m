Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF676C5208
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCVRPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCVRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282265C6F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ew6so12882536edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505320; x=1682097320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKKb1zFXQ8RMG4G+1nCtOfg0xwq/cDe7kuYBhG6cOwc=;
        b=f5pVr567swxunmcxX9IPCt7OG7W4StH1FMpqV8PBgfSgzwBaEtT2VquH0QH3b2rc2G
         HcU4g4hZtGDdwo7OSvy7CU9dW6atp4QoAXDiskYKvJPoyvO3MQXZDBrKD1V2ed53eTun
         OPiemkvFstE4aDHf6Hiagtj6yiM284VsRNgrUXU2qKzkybGq2jPZKJ530nVUMIXl/JMr
         kEWaPNOjfnO3BbZBWxN6NcNAWgsEd6eTY+PIcmloN9gEk/o7B9TZw05yh+EiT86rA7qT
         GDGK10HIvn5OJqcfJrACrCfbQ6teflsJnNyZaGsA1KtvLxL8+og5VXhHHKjVwxMO7asw
         n+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505320; x=1682097320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKKb1zFXQ8RMG4G+1nCtOfg0xwq/cDe7kuYBhG6cOwc=;
        b=mjhWpHWrqfc3p2TxZCBf+bXjq3HAt3Md+F4ecXduyvpf8q9Ll9KjirL0p2xDzj9wbh
         XUPESg9VRs5RiBU+wX8GO4ZK9IgAOx3/GmxFZfK0gpTu8xtjQS5rwRUADHB3lf5AbrJ6
         3nH/uA1jTIYkk9ijDOZXpb7pF4ie1t2H4ZwWgUcy1Q+4zhEqMtS4S1GHg+hvE8bpIaoA
         ZmZQ/UnqZKQOdjgKkqUSYwDUNZwdGZHMK7Dfv2+BpcOHvc15zmcWKza27LFoX1r6LqU0
         9Y3TrafKywxrJWaxNejoIMAvqO+wUObvPqx0hL+QUpUG+tqsdwvkWZ85AA/br9Bgaazy
         s+5Q==
X-Gm-Message-State: AO0yUKWZ9GKrwlqEkEpyHGxq9Szi6iV5PF2uu0+8eQhn+++qhZ/lnHyZ
        ei8I+UkQNlPrqy/VjNZgnSA=
X-Google-Smtp-Source: AK7set9QBuuXm2kHrKsCunaaLNx5vQzG5HCk3cBA72ihKO/OHTD4Cz40inrD/Qs41jPWo6rr9ZG7wQ==
X-Received: by 2002:a17:906:74ca:b0:933:2e79:4632 with SMTP id z10-20020a17090674ca00b009332e794632mr5874525ejl.1.1679505320524;
        Wed, 22 Mar 2023 10:15:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id zc14-20020a170906988e00b00927f6c799e6sm7544458ejb.132.2023.03.22.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:20 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:15:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] staging: rtl8192e: Replace macro
 container_of_work_rsl with standard macro
Message-ID: <d75688b6f884c526f6046fac522b8ed87db1ca2f.1679504314.git.philipp.g.hortmann@gmail.com>
References: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro container_of_work_rsl with standard macro container_of to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without “f.”
        Changed description from function to macro
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 9 +++------
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 3 +--
 drivers/staging/rtl8192e/rtllib.h            | 1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ea07b350b62a..3244aef12c05 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -311,8 +311,7 @@ static const struct rtllib_qos_parameters def_qos_parameters = {
 
 static void _rtl92e_update_beacon(void *data)
 {
-	struct r8192_priv *priv = container_of_work_rsl(data, struct r8192_priv,
-				  update_beacon_wq.work);
+	struct r8192_priv *priv = container_of(data, struct r8192_priv, update_beacon_wq.work);
 	struct net_device *dev = priv->rtllib->dev;
 	struct rtllib_device *ieee = priv->rtllib;
 	struct rtllib_network *net = &ieee->current_network;
@@ -326,8 +325,7 @@ static void _rtl92e_update_beacon(void *data)
 
 static void _rtl92e_qos_activate(void *data)
 {
-	struct r8192_priv *priv = container_of_work_rsl(data, struct r8192_priv,
-				  qos_activate);
+	struct r8192_priv *priv = container_of(data, struct r8192_priv, qos_activate);
 	struct net_device *dev = priv->rtllib->dev;
 	int i;
 
@@ -2033,8 +2031,7 @@ void rtl92e_commit(struct net_device *dev)
 
 static void _rtl92e_restart(void *data)
 {
-	struct r8192_priv *priv = container_of_work_rsl(data, struct r8192_priv,
-				  reset_wq);
+	struct r8192_priv *priv = container_of(data, struct r8192_priv, reset_wq);
 	struct net_device *dev = priv->rtllib->dev;
 
 	mutex_lock(&priv->wx_mutex);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index ef4f736ce325..5a1cd22f5e25 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -142,8 +142,7 @@ void rtl92e_ips_leave(struct net_device *dev)
 
 void rtl92e_ips_leave_wq(void *data)
 {
-	struct rtllib_device *ieee = container_of_work_rsl(data,
-				     struct rtllib_device, ips_leave_wq);
+	struct rtllib_device *ieee = container_of(data, struct rtllib_device, ips_leave_wq);
 	struct net_device *dev = ieee->dev;
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index aa39f8b2bf09..669a9d9a5d18 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,7 +62,6 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define container_of_work_rsl(x, y, z) container_of(x, y, z)
 #define container_of_dwork_rsl(x, y, z)				\
 	container_of(to_delayed_work(x), y, z)
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 91fb5f150a00..b9886e83a6dc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1498,7 +1498,7 @@ static void rtllib_associate_step2(struct rtllib_device *ieee)
 static void rtllib_associate_complete_wq(void *data)
 {
 	struct rtllib_device *ieee = (struct rtllib_device *)
-				     container_of_work_rsl(data,
+				     container_of(data,
 				     struct rtllib_device,
 				     associate_complete_wq);
 	struct rt_pwr_save_ctrl *psc = &ieee->pwr_save_ctrl;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 06f1d6de5cc7..1f2fa711e60b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -326,8 +326,7 @@ EXPORT_SYMBOL(rtllib_wx_set_mode);
 
 void rtllib_wx_sync_scan_wq(void *data)
 {
-	struct rtllib_device *ieee = container_of_work_rsl(data,
-				     struct rtllib_device, wx_sync_scan_wq);
+	struct rtllib_device *ieee = container_of(data, struct rtllib_device, wx_sync_scan_wq);
 	short chan;
 	enum ht_extchnl_offset chan_offset = 0;
 	enum ht_channel_width bandwidth = 0;
-- 
2.39.2

