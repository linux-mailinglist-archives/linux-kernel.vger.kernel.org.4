Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13F73200A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjFOS3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjFOS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:29:47 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2CA7;
        Thu, 15 Jun 2023 11:29:45 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso8449115e9.1;
        Thu, 15 Jun 2023 11:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853783; x=1689445783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU6a6sKvQg9ioadnbSYVtH+UsgRPTiogrfsIDCI88uA=;
        b=fnYdr8izGhA7xmuFBB4T/dTjLSMGSLog5qdZDeOMLBl3pp60bOYQoi1o/UUyQaXgkx
         cR+IPVM6eO0wd008FMu33gIUXMxlWljT1mrh0h8rhLhQTaOnXIBcunAoHoSeB8LUfmq8
         hBMAGC9kPZJQfCS1L3PIzSmnWXins+KgL9iAN7WxBV6k9XAR0QWKucXgTp3dBNW05kHh
         OcECYEDKuO5NkgLYWkVCMkENJ8EncAB2aRwR0nFB2LKGcBG++xYksXW3uuzZZEeco5fj
         0fK7pc1uEflMY6+/+hX4+OuuOdVrXbFeSo6e6+ePuixYW8AYTrSmXRvG4WigSjC/fRYQ
         focw==
X-Gm-Message-State: AC+VfDyiaH2NFX3WPYtSGXe6mo+aLw5k9gWwz2sZwEiqQ8ttp16QSZXh
        XudDDHadwpxyAR7cAmeHj19dCAxtAiZiWQ==
X-Google-Smtp-Source: ACHHUZ6EgZct0QfQ1duy3CEUre2XBD50U3qxsJ2bhtaGhPqHTS6r7ZpuIUOcaTnZ7iWOJThMidU+uA==
X-Received: by 2002:adf:f601:0:b0:311:100a:d1e0 with SMTP id t1-20020adff601000000b00311100ad1e0mr3986490wrp.14.1686853783284;
        Thu, 15 Jun 2023 11:29:43 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm21525887wrr.46.2023.06.15.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:29:42 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH 2/6] dt-bindings: clock: Bindings for Meson T7 clock controller
Date:   Thu, 15 Jun 2023 19:29:34 +0100
Message-ID: <20230615182938.18487-3-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615182938.18487-1-tanure@linux.com>
References: <20230615182938.18487-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for T7 the clock controller.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/clock/amlogic,mesont7.yaml       |  69 +++
 include/dt-bindings/clock/mesont7-clkc.h      | 487 ++++++++++++++++++
 2 files changed, 556 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
 create mode 100644 include/dt-bindings/clock/mesont7-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
