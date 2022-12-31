Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA665A627
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 19:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiLaS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 13:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 13:58:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0C6414
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 10:58:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p36so36188466lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+f6MEHPvraJbIhg/Qh3EFX2QlA+pVzk6PS1RzpejfpU=;
        b=mm3rbNvErKbm878y6ZLKO1BRezWJCBTu40Aw7nN6SC3nL6oJPiv5NeSsIlrJzNCIbp
         ZRDOe0BQ1Ch84+IMryAV9ZLzjpNG/UAaaXQFnv0oTvj9CJBq+UueBnEXN1N85nBnud4L
         5q9pflE6Cz7vI7A2XGBRgpVVGCPOhb39Sdcxgi1WpSlaeZS9cuMSnEzgkG244Ny6x+/7
         KLIA1Jw11GUCtITafrih993ehavRbxdQ50Ya4g7ei/mE2gBmWJpuEJqs/vApnsY1HeGR
         Uwt4c1ihY6b3SERs5S64i21VDRMGTIUZ3UeC9pRcfUj93ZA5WWHbglMljiKP0BRVnRtE
         MZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+f6MEHPvraJbIhg/Qh3EFX2QlA+pVzk6PS1RzpejfpU=;
        b=TdB+BEcpMpg1o3mQOa5Mo8C+fiU6m9JU+veMpdR3gw28cPBaPIDVoSUTlOAknS3Abh
         hmoaRh1Ag8zETV4VfW8f9pNmM/Z9hyU0ox86BdW0+O5m8gSpShUULtcG4j17eUckdti8
         U6+TzsLYOahxVRgdWDkXCoG+ixzr9Kt469yl+F2dn7AvxpZrGq0+O5aBPiHn/cVoGETQ
         dKMoj9ui4L1Z4mPTn8NVkb2YOZbAyOtVJHb6hV5wPQxwqj2Fp2/epiFVIMSqJ6LtSOPB
         cr26IiwBMRfSxZwpV5MeliwFvqaRViaXvCZ1G03aikls9+wE96sp9xL29gnUPHu+kuXd
         fX5g==
X-Gm-Message-State: AFqh2krQIloHOAS7rgO3e43XE7p4YueRCGODmNdTkz8dlu/5gmpRthwH
        gQg20J74nPVdAlBz0iP8xKMrOg==
X-Google-Smtp-Source: AMrXdXu3hVDP0pdMCRE0xDMOyOhqgWtFfHo8ZaBoTE2AP8DSG03gyX4aawLsVQD04bpROMi9ee4vzw==
X-Received: by 2002:a05:6512:3d9e:b0:4b5:5efe:966e with SMTP id k30-20020a0565123d9e00b004b55efe966emr13561654lfv.15.1672513121712;
        Sat, 31 Dec 2022 10:58:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q14-20020a056512210e00b004a2c447598fsm3910225lfr.159.2022.12.31.10.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 10:58:41 -0800 (PST)
Message-ID: <92dbd096-b02f-b5e5-6275-a37a3d582685@linaro.org>
Date:   Sat, 31 Dec 2022 19:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Allwinner D1 PPU
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20221231160402.16157-1-samuel@sholland.org>
 <20221231160402.16157-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231160402.16157-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 17:04, Samuel Holland wrote:
> The Allwinner D1 family of SoCs contain a "PPU" power domain controller
> separate from the PRCM. It can power down the video engine and DSP, and
> it contains special logic for hardware-assisted CPU idle. Other recent
> Allwinner SoCs (e.g. TV303) have a PPU with a different set of domains.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../power/allwinner,sun20i-d1-ppu.yaml        | 54 +++++++++++++++++++
>  .../power/allwinner,sun20i-d1-ppu.h           | 10 ++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
>  create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
> 
> diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> new file mode 100644
> index 000000000000..64c9a9f398a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/allwinner,sun20i-d1-ppu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner SoCs "PPU" power domain controller

Drop quotes over "PPU" - it's not some nickname, alias, but acronym.
Explain the acronym in description.


> +
> +maintainers:
> +  - Samuel Holland <samuel@sholland.org>
> +
> +description:
> +  D1 and related SoCs contain a power domain controller for the CPUs, GPU, and
> +  video-related hardware.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-ppu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: Bus Clock
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sun20i-d1-r-ccu.h>
> +    #include <dt-bindings/reset/sun20i-d1-r-ccu.h>
> +
> +    ppu: power-controller@7001000 {
> +            compatible = "allwinner,sun20i-d1-ppu";

Use 4 spaces for example indentation.

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

