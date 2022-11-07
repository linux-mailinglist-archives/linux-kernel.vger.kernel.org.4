Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA1D620454
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiKGX6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiKGX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:57:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735CB2B185
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:57:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w14so18499147wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBn1okDA9FkjZiEO+BQaAcUqYpCACBzlx4g2jWvBS70=;
        b=K3e53IR7+l0QPXnfz04ujkXBoKgbjE0TBVBBtiJmnkYwMfwM1JHfF7aotmR0GXmMHS
         ld8otWUUgsX0QtK8kI1VsXACkFLa+1u+H3Xu1eEh/bycRqr1tcoy04AZdX3Dx6ulxBPf
         dpHK0hJNlhjD9HfShbyyVPsGkslxNe9LDmEXunaV889T3y5X+5mX8T/RMHc1yLmhqTE7
         Jo1jmFPDF4Wf834xG9FMlShWPMOaprekhV7pZnBrPmndxN0tztIiwtBGRKHsJQ357buC
         dMuoKgAx8SxCWsayT1uCpDJHhnZkWLKpbccfi2YsWrynXehUsA7fGu+SEJpqnE4w+azJ
         GKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBn1okDA9FkjZiEO+BQaAcUqYpCACBzlx4g2jWvBS70=;
        b=sPdD+Our470nQcmTR2QDke6Cykyro74CgpoJB5yUcbDpX0NNUXytn/MsvOfmIegbr0
         ODaK+8sdNcu0q19b+zXgRUhS3hDCSSSTYQq67+TGBnEaIOo2/1fnfqKZuU0749BwTUMr
         ZibiGVgCPhp7Kz1mv6w3B5TF8mQ9C1qJQ2fzvnvCJbFRHQPIzqDMK/lpA2U9QVXSDtGk
         cr2jpCD+YC4r94BmiUmCRNQ8E7y+//Ke6u8fw0EvXU15QvYAQMzxxShyJecvsBKuksh8
         y0J26U3YSC6903hoEUgbquRsYOFpugiy/V9diR33wrwHFBIjdcG72znYAjY8nlKQqQgN
         4gaA==
X-Gm-Message-State: ACrzQf0bn+f2eImMgCp23sAbdLKfoceV/ghjPXswBBvulAzKfsuAQ4AT
        TpIryZSJN4Pz9sxDBhJnlr1OBw==
X-Google-Smtp-Source: AMsMyM5yDUgGkXsBv7Wu1gTmRMP+mGOxbX8xo3mHEFp6SmwqdAOxmafK7Smt+UktbHr9XX3c7bHK1Q==
X-Received: by 2002:a5d:64e8:0:b0:236:6225:5c16 with SMTP id g8-20020a5d64e8000000b0023662255c16mr33543688wri.219.1667865436017;
        Mon, 07 Nov 2022 15:57:16 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm8386161wrf.76.2022.11.07.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:57:15 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v2 18/18] arm64: dts: qcom: sm8250: Add compat qcom,mdss-dsi-ctrl-sm8250
Date:   Mon,  7 Nov 2022 23:56:54 +0000
Message-Id: <20221107235654.1769462-19-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add silicon specific compatible qcom,mdss-dsi-ctrl-sm8250 to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sm8250 against the yaml documentation.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 0d47c5b7148e1..9297816369524 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3528,7 +3528,8 @@ opp-460000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,mdss-dsi-ctrl-sm8250",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -3619,7 +3620,8 @@ dsi0_phy: dsi-phy@ae94400 {
 			};
 
 			dsi1: dsi@ae96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,mdss-dsi-ctrl-sm8250",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae96000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

