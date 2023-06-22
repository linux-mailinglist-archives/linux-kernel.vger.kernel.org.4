Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E473A04A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFVL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjFVL6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:58:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580C1FF5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:58:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso95921521fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435079; x=1690027079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZILjfplVkyXwwY/Vk9vNMVAT/CrFw5qFILje9oH7ZxI=;
        b=LFBzzcgBhdvdLMdLBlLx7ZI7Tbs8dLvXoX+sZiLRdvnn1fl4QQpTvnEsaiC+BagjKr
         2XFndg/MxLlKknPcrXMlBOWXB0SWNWyMyS8FiCFTGRq3utGkWa/T2QpN2rZte6NigmUR
         tiPBaoyKKNyE5NvyH7vm14STfo/RCdqaLQyd1sYX8ts6f3kg0x4icfNr/+m8YX3YKSJh
         wrRTGLdPOzbKMFiatMpycMLTtgFmujXhcEdEHewhtQoebwEQLl98pEOSEEdzVBO6XBf6
         84UdRTCigMjnJCmQ1wEo8+rMR6grFI6lS6zWRzKt9UdpRw+msamfuH7ZrHBLwDer2YZ9
         zXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435079; x=1690027079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZILjfplVkyXwwY/Vk9vNMVAT/CrFw5qFILje9oH7ZxI=;
        b=bauzQtFpLnKkrcRYntImfTQW5fFWV5VsmWFVHatspVq5YVQ0DcS2Jt8KOFdgi+k6Vv
         uQe8DShCfUDu6uNi4uTsbPuB8BEFAvM3BBL8/IFQk7Z5r+9HbdiQl9/YUb/KDEJYHYks
         7vGFIhuAWRzlb8yAe3Odgbv3F3mE3DX9h79itNtosuFRCZaSxJx0PWhgkx6iuDroP0vf
         YwAqrKDhRirwsQNW+7mq52xNsBMPLHwwsEaSQdTVV/ANhFhS0GzDnsprj19DevtT2trN
         z9Hk2DtqsrxA+nKHHgIcKORtZQryngaWpNTx/hGQ1b6Dv41EnBx8tWES1dZFlVZbXy7I
         F/nA==
X-Gm-Message-State: AC+VfDzSvc4Mf2iQWLxDrqpkByEbVgFtQY8L8y9MeXOPAOMPwxDYcvaW
        Sw3j+Vknor5vq9sPfSJrVGqGVg==
X-Google-Smtp-Source: ACHHUZ7m4PyiYoTIiAFmkVfe+HaWu+zBYTvJH1Wb7MrWlmzq7NpPoY3WEY2HlcXIYUgaxMcM6zzbWQ==
X-Received: by 2002:a19:711c:0:b0:4f6:3000:4d5a with SMTP id m28-20020a19711c000000b004f630004d5amr10848140lfc.38.1687435079156;
        Thu, 22 Jun 2023 04:57:59 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:57:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 13:57:48 +0200
Subject: [PATCH 8/9] arm64: dts: qcom: msm8998: Use the correct GPLL0 leg
 for GPUCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v1-8-5b7a0d6e98b1@linaro.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=738;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ih+ryM16TgO1zmWBZ5fg0NCby9pNBTJkiA0FEt7oBOI=;
 b=3x7GPBHGo/0XQ3mC4GY7XNBfXJTntEfg2XEHTbDuKkHQXoTAbrtUce1oLaNP9lDyknU0kLBdt
 UNjKraJy5nODREE6ElWLP7/tZhZTPee5Ge0CwmJkHSYDHd7PSGbWTdk
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

GPUCC has its own GPLL0 leg, switch to it to allow shutting it down
when it's unused.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0e943ff0046..74bd05579796 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1574,7 +1574,7 @@ gpucc: clock-controller@5065000 {
 			reg = <0x05065000 0x9000>;
 
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
-				 <&gcc GPLL0_OUT_MAIN>;
+				 <&gcc GCC_GPU_GPLL0_CLK>;
 			clock-names = "xo",
 				      "gpll0";
 		};

-- 
2.41.0

