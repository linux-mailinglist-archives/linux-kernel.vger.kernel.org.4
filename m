Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C113627172
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiKMSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiKMSHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:07:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46C10B7C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so23442833eje.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnyf91bipF2JRLTPkhwmHfUpzi0ppPqPGAVM2YEgVXE=;
        b=kaKpU7PgqxEt8NDacUtZi7VC7l/UKh3m7raaccNu8CsTD9DiWqmiJb8eOEvDRVsJ9d
         Vefxg3eF27/ANXXWEqV9II+7wNRVmgHIGDBcdS6Pv9RysjGpqeH0IuN7pxnqnOa4qp01
         P7Qz0serV6fPnrZnnZn2doCLRe4pdbb/9e47k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnyf91bipF2JRLTPkhwmHfUpzi0ppPqPGAVM2YEgVXE=;
        b=z26tc7tuDLkPmymUjAK/PN7Su6q1z2af7VuMsmmvto0Xvs3TidkEJmpvoETQvlh53j
         3xi14s/N3ercup1npmY8YurUI9OkKyjaAI6wtjroti78mxFQtd50ZlAgGLCzLKZa6MOX
         yvyKpn6OJzsNRjgds+ctDbVu8QmHIspTdADDzB81Bdk4bJPCoRM66EkcxnPjnff85XDk
         n9DKMtSDrglxIIMCGNZ6CRhmrHfZg/JO5gPN4OkOysivPnJeXMDFl0tUWHx5iEiAyyVu
         l8E63TpOO6c9xy1WpmgDMJEmQVq9RVHpOsPiy1b25iMJeIuMsJJtYwycSvD7tPx6zw6C
         LSAA==
X-Gm-Message-State: ANoB5pnCL6uH11XkGcme29t/Z/bmy/deFVH5qiOCkd2XTTgqfpl70jcw
        dQ42ZKcbkK/MD32NrLa34QAhGG8178F9Dw==
X-Google-Smtp-Source: AA0mqf491Ex2gRXbIbrX0/pmZBnfg+XEfzg0PIEU25c7wCGc4CPYNmS4QoD7bg1uSw6Yq9tc0TLA6g==
X-Received: by 2002:a17:906:a20c:b0:7ae:27a7:2a66 with SMTP id r12-20020a170906a20c00b007ae27a72a66mr8220123ejy.72.1668362838299;
        Sun, 13 Nov 2022 10:07:18 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b007a8de84ce36sm3171058eja.206.2022.11.13.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:07:17 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/5] clk: imx8mn: rename vpu_pll to m7_alt_pll
Date:   Sun, 13 Nov 2022 19:07:06 +0100
Message-Id: <20221113180710.1625410-2-dario.binacchi@amarulasolutions.com>
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

There is no occurrence of vpu pll in the reference manual (document
IMX8MNRM Rev 2, 07/2022). From an analysis of the code and the RM
itself, I think vpu pll is used instead of m7 alternate pll, probably
for copy and paste of code taken from modules of similar architectures.

As an example for all, if we consider the second row of the "Clock Root"
table of chapter 5 (Clocks and Power Management) of the RM:

     Clock Root     offset     Source Select (CCM_TARGET_ROOTn[MUX])
        ...          ...                    ...
  ARM_M7_CLK_ROOT   0x8080            000 - 24M_REF_CLK
                                      001 - SYSTEM_PLL2_DIV5
				      010 - SYSTEM_PLL2_DIV4
				      011 - M7_ALT_PLL_CLK
				      100 - SYSTEM_PLL1_CLK
				      101 - AUDIO_PLL1_CLK
				      110 - VIDEO_PLL_CLK
				      111 - SYSTEM_PLL3_CLK
        ...          ...                    ...

but in the source code, the imx8mn_m7_sels clocks list contains vpu_pll
for the source select bits 011b.

So, let's rename "vpu_pll" to "m7_alt_pll" to be consistent with the RM.

No functional changes intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++--------
 include/dt-bindings/clock/imx8mn-clock.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index d37c45b676ab..72f9563a0ff6 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -30,7 +30,7 @@ static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_
 static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
