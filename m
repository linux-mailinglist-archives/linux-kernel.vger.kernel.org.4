Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59127741363
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjF1OEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjF1ODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:03:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A830FC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:01:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso32241961fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960864; x=1690552864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPAidhx6gb0MzSkeNv0f96g3+quO0syJDIwE973x+Fc=;
        b=d2YedIZqPbp3kWPXCASHOEWcCdlm1wmqrAsDV6BW4xy4ONU3uWRQQII69j0zKzC6E7
         L+XxCWx/qv5guu3d7edJ52aNTNoybzyJ9dUHpMpc0/WZxgHNCFv+TpjOR0ry3MXAM9D7
         frjK8MsRmhSQHhhJsSvOKjiGYl2AoVoZZmyZgBDVpOl3uHy3x1uzEwu0cGcCNOuHVOQ6
         0epW0beHwgB8L2bMSupBQLZaDNup3rlpSjf/+qR6l4/a6/nGs1teMIlmP5xhOQ8zSgFV
         wW4Jnkn1jirm8TeAotbd/cUJDcO7QgVeCxSnph7HjB99oUPEzbPAKib9q/RtFMbj2+Sd
         sa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960864; x=1690552864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPAidhx6gb0MzSkeNv0f96g3+quO0syJDIwE973x+Fc=;
        b=lHLi/h+IQEBCuRYyKTXSaeRBlbfurDH5I0MAkBzZyg8r+ScgVdvyJieCTnLgHkyHVN
         9mmi8S3qZeBK73z78D6oWywFh66yVM8XgrNzSSW8bEtrPEdjrbEhUMSAbxN4md1G9QJa
         QhDMh0C5SYiTFqYwxWuL1iPGRHaJdBC5tL4UaDg4nHg8jEIQ6SkJHPGlSwxPiafizT5x
         e+Pf7phUqlOCtF7WC8SJkFjzEx4BZ62tBXmHmjUXhQAw9LC0K163BA49pww5hSfU2ve3
         YNfrfg/vfUi+iRnVE08l1yqb9/uNslxA4DxIv2NizxIdV+1Zu6uM8IvSkLZt4H8JYeWS
         OSUw==
X-Gm-Message-State: AC+VfDxrk//skokH+4Jm3tYeivn9IgkwgcUOZzykIlD9lbJR7hjDQtdG
        Yf6LDiheoLEssN2E1fy6/H+QSQ==
X-Google-Smtp-Source: ACHHUZ6i5vMkmHSB9Mm5L23gJK75XGN7cOLzCrmamqAXt08mBZXHCz4LkbDqO0JpiYw6rQO0tzLvrQ==
X-Received: by 2002:a05:6512:3a82:b0:4fb:8c27:4def with SMTP id q2-20020a0565123a8200b004fb8c274defmr2768026lfu.8.1687960864037;
        Wed, 28 Jun 2023 07:01:04 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:01:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:49 +0200
