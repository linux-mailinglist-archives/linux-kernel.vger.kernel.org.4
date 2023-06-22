Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B218A739C04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjFVJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjFVJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:04:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB549FC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa71db41b6so4514655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424257; x=1690016257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW7sKGgRKZW5eL7/ybizx1B1Ffk8j/MezoGO0WjGvjA=;
        b=iZf7oY0tIXZmjts1/W1LHlxlUExPyZh7LA82h38ic9bG2O5Rydgc/MXeQJeExkkXBh
         0r2JoaSPky6RBeQ/niteUinqeM4ZuBZ9ygFk2D5pFTI55bMsRseKACjONaO+UezjpRbk
         2woz20r6SBJtf67r/9bB75tZxLOb7UNVVHSD62FSWQnd+mFKP2pAzHORjS3wX/si8EkH
         Fwcng5n1TGyFnuVCRSzNLvFZgT2IwqzRuwuVyfmVlaqOMtGkHItJrOsYhsjKoKHzWKrW
         41Hp5ilKlFro3glo2na1YBllw3tvU9+hfYhOvW+N+MI7G+raAMeUkd4Zhb7iJ5BPH1Pd
         mO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424257; x=1690016257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW7sKGgRKZW5eL7/ybizx1B1Ffk8j/MezoGO0WjGvjA=;
        b=EEJDY3Z61sZCEhb/0xxowcU1eWFFt8ZMHohkv+iIobXddgM4qO7rpVytcUs0XYeKTM
         AV0RxPWCrcBg765gc3eGJZH2GCfBqDKbwaQf5qVphJgIVdi1uzQVMk/Wkx9JScYtNCCf
         kPsXmqlks6lLZs1XDUxR2IEPcpHQ88Qfhl3QcywCMzzjAf32BaFEAreWfq2fJwKk7eV1
         Z8YQxNW0GXgo9eTYWU5d+lu2RwHl6vM8CBjJfgymGSmlBTrpYNWjemIjxGNMfBxy/QTA
         2aEBnzkBfXAxT04KHYIdHBPWZMmpD/snELyNDjoe/8lM7lMXZN2tUH6vw9aB38VXER9h
         wZ1g==
X-Gm-Message-State: AC+VfDyCkxHzmiFrcUseqdriZolOxA3/CxvSdiAOV9RtQK91YGV/mi9h
        tQZIO8UWpocS/GxtlwYzMB5AQw==
X-Google-Smtp-Source: ACHHUZ6R9CbR2XQNsBZoYCnt6a78K8PDuAN+Zm4IodxE76Li7pGvAZU90JJtmpP1u31kglIrV4Bx/g==
X-Received: by 2002:a7b:cd8a:0:b0:3f9:b975:a0d7 with SMTP id y10-20020a7bcd8a000000b003f9b975a0d7mr4604105wmj.1.1687424257525;
        Thu, 22 Jun 2023 01:57:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c20ca00b003f9b29ba838sm7136305wmm.35.2023.06.22.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:57:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 10:57:21 +0200
Subject: [PATCH 4/5] arm64: dts: qcom: msm89xx-mtp: add chassis-type
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-sm8x50-upstream-chassis-type-v1-4-13f676eb71f3@linaro.org>
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FRH2n1IjjTKn5ybe+AewNSW12EEH6TBnL96iMf+34S8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklAz8dHdW8ix7NTPBDBfK1gKhUrJZehcN8iKgVTvO
 YXjoL9CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJQM/AAKCRB33NvayMhJ0W8LD/
 0bYQv73j5QRrs1CKBnrmUO0+2xo14o2zd5x8o6eTJ9S/+YYYzbmHjAatij4N4bMR6ucPQTgIo81t+H
 UvikYN8vNV7slWYom68K6A+yoZcuLAUBt4nud8eVlugT2KcB1ZyBCrb5Z8JVWJ3004xYV8tSgKS4Jq
 7DIU8omQX+w2khevj0UMqFE8K+afyaTFLO9BGRhzSVMk+P/4SPpfoIKgvfiRmKVeKIt2AGOLBo0D+E
 8Q+iwOglCXn0cJb3NnsAIGil4SY6jCjNesb+ziiJU2rf1d9xfsU2onU/OuFiDlrX0SCkshtqZNXmF1
 OoQTCn2CCmoEA905PhBF+aV5virBl10deoynARRpf5IT81FUIVhsGhOcVZTycOoNfyl8GViGq+5Jtb
 PhbO8a/BUrSGLwhk1xns/zip3cpZwJy9HKV4YJfS4dgsBvTsl3Fl0BM8TEEI68gN84zQkx4NTkdSx5
 vPb3MEhidkwo5Vz29AT4mfMc1dlZ+7X9sJDuyw+5xLWpT6zz5HBtYs4Y1M4NQ4mIw33g/v+EcHsg8O
 AbCvJFjjNDwDTnBLEeGHHa7S/KC1615242JOaoYeFjUPab6JptyisYilY1mNOxEuXufhRoROx4kDqy
 lopVehw2Ac+DnVasrO+5Q9pceA9SSc+bTY6Hm7RN+hhGqhYcO9cpgYj0eF8w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm's Mobile Test Platforms devices are handsets, set the
chassis-type property to 'handset'.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts | 1 +
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts | 1 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
index 438eb1faee1d..ac527a3a0826 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -10,6 +10,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
 	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp/1", "qcom,msm8916";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &blsp_uart2;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
index 495d45a16e63..6e9c9caf25b1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
@@ -10,6 +10,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8996 MTP";
 	compatible = "qcom,msm8996-mtp", "qcom,msm8996";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &blsp2_uart2;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index 453a1c9e9808..4319f4da8996 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -11,6 +11,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. MSM8998 v1 MTP";
 	compatible = "qcom,msm8998-mtp", "qcom,msm8998";
+	chassis-type = "handset";
 
 	qcom,board-id = <8 0>;
 

-- 
2.34.1

