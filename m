Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1E725C61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjFGK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjFGK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263B2703
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f7ebb2b82cso16133615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135393; x=1688727393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsnmlXWXAcgVHUbjGfQAWDjY409xKyzHLPgBv/T7PpM=;
        b=Vq8pa4b2T29yceZMdKvfJiUC8Fg+vWuPeJl7uQVmqtmzrO5tIkAoIxqjgq07lsh5mA
         ROUSF15bBgrhIxy/xDzx/fVi2fmH0f/wii8jt0SiWkURShx8P8VWdxtriWJwefqZ/7u9
         XlaZuoUDzbvJBHBVF425VYECX9KpAc47hhlyQ3trVPbMHfiaAMfsgJA+X58jr8Dag/ye
         KtRoqsTql6aWYlK8J5xywTd3IuzntxFB0TA0VbjxA6aszHZkLzTH0I31ZKTEdQ0CL5TU
         vWuFgh7uSeVpOyft9UfDCTILPKfNOCs6ws0/8Y+SIk7DoG69FLYTXEK/epvRi0ythygJ
         VSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135393; x=1688727393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsnmlXWXAcgVHUbjGfQAWDjY409xKyzHLPgBv/T7PpM=;
        b=J5BKEXJML6WQx/2aaQrTScntBMol6arEzweH4q39fz6LuqB/3VPdo8lFXhGI/T/yK/
         QFv5x5wREIl7MA6Dx8GvregTA1nsDxnhVLcfeLIN2YT7nIz3tiaRmvaT7TXykwj04/cu
         3jdeP2BmzTFdSPN+G32DHRc+nA1Ku4En29AGxsH8mel2o7skfIUISK13TmzqgiwNC/7L
         wPKe6XlglTgWHS5MpNC//rScJQmibk6/sBgEncv0Jq7I3Jcezj4EvzI9GCh4QUdZbgGI
         9a7PZMXn0NER8Maz8BldC26Uf8zHU8xstcVVrJ/yfcLyxGe2z1vi0oteKJfXLHvSSaFQ
         dGyw==
X-Gm-Message-State: AC+VfDynIr7sqhNLJ3pm6gXvZp282UzV3hWCdo9Y/r1r54hFamfTbCAM
        S9O+btsd4/B83I6OMk+Vz3RSOg==
X-Google-Smtp-Source: ACHHUZ7jQ7MaLkOmGsRN8HZCYFzMqtUFxGliSBM9KbHB5D4gJ9pX7SlWtYEiEvTbiCB/9UqKI5Ygng==
X-Received: by 2002:a05:600c:22ca:b0:3f7:34ee:413f with SMTP id 10-20020a05600c22ca00b003f734ee413fmr4351530wmg.5.1686135393010;
        Wed, 07 Jun 2023 03:56:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:21 +0200
Subject: [PATCH 10/18] dt-bindings: clk: meson8b-clkc: expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-10-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9164;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LbkDDdKA0SSEdFWllOS0ngQCe/Pb7VZcTTFr4986Crs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJSqZwd2YW95P6lPRkUmXxwSDcLY6on3l7Ly1Hw
 VSiVl3GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUgAKCRB33NvayMhJ0dnZD/
 9alNmV3TT3r7KFQ2rF/70Qss3SDx6cL2i1vlmIkoL1a9CEZeIWDDYlRFJRCWEK1dr7lVWWZDjgm+b8
 /pSdaavRPtm3VmIl/zFQORwWg062QFSeUgzRRNe6/ohwCz+XoRXETgTN9rCrnEBdyKikvJq6rJxQaO
 CTG9Sajj0faYuWmLUQi/oExUGujTUqM8e75DdlPeCUkoYHWbx4tB9WOQfmbdqs+G+OXQ7fshAv3gO6
 Vam0WIfGXIcC5vOD4SQDKOfBp2ppHnru/N5P5u7F8LVhk8PZIz6W8O29vp+ryRZQhGN75dNCJ+MUL4
 iW020UIaSDLNvhWwIA/aLAaupMmfhZP/WKnGeswmf7SXLcsXdXHppraJyfH/8BhevMji3ZftF0Tz0N
 yoMRXlENBbj8DBRPpYjoBiA6nC0b+tC579tB8iRGqu2asuEfij0xoxQbtr0uFWYyjfiB5OJreOkXaG
 fqsaDbsv5mCxjl2nOV1l25aoSj5qgFHsUzDdSfyNKa5BHCLk6AsOUeen54zjtXPUwV/97q3ZaEjFxT
 gaZcNB7gkNX1wJ66OG/199m4HrBHLB0AMDW3lOcONETSPYAp9hhGMRZpIDK9PtfGOWJ0R2V0VvrzIn
 odJ1sjsjyG6bkWUVTBMendwO5iSfGX2BLeZHSnJa8Exw+i8IFkxzj4Stw6hA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a policy change in clock ID bindings handling, expose
