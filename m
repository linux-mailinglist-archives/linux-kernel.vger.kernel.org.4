Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFD6C51FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCVRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjCVRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8714E5CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ew6so12880256edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505308; x=1682097308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bbKg7FyJDOKWJFl4zE5/yQHEnuXb4tsxfmTupEGD00=;
        b=mxoP0PQgIVbOZ6pf1eX+ncgqg/XlaOYFD5zbOffXX3DtD2YQWeBTszZGC6L8EuEJwd
         sVvrQHiAliZMhEd9UjCijKzgtxFYbKDJepWfOmUeOZmuEunxLG/OHSnm6xksRom66uft
         R5pHDhkdofj3ZD76BzaGvip8XCYjGHUE0tUn8I53jWzOwiuaG2PEGFckd1a/NyJF1FZj
         /iRElxQb6+BmCD4l5RVOdZWfPGgF2OEmFxtkAbSUKduYAgWxFfatlTV7YwBrH6+Hp945
         RSpARWuZFmwxs6pt5yJ5YET4u0nxV7TCr61tFfchhcNfzfYBs09pTq7sHUczj06rY8sx
         WYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505308; x=1682097308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bbKg7FyJDOKWJFl4zE5/yQHEnuXb4tsxfmTupEGD00=;
        b=VyrP/Zf5MRgJgW7k3xvxPpmo7QRXobRcI+YK8Sq9zMSqWUKbwp2eY4GnoAyHx3f3Hk
         FbRyxLZWumzl4BEuzPnLodyCKbkmWoJJcLkJRkKsMQ6kQPiR08twB5XIeM3Q57VL4nKO
         7+nQv2z90x6fXfdJl+oTAPLrCBLQqPR4O9Ii+UushlvhsqFnZ3eJaGjHh1gNx3ofhKys
         ADZKeDKygL5Lg4e9ZmBsbEZZ39KZYd5Ddy+0EnDUjs/z75rB/uSC36N5tlqHRC880L/7
         cfUyxDAVxlQ7mxMSzljNGjFaN9kFkorCJfaHjuE7spDzFKxyItMXZxiQza2kk8Bp2xLO
         Vi7A==
X-Gm-Message-State: AO0yUKWsOZxvdcsIoAor5i75FNs4TiaMLjSh/2oUsB4fDr7ylyW4JbGJ
        Y7sDZKHh8+UXN6H0nKC3Ffo=
X-Google-Smtp-Source: AK7set/n+1PLAyZk8FRUplGPssF058bNcofPPkfZ13wToXopvt3mScjLKb8nKzrA/fjJwIShkb8QAg==
X-Received: by 2002:a17:906:10d0:b0:931:4285:ea16 with SMTP id v16-20020a17090610d000b009314285ea16mr7048731ejv.7.1679505308378;
        Wed, 22 Mar 2023 10:15:08 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090680d400b008def483cf79sm7395702ejx.168.2023.03.22.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:07 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:15:06 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] staging: rtl8192e: Replace macro
 INIT_DELAYED_WORK_RSL with standard macro
Message-ID: <61b589012a5efb4b68a76e52eb84ad19093013b3.1679504314.git.philipp.g.hortmann@gmail.com>
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

Replace macro INIT_DELAYED_WORK_RSL with standard macro INIT_DELAYED_WORK
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without “m.”
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 18 ++++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   |  3 +--
 drivers/staging/rtl8192e/rtllib.h            |  2 --
 drivers/staging/rtl8192e/rtllib_softmac.c    | 15 +++++----------
 4 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2ec47c367c5f..a2263c41c6c8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -893,19 +893,13 @@ static void _rtl92e_init_priv_task(struct net_device *dev)
 	INIT_WORK_RSL(&priv->reset_wq, (void *)_rtl92e_restart, dev);
 	INIT_WORK_RSL(&priv->rtllib->ips_leave_wq, (void *)rtl92e_ips_leave_wq,
 		      dev);
