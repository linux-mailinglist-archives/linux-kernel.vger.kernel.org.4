Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9C6BF186
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCQTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCQTN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:13:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9886BE2539
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so24319459edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080420; x=1681672420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjtT+UNbmknzeDI4lxkQZjhyjKyi9xDEJK9zSTQV6XY=;
        b=jAGZo8mwxVKdF+xe3v5y+QhJ474y5Q/pJ2shxKUgG36alsl4qIuIks5dHvQryKXkWM
         ExJhDDWZ98r9E+SiOrNSHQ53kfnF6EvOxphBJTtvXR0985UZmYWCT2wH1z3Y+/sHXCXC
         fv5tmcxOHuSEE5eI9yTvck52wCl4iFu9SUYrHKBE3sMAofKN1iWBgeZWjV/5yurbDKam
         0JVkfq5Yoxopq5iOO7hxy2EhPrFBX4COqHSOPkvM94pONF7BKZ/TkPx7v43oO/MjnnJF
         FiskofLlvBglTqO3oY0Paxbh7NOdb3G2X3ki4K/tkNYpkNnzqHnzsiUmvjeuuyAJxRuh
         M3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080420; x=1681672420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjtT+UNbmknzeDI4lxkQZjhyjKyi9xDEJK9zSTQV6XY=;
        b=gnWhUDkKrY1e7bS+XyfJMklu/eG/AqnPnOmd4SyAbfKWkxwddwGS5dlIYbLBUhNJQm
         eVBc5rt0QePt3PwMZdjmXSRYQP0U0A1lOPrt7vJ5Nz7PifWwTMbF4nu69bRctD/wA/Ed
         OAdwVAd/oLUEMZiNLLuGj+xV/A/HqAZn/FMrXXAxLOG9vD7X0I0MMNCe0t6fS28GWGcb
         OI+bxnwgM2/6yZqph+yOqtlnznCnwvxQkWuyXiAW2OxQBfJpzn1r1dwb8RxtJ5rEpXMi
         HbOu6VoPK/zMAP61qmeU/AYBm6rR7Csg3aN47i7vx5Dk98mw8LW4csBPvvpyGtD17rHs
         iUvQ==
X-Gm-Message-State: AO0yUKUvzBegIb3Ed3gjBthGJEI0Pj0ieRx4hm+Kl5nl4Oae0VdD9CfZ
        IwqpPo3CKWbtSVBaJT1qh8G1GHiQv0k=
X-Google-Smtp-Source: AK7set+4CamMNh5i/sRBDiEkG6DWBTyR7QOmtJoe37S0VR5OTpsajWWo0sTonwNgqtEISx8ftmEW+A==
X-Received: by 2002:a05:6402:354a:b0:4bc:edde:14e2 with SMTP id f10-20020a056402354a00b004bcedde14e2mr9297287edd.0.1679080420672;
        Fri, 17 Mar 2023 12:13:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709064e1500b00930de1da701sm1305591eju.10.2023.03.17.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:40 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:38 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: rtl8192e: Replace macro INIT_DELAYED_WORK_RSL
 with standard m.
Message-ID: <69b1612c05a0fa0334704eb94d80f771ada6b35c.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro INIT_DELAYED_WORK_RSL with standard macro INIT_DELAYED_WORK
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
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

