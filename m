Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DC67FFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjA2O64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjA2O6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:58:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECD13D73
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so8903320wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kObtkesHDp3/jvTg21bOv7yEj2AdVjYtEj97EYzt4U=;
        b=nn0+dCEGm10fKkUm78VcoLjWaZpJwjB4bHUDywbWtUJCDHsf9ZMfrZn7txLxgBs9Ya
         YdPXo9SQ+k8eD1CjU27DoAvh2/vmPaoFkA277Qc0y2rg4Ewzsvr5sOk/laThLk4gAxBk
         jym2s4C2NBr4aRrilPO8hRrkt7V3l0UnqccpY4lMoecjNiGraLBAa6+B3m955BcFiqAI
         QBJfndZQBZq96BZofLXKZR/poud2Issp72OvQYWgLBpwbaVfpPy2INosxL1JHX/qWDvA
         lVcEtre89LNAim+itY+jAsdDYWfFftOJXJN7h+Co+1BY2lk8LkhBvpawJ2jsaM+LLZgo
         4NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kObtkesHDp3/jvTg21bOv7yEj2AdVjYtEj97EYzt4U=;
        b=pQWQLkduwJwDPDe/ogwWiTdtL7TcqZsBfE9jmRyx5fBvy9bTV+vm2niKR5GZBudhZk
         zc3iQtcimdvwouBkAQZ/IamkBSjSKLcu8hHfFU9xMxdOpEaWrRGgDsxCzD1w7kRYaFry
         6KhdMs4lY+IedoMbmYj7dpLbJFs+fE3Sb4eKKqNd8CeRrTbro4jA4vxmTUHPHvh7twtx
         yNMBjQv8MF5qsjXeAoV+bxVrdgNc/DeftYUeOYDOaBrxoTjk9mxFxjB5ywVCfyrp+cWH
         HsTeE8GJMmwdZg61iwITiTotMNUPrRM+gvUjjLD7u33uyP8iHA/0rTh+Lmir23SA46/R
         0sdg==
X-Gm-Message-State: AO0yUKUuUTne0c4+w3S00pbtwzJND45ar80NKRtJrIyqPZiRQ7qMt0Kv
        gH6ODVFq7T+1jnfHSuNz9bQ=
X-Google-Smtp-Source: AK7set8AHcPD4BiH1iMgc/5WOn6Ubc4u3IdJ3/2Oux877cLj7U+eeFDQzreKKiVTdpHqUxfPGzC7Tg==
X-Received: by 2002:adf:ba4a:0:b0:2bf:dfd5:98c9 with SMTP id t10-20020adfba4a000000b002bfdfd598c9mr974249wrg.7.1675004312434;
        Sun, 29 Jan 2023 06:58:32 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c2e0400b003dc4ecfc4d7sm3892938wmf.29.2023.01.29.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:31 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:58:30 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Rename BaseBand_Config_PHY_REG and
 BaseBand_Config_AGC_TAB
Message-ID: <6d26690c7c2c68cc7c766c981293bd8e40999ed0.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constants BaseBand_Config_PHY_REG to BB_CONFIG_PHY_REG and
BaseBand_Config_AGC_TAB to BB_CONFIG_AGC_TAB to avoid CamelCase which is
not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 3e223151d4b7..858cfc203f13 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -8,8 +8,8 @@
 #define R8180_HW
 
 enum baseband_config {
-	BaseBand_Config_PHY_REG = 0,
-	BaseBand_Config_AGC_TAB = 1,
+	BB_CONFIG_PHY_REG = 0,
+	BB_CONFIG_AGC_TAB = 1,
 };
 
 #define	RTL8187_REQT_READ	0xc0
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 456b7ca73073..cbda027656dc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -342,13 +342,13 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
 	}
 
-	if (ConfigType == BaseBand_Config_PHY_REG) {
+	if (ConfigType == BB_CONFIG_PHY_REG) {
 		for (i = 0; i < PHY_REGArrayLen; i += 2) {
 			rtl92e_set_bb_reg(dev, Rtl819XPHY_REGArray_Table[i],
 					  bMaskDWord,
 					  Rtl819XPHY_REGArray_Table[i+1]);
 		}
-	} else if (ConfigType == BaseBand_Config_AGC_TAB) {
+	} else if (ConfigType == BB_CONFIG_AGC_TAB) {
 		for (i = 0; i < AGCTAB_ArrayLen; i += 2) {
 			rtl92e_set_bb_reg(dev, Rtl819XAGCTAB_Array_Table[i],
 					  bMaskDWord,
@@ -526,12 +526,12 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 			return rtStatus;
 	}
 	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn|bOFDMEn, 0x0);
-	_rtl92e_phy_config_bb(dev, BaseBand_Config_PHY_REG);
+	_rtl92e_phy_config_bb(dev, BB_CONFIG_PHY_REG);
 
 	dwRegValue = rtl92e_readl(dev, CPU_GEN);
 	rtl92e_writel(dev, CPU_GEN, (dwRegValue|CPU_GEN_BB_RST));
 
-	_rtl92e_phy_config_bb(dev, BaseBand_Config_AGC_TAB);
+	_rtl92e_phy_config_bb(dev, BB_CONFIG_AGC_TAB);
 
 	if (priv->ic_cut  > VERSION_8190_BD) {
 		if (priv->rf_type == RF_2T4R)
-- 
2.39.1

