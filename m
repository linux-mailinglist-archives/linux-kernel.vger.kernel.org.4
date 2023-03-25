Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870B46C8CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjCYIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjCYIh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB018ABB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:37:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er18so5300455edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovOf0VQJbLs8pFVaHE8+gPaOdY/j18U17OR+um3GAwM=;
        b=dtQWgKIFC5MVE5WHj/tkEOoErziyY01JN1J46VXEddJz7PS+S2DBEEJSsOJ/CaTaIW
         sY19/NJH1J6atOsJs00RnHMIbUPAQlV4QpY+Fr3RkbZTyk9bu+Bz1I/NHmSr6stiiAdX
         sZRfkZIMnBMkYFz+WRi44hPFbO5NybGwdxBfVi1OzgF6QgiC/xbAF5Wg6/saDleU/J1T
         ZCrMnbBRtrlS3n6sTjbZlRTfHt5s4xanHNvHzo4InganGRiifmbbkthFv12NAC3rH1NF
         0476n8el5jTVEroOMAF4sG/bkTSYGk04kmjY/cvCRRRUTTIF3e6hKKANUKwRmFYT/BHL
         6p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovOf0VQJbLs8pFVaHE8+gPaOdY/j18U17OR+um3GAwM=;
        b=0tcqyOUKr8KgyQw2cYxTRLYHNKKzmeTonubc/hrEmiTUxAS9vqHQmEwYplTnAMPfDB
         FusnT3cXSp33yaQ7dLU+mCiAj45xO1vyDzEazLC4yeEunJQHB6jFhZiFGqIXnVxI0Vai
         6hUJP1X2lo5ygd7fYaTKlpvlDSQ/UMsv6kTl5gSVbNUXYtNl6+o4Ule8ARv9PLzN3B4z
         dKqmsUuWtGxtpknerTyL/RSKdZc95HpdLbtlHc7Tos1cgHhllXMM9xGFliomPk7SpYmQ
         XX8dadvujo/vfXhsvpcPs3Kemdr9hRRdJmLmMcsmf0XHAXKML3SgDFMs6kInJb1AocFP
         l4Ug==
X-Gm-Message-State: AAQBX9dAS5TJstl2foM+d3890qjYVUokYM8TB/UAwXCIjSG9y014ekOA
        Umt15BJTalIC/0whflVQBo8=
X-Google-Smtp-Source: AKy350bxZ93adCN4Rqg7W6VP99P4KcZ0CUV7dovWEAdh+r/CLokTDRThtGLzPtDbZ1Wcl+JFZqg6Ww==
X-Received: by 2002:a05:6402:2811:b0:502:92d:4f51 with SMTP id h17-20020a056402281100b00502092d4f51mr6903412ede.1.1679733432752;
        Sat, 25 Mar 2023 01:37:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm8623229ejb.198.2023.03.25.01.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:37:12 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:37:10 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove priv->rf_chip
Message-ID: <2ce85c1a159ae376d82c19c61e694924f07d1093.1679732276.git.philipp.g.hortmann@gmail.com>
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

priv->rf_chip is initialized to RF_8256 and not used. Remove
initialization, variable and enum as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 10 ----------
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 1e7be321721b..a67927f0c5e3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -432,8 +432,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 	rtl92e_init_adaptive_rate(dev);
 
-	priv->rf_chip = RF_8256;
-
 	if (priv->reg_chnl_plan == 0xf)
 		priv->chnl_plan = priv->eeprom_chnl_plan;
 	else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index c8816c44ca51..68ec0aeb2dd9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -129,15 +129,6 @@ enum dcmg_txcmd_op {
 	TXCMD_XXXX_CTRL,
 };
 
-enum rt_rf_type_819xu {
-	RF_TYPE_MIN = 0,
-	RF_8225,
-	RF_8256,
-	RF_8258,
-	RF_6052 = 4,
-	RF_PSEUDO_11N = 5,
-};
-
 enum rt_customer_id {
 	RT_CID_DEFAULT	  = 0,
 	RT_CID_819x_CAMEO       = 6,
@@ -221,7 +212,6 @@ struct r8192_priv {
 
 	enum rt_customer_id customer_id;
 
-	enum rt_rf_type_819xu rf_chip;
 	enum ht_channel_width current_chnl_bw;
 	struct bb_reg_definition phy_reg_def[4];
 	struct rate_adaptive rate_adaptive;
-- 
2.39.2

