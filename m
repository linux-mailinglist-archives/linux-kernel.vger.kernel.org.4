Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF773EB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjFZUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFZUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:00:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A77172A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6a0e36d42so17223981fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687809644; x=1690401644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBd8zYmgXYIJEREOfSmC9QA82+fRkHgoZhhw+yecJog=;
        b=jll4tYqzu7BMIfP4ApSYC6LZa4nDGYV1Nyq5BYckVuVw2SJIsTOPY7Kqyi+Dr1qQwg
         siJPnAB8YCZs7/2JNlMAXEatIO090IWzSvod55RnTIHFUaJiNErQwSAvUR0H5jXh4XqG
         fniW42lFDYAFzNFgl0PBTqgt9uFXz1hYv0N8i4JCIhYjC3WAPe8WrZinFk7lpNnqYFb2
         R3IqSpaLjguqRY5CqQkSNJlzXgd2rH9I1nzy6FZaBFYL3t5ai9gwC60JhzCKMDCKlTqf
         l6YPtkSxSgtCkkFNC58x3QRoHpM2NGGQ88R60ObwaO0cVttcKllqbhpG1cfmcyNwZgVy
         hS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809644; x=1690401644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBd8zYmgXYIJEREOfSmC9QA82+fRkHgoZhhw+yecJog=;
        b=HOCYYEvmJshwvan9A+F7fx5PzjcHsRSsfRzpgyIfcSc3urj1plVuteXVbC+cN86z2m
         er1M5mJWgG918jXRHM246Cj5S1REuva8MglihNqB5TxrjR/Ja2+p5izaBlOcVrSrzxYr
         Wr7BN+qJmUXJPs0XtrY8rlJRpBzPkrGQtBk9tNpZIcZwId2gXJX0FhsF+f7+GGPbMyxU
         QUWA5nVOay2Q7ykl2XMytj0RZx2KqXOVXqvb/wGsvQDnWByqjqEEgw/inWCAEuekyIbB
         5BlIvxwWfC+kJgY72qJePuQCOEhd32FMa80BuAzOcQZ9m+rQwkncdNCm2VD4IfnGOE0X
         WTQg==
X-Gm-Message-State: AC+VfDzFpYJVEi5wbJDWB+2xj4lRGGX7lL3rikYzeQeLjJZbAH/WS2zG
        mGsvSMT435NsdiIA0vDHlsgDPw==
X-Google-Smtp-Source: ACHHUZ6n/y7KAJeGbOMz7+mh+y2vPDpUaiElzO4mf+ROXSrqj/nAWYSYK03jdE9sAaZ6NI5/aI3Yaw==
X-Received: by 2002:a05:6512:3088:b0:4f6:2d47:274c with SMTP id z8-20020a056512308800b004f62d47274cmr12391004lfd.15.1687809643729;
        Mon, 26 Jun 2023 13:00:43 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b004fb74cb9670sm628082lfi.125.2023.06.26.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:00:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 22:00:25 +0200
Subject: [PATCH 3/7] arm64: dts: qcom: pm6150l: Add missing short interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-topic-bindingsfixups-v1-3-254ae8642e69@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687809636; l=1027;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ujcheFLL/6qV12qqejjbZeIk898Ii1a50BTU4uUbDeY=;
 b=NGVkEswwSUw3X5KijxbzS2TpVSNV+7El5Pf99qS9FEoTk3ICMAcsn62N018+OLx8A/O9/Rhy1
 UDq6h9qiILRAUHLFbMxyhxQtOd4i6+UfK6BEnOlz0r8U493lH3wLFMP
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

Add the missing short interrupt. This fixes the schema warning:

wled@d800: interrupt-names: ['ovp'] is too short

Fixes: fe508ced49dd ("arm64: dts: qcom: pm6150l: Add wled node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 6a7fe1e59f15..d13a1ab7c20b 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -121,8 +121,9 @@ pm6150l_flash: led-controller@d300 {
 		pm6150l_wled: leds@d800 {
 			compatible = "qcom,pm6150l-wled";
 			reg = <0xd800>, <0xd900>;
-			interrupts = <0x5 0xd8 0x1 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "ovp";
+			interrupts = <0x5 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x5 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
 			label = "backlight";
 
 			status = "disabled";

-- 
2.41.0

