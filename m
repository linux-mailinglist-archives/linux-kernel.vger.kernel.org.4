Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0A5F1B0A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJAJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJAJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:12:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4045115C1F5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:12:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f21so3243272lfm.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oSyrH4Rkjw4Y+1ia0HSofoVxm8e5lCFDiLKNr9go8iY=;
        b=nEoHsFl5PF+vQassPQ0CZZ8nPfASwLdX5hhVU3o5dE0x5xr6vN17s9TSf9UXsbgjXf
         Ktf238jsuhMFYOQipPlbFfoLXooAP06blrzizUfRY+NQXkfsS+ei8ETxDjkQmNTIY185
         HBZOGXLICzMhfbeWyTPNBxW88DLtgypeWnRbG3QzKzxXYNFgtai3xG+EGh1YkXd00k1S
         M58Id/jVsji2UUNo5LcqE4drEUDbzwD/L1mW4mv9xE/Af5ebN72azbmsHcnpmUh+k+AS
         4mDDid8pqIjBGZyuJJ2iG+8g1Csi+sHBN0lxpyUdrttHenNkDs1SEsT7chNVghMdCXn+
         7BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oSyrH4Rkjw4Y+1ia0HSofoVxm8e5lCFDiLKNr9go8iY=;
        b=i58wyY9FJQdh2UAZBwksXoJdtCUu/tkxvoOfAfVj+FAmP/Wx7+UnWWdzYkBkjPxEct
         dNQmIjYPFnMeFTbxvQzCyiyrxrkFYKjoPJy/7r8V2IcQoJhdqYzzkm27oqTLCWGD8UYG
         4w8geP+nLxoMDuhfIl+Nv/+N5eKrH3C2B55seVuoHBgMhw11Nl4a+VKfhCWVyW8z5Md8
         Uw1Jn22cP13wUb6wO+RmlO4Q9a1FHrQRw40F18tLluKVUZ/LKA+kVrN4wXKtPZGTOHNX
         IL81T2F7vCgHyGDKAiPPHRUgtsJPQr+msOzkszgAP2Tg0woFA2Wh/S6V6w3dMcPQr0WX
         eFvg==
X-Gm-Message-State: ACrzQf3+x2/fd0wZQoIgx5SaJBYXsxkf35RF7ACeOANztKPt+Kn5QyGV
        fMP7BKL4wGF0CR4Ih5ZRYITMiw==
X-Google-Smtp-Source: AMsMyM61AU/8E33pDjg9YTcQjelrf5aX3P4WhH+I01MKvZpd5hh7vELws5nLo2FdRFyaCBhsbKURfg==
X-Received: by 2002:a05:6512:22cf:b0:49e:860d:8f4e with SMTP id g15-20020a05651222cf00b0049e860d8f4emr4339556lfu.584.1664615575579;
        Sat, 01 Oct 2022 02:12:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b004a05c425cb7sm698108lfu.184.2022.10.01.02.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:12:55 -0700 (PDT)
Message-ID: <2887c49c-434a-cc1b-b078-1506416e583f@linaro.org>
Date:   Sat, 1 Oct 2022 11:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 02/19] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030656.29365-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
> SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |  2 ++
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 30 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 30 ++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1d86a33de528..398920c530b0 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -152,3 +152,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += qdu1000-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += qru1000-idp.dtb

List is ordered by name.


> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> new file mode 100644
> index 000000000000..0ecf9a7c41ec
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "qdu1000.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";

Undocumented compatibles. You need bindings for these.

> +	qcom,board-id = <0x22 0x0>;
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> new file mode 100644
> index 000000000000..ddb4ea17f7d2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "qru1000.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QRU1000 IDP";
> +	compatible = "qcom,qru1000-idp", "qcom,qru1000";

Same problem.

> +	qcom,board-id = <0x22 0x0>;

Undocumented compatible. Drop it.

Best regards,
Krzysztof

