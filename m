Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758AE61F6D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiKGO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiKGOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:55:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA91EADB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:55:47 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b2so30799482eja.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOtt4TgnKXp9fj1DHy8FkNetuTYDbpK+ZsFHgnK7rY0=;
        b=kfFS0dWaJljMpp43/JDMAZ1AOos71/7++MW6Svbzn38EPnfSBiEqYbo56N7vk05+j1
         2qkv4hkISXgaxD8bbuArwhh5GB8LsfTmqDikKGcBMbm+czrYt2m/+H1IZHtALUbGk/oO
         xL9j9OvT4oLKP0TAQTqYGCqeyoPSdPr4FQByGZsndSivpYCurZE3REcf3c3tjPGM9ABK
         b3Ck/gDGM6UPKPjHDCNaUbV4poO0Xru+qjj1FPSCIuxaCXVb/p/eErQh5jmqwJPnPU4Z
         f2vFzV90JyXUvd+mhIlPvzzOHUKg2SpKgmtg+eHnRi9AQc9lPeSpY+ofJ93s3P1bZK2U
         InMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOtt4TgnKXp9fj1DHy8FkNetuTYDbpK+ZsFHgnK7rY0=;
        b=EjV1tMFtrGa69FwBZxZqORKIM8to14dI+tx4Udr2f4EyDkHnKwniK5dJjTFsKnoaFj
         dcRF9gmUyu9//2kPwX2mjn5uJUPxHXgtqZDwMMQyLHtK9bNpvmEuXO0/PvSwNQr/d5xV
         hvpVGQNEWIzA1XUgjfDk4II40Pq5QfE5KQiRAYLvza/8+6b50e7GUVjjAlIcFcAQwdK4
         4P3zKsXLlKiCKZCUPsyQeXIJZcyQKlMoujrp1l7fLWBqS+r6xXWJ8nvLOWuvMEIRzLny
         oAskdRHo6mSOopEH2o8ulCXMk+vGFpWl0rNsXKNbiqwXxerS2ZQJEhHA2HPhRgkH/XFu
         qucQ==
X-Gm-Message-State: ACrzQf21VJYDZbHrqdOViW6ze8J2HpfbOjpdGtLtdmfo0kv/OEL060r+
        SWqk4cK12GhkOgQKT+nmkROy8A==
X-Google-Smtp-Source: AMsMyM5gcZ/fxE4XfsOW46/dE5R6NZqw+sdEe12gWdgwA4ewT7cC//LxFyj19QYw3ABEPc2jeH18/A==
X-Received: by 2002:a17:907:608d:b0:7a2:b93e:a765 with SMTP id ht13-20020a170907608d00b007a2b93ea765mr48933718ejc.273.1667832946752;
        Mon, 07 Nov 2022 06:55:46 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067f0100b0078907275a44sm3503049ejr.42.2022.11.07.06.55.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 06:55:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] arm64: dts: qcom: qcs404-*: Fix up comments
Date:   Mon,  7 Nov 2022 15:55:20 +0100
Message-Id: <20221107145522.6706-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107145522.6706-1-konrad.dybcio@linaro.org>
References: <20221107145522.6706-1-konrad.dybcio@linaro.org>
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

Switch '//' comments to C-style /* */.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts | 4 +++-
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 4 +++-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 4 +++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi         | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
index 937eb4555ffe..fc29b194cd34 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018, Linaro Limited
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
index 08d5d51221cf..047b74d912a1 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018, Linaro Limited
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index dbbe1653718b..c6f8b5b15825 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018, Linaro Limited
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
 
 #include <dt-bindings/gpio/gpio.h>
 #include "qcs404.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 80f2d05595fa..b4b89346b492 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018, Linaro Limited
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
-- 
2.38.1

