Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673272598C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbjFGJIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjFGJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:07:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108EA1FFD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:07:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25695bb6461so291807a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686128824; x=1688720824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wS6HxZPw2hCtPpYfVzkDvRLSG1OCC/WwrM2i4bBWC8=;
        b=baZZe3lqESYWGumgMh7CEq9Lxbk6JmjVPVuWT4RYgVvGzdaGR1uLOopN/dMuwj7eru
         zep0o9s8amPjMM4/2Bg9fmE3at6+zmzgKCpn5ug1C1Hp18YouV5JYgurvWFKxKYoNqfq
         S0B3if2E6tv5VbOber8WdL2jUoeAXEIvxbIhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128824; x=1688720824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wS6HxZPw2hCtPpYfVzkDvRLSG1OCC/WwrM2i4bBWC8=;
        b=WgDT5wVTm34JjfHyUK1ORlqJ4sEE/p3pFNhXcup+raXo2df6AFjfmzt1wih3pnBUMV
         ov6KU0PgT7xYosvf+3Pw4TU5FKT37Or7TpBZzWlHIXXFATlGiOoiuLooQZv3+AqjePl1
         qfC6lbr/aENy0hF7Mz+j6/xVRfLM8WGJmOnAeZqsNxVjkqstEtPXwRw3V6eAHXZT2JFK
         ag2MLXvf0w0Wi1VcQBvl6Oz6r7nVynRaxdsnEpYGkCNpj1PHAB+8/AMzC/YqHSPlNP3n
         9aGf2JOTETDOZ3Fs7YUWTC2vuN5mOeeaa2uP9ucnlR5YdUYDfbQOrePyi7nrfqL2utvE
         iCTg==
X-Gm-Message-State: AC+VfDwfeaE1hr6ylBpGnd3uYLcb0K6tJsUlWG+HuuYYsLlq1s6JDWoU
        WoomlApYkWufLYS623MEQG7m/Q==
X-Google-Smtp-Source: ACHHUZ6h8JcuMSr2FthOK/WjB3Ue97GVrH04em6wr2nFCYYUR2itTbKu81vB4TLCqzX9H2XPfYKuGg==
X-Received: by 2002:a17:90a:67ca:b0:256:9b5c:2aa2 with SMTP id g10-20020a17090a67ca00b002569b5c2aa2mr5718892pjm.6.1686128824493;
        Wed, 07 Jun 2023 02:07:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:443b:29bb:b677:185d])
        by smtp.gmail.com with ESMTPSA id b38-20020a631b66000000b0051eff0a70d7sm8505732pgm.94.2023.06.07.02.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:07:04 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/4] arm64: dts: mediatek: mt8186: Wire up CPU frequency/voltage scaling
Date:   Wed,  7 Jun 2023 17:06:50 +0800
Message-ID: <20230607090653.2468317-3-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230607090653.2468317-1-wenst@chromium.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds clocks, dynamic power coefficients, and OPP tables for the CPU
cores, so that everything required at the SoC level for CPU freqency and
voltage scaling is available.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 274 +++++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 1b754f7a0725..6735c1feb26d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -136,6 +136,240 @@ cci_opp_15: opp-1400000000 {
 		};
 	};
 
