Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2D61A0B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKDTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKDTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:17:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD84876A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:17:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z30so3641893qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3IQuXma0cjf2XddXrRe8ESj+gGbbWZ0MQ+tC4zj4Es=;
        b=Z6EyrOpVxPv9TAsb7BTYoQW7CNbsYZWdk+Fr1gKr9GL9OvufRSAxWryOMvUOQ7SX7H
         GtjWn2iEEYB/9OO7+GbV2KI+j9dr6fGl/LffGFO/OFSPUgrbddtqucNZFbMn0uEC6tv2
         QRUPVgKG+CW32ru3iITtYHiidMSGjJTYdmBRYuyVpYLcZSfU8Rcml78x1G+OtOE7x1em
         z4FHvqycOK7FYeX57qY0mGWTlYPvACqIJVyXMEm1r51qXNYSiCrH4HHrx4BvUE4PmrYM
         bTSPZr1nivB1LpPo6nAzDwr552lxLB83wcZNcIn9/A8OSdl6nrGTA4V1JcM6j5Du1SGg
         nHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3IQuXma0cjf2XddXrRe8ESj+gGbbWZ0MQ+tC4zj4Es=;
        b=Z7oPeKnl3b8LF+lhGPFaR9WI+DqRfEerIwXfEoZSPS87uB1hE3C1ZCc864e2oLDiPy
         tSrCtjMMJ++KCiWtuTtJXW+O2xP8BVvFBaJCZTx2mnYr7U1hMqw+yNnL6AbAULF7BT9Q
         mMQTIlmeSHXq491eHduzYmLpXt40JWDwIacuAX4XrmCS6Cwsxbk0KmEO8C2aNmbb7jYP
         BKKfMW3bPvFgVdFMNzZjNDTjv2IAoEuEiJbg2UXitimmZ+qZ+cX3IbfhdMCKxsyLB7tu
         OY91TRvHO7NFQVwgVzhHPMPtRDGNRm94CuLz8Wz0tHgU+ViGqR879QleQFua6z4+TKcU
         kKEg==
X-Gm-Message-State: ACrzQf1O98VW+69607f4VABZxlCT3WcKRcGmw+pchsP5yDJ8mdgyftlD
        iDKQxZwMRFG3ypU0iqrf0ulSZg==
X-Google-Smtp-Source: AMsMyM6xbn9mzynOw8KybXlugzplo7nLIe11G4YCPG/JyHuRwL/LdTZuRgcA3eFMTFoUtLAu6VKDKg==
X-Received: by 2002:a37:f502:0:b0:6f8:c3b2:51b9 with SMTP id l2-20020a37f502000000b006f8c3b251b9mr26954851qkk.616.1667589426961;
        Fri, 04 Nov 2022 12:17:06 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id y12-20020a37f60c000000b006cfaee39ccesm3366383qkj.114.2022.11.04.12.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 12:17:06 -0700 (PDT)
Message-ID: <1880c054-08d9-3901-f44e-290d1fd27ed4@linaro.org>
Date:   Fri, 4 Nov 2022 15:17:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 8/8] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-9-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221030094258.486428-9-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2022 05:42, Iskren Chernev wrote:
> Add initial support for OnePlus Nord N100, based on SM4250. Currently
> working:
> - boots
> - usb
> - built-in flash storage (UFS)
> - SD card reader
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
>  2 files changed, 242 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0558d3389e5..eb2a58b8af5f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -142,6 +142,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> new file mode 100644
> index 000000000000..a3f1c7c41fd7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4250.dtsi"
> +
> +/ {
> +	model = "OnePlus Nord N100";
> +	compatible = "oneplus,billie2", "qcom,sm4250";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
> +	qcom,board-id = <0x1000b 0x00>;

These are currently not allowed for SM4250. If there are really needed,
please justify it and update
Documentation/devicetree/bindings/arm/qcom.yaml. Then also update
include/dt-bindings/arm/qcom,ids.h and socinfo driver.


Best regards,
Krzysztof

