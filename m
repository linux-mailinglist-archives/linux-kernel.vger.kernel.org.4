Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A48627173
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiKMSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiKMSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:07:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89E11455
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id i10so14731287ejg.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9rY57aH7I24rE4lreigisIrtzpJlcbzkFokeDM/SUE=;
        b=pFemdqI3NCKH94vulxhf/vdZTI0Gvuta3r5dUkx3e55XLXOzWd/aFw+aDTHduuYbna
         D7BGe6sBzXKmd4iwIKdux2WoUg1Bjq9ernlR9knxV8NDbuNhKOxanKETi3KFW0n47gKn
         MUH2G9SO+q0qZQES6vIbNXsL61weGlblneq9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9rY57aH7I24rE4lreigisIrtzpJlcbzkFokeDM/SUE=;
        b=Ct6tNd+X+vii/Y8y5wWYJMTwXdoiSSO2oHm0GdzswtidrM/6HJ7AbLZ888D0k2ZvWL
         nBT7TCTdLPK5PX8thBYLuGpGaRuhkHh2gA+kw9/m5ZvGlfKooSJOHRilgCLVLEuMFth6
         T0CsDoUi3+aV7Ay0ZazKkfrWPHHX+fVzlnmzEpIbzDgetojP7Xjv/anB1b0mbUvUTXgz
         Hmh8moSsGVqDBWqF15V7C030rz9a1Q41aF6yIZBtMZKc3Vyiu8pj3tGPx+C1XDzTCmEl
         IE2PKasPW16JuPK4fp0UUivl1BQWS1OIbga7sJR3PZCwypeECxq1TMcelgRh6KWSkIFm
         g8DA==
X-Gm-Message-State: ANoB5pndmmMdI8crTlrRzo/A39VSSEB3IcOmkWAVIQSJdysdNv+wGsYY
        9MdfrNqgQ3zFrqgtpRs5xj1VwjCq25u8GA==
X-Google-Smtp-Source: AA0mqf7vU9UIfEsVBc/Fj5hCTFltlolOM4D2/M7vGpRB1YWsvBd/7QuxskC3Up4KGH3U5JiK9ZUd1A==
X-Received: by 2002:a17:907:9d03:b0:7ae:87ef:d9a6 with SMTP id kt3-20020a1709079d0300b007ae87efd9a6mr8139536ejc.397.1668362839685;
        Sun, 13 Nov 2022 10:07:19 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b007a8de84ce36sm3171058eja.206.2022.11.13.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:07:19 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/5] clk: imx: replace osc_hdmi with dummy
Date:   Sun, 13 Nov 2022 19:07:07 +0100
Message-Id: <20221113180710.1625410-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
References: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no occurrence of the hdmi oscillator in the reference manual
(document IMX8MNRM Rev 2, 07/2022). Further, if we consider the indexes
76-81 and 134 of the "Clock Root" table of chapter 5 of the RM, there is
no entry for the source select bits 101b, which is the setting referenced
by "osc_hdmi".
Fix by renaming "osc_hdmi" with "dummy", a clock which has already been
used for missing source select bits.

Tested on the BSH SystemMaster (SMM) S2 board.

Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mn.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 72f9563a0ff6..0fae97e61e2c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -108,27 +108,27 @@ static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll1_out
 						      "sys_pll3_out", "clk_ext4", };
 
 static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						  "video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						  "video_pll1_out", "sys_pll1_133m", "dummy",
 						  "clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
-- 
2.32.0

