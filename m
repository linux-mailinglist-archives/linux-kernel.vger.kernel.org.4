Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42506624DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKJWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiKJWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:45:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52FC4875B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:45:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so5775024lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnPc8TYCk0gx8Cqe8IjyEVkrsOdsYrHFpEqZ4PLg4sQ=;
        b=Gvr3SeMM8yM7/1PgawPRk+ijYAT7vKjxJa1laLUN/5xxmoRZof5WuEVKR9fT30RPO9
         qU7mjSduCPChzKh07wcfNLF2BU/fEzwcTnyj54Ij5kJchY77aNDRvFXM13tuotBRUQND
         2GGgJ+YVhmdip+vGtfGpmc76gbyzNL0Uc0l8O+WNvp8gquGpYtMcTlefLVXsESMY/yK4
         cvj5/zrhEVjMQrTCwoTkrNRBgsHACo4BaGzmI9LIwzlgvykwNrQbroHOBJrshzKyV5AE
         ULKqIn2nweWLuNpaTy6wWrMi76fZ5tjcFp7nwMazuXzO0XzgXvOSsEtTXB0M85wiM0ni
         pa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnPc8TYCk0gx8Cqe8IjyEVkrsOdsYrHFpEqZ4PLg4sQ=;
        b=Qh4dIHSKAseZqqjafzipb9R5Wl6KziTNI1B7Hu7Mt44woE3V7YdCD0sz+3GDAdhwKx
         jAfTuWjkCuDBYkQEuhIDJy8UYwW1GKFHk3/n+PlxnOFNWQhVfJ6HAHi2xc0/GttJw2BA
         K3wr7gs+cEt4OWi8D08TZVFdaz3rTB/rwSGIyGNLyI+zDCnOUiV7s9ORV+MoRuOX+pHX
         j8RUJp9lxB4YGepsY3EMEA1eMG/62R3RhPeBU67ntfnk+JAlQAMYVcrOLw9BP3t7hkKg
         70Sc2Mb86G/LQ6ZzqEeIhzMRfjFcJOf/alRv1wJsu8tTmaj4Gs1XhXrWaEj/ih8U4pU/
         msWg==
X-Gm-Message-State: ACrzQf1FOPhuQ4jeZrJ1CEG4il5Ih6QLYuzbe1O8Zx//KNyADsw6Q95K
        PBB+CMICGkmy2vwtegP7Wx418A==
X-Google-Smtp-Source: AMsMyM4Xy9QTL5LL5+b8VjF7kTfiz6cYp1Rn3+/rF6MOsTLPCK0kKtCwnL3583Pih321tY5OQbSk8A==
X-Received: by 2002:a19:6d12:0:b0:4b1:7c15:e923 with SMTP id i18-20020a196d12000000b004b17c15e923mr1915751lfc.320.1668120350099;
        Thu, 10 Nov 2022 14:45:50 -0800 (PST)
Received: from localhost.localdomain (95.49.32.193.neoplus.adsl.tpnet.pl. [95.49.32.193])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651239c400b0048a934168c0sm55315lfu.35.2022.11.10.14.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:45:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8450: Add Xperia 5 IV support
Date:   Thu, 10 Nov 2022 23:39:28 +0100
Message-Id: <20221110223929.134655-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110223929.134655-1-konrad.dybcio@linaro.org>
References: <20221110223929.134655-1-konrad.dybcio@linaro.org>
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
index 000000000000..12c0e6555205
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
+	imx563_vdig_vreg: imx563-vdig-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "imx563_vdig_vreg";
+		gpio = <&tlmm 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
-- 
2.38.1

