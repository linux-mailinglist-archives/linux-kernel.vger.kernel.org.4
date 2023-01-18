Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313C672982
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjARUgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjARUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:35:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D30A5DC07
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:34:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z3so2895301pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DqtnrZpeAQG00MExmoFCWtw4zspPS5f/QUn4GznZGU=;
        b=TQob0NI6zROAPkKJ8WmU7oLNmIuTKjgr6fluG7lhVt0d1p04zLrRGgu6+GrnhEukcz
         pE945lmOBcf20JJMtj96oeznOA9iEfsVK1FiIPRgcfhHiLyRueYZmkRTLjsoTfBKV59w
         HWGLoe91MPAalxjjf2i2V4a9BGb9/Vjgjf1bhHUiBCpT6ZfBwEhL9+PLDDRG0cBp6LRV
         K2zozTu+VWE9H7WSFO9VhaPw7JUsMqledw6ie48QFICVyxHWIWdaKgS8XiSc0T4r2hja
         6xZ/1I9V/MsIViVT5JLQ8gZA5Z5VUq0eQ4ccqdE/EWzr12tstwvZGl7pgqLHuS7CKcip
         95qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DqtnrZpeAQG00MExmoFCWtw4zspPS5f/QUn4GznZGU=;
        b=TcroYFDKoM+bgPwrCE2yKsvqtAgzu4eu5U+37AQP/RKkpeXgFbbMOkqCg15rRHgdAH
         B50YtpwSUMR5N3UPAvfL1+BQOBe9JCfnAOVxbe1zaasDEGLD5O7Z9ncB4/UlXM5NoXL2
         /DG5mAkdsgign3DgrZZmyzSXhOI4Df81s+VWYOY7RbbD6nMqDaytoRyOCmjnfUR8RYGZ
         y/pKyGsdHn5x1eSif3rGXAErq77zkrmWr3FNsGxdyiVKcAN+mwpVhhsI8r/r8OVLRmpg
         pL9FsJjz5Mh+yNmRfSN9T9vCHWiF+pQoWgDaoqpCzkcaB4WbqtfQviNeXbPHdevZgW/j
         58zw==
X-Gm-Message-State: AFqh2kpW+yddxOwnok0TnwTevPeQaLzQOpK/y/rsxfsu2F9ZW2TQ874e
        WzHTR6I1VKICgxM85z4JHjbli5vySiWPyxdn
X-Google-Smtp-Source: AMrXdXvz3W3yDzYxv2ad22wjF+zp5coz51GuRnc4XEQoJZlD+DwUtgnAsK2EDp8bHNW1OA6vRytqLg==
X-Received: by 2002:a62:830d:0:b0:58d:94f4:a8b9 with SMTP id h13-20020a62830d000000b0058d94f4a8b9mr9722043pfe.11.1674074083380;
        Wed, 18 Jan 2023 12:34:43 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id 8-20020a621608000000b0058a3d8eab6asm16303441pfw.134.2023.01.18.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:34:42 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH] arm64: dts: qcom: sm6115: Add CPU idle-states
Date:   Thu, 19 Jan 2023 02:04:28 +0530
Message-Id: <20230118203428.910992-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 478c5d009272..29c05cbb5fd7 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -44,6 +44,8 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -59,6 +61,8 @@ CPU1: cpu@1 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		CPU2: cpu@2 {
@@ -70,6 +74,8 @@ CPU2: cpu@2 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		CPU3: cpu@3 {
@@ -81,6 +87,8 @@ CPU3: cpu@3 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		CPU4: cpu@100 {
@@ -92,6 +100,8 @@ CPU4: cpu@100 {
 			dynamic-power-coefficient = <282>;
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -107,6 +117,8 @@ CPU5: cpu@101 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 		};
 
 		CPU6: cpu@102 {
@@ -118,6 +130,8 @@ CPU6: cpu@102 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 		};
 
 		CPU7: cpu@103 {
@@ -129,6 +143,8 @@ CPU7: cpu@103 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 		};
 
 		cpu-map {
@@ -168,6 +184,41 @@ core3 {
 				};
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <290>;
+				exit-latency-us = <376>;
+				min-residency-us = <800>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <297>;
+				exit-latency-us = <324>;
+				min-residency-us = <1110>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				idle-state-name = "cluster-power-collapse";
+				arm,psci-suspend-param = <0x41000043>;
+				entry-latency-us = <800>;
+				exit-latency-us = <2118>;
+				min-residency-us = <7376>;
+			};
+		};
 	};
 
 	firmware {
@@ -191,6 +242,59 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
 	};
 
 	reserved_memory: reserved-memory {
-- 
2.38.1

