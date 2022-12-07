Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B422E64631E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLGVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLGVNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:13:45 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DB1741D;
        Wed,  7 Dec 2022 13:13:44 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id k189so3099068oif.7;
        Wed, 07 Dec 2022 13:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODpnYyfaXKRv/tcoyL5sYgiHCqzwZL7rK+tRZUQXp6o=;
        b=6SOPW4fSks6mKZCVv0U5AxmZQ5GYJZflzPLiJiLbNFd4ZFfOLx6c4/gS8Viau1EL9x
         tXQdCngs7idLXn5JUqBrdTtDKgwYzEEZdWkxLsHDkw0BpJLTPnW68UVWZImbqrASW9y9
         YbxQIAXnOrI9y+v1sXIfR7JkOcljOnNWQIco3+VDEuZAu31qAUH6iplOsv81Y38r+YKb
         X27EfRuqLnhUeYvl5XSUoMQNaZn4F5FTckljOk4pzex2/rci0k8ipnHrmtuiYBsc+G8A
         Olhg7GAfWPUGEU3nLteHnoEq7jUYWtLHBEhVGncXsj+lmYrjw30lg2oS2ei+KDSLqAa/
         chaA==
X-Gm-Message-State: ANoB5pmH2R3DbVOa7gG9hmM+2P6UufXTpYu18xhnok+fFAkIjY/pAxVf
        ZQE9Zus44a7GWQN2eQ9vmeXVkQPtjQ==
X-Google-Smtp-Source: AA0mqf7XhwR8ZwBKB+ZE6mPcI5YuuPDn5J8tDe4dKM9yKhKS+fB6MIl0usQDA2+jWSXcGjkoFGfafw==
X-Received: by 2002:a05:6808:188:b0:35c:3410:ac6d with SMTP id w8-20020a056808018800b0035c3410ac6dmr7797622oic.4.1670447623659;
        Wed, 07 Dec 2022 13:13:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 24-20020aca1018000000b0035e461d9b1bsm311562oiq.50.2022.12.07.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:13:43 -0800 (PST)
Received: (nullmailer pid 2849012 invoked by uid 1000);
        Wed, 07 Dec 2022 21:13:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: Fix CPU nodes compatible string
Date:   Wed,  7 Dec 2022 15:13:27 -0600
Message-Id: <20221207211327.2848665-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'arm,kryo' is not documented and is not an Arm Ltd thing either as that
is Qualcomm branding. The correct compatible is 'qcom,kryo'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 212580316d3e..f06cc7588acc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -166,7 +166,7 @@ cpus {
 
 		CPU0: cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
@@ -189,7 +189,7 @@ L3_0: l3-cache {
 
 		CPU1: cpu@100 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
@@ -209,7 +209,7 @@ L2_100: l2-cache {
 
 		CPU2: cpu@200 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
@@ -229,7 +229,7 @@ L2_200: l2-cache {
 
 		CPU3: cpu@300 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
@@ -249,7 +249,7 @@ L2_300: l2-cache {
 
 		CPU4: cpu@400 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
@@ -269,7 +269,7 @@ L2_400: l2-cache {
 
 		CPU5: cpu@500 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
@@ -289,7 +289,7 @@ L2_500: l2-cache {
 
 		CPU6: cpu@600 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
@@ -309,7 +309,7 @@ L2_600: l2-cache {
 
 		CPU7: cpu@700 {
 			device_type = "cpu";
-			compatible = "arm,kryo";
+			compatible = "qcom,kryo";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
-- 
2.35.1

