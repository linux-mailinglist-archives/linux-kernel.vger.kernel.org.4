Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FB1650C90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiLSNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiLSNT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:19:27 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A49FD18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:19:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m29so13372448lfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuTm8winyF6vQ9ZUYWHIldSVWTLw8cyqmI/px190J20=;
        b=dyUWL/VRrHv39/YQyes7wxUz7DJGIuejeh7WTRpPTtcolJc5xaDKqFzMorIAv3y+Vj
         U0EEO+B4rX8CSLCgAf+4z7rBHp9u95Hochvs3wUy8QS0tpqBbwUJ7UwqBSeXi7CmLk7N
         MDiVdDSc0+HnskRKbXBBQUD6ekAlS7s6NLF3f5sELfYYL1DW3v28pHdLCf3wACKoYeWH
         IF+kkHhDqFtJiApvXo9OnM6EQUnqwqL0QBH8xyBMCl4ewfu7jJKhf0T9rfB87yxEd2Uy
         krAfXcAABsUivSXvAxCBkkilvoN65JNabt2K6o/4n3fKTS/ljES0rrD+Ty3gniN3drIZ
         CFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuTm8winyF6vQ9ZUYWHIldSVWTLw8cyqmI/px190J20=;
        b=J7CaoXyz68ACrbbSY1tCbDQGJ44N8RpuiqOGldriiX9uO5m9CtFwJElhcTV5eT/9Uz
         fUxNpD5vd4ybz1aI3OeXnTLEoL/U9HyQt23Pv8oJcHph/3T92SVkzUQ8E2bW/8E3eqtw
         fmCUPoidJXACj2HvisSpXCHN6huisbN6O8nSOzv/I6jNb92R3RJuQxjM98w8AuQZKCp4
         yddP0f9c4Wec0vmHBSDJwL1iVwuPmeWqGF1UG5cJdkT8DIcSKE+DZBdJGrW98oJAgmAx
         CKvg7O3ZOJ3IQqJnIcUr7hy1/+2tvC7l3jMjUyu8T9UzMlJTrMijFju0h/i8MzX89nYj
         L12Q==
X-Gm-Message-State: ANoB5pntZhGp58GX91vdpovGqOZXpeN0cvMNVrI8iXl+wh10n8j05LTf
        k0j1lZDNvQRnDuwFS/Y7grwabg==
X-Google-Smtp-Source: AA0mqf7o8ZFA4nXhz2FfebZRlhT7eYPDcMN43kI9LXbZdTusfoCm+jEO8ImJ2S5EHRHZ7ECcM9Lxdw==
X-Received: by 2002:a05:6512:3772:b0:4b5:7762:5df2 with SMTP id z18-20020a056512377200b004b577625df2mr11434689lft.36.1671455963943;
        Mon, 19 Dec 2022 05:19:23 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512370f00b004b581ab4c77sm1099501lfr.78.2022.12.19.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 05:19:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: msm8992-libra: Fix the memory map
Date:   Mon, 19 Dec 2022 14:19:18 +0100
Message-Id: <20221219131918.446587-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219131918.446587-1-konrad.dybcio@linaro.org>
References: <20221219131918.446587-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory map was wrong. Fix it to prevent the device from randomly
rebooting.

Fixes: 0f5cdb31e850 ("arm64: dts: qcom: Add Xiaomi Libra (Mi 4C) device tree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    | 77 +++++++++++++++----
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index b242c272d2af..fcca1ba94da6 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -11,6 +11,12 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 
+/delete-node/ &adsp_mem;
+/delete-node/ &audio_mem;
+/delete-node/ &mpss_mem;
+/delete-node/ &peripheral_region;
+/delete-node/ &rmtfs_mem;
+
 / {
 	model = "Xiaomi Mi 4C";
 	compatible = "xiaomi,libra", "qcom,msm8992";
@@ -70,25 +76,67 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		/* This is for getting crash logs using Android downstream kernels */
-		ramoops@dfc00000 {
-			compatible = "ramoops";
-			reg = <0x0 0xdfc00000 0x0 0x40000>;
-			console-size = <0x10000>;
-			record-size = <0x10000>;
-			ftrace-size = <0x10000>;
-			pmsg-size = <0x20000>;
+		memory_hole: hole@6400000 {
+			reg = <0 0x06400000 0 0x600000>;
+			no-map;
+		};
+
+		memory_hole2: hole2@6c00000 {
+			reg = <0 0x06c00000 0 0x2400000>;
+			no-map;
+		};
+
+		mpss_mem: mpss@9000000 {
+			reg = <0 0x09000000 0 0x5a00000>;
+			no-map;
+		};
+
+		tzapp: tzapp@ea00000 {
+			reg = <0 0x0ea00000 0 0x1900000>;
+			no-map;
+		};
+
+		mdm_rfsa_mem: mdm-rfsa@ca0b0000 {
+			reg = <0 0xca0b0000 0 0x10000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs@ca100000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xca100000 0 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
 		};
 
-		modem_region: modem_region@9000000 {
-			reg = <0x0 0x9000000 0x0 0x5a00000>;
+		audio_mem: audio@cb400000 {
+			reg = <0 0xcb000000 0 0x400000>;
+			no-mem;
+		};
+
+		qseecom_mem: qseecom@cb400000 {
+			reg = <0 0xcb400000 0 0x1c00000>;
+			no-mem;
+		};
+
+		adsp_rfsa_mem: adsp-rfsa@cd000000 {
+			reg = <0 0xcd000000 0 0x10000>;
 			no-map;
 		};
 
-		tzapp: modem_region@ea00000 {
-			reg = <0x0 0xea00000 0x0 0x1900000>;
+		sensor_rfsa_mem: sensor-rfsa@cd010000 {
+			reg = <0 0xcd010000 0 0x10000>;
 			no-map;
 		};
+
+		ramoops@dfc00000 {
+			compatible = "ramoops";
+			reg = <0 0xdfc00000 0 0x40000>;
+			console-size = <0x10000>;
+			record-size = <0x10000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x20000>;
+		};
 	};
 };
 
@@ -130,11 +178,6 @@ &blsp2_uart2 {
 	status = "okay";
 };
 
-&peripheral_region {
-	reg = <0x0 0x7400000 0x0 0x1c00000>;
-	no-map;
-};
-
 &pm8994_spmi_regulators {
 	VDD_APC0: s8 {
 		regulator-min-microvolt = <680000>;
-- 
2.39.0

