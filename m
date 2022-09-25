Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202F05E92C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIYLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIYLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:43:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB426ACC
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:43:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c7so4622793ljm.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date;
        bh=xdUpkjLWneiu1az8qo/Aypa1Ui05jsIcIxb7bsaMP+g=;
        b=suFkZbD4pRhBqnpo7QzFERWcc4jsxyfpT3Gc8lK0xwS6vIldPB0Tjpno0HNQNiScjL
         yUczipX0UEFByvyIaW6VxwYP4NFnYTVDHDkOimLsKUdesl+P2edygdjt69f7vu+gelVH
         MnnSS5FPm+mz9XkAMoYj8a7SFT//9p1uWaYHel228rX3g8IX1Ra1iDdP3KFU8TrI2dvG
         pje/POpyr9BaPK/1fhZAfsaBNJ29+7nylbN+utM5QnROwWs/1JN3ed1Oi+INqG2gvKXf
         6coLXaPR/pohmGoORVAm7qKpBb0X4JN89BGU0jMMM5jLRAfp26V0SRlcvmuC5X93x7m6
         D8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date;
        bh=xdUpkjLWneiu1az8qo/Aypa1Ui05jsIcIxb7bsaMP+g=;
        b=eNYPw7jvZCU7buUey/4Wqg/GuM2yQxWKMN7piwjzVKijhyzZIHYmcWasnvnsg1c8td
         XdLHQunycvJ3PAzJwt9Ggt50k2kztKHrdAFnOoXPec7XDjWo5Qp9pxvFouHosSslBudl
         FqntsjnPWaoK6jqoU8p+0bgxnq/j//rSQNV+nX970DzUlLolXBoKsOJI1VDN/RLc5Fis
         683gDdDDB/TDh85Ehl5WML5lCcbH+VK1nfr73NqyWgGykD4m3RLm4aGysF99BjFIZA/9
         Sal37KaokIjeaRmi/fwMoXftK7yFnGlfjIpllD50+Z2N/7365OjuGSSKSc7QjK6zt3cR
         xlhw==
X-Gm-Message-State: ACrzQf2GoPB/c+mnFLzXW1h1KaSIixnbqyMyZJduqlpjys3cHHzzvn7w
        Mn8PTUhHsd+bE9ggncf2OQ2Pvw==
X-Google-Smtp-Source: AMsMyM59gBFRFjC9Z1NVafxeKXY3lCwEBML/x/82ul0gly35mS9sN1N4fVVRpaRGsCuEM2FGjhu0fw==
X-Received: by 2002:a05:651c:179e:b0:26b:dbbb:eb9 with SMTP id bn30-20020a05651c179e00b0026bdbbb0eb9mr5696131ljb.121.1664106208210;
        Sun, 25 Sep 2022 04:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.228.177])
        by smtp.gmail.com with ESMTPSA id b10-20020a2eb90a000000b00261d619fb16sm2074425ljb.82.2022.09.25.04.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2022 04:43:27 -0700 (PDT)
Date:   Sun, 25 Sep 2022 14:43:13 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: qcom: restrict drivers per ARM/ARM64
User-Agent: K-9 Mail for Android
In-Reply-To: <20220925112103.148836-1-krzysztof.kozlowski@linaro.org>
References: <20220925112103.148836-1-krzysztof.kozlowski@linaro.org>
Message-ID: <08E290AD-C842-4BF2-9C57-2CE59A4C5D88@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 September 2022 14:21:03 GMT+03:00, Krzysztof Kozlowski <krzysztof=2E=
kozlowski@linaro=2Eorg> wrote:
>There is no point to allow selecting pin-controller drivers for Qualcomm
>ARMv7 SoCs when building ARM64 kernel, and vice versa=2E  This makes
>kernel configuration more difficult as many do not remember the Qualcomm
>SoCs=2E  There won't be a single image for ARMv7 and ARMv8/9 SoCs, so no
>features/options are lost=2E
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>

I haven't checked which restrictions apply to msm8916 at this moment, but =
it might be worth adding 'depends on ARM || ARM64 || COMPILE_TEST'

Otherwise lgtm=2E