all the "private" clock IDs to the public clock dt-bindings
to move out of the previous maintenance scheme.

This refers to a discussion at [1] & [2] with Krzysztof about
the issue with the current maintenance.

It was decided to move every meson8b-clkc ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/meson8b.h              | 108 -------------------------------
 include/dt-bindings/clock/meson8b-clkc.h |  97 +++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 108 deletions(-)

diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index f999655d4436..2a9c4fe29ca2 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -77,114 +77,6 @@
 #define HHI_MPLL_CNTL9			0x2A0 /* 0xa8 offset in data sheet */
 #define HHI_MPLL_CNTL10			0x2A4 /* 0xa9 offset in data sheet */
 
-/*
- * CLKID index values
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/gxbb-clkc.h. Only the clocks ids we don't want
- * to expose, such as the internal muxes and dividers of composite clocks,
- * will remain defined here.
- */
-
-#define CLKID_MPLL0_DIV		96
-#define CLKID_MPLL1_DIV		97
-#define CLKID_MPLL2_DIV		98
-#define CLKID_CPU_IN_SEL	99
-#define CLKID_CPU_IN_DIV2	100
-#define CLKID_CPU_IN_DIV3	101
-#define CLKID_CPU_SCALE_DIV	102
-#define CLKID_CPU_SCALE_OUT_SEL	103
-#define CLKID_MPLL_PREDIV	104
-#define CLKID_FCLK_DIV2_DIV	105
-#define CLKID_FCLK_DIV3_DIV	106
-#define CLKID_FCLK_DIV4_DIV	107
-#define CLKID_FCLK_DIV5_DIV	108
-#define CLKID_FCLK_DIV7_DIV	109
-#define CLKID_NAND_SEL		110
-#define CLKID_NAND_DIV		111
-#define CLKID_PLL_FIXED_DCO	113
-#define CLKID_HDMI_PLL_DCO	114
-#define CLKID_PLL_SYS_DCO	115
-#define CLKID_CPU_CLK_DIV2	116
-#define CLKID_CPU_CLK_DIV3	117
-#define CLKID_CPU_CLK_DIV4	118
-#define CLKID_CPU_CLK_DIV5	119
-#define CLKID_CPU_CLK_DIV6	120
-#define CLKID_CPU_CLK_DIV7	121
-#define CLKID_CPU_CLK_DIV8	122
-#define CLKID_APB_SEL		123
-#define CLKID_PERIPH_SEL	125
-#define CLKID_AXI_SEL		127
-#define CLKID_L2_DRAM_SEL	129
-#define CLKID_HDMI_PLL_LVDS_OUT 131
-#define CLKID_VID_PLL_IN_SEL	133
-#define CLKID_VID_PLL_IN_EN	134
-#define CLKID_VID_PLL_PRE_DIV	135
-#define CLKID_VID_PLL_POST_DIV	136
-#define CLKID_VCLK_IN_EN	139
-#define CLKID_VCLK_DIV1		140
-#define CLKID_VCLK_DIV2_DIV	141
-#define CLKID_VCLK_DIV2		142
-#define CLKID_VCLK_DIV4_DIV	143
-#define CLKID_VCLK_DIV4		144
-#define CLKID_VCLK_DIV6_DIV	145
-#define CLKID_VCLK_DIV6		146
-#define CLKID_VCLK_DIV12_DIV	147
-#define CLKID_VCLK_DIV12	148
-#define CLKID_VCLK2_IN_EN	150
-#define CLKID_VCLK2_DIV1	151
-#define CLKID_VCLK2_DIV2_DIV	152
-#define CLKID_VCLK2_DIV2	153
-#define CLKID_VCLK2_DIV4_DIV	154
-#define CLKID_VCLK2_DIV4	155
-#define CLKID_VCLK2_DIV6_DIV	156
-#define CLKID_VCLK2_DIV6	157
-#define CLKID_VCLK2_DIV12_DIV	158
-#define CLKID_VCLK2_DIV12	159
-#define CLKID_CTS_ENCT_SEL	160
-#define CLKID_CTS_ENCP_SEL	162
-#define CLKID_CTS_ENCI_SEL	164
-#define CLKID_HDMI_TX_PIXEL_SEL	166
-#define CLKID_CTS_ENCL_SEL	168
-#define CLKID_CTS_VDAC0_SEL	170
-#define CLKID_HDMI_SYS_SEL	172
-#define CLKID_HDMI_SYS_DIV	173
-#define CLKID_MALI_0_SEL	175
-#define CLKID_MALI_0_DIV	176
-#define CLKID_MALI_0		177
-#define CLKID_MALI_1_SEL	178
-#define CLKID_MALI_1_DIV	179
-#define CLKID_MALI_1		180
-#define CLKID_GP_PLL_DCO	181
-#define CLKID_GP_PLL		182
-#define CLKID_VPU_0_SEL		183
-#define CLKID_VPU_0_DIV		184
-#define CLKID_VPU_0		185
-#define CLKID_VPU_1_SEL		186
-#define CLKID_VPU_1_DIV		187
-#define CLKID_VPU_1		189
-#define CLKID_VDEC_1_SEL	191
-#define CLKID_VDEC_1_1_DIV	192
-#define CLKID_VDEC_1_1		193
-#define CLKID_VDEC_1_2_DIV	194
-#define CLKID_VDEC_1_2		195
-#define CLKID_VDEC_HCODEC_SEL	197
-#define CLKID_VDEC_HCODEC_DIV	198
-#define CLKID_VDEC_2_SEL	200
-#define CLKID_VDEC_2_DIV	201
-#define CLKID_VDEC_HEVC_SEL	203
-#define CLKID_VDEC_HEVC_DIV	204
-#define CLKID_VDEC_HEVC_EN	205
-#define CLKID_CTS_AMCLK_SEL	207
-#define CLKID_CTS_AMCLK_DIV	208
-#define CLKID_CTS_MCLK_I958_SEL	210
-#define CLKID_CTS_MCLK_I958_DIV	211
-#define CLKID_VCLK_EN		214
-#define CLKID_VCLK2_EN		215
-#define CLKID_VID_PLL_LVDS_EN	216
-#define CLKID_HDMI_PLL_DCO_IN   217
-
 /*
  * include the CLKID and RESETID that have
  * been made part of the stable DT binding
diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 78aa07fd7cc0..385bf243c56c 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -100,29 +100,126 @@
 #define CLKID_MPLL0		93
 #define CLKID_MPLL1		94
 #define CLKID_MPLL2		95
+#define CLKID_MPLL0_DIV		96
+#define CLKID_MPLL1_DIV		97
+#define CLKID_MPLL2_DIV		98
+#define CLKID_CPU_IN_SEL	99
+#define CLKID_CPU_IN_DIV2	100
+#define CLKID_CPU_IN_DIV3	101
+#define CLKID_CPU_SCALE_DIV	102
+#define CLKID_CPU_SCALE_OUT_SEL	103
+#define CLKID_MPLL_PREDIV	104
+#define CLKID_FCLK_DIV2_DIV	105
+#define CLKID_FCLK_DIV3_DIV	106
+#define CLKID_FCLK_DIV4_DIV	107
+#define CLKID_FCLK_DIV5_DIV	108
+#define CLKID_FCLK_DIV7_DIV	109
+#define CLKID_NAND_SEL		110
+#define CLKID_NAND_DIV		111
 #define CLKID_NAND_CLK		112
+#define CLKID_PLL_FIXED_DCO	113
+#define CLKID_HDMI_PLL_DCO	114
+#define CLKID_PLL_SYS_DCO	115
+#define CLKID_CPU_CLK_DIV2	116
+#define CLKID_CPU_CLK_DIV3	117
+#define CLKID_CPU_CLK_DIV4	118
+#define CLKID_CPU_CLK_DIV5	119
+#define CLKID_CPU_CLK_DIV6	120
+#define CLKID_CPU_CLK_DIV7	121
+#define CLKID_CPU_CLK_DIV8	122
+#define CLKID_APB_SEL		123
 #define CLKID_APB		124
+#define CLKID_PERIPH_SEL	125
 #define CLKID_PERIPH		126
+#define CLKID_AXI_SEL		127
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
+#define CLKID_L2_DRAM_SEL	129
+#define CLKID_HDMI_PLL_LVDS_OUT 131
 #define CLKID_HDMI_PLL_HDMI_OUT	132
+#define CLKID_VID_PLL_IN_SEL	133
+#define CLKID_VID_PLL_IN_EN	134
+#define CLKID_VID_PLL_PRE_DIV	135
+#define CLKID_VID_PLL_POST_DIV	136
 #define CLKID_VID_PLL_FINAL_DIV	137
 #define CLKID_VCLK_IN_SEL	138
+#define CLKID_VCLK_IN_EN	139
+#define CLKID_VCLK_DIV1		140
+#define CLKID_VCLK_DIV2_DIV	141
+#define CLKID_VCLK_DIV2		142
+#define CLKID_VCLK_DIV4_DIV	143
+#define CLKID_VCLK_DIV4		144
+#define CLKID_VCLK_DIV6_DIV	145
+#define CLKID_VCLK_DIV6		146
+#define CLKID_VCLK_DIV12_DIV	147
+#define CLKID_VCLK_DIV12	148
 #define CLKID_VCLK2_IN_SEL	149
+#define CLKID_VCLK2_IN_EN	150
+#define CLKID_VCLK2_DIV1	151
+#define CLKID_VCLK2_DIV2_DIV	152
+#define CLKID_VCLK2_DIV2	153
+#define CLKID_VCLK2_DIV4_DIV	154
+#define CLKID_VCLK2_DIV4	155
+#define CLKID_VCLK2_DIV6_DIV	156
+#define CLKID_VCLK2_DIV6	157
+#define CLKID_VCLK2_DIV12_DIV	158
+#define CLKID_VCLK2_DIV12	159
+#define CLKID_CTS_ENCT_SEL	160
 #define CLKID_CTS_ENCT		161
+#define CLKID_CTS_ENCP_SEL	162
 #define CLKID_CTS_ENCP		163
+#define CLKID_CTS_ENCI_SEL	164
 #define CLKID_CTS_ENCI		165
+#define CLKID_HDMI_TX_PIXEL_SEL	166
 #define CLKID_HDMI_TX_PIXEL	167
+#define CLKID_CTS_ENCL_SEL	168
 #define CLKID_CTS_ENCL		169
+#define CLKID_CTS_VDAC0_SEL	170
 #define CLKID_CTS_VDAC0		171
+#define CLKID_HDMI_SYS_SEL	172
+#define CLKID_HDMI_SYS_DIV	173
 #define CLKID_HDMI_SYS		174
+#define CLKID_MALI_0_SEL	175
+#define CLKID_MALI_0_DIV	176
+#define CLKID_MALI_0		177
+#define CLKID_MALI_1_SEL	178
+#define CLKID_MALI_1_DIV	179
+#define CLKID_MALI_1		180
+#define CLKID_GP_PLL_DCO	181
+#define CLKID_GP_PLL		182
+#define CLKID_VPU_0_SEL		183
+#define CLKID_VPU_0_DIV		184
+#define CLKID_VPU_0		185
+#define CLKID_VPU_1_SEL		186
+#define CLKID_VPU_1_DIV		187
+#define CLKID_VPU_1		189
 #define CLKID_VPU		190
+#define CLKID_VDEC_1_SEL	191
+#define CLKID_VDEC_1_1_DIV	192
+#define CLKID_VDEC_1_1		193
+#define CLKID_VDEC_1_2_DIV	194
+#define CLKID_VDEC_1_2		195
 #define CLKID_VDEC_1		196
+#define CLKID_VDEC_HCODEC_SEL	197
+#define CLKID_VDEC_HCODEC_DIV	198
 #define CLKID_VDEC_HCODEC	199
+#define CLKID_VDEC_2_SEL	200
+#define CLKID_VDEC_2_DIV	201
 #define CLKID_VDEC_2		202
+#define CLKID_VDEC_HEVC_SEL	203
+#define CLKID_VDEC_HEVC_DIV	204
+#define CLKID_VDEC_HEVC_EN	205
 #define CLKID_VDEC_HEVC		206
+#define CLKID_CTS_AMCLK_SEL	207
+#define CLKID_CTS_AMCLK_DIV	208
 #define CLKID_CTS_AMCLK		209
+#define CLKID_CTS_MCLK_I958_SEL	210
+#define CLKID_CTS_MCLK_I958_DIV	211
 #define CLKID_CTS_MCLK_I958	212
 #define CLKID_CTS_I958		213
+#define CLKID_VCLK_EN		214
+#define CLKID_VCLK2_EN		215
+#define CLKID_VID_PLL_LVDS_EN	216
+#define CLKID_HDMI_PLL_DCO_IN   217
 
 #endif /* __MESON8B_CLKC_H */

-- 
2.34.1

