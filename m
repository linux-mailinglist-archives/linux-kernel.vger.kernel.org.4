Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698CC64C9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiLNNHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbiLNNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:07:29 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B76FCE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:07:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so10295737lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLC+YouSgfFcE5WwUiX2kvWrs63dDVeOKOUOSmX/lJ0=;
        b=PqQyNIyDvvg4sJh+ghS5L03oZblM4Gd54YokXRXIAL2WOzveCqy2aF4r0Xx0coyo//
         8ss9DER02X1NjsSNa4CgCNUZlW7e59f935674ek0uF28HQatDNs1FjVDG4NQij6ZMYxF
         /b/uiJotKCmr42Msd4cZzYwzlqZCvJDyYNG1ZddVLiwYMTughFHEIy92f6GGHpVQIROg
         HgLNNVwQciUYJXIVMM6/TU/YmsCmvlXonfOHS6d3FS0XueNWB1w6iwiJqWDIIzSGLxiI
         S3XWxbh7N/MGy0Rs+K3LgIlww8m+V65o2kaKbWZ0nxqVIrijTZC/b9j2Uqt9h1/058fx
         8h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLC+YouSgfFcE5WwUiX2kvWrs63dDVeOKOUOSmX/lJ0=;
        b=WlP+xQ3PMl845FWk/YMA25T81fDUbfFxg+tcTTmloTccGLDqXX8YwhXc1u/q9Z+pQm
         4CCA8fyGvMITrShiaQFBeiG1IjAvv87OJ0hhxOgp1gqpKHV8pGHHn4Zx/3LNJOaqEndb
         1OsRdSMzRaWsdlcjIoNk8pqqaqahJf0Z4V3WIdBYHszCrc/PSEtwm7xv/XOTAyu3J5j7
         2XrRJ3dr+D6PiRZnwpPi0SOPPpoXzjDwWKsd+F5ot8+3VYQ4rIL9g6BP24WbpcJ/3Vcr
         /baqAVw0pftDT4J6P9KZwvp5/AJEn46q4LTzAHRxPSPwhmVClclfr9qRQr0+GQa5/bDS
         1tuQ==
X-Gm-Message-State: ANoB5plufQLfZxsSx4RKjxtxwfwTkGh3921z026ZcV4uOcbtaaEQNFOL
        pY1vFyOif1PiyMuygvft0JSJ4A==
X-Google-Smtp-Source: AA0mqf6+LLK2zNpOQDfUltUxPH71nzu3Q55+wa1+RbAm0/99ktVB1MB703JTeFyIDA0CfKtPOmdEpw==
X-Received: by 2002:a05:6512:169b:b0:4b4:9124:8aa6 with SMTP id bu27-20020a056512169b00b004b491248aa6mr8978045lfb.27.1671023248454;
        Wed, 14 Dec 2022 05:07:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d20-20020a056512369400b004b55c1b5c66sm795733lfs.157.2022.12.14.05.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 05:07:28 -0800 (PST)
Message-ID: <b0aff55f-978f-48f6-4a86-f6b126ecc649@linaro.org>
Date:   Wed, 14 Dec 2022 14:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 16/17] dt-bindings: soc: socionext: Add UniPhier DWC3
 USB glue layer
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-17-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-17-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> DWC3 USB glue layer implemented in UniPhier SoCs.
> 
> This USB glue layer works as a sideband logic for the host controller,
> including core reset, vbus control, PHYs, and some signals to the
> controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> new file mode 100644
> index 000000000000..bd0def7236b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

