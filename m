Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9392B6279D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiKNJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiKNJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:58:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA61F2F8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g12so18429307lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRS7PBGZp4XrpSqD1cc049+5M2adrMuAS40ElKEXgN4=;
        b=du8uD/HdudnVC4I3bifU1xX2zSxTqtL4WLiCwoaZX2sPn4QdTRrUXnNGI4K/FnCgek
         Db/y4d4/DvnewgWFxxUI8TTas9JK0ljyJwNoSUZDqG/Vl2YJ99lRpYzwtrWjgfeeMC2K
         K2rPVgNgSi0Ejk2WYjZt7/HUY0TTox+NsUgmCr1YWrCx0O5G+bDGHi6stlo/RYdqUtaO
         SqzE7JHQAVPrUssoy+euIBSh7hC0v7xcSZxja3XJsrEP870e37xITFInu/0y6uSzTT1+
         7XdjQujnOp+hWM6mB6UuR2n/ldIHfGBtHmB7tmYN4YOyFLhbgHvNZIOawTn7fHLQEr6O
         ZmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRS7PBGZp4XrpSqD1cc049+5M2adrMuAS40ElKEXgN4=;
        b=MMPiVczl2jb8WBRZ4ReaFWtUAOWtyDvjV4idDS1OWepP8jc998QcCzxOm4xT/Wykc+
         SEjydV9q9NuenVeavwB08H+5p3bMWWgBB37QEbOgAktILZlEzjoFAqg+tvydgltQovA1
         5Nm0Z/XM6C9TskA6hxIgymt452x5aBtd7H0GTDhu5PBh6KZs6tLuPD+JFa64HzVtJQ2v
         HIOKVBNK2JLLD2AV51eo4C+Xv60KQfjPeLjnOQtvGA0i5GGC4LKI9QQFZmwQRfOaBO7B
         1soOH+JZ1OZz5dC3/8npUuNRT1M4TGDNiAz/qf08CFdoIOD76kHuxGU8AFQ5nlci+vDf
         mvkg==
X-Gm-Message-State: ANoB5plXTCNLiqQnAeeapaL/oGWsqnIt4wHmCHTbCPbe0BfP9GINqgzn
        e2QHUl5B9KUEHxelZUppbTnxRA==
X-Google-Smtp-Source: AA0mqf6J/0GDhZ5dZx8H2IlcyFgvQTDMDmpBbEcVxbIhPmkuWQAlQ+LmWg8tm0kafcFWBm+128B2VA==
X-Received: by 2002:ac2:48a4:0:b0:4a2:3955:109a with SMTP id u4-20020ac248a4000000b004a23955109amr4560892lfg.73.1668419826179;
        Mon, 14 Nov 2022 01:57:06 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id p12-20020a2eb98c000000b00278e7800715sm1832012ljp.16.2022.11.14.01.57.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 01:57:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8450: Add Xperia 5 IV support
Date:   Mon, 14 Nov 2022 10:56:53 +0100
Message-Id: <20221114095654.34561-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114095654.34561-1-konrad.dybcio@linaro.org>
References: <20221114095654.34561-1-konrad.dybcio@linaro.org>
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

Add a device tree for the Xperia 5 IV (pdx224). It's literally the 1 IV
with a smaller body, different panel, one camera lens (not sensor afaict)
swapped out and no 3D iToF sensor, hence the device-specific DT is tiny.

Be sure to follow the vbmeta disablement steps (detailed in pdx223
introduction commit message), otherwise your phone will not boot and
will reject anything and everything with just a non-descriptive
"Your device is corrupted" followed by a sad reboot. This should not
be the case, as vbmeta should be plainly ignored in unlocked state,
but what can we do..

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- use a common suffix for the fixed regulator node name

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/sm8450-sony-xperia-nagara-pdx224.dts | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d534888bcfe5..804bbd070fec 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -168,3 +168,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
new file mode 100644
index 000000000000..0d64d3c0afed
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sm8450-sony-xperia-nagara.dtsi"
+
+/ {
+	model = "Sony Xperia 5 IV";
+	compatible = "sony,pdx224", "qcom,sm8450";
+
+	imx563_vdig_vreg: imx563-vdig-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "imx563_vdig_vreg";
+		gpio = <&tlmm 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
-- 
2.38.1

