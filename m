Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0402736D06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjFTNS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFTNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DB1BC3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b470330145so39941521fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687267085; x=1689859085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPPnIKrExyggPEKNdXPVOY3qQ/GVfzx50WZpVsmSHmQ=;
        b=Hlweeu0GJUtdMkguNd4fWK1oyhlBLF9vxka7Ps3d5tEO2RY5wYL7JbeMXSPVUAamb3
         0MuO7jtPJbYTrMM9/U6ZwHT/Zra8H+lQ/N4OB5gNARM7ZaQcIsj9RNKLjGo+NxAAi+CF
         3XUW3LGt++IvfB4yWNgdlhvVmE3qtGqFn7gwW5m3vQDtQi98J0bgZ170WVhmlQJ4PX8F
         kejLuFwbi51rZi/k4JD3EVNYr7sSLCtf1QCAiofX53NhXFy4Cf9F7Iw1aDA0/8cwnue6
         AxUsBSkl5sc3ADrYUsdYRIuLm+Bu0OHOUjVcaeu6hOK1NIKVqC0bUEtbJEwLVnpc2IQ1
         V55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267085; x=1689859085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPPnIKrExyggPEKNdXPVOY3qQ/GVfzx50WZpVsmSHmQ=;
        b=V2xpiVlF18gJ9q/kaFYrJFxkWWe5wZZAFTQd9H9Go7LQhtRO1xr5Pj+mjwJz9/Ae3m
         f2CtpxUDpJDg7DeDaUFyCRjPNSXNacQHe84qXhhX/7jekbL7KsCiKO9kba9Z1BvYYdr1
         mPfQXXyTMV21qjfydSbtCtNqpow4MKQlI8ewC6c77giuOmnFayzaFXse1hyoZAeZAeBe
         5LXWc4xFotIeeHatFwRqNMtBG2OB7Hf1XsE9uCZP7r/iQl+kWaZXYjUbrMfIFaj00eeN
         aCkXbXDnSjYS9QsDP7TnCUeaCztIKT3I74oSgeVDuQr/rahubR5uKRnVXca1eimEZqBH
         /+Yw==
X-Gm-Message-State: AC+VfDw1M7BIDXdmXAQn0QsWE4WOmZ1XUvieZFD+vfypkz8oRCLJ0JSH
        y4+bmnDN6o7kJiui7Dh0ji4pVQ==
X-Google-Smtp-Source: ACHHUZ6n5nt4M+U09pwWxJOfKT31kbWnL6NzNVxLYdM8tz4R3Pv+8R+tZgyf+WUvdgrC8VkN0YW0Yw==
X-Received: by 2002:a2e:92d6:0:b0:2b4:7a19:afc9 with SMTP id k22-20020a2e92d6000000b002b47a19afc9mr3338692ljh.15.1687267085479;
        Tue, 20 Jun 2023 06:18:05 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id h19-20020a2eb0f3000000b002b3318c8d6fsm414433ljl.28.2023.06.20.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 15:17:47 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm6115p-j606f: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-gpu_tablet_disp-v1-3-7bb02bec8dc0@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687267079; l=728;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DG1Kku4Yif9zFLSt2SwuInTVyNCBfhoN7wmz9kKZ/L4=;
 b=oCLFeh19WhAGL2UmgNqWuA9WEkoZvHgmgC/XlRQxNwXsJ7KgtLyvQU5/tL6TbG7plaZfrIrJ2
 LipkQHs8M+zDHwEN3nS1zEPp3NdwZ9kMtO/0c97/SUeMUsgxRDuI05u
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

Enable the A610 GPU and provide a firmware path to the ZAP blob.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index a10ce676bd44..ed745678fadd 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -65,6 +65,14 @@ ramoops@ffc00000 {
 	};
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm6115/LENOVO/J606F/a610_zap.mbn";
+	};
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.41.0

