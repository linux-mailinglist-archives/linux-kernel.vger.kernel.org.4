Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41015748520
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGENgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGENgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:36:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A1171C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:36:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so109222701fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688564194; x=1691156194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLuG9KuEJuS9NyZByQeLuBduARgWRDXGrvbnJCmv87Y=;
        b=BVnw0z00jp36hhC2CRXVrcj5uVSHR6InYJBj4hMLIXFa8/SKsh/RaG+1RI+UOGQ/yW
         theNQEoCGiIHclWLQg98wFeSTC+2aaw4YllAjdoqgiTOXGAylJT4GCf3AO/3SiyM69vc
         mtrf0Nv6JTWtJ24owN8rnoBJslj7jxNJYG34l0kNB5HUOol2+jb3IcgVgdJsYxmlMZQc
         dzI3WZEjTfYmCz5TeFMWRrCesbGnNLi3uoMxvKSndNqHQs5ArZcKYlj2reUxzJppDFNp
         twdUCX0z6Nrso70p0+k9IdpqbLNN9S+LOBfGbUgMki8A5tItVrmHpZTtRviPcRA4MP8U
         dgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564194; x=1691156194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLuG9KuEJuS9NyZByQeLuBduARgWRDXGrvbnJCmv87Y=;
        b=OZQj6EBX44vcqonnFFadOTvacXEgaoiAU8ushovKHCrELb6GoEVkA1tTRMUeF8WtEF
         2lN0eEHWxg2NWXsWYLEk1/cRJqkIerHe9mZAaUmSDdYp70/gl+KJijQZgbCa6tpp73LV
         QTcPDeNiI+01mM0PUCKVEgDkV9sPvPHkxSFSDd15EBCW+sewwqCrPAcBI4qZ/ylHDl7h
         4lStrWbfVdP7GiywQ9b/gt6NBVr1v1envhYlfjnPWSDK+OHDmNJTAdZgAkwH1/LZZ8gs
         TCiEzB1hVhcLJ/OHTZDZNXSRtm3lv7h5W+5UIGOaNLsvvPP6+h6WvqiNfjF976pxkcKC
         UlEA==
X-Gm-Message-State: ABy/qLb0h7zfa2DhC9qlQhSgdwgfMLafJcw/mEQVfEumpymIEN9Ophdp
        RooxILB6ZAyGg26N5f4EXkIgDw==
X-Google-Smtp-Source: APBJJlGMJO9Y6xzoHHzL/Xd0vBQ/yUPQ4Kd1fYN38wnDNQp4j3ps1M59oKBlf35m8zoVrKVOfVY/fg==
X-Received: by 2002:a2e:800b:0:b0:2b6:bbb9:b560 with SMTP id j11-20020a2e800b000000b002b6bbb9b560mr10341358ljg.0.1688564193976;
        Wed, 05 Jul 2023 06:36:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id z16-20020a2e7e10000000b002b700952298sm246803ljc.33.2023.07.05.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:36:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 05 Jul 2023 15:36:23 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sm8350: Add missing LMH interrupts
 to cpufreq
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-topic-sm8350_fixes-v1-3-0f69f70ccb6a@linaro.org>
References: <20230705-topic-sm8350_fixes-v1-0-0f69f70ccb6a@linaro.org>
In-Reply-To: <20230705-topic-sm8350_fixes-v1-0-0f69f70ccb6a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688564188; l=1028;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3JUnpoYQtL09+7PeKMql4RBG+8C55y1mCnZjG94miQ0=;
 b=ESKn+TvZGOWU0NLEyoasfkSRD43nl9nmnMCc3i4JjgppwwLbDBljAr2Xh+ZVoXLhx9Aq7M9+x
 pNGYcRv1PguBbilxGVBPeccr/PyJsHGhQMruXkh27l6DZTD1N2WTvWi
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

Add the missing interrupts that communicate the hardware-managed
throttling to Linux.

Fixes: ccbb3abb23a5 ("arm64: dts: qcom: sm8350: Add cpufreq node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 4981a502d4ce..00083782e533 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3407,6 +3407,13 @@ cpufreq_hw: cpufreq@18591000 {
 			      <0 0x18593000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
 
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1",
+					  "dcvsh-irq-2";
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 

-- 
2.41.0

