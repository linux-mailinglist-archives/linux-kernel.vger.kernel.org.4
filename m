Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8706CF2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjC2TR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjC2TRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:17:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F29CD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so17267438ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680117460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViLPrFFT9b2xN8fTsQ82odoC+1YzAduaFKgrDzgE2N4=;
        b=TmKvhDjGEbK7ITJhW4r6/CTbtHiKWtyrpJPDMJwZfFyX6EHkUEH5D1grLtTGdkKJ7/
         EkhzYL0LV6JbuuJYpYRUdlUcu/kW3v0sPj6tmd5ou3BTMw9P8xTsykZnO+V9hEACebCe
         reln6sZ0oY9x39Oz4CZ6M1Sh15TFl/cdMBHwm38w7Whspxk5VUxX4+bYObs7joy2pzEr
         s7ftr0VJsp5dXO+SmotjZnrTzRjPkOj1K4U/DumWZhGG/cZCBfj0z5yZSAd0Qw4kW+Sk
         qZHHWgW4C0zDgQkL9luC96KruGbBlpb/nLiB0Cd1Hv/WSmfgVCwMwp/peokhgXlthW77
         MpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViLPrFFT9b2xN8fTsQ82odoC+1YzAduaFKgrDzgE2N4=;
        b=YE6m940tcQFt7fMZ4axHOJ3/pt+iXw3I//fvGmmT5JvZ0E/0bBkqe1T8o5ubqMrRiZ
         n/Z4nVAd32shrG020XP2sRjjxzKo9wHDOrimH39uajHyd0dTEEBjqxf70wdTHWrzRsii
         0Ms6DCYAJQwjqZCxQ9a3/As51IhK0RKo1/sw524B97IuGT8FjiJ7E/uR0qvyWMJXT9RJ
         RwVLnFRl8u8SYY39+anV38KD2ErLt5zTrPdKWRbE5wB9Ip9w/VptSOVcWEdZWn4kY5Yx
         mze8PQCVgGuNf4UkE8Y19Vebzgmbi45TN8vrS7QuYqjazg5yoZfgiFYHPV+iHht8bUhK
         ff2Q==
X-Gm-Message-State: AAQBX9fPBp/EBqzi7aWRRzclgJHD22V4p7/o0eFi4GXW/lqursI2qhRL
        NUsgKQB4K31TOtdRaexhntzpng==
X-Google-Smtp-Source: AKy350Y1ZQ1nM53sJv20DLlfGDuxW/q4qG1NtiQSjtVJrZ/QzCXz769W2Edvn0mJmIiDjfS46Yo+CQ==
X-Received: by 2002:a05:651c:22d:b0:29b:6521:8869 with SMTP id z13-20020a05651c022d00b0029b65218869mr6141744ljn.20.1680117460348;
        Wed, 29 Mar 2023 12:17:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e3804000000b0029ad1fc89b3sm5189658lja.60.2023.03.29.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:17:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:17:30 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: msm8996: Improve GPU OPP table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-topic-adreno_opp-v1-3-24d34ac6f007@linaro.org>
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
In-Reply-To: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680117452; l=2100;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HHs9XUkau//fB7qwICGVh9A9wHhqzyRvVAVcwO4KDfs=;
 b=78jckBmXgNXovF2Ypqr1OD6fjvfwgaTJPmXe+Ex0iTBQcKoz9mv8K8UM4YxbtIL5EcHHQOAtW9iT
 FXeHmfBjATuEPj7/i+Ciw/ONUdUNPpV84+0+3EDe0sM4abfpIaOw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the self-explanatory comment about opp-supported-hw contents,
add required-opps to ensure reasonable power domain levels are voted
for (currently we've been piggybacking off of miracles and MDP votes)
and add newlines between each subnode.

Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4dd37f72e018..62ad30e94f40 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1244,37 +1244,45 @@ gpu: gpu@b00000 {
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/*
-				 * 624Mhz is only available on speed bins 0 and 3.
-				 * 560Mhz is only available on speed bins 0, 2 and 3.
-				 * All the rest are available on all bins of the hardware.
-				 */
 				opp-624000000 {
 					opp-hz = /bits/ 64 <624000000>;
+					required-opps = <&rpmpd_opp_turbo>;
 					opp-supported-hw = <0x09>;
 				};
+
 				opp-560000000 {
 					opp-hz = /bits/ 64 <560000000>;
+					required-opps = <&rpmpd_opp_turbo>;
 					opp-supported-hw = <0x0d>;
 				};
+
 				opp-510000000 {
 					opp-hz = /bits/ 64 <510000000>;
+					required-opps = <&rpmpd_opp_nom>;
 					opp-supported-hw = <0xff>;
 				};
+
 				opp-401800000 {
 					opp-hz = /bits/ 64 <401800000>;
+					required-opps = <&rpmpd_opp_nom>;
 					opp-supported-hw = <0xff>;
 				};
+
 				opp-315000000 {
 					opp-hz = /bits/ 64 <315000000>;
+					required-opps = <&rpmpd_opp_svs>;
 					opp-supported-hw = <0xff>;
 				};
+
 				opp-214000000 {
 					opp-hz = /bits/ 64 <214000000>;
+					required-opps = <&rpmpd_opp_svs>;
 					opp-supported-hw = <0xff>;
 				};
+
 				opp-133000000 {
 					opp-hz = /bits/ 64 <133000000>;
+					required-opps = <&rpmpd_opp_svs>;
 					opp-supported-hw = <0xff>;
 				};
 			};

-- 
2.40.0

