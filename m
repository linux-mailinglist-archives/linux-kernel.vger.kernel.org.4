Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23467BC46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbjAYUKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbjAYUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED75AA6C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q10so1265856wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDxe4oIJJSUOqPRwp3G0IGOgJo50hIDpNvcK0HbcW+I=;
        b=qAtHh3HwGlWTIavwZBR9eHLTvK0r//m0TwA4Wf7MIK+sqNyRDS3PBTtmyYxSdDSyAz
         0wCiETk9qiVzPJvSFoDDOueI0oJhHGQ5Lqa6G+DLURT6rn7UocCXrK2Pp5gYfhFFpOQc
         Nnc21ecuBb/maD0nI2yjRXyHfVHCjFXU8sIq6WkU7w4r7e50X5c+27sGqh91QyW44z7N
         qp5wDQqjntoRCjZ32ps2I21XkincXo2a7MgfTnSvvptA0UynoKz/F4ohixYTn9jQWKr3
         3BgCXgoqm+RkgjaTMCe9F2TMhzCHvkOZd8F6RsN5TL5HBO2tckVNf6KlnSQsjQb7/MVv
         ylxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDxe4oIJJSUOqPRwp3G0IGOgJo50hIDpNvcK0HbcW+I=;
        b=bqyNKzdnxHK1BiNOCUVrmYg1X6JhYhdW2mnMiHu+sepySAx0gwPKcwP3cxXC6CtVwf
         +B9Vt3f72vUYWNbj33NVzUa8JOjJITeChKS5BSsWPCc2DlJlQtFYa370+7EF8ODIxBqX
         krx6BwBpfmrLIiSNrf0m8kU1KBu6lIT6kIx1Gj/tBy8wVrOjoyrunMycZTJFIjRWivSE
         mEAeQZ6DEy50zT+MyunKCPzmQuddwvT2wcfM13Wzbfc+VoJqfQvau1KJRF2SqPU+L1J/
         HNt5Ez1hXd7OggNimgezIRiotaZotl6Fh/x7VuaOFJQn9+N6DTclXK+bHrvuhOb6gL58
         F49Q==
X-Gm-Message-State: AO0yUKWQ2leQzaMDYzP4J5lS+vD3CT1kKmccTPQww/kN0vFo1ddwMyKy
        qxx2aCQ08uXynA487f3Ar3M=
X-Google-Smtp-Source: AK7set+gKyL1/EbwngB0SCDE5eQm9o64IfenrGX4+jjBe5iXQY2tEPg5qF3+P6yRQEdKGjIvZeijFg==
X-Received: by 2002:adf:e3d0:0:b0:2bf:b41c:61de with SMTP id k16-20020adfe3d0000000b002bfb41c61demr1049378wrm.4.1674677368768;
        Wed, 25 Jan 2023 12:09:28 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id f5-20020adffcc5000000b002bfae3f6802sm5124513wrs.58.2023.01.25.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:28 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:09:26 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] staging: rtl8192e: Remove unused variables
 txbeac.., txman.. and txcmdp..
Message-ID: <6c922591c48512692f77729ac91849ebb4e61bd1.1674675808.git.philipp.g.hortmann@gmail.com>
References: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

txbeaconerr, txmanageokint and txcmdpktokint are initialized and increased
but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 +-------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4cc90425fa4c..2c5edda74e73 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2139,11 +2139,7 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		goto done;
 	}
 
-	if (inta & IMR_TBDER)
-		priv->stats.txbeaconerr++;
-
 	if (inta  & IMR_MGNTDOK) {
-		priv->stats.txmanageokint++;
 		_rtl92e_tx_isr(dev, MGNT_QUEUE);
 		spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 		if (priv->rtllib->ack_tx_to_ieee) {
@@ -2155,10 +2151,8 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		spin_lock_irqsave(&priv->irq_th_lock, flags);
 	}
 
-	if (inta & IMR_COMDOK) {
-		priv->stats.txcmdpktokint++;
+	if (inta & IMR_COMDOK)
 		_rtl92e_tx_isr(dev, TXCMD_QUEUE);
-	}
 
 	if (inta & IMR_HIGHDOK)
 		_rtl92e_tx_isr(dev, HIGH_QUEUE);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index f8b2201ea288..c6a4ac6ce959 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long txbeaconerr;
-	unsigned long txmanageokint;
-	unsigned long txcmdpktokint;
 	unsigned long txbytesmulticast;
 	unsigned long txbytesbroadcast;
 	unsigned long txbytesunicast;
-- 
2.39.1

