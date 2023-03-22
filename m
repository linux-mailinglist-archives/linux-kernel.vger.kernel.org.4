Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978316C5202
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCVRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCVRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBDE64AB8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so75948278edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505315; x=1682097315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JECvJ/K7E4yzQQFzJdiJ4lI6M7UJm3etUVtp/7RJfO0=;
        b=RaG65SripXOXd4P3RbaRyrmMRcCS9zYqhLN6j/FlAQWC1wRroz9Ff/XrT553zzAXlD
         7LA6vkW0tDf7AQCHomMUHYm4LS6Do6sLr+AI/00gYo1mxPFFdyFVMgpG/InrtmjAVrlI
         r70mGV+LG3qkAcPAzEuE4AuEYOrKOKLXXvoBW5+YgkbY8/6Nhj8yOpK274zlL03E9HKe
         FSt+0xQDGlhF4YUmR0MFm7vgy/OUGs9QJ6VQsJjjPgUC1ydjxfj2CHhTJ+yJIrkOSg4P
         XqkA/j7jPZxlnlDUlbMrjz3yVJ7NIRmJKVN/qVHZHYbc5Cvr14wO5t4gVtVc9lMR5TtQ
         +Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505315; x=1682097315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JECvJ/K7E4yzQQFzJdiJ4lI6M7UJm3etUVtp/7RJfO0=;
        b=H6A19GcCqfWE2+lvrpZzScQzP7vdd2NoYQ5nJPrHFnza59MdqfoSwKRGBuIhjL/rIl
         C/K6GSKZS3j/yO3vKnH8qUXNfkoWKrgjPa8ZMG8sC13Yjo3HvsRgCMj/F085bovHhFTH
         cws460Ek6CmX2BYHbDvHljaAQh4CIl1TSiDcp4TxeiDvIAYX7/OPKaZenTkQEkjwyc4S
         9G15jmjHXD1tdLC1OZ6lEVuUPG67xO+OKd9+uiV1NnicqOVpI7zeqjnborlKh4ag8ioc
         Jxry2tH/NmtsYRsQUhWwdqYpKZU7Q1lobFE8wbI0n0bnCrfdlGXZiovMQxmhW5ZFxsPa
         0wmQ==
X-Gm-Message-State: AO0yUKW1X+FvnchapczJ4KZ64CK7I2gVplKAWx8em0ro9Gs6yfJg/Ppn
        79/8hIoi0F08OkyDc/7l2xTwCN94jVk=
X-Google-Smtp-Source: AK7set8ffGT/kzRNoSw203vZvPePb4caVvJ5GhXeIIkpX3RqcxMuKVYvyHUI+Lr8bYt8bpsU8IKhgA==
X-Received: by 2002:a17:906:100a:b0:933:fa42:7e36 with SMTP id 10-20020a170906100a00b00933fa427e36mr6543719ejm.5.1679505314948;
        Wed, 22 Mar 2023 10:15:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y70-20020a50bb4c000000b004fa380a14e7sm8109199ede.77.2023.03.22.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:14 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:15:12 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] staging: rtl8192e: Replace macro INIT_WORK_RSL with
 standard macro
Message-ID: <71879ccda54d57078f47c70cdba90ae2234adc91.1679504314.git.philipp.g.hortmann@gmail.com>
References: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Replace macro INIT_WORK_RSL with standard macro INIT_WORK to increase
readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +++----
 drivers/staging/rtl8192e/rtllib.h            | 2 --
 drivers/staging/rtl8192e/rtllib_softmac.c    | 6 ++----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a2263c41c6c8..ea07b350b62a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -890,14 +890,13 @@ static void _rtl92e_init_priv_task(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	INIT_WORK_RSL(&priv->reset_wq, (void *)_rtl92e_restart, dev);
-	INIT_WORK_RSL(&priv->rtllib->ips_leave_wq, (void *)rtl92e_ips_leave_wq,
-		      dev);
+	INIT_WORK(&priv->reset_wq, (void *)_rtl92e_restart);
+	INIT_WORK(&priv->rtllib->ips_leave_wq, (void *)rtl92e_ips_leave_wq);
 	INIT_DELAYED_WORK(&priv->watch_dog_wq, (void *)_rtl92e_watchdog_wq_cb);
 	INIT_DELAYED_WORK(&priv->txpower_tracking_wq, (void *)rtl92e_dm_txpower_tracking_wq);
 	INIT_DELAYED_WORK(&priv->rfpath_check_wq, (void *)rtl92e_dm_rf_pathcheck_wq);
 	INIT_DELAYED_WORK(&priv->update_beacon_wq, (void *)_rtl92e_update_beacon);
-	INIT_WORK_RSL(&priv->qos_activate, (void *)_rtl92e_qos_activate, dev);
+	INIT_WORK(&priv->qos_activate, (void *)_rtl92e_qos_activate);
 	INIT_DELAYED_WORK(&priv->rtllib->hw_wakeup_wq, (void *)rtl92e_hw_wakeup_wq);
 	INIT_DELAYED_WORK(&priv->rtllib->hw_sleep_wq, (void *)rtl92e_hw_sleep_wq);
 	tasklet_setup(&priv->irq_rx_tasklet, _rtl92e_irq_rx_tasklet);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8cbefa6dfd6e..aa39f8b2bf09 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,8 +62,6 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define INIT_WORK_RSL(x, y, z) INIT_WORK(x, y)
-
 #define container_of_work_rsl(x, y, z) container_of(x, y, z)
 #define container_of_dwork_rsl(x, y, z)				\
 	container_of(to_delayed_work(x), y, z)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c442fc98283d..91fb5f150a00 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2998,13 +2998,11 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	INIT_DELAYED_WORK(&ieee->link_change_wq, (void *)rtllib_link_change_wq);
 	INIT_DELAYED_WORK(&ieee->start_ibss_wq, (void *)rtllib_start_ibss_wq);
-	INIT_WORK_RSL(&ieee->associate_complete_wq,
-		      (void *)rtllib_associate_complete_wq, ieee);
+	INIT_WORK(&ieee->associate_complete_wq, (void *)rtllib_associate_complete_wq);
 	INIT_DELAYED_WORK(&ieee->associate_procedure_wq, (void *)rtllib_associate_procedure_wq);
 	INIT_DELAYED_WORK(&ieee->softmac_scan_wq, (void *)rtllib_softmac_scan_wq);
 	INIT_DELAYED_WORK(&ieee->associate_retry_wq, (void *)rtllib_associate_retry_wq);
-	INIT_WORK_RSL(&ieee->wx_sync_scan_wq, (void *)rtllib_wx_sync_scan_wq,
-		      ieee);
+	INIT_WORK(&ieee->wx_sync_scan_wq, (void *)rtllib_wx_sync_scan_wq);
 
 	mutex_init(&ieee->wx_mutex);
 	mutex_init(&ieee->scan_mutex);
-- 
2.39.2

