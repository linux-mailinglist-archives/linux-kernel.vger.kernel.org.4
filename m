Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CB697715
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjBOHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjBOHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:05:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D0835252
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i18so10965007pli.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhId2O9gS5a2V65bZNIgYaEIr4oaxUhIqjkueyE7108=;
        b=MthjD0BfberAbO0QFqNFW+BqR6YFH9fssU+5ez5mAOfZVCLwOdcd1XilGeQyuCBXvF
         NLnj6jAZRwDV2HxYmxy1/KvaMZ76erd+A/e3UiG7C5/5vDnh0phAeeYDEUZrjrIubc94
         2Yc9yrMxIrPdKyzrkTby9du5/DuS9gzrMCYQURa4jDlvFYa9A98R0FMO7sauL44XsfnL
         ZfC/fhQ6YUkZ6/p8eMXw6NlkeZ+W0mxuCpicfLG5tcbnQGNGTbxq23jqgHQEiqklDEwm
         ZMTd2jRnePqKNc0CGHRM4hW4bRA0cAgBcDODnKnxJQkL7swmPrtmcallNgYCRw/tW304
         v0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhId2O9gS5a2V65bZNIgYaEIr4oaxUhIqjkueyE7108=;
        b=ctKA9tdWyiauFFrU2JmMidyM5MXrkrVwSGdxiA+rQW5vVpj46w/W4y/y14dG6GA9qY
         v8GbAopTx+lNqCPHM/5oK+5t7oGFsvchet0867Vu8OZFKZ90iUxoH97K+uY8Ri5cPpu6
         t9ai81/Q8iWwlWUEm1uKUQKFfNEXmeAbHhveNEb7QkXISuwyFWboQhxcXOubY1RWU89Q
         zYBJiTcEmWAq1Y/NCbEdEfZ4acYjCoGGUJzt/kW1KimLMuLjbGMqLcTSPmvntDZS1MSL
         Jp/usrpnSi4aS4jf2Gs8SdpR1g4x4Ji02/R6GjAjiHyA1WhvZt5umJ9N5ZkPgUw4H30W
         NKvg==
X-Gm-Message-State: AO0yUKUKnfJLQWgZhP80lZ11w6AVZcKbnJo81aMTjI7zbst+smAqipY5
        B02N2mcG4gYLsy/gNAxYuvdU
X-Google-Smtp-Source: AK7set9gn3u4n+bGAMPrFkdZ7B75WEtqClOTNROugFcTmkYkYaMaRXDAqCARElNWUmcHfM3YmSyCpQ==
X-Received: by 2002:a05:6a20:6912:b0:be:fa43:9476 with SMTP id q18-20020a056a20691200b000befa439476mr1253609pzj.35.1676444691680;
        Tue, 14 Feb 2023 23:04:51 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 10/12] arm64: dts: qcom: sc8280xp: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:58 +0530
Message-Id: <20230215070400.5901-11-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 813fb168801f..a1eb9e333699 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -45,6 +45,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
 			next-level-cache = <&L2_0>;
@@ -69,6 +70,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
 			next-level-cache = <&L2_100>;
@@ -89,6 +91,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
 			next-level-cache = <&L2_200>;
@@ -109,6 +112,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
 			next-level-cache = <&L2_300>;
@@ -129,6 +133,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_400>;
@@ -149,6 +154,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_500>;
@@ -169,6 +175,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_600>;
@@ -189,6 +196,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_700>;
@@ -3875,6 +3883,7 @@ cpufreq_hw: cpufreq@18591000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		remoteproc_nsp0: remoteproc@1b300000 {
-- 
2.25.1

