Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA069770F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjBOHF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjBOHFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:05:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F103647D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mg23so10777656pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSprQRzUAPAcRKdXmOH1+IXrj92bjRdjsdi9aS/W/NY=;
        b=qvlr8d3h+UUVCjenFQIYLf4S8UDIgx+z/oHnS1aeP7kNCaqa1rBn1oOL8RagHfsrlX
         EEtVI1i+nm1hAcYLsaVSWwLf0xTHvaHTU2XvAFF85/Dd24rZN8NYvfvw04cf5eHXw4VR
         Mcfj8oFV/YakXWSIiEESTKDqMSdzP+1Yrg3oGpmzUkMrLooXmygM99YpxDNtOJJzMiCs
         1HMvpU+PC+nJLstOFXmdyzUv8oiiSamYLGHDgZGU5i6ejLUzI2czs3d2Sb8UlEBrzj1Y
         QF6GDNnIGPchWm5lm1KNZynuu5l2mAkLKI3G0eA3I565VUS6rD11QFgQvYeFRZtlhay/
         nPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSprQRzUAPAcRKdXmOH1+IXrj92bjRdjsdi9aS/W/NY=;
        b=r5t8goH0P2p1CEJcAMyXbs9C+Y/6qYCCS0g/gNlKg+Cx9w7X7DPUcJ8OtvEC8KfC3M
         boHbTX/qYVppaeZToHyyjVmbzYb8Ic+S+6A99fZ75gg6RIM0m02idEYFcRpKbpvLl+5c
         2jIJv88mNhBNoo4amiGbW7bVl/HhNzTLGnALXiTY+0lShEmNNYk4Lu5Ze+y7X4d0kzg2
         7LDp1VLeOmBDW7pZORWSU3/aSE52iMAGz32Mj1wjWEvggLi197EoLXV8/1BUW98Uoty7
         /2OOge2GZ7rollxucV7ckUHKd6vKm+24MLWC9e4pvBeEkuUcmXAID0bY0Oj5E4sevML5
         1ueA==
X-Gm-Message-State: AO0yUKV91lC+bZB49x73dcAcCbXCbRluqV2uxfiyws/v+xaucxlQ3uYp
        9w1yvL7sXAkfJ/mKk5pAxpOs
X-Google-Smtp-Source: AK7set9434lNswoZvKO0tcdKeTE8XiVB8JAvySUXMYBJIaQb0LtQjwQ6h6pu/zvwOYh00mCX5zrIBg==
X-Received: by 2002:a05:6a20:8f01:b0:bc:e64b:e79b with SMTP id b1-20020a056a208f0100b000bce64be79bmr1274322pzk.1.1676444687546;
        Tue, 14 Feb 2023 23:04:47 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 09/12] arm64: dts: qcom: sm8350: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:57 +0530
Message-Id: <20230215070400.5901-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
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

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. But this relationship is not represented in DTS so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 0a422637b61f..1b423c42ec0d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -48,6 +48,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -69,6 +70,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -86,6 +88,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -103,6 +106,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -120,6 +124,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -137,6 +142,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -155,6 +161,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -172,6 +179,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo685";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
@@ -2283,6 +2291,7 @@ cpufreq_hw: cpufreq@18591000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		ufs_mem_hc: ufshc@1d84000 {
-- 
2.25.1

