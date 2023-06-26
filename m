Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEF73EB78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFZUBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjFZUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:00:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76241BDF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso2270648e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687809650; x=1690401650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuktTM1UhdAXyb9mJvjHwufVvOKEzeBXkcK386zAIO0=;
        b=hGFXgcp1n/VTAG9JKtBSrKkyJIMQ5W9aN33MYvWk0ga+6fcAkKRLJKt1fxiCYKqav9
         4KThNR3P50sR78T010b7R7SoBTu0RQJCWAbfcRPObzUrPhK2zSs8FZkJH/tjBYwkf17z
         piEIHO/fhmx9fW5tpEafldrGNsjBBGQcFUUzoIoHqvPCYi342GeJvLCN3SZ0t9//wzMA
         jMWmGFdWeqsQS5Q3NQRgUioze2z0r9cRoEpGCVMc0KlJ7vshUUQM+iFHPLwBKRuWYrSe
         P9alLc6v+qhYtqR0EOG7a1wIndaftiGDgqH2Sedzf6Hn/MoiPzLhUFgEpjYnZl55vIUd
         lk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809650; x=1690401650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuktTM1UhdAXyb9mJvjHwufVvOKEzeBXkcK386zAIO0=;
        b=Xi+kavzoMGKhTX6CfLIFvFiwom5aPiEFF0pXOW4OaR9GyU5Gab4cWQ6MVYYOhGNPQ/
         QkKQPVKlUP413brm7w4C6DYo8GiJgQ7XOIG6Is3rnkZeIE3/20seANbOTCvBI6RUfVeT
         P6Ysbh5qe+XG1Q188QTcmLg9J5APFmxG4vHgztg/u2CC0blMGvMzeiEvmCdj9dol137f
         lZJV4FMGRCmsp5oQihEppG439IpAuhBla6Fpxt/Jjaq6gXRJrp16yV9IahGNddmVGiMU
         ZIaicNuicmmvNVSujNhUHRzmweKSRBAOZPIoog6tYOrAByBLkcUVq8yxDYCva1w/Upm4
         mLag==
X-Gm-Message-State: AC+VfDwiaX1JD8zURE1Gs7kYKIsD/GncwiH33QxfWKHILwbH5n2oIU4r
        xanWiWQn6lIErH5+UFGZbMK08Q==
X-Google-Smtp-Source: ACHHUZ7EXepLP9S0iQxWok0b76K0pbQWxmI21PNK3vwwhPWOkkfzSbxqTwv0BqrkbGqJc+qzUVwKmw==
X-Received: by 2002:a19:7715:0:b0:4f9:5a87:1028 with SMTP id s21-20020a197715000000b004f95a871028mr8492827lfc.30.1687809650686;
        Mon, 26 Jun 2023 13:00:50 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b004fb74cb9670sm628082lfi.125.2023.06.26.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:00:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 22:00:29 +0200
Subject: [PATCH 7/7] arm64: dts: qcom: sc8180x: Add missing 'cache-unified'
 to L3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-topic-bindingsfixups-v1-7-254ae8642e69@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687809636; l=751;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ibNUSGIgP6PhhvRriKU7DI4t+22ag5VAkhr7uTbUPMA=;
 b=PtMSn6MU54shBkuVwhD30ztIxSCv8W5HtCsm2V3hIf4gC1CdzHM4oX54cI2b2WAz1X6VI5gv0
 nuUIs36narkAfFei2b3tnCm708vhbpIALOw5HObFpt8ZcBQ5FzQv+ZZ
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

Add the missing property to fix the dt checker warning:

qcom/sc8180x-primus.dtb: l3-cache: 'cache-unified' is a required property

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 204deefbfa8b..5d8303a8dc95 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -64,6 +64,7 @@ L2_0: l2-cache {
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};

-- 
2.41.0

