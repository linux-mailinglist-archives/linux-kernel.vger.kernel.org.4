Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595105E9BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiIZIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiIZIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:16:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CD237E1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:16:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s14so9025384wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=NznGcr0ykL64h72sno6OQWCYhPWC8fy80LMUKAAPWZo=;
        b=MiRKVs3Rtii2kIXuPy0754f9kyzs9haf++zm/W+a0zFaZuuBNSQWSre2J6yR3Kz+vO
         TwZUOk5osY2kglEjzs6Lon4LN+4DCQaX3us5RUIGwDmey2a4IlUQop5B9ao2uQKlEvLb
         KwnlmYUX6QaQ/KqG+awbEbh9Mo6FcvLGD67ppj8Qhaxbit85ln/WgjBMRt4ZPtpnDHwy
         iOYjzBXj9LHJzBu2ZUqO5DBcdieGMvR4VrIuy1vIVITxE8b+HoE18P7gZBRb4Hi2ikwm
         5iMym5retT86FNWmVdJSgGSA/vSd1D65Luh/8CB/6dT5vVKthnnPyR+jW+7qXNJAhvjn
         hV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=NznGcr0ykL64h72sno6OQWCYhPWC8fy80LMUKAAPWZo=;
        b=DIHW8Jn0KeMDce61NWUgki6mt5HrinvexVp1qapDd7lcl11e8uqIAOrbXgxMMXHB5C
         OsQOqMcgbHFEFsuGDUu3cRzo+mtD9+TrHxIePLtso7YN3fi18SRm3H/F7mOuzJxPEj4d
         DCzhHchCXNFBzXLXg3J/46gZqJbs6W7k2SnfP/wTL/yAo6MRBue37IUKzsoJxnpRet4J
         w+60UO7ZD0rC4bdGmLYVSOSBQCUGiki1h3kGYrDkK25/Wt0ds5MbQUpzrEsFF/qgRQ7A
         qE0GyGWkpssF+8jRuEVSMVGVRxJgvjXO924hHxIrTSNISWDys8YIVvZXeQBnjpDSSmqq
         rHUQ==
X-Gm-Message-State: ACrzQf3r3V4bYy0hZlbG+TrpVoIEp72MMwHJys+uo6Bhz+KGMNtGNT1M
        gQBMAeO/a0Opia2d/ekl3DL57A==
X-Google-Smtp-Source: AMsMyM6xtnia+VPZLtQatSc+KU54sbBg6zSPBECyIr7d4KrKwhDK5128gSjJ7QsR8YB6BuMpFAy/BA==
X-Received: by 2002:adf:e38a:0:b0:22c:8b0b:df3 with SMTP id e10-20020adfe38a000000b0022c8b0b0df3mr8603530wrm.352.1664180179856;
        Mon, 26 Sep 2022 01:16:19 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003a5f4fccd4asm10772463wmb.35.2022.09.26.01.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:16:19 -0700 (PDT)
Message-ID: <c944beec-44d8-0399-e568-7dd1c75193d5@linaro.org>
Date:   Mon, 26 Sep 2022 10:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] ARM: qcom_defconfig: enable rest of ARMv7 SoCs
 pinctrl drivers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 13:21, Krzysztof Kozlowski wrote:
> Enable rest of ARMv7 SoCs pin controller drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Do not enable MSM8976 (Stephan)
> ---
>   arch/arm/configs/qcom_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 7d8b6884fd00..b41716c1ec64 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -131,14 +131,19 @@ CONFIG_PINCTRL_APQ8064=y
>   CONFIG_PINCTRL_APQ8084=y
>   CONFIG_PINCTRL_IPQ4019=y
>   CONFIG_PINCTRL_IPQ8064=y
> +CONFIG_PINCTRL_MSM8226=y
>   CONFIG_PINCTRL_MSM8660=y
>   CONFIG_PINCTRL_MSM8960=y
> +CONFIG_PINCTRL_MDM9607=y
>   CONFIG_PINCTRL_MDM9615=y
>   CONFIG_PINCTRL_MSM8X74=y
> +CONFIG_PINCTRL_MSM8909=y
> +CONFIG_PINCTRL_MSM8916=y
>   CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>   CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
>   CONFIG_GPIOLIB=y
>   CONFIG_PINCTRL_SDX55=y
> +CONFIG_PINCTRL_SDX65=y
>   CONFIG_GPIO_SYSFS=y
>   CONFIG_POWER_RESET=y
>   CONFIG_POWER_RESET_MSM=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