-static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
+static const char * const m7_alt_pll_bypass_sels[] = {"m7_alt_pll", "m7_alt_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
 
@@ -40,7 +40,7 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
 
 static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
 
-static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "vpu_pll_out",
+static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "m7_alt_pll_out",
 				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
 
 static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
@@ -252,10 +252,10 @@ static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys
 						"audio_pll1_out", "clk_ext1", };
 
 static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
-						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
+						"m7_alt_pll_out", "sys_pll2_125m", "sys_pll3_out",
 						"sys_pll1_80m", "sys_pll2_166m", };
 
-static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "vpu_pll_out",
+static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "m7_alt_pll_out",
 						 "sys_pll3_out", "sys_pll2_200m", "sys_pll1_266m",
 						 "sys_pll2_500m", "sys_pll1_100m", };
 
@@ -352,7 +352,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx_clk_hw_mux("m7_alt_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
@@ -361,7 +361,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
 	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
 	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
-	hws[IMX8MN_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
+	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
 	hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
 	hws[IMX8MN_SYS_PLL1] = imx_clk_hw_fixed("sys_pll1", 800000000);
 	hws[IMX8MN_SYS_PLL2] = imx_clk_hw_fixed("sys_pll2", 1000000000);
@@ -373,7 +373,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx_clk_hw_mux_flags("m7_alt_pll_bypass", base + 0x74, 28, 1, m7_alt_pll_bypass_sels, ARRAY_SIZE(m7_alt_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MN_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
 
@@ -383,7 +383,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
 	hws[IMX8MN_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
 	hws[IMX8MN_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
-	hws[IMX8MN_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x74, 11);
+	hws[IMX8MN_M7_ALT_PLL_OUT] = imx_clk_hw_gate("m7_alt_pll_out", "m7_alt_pll_bypass", base + 0x74, 11);
 	hws[IMX8MN_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11);
 	hws[IMX8MN_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
 
diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
index 07b8a282c268..f103b008a12a 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -19,7 +19,7 @@
 #define IMX8MN_VIDEO_PLL1_REF_SEL		10
 #define IMX8MN_DRAM_PLL_REF_SEL			11
 #define IMX8MN_GPU_PLL_REF_SEL			12
-#define IMX8MN_VPU_PLL_REF_SEL			13
+#define IMX8MN_M7_ALT_PLL_REF_SEL		13
 #define IMX8MN_ARM_PLL_REF_SEL			14
 #define IMX8MN_SYS_PLL1_REF_SEL			15
 #define IMX8MN_SYS_PLL2_REF_SEL			16
@@ -29,7 +29,7 @@
 #define IMX8MN_VIDEO_PLL1			20
 #define IMX8MN_DRAM_PLL				21
 #define IMX8MN_GPU_PLL				22
-#define IMX8MN_VPU_PLL				23
+#define IMX8MN_M7_ALT_PLL			23
 #define IMX8MN_ARM_PLL				24
 #define IMX8MN_SYS_PLL1				25
 #define IMX8MN_SYS_PLL2				26
@@ -39,7 +39,7 @@
 #define IMX8MN_VIDEO_PLL1_BYPASS		30
 #define IMX8MN_DRAM_PLL_BYPASS			31
 #define IMX8MN_GPU_PLL_BYPASS			32
-#define IMX8MN_VPU_PLL_BYPASS			33
+#define IMX8MN_M7_ALT_PLL_BYPASS		33
 #define IMX8MN_ARM_PLL_BYPASS			34
 #define IMX8MN_SYS_PLL1_BYPASS			35
 #define IMX8MN_SYS_PLL2_BYPASS			36
@@ -49,7 +49,7 @@
 #define IMX8MN_VIDEO_PLL1_OUT			40
 #define IMX8MN_DRAM_PLL_OUT			41
 #define IMX8MN_GPU_PLL_OUT			42
-#define IMX8MN_VPU_PLL_OUT			43
+#define IMX8MN_M7_ALT_PLL_OUT			43
 #define IMX8MN_ARM_PLL_OUT			44
 #define IMX8MN_SYS_PLL1_OUT			45
 #define IMX8MN_SYS_PLL2_OUT			46
-- 
2.32.0