+	cluster0_opp: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <600000>;
+			opp-level = <15>;
+			required-opps = <&cci_opp_0>;
+		};
+
+		opp-774000000 {
+			opp-hz = /bits/ 64 <774000000>;
+			opp-microvolt = <675000>;
+			opp-level = <14>;
+			required-opps = <&cci_opp_1>;
+		};
+
+		opp-875000000 {
+			opp-hz = /bits/ 64 <875000000>;
+			opp-microvolt = <700000>;
+			opp-level = <13>;
+			required-opps = <&cci_opp_2>;
+		};
+
+		opp-975000000 {
+			opp-hz = /bits/ 64 <975000000>;
+			opp-microvolt = <725000>;
+			opp-level = <12>;
+			required-opps = <&cci_opp_3>;
+		};
+
+		opp-1075000000 {
+			opp-hz = /bits/ 64 <1075000000>;
+			opp-microvolt = <750000>;
+			opp-level = <11>;
+			required-opps = <&cci_opp_4>;
+		};
+
+		opp-1175000000 {
+			opp-hz = /bits/ 64 <1175000000>;
+			opp-microvolt = <775000>;
+			opp-level = <10>;
+			required-opps = <&cci_opp_5>;
+		};
+
+		opp-1275000000 {
+			opp-hz = /bits/ 64 <1275000000>;
+			opp-microvolt = <800000>;
+			opp-level = <9>;
+			required-opps = <&cci_opp_6>;
+		};
+
+		opp-1375000000 {
+			opp-hz = /bits/ 64 <1375000000>;
+			opp-microvolt = <825000>;
+			opp-level = <8>;
+			required-opps = <&cci_opp_7>;
+		};
+
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <856250>;
+			opp-level = <7>;
+			required-opps = <&cci_opp_8>;
+		};
+
+		opp-1618000000 {
+			opp-hz = /bits/ 64 <1618000000>;
+			opp-microvolt = <875000>;
+			opp-level = <6>;
+			required-opps = <&cci_opp_9>;
+		};
+
+		opp-1666000000 {
+			opp-hz = /bits/ 64 <1666000000>;
+			opp-microvolt = <900000>;
+			opp-level = <5>;
+			required-opps = <&cci_opp_10>;
+		};
+
+		opp-1733000000 {
+			opp-hz = /bits/ 64 <1733000000>;
+			opp-microvolt = <925000>;
+			opp-level = <4>;
+			required-opps = <&cci_opp_11>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <950000>;
+			opp-level = <3>;
+			required-opps = <&cci_opp_12>;
+		};
+
+		opp-1866000000 {
+			opp-hz = /bits/ 64 <1866000000>;
+			opp-microvolt = <981250>;
+			opp-level = <2>;
+			required-opps = <&cci_opp_13>;
+		};
+
+		opp-1933000000 {
+			opp-hz = /bits/ 64 <1933000000>;
+			opp-microvolt = <1006250>;
+			opp-level = <1>;
+			required-opps = <&cci_opp_14>;
+		};
+
+		opp-2000000000 {
+			opp-hz = /bits/ 64 <2000000000>;
+			opp-microvolt = <1031250>;
+			opp-level = <0>;
+			required-opps = <&cci_opp_15>;
+		};
+	};
+
+	cluster1_opp: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-774000000 {
+			opp-hz = /bits/ 64 <774000000>;
+			opp-microvolt = <675000>;
+			opp-level = <15>;
+			required-opps = <&cci_opp_0>;
+		};
+
+		opp-835000000 {
+			opp-hz = /bits/ 64 <835000000>;
+			opp-microvolt = <693750>;
+			opp-level = <14>;
+			required-opps = <&cci_opp_1>;
+		};
+
+		opp-919000000 {
+			opp-hz = /bits/ 64 <919000000>;
+			opp-microvolt = <718750>;
+			opp-level = <13>;
+			required-opps = <&cci_opp_2>;
+		};
+
+		opp-1002000000 {
+			opp-hz = /bits/ 64 <1002000000>;
+			opp-microvolt = <743750>;
+			opp-level = <12>;
+			required-opps = <&cci_opp_3>;
+		};
+
+		opp-1085000000 {
+			opp-hz = /bits/ 64 <1085000000>;
+			opp-microvolt = <775000>;
+			opp-level = <11>;
+			required-opps = <&cci_opp_4>;
+		};
+
+		opp-1169000000 {
+			opp-hz = /bits/ 64 <1169000000>;
+			opp-microvolt = <800000>;
+			opp-level = <10>;
+			required-opps = <&cci_opp_5>;
+		};
+
+		opp-1308000000 {
+			opp-hz = /bits/ 64 <1308000000>;
+			opp-microvolt = <843750>;
+			opp-level = <9>;
+			required-opps = <&cci_opp_6>;
+		};
+
+		opp-1419000000 {
+			opp-hz = /bits/ 64 <1419000000>;
+			opp-microvolt = <875000>;
+			opp-level = <8>;
+			required-opps = <&cci_opp_7>;
+		};
+
+		opp-1530000000 {
+			opp-hz = /bits/ 64 <1530000000>;
+			opp-microvolt = <912500>;
+			opp-level = <7>;
+			required-opps = <&cci_opp_8>;
+		};
+
+		opp-1670000000 {
+			opp-hz = /bits/ 64 <1670000000>;
+			opp-microvolt = <956250>;
+			opp-level = <6>;
+			required-opps = <&cci_opp_9>;
+		};
+
+		opp-1733000000 {
+			opp-hz = /bits/ 64 <1733000000>;
+			opp-microvolt = <981250>;
+			opp-level = <5>;
+			required-opps = <&cci_opp_10>;
+		};
+
+		opp-1796000000 {
+			opp-hz = /bits/ 64 <1796000000>;
+			opp-microvolt = <1012500>;
+			opp-level = <4>;
+			required-opps = <&cci_opp_11>;
+		};
+
+		opp-1860000000 {
+			opp-hz = /bits/ 64 <1860000000>;
+			opp-microvolt = <1037500>;
+			opp-level = <3>;
+			required-opps = <&cci_opp_12>;
+		};
+
+		opp-1923000000 {
+			opp-hz = /bits/ 64 <1923000000>;
+			opp-microvolt = <1062500>;
+			opp-level = <2>;
+			required-opps = <&cci_opp_13>;
+		};
+
+		cluster1_opp_14: opp-1986000000 {
+			opp-hz = /bits/ 64 <1986000000>;
+			opp-microvolt = <1093750>;
+			opp-level = <1>;
+			required-opps = <&cci_opp_14>;
+		};
+
+		cluster1_opp_15: opp-2050000000 {
+			opp-hz = /bits/ 64 <2050000000>;
+			opp-microvolt = <1118750>;
+			opp-level = <0>;
+			required-opps = <&cci_opp_15>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -182,6 +416,11 @@ cpu0: cpu@0 {
 			reg = <0x000>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -201,6 +440,11 @@ cpu1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -220,6 +464,11 @@ cpu2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -239,6 +488,11 @@ cpu3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -258,6 +512,11 @@ cpu4: cpu@400 {
 			reg = <0x400>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -277,6 +536,11 @@ cpu5: cpu@500 {
 			reg = <0x500>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -296,6 +560,11 @@ cpu6: cpu@600 {
 			reg = <0x600>;
 			enable-method = "psci";
 			clock-frequency = <2050000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_BL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
+			dynamic-power-coefficient = <335>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
@@ -315,6 +584,11 @@ cpu7: cpu@700 {
 			reg = <0x700>;
 			enable-method = "psci";
 			clock-frequency = <2050000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_BL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
+			dynamic-power-coefficient = <335>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
-- 
2.41.0.rc0.172.g3f132b7071-goog

