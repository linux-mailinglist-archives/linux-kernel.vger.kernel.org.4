Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C685B3F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiIITWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiIITWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:22:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81396C6CFE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:22:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dv25so6201948ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=NHzRLjfMh6T5QNVR72/cJx1E3THkZEuucEB860YC2rk=;
        b=fLFeRWtuOCZ4VVOreB05d81zTeQOmUmJnDIQml9I41PlX4NdSyoQU+q8dGWuya+LXj
         EatykCB1N9JOtS5UL6rOICj/mb48T1D6Q4JREmfZqD+AAeksjDnQnGzYdtEGo1gJ/0CO
         R3l6wO4SJAQp5kiLeek/452xQwEa5oP6nhOnRJnCFkdK3Uq8qJjzKDZooFmc1QB5kRir
         yZZ/AjAc6Cf1Oo04KjN6TG1cV793DLnINipGhkQ5sY7A64Zp3Phlypwc3OaxHuY1v9X6
         UDCvqpK2JwzQtB26w0UQKJB8bN2SSsmIgfaZyTYNKAjBnrtu/Jb+dKC9FDWqd00JTVDc
         EojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NHzRLjfMh6T5QNVR72/cJx1E3THkZEuucEB860YC2rk=;
        b=YHZuDIRtsjkQxws5wXW4MbI4+VkVLcoByDKze9rQtRkM6JK+l06Lrg0DVqPqjg4pGh
         2MCm1yN7kKX5UH0IWloM6EUiU6OkE+oEFeDIr8SKuYGHIEtSMjkv8cOXO2vXaJh5LadO
         yvBo4ik29uwVviIuDli+LTa/KivzPRBIHAhf1ARZdqZO2d8bVPAbHZLfk8ZiUJAsOdD6
         H+wHeYQXTCSlZsvk45fPowERf/eEimtDVhNMB0e1WEHSF8RDYdICbgthp/9JbAu/wMa5
         He104cwmx8ClN0xEDmojcL1pprGU9DDxGn8deCCBhkZOGJC1UL5pGOm7ZqrL02eqtJ9v
         stzg==
X-Gm-Message-State: ACgBeo2RUUJqWapw/qk+Reu+HrZB4jOmP6Jqoxqfh35mFwOjht+W50C6
        8qdgq38MIRBazHwsvmVu/RqzmQpGPrw=
X-Google-Smtp-Source: AA6agR58ibYy1rPSMeVgqVcl2PX3QYvHRWkPwuHuu5vcjsbZ1I7Ns/p3hQ0cs8ENioy11N0FjnjMkw==
X-Received: by 2002:a17:907:2e0d:b0:741:a3ec:7f92 with SMTP id ig13-20020a1709072e0d00b00741a3ec7f92mr10786882ejc.309.1662751320329;
        Fri, 09 Sep 2022 12:22:00 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090669c700b0077a11b79b9bsm637844ejs.133.2022.09.09.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:22:00 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:21:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8192e: Rename RFChangeInProgress
Message-ID: <29739986e76750395941ddaa6c4f0ffab6eb26a9.1662402870.git.philipp.g.hortmann@gmail.com>
References: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable RFChangeInProgress to rf_change_in_progress to avoid
CamelCase which is not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 24 ++++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ee3d0f243463..e7aacccfa37e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -145,10 +145,10 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 	while (true) {
 		spin_lock_irqsave(&priv->rf_ps_lock, flag);
-		if (priv->RFChangeInProgress) {
+		if (priv->rf_change_in_progress) {
 			spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 
-			while (priv->RFChangeInProgress) {
+			while (priv->rf_change_in_progress) {
 				rf_wait_counter++;
 				mdelay(1);
 
@@ -160,7 +160,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 				}
 			}
 		} else {
-			priv->RFChangeInProgress = true;
+			priv->rf_change_in_progress = true;
 			spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 			break;
 		}
@@ -226,7 +226,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	}
 
 	spin_lock_irqsave(&priv->rf_ps_lock, flag);
-	priv->RFChangeInProgress = false;
+	priv->rf_change_in_progress = false;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 	return action_allowed;
 }
@@ -755,7 +755,7 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 
 	rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
 	spin_lock_irqsave(&priv->rf_ps_lock, flags);
-	while (priv->RFChangeInProgress) {
+	while (priv->rf_change_in_progress) {
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
 		if (RFInProgressTimeOut > 100) {
 			spin_lock_irqsave(&priv->rf_ps_lock, flags);
@@ -765,11 +765,11 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 		RFInProgressTimeOut++;
 		spin_lock_irqsave(&priv->rf_ps_lock, flags);
 	}
-	priv->RFChangeInProgress = true;
+	priv->rf_change_in_progress = true;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
 	priv->ops->stop_adapter(dev, false);
 	spin_lock_irqsave(&priv->rf_ps_lock, flags);
-	priv->RFChangeInProgress = false;
+	priv->rf_change_in_progress = false;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
 	udelay(100);
 	memset(&priv->rtllib->current_network, 0,
@@ -883,7 +883,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->isRFOff = false;
 	priv->bInPowerSaveMode = false;
 	priv->rtllib->RfOffReason = 0;
-	priv->RFChangeInProgress = false;
+	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
 	priv->SetRFPowerStateInProgress = false;
 	priv->rtllib->PowerSaveControl.bInactivePs = true;
@@ -1151,11 +1151,11 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		priv->ResetProgress = RESET_TYPE_SILENT;
 
 		spin_lock_irqsave(&priv->rf_ps_lock, flag);
-		if (priv->RFChangeInProgress) {
+		if (priv->rf_change_in_progress) {
 			spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 			goto END;
 		}
-		priv->RFChangeInProgress = true;
+		priv->rf_change_in_progress = true;
 		priv->bResetInProgress = true;
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 
@@ -1217,7 +1217,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		ieee->is_silent_reset = 1;
 
 		spin_lock_irqsave(&priv->rf_ps_lock, flag);
-		priv->RFChangeInProgress = false;
+		priv->rf_change_in_progress = false;
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 
 		rtl92e_enable_hw_security_config(dev);
@@ -1403,7 +1403,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
 	if ((check_reset_cnt++ >= 3) && (!ieee->is_roaming) &&
-	    (!priv->RFChangeInProgress) && (!pPSC->bSwRfProcessing)) {
+	    (!priv->rf_change_in_progress) && (!pPSC->bSwRfProcessing)) {
 		ResetType = _rtl92e_if_check_reset(dev);
 		check_reset_cnt = 3;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 7dee40481087..e851f2471288 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -478,7 +478,7 @@ struct r8192_priv {
 	bool bInPowerSaveMode;
 	u8 bHwRfOffAction;
 
-	bool RFChangeInProgress;
+	bool rf_change_in_progress;
 	bool SetRFPowerStateInProgress;
 	bool bdisable_nic;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 3333ce3e88a8..966debd99296 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -21,7 +21,7 @@ static void _rtl92e_hw_sleep(struct net_device *dev)
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&priv->rf_ps_lock, flags);
-	if (priv->RFChangeInProgress) {
+	if (priv->rf_change_in_progress) {
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
 		RT_TRACE(COMP_DBG,
 			 "%s(): RF Change in progress!\n", __func__);
@@ -48,7 +48,7 @@ void rtl92e_hw_wakeup(struct net_device *dev)
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&priv->rf_ps_lock, flags);
-	if (priv->RFChangeInProgress) {
+	if (priv->rf_change_in_progress) {
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
 		RT_TRACE(COMP_DBG,
 			 "%s(): RF Change in progress!\n", __func__);
-- 
2.37.2

