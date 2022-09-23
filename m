Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A85E7C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiIWOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiIWOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:09:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A739BBA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:09:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so286985plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JHh+MG4OU/+wjbCiWOKQq0gX7ZmA4UN476SmJdYV9kg=;
        b=U06hAzEw46JykwIVtPIzpMDYvAl26vQI1I8ivgPa40TGh/65Es0C35DskYxRG31wlg
         /wWNDUHfEpDyS7yyAkUTzPiZSQ5+O08XQh5sMxAJCYuKERZ5wEdge9a4dkmdbaqXp61o
         YP60uW1F6EuBJwk5BHO76wl5T4Z35MJg0Usx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JHh+MG4OU/+wjbCiWOKQq0gX7ZmA4UN476SmJdYV9kg=;
        b=ZJ2dmVwpjBRz8aHJc2WvUXu9G0drlmwAB3QSOHXcLjjodBEZ3ql15LUysKzAj5zRjt
         PasodNeRkruThMJ0S1pI/JFhRkxuAr0bbn/K8EgC80Vg2JsRl80qyIeSkalSCY5hDxhj
         fUgk0hBRcJTQ8ryuQPlUZHPj4GyfhcpIwX4SLrHVF+dDXCGIcdeLDqC5o2QwtzQW5Ky9
         d1R9TdMf7F4LerGg3GJejkZuq+ZJGN23DxqZaQLnQwbDfC2tfFP1fy4FyGK5/01aAxAa
         l39kjfBwvYZQgnSpBIXJp0h5iUdkrKL8gVBaNv8nQkBxyfrKcmFES4U4ZC/0Ktmg53yQ
         TLUQ==
X-Gm-Message-State: ACrzQf3LgANDXauHOCLUb+pxue1yyXs5ENY3aYv8FxHvZ2Qmx3viMkEt
        hqvqwbt3dlfiVcNIxgqnNsiKSw==
X-Google-Smtp-Source: AMsMyM70CiterdwYx5puGOdjCWm26ncekiCeYfeMZdG6g+/Ju8mIOv+oUSp8FaLtCGSLPKdQiRnUmQ==
X-Received: by 2002:a17:902:7c02:b0:178:3670:944b with SMTP id x2-20020a1709027c0200b001783670944bmr8816294pll.148.1663942189865;
        Fri, 23 Sep 2022 07:09:49 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a408e00b001fd8316db51sm1645318pjg.7.2022.09.23.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:09:48 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
Date:   Fri, 23 Sep 2022 14:09:17 +0000
Message-Id: <20220923140918.2825043-3-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923140918.2825043-1-judyhsiao@chromium.org>
References: <20220923140918.2825043-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio dtsi for sc7280 boards that using rt5682 headset codec:
1. Add dt nodes for sound card which use I2S playback and record
   through rt5682s and I2S playback through max98357a.
2. Enable lpass cpu node and add pin control and dai-links.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
new file mode 100644
index 000000000000..2dbdeeb29ece
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ *
+ * This file defines the common audio settings for the child boards
+ * using rt5682 codec.
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/ {
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-rt5682-max98360a-1mic";
+
+		status = "okay";
+		audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dai-link@0 {
+			link-name = "MAX98360";
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+			};
+
+			codec {
+				sound-dai = <&max98360a>;
+			};
+		};
+
+		dai-link@1 {
+			link-name = "ALC5682";
+			reg = <1>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_PRIMARY>;
+			};
+
+			codec {
+				sound-dai = <&alc5682 0 /* aif1 */>;
+			};
+		};
+	};
+};
+
+hp_i2c: &i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	alc5682: codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_irq>;
+
+		#sound-dai-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <101 IRQ_TYPE_EDGE_BOTH>;
+
+		AVDD-supply = <&pp1800_alc5682>;
+		MICVDD-supply = <&pp3300_codec>;
+
+		realtek,dmic1-data-pin = <1>;
+		realtek,dmic1-clk-pin = <2>;
+		realtek,jd-src = <1>;
+		realtek,dmic-clk-rate-hz = <2048000>;
+	};
+};
+
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
+			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dai-link@0 {
+		reg = <MI2S_PRIMARY>;
+		qcom,playback-sd-lines = <1>;
+		qcom,capture-sd-lines = <0>;
+	};
+
+	dai-link@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+};
+
+&mi2s0_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_data1 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_mclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
-- 
2.37.3.998.g577e59143f-goog