Subject: [PATCH v12 10/10] arm64: dts: qcom: msm8998: Configure CPRh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-10-1a4d050e1e67@linaro.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960843; l=20911;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=R/ZHDpIuNb7dxERiX7ReT3OE+b76z4GsY9Jbl995rIo=;
 b=TfdmurTC3aQbPLM6BwdIXmrBwgnSlBIaWhEV2zo6twfRjMm/32hyOEKH1dImKO/90AGcWJHy5
 ZcF15A/yB/BAftojVV/yUZfEOJ0inQzOOQc+0xSzznLpGRVCm2De5zN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Now that the CPR v3/v4/Hardened is ready, enable it on MSM8998.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate from adding cpufreq, sort nodes, use lowercase hex,
 update for driver changes]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 757 ++++++++++++++++++++++++++++++++++
 1 file changed, 757 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0e943ff0046..9a53396e13ff 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -143,6 +143,9 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -158,6 +161,9 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU2: cpu@2 {
@@ -168,6 +174,9 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU3: cpu@3 {
@@ -178,6 +187,9 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU4: cpu@100 {
@@ -188,6 +200,9 @@ CPU4: cpu@100 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -203,6 +218,9 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		CPU6: cpu@102 {
@@ -213,6 +231,9 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		CPU7: cpu@103 {
@@ -223,6 +244,9 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		cpu-map {
@@ -316,6 +340,490 @@ scm {
 		};
 	};
 
+	cprh_opp_table: opp-table-cprh {
+		compatible = "operating-points-v2-qcom-level";
+
+		cprh_opp1: opp-1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp2: opp-2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp3: opp-3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp4: opp-4 {
+			opp-level = <4>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp5: opp-5 {
+			opp-level = <5>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp6: opp-6 {
+			opp-level = <6>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp7: opp-7 {
+			opp-level = <7>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp8: opp-8 {
+			opp-level = <8>;
+			qcom,opp-fuse-level = <1 1>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp9: opp-9 {
+			opp-level = <9>;
+			qcom,opp-fuse-level = <2 2>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp10: opp-10 {
+			opp-level = <10>;
+			qcom,opp-fuse-level = <2 2>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp11: opp-11 {
+			opp-level = <11>;
+			qcom,opp-fuse-level = <2 2>;
+			qcom,opp-cloop-vadj = <0 0>;
+			qcom,opp-oloop-vadj = <0 0>;
+		};
+
+		cprh_opp12: opp-12 {
+			opp-level = <12>;
+			qcom,opp-fuse-level = <3 2>;
+			qcom,opp-cloop-vadj = <(-10000) (-10000)>;
+			qcom,opp-oloop-vadj = <(-12000) (-8000)>;
+		};
+
+		cprh_opp13: opp-13 {
+			opp-level = <13>;
+			qcom,opp-fuse-level = <3 3>;
+			qcom,opp-cloop-vadj = <(-11000) (-10000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-16000)>;
+		};
+
+		cprh_opp14: opp-14 {
+			opp-level = <14>;
+			qcom,opp-fuse-level = <3 3>;
+			qcom,opp-cloop-vadj = <(-12000) (-11000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-12000)>;
+		};
+
+		cprh_opp15: opp-15 {
+			opp-level = <15>;
+			qcom,opp-fuse-level = <3 3>;
+			qcom,opp-cloop-vadj = <(-13000) (-12000)>;
+			qcom,opp-oloop-vadj = <(-12000) (-16000)>;
+		};
+
+		cprh_opp16: opp-16 {
+			opp-level = <16>;
+			qcom,opp-fuse-level = <3 3>;
+			qcom,opp-cloop-vadj = <(-14000) (-12000)>;
+			qcom,opp-oloop-vadj = <(-12000) (-16000)>;
+		};
+
+		cprh_opp17: opp-17 {
+			opp-level = <17>;
+			qcom,opp-fuse-level = <3 3>;
+			qcom,opp-cloop-vadj = <(-14000) (-13000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-12000)>;
+		};
+
+		cprh_opp18: opp-18 {
+			opp-level = <18>;
+			qcom,opp-fuse-level = <3 3>;
+			qcom,opp-cloop-vadj = <(-15000) (-14000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-16000)>;
+		};
+
+		cprh_opp19: opp-19 {
+			opp-level = <19>;
+			qcom,opp-fuse-level = <4 3>;
+			qcom,opp-cloop-vadj = <(-21000) (-14000)>;
+			qcom,opp-oloop-vadj = <(-20000) (-16000)>;
+		};
+
+		cprh_opp20: opp-20 {
+			opp-level = <20>;
+			qcom,opp-fuse-level = <4 3>;
+			qcom,opp-cloop-vadj = <(-24000) (-15000)>;
+			qcom,opp-oloop-vadj = <(-24000) (-16000)>;
+		};
+
+		cprh_opp21: opp-21 {
+			opp-level = <21>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <(-26000) (-16000)>;
+			qcom,opp-oloop-vadj = <(-28000) (-24000)>;
+		};
+
+		cprh_opp22: opp-22 {
+			opp-level = <22>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <(-28000) (-16000)>;
+			qcom,opp-oloop-vadj = <(-28000) (-16000)>;
+		};
+
+		cprh_opp23: opp-23 {
+			opp-level = <23>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-17000)>;
+			qcom,opp-oloop-vadj = <0 (-20000)>;
+		};
+
+		cprh_opp24: opp-24 {
+			opp-level = <24>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-15000)>;
+			qcom,opp-oloop-vadj = <0 (-16000)>;
+		};
+
+		cprh_opp25: opp-25 {
+			opp-level = <25>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-14000)>;
+			qcom,opp-oloop-vadj = <0 (-12000)>;
+		};
+
+		cprh_opp26: opp-26 {
+			opp-level = <26>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-27000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp27: opp-27 {
+			opp-level = <27>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-27000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp28: opp-28 {
+			opp-level = <28>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-28000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp29: opp-29 {
+			opp-level = <29>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-28000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp30: opp-30 {
+			opp-level = <30>;
+			qcom,opp-fuse-level = <4 4>;
+			qcom,opp-cloop-vadj = <0 (-28000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+	};
+
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			required-opps = <&cprh_opp22>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			required-opps = <&cprh_opp21>;
+		};
+
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			required-opps = <&cprh_opp20>;
+		};
+
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			required-opps = <&cprh_opp19>;
+		};
+
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			required-opps = <&cprh_opp18>;
+		};
+
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			required-opps = <&cprh_opp17>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			required-opps = <&cprh_opp16>;
+		};
+
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			required-opps = <&cprh_opp15>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			required-opps = <&cprh_opp14>;
+		};
+
+		opp-1171200000 {
+			opp-hz = /bits/ 64 <1171200000>;
+			required-opps = <&cprh_opp13>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&cprh_opp12>;
+		};
+
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			required-opps = <&cprh_opp11>;
+		};
+
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			required-opps = <&cprh_opp10>;
+		};
+
+		opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			required-opps = <&cprh_opp9>;
+		};
+
+		opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			required-opps = <&cprh_opp8>;
+		};
+
+		opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			required-opps = <&cprh_opp7>;
+		};
+
+		opp-672000000 {
+			opp-hz = /bits/ 64 <672000000>;
+			required-opps = <&cprh_opp6>;
+		};
+
+		opp-595200000 {
+			opp-hz = /bits/ 64 <595200000>;
+			required-opps = <&cprh_opp5>;
+		};
+
+		opp-518400000 {
+			opp-hz = /bits/ 64 <518400000>;
+			required-opps = <&cprh_opp4>;
+		};
+
+		opp-441600000 {
+			opp-hz = /bits/ 64 <441600000>;
+			required-opps = <&cprh_opp3>;
+		};
+
+		opp-364800000 {
+			opp-hz = /bits/ 64 <364800000>;
+			required-opps = <&cprh_opp2>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cprh_opp1>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-2361600000 {
+			opp-hz = /bits/ 64 <2361600000>;
+			required-opps = <&cprh_opp30>;
+		};
+
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			required-opps = <&cprh_opp29>;
+		};
+
+		opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			required-opps = <&cprh_opp28>;
+		};
+
+		opp-2265600000 {
+			opp-hz = /bits/ 64 <2265600000>;
+			required-opps = <&cprh_opp27>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			required-opps = <&cprh_opp26>;
+		};
+
+		opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			required-opps = <&cprh_opp25>;
+		};
+
+		opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			required-opps = <&cprh_opp24>;
+		};
+
+		opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			required-opps = <&cprh_opp23>;
+		};
+
+		opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			required-opps = <&cprh_opp22>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			required-opps = <&cprh_opp21>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			required-opps = <&cprh_opp20>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			required-opps = <&cprh_opp19>;
+		};
+
+		opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			required-opps = <&cprh_opp18>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			required-opps = <&cprh_opp17>;
+		};
+
+		opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			required-opps = <&cprh_opp16>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			required-opps = <&cprh_opp15>;
+		};
+
+		opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			required-opps = <&cprh_opp14>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			required-opps = <&cprh_opp13>;
+		};
+
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			required-opps = <&cprh_opp12>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			required-opps = <&cprh_opp11>;
+		};
+
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			required-opps = <&cprh_opp10>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			required-opps = <&cprh_opp9>;
+		};
+
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			required-opps = <&cprh_opp8>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			required-opps = <&cprh_opp7>;
+		};
+
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			required-opps = <&cprh_opp6>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			required-opps = <&cprh_opp5>;
+		};
+
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			required-opps = <&cprh_opp4>;
+		};
+
+		opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			required-opps = <&cprh_opp3>;
+		};
+
+		opp-345600000 {
+			opp-hz = /bits/ 64 <345600000>;
+			required-opps = <&cprh_opp2>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cprh_opp1>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -845,6 +1353,174 @@ qfprom: qfprom@784000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			cpr_efuse_speedbin: speedbin@133 {
+				reg = <0x133 0x8>;
+				bits = <5 3>;
+			};
+
+			cpr_fuse_revision: cpr-fusing-rev@13e {
+				reg = <0x13e 0x1>;
+				bits = <3 3>;
+			};
+
+			/* CPR Ring Oscillator: Power Cluster */
+			cpr_ro_sel3_pwrcl: rosel3-pwrcl@218 {
+				reg = <0x218 0x1>;
+				bits = <0 4>;
+			};
+
+			cpr_ro_sel2_pwrcl: rosel2-pwrcl@218 {
+				reg = <0x218 0x1>;
+				bits = <4 4>;
+			};
+
+			cpr_ro_sel1_pwrcl: rosel1-pwrcl@219 {
+				reg = <0x219 0x1>;
+				bits = <0 4>;
+			};
+
+			cpr_ro_sel0_pwrcl: rosel0-pwrcl@219 {
+				reg = <0x219 0x1>;
+				bits = <4 4>;
+			};
+
+			/* CPR Init Voltage: Power Cluster */
+			cpr_init_voltage3_pwrcl: ivolt3-pwrcl@21a {
+				reg = <0x21a 0x1>;
+				bits = <0 6>;
+			};
+
+			cpr_init_voltage2_pwrcl: ivolt2-pwrcl@21a {
+				reg = <0x21a 0x2>;
+				bits = <6 6>;
+			};
+
+			cpr_init_voltage1_pwrcl: ivolt1-pwrcl@21b {
+				reg = <0x21b 0x2>;
+				bits = <4 6>;
+			};
+
+			cpr_init_voltage0_pwrcl: ivolt0-pwrcl@21c {
+				reg = <0x21c 0x1>;
+				bits = <2 6>;
+			};
+
+			/* CPR Target Quotients: Power Cluster */
+			cpr_quot3_pwrcl: quot3-pwrcl@21d {
+				reg = <0x21d 0x3>;
+				bits = <6 12>;
+			};
+
+			cpr_quot2_pwrcl: quot2-pwrcl@21f {
+				reg = <0x21f 0x2>;
+				bits = <2 11>;
+			};
+
+			cpr_quot1_pwrcl: quot1-pwrcl@220 {
+				reg = <0x220 0x3>;
+				bits = <6 12>;
+			};
+
+			cpr_quot0_pwrcl: quot0-pwrcl@222 {
+				reg = <0x222 0x2>;
+				bits = <2 12>;
+			};
+
+			/* CPR Quotient Offsets: Power Cluster */
+			cpr_quot_offset3_pwrcl: qoff3-pwrcl@226 {
+				reg = <0x226 0x1>;
+				bits = <1 7>;
+			};
+
+			cpr_quot_offset2_pwrcl: qoff2-pwrcl@227 {
+				reg = <0x227 0x1>;
+				bits = <0 7>;
+			};
+
+			cpr_quot_offset1_pwrcl: qoff1-pwrcl@227 {
+				reg = <0x227 0x2>;
+				bits = <7 6>;
+			};
+
+			/* CPR Ring Oscillator: Performance Cluster */
+			cpr_ro_sel3_perfcl: rosel3-perfcl@229 {
+				reg = <0x229 0x2>;
+				bits = <6 4>;
+			};
+
+			cpr_ro_sel2_perfcl: rosel2-perfcl@22a {
+				reg = <0x22a 0x1>;
+				bits = <2 4>;
+			};
+
+			cpr_ro_sel1_perfcl: rosel1-perfcl@22a {
+				reg = <0x22a 0x2>;
+				bits = <6 4>;
+			};
+
+			cpr_ro_sel0_perfcl: rosel0-perfcl@22b {
+				reg = <0x22b 0x1>;
+				bits = <2 4>;
+			};
+
+			/* CPR Init Voltage: Performance Cluster */
+			cpr_init_voltage3_perfcl: ivolt3-perfcl@22b {
+				reg = <0x22b 0x2>;
+				bits = <6 6>;
+			};
+
+			cpr_init_voltage2_perfcl: ivolt2-perfcl@22c {
+				reg = <0x22c 0x2>;
+				bits = <4 6>;
+			};
+
+			cpr_init_voltage1_perfcl: ivolt1-perfcl@22d {
+				reg = <0x22d 0x1>;
+				bits = <2 6>;
+			};
+
+			cpr_init_voltage0_perfcl: ivolt0-perfcl@22e {
+				reg = <0x22e 0x1>;
+				bits = <0 6>;
+			};
+
+			/* CPR Target Quotients: Performance Cluster */
+			cpr_quot3_perfcl: quot3-perfcl@22f {
+				reg = <0x22f 0x2>;
+				bits = <4 11>;
+			};
+
+			cpr_quot2_perfcl: quot2-perfcl@231 {
+				reg = <0x231 0x2>;
+				bits = <0 12>;
+			};
+
+			cpr_quot1_perfcl: quot1-perfcl@232 {
+				reg = <0x232 0x2>;
+				bits = <4 12>;
+			};
+
+			cpr_quot0_perfcl: quot0-perfcl@234 {
+				reg = <0x234 0x2>;
+				bits = <0 12>;
+			};
+
+			/* CPR Quotient Offsets: Performance Cluster */
+			cpr_quot_offset3_perfcl: qoff3-perfcl@237 {
+				reg = <0x237 0x2>;
+				bits = <7 6>;
+			};
+
+			cpr_quot_offset2_perfcl: qoff2-perfcl@238 {
+				reg = <0x238 0x2>;
+				bits = <6 7>;
+			};
+
+			cpr_quot_offset1_perfcl: qoff1-perfcl@239 {
+				reg = <0x239 0x1>;
+				bits = <5 3>;
+			};
+
 			qusb2_hstx_trim: hstx-trim@23a {
 				reg = <0x23a 0x1>;
 				bits = <0 4>;
@@ -2865,6 +3541,87 @@ frame@17928000 {
 			};
 		};
 
+		apc_cprh: power-controller@179c8000 {
+			compatible = "qcom,msm8998-cprh", "qcom,cprh";
+			reg = <0x179c8000 0x4000>,
+			      <0x179c4000 0x4000>;
+
+			clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+
+			/* Set the CPR clock here, it needs to match XO */
+			assigned-clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			operating-points-v2 = <&cprh_opp_table>;
+			power-domains = <&rpmpd MSM8998_VDDCX_AO>;
+			#power-domain-cells = <1>;
+
+			nvmem-cells = <&cpr_efuse_speedbin>,
+				      <&cpr_fuse_revision>,
+				      <&cpr_quot0_pwrcl>,
+				      <&cpr_quot1_pwrcl>,
+				      <&cpr_quot2_pwrcl>,
+				      <&cpr_quot3_pwrcl>,
+				      <&cpr_quot_offset1_pwrcl>,
+				      <&cpr_quot_offset2_pwrcl>,
+				      <&cpr_quot_offset3_pwrcl>,
+				      <&cpr_init_voltage0_pwrcl>,
+				      <&cpr_init_voltage1_pwrcl>,
+				      <&cpr_init_voltage2_pwrcl>,
+				      <&cpr_init_voltage3_pwrcl>,
+				      <&cpr_ro_sel0_pwrcl>,
+				      <&cpr_ro_sel1_pwrcl>,
+				      <&cpr_ro_sel2_pwrcl>,
+				      <&cpr_ro_sel3_pwrcl>,
+				      <&cpr_quot0_perfcl>,
+				      <&cpr_quot1_perfcl>,
+				      <&cpr_quot2_perfcl>,
+				      <&cpr_quot3_perfcl>,
+				      <&cpr_quot_offset1_perfcl>,
+				      <&cpr_quot_offset2_perfcl>,
+				      <&cpr_quot_offset3_perfcl>,
+				      <&cpr_init_voltage0_perfcl>,
+				      <&cpr_init_voltage1_perfcl>,
+				      <&cpr_init_voltage2_perfcl>,
+				      <&cpr_init_voltage3_perfcl>,
+				      <&cpr_ro_sel0_perfcl>,
+				      <&cpr_ro_sel1_perfcl>,
+				      <&cpr_ro_sel2_perfcl>,
+				      <&cpr_ro_sel3_perfcl>;
+			nvmem-cell-names = "cpr_speed_bin",
+					   "cpr_fuse_revision",
+					   "cpr0_quotient1",
+					   "cpr0_quotient2",
+					   "cpr0_quotient3",
+					   "cpr0_quotient4",
+					   "cpr0_quotient_offset2",
+					   "cpr0_quotient_offset3",
+					   "cpr0_quotient_offset4",
+					   "cpr0_init_voltage1",
+					   "cpr0_init_voltage2",
+					   "cpr0_init_voltage3",
+					   "cpr0_init_voltage4",
+					   "cpr0_ring_osc1",
+					   "cpr0_ring_osc2",
+					   "cpr0_ring_osc3",
+					   "cpr0_ring_osc4",
+					   "cpr1_quotient1",
+					   "cpr1_quotient2",
+					   "cpr1_quotient3",
+					   "cpr1_quotient4",
+					   "cpr1_quotient_offset2",
+					   "cpr1_quotient_offset3",
+					   "cpr1_quotient_offset4",
+					   "cpr1_init_voltage1",
+					   "cpr1_init_voltage2",
+					   "cpr1_init_voltage3",
+					   "cpr1_init_voltage4",
+					   "cpr1_ring_osc1",
+					   "cpr1_ring_osc2",
+					   "cpr1_ring_osc3",
+					   "cpr1_ring_osc4";
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x17a00000 0x10000>,       /* GICD */

-- 
2.41.0

