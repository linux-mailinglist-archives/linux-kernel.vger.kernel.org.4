Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB36728E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjARUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjARUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:00:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E0759B40
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:00:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so2208418wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93TSWSfcAvhzEd5s0QeYy7VAbNnlQKb4h0RKMKN4xLE=;
        b=PuJuqo/QtMPy6MvZLbhebn3A9HxGuzjBWisUUiuUu8rV3A7SKMGi65pv0/PeNlhpDt
         mdR53A4E54oolcA4m6jsoCVnkudF2xqgB12EPnU4hE+ApueUjaaNZN/cwP0J6o53bcP0
         NFciYZFdGW5tz82/qcNWunQtXZ/FdkIX74MwuCXjSSlPUFZxk/W2iUkFN4CgD7NUf1mS
         36IwszhOOf/E5Rm1ndHRUKyIsN5RRrRvPGaHf+QwV68DlpT7vuhWNpDOMkOZi0k833Op
         LyerFw2H04gLpOh6U0J2HF+wSqB3sBMDi6v5vXCHQrNzGZuqAICyVf7SR0WrN28p72nW
         T2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93TSWSfcAvhzEd5s0QeYy7VAbNnlQKb4h0RKMKN4xLE=;
        b=S9GFmgMJlIuvczpmTeho210ULoIGngfD72tZsM1dr0+ebY3jL2DrkrGqU4xGLiMbrF
         sAPvpKLGsWT/9excstGi//4f5mouyK/pMiaJ6JLzzwDjrXII7h3HOCTTXm9hCPXiCw5K
         N5Bny4tZXq+4qxsyoKWKewdyKw1u5nkMVpxr/FOpJzsnRLkffalF+Xxd9szVkPLCwfc9
         kqw79XWZkU30L5/ctTSXb9KfyWVs4+AbbAE0yuYGvCHxZ3kPvGk7uf0qi7lH2bVQ07FI
         iyR7XyQr8dCc6aGOJ8xF3ZUoYCLbuztCexyToXR3zm23xyjvLgaajkeXCUP2zDtaKPQe
         qegg==
X-Gm-Message-State: AFqh2kqVDnzCl/jiKOdfCG1zQ3Vxr7RW5wTSPClFiX/5ZoLIfRnk2HiR
        6X54Nt1Z6FOpOfIjJt1cdHo=
X-Google-Smtp-Source: AMrXdXtjYHLQ93dpaCEfO1nFbqO2oLpBJYE4JwjyQjzUfFFMQwfQUBYsVA0j7Vl+/P8BUyeobzooCQ==
X-Received: by 2002:a05:600c:3b06:b0:3d3:446a:b493 with SMTP id m6-20020a05600c3b0600b003d3446ab493mr2146003wms.4.1674072009873;
        Wed, 18 Jan 2023 12:00:09 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id j35-20020a05600c1c2300b003c71358a42dsm3903876wms.18.2023.01.18.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:00:09 -0800 (PST)
Date:   Wed, 18 Jan 2023 21:00:07 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] staging: rtl8192e: Remove unused variable RF_C_TxPwDiff
Message-ID: <bcace15cc05057ab310f807f27619ef6ff391d91.1674071236.git.philipp.g.hortmann@gmail.com>
References: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RF_C_TxPwDiff is set to a value and then never evaluated. Remove resulting
dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index aafe39e50bd9..ff66a97b8763 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -603,8 +603,6 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 			ant_pwr_diff = priv->tx_pwr_level_ofdm_24g_c[channel - 1]
 				       - priv->tx_pwr_level_ofdm_24g_a[channel - 1];
 
-			priv->RF_C_TxPwDiff = ant_pwr_diff;
-
 			ant_pwr_diff &= 0xf;
 
 			priv->antenna_tx_pwr_diff[2] = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 12a869a556bb..6662558e56fa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -476,7 +476,6 @@ struct r8192_priv {
 	u8 tx_pwr_level_ofdm_24g_a[14];
 	u8 tx_pwr_level_ofdm_24g_c[14];
 	u8 legacy_ht_tx_pwr_diff;
-	s8		RF_C_TxPwDiff;
 	u8 antenna_tx_pwr_diff[3];
 
 	bool		dynamic_tx_high_pwr;
-- 
2.39.0

