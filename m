Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505AD62D98A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiKQLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbiKQLg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:36:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8EC6A748
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n21so4292503ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3uDGf6nFwfo97/RpmImJcIh+Hx1nK4UXLWDjOMYdaw=;
        b=nghdVoejMDXntacsNMzk02oYdAH1coNLAAX6KPeORBPUIb7lccM+HohiaZmwdB2xZ1
         qac0MMxDTK5WP7KQm2UBZo6UIF+7tOl+tJdtpwkKqOY9Usr8o/1zqlliEgeW9s7qCbUz
         VxVHop7EHwDiK1nJknM04XVO07/dBquGZN3fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3uDGf6nFwfo97/RpmImJcIh+Hx1nK4UXLWDjOMYdaw=;
        b=s6+39Ov67En24b07MED3j3SXoHAAEHr2Kh06Fe3Fb1Oqg0JLx3NxLMmJbPS9ntd/D+
         AjPkQesqaJ1foc6XmVmhN4BucvC0x1FqSo06Tgtq8v50GYtmV34y9tt1mCdeIXIXVNvj
         ll3Ahn0A3o1ZqeUEsiJ8h1t5qaYFFcUt+MP3zhIPx05ki+aSi+18aA5CKEW+DDdvRuyQ
         BPOD6Ej31fce9hT2HGdCNFD4wd0Hkiu45CIdcSf4i68QX51CENo66wpPr3ppqaHyuHve
         u/vwdc7QFGNAL6eE+WFQIg43eM0bz+uvYw/4oZaYCbCkZM6ucBuRXPYXZC0DJ6C+3U+V
         asvQ==
X-Gm-Message-State: ANoB5pncNFjD+Wd8BRWcEsSMhCnj76qY11O/ZByzM/L0f0B+xGYVqTeD
        UCmLbzDcmP1e72xKO8UQh/naV9emEor6Uw==
X-Google-Smtp-Source: AA0mqf69VIOyLwRRt2pkjgSAuCU7OJ+nTpFybk4c/13Qw5Eo+FsO7QNm+AvpwZWJ2r8izt+7M0uwTg==
X-Received: by 2002:a17:906:49c2:b0:7aa:23ac:608e with SMTP id w2-20020a17090649c200b007aa23ac608emr1738874ejv.450.1668685015577;
        Thu, 17 Nov 2022 03:36:55 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-137-239.net.vodafone.it. [5.90.137.239])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0043bbb3535d6sm413897edt.66.2022.11.17.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:36:55 -0800 (PST)
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
Subject: [PATCH v2 5/5] clk: imx8mn: fix imx8mn_enet_phy_sels clocks list
Date:   Thu, 17 Nov 2022 12:36:37 +0100
Message-Id: <20221117113637.1978703-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
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

According to the "Clock Root" table of the reference manual (document
IMX8MNRM Rev 2, 07/2022):

     Clock Root         offset     Source Select (CCM_TARGET_ROOTn[MUX])
        ...              ...                    ...
 ENET_PHY_REF_CLK_ROOT  0xAA80            000 - 24M_REF_CLK
                                          001 - SYSTEM_PLL2_DIV20
                                          010 - SYSTEM_PLL2_DIV8
                                          011 - SYSTEM_PLL2_DIV5
                                          100 - SYSTEM_PLL2_DIV2
                                          101 - AUDIO_PLL1_CLK
                                          110 - VIDEO_PLL_CLK
                                          111 - AUDIO_PLL2_CLK
        ...              ...                    ...

while the imx8mn_enet_phy_sels list didn't contained audio_pll1_out for
source select bits 101b.

Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/clk/imx/clk-imx8mn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 37128c35198d..2afea905f7f3 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -140,8 +140,8 @@ static const char * const imx8mn_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m"
 						      "clk_ext4", "video_pll_out", };
 
 static const char * const imx8mn_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
-						    "sys_pll2_200m", "sys_pll2_500m", "video_pll_out",
-						    "audio_pll2_out", };
+						    "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
+						    "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
-- 
2.32.0

