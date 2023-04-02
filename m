Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E26D36BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDBJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjDBJwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:52:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751C6194
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:51:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so106294995edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680429110; x=1683021110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhiswCrusaKP4BJlZZJCPIbuTKVOmwuOxikLoZ9ebT0=;
        b=pAE7/h5VEeQ5yCr9LFJXyKFTAjLmOFfZTgw2MbmHa/BqqOSJ/flZdLHPdhivywjXaD
         fQvvJTywVJ3bv35d9VVrrYKrSc3OGhbaUb7j5r5UnYJukiB6vKNxrcmhR33FQAbm0iRU
         CihNxtBKhjVxHPN4jBCEgC5aIszRgj3kzAxKyeaY9r741RcWqCM6CRepPB1maZ14khB6
         xIKGivfX2Cza9Zh0Abg3QtByp9AtrT/h8Gl4sfA6M2Ktoe2LCbvcvYCo/7XR2TYGHcu7
         z8x8ZFa4E3I8ScwtRYe9DDA75xcDTmJrXJotnONyGso/2uiqVoJb1Fq/Dew7KlOLXNIv
         +Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429110; x=1683021110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhiswCrusaKP4BJlZZJCPIbuTKVOmwuOxikLoZ9ebT0=;
        b=1J3yLY7+NTKyva/EAsTWl8wa8Ak8WrzHUYivVQSfQJ510kqZsMQ7wcJNn+PlKXmfnI
         DOWaSguqoHdHOpGe6XOAOnMwcbKgu3weYFjnb8/u+O7JjXmTwKf37OzT+kZ+hFiU42UQ
         p3/WizpoHTitA9uVrgRLfWkAZy6YTRns8M6J2JBruLswrqmh0fWjzkH/woEiNFymgDo5
         7dL0ybjb0SvbG6KSJhBVcX8oYUFFqEryOnV0eva8/7ecmL5roBKTZV2YFETZIMALuZYy
         mUYJXX7+KDQI+icZU3PPj7yqpwduzaXSjEXs9uTeHH1yqYuLb4tnstpbKg53f3FD54E7
         Tv3w==
X-Gm-Message-State: AAQBX9dGic1Bam9RQDEReTNTSlovynic1wKAG+LSv3vJDdXoHcW6r8SC
        f7x0YKubC7V5Dfxe/FPuXjMPr6/uVxQ=
X-Google-Smtp-Source: AKy350Zrp6xqBdqtbKE/2s4DU2frd4df2TjoeQmOQNCXtBFD2YZboGFXVrBCC7e+4J2qhhlLyTajHQ==
X-Received: by 2002:a17:906:49:b0:930:aa02:f9cf with SMTP id 9-20020a170906004900b00930aa02f9cfmr10039192ejg.2.1680429109889;
        Sun, 02 Apr 2023 02:51:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709060b1900b0093e39b921c8sm3021008ejg.164.2023.04.02.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 02:51:49 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:51:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] staging: rtl8192e: Remove enum RF_1T2R and RF_Type
Message-ID: <6c29e709f5c328703870ca8e7d61ee6338886fa7.1680427945.git.philipp.g.hortmann@gmail.com>
References: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum RF_1T2R is used to initialize a local variable RF_Type that is then
shifted. The result of the shift is zero. Remove code that has always
the same result to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Removed declaration of local variable
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 5 ++---
 drivers/staging/rtl8192e/rtllib.h          | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 258ea66ab2fd..a21b3798db48 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -518,7 +518,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	struct dcmd_txcmd tx_cmd;
 	u8	powerlevelOFDM24G;
 	int	i = 0, j = 0, k = 0;
-	u8	RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
+	u8	tmp_report[5] = {0, 0, 0, 0, 0};
 	u32	Value;
 	u8	Pwr_Flag;
 	u16	Avg_TSSI_Meas, tssi_13dBm, Avg_TSSI_Meas_from_driver = 0;
@@ -529,8 +529,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	priv->rtllib->bdynamic_txpower_enable = false;
 
 	powerlevelOFDM24G = priv->pwr_track >> 24;
-	RF_Type = RF_1T2R;
-	Value = (RF_Type<<8) | powerlevelOFDM24G;
+	Value = powerlevelOFDM24G;
 
 	for (j = 0; j <= 30; j++) {
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 197c0a44ebd6..7d83a4c322cf 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -433,10 +433,6 @@ enum led_ctl_mode {
 	LED_CTL_START_TO_LINK = 8,
 };
 
-enum rt_rf_type_def {
-	RF_1T2R = 0,
-};
-
 enum wireless_mode {
 	WIRELESS_MODE_UNKNOWN = 0x00,
 	WIRELESS_MODE_A = 0x01,
-- 
2.40.0

