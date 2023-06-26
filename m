Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFCC73EB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFZUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFZUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:00:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814C173E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso1946905e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687809647; x=1690401647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKfIdLUUH2RS/LUserqASM5cmaLcT+sMjCEMVJp6OG0=;
        b=qsKd6ggy1Axj9lwIWB2x+mFB2qIylwRI7aUVdF0KWYKyzCnHXgocW+DxYET2wtcQJ7
         ms7H9kIvTWV4I+LzJv6w0tdtv5EvUSwYtKWosuxUMUY4I7HrPLkYFmhawBfQY9uGGOjq
         z1aVRVxrhiAPdsqDx6vvrQQaPQ0m3Dyu2G4MLf2E2xIyfHKXOBHkRWP8l9URAz8IH5Ho
         C8biajrPGizw8+ceEXeUdlcSR+CPY4xKtJ7C3FGCCuKIJ10wRPUy/TznqAzhRmJXDNMM
         bWxiXvh/HCylYruibx/6DXyA8PXwL3LprjPQXQECtlDi26AebNyGljYSLKMGNbqgn533
         ZX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809647; x=1690401647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKfIdLUUH2RS/LUserqASM5cmaLcT+sMjCEMVJp6OG0=;
        b=K05xvyAFFCKzMS97z+0HKJQT3FTAtCr3Fo/Qj9Dnv27vHoOr4jRhgvE1AVGcFo9iPy
         ijsdifHArk9I38oEfTXL8148c7/zCBKGTT3KSUCPmjYP5PbvgoLV4wECKLY64unKnouI
         vc8hHWToK6cr2nb1XDyYDXFU6gXuwwGvmeRftAAqwQOk1V4S897wM9imF5OxKGsZpbIw
         iRGIyQNrWCLngSXCDv5u27qOYJqlO+OhjLd9X9jrVqcWqjB95Avx15XqZc1Jpujyq9tJ
         dfNgzv/u4r9RUxlu2LHXBRgMmJPuod8j8y/njTcZ6Ex7yS31LWIlFj7dC4Bd8TYuz50Z
         M1tg==
X-Gm-Message-State: AC+VfDwFEbAi6XZLe4eptO5UeRQZKSeomQJDwMjn7rjLCtQtJDnuXSRo
        ZK8S3/MH/KWUDZUJwgHm8CzagrjEBbVnSZLZkK4=
X-Google-Smtp-Source: ACHHUZ4NLSXysy6psp13JHUXwmMYc7ARbE87NuhMyBupcqaANX/p2M/kcomktzH1OGLoppl6tRXEnw==
X-Received: by 2002:a05:6512:447:b0:4f8:5fce:3683 with SMTP id y7-20020a056512044700b004f85fce3683mr15653218lfk.20.1687809647097;
        Mon, 26 Jun 2023 13:00:47 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b004fb74cb9670sm628082lfi.125.2023.06.26.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:00:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 22:00:27 +0200
Subject: [PATCH 5/7] arm64: dts: qcom: pmi8950: Add missing OVP interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-topic-bindingsfixups-v1-5-254ae8642e69@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687809636; l=1018;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KUd2AC4tc+iLheKuH/ERKh2OsQIUCXg4x0GOwnEVQBc=;
 b=3BhxLUb7/d4mmkWDECw8N4IewedZ36153EHBhClQZe07ll84G9Q/ATFQMLlZrTTxPAYqXzcp2
 RexIcXisuOjBJwBAaW0zxlo66RnSjeHVuZBf22YFCMJCNhOFJp14BO1
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

Add the missing OVP interrupt. This fixes the schema warning:

wled@d800: interrupt-names: ['short'] is too short

Fixes: 0d97fdf380b4 ("arm64: dts: qcom: Add configuration for PMI8950 peripheral")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index c09a9681bc0c..1029f3b1bb9a 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -87,8 +87,9 @@ pmic@3 {
 		pmi8950_wled: leds@d800 {
 			compatible = "qcom,pmi8950-wled";
 			reg = <0xd800>, <0xd900>;
-			interrupts = <0x3 0xd8 0x02 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "short";
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
 			label = "backlight";
 
 			status = "disabled";

-- 
2.41.0