-	INIT_DELAYED_WORK_RSL(&priv->watch_dog_wq,
-			      (void *)_rtl92e_watchdog_wq_cb, dev);
-	INIT_DELAYED_WORK_RSL(&priv->txpower_tracking_wq,
-			      (void *)rtl92e_dm_txpower_tracking_wq, dev);
-	INIT_DELAYED_WORK_RSL(&priv->rfpath_check_wq,
-			      (void *)rtl92e_dm_rf_pathcheck_wq, dev);
-	INIT_DELAYED_WORK_RSL(&priv->update_beacon_wq,
-			      (void *)_rtl92e_update_beacon, dev);
+	INIT_DELAYED_WORK(&priv->watch_dog_wq, (void *)_rtl92e_watchdog_wq_cb);
+	INIT_DELAYED_WORK(&priv->txpower_tracking_wq, (void *)rtl92e_dm_txpower_tracking_wq);
+	INIT_DELAYED_WORK(&priv->rfpath_check_wq, (void *)rtl92e_dm_rf_pathcheck_wq);
+	INIT_DELAYED_WORK(&priv->update_beacon_wq, (void *)_rtl92e_update_beacon);
 	INIT_WORK_RSL(&priv->qos_activate, (void *)_rtl92e_qos_activate, dev);
-	INIT_DELAYED_WORK_RSL(&priv->rtllib->hw_wakeup_wq,
-			      (void *)rtl92e_hw_wakeup_wq, dev);
-	INIT_DELAYED_WORK_RSL(&priv->rtllib->hw_sleep_wq,
-			      (void *)rtl92e_hw_sleep_wq, dev);
+	INIT_DELAYED_WORK(&priv->rtllib->hw_wakeup_wq, (void *)rtl92e_hw_wakeup_wq);
+	INIT_DELAYED_WORK(&priv->rtllib->hw_sleep_wq, (void *)rtl92e_hw_sleep_wq);
 	tasklet_setup(&priv->irq_rx_tasklet, _rtl92e_irq_rx_tasklet);
 	tasklet_setup(&priv->irq_tx_tasklet, _rtl92e_irq_tx_tasklet);
 	tasklet_setup(&priv->irq_prepare_beacon_tasklet,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index eb54f8cbee76..b745b73eedea 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -217,8 +217,7 @@ void rtl92e_dm_init(struct net_device *dev)
 	if (IS_HARDWARE_TYPE_8192SE(dev))
 		_rtl92e_dm_init_wa_broadcom_iot(dev);
 
-	INIT_DELAYED_WORK_RSL(&priv->gpio_change_rf_wq,
-			      (void *)_rtl92e_dm_check_rf_ctrl_gpio, dev);
+	INIT_DELAYED_WORK(&priv->gpio_change_rf_wq, (void *)_rtl92e_dm_check_rf_ctrl_gpio);
 }
 
 void rtl92e_dm_deinit(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8965bb605eaa..8cbefa6dfd6e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,8 +62,6 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define INIT_DELAYED_WORK_RSL(x, y, z) INIT_DELAYED_WORK(x, y)
-
 #define INIT_WORK_RSL(x, y, z) INIT_WORK(x, y)
 
 #define container_of_work_rsl(x, y, z) container_of(x, y, z)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 4923423aa85b..c442fc98283d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2996,18 +2996,13 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	timer_setup(&ieee->beacon_timer, rtllib_send_beacon_cb, 0);
 
-	INIT_DELAYED_WORK_RSL(&ieee->link_change_wq,
-			      (void *)rtllib_link_change_wq, ieee);
-	INIT_DELAYED_WORK_RSL(&ieee->start_ibss_wq,
-			      (void *)rtllib_start_ibss_wq, ieee);
+	INIT_DELAYED_WORK(&ieee->link_change_wq, (void *)rtllib_link_change_wq);
+	INIT_DELAYED_WORK(&ieee->start_ibss_wq, (void *)rtllib_start_ibss_wq);
 	INIT_WORK_RSL(&ieee->associate_complete_wq,
 		      (void *)rtllib_associate_complete_wq, ieee);
-	INIT_DELAYED_WORK_RSL(&ieee->associate_procedure_wq,
-			      (void *)rtllib_associate_procedure_wq, ieee);
-	INIT_DELAYED_WORK_RSL(&ieee->softmac_scan_wq,
-			      (void *)rtllib_softmac_scan_wq, ieee);
-	INIT_DELAYED_WORK_RSL(&ieee->associate_retry_wq,
-			      (void *)rtllib_associate_retry_wq, ieee);
+	INIT_DELAYED_WORK(&ieee->associate_procedure_wq, (void *)rtllib_associate_procedure_wq);
+	INIT_DELAYED_WORK(&ieee->softmac_scan_wq, (void *)rtllib_softmac_scan_wq);
+	INIT_DELAYED_WORK(&ieee->associate_retry_wq, (void *)rtllib_associate_retry_wq);
 	INIT_WORK_RSL(&ieee->wx_sync_scan_wq, (void *)rtllib_wx_sync_scan_wq,
 		      ieee);
 
-- 
2.39.2

