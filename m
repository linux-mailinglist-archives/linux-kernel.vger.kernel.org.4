Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7963E165
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiK3ULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiK3ULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDF9D837;
        Wed, 30 Nov 2022 12:10:04 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z4so22180506ljq.6;
        Wed, 30 Nov 2022 12:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6KtEaf/qmwW9+C/8cbU0t4+fA9tt0ZOxNed3iCE/Io=;
        b=RMNPXwu82W0pG+t8O8HH/V7/u2v+Vb1SNXjosRZzZHhmrwA+iIzc6j4yoh/J5PKFWD
         eQ4dJienr68cFYcN9+7621V4XOUvPqhLYVckFsDWVz3X731w3G6Xho2trunsXRaCmwjl
         H5p23onyZ4R3c3r2McKVkJFw0nYUqHfjyaHU7dXl/g3GIfbk6hYqs1GRvnk3tMMmhJFq
         fQouhvwvVYcMWh+PE/7UfPsB79vxnL1MgA/MhfNcFSFpfL6nrZbO1CqlgDUX+WsRVGXX
         jTHj1l0ReWwPNXykNaBU4U+F+A4WTMEOucQrHwuPEM6bNpT2+++YJ5MFk9Y+71tM69GO
         ARdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6KtEaf/qmwW9+C/8cbU0t4+fA9tt0ZOxNed3iCE/Io=;
        b=GQhLZqBbBjnP4m9d8vfrcYqhRO8MXwK6qt+KlDRnXF8a9D0ObiFnLRvfkv+YAnYC57
         SJYbXrtbLRnVwvOOoSuy/j+Y7c8tqXIfXbwuEMBlnl4SLisGV4SLnqWGQk+QXJdPKEic
         mSxLt7kDPk187h9FdiKYzH2E+3Fn43YOI7VH699A/xnGaaZUjHtf5c+tLuvKCqTfK4L8
         PyM0LEb2+EllgLJR3k2XRYzYsGDt5/TET1kdssT6fxjATF33k2/8ySxf8gct/sHTFH2f
         8uPKgGPHhl1BXi4F+7oiAIrjMlmx2qMl+5Llj4E7LxcQ/+ld9m+45+sPdoBevwbiWE5x
         AUxA==
X-Gm-Message-State: ANoB5pmAfyfuo7aN+KZvx460E5AbMgDR5d58YR6N1ZCixZbaIZ8zN4xx
        bjVPCqTkHliXLP45GFLtKXGee0UfEY4=
X-Google-Smtp-Source: AA0mqf5P05TtUcf7Z754qXf11Dn1gzaFO/dbcqSzW1O9opHt5eNJRN1EWK5T5FTIteTnINe3RsNLOA==
X-Received: by 2002:a05:651c:1244:b0:278:a461:cb7d with SMTP id h4-20020a05651c124400b00278a461cb7dmr14760527ljh.246.1669839003243;
        Wed, 30 Nov 2022 12:10:03 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:02 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 03/12] arm64: dts: qcom: sm6115: Add cpufreq-hw support
Date:   Wed, 30 Nov 2022 21:09:41 +0100
Message-Id: <20221130200950.144618-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpufreq-hw node and assign qcom,freq-domain properties
to CPUs to enable CPU clock scaling.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 0340ed21be05..2a55087b103e 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -41,6 +41,7 @@ CPU0: cpu@0 {
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -55,6 +56,7 @@ CPU1: cpu@1 {
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 		};
 
 		CPU2: cpu@2 {
@@ -65,6 +67,7 @@ CPU2: cpu@2 {
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 		};
 
 		CPU3: cpu@3 {
@@ -75,6 +78,7 @@ CPU3: cpu@3 {
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 		};
 
 		CPU4: cpu@100 {
@@ -85,6 +89,7 @@ CPU4: cpu@100 {
 			capacity-dmips-mhz = <1638>;
 			dynamic-power-coefficient = <282>;
 			next-level-cache = <&L2_1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -99,6 +104,7 @@ CPU5: cpu@101 {
 			dynamic-power-coefficient = <282>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 		};
 
 		CPU6: cpu@102 {
@@ -109,6 +115,7 @@ CPU6: cpu@102 {
 			dynamic-power-coefficient = <282>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 		};
 
 		CPU7: cpu@103 {
@@ -119,6 +126,7 @@ CPU7: cpu@103 {
 			dynamic-power-coefficient = <282>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 		};
 
 		cpu-map {
@@ -842,6 +850,17 @@ intc: interrupt-controller@f200000 {
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		cpufreq_hw: cpufreq@f521000 {
+			compatible = "qcom,cpufreq-hw";
+			reg = <0x0f521000 0x1000>, <0x0f523000 0x1000>;
+
+			reg-names = "freq-domain0", "freq-domain1";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.25.1