>
>---
>
>Changes since v1:
>1=2E Restrict MSM8976 to ARM64=2E
>---
> drivers/pinctrl/qcom/Kconfig | 39 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
>
>diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>index 2961b5eb8e10=2E=2E9dc2d803a586 100644
>--- a/drivers/pinctrl/qcom/Kconfig
>+++ b/drivers/pinctrl/qcom/Kconfig
>@@ -15,6 +15,7 @@ config PINCTRL_MSM
> config PINCTRL_APQ8064
> 	tristate "Qualcomm APQ8064 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -23,6 +24,7 @@ config PINCTRL_APQ8064
> config PINCTRL_APQ8084
> 	tristate "Qualcomm APQ8084 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -31,6 +33,7 @@ config PINCTRL_APQ8084
> config PINCTRL_IPQ4019
> 	tristate "Qualcomm IPQ4019 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -39,6 +42,7 @@ config PINCTRL_IPQ4019
> config PINCTRL_IPQ8064
> 	tristate "Qualcomm IPQ8064 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -47,6 +51,7 @@ config PINCTRL_IPQ8064
> config PINCTRL_IPQ8074
> 	tristate "Qualcomm Technologies, Inc=2E IPQ8074 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
>@@ -57,6 +62,7 @@ config PINCTRL_IPQ8074
> config PINCTRL_IPQ6018
> 	tristate "Qualcomm Technologies, Inc=2E IPQ6018 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
>@@ -67,6 +73,7 @@ config PINCTRL_IPQ6018
> config PINCTRL_MSM8226
> 	tristate "Qualcomm 8226 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -76,6 +83,7 @@ config PINCTRL_MSM8226
> config PINCTRL_MSM8660
> 	tristate "Qualcomm 8660 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -84,6 +92,7 @@ config PINCTRL_MSM8660
> config PINCTRL_MSM8960
> 	tristate "Qualcomm 8960 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -100,6 +109,7 @@ config PINCTRL_MDM9607
> config PINCTRL_MDM9615
> 	tristate "Qualcomm 9615 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -108,6 +118,7 @@ config PINCTRL_MDM9615
> config PINCTRL_MSM8X74
> 	tristate "Qualcomm 8x74 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -116,6 +127,7 @@ config PINCTRL_MSM8X74
> config PINCTRL_MSM8909
> 	tristate "Qualcomm 8909 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -132,6 +144,7 @@ config PINCTRL_MSM8916
> config PINCTRL_MSM8953
> 	tristate "Qualcomm 8953 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -142,6 +155,7 @@ config PINCTRL_MSM8953
> config PINCTRL_MSM8976
> 	tristate "Qualcomm 8976 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -152,6 +166,7 @@ config PINCTRL_MSM8976
> config PINCTRL_MSM8994
> 	tristate "Qualcomm 8994 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -161,6 +176,7 @@ config PINCTRL_MSM8994
> config PINCTRL_MSM8996
> 	tristate "Qualcomm MSM8996 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -169,6 +185,7 @@ config PINCTRL_MSM8996
> config PINCTRL_MSM8998
> 	tristate "Qualcomm MSM8998 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -177,6 +194,7 @@ config PINCTRL_MSM8998
> config PINCTRL_QCM2290
> 	tristate "Qualcomm QCM2290 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -185,6 +203,7 @@ config PINCTRL_QCM2290
> config PINCTRL_QCS404
> 	tristate "Qualcomm QCS404 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -232,6 +251,7 @@ config PINCTRL_QCOM_SSBI_PMIC
> config PINCTRL_SC7180
> 	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -241,6 +261,7 @@ config PINCTRL_SC7180
> config PINCTRL_SC7280
> 	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -250,6 +271,7 @@ config PINCTRL_SC7280
> config PINCTRL_SC7280_LPASS_LPI
> 	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller dri=
ver"
> 	depends on GPIOLIB
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_LPASS_LPI
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -259,6 +281,7 @@ config PINCTRL_SC7280_LPASS_LPI
> config PINCTRL_SC8180X
> 	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
> 	depends on (OF || ACPI)
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -268,6 +291,7 @@ config PINCTRL_SC8180X
> config PINCTRL_SC8280XP
> 	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -277,6 +301,7 @@ config PINCTRL_SC8280XP
> config PINCTRL_SDM660
> 	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -286,6 +311,7 @@ config PINCTRL_SDM660
> config PINCTRL_SDM845
> 	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> 	depends on (OF || ACPI)
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -295,6 +321,7 @@ config PINCTRL_SDM845
> config PINCTRL_SDX55
> 	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
> 	depends on OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -304,6 +331,7 @@ config PINCTRL_SDX55
> config PINCTRL_SM6115
> 	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver=
"
> 	depends on GPIOLIB && OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -313,6 +341,7 @@ config PINCTRL_SM6115
> config PINCTRL_SM6125
> 	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -322,6 +351,7 @@ config PINCTRL_SM6125
> config PINCTRL_SM6350
> 	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
> 	depends on GPIOLIB && OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -331,6 +361,7 @@ config PINCTRL_SM6350
> config PINCTRL_SM6375
> 	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
> 	depends on GPIOLIB && OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -340,6 +371,7 @@ config PINCTRL_SM6375
> config PINCTRL_SDX65
> 	tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
> 	depends on GPIOLIB && OF
>+	depends on ARM || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -349,6 +381,7 @@ config PINCTRL_SDX65
> config PINCTRL_SM8150
> 	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -358,6 +391,7 @@ config PINCTRL_SM8150
> config PINCTRL_SM8250
> 	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
> 	depends on OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -367,6 +401,7 @@ config PINCTRL_SM8250
> config PINCTRL_SM8250_LPASS_LPI
> 	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller dri=
ver"
> 	depends on GPIOLIB
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_LPASS_LPI
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -375,6 +410,7 @@ config PINCTRL_SM8250_LPASS_LPI
>=20
> config PINCTRL_SM8350
> 	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -384,6 +420,7 @@ config PINCTRL_SM8350
> config PINCTRL_SM8450
> 	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
> 	depends on GPIOLIB && OF
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_MSM
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -393,6 +430,7 @@ config PINCTRL_SM8450
> config PINCTRL_SM8450_LPASS_LPI
> 	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller dri=
ver"
> 	depends on GPIOLIB
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_LPASS_LPI
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>@@ -402,6 +440,7 @@ config PINCTRL_SM8450_LPASS_LPI
> config PINCTRL_SC8280XP_LPASS_LPI
> 	tristate "Qualcomm Technologies Inc SC8280XP LPASS LPI pin controller d=
river"
> 	depends on GPIOLIB
>+	depends on ARM64 || COMPILE_TEST
> 	depends on PINCTRL_LPASS_LPI
> 	help
> 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the

--=20
With best wishes
Dmitry