new file mode 100644
index 000000000000..18e7cca0c0e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,mesont7-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson T7 Clock Controller
+
+maintainers:
+  - Lucas Tanure <tanure@linux.com>
+
+description: |
+  The Amlogic Meson T7 clock controller generates and supplies clock to
+  various peripherals within the SoC.
+
+  This binding uses common clock bindings
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    const: amlogic,t7-clkc
+
+  reg:
+    items:
+      - description: basic registers
+      - description: pll registers
+      - description: cpu_clk registers
+
+  reg-names:
+    items:
+      - const: basic
+      - const: pll
+      - const: cpu_clk
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xtal
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock controller node:
+  - |
+    clkc: clock-controller {
+        compatible = "amlogic,t7-clkc";
+        #clock-cells = <1>;
+        reg = <0x0 0x0000 0x00 0x49c>,
+              <0x0 0x8000 0x00 0x320>,
+              <0x0 0xe040 0x00 0x0bc>;
+        reg-names = "basic", "pll", "cpu_clk";
+        clocks = <&xtal>;
+        clock-names = "xtal";
+        status = "okay";
+    };
+
+...
diff --git a/include/dt-bindings/clock/mesont7-clkc.h b/include/dt-bindings/clock/mesont7-clkc.h
new file mode 100644
index 000000000000..8bc1122b75a7
--- /dev/null
+++ b/include/dt-bindings/clock/mesont7-clkc.h
@@ -0,0 +1,487 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (c) 2019 Amlogic Inc. All rights reserved.
+ */
+
+#ifndef __T7_CLKC_H
+#define __T7_CLKC_H
+
+/*
+ * CLKID index values
+ */
+
+#define CLKID_FIXED_PLL_DCO		0
+#define CLKID_FIXED_PLL			1
+#define CLKID_SYS_PLL_DCO		2
+#define CLKID_SYS_PLL			3
+#define CLKID_FCLK_DIV2_DIV		4
+#define CLKID_FCLK_DIV2			5
+#define CLKID_FCLK_DIV3_DIV		6
+#define CLKID_FCLK_DIV3			7
+#define CLKID_FCLK_DIV4_DIV		8
+#define CLKID_FCLK_DIV4			9
+#define CLKID_FCLK_DIV5_DIV		10
+#define CLKID_FCLK_DIV5			11
+#define CLKID_FCLK_DIV7_DIV		12
+#define CLKID_FCLK_DIV7			13
+#define CLKID_FCLK_DIV2P5_DIV		14
+#define CLKID_FCLK_DIV2P5		15
+#define CLKID_GP0_PLL_DCO		16
+#define CLKID_GP0_PLL			17
+#define CLKID_GP1_PLL_DCO		18
+#define CLKID_GP1_PLL			19
+#define CLKID_SYS1_PLL_DCO		20
+#define CLKID_SYS1_PLL			21
+#define CLKID_CPU_DYN_CLK		22
+#define CLKID_CPU_CLK			23
+#define CLKID_A73_DYN_CLK		24
+#define CLKID_A73_CLK			25
+#define CLKID_CPU1_CLK			26
+#define CLKID_CPU2_CLK			27
+#define CLKID_CPU3_CLK			28
+#define CLKID_MCLK_PLL_DCO		29
+#define CLKID_MCLK_PRE			30
+#define CLKID_MCLK_PLL			31
+
+#define CLKID_PLL_BASE			32
+#define CLKID_HIFI_PLL_DCO		(CLKID_PLL_BASE + 0)
+#define CLKID_HIFI_PLL			(CLKID_PLL_BASE + 1)
+#define CLKID_PCIE_PLL_DCO		(CLKID_PLL_BASE + 2)
+#define CLKID_PCIE_PLL_DCO_DIV2		(CLKID_PLL_BASE + 3)
+#define CLKID_PCIE_PLL_OD		(CLKID_PLL_BASE + 4)
+#define CLKID_PCIE_PLL			(CLKID_PLL_BASE + 5)
+#define CLKID_HDMI_PLL_DCO		(CLKID_PLL_BASE + 6)
+#define CLKID_HDMI_PLL_OD		(CLKID_PLL_BASE + 7)
+#define CLKID_HDMI_PLL			(CLKID_PLL_BASE + 8)
+#define CLKID_MPLL_50M_DIV		(CLKID_PLL_BASE + 9)
+#define CLKID_MPLL_50M			(CLKID_PLL_BASE + 10)
+#define CLKID_MPLL_PREDIV		(CLKID_PLL_BASE + 11)
+#define CLKID_MPLL0_DIV			(CLKID_PLL_BASE + 12)
+#define CLKID_MPLL0			(CLKID_PLL_BASE + 13)
+#define CLKID_MPLL1_DIV			(CLKID_PLL_BASE + 14)
+#define CLKID_MPLL1			(CLKID_PLL_BASE + 15)
+#define CLKID_MPLL2_DIV			(CLKID_PLL_BASE + 16)
+#define CLKID_MPLL2			(CLKID_PLL_BASE + 17)
+#define CLKID_MPLL3_DIV			(CLKID_PLL_BASE + 18)
+#define CLKID_MPLL3			(CLKID_PLL_BASE + 19)
+#define CLKID_PCIE_BGP			(CLKID_PLL_BASE + 20)
+#define CLKID_PCIE_HCSL			(CLKID_PLL_BASE + 21)
+
+#define CLKID_BASE			(CLKID_PLL_BASE + 22)
+#define CLKID_RTC_32K_CLKIN		(CLKID_BASE + 0)
+#define CLKID_RTC_32K_DIV		(CLKID_BASE + 1)
+#define CLKID_RTC_32K_XATL		(CLKID_BASE + 2)
+#define CLKID_RTC_32K_MUX		(CLKID_BASE + 3)
+#define CLKID_RTC_CLK			(CLKID_BASE + 4)
+#define CLKID_SYS_CLK_B_MUX		(CLKID_BASE + 5)
+#define CLKID_SYS_CLK_B_DIV		(CLKID_BASE + 6)
+#define CLKID_SYS_CLK_B_GATE		(CLKID_BASE + 7)
+#define CLKID_SYS_CLK_A_MUX		(CLKID_BASE + 8)
+#define CLKID_SYS_CLK_A_DIV		(CLKID_BASE + 9)
+#define CLKID_SYS_CLK_A_GATE		(CLKID_BASE + 10)
+#define CLKID_SYS_CLK			(CLKID_BASE + 11)
+#define CLKID_CECA_32K_CLKIN		(CLKID_BASE + 12)
+#define CLKID_CECA_32K_DIV		(CLKID_BASE + 13)
+#define CLKID_CECA_32K_MUX_PRE		(CLKID_BASE + 14)
+#define CLKID_CECA_32K_MUX		(CLKID_BASE + 15)
+#define CLKID_CECA_32K_CLKOUT		(CLKID_BASE + 16)
+#define CLKID_CECB_32K_CLKIN		(CLKID_BASE + 17)
+#define CLKID_CECB_32K_DIV		(CLKID_BASE + 18)
+#define CLKID_CECB_32K_MUX_PRE		(CLKID_BASE + 19)
+#define CLKID_CECB_32K_MUX		(CLKID_BASE + 20)
+#define CLKID_CECB_32K_CLKOUT		(CLKID_BASE + 21)
+#define CLKID_SC_CLK_MUX		(CLKID_BASE + 22)
+#define CLKID_SC_CLK_DIV		(CLKID_BASE + 23)
+#define CLKID_SC_CLK_GATE		(CLKID_BASE + 24)
+#define CLKID_DSPA_CLK_B_MUX		(CLKID_BASE + 25)
+#define CLKID_DSPA_CLK_B_DIV		(CLKID_BASE + 26)
+#define CLKID_DSPA_CLK_B_GATE		(CLKID_BASE + 27)
+#define CLKID_DSPA_CLK_A_MUX		(CLKID_BASE + 28)
+#define CLKID_DSPA_CLK_A_DIV		(CLKID_BASE + 29)
+#define CLKID_DSPA_CLK_A_GATE		(CLKID_BASE + 30)
+#define CLKID_DSPA_CLK			(CLKID_BASE + 31)
+#define CLKID_24M_CLK_GATE		(CLKID_BASE + 32)
+#define CLKID_12M_CLK_DIV		(CLKID_BASE + 33)
+#define CLKID_12M_CLK_GATE		(CLKID_BASE + 34)
+#define CLKID_25M_CLK_DIV		(CLKID_BASE + 35)
+#define CLKID_25M_CLK_GATE		(CLKID_BASE + 36)
+/* Video clks */
+#define CLKID_VID_PLL_DIV		(CLKID_BASE + 37)
+#define CLKID_VID_PLL_MUX		(CLKID_BASE + 38)
+#define CLKID_VID_PLL			(CLKID_BASE + 39)
+#define CLKID_VCLK_MUX			(CLKID_BASE + 40)
+#define CLKID_VCLK2_MUX			(CLKID_BASE + 41)
+#define CLKID_VCLK_INPUT		(CLKID_BASE + 42)
+#define CLKID_VCLK2_INPUT		(CLKID_BASE + 43)
+#define CLKID_VCLK_DIV			(CLKID_BASE + 44)
+#define CLKID_VCLK2_DIV			(CLKID_BASE + 45)
+#define CLKID_VCLK			(CLKID_BASE + 46)
+#define CLKID_VCLK2			(CLKID_BASE + 47)
+#define CLKID_VCLK_DIV1			(CLKID_BASE + 48)
+#define CLKID_VCLK_DIV2_EN		(CLKID_BASE + 49)
+#define CLKID_VCLK_DIV4_EN		(CLKID_BASE + 50)
+#define CLKID_VCLK_DIV6_EN		(CLKID_BASE + 51)
+#define CLKID_VCLK_DIV12_EN		(CLKID_BASE + 52)
+#define CLKID_VCLK2_DIV1		(CLKID_BASE + 53)
+#define CLKID_VCLK2_DIV2_EN		(CLKID_BASE + 54)
+#define CLKID_VCLK2_DIV4_EN		(CLKID_BASE + 55)
+#define CLKID_VCLK2_DIV6_EN		(CLKID_BASE + 56)
+#define CLKID_VCLK2_DIV12_EN		(CLKID_BASE + 57)
+#define CLKID_VCLK_DIV2			(CLKID_BASE + 58)
+#define CLKID_VCLK_DIV4			(CLKID_BASE + 59)
+#define CLKID_VCLK_DIV6			(CLKID_BASE + 60)
+#define CLKID_VCLK_DIV12		(CLKID_BASE + 61)
+#define CLKID_VCLK2_DIV2		(CLKID_BASE + 62)
+#define CLKID_VCLK2_DIV4		(CLKID_BASE + 63)
+#define CLKID_VCLK2_DIV6		(CLKID_BASE + 64)
+#define CLKID_VCLK2_DIV12		(CLKID_BASE + 65)
+#define CLKID_CTS_ENCI_MUX		(CLKID_BASE + 66)
+#define CLKID_CTS_ENCP_MUX		(CLKID_BASE + 67)
+#define CLKID_CTS_VDAC_MUX		(CLKID_BASE + 68)
+#define CLKID_HDMI_TX_MUX		(CLKID_BASE + 69)
+#define CLKID_CTS_ENCI			(CLKID_BASE + 70)
+#define CLKID_CTS_ENCP			(CLKID_BASE + 71)
+#define CLKID_CTS_VDAC			(CLKID_BASE + 72)
+#define CLKID_HDMI_TX			(CLKID_BASE + 73)
+#define CLKID_HDMITX_SYS_MUX		(CLKID_BASE + 74)
+#define CLKID_HDMITX_SYS_DIV		(CLKID_BASE + 75)
+#define CLKID_HDMITX_SYS		(CLKID_BASE + 76)
+#define CLKID_TS_CLK_DIV		(CLKID_BASE + 77)
+#define CLKID_TS_CLK_GATE		(CLKID_BASE + 78)
+#define CLKID_MALI_0_SEL		(CLKID_BASE + 79)
+#define CLKID_MALI_0_DIV		(CLKID_BASE + 80)
+#define CLKID_MALI_0			(CLKID_BASE + 81)
+#define CLKID_MALI_1_SEL		(CLKID_BASE + 82)
+#define CLKID_MALI_1_DIV		(CLKID_BASE + 83)
+#define CLKID_MALI_1			(CLKID_BASE + 84)
+#define CLKID_MALI_MUX			(CLKID_BASE + 85)
+#define CLKID_VDEC_P0_MUX		(CLKID_BASE + 86)
+#define CLKID_VDEC_P0_DIV		(CLKID_BASE + 87)
+#define CLKID_VDEC_P0			(CLKID_BASE + 88)
+#define CLKID_VDEC_P1_MUX		(CLKID_BASE + 89)
+#define CLKID_VDEC_P1_DIV		(CLKID_BASE + 90)
+#define CLKID_VDEC_P1			(CLKID_BASE + 91)
+#define CLKID_VDEC_MUX			(CLKID_BASE + 92)
+#define CLKID_HCODEC_P0_MUX		(CLKID_BASE + 93)
+#define CLKID_HCODEC_P0_DIV		(CLKID_BASE + 94)
+#define CLKID_HCODEC_P0			(CLKID_BASE + 95)
+#define CLKID_HCODEC_P1_MUX		(CLKID_BASE + 96)
+#define CLKID_HCODEC_P1_DIV		(CLKID_BASE + 97)
+#define CLKID_HCODEC_P1			(CLKID_BASE + 98)
+#define CLKID_HCODEC_MUX		(CLKID_BASE + 99)
+#define CLKID_HEVCB_P0_MUX		(CLKID_BASE + 100)
+#define CLKID_HEVCB_P0_DIV		(CLKID_BASE + 101)
+#define CLKID_HEVCB_P0			(CLKID_BASE + 102)
+#define CLKID_HEVCB_P1_MUX		(CLKID_BASE + 103)
+#define CLKID_HEVCB_P1_DIV		(CLKID_BASE + 104)
+#define CLKID_HEVCB_P1			(CLKID_BASE + 105)
+#define CLKID_HEVCB_MUX			(CLKID_BASE + 106)
+#define CLKID_HEVCF_P0_MUX		(CLKID_BASE + 107)
+#define CLKID_HEVCF_P0_DIV		(CLKID_BASE + 108)
+#define CLKID_HEVCF_P0			(CLKID_BASE + 109)
+#define CLKID_HEVCF_P1_MUX		(CLKID_BASE + 110)
+#define CLKID_HEVCF_P1_DIV		(CLKID_BASE + 111)
+#define CLKID_HEVCF_P1			(CLKID_BASE + 112)
+#define CLKID_HEVCF_MUX			(CLKID_BASE + 113)
+#define CLKID_WAVE_A_MUX		(CLKID_BASE + 114)
+#define CLKID_WAVE_A_DIV		(CLKID_BASE + 115)
+#define CLKID_WAVE_A_GATE		(CLKID_BASE + 116)
+#define CLKID_WAVE_B_MUX		(CLKID_BASE + 117)
+#define CLKID_WAVE_B_DIV		(CLKID_BASE + 118)
+#define CLKID_WAVE_B_GATE		(CLKID_BASE + 119)
+#define CLKID_WAVE_C_MUX		(CLKID_BASE + 120)
+#define CLKID_WAVE_C_DIV		(CLKID_BASE + 121)
+#define CLKID_WAVE_C_GATE		(CLKID_BASE + 122)
+#define CLKID_VPU_0_MUX			(CLKID_BASE + 123)
+#define CLKID_VPU_0_DIV			(CLKID_BASE + 124)
+#define CLKID_VPU_0			(CLKID_BASE + 125)
+#define CLKID_VPU_1_MUX			(CLKID_BASE + 126)
+#define CLKID_VPU_1_DIV			(CLKID_BASE + 127)
+#define CLKID_VPU_1			(CLKID_BASE + 128)
+#define CLKID_VPU			(CLKID_BASE + 129)
+#define CLKID_VPU_CLKB_TMP_MUX		(CLKID_BASE + 130)
+#define CLKID_VPU_CLKB_TMP_DIV		(CLKID_BASE + 131)
+#define CLKID_VPU_CLKB_TMP		(CLKID_BASE + 132)
+#define CLKID_VPU_CLKB_DIV		(CLKID_BASE + 133)
+#define CLKID_VPU_CLKB			(CLKID_BASE + 134)
+#define CLKID_VPU_CLKC_P0_MUX		(CLKID_BASE + 135)
+#define CLKID_VPU_CLKC_P0_DIV		(CLKID_BASE + 136)
+#define CLKID_VPU_CLKC_P0		(CLKID_BASE + 137)
+#define CLKID_VPU_CLKC_P1_MUX		(CLKID_BASE + 138)
+#define CLKID_VPU_CLKC_P1_DIV		(CLKID_BASE + 139)
+#define CLKID_VPU_CLKC_P1		(CLKID_BASE + 140)
+#define CLKID_VPU_CLKC_MUX		(CLKID_BASE + 141)
+#define CLKID_VAPB_0_MUX		(CLKID_BASE + 142)
+#define CLKID_VAPB_0_DIV		(CLKID_BASE + 143)
+#define CLKID_VAPB_0			(CLKID_BASE + 144)
+#define CLKID_VAPB_1_MUX		(CLKID_BASE + 145)
+#define CLKID_VAPB_1_DIV		(CLKID_BASE + 146)
+#define CLKID_VAPB_1			(CLKID_BASE + 147)
+#define CLKID_VAPB			(CLKID_BASE + 148)
+#define CLKID_GE2D			(CLKID_BASE + 149)
+#define CLKID_VDIN_MEAS_MUX		(CLKID_BASE + 150)
+#define CLKID_VDIN_MEAS_DIV		(CLKID_BASE + 151)
+#define CLKID_VDIN_MEAS_GATE		(CLKID_BASE + 152)
+#define CLKID_DSI_A_MEAS_MUX		(CLKID_BASE + 153)
+#define CLKID_DSI_A_MEAS_DIV		(CLKID_BASE + 154)
+#define CLKID_DSI_A_MEAS_GATE		(CLKID_BASE + 155)
+#define CLKID_DSI_B_MEAS_MUX		(CLKID_BASE + 156)
+#define CLKID_DSI_B_MEAS_DIV		(CLKID_BASE + 157)
+#define CLKID_DSI_B_MEAS_GATE		(CLKID_BASE + 158)
+#define CLKID_DSI0_PHY_MUX		(CLKID_BASE + 159)
+#define CLKID_DSI0_PHY_DIV		(CLKID_BASE + 160)
+#define CLKID_DSI0_PHY_GATE		(CLKID_BASE + 161)
+#define CLKID_DSI1_PHY_MUX		(CLKID_BASE + 162)
+#define CLKID_DSI1_PHY_DIV		(CLKID_BASE + 163)
+#define CLKID_DSI1_PHY_GATE		(CLKID_BASE + 164)
+#define CLKID_VID_LOCK_DIV		(CLKID_BASE + 165)
+#define CLKID_VID_LOCK			(CLKID_BASE + 166)
+#define PERI_BASE			(CLKID_BASE + 167)
+#define CLKID_PWM_A_MUX			(PERI_BASE + 0)
+#define CLKID_PWM_A_DIV			(PERI_BASE + 1)
+#define CLKID_PWM_A_GATE		(PERI_BASE + 2)
+#define CLKID_PWM_B_MUX			(PERI_BASE + 3)
+#define CLKID_PWM_B_DIV			(PERI_BASE + 4)
+#define CLKID_PWM_B_GATE		(PERI_BASE + 5)
+#define CLKID_PWM_C_MUX			(PERI_BASE + 6)
+#define CLKID_PWM_C_DIV			(PERI_BASE + 7)
+#define CLKID_PWM_C_GATE		(PERI_BASE + 8)
+#define CLKID_PWM_D_MUX			(PERI_BASE + 9)
+#define CLKID_PWM_D_DIV			(PERI_BASE + 10)
+#define CLKID_PWM_D_GATE		(PERI_BASE + 11)
+#define CLKID_PWM_E_MUX			(PERI_BASE + 12)
+#define CLKID_PWM_E_DIV			(PERI_BASE + 13)
+#define CLKID_PWM_E_GATE		(PERI_BASE + 14)
+#define CLKID_PWM_F_MUX			(PERI_BASE + 15)
+#define CLKID_PWM_F_DIV			(PERI_BASE + 16)
+#define CLKID_PWM_F_GATE		(PERI_BASE + 17)
+#define CLKID_PWM_AO_A_MUX		(PERI_BASE + 18)
+#define CLKID_PWM_AO_A_DIV		(PERI_BASE + 19)
+#define CLKID_PWM_AO_A_GATE		(PERI_BASE + 20)
+#define CLKID_PWM_AO_B_MUX		(PERI_BASE + 21)
+#define CLKID_PWM_AO_B_DIV		(PERI_BASE + 22)
+#define CLKID_PWM_AO_B_GATE		(PERI_BASE + 23)
+#define CLKID_PWM_AO_C_MUX		(PERI_BASE + 24)
+#define CLKID_PWM_AO_C_DIV		(PERI_BASE + 25)
+#define CLKID_PWM_AO_C_GATE		(PERI_BASE + 26)
+#define CLKID_PWM_AO_D_MUX		(PERI_BASE + 27)
+#define CLKID_PWM_AO_D_DIV		(PERI_BASE + 28)
+#define CLKID_PWM_AO_D_GATE		(PERI_BASE + 29)
+#define CLKID_PWM_AO_E_MUX		(PERI_BASE + 30)
+#define CLKID_PWM_AO_E_DIV		(PERI_BASE + 31)
+#define CLKID_PWM_AO_E_GATE		(PERI_BASE + 32)
+#define CLKID_PWM_AO_F_MUX		(PERI_BASE + 33)
+#define CLKID_PWM_AO_F_DIV		(PERI_BASE + 34)
+#define CLKID_PWM_AO_F_GATE		(PERI_BASE + 35)
+#define CLKID_PWM_AO_G_MUX		(PERI_BASE + 36)
+#define CLKID_PWM_AO_G_DIV		(PERI_BASE + 37)
+#define CLKID_PWM_AO_G_GATE		(PERI_BASE + 38)
+#define CLKID_PWM_AO_H_MUX		(PERI_BASE + 39)
+#define CLKID_PWM_AO_H_DIV		(PERI_BASE + 40)
+#define CLKID_PWM_AO_H_GATE		(PERI_BASE + 41)
+#define CLKID_SPICC0_MUX		(PERI_BASE + 42)
+#define CLKID_SPICC0_DIV		(PERI_BASE + 43)
+#define CLKID_SPICC0_GATE		(PERI_BASE + 44)
+#define CLKID_SPICC1_MUX		(PERI_BASE + 45)
+#define CLKID_SPICC1_DIV		(PERI_BASE + 46)
+#define CLKID_SPICC1_GATE		(PERI_BASE + 47)
+#define CLKID_SPICC2_MUX		(PERI_BASE + 48)
+#define CLKID_SPICC2_DIV		(PERI_BASE + 49)
+#define CLKID_SPICC2_GATE		(PERI_BASE + 50)
+#define CLKID_SPICC3_MUX		(PERI_BASE + 51)
+#define CLKID_SPICC3_DIV		(PERI_BASE + 52)
+#define CLKID_SPICC3_GATE		(PERI_BASE + 53)
+#define CLKID_SPICC4_MUX		(PERI_BASE + 54)
+#define CLKID_SPICC4_DIV		(PERI_BASE + 55)
+#define CLKID_SPICC4_GATE		(PERI_BASE + 56)
+#define CLKID_SPICC5_MUX		(PERI_BASE + 57)
+#define CLKID_SPICC5_DIV		(PERI_BASE + 58)
+#define CLKID_SPICC5_GATE		(PERI_BASE + 59)
+#define CLKID_SD_EMMC_C_CLK_MUX		(PERI_BASE + 60)
+#define CLKID_SD_EMMC_C_CLK_DIV		(PERI_BASE + 61)
+#define CLKID_SD_EMMC_C_CLK		(PERI_BASE + 62)
+#define CLKID_SD_EMMC_A_CLK_MUX		(PERI_BASE + 63)
+#define CLKID_SD_EMMC_A_CLK_DIV		(PERI_BASE + 64)
+#define CLKID_SD_EMMC_A_CLK		(PERI_BASE + 65)
+#define CLKID_SD_EMMC_B_CLK_MUX		(PERI_BASE + 66)
+#define CLKID_SD_EMMC_B_CLK_DIV		(PERI_BASE + 67)
+#define CLKID_SD_EMMC_B_CLK		(PERI_BASE + 68)
+#define CLKID_ETH_RMII_SEL		(PERI_BASE + 69)
+#define CLKID_ETH_RMII_DIV		(PERI_BASE + 70)
+#define CLKID_ETH_RMII			(PERI_BASE + 71)
+#define CLKID_ETH_DIV8			(PERI_BASE + 72)
+#define CLKID_ETH_125M			(PERI_BASE + 73)
+#define CLKID_SARADC_MUX		(PERI_BASE + 74)
+#define CLKID_SARADC_DIV		(PERI_BASE + 75)
+#define CLKID_SARADC_GATE		(PERI_BASE + 76)
+#define CLKID_GEN_MUX			(PERI_BASE + 77)
+#define CLKID_GEN_DIV			(PERI_BASE + 78)
+#define CLKID_GEN_GATE			(PERI_BASE + 79)
+
+#define MEDIA_BASE			(PERI_BASE + 80)
+#define CLKID_DSPB_CLK_B_MUX		(MEDIA_BASE + 0)
+#define CLKID_DSPB_CLK_B_DIV		(MEDIA_BASE + 1)
+#define CLKID_DSPB_CLK_B_GATE		(MEDIA_BASE + 2)
+#define CLKID_DSPB_CLK_A_MUX		(MEDIA_BASE + 3)
+#define CLKID_DSPB_CLK_A_DIV		(MEDIA_BASE + 4)
+#define CLKID_DSPB_CLK_A_GATE		(MEDIA_BASE + 5)
+#define CLKID_DSPB_CLK			(MEDIA_BASE + 6)
+#define CLKID_MIPI_ISP_MUX		(MEDIA_BASE + 7)
+#define CLKID_MIPI_ISP_DIV		(MEDIA_BASE + 8)
+#define CLKID_MIPI_ISP			(MEDIA_BASE + 9)
+#define CLKID_MIPI_CSI_PHY_SEL0		(MEDIA_BASE + 10)
+#define CLKID_MIPI_CSI_PHY_DIV0		(MEDIA_BASE + 11)
+#define CLKID_MIPI_CSI_PHY0		(MEDIA_BASE + 12)
+#define CLKID_MIPI_CSI_PHY_SEL1		(MEDIA_BASE + 13)
+#define CLKID_MIPI_CSI_PHY_DIV1		(MEDIA_BASE + 14)
+#define CLKID_MIPI_CSI_PHY1		(MEDIA_BASE + 15)
+#define CLKID_MIPI_CSI_PHY_CLK		(MEDIA_BASE + 16)
+#define CLKID_GDCCLK_0_MUX		(MEDIA_BASE + 17)
+#define CLKID_GDCCLK_0_DIV		(MEDIA_BASE + 18)
+#define CLKID_GDCCLK_0			(MEDIA_BASE + 19)
+#define CLKID_GDCCLK_1_MUX		(MEDIA_BASE + 20)
+#define CLKID_GDCCLK_1_DIV		(MEDIA_BASE + 21)
+#define CLKID_GDCCLK_1			(MEDIA_BASE + 22)
+#define CLKID_GDCCLK			(MEDIA_BASE + 23)
+#define CLKID_GDC_CLK			(MEDIA_BASE + 24)
+#define CLKID_DEWARPCLK_0_MUX		(MEDIA_BASE + 25)
+#define CLKID_DEWARPCLK_0_DIV		(MEDIA_BASE + 26)
+#define CLKID_DEWARPCLK_0		(MEDIA_BASE + 27)
+#define CLKID_DEWARPCLK_1_MUX		(MEDIA_BASE + 28)
+#define CLKID_DEWARPCLK_1_DIV		(MEDIA_BASE + 29)
+#define CLKID_DEWARPCLK_1		(MEDIA_BASE + 30)
+#define CLKID_DEWARPCLK			(MEDIA_BASE + 31)
+#define CLKID_DEWARP_CLK		(MEDIA_BASE + 32)
+#define CLKID_ANAKIN_0_MUX		(MEDIA_BASE + 33)
+#define CLKID_ANAKIN_0_DIV		(MEDIA_BASE + 34)
+#define CLKID_ANAKIN_0			(MEDIA_BASE + 35)
+#define CLKID_ANAKIN_1_MUX		(MEDIA_BASE + 36)
+#define CLKID_ANAKIN_1_DIV		(MEDIA_BASE + 37)
+#define CLKID_ANAKIN_1			(MEDIA_BASE + 38)
+#define CLKID_ANAKIN			(MEDIA_BASE + 39)
+#define CLKID_ANAKIN_CLK		(MEDIA_BASE + 40)
+#define CLKID_HDMITX_PRIF_MUX		(MEDIA_BASE + 41)
+#define CLKID_HDMITX_PRIF_DIV		(MEDIA_BASE + 42)
+#define CLKID_HDMITX_PRIF		(MEDIA_BASE + 43)
+#define CLKID_HDMITX_200M_MUX		(MEDIA_BASE + 44)
+#define CLKID_HDMITX_200M_DIV		(MEDIA_BASE + 45)
+#define CLKID_HDMITX_200M		(MEDIA_BASE + 46)
+#define CLKID_HDMITX_AUD_MUX		(MEDIA_BASE + 47)
+#define CLKID_HDMITX_AUD_DIV		(MEDIA_BASE + 48)
+#define CLKID_HDMITX_AUD		(MEDIA_BASE + 49)
+#define CLKID_HDMIRX_2M_MUX		(MEDIA_BASE + 50)
+#define CLKID_HDMIRX_2M_DIV		(MEDIA_BASE + 51)
+#define CLKID_HDMIRX_2M			(MEDIA_BASE + 52)
+#define CLKID_HDMIRX_5M_MUX		(MEDIA_BASE + 53)
+#define CLKID_HDMIRX_5M_DIV		(MEDIA_BASE + 54)
+#define CLKID_HDMIRX_5M			(MEDIA_BASE + 55)
+#define CLKID_HDMIRX_CFG_MUX		(MEDIA_BASE + 56)
+#define CLKID_HDMIRX_CFG_DIV		(MEDIA_BASE + 57)
+#define CLKID_HDMIRX_CFG		(MEDIA_BASE + 58)
+#define CLKID_HDMIRX_HDCP_MUX		(MEDIA_BASE + 59)
+#define CLKID_HDMIRX_HDCP_DIV		(MEDIA_BASE + 60)
+#define CLKID_HDMIRX_HDCP		(MEDIA_BASE + 61)
+#define CLKID_HDMIRX_AUD_PLL_MUX	(MEDIA_BASE + 62)
+#define CLKID_HDMIRX_AUD_PLL_DIV	(MEDIA_BASE + 63)
+#define CLKID_HDMIRX_AUD_PLL		(MEDIA_BASE + 64)
+#define CLKID_HDMIRX_ACR_MUX		(MEDIA_BASE + 65)
+#define CLKID_HDMIRX_ACR_DIV		(MEDIA_BASE + 66)
+#define CLKID_HDMIRX_ACR		(MEDIA_BASE + 67)
+#define CLKID_HDMIRX_METER_MUX		(MEDIA_BASE + 68)
+#define CLKID_HDMIRX_METER_DIV		(MEDIA_BASE + 69)
+#define CLKID_HDMIRX_METER		(MEDIA_BASE + 70)
+#define CLKID_MCLK_0_SEL		(MEDIA_BASE + 71)
+#define CLKID_MCLK_0_DIV2		(MEDIA_BASE + 72)
+#define CLKID_MCLK_0_PRE		(MEDIA_BASE + 73)
+#define CLKID_MCLK_0			(MEDIA_BASE + 74)
+#define CLKID_MCLK_1_SEL		(MEDIA_BASE + 75)
+#define CLKID_MCLK_1_DIV2		(MEDIA_BASE + 76)
+#define CLKID_MCLK_1_PRE		(MEDIA_BASE + 77)
+#define CLKID_MCLK_1			(MEDIA_BASE + 78)
+
+#define SYS_BASE			(MEDIA_BASE + 79)
+#define CLKID_DDR			(SYS_BASE + 0)
+#define CLKID_DOS			(SYS_BASE + 1)
+#define CLKID_ETHPHY			(SYS_BASE + 2)
+#define CLKID_MALI			(SYS_BASE + 3)
+#define CLKID_TS_A53			(SYS_BASE + 4)
+#define CLKID_TS_A73			(SYS_BASE + 5)
+#define CLKID_CEC			(SYS_BASE + 6)
+#define CLKID_SD_EMMC_A			(SYS_BASE + 7)
+#define CLKID_SD_EMMC_B			(SYS_BASE + 8)
+#define CLKID_SD_EMMC_C			(SYS_BASE + 9)
+#define CLKID_SMARTCARD			(SYS_BASE + 10)
+#define CLKID_ACODEC			(SYS_BASE + 11)
+#define CLKID_SPIFC			(SYS_BASE + 12)
+#define CLKID_MSR_CLK			(SYS_BASE + 13)
+#define CLKID_IR_CTRL			(SYS_BASE + 14)
+#define CLKID_AUDIO			(SYS_BASE + 15)
+#define CLKID_ETH			(SYS_BASE + 16)
+#define CLKID_UART_A			(SYS_BASE + 17)
+#define CLKID_UART_B			(SYS_BASE + 18)
+#define CLKID_UART_C			(SYS_BASE + 19)
+#define CLKID_UART_D			(SYS_BASE + 20)
+#define CLKID_UART_E			(SYS_BASE + 21)
+#define CLKID_AIFIFO			(SYS_BASE + 22)
+#define CLKID_TS_DDR			(SYS_BASE + 23)
+#define CLKID_TS_PLL			(SYS_BASE + 24)
+#define CLKID_G2D			(SYS_BASE + 25)
+#define CLKID_SPICC0			(SYS_BASE + 26)
+#define CLKID_SPICC1			(SYS_BASE + 27)
+#define CLKID_PCIE			(SYS_BASE + 28)
+#define CLKID_USB			(SYS_BASE + 29)
+#define CLKID_PCIE_PHY			(SYS_BASE + 30)
+#define CLKID_I2C_M_A			(SYS_BASE + 31)
+#define CLKID_I2C_M_B			(SYS_BASE + 32)
+#define CLKID_I2C_M_C			(SYS_BASE + 33)
+#define CLKID_I2C_M_D			(SYS_BASE + 34)
+#define CLKID_I2C_M_E			(SYS_BASE + 35)
+#define CLKID_I2C_M_F			(SYS_BASE + 36)
+#define CLKID_HDMITX_APB		(SYS_BASE + 37)
+#define CLKID_I2C_S_A			(SYS_BASE + 38)
+#define CLKID_USB1_TO_DDR		(SYS_BASE + 39)
+#define CLKID_AOCPU			(SYS_BASE + 40)
+#define CLKID_MMC_APB			(SYS_BASE + 41)
+#define CLKID_RSA			(SYS_BASE + 42)
+#define CLKID_AUCPU			(SYS_BASE + 43)
+#define CLKID_DSPA			(SYS_BASE + 44)
+#define CLKID_VPU_INTR			(SYS_BASE + 45)
+#define CLKID_SAR_ADC			(SYS_BASE + 46)
+#define CLKID_GIC			(SYS_BASE + 47)
+#define CLKID_PWM_AB			(SYS_BASE + 48)
+#define CLKID_PWM_CD			(SYS_BASE + 49)
+#define CLKID_PWM_EF			(SYS_BASE + 50)
+#define CLKID_PWM_GH			(SYS_BASE + 51)
+#define CLKID_PWM_AO_AB			(SYS_BASE + 52)
+#define CLKID_MIPI_DSI_A		(SYS_BASE + 53)
+#define CLKID_MIPI_DSI_B		(SYS_BASE + 54)
+#define CLKID_GDC			(SYS_BASE + 55)
+#define CLKID_DESWARP			(SYS_BASE + 56)
+#define CLKID_AMPIPE_NAND		(SYS_BASE + 57)
+#define CLKID_AMPIPE_ETH		(SYS_BASE + 58)
+#define CLKID_AM2AXI0			(SYS_BASE + 59)
+#define CLKID_AM2AXI1			(SYS_BASE + 60)
+#define CLKID_AM2AXI2			(SYS_BASE + 61)
+#define CLKID_PWM_AO_CD			(SYS_BASE + 62)
+#define CLKID_PWM_AO_EF			(SYS_BASE + 63)
+#define CLKID_PWM_AO_GH			(SYS_BASE + 64)
+#define CLKID_TS_NNA			(SYS_BASE + 65)
+#define CLKID_TS_GPU			(SYS_BASE + 66)
+#define CLKID_TS_HEVC			(SYS_BASE + 67)
+#define CLKID_DSPB			(SYS_BASE + 68)
+#define CLKID_SPICC2			(SYS_BASE + 69)
+#define CLKID_SPICC3			(SYS_BASE + 70)
+#define CLKID_SPICC4			(SYS_BASE + 71)
+#define CLKID_SPICC5			(SYS_BASE + 72)
+#define CLKID_I2C_AO_A			(SYS_BASE + 73)
+#define CLKID_I2C_AO_B			(SYS_BASE + 74)
+#define CLKID_UART_F			(SYS_BASE + 75)
+#define CLKID_MIPI_ISP_PCLK		(SYS_BASE + 76)
+#define CLKID_HDMIRX_PCLK		(SYS_BASE + 77)
+#define CLKID_PCLK_SYS_CPU_APB		(SYS_BASE + 78)
+#define CLKID_A73PCLK_CPU_APB		(SYS_BASE + 79)
+#define CLKID_TS_VPU			(SYS_BASE + 80)
+
+#define NR_CLKS				(SYS_BASE + 81)
+
+#endif /* __T7_CLKC_H */
--
2.41.0

