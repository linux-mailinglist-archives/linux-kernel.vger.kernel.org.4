Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5C62C631
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiKPRTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiKPRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:19:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54426383
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:19:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a29so30589526lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCpMqcRT8DeY5MXJCLiKIz5Im5PIOy+nnF0pses3NRo=;
        b=gPP/YC7RcqXib2XtCBKhb344QqRcr2tCekCF3H6g0DbHMXM4BhF+AYi7kbOqwzduc1
         3Nci/kOMGv5CP1o5EcR/uksu0p+DQ1m2pB/gPAPIJ41aKwBUyDOCxBpVgybBC/qaRQga
         T3RREKedJitX+tZgbKXiRYFLTT+UhTcWyWU/SmhiHj57cdAf7pxa5HNvQ4I2SYeFTVPe
         hwd9U5GXn3E2GS3Eakoa0GH8ZR3mS3C+DQkxZAzSXLcPeG/Pdzdn2nGBPyD2iT60PZDX
         NIB8D8lpfsyt/RpG+EaZvK2Nv0GLHktVnskYmOD64WMfMkltDs0AtnMchbWTlVb+L9sT
         fNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCpMqcRT8DeY5MXJCLiKIz5Im5PIOy+nnF0pses3NRo=;
        b=U/zVTLOGiMWmFVAWcCkt5hsgjngg4RA13GBpWyD0ufL6k/RQLkadTL2OIBZzzQrpmn
         CcmWLS1DPxyy/NOdbj8u0XmXG+5rRsin2P/m7ueWBhrVe5fFxlRO69MX8W1pwe1YN67K
         5GG3cQ9MG4Uf40jQ/zoMOxyn04zEtQS/xJXEtHyKwZc7/tXNA6gMwWaGj71RwkvXCWJf
         7PK1kCR+JnzDyL6DfX0j0es9jJEkm2qfBDdFXu0lPfy0kKRqOPThCgBzXkooJmcL6AUV
         4SPqZTRbJ15aJbP/Bn1jBkUBqjw4nczTJ2WzuZFlZ7V37xdnRvFAooEJq23bEbkPEuRq
         BPmQ==
X-Gm-Message-State: ANoB5plIf7CEj57fJ4lNA3X988Ikwk3cW/J/pdfSvAPmRptJDo3iA5LX
        MmB2+vixIVPm8yz+3MZxUwq06Q==
X-Google-Smtp-Source: AA0mqf61LBMQcDDOdERra618Gul2RXMcG5LraXEgHjg7sKKHhpXJP2KJpVLUcPqjo1eEivEm8tnoHw==
X-Received: by 2002:ac2:5093:0:b0:4b1:753b:e66f with SMTP id f19-20020ac25093000000b004b1753be66fmr8351806lfm.276.1668619160736;
        Wed, 16 Nov 2022 09:19:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 11-20020ac24d4b000000b004a62ff61b3dsm2676326lfp.252.2022.11.16.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:19:20 -0800 (PST)
Message-ID: <891e51f0-af46-6150-ba4e-807f00cc8e63@linaro.org>
Date:   Wed, 16 Nov 2022 18:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sdm450: Add device tree for
 Motorola Moto G6
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Braha <julianbraha@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-3-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116145616.17884-3-luca@z3ntu.xyz>
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

On 16/11/2022 15:56, Luca Weiss wrote:
> From: Julian Braha <julianbraha@gmail.com>
> 
> Add device tree for the Motorola Moto G6 (ali) smartphone. This device
> is based on Snapdragon 450 (sdm450) SoC which is a variant of MSM8953.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Missing SoB.

Please run scripts/checkpatch.pl and fix reported warnings.

> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sdm450-motorola-ali.dts     | 256 ++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d7669a7cee9f..a0b537414593 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -115,6 +115,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> new file mode 100644
> index 000000000000..62874306fc24
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/ {
> +	model = "Motorola Moto G6";
> +	compatible = "motorola,ali", "qcom,sdm450";
> +	chassis-type = "handset";
> +	qcom,msm-id = <338 0>;
> +	qcom,board-id = <0x41 0xb1a0>,
> +			<0x42 0xb1a0>,
> +			<0x43 0xc100>,
> +			<0x42 0xb1b0>,
> +			<0x43 0xc200>,
> +			<0x44 0xc200>,
> +			<0x42 0xb200>,
> +			<0x43 0xb200>;

Both properties are not allowed, unless exception list is extended.

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


Best regards,
Krzysztof

