Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB18688461
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjBBQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBBQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:26:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738D93F0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:26:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so2207432wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMNOmY6zTM5brzrRGCMNvI9vzHRlQKOKoeE7qPa7iD8=;
        b=ZOI3U7RU0D6RTWYR3ZRVbQjuMdTlSHJI5FydEez1qW18qZb3FciIqzEAEt2V1BcR3U
         iFe97l+8cIHXSlPrNkmA3OQgE6dFNR6oNqbQ9Y5QVzCmodrectKx9ikKfjMs4A+df0ms
         gvaEGuCIxY9jxQACwPjpzaItgg1ZUjHvQSkhJ2iQpkEO5f64u+ywP+CBxh3UG0qeEmgy
         CPxlsPFZ4359LtlTgh0nVkHZj1oqpb3bpEIbSWgKGwF8GuMwgIvzLANyorVBUXBcdgAx
         BAc0KJGdw1dZDPzaYBCYiz+WXAgAAoHCLW5J79N69Swp8C3sKfOaB1CPRC10ZxUrJWjy
         cREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMNOmY6zTM5brzrRGCMNvI9vzHRlQKOKoeE7qPa7iD8=;
        b=m8x6vnq9UhLyiGvCwdTAwfFPAJkObHJCssxaLPKm/GsAY9aqpOzdYZ/l5RFg53omzO
         pgCDyIzHiNDjNzjQo9ZxPnZmPqfDS2eCBSyeW7aDAvwBR016z2/MK8YZXrU4XY9REeWr
         OEDu9T+MbugJ4jg1BlWFXKQwbsKK1OPC90X5+i8MXgCz4reuMxhZjSxgFCFj0iJZbEAn
         lxDV9BrdrGHHDjBZl/RQ0CkPSTgQLvIQ+BYtuJGkECOnxL16FiF9jlK+W6d082xmh2Nr
         lju8lU6YPQTop+OjUbjIVHd2IM5J3Kfn+OLOmZfQGSgNQFYTI8Yz9Om7Cdh4R4BgNaXK
         Hwgw==
X-Gm-Message-State: AO0yUKVgd8uv3KsBn/WxxTFEwjdtQ5+tKTxosQVkl92Nt8FLtoBisVVP
        IHxfUM0GWm6EzCYPBqBK/0nk9A==
X-Google-Smtp-Source: AK7set83QC7Ek+NNqNoxPyvkKFy54osdQsehBsHgOrTnOJY45WtGMo11I7cqihn789HTn6wBHJWuQQ==
X-Received: by 2002:a5d:6d46:0:b0:2bf:bac7:30d4 with SMTP id k6-20020a5d6d46000000b002bfbac730d4mr6145918wri.53.1675355187298;
        Thu, 02 Feb 2023 08:26:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ay22-20020a5d6f16000000b002c3bec91679sm2436574wrb.110.2023.02.02.08.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:26:26 -0800 (PST)
Message-ID: <7d94a260-e3d5-0c4a-1a59-af369619e7c7@linaro.org>
Date:   Thu, 2 Feb 2023 17:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        broonie@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
 <20230202161750.21210-4-kyarlagadda@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202161750.21210-4-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 17:17, Krishna Yarlagadda wrote:
> Add "nvidia,wait-polling" flag to enable TCG TIS hardware flow control.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> index 2c3cada75339..25150d55603e 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> @@ -28,5 +28,11 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 255
> +properties:
> +  nvidia,wait-polling:
> +    description:
> +      Enable TPM wait polling feature for QSPI as specified in TCG PC Client
> +      Specific TPM Interface Specification (TIS).
> +    $ref: /schemas/types.yaml#/definitions/flag

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

