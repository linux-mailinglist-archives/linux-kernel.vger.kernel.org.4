Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3160970699C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjEQNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjEQNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:19:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF11E50
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so7149451fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329592; x=1686921592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Snql9fZTVzGEa4100bCYfNArEVQGFmNQcHmddiMGNsw=;
        b=PSGPQwd7aSZF8vck4JAqV1uQpBjlGBgWdQZ6ndjUP7T2xNHy+zCY+wfDzBfTwFrMxP
         0/kgOqZcWegzG4/b1Y1mLSWaNdLEVvrizOc5zuU76NN7iQ0btqGV0MTEKXnVGaY9yb/E
         CZ6fysvS/D9Amb3yM9oHPXanEmXHNe1NIjSWjzp/UnkfJYcObcmMFwuE8y+nFsp2I7A5
         BK/y+vyKMx9IILqsYWlh13yJZVlIxLKtluTOCj8RKnylFbHoUycslBW2rJyU/7moWXQb
         TAnFeJSkdopJl5U3L3jeZqHHYIyoQjly2FQMG9+WaS9wDoXYigySG0XZrbogifmy/C5+
         sFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329592; x=1686921592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Snql9fZTVzGEa4100bCYfNArEVQGFmNQcHmddiMGNsw=;
        b=VkCSFsTNPD4Hr3bdpsk1oIpyxKzXIlgCqJxnyjri6ug4hf+cBlYA0jgMl9sGJWPRfc
         77WH8D4QkHKf4er/GRqLreFDRTjlA68sSMQfRSJCZsHNeIKDAVsWagYx/E1WolUSuA9h
         GK/UY7GzzWPHfiNA+bn1I4Vwt5u4hQjzqV4oeAX76gO8Vzi+nERP7F03WTvB61tGB5W9
         XRIk+7ReQdAlyy0daC+3GAsTOfu9WaZdHMbfW8k1zwOvAqr6d6xpJeA22G8gTCQawU/p
         6U46Y2fPbjjIC0x9UE6KOAQR86LcimFXQeKH9nqBePbZxMfNR+89J01T4iSYe7jNN5U4
         AHpA==
X-Gm-Message-State: AC+VfDwZ3d8btY16kBkCuAMAB4duBXVFwiaVySpUgJl5MjsGHOMdRRAZ
        b3vGNJzTBW3mhpz7E1/imGgUdA==
X-Google-Smtp-Source: ACHHUZ5MuTqRjz5JXlvl6zJHyFZFGPTDjgIffWQ/g5V7+mY4ajzFZBKqGtG1RaGX8p9PqwVz0QksoA==
X-Received: by 2002:a2e:801a:0:b0:2ac:67f7:25a2 with SMTP id j26-20020a2e801a000000b002ac67f725a2mr8993656ljg.50.1684329592065;
        Wed, 17 May 2023 06:19:52 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:c93:874f:be7b:fb6c:26f9:307c])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002adadef95c0sm3007457ljg.124.2023.05.17.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:19:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 15:19:45 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP
 levels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-kailua-rpmhpd-v1-3-cd3013d051a6@linaro.org>
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684329587; l=2258;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZxLc6Pyv1LGo4O8MrviS8WijNnatdta5WuEdHKXOjlE=;
 b=Ra4e2+oAWw6UTwvdX5hrOrg9xPuQHRqVZBPauOldQ4WFI+T0ug71fez4yahebETqSm7cE0H2w
 AHiHBZav3vCBe11B9Cs6t/HNSLir3Gqkyir64zF2sB5MtrG9/NSN6O2
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

We need more granularity for things like the GPU. Add the missing levels.

This unfortunately requires some re-indexing, resulting in an ugly diff.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..0c987dd4e4e5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3616,35 +3616,55 @@ rpmhpd_opp_min_svs: opp2 {
 						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
 					};
 
-					rpmhpd_opp_low_svs: opp3 {
+					rpmhpd_opp_lov_svs_d2: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					};
+
+					rpmhpd_opp_lov_svs_d1: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					};
+
+					rpmhpd_opp_lov_svs_d0: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					};
+
+					rpmhpd_opp_low_svs: opp6 {
 						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					};
 
-					rpmhpd_opp_svs: opp4 {
+					rpmhpd_opp_low_svs_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					};
+
+					rpmhpd_opp_svs: opp8 {
 						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					};
 
-					rpmhpd_opp_svs_l1: opp5 {
+					rpmhpd_opp_svs_l0: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					};
+
+					rpmhpd_opp_svs_l1: opp10 {
 						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					};
 
-					rpmhpd_opp_nom: opp6 {
+					rpmhpd_opp_nom: opp11 {
 						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					};
 
-					rpmhpd_opp_nom_l1: opp7 {
+					rpmhpd_opp_nom_l1: opp12 {
 						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					};
 
-					rpmhpd_opp_nom_l2: opp8 {
+					rpmhpd_opp_nom_l2: opp13 {
 						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
 					};
 
-					rpmhpd_opp_turbo: opp9 {
+					rpmhpd_opp_turbo: opp14 {
 						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
 					};
 
-					rpmhpd_opp_turbo_l1: opp10 {
+					rpmhpd_opp_turbo_l1: opp15 {
 						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					};
 				};

-- 
2.40.1

