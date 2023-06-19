Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6283F735C18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjFSQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFSQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:19:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899D1E72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:18:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f841b7a697so4341185e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191538; x=1689783538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCJCOnI1yJIgtPY0bSH/Iw3dongLkLZbZa4jU5bzULg=;
        b=ePl5J5GFFsh+871xAbZME1hNeODYQFBsr/Pf0XGqepVpsc1g7yb6iRA5L+h66bEmwd
         +fCoNS473AfsfMsi/FXSC59EcVrWlWC9SlM6JjtsJazqZ3KQaRoCI8R8ohZt8P8ugqm9
         1vVrw48aQ3dGoA0rACmYQRaIVFcbsxGyw7XYePOANlCgdItNpApuu/Gx6mbxz/fAFNal
         haHjX3dAUuC9xIm1jroLe9YFQq3/kBJSJznUcUdVUDUF9onHm8TyHxbijkjJTWq751c+
         VfOc6pOnIqtvfTewyjSw62LDEO6VW5Mn/+vFCkSnewjm4pn4bxkrrFInvXcVu7/IjKig
         Ze7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191538; x=1689783538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCJCOnI1yJIgtPY0bSH/Iw3dongLkLZbZa4jU5bzULg=;
        b=OfeCkIqLDDaO48uJxLZG0n8sVzZBo3ufHuhEsyDQMiScBZzAsOE/G7l2Q9ARxhkTEr
         Jw+eAzzAPfre6aljzxRZcLt8WrxTGrRKsiCkzcnEvHwJJyw2asiUCnnMeMF3+1X8cgaF
         q5HBfNoIy1IFiCdXUdXRnhxbdlPapgZxzFAoyrsWcVZ8sFDAJh1CAQGGnEBryUcPgood
         JeDhcGfhfyoAO/c4WMqLFo9tDtAmM3bdbOvNwOg0jJA9CraDsiysujIWLE6f6yLwfRx5
         alOlvIBZDgJx2CSakZ5SRic+7ZdxtgT3ZuAugaNwDuidjob+yhx+GDTtvi5uQ5rwuuyh
         2XUQ==
X-Gm-Message-State: AC+VfDxbqqgl8ZikqVXExgGnQD1zSzQHoUZdcaJCOfUFkAlC3P29gXjL
        wCCEz6Jk6x+MRoXm68HK63pcAA==
X-Google-Smtp-Source: ACHHUZ5Xcmx7sD1zWAAAmVEqIO1fpkl0OmKlLVkGi+D96PTjXo1Z4toW8puq3J09X4ZLp1+5Ip8+Zg==
X-Received: by 2002:a19:4412:0:b0:4f8:1e2a:2b55 with SMTP id r18-20020a194412000000b004f81e2a2b55mr5193195lfa.8.1687191537802;
        Mon, 19 Jun 2023 09:18:57 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id c11-20020ac2530b000000b004b4cbc942a3sm4332824lfh.127.2023.06.19.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:18:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:18:54 +0200
Subject: [PATCH RFT RFC 2/3] arm64: dts: qcom: sc8280xp: Add missing CPU
 idle states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sc8280xp-idle-v1-2-35a8b98451d0@linaro.org>
References: <20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org>
In-Reply-To: <20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687191534; l=3555;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KEJh5fKDHpG+tf7FsdNG34aNe2COjzMzqzjlkSjq5mA=;
 b=EAdzybHN11hL6DoTZDVLIw0L7SbOi69e139T6SXY7Fjnyra2wqywY2P/NKLQ+r5fGg4tHfvw6
 DvApguSzEUCApK6v7xQXu7MAXuBYhU13p6VyrVTifD7I5vm31/h+ojP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between WFI (C1) and rail power collapse (C4), the Cortex cores on the
SC8280XP can also be shut down on their own (C3).

Describe that missing idle state.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 36 ++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index d524f851cb53..b8f2ec9477f5 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -264,6 +264,16 @@ idle-states {
 			entry-method = "psci";
 
 			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
+			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "little-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -274,6 +284,16 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 			};
 
 			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <523>;
+				exit-latency-us = <1244>;
+				min-residency-us = <2207>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "big-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -601,49 +621,49 @@ psci {
 		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CPU_PD5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CPU_PD6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CPU_PD7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {

-- 
2.41.0

