Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF76F9B64
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjEGUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjEGUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8911574;
        Sun,  7 May 2023 13:12:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so42901901fa.2;
        Sun, 07 May 2023 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490374; x=1686082374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8I28e7y8DJIf9u5FBClsICPJaLiy43IFsBoaVHZx9g=;
        b=oAzMQtYgXWrLJsvcTWJGIC+RaWCOUkWHAIAwmfRo/MuEfu/HtjDsk5Y1HRkWsmg55t
         28uZ0HUd60Fiylp2uIOJiHzr4b3XNgjBQz+G+O7KxVQWwt9kMQHsserO4z2/6mnNO4eK
         fvi7Aa0BXBV2lgK+TmKmsZwM6Zjbrluds1LHk0pSehdBwhSF+Cfutjg9tUsv77I2SBsJ
         cWpR3HR2VoYnbY52kF7jdEyF/gmN65PSJJXHXUN6oxTe6Axrcsgtxay9RDSA4J/owZgV
         rls4ZYWn8Hwd92C2mOpviT+592DF5OTlxiTf6kUrrfUotK4822jhJyLQbYO3UQ0y9j6u
         O0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490374; x=1686082374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8I28e7y8DJIf9u5FBClsICPJaLiy43IFsBoaVHZx9g=;
        b=RujJT3Im0EBmwdYW05A0D8BFEdjl691jPIl5L8sEWbIeqICG4UifZBSHOSS3vHlZOu
         QrtyEfVi5Aq51iTFUEAcPnErniRJl1sLKQxcPmDvL93tJkzd+arbknu9I/dpbk3imY+0
         Q3dIaJi87CVOcRH4BO4/GFQ5l3mli92R9fDJ9A9hv/AVPFK7CO2fETpYjggqKGwj2h/X
         El+ux4UgbR0mY7mLBRMmJmVfgPm1wSNcutwstQAMYZrh9t5mFn6IecNYgIZgHdyTJW3e
         6DKe4GktOPlscTcRnzjn3990h8GA9p5aGj+7Ah+5ZSJ1jMyKUuaHPjODPGz0JhXJpplA
         TPdw==
X-Gm-Message-State: AC+VfDx7SkS0gIzcWcDp9LthNyS393wDxOcTb08mo0kN5bKjtxOt5AnL
        cxUQo1E5qRn6pl6x5t+1EInsU849+p2+/w==
X-Google-Smtp-Source: ACHHUZ4I9mnyZUeIfFQtOIkjIOBMjt3n6aUeDRXJSPfy9d/OT8PL8i0gtaiK8PnoOKeWoxK/L63JxQ==
X-Received: by 2002:a05:651c:110:b0:2a7:9b39:eff8 with SMTP id a16-20020a05651c011000b002a79b39eff8mr2291646ljb.6.1683490374249;
        Sun, 07 May 2023 13:12:54 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:53 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: dts: msm8226: Add tsens node and related nvmem cells
Date:   Sun,  7 May 2023 23:12:23 +0300
Message-Id: <20230507201225.89694-6-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify pre-parsed per-sensor calibration nvmem cells in the qfprom
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 113 ++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index c34b8f3139ae..a0c3d25eea65 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -500,6 +500,34 @@ data-pins {
 			};
 		};
 
+		tsens: thermal-sensor@fc4a9000 {
+			compatible = "qcom,msm8226-tsens", "qcom,tsens-v0_1";
+			reg = <0xfc4a9000 0x1000>, /* TM */
+			      <0xfc4a8000 0x1000>; /* SROT */
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s3_p1>, <&tsens_s3_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>,
+				      <&tsens_s5_p1>, <&tsens_s5_p2>,
+				      <&tsens_s6_p1>, <&tsens_s6_p2>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s3_p1", "s3_p2",
+					   "s4_p1", "s4_p2",
+					   "s5_p1", "s5_p2",
+					   "s6_p1", "s6_p2";
+			#qcom,sensors = <6>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
+			#thermal-sensor-cells = <1>;
+		};
+
 		restart@fc4ab000 {
 			compatible = "qcom,pshold";
 			reg = <0xfc4ab000 0x4>;
@@ -510,6 +538,91 @@ qfprom: qfprom@fc4bc000 {
 			reg = <0xfc4bc000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			tsens_base1: base1@1c1 {
+				reg = <0x1c1 0x2>;
+				bits = <5 8>;
+			};
+
+			tsens_s0_p1: s0-p1@1c2 {
+				reg = <0x1c2 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s1_p1: s1-p1@1c4 {
+				reg = <0x1c4 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s2_p1: s2-p1@1c4 {
+				reg = <0x1c4 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s3_p1: s3-p1@1c5 {
+				reg = <0x1c5 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s4_p1: s4-p1@1c6 {
+				reg = <0x1c6 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s5_p1: s5-p1@1c7 {
+				reg = <0x1c7 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s6_p1: s6-p1@1ca {
+				reg = <0x1ca 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_base2: base2@1cc {
+				reg = <0x1cc 0x1>;
+				bits = <0 8>;
+			};
+
+			tsens_s0_p2: s0-p2@1cd {
+				reg = <0x1cd 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s1_p2: s1-p2@1cd {
+				reg = <0x1cd 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s2_p2: s2-p2@1ce {
+				reg = <0x1ce 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s3_p2: s3-p2@1cf {
+				reg = <0x1cf 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s4_p2: s4-p2@446 {
+				reg = <0x446 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s5_p2: s5-p2@447 {
+				reg = <0x447 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s6_p2: s6-p2@44e {
+				reg = <0x44e 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_mode: mode@44f {
+				reg = <0x44f 0x1>;
+				bits = <5 3>;
+			};
 		};
 
 		spmi_bus: spmi@fc4cf000 {
-- 
2.34.1

