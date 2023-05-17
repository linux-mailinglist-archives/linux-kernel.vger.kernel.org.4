Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102F7072CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjEQUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEQUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:13:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D67ED0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1400199e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684354412; x=1686946412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fddr7vQfG7SJnVJn02S1O20K03Qt9GSXK3rEV8Cg+k0=;
        b=EkLoRT+KFXel4yX8Uvo1ory38MSZ65Hov9IExlTPHSRF37JxC4DtRK795QyrQtsc1F
         rgd/0WA5MbPn1skALE6HAdAUU5IVndpePxwtaWYyBtRmL4j5oqAMLhZ+B8EPu81D0TvF
         n6qa1LuB4PuR+Obzs26YyZ8FUwegIq+4/jDGdpp7TN4Ku6fcnm+jajQQXuICyxtVQrmt
         hK2ZLT3VnC9WaVfUtcsWj166PSyczngUoIDptWoDBTRyPs1eBvFV4W2k6y/FgZ64zHcD
         ruE+yasm9wzXzjZpD06p6YimBUB3VGNKInuJV6YfG5k3CkSiyYH/fW9AS84NXmZ4seaY
         scWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354412; x=1686946412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fddr7vQfG7SJnVJn02S1O20K03Qt9GSXK3rEV8Cg+k0=;
        b=UZRixxIIxCFwjbmCwBcoopb+LD5U2rAVp+SRPvq8PcAEdHhToiCB24uml4zA525o2Z
         Smb5riEKehZ7/pQYcYPKod4/ZbWb0/y7RtHK0xPzdOeAWTTXUfMqDSaCyDB8WNtHq7rj
         MR61VFob2whCjXHbMTd/ju7nW19oOZMxexIa4YscbMbvxb9GzIxkdFmBACF+x+BLBL0R
         9zLOa9y5VYcQ7/1iGXxkPoicuX268ImD7U7Md3PLwdPy7GzWdYq3CoZv81MLzbAlX1I2
         v9pJy4VHF8oTsuKnSZ96a2V4JCeSYZ49Vtvg38jlkJgXcWB4Sys/yeZyk152kWRwIcSp
         igWg==
X-Gm-Message-State: AC+VfDwgwsZhywZI4MMknNXsXhVB+VnTd3FqUuS1yyx/1nyofNxN/Kzm
        4fRSLtYi/PqYf+4jg3qhHJ+c6w==
X-Google-Smtp-Source: ACHHUZ6o180I0fAigI/8A3iS92oiIiwqKrYDmoXe1xL+jRS4jMwv7wocDJ2W+aCgBqX7A0m8StHBkg==
X-Received: by 2002:a19:f707:0:b0:4f2:7e3e:7d24 with SMTP id z7-20020a19f707000000b004f27e3e7d24mr545223lfe.46.1684354412582;
        Wed, 17 May 2023 13:13:32 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b004f382ae9892sm1190899lfo.247.2023.05.17.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:13:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 22:12:52 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP
 levels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-kailua-rpmhpd-v2-3-3063ce19c491@linaro.org>
References: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684354400; l=2617;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JJOo1yC89QKK0GjXF7VRcmrSi+n6mZDBrrstrn3foPM=;
 b=CpJVb5IAq0cXatsz5h3BLG1mi4TobFqZMAM/KIr0NgZShrr+JQ5Vz3+6wLTsj6rluYNpA1U2i
 7hQ7+NHTG0DCQgJt/oNsOa9bZhyOUYCKinWV09G+CrWPDCRR8d6BLbj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need more granularity for things like the GPU. Add the missing levels.

This unfortunately requires some re-indexing, resulting in an ugly diff.
Rename the nodes to prevent that in the future.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 40 +++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..1c9460dc3d44 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3608,43 +3608,63 @@ rpmhpd: power-controller {
 				rpmhpd_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					rpmhpd_opp_ret: opp1 {
+					rpmhpd_opp_ret: opp-16 {
 						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
 					};
 
-					rpmhpd_opp_min_svs: opp2 {
+					rpmhpd_opp_min_svs: opp-48 {
 						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
 					};
 
-					rpmhpd_opp_low_svs: opp3 {
+					rpmhpd_opp_lov_svs_d2: opp-52 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					};
+
+					rpmhpd_opp_lov_svs_d1: opp-56 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					};
+
+					rpmhpd_opp_lov_svs_d0: opp-60 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					};
+
+					rpmhpd_opp_low_svs: opp-64 {
 						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					};
 
-					rpmhpd_opp_svs: opp4 {
+					rpmhpd_opp_low_svs_l1: opp-80 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					};
+
+					rpmhpd_opp_svs: opp-128 {
 						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					};
 
-					rpmhpd_opp_svs_l1: opp5 {
+					rpmhpd_opp_svs_l0: opp-144 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					};
+
+					rpmhpd_opp_svs_l1: opp-192 {
 						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					};
 
-					rpmhpd_opp_nom: opp6 {
+					rpmhpd_opp_nom: opp-256 {
 						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					};
 
-					rpmhpd_opp_nom_l1: opp7 {
+					rpmhpd_opp_nom_l1: opp-320 {
 						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					};
 
-					rpmhpd_opp_nom_l2: opp8 {
+					rpmhpd_opp_nom_l2: opp-336 {
 						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
 					};
 
-					rpmhpd_opp_turbo: opp9 {
+					rpmhpd_opp_turbo: opp-384 {
 						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
 					};
 
-					rpmhpd_opp_turbo_l1: opp10 {
+					rpmhpd_opp_turbo_l1: opp-416 {
 						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					};
 				};

-- 
2.40.1

