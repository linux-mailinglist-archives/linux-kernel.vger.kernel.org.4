Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1861F6CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiKGO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiKGOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:55:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A4F1E3FE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:55:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i21so17946283edj.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdBb6nGD4RtzMeFCF0mI0hXgihUtUj9UKHVMO3S1XYw=;
        b=tE9UgVX+L9hpaWpxckXaST/M9xzZhZFJ247XS/nQWuAdOzE9i+a4Puj9HnIcvgyMKJ
         fFfB2+zkGCQcs+TpbU7aS+FMmDBSrlJ6b4cR+solyXsKDHUta5wR8KIoFDWCT8MM7zi/
         wcLqzcgH15mXIdGjtta/inudCqfZULwGkvhL2feKeQRGgV4MyU9tAP0ZuN0Yg6Uu1Yok
         qGwkpe+wU7qkVI2KwWuPJTWTjnjOhODDul/QcyB9RqJ74AXKwFeEz/lTeq1Xzqh6F8UY
         5gS3vDxGnyx+Kz3jeUuick3cR0/nVqc+g1IAlTwSBrPxaq3ABTWWAqJSV15JEFJLv7iv
         SfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdBb6nGD4RtzMeFCF0mI0hXgihUtUj9UKHVMO3S1XYw=;
        b=IP9MWpDZT0Xf0QNPscNgVHqlpmbCcJewPtsMNCxZIDgr1S4NKetZYEwBmaRNuIsaAw
         2l0gZN5H4Q0nLXO7EaFJaHnQfWAcl+ftdV/9ZImAU4ZaDXsvOAhmDKuY6AtcZRteVrZ9
         TQi/EYcyxXkxUsO6cn0ezJslrKXwVZjwc1py+hZi7mipRoVDQW2cMSGfLci25zF+hPMK
         KdvB8yMJXv9mYcAiU46qn0EK1qAfQzHuFD5CATOdzDO4uf45shvbj4D4SPefVe0HnrAa
         p+KluEjQX/9ReS0hCDymRScML0j/AZTG6Q6k1mdUXXJrZGZgVV4voqSOie2z1UpwkmpQ
         2FPg==
X-Gm-Message-State: ACrzQf0CVTXuwa3HyY/uwsIjsGDEardNpLNnVkj4zuaUAjsBdV3aiv8A
        clT1gTtOtvExliAWdGwx7u/XVQ==
X-Google-Smtp-Source: AMsMyM6GdA0cFt5vchQrAwlYjCJEeZRHRs+ODCxUWXs2gBoK/ldVG6erdBp3IXVici6hF/wayLA4/A==
X-Received: by 2002:a05:6402:46:b0:45c:bd68:6ab0 with SMTP id f6-20020a056402004600b0045cbd686ab0mr51049112edu.16.1667832933383;
        Mon, 07 Nov 2022 06:55:33 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067f0100b0078907275a44sm3503049ejr.42.2022.11.07.06.55.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 06:55:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] arm64: dts: qcom: msm8998-*: Fix up comments
Date:   Mon,  7 Nov 2022 15:55:14 +0100
Message-Id: <20221107145522.6706-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107145522.6706-1-konrad.dybcio@linaro.org>
References: <20221107145522.6706-1-konrad.dybcio@linaro.org>
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

Switch '//' comments to C-style /* */ and fix up the contents of some.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts | 8 ++------
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts        | 8 ++------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 2aee2fd29a07..310f7a2df1e8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -310,15 +310,11 @@ &funnel3 {
 };
 
 &funnel4 {
-	// FIXME: Figure out why clock late_initcall crashes the board with
-	// this enabled.
-	// status = "okay";
+	/* FIXME: Figure out why clock late_initcall crashes the board with this enabled. */
 };
 
 &funnel5 {
-	// FIXME: Figure out why clock late_initcall crashes the board with
-	// this enabled.
-	// status = "okay";
+	/* FIXME: Figure out why clock late_initcall crashes the board with this enabled. */
 };
 
 &pcie0 {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index 00032ed3f4aa..453a1c9e9808 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -124,15 +124,11 @@ &funnel3 {
 };
 
 &funnel4 {
-	// FIXME: Figure out why clock late_initcall crashes the board with
-	// this enabled.
-	// status = "okay";
+	/* FIXME: Figure out why clock late_initcall crashes the board with this enabled. */
 };
 
 &funnel5 {
-	// FIXME: Figure out why clock late_initcall crashes the board with
-	// this enabled.
-	// status = "okay";
+	/* FIXME: Figure out why clock late_initcall crashes the board with this enabled. */
 };
 
 &pcie0 {
-- 
2.38.1

