Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4673EB65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFZUBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjFZUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:00:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BC1736
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so2102488e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687809645; x=1690401645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imK7Izrf9XR0OzZ//Iou7g22arhXPCMNK+D4dNlp2hs=;
        b=oeJIeukDECgfDArUfNvY+piZwLvJVsJqVdtUK71oyzAJPwHjMoRyrqcNz2qmKckza1
         2bhSE24nn9Koor08zFL3xs0ypbKDXDuQ3aqs2Y3egMdAaIE5DrlrNOeIQS7vPsD+zG3z
         7vd/P4fAz7DWOlaYlkrmMdAPWIHC99JU7DQoRXybf6rhTBoLnbWpv0ZjvM55CQ+DIEGr
         iGFFSyUZDj4ZQkdC5WwZX9si8B/i/PgiqGvYSFbNGUii+bER3Ul9nhySR050W4+x3tTR
         iQ2f70k6rJcrKlDJymvHKwCdNfOk7tvuUsIvf2N6SWuafsB5/6x+4R53Gsil6aiJInCh
         Cpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809645; x=1690401645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imK7Izrf9XR0OzZ//Iou7g22arhXPCMNK+D4dNlp2hs=;
        b=hWaxt3jpywTTGlZs+O0zOsZrUyd6VMaMmByu8OSRhUAJ4MQdEosypqkMLLQzOmzNC+
         gXljQiiOiM8CqwBkp3271smIgy73Q76Sp/Xt+fRyC/0Qw4/VSSio2i1ZxSXVwzs0McWJ
         m8L9p0575rza4l10B2SgdmOjr581dsRMvbLjDyMwbxWcF8yTUFkU0ixnap50LIApA7ZP
         wfmKEur3C52zvlrnjqvX1jmTBRcCnUAQ8q2PGSXIBgqZdAmJo1Dr+ZMZnJqRvN/ipaHZ
         UvdLP1T5FN2arrjqpabZRrXJQci7donUsNTjnGvvTI1I6nl+aUkcxEKo2rTD3lpWbRl6
         V6Sw==
X-Gm-Message-State: AC+VfDz3wZYQqmEP13PQ0uDv3fSORIHHZSzYB6/kWcDUtNpA8L9FTkGT
        pTHvo8H8/HOu2Rh4A3L/lkcdbQ==
X-Google-Smtp-Source: ACHHUZ7VCjJOZiS3WzEnzBQTQhU2ENJVrUE11RzNnix8tmm+eAeK5rtPHJs71pENoFBFyWy/zIglEw==
X-Received: by 2002:a19:5e01:0:b0:4f3:b18a:6494 with SMTP id s1-20020a195e01000000b004f3b18a6494mr9009627lfb.22.1687809645418;
        Mon, 26 Jun 2023 13:00:45 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b004fb74cb9670sm628082lfi.125.2023.06.26.13.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:00:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 22:00:26 +0200
Subject: [PATCH 4/7] arm64: dts: qcom: pm660l: Add missing short interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-topic-bindingsfixups-v1-4-254ae8642e69@linaro.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
In-Reply-To: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687809636; l=1001;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=J+dkBOrcQCIu7gPctg2TZ5QROQCaxdqVG4hEZO0yoyA=;
 b=0gJ0roLPKeoCHgf+euqfCRvW6DzudIvp48K5ZYq5FKATxUBnSe+iuDqXkagQndQvumQ6/T5m6
 i3FQk573ojNAZyHRpViu0uLF4jDYUwsE9SyWvaInL4nX+aoVlK10Br8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing short interrupt. This fixes the schema warning:

wled@d800: interrupt-names: ['ovp'] is too short

Fixes: 7b56a804e58b ("arm64: dts: qcom: pm660l: Add WLED support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm660l.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 87b71b7205b8..6fdbf507c262 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -74,8 +74,9 @@ pm660l_lpg: pwm {
 		pm660l_wled: leds@d800 {
 			compatible = "qcom,pm660l-wled";
 			reg = <0xd800>, <0xd900>;
-			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "ovp";
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
 			label = "backlight";
 
 			status = "disabled";

-- 
2.41.0

