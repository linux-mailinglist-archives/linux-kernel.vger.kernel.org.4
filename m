Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432935FFA55
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJONkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJONko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:40:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713364AD40
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:40:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r19so5330984qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCYluIy5X4DDBnJLEPtFcsvj/4A/lreQlJGJ296FwLQ=;
        b=N96XVvNzi2oixzSzvKU0F1f2fnWQboaK4/xph2X+sflvQnEKOPVN9hhBH09FxX1k44
         X532hJtk/IZcrLcSxiJztfQWEAy05NqZFOC9/uDM1kjRfTz/Ma5Hg22Vqe/xauWr6JFl
         +bHWEqybzklKw1Uz1XeDYaQ6Bv42BOAOigdzbZjJjYhsF7cJ8lxZl3rSGFkeDex+BInc
         M8sKpp6LkxpzWfAWiYtNg0KNfk5MMEsf9Iqe/MwaAt1iR9tetQtx9D8eQzduThL2+8+Z
         GaYhXuOAb+fr7crGn1mw5a2Uuz4qOp3Mx43rUuU6b1LoaLPbSWHiXFUjw/EYd+fpDlhD
         aNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCYluIy5X4DDBnJLEPtFcsvj/4A/lreQlJGJ296FwLQ=;
        b=ZEt28G3lDA0VonT7X6y+Qc8TcuY+0IUzab1RP+/YM5mV8cOrpzeSX8H5pMG6TWt+0Q
         2BFnyV0ahE/SEReLjmbz/Z2HbIri09twSjIR2VltyWoWz83MffS13zqtRL+lcCyKuO9K
         0qe038xO+StTHUSQ0S1cfcex17Qvia9GZmj+kqjFurbCnLEqYdCucj3Bv7Rd8gTIN14/
         7SnNX32f7REgPAMvvvp4snNvPa9S4FxWDYR13alVDpueRyR9aTkwMMMouX9E1Mo26Igv
         hGEP0rLGXVFYfaIZYc1/3UPvQlOAP6axLKjpnwWXl26nPrBGVGNGSn/5kPcLuA+kG1nK
         esGA==
X-Gm-Message-State: ACrzQf3WyEXWeO/C5Kqh0uCZf74hBITVFOas/EfdXpBjXSgjLe4z20qx
        y3v1rnVmC4HuxgrPzofddP4MQg==
X-Google-Smtp-Source: AMsMyM4foZZfRIHFP7dnGO/reqF/Zyacduw/lGzF6XF24hZsKphPpGgxzNtaBSBTgkKWL3pgK0m5Uw==
X-Received: by 2002:a05:622a:13cc:b0:39c:c0fb:95e8 with SMTP id p12-20020a05622a13cc00b0039cc0fb95e8mr1984495qtk.63.1665841241596;
        Sat, 15 Oct 2022 06:40:41 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:161:5720:79e9:9739? ([2601:42:0:3450:161:5720:79e9:9739])
        by smtp.gmail.com with ESMTPSA id b84-20020ae9eb57000000b006eea4b5abcesm4681943qkg.89.2022.10.15.06.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 06:40:40 -0700 (PDT)
Message-ID: <498ea0a0-24c2-c9c0-3a5d-150ba32b3c4c@linaro.org>
Date:   Sat, 15 Oct 2022 09:40:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014221025.7372-1-quic_molvera@quicinc.com>
 <20221014221025.7372-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221025.7372-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:10, Melody Olvera wrote:
> Add pin control driver for the TLMM block found in the QDU1000
> and QRU1000 SoC.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/pinctrl/qcom/Kconfig           |    9 +
>  drivers/pinctrl/qcom/Makefile          |    1 +
>  drivers/pinctrl/qcom/pinctrl-qdu1000.c | 1274 ++++++++++++++++++++++++
>  3 files changed, 1284 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdu1000.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 9dc2d803a586..4ab857dc2847 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -248,6 +248,15 @@ config PINCTRL_QCOM_SSBI_PMIC
>  	 which are using SSBI for communication with SoC. Example PMIC's
>  	 devices are pm8058 and pm8921.
>  
> +config PINCTRL_QDU1000
> +	tristate "Qualcomm Tehcnologies Inc QDU1000/QRU1000 pin controller driver"
> +	depends on GPIOLIB && OF

depends on ARM64 || COMPILE_TEST

> +	depends on PINCTRL_MSM
> +	help
> +	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc QDU1000 and QRU1000 platforms.
> +

(...)

> +	PINCTRL_PIN(138, "GPIO_138"),
> +	PINCTRL_PIN(139, "GPIO_139"),
> +	PINCTRL_PIN(140, "GPIO_140"),
> +	PINCTRL_PIN(141, "GPIO_141"),
> +	PINCTRL_PIN(142, "GPIO_142"),
> +	PINCTRL_PIN(143, "GPIO_143"),
> +	PINCTRL_PIN(144, "GPIO_144"),
> +	PINCTRL_PIN(145, "GPIO_145"),
> +	PINCTRL_PIN(146, "GPIO_146"),
> +	PINCTRL_PIN(147, "GPIO_147"),
> +	PINCTRL_PIN(148, "GPIO_148"),
> +	PINCTRL_PIN(149, "GPIO_149"),
> +	PINCTRL_PIN(150, "GPIO_150"),

Your bindings said you have GPIOs 0-149, not 0-150.

> +	PINCTRL_PIN(151, "SDC1_RCLK"),
> +	PINCTRL_PIN(152, "SDC1_CLK"),
> +	PINCTRL_PIN(153, "SDC1_CMD"),
> +	PINCTRL_PIN(154, "SDC1_DATA"),

This also does not match bindings.



Best regards,
Krzysztof

