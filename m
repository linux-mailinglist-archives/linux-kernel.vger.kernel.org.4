Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05A3739BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjFVJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjFVJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:04:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB026AE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so58247225e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424255; x=1690016255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ4vkNp7Si6XogVMBMNthb6WR/2t+CxPIqYcDxsZReY=;
        b=P4dhJYUJOZPzrsdaLhVY4+jcGkTJTORjgVSSsn5KllVf0ox4xgbnFoFa2/g1j1gdrp
         uN13kf5B4Evetto/dlelSR3OPsVOGfsCs4RzFa/s+U3EjyXXWXjBRV4Fd81CGZjduF/e
         Z/5DDUjukTh4NPcCbEZe/9ntD7N8n3LUgEWh/YiZwZRFMWKOssuEukbdb6AYh8w243Ci
         hXDfofebUuSec1+Gyvek9zxGKaaisMoR1zFfqljA9mXahA57xBH1VrukWdbnEWUjFxQ5
         moorirmmk411AMh6RZqdAYyx5t1O93jP7XqMVE+ySd8YGrRHG7GsLKRGm5fJswoUMaHA
         Puzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424255; x=1690016255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ4vkNp7Si6XogVMBMNthb6WR/2t+CxPIqYcDxsZReY=;
        b=dpO57aJxrTeu8vEgS3oN/xT5Y+E4rMzLIHGFF5VD/5ihWSDEVuuvhOen1AtoBxJcBS
         4nPt95IL/DCe+eQd8gmf87nYALW5z8CxHTenAcn6kbgVF6s151tT71WDbYImdtOVcD7H
         RLkptJ9rtDjsHkRXuzi27fN+xezTO+03cV01MAgyth2mNUYUp9BNKeC9MAESbn225xIh
         Q7m1e6IwVTyTM6jvLLvJaB/9VE9puRqWHIp1naHlPag365T0fj/AhQwspULyEhXOvI9Y
         zzsD3r+eLCBmvCZy7VhHHY/L3kpkyCHR9r94GuFYEOIVyZ29DE9ETLP4uAfAGjPnwk3n
         2ksw==
X-Gm-Message-State: AC+VfDwytMZovi2ajCPPzsTRUlmIesyIOyaxgkHk+NdHC78spSiZANAX
        5Vqk+NhPL1f1OX4I3IGdaixqlw==
X-Google-Smtp-Source: ACHHUZ7MNLVNqxyF6jckXpQJOEtoVONQvGfyXOSOjErCdqCEh859B/SDotPCOb+g3l7Z1LjL1zZIaA==
X-Received: by 2002:a05:600c:2290:b0:3f9:c9b7:1911 with SMTP id 16-20020a05600c229000b003f9c9b71911mr2350263wmf.32.1687424254889;
        Thu, 22 Jun 2023 01:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c20ca00b003f9b29ba838sm7136305wmm.35.2023.06.22.01.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:57:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 10:57:18 +0200
Subject: [PATCH 1/5] arm64: dts: qcom: sm8[1235]50-mtp: add chassis-type
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-sm8x50-upstream-chassis-type-v1-1-13f676eb71f3@linaro.org>
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zKXtlI65HW1ON0mzd8kaZUs+rZG7rjMEDKWAQq1aeMA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklAz6z+YrYnTJZTRObIxh3LxYzBpMrXXb65ugAoCv
 EL1G8/+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJQM+gAKCRB33NvayMhJ0VlXD/
 9VAQ103ImhpH4uguSQza2qNn7OD6c3ENxdSh53BlEi5J0El4aYIoYchEbOZcTTVp7Ci0loi5KJ+6s+
 cpf/UVseaOc2+VrcVyh8QwZ2MM1nU4a+Bq4Ss2TzPbOzo62gpDlHQeT5t+OFcFEl5omlQfqyrqNOVh
 brgp2pDLo1+EG6mIH/JdtI3kL+G0LFt2RtcOFQ6eV8Ik3i92cYvZTZSsnZBFqO9tJqX7DoeLnE6onh
 wmdmcv/V1Pshq7YtaF1gNcC0Tnggkc/RTyZUZrX/t5Mcz4yyO24hgkvyirZ2zydhM8fHddML9Pi+ai
 eHoOYd92znhqx3n//o5DmlSLp1pUDq8sm0ImxSwbSZmGMz8oKKLfGzclxzSuR8USTpmhi0u0ZoRVy4
 xhX+UxL2tvZ5DlgTOT4sEsswUMoN8lCquNfoPeXrBN15A2jaTvbnC+zBvhn8+e7xeF6pibixoxl2dj
 jXqutopA0vlCRwg04hgN6tVEX4Zr+v4QWgNmC7Admg62kb3kkzB6Z6PnmESWhSzjW8bF+xN6YI0cMn
 EONGWbn4NGGLmNCYt5SMokacEr3HczeZ9pgYVnO0sHk6yKdRUDiIkjV62QxlXUuc3hCnoUmcAQUGNS
 0TkzhjpA74aXlJIjr7RrgEZYeTpE4WByIcoXvpIfC98YzHjoEN3ykDs9brRQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm's Mobile Test Platforms devices are handsets, set the
chassis-type property to 'handset'.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 1 +
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 1 +
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts | 1 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 34ec84916bdd..286350ac7751 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -16,6 +16,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. SM8150 MTP";
 	compatible = "qcom,sm8150-mtp", "qcom,sm8150";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &uart2;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 4c9de236676d..ad2b60e281eb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -18,6 +18,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. SM8250 MTP";
 	compatible = "qcom,sm8250-mtp", "qcom,sm8250";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &uart12;
diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index d21d2aacf201..c5a6c8745606 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -17,6 +17,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. sm8350 MTP";
 	compatible = "qcom,sm8350-mtp", "qcom,sm8350";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &uart2;
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index ec86c5f38045..00c7e1704a8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -18,6 +18,7 @@
 / {
 	model = "Qualcomm Technologies, Inc. SM8550 MTP";
 	compatible = "qcom,sm8550-mtp", "qcom,sm8550";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &uart7;

-- 
2.34.1

