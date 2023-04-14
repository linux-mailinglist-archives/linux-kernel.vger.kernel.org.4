Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E36E28E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDNRBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDNRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:01:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF09B446
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:01:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id xi5so47220210ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681491700; x=1684083700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCbJAh+Z0aRKbTKNkNpTrH1WXy4mYvnZUCA8nbxWox8=;
        b=yKoeG23ri75vVft4xi17uGfIyuX8d/w+X/Qo03BGo9MdxEXkpILyAxwTEHB+WPPhCX
         oZFsdPz6WpboQhqKhZrV4DeoHHYeQavnUuneCodkbkTXUNmzSmDTQvW3DbjRKLzb/M+h
         eVedx7arbZOXA12EJ7vgrZNwQpM5wkPbPnbyfDgfD9feSS1gQ/YwoaTEqErnUkhECMSw
         +1/ACgoJz7wAEx9uQyKzAcVtCFjNkgNuiyYipH8uKyAd3/E3HExxfKmVogJ9G5dOj1tg
         uM47VSdyLB6tmklhyhvvwxUjTc8Ie3i0ZCCZ4bzJyegyLEU5Gy6S6PhETG2Itk2XQzE9
         y/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491700; x=1684083700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCbJAh+Z0aRKbTKNkNpTrH1WXy4mYvnZUCA8nbxWox8=;
        b=TLnglUUDNiNk4YQik7exE0OxoOh+vsekyje7UPsR0i1tyMKUgvU4IHr29XEHmX8IZl
         0y0OJXMWWYX66LPquuh7YyeJt1+79mh6kilrGIeiZYBemwueMw7u44YwR+C119jfPtZ5
         woh2mgj52EpgbfaXonJbCAcbMu6BphD+3/Y2jzkNSdkaiiMAnCbqmiQFenaxTl1so8A1
         k7BLtkF5jowZCe2eAV2CZDzm22QGupYQYmq4ITqRD0UhTAas8eAd9FtqvkXdvLivOG5g
         DdW9PnBU5x7jjU+nLjWYWeJRd6ESL3XCVCIkoxiU+aHQTc48ckBdylnJ2uq/ewNhwKY8
         5nrQ==
X-Gm-Message-State: AAQBX9dD1OEH2eZYXEO/Q0KZbhO4ZVF0NmvMMD0ekDF6DSKvf93xgzFO
        gSq/VPdzsRzXR5k8EPavOYN4Ag==
X-Google-Smtp-Source: AKy350YiivcwJTYAsTfFGBz+OXvwfnukjw7cREDIL00YkEeOmHmKknAOL0ZHz2mzQiyD7pydh2C/3w==
X-Received: by 2002:a17:907:8d09:b0:94e:48ac:9a51 with SMTP id tc9-20020a1709078d0900b0094e48ac9a51mr4464472ejc.4.1681491699870;
        Fri, 14 Apr 2023 10:01:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709064a1200b0094e92b50076sm2652252eju.133.2023.04.14.10.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 10:01:39 -0700 (PDT)
Message-ID: <00b9429b-494a-24aa-9770-90dba6e2b0ea@linaro.org>
Date:   Fri, 14 Apr 2023 19:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/9] dt-bindings: ASoC: Add it68051
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-5-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414140203.707729-5-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 16:01, Paweł Anikiel wrote:
> Add binding for it68051 device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/ite,it68051.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ite,it68051.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ite,it68051.yaml b/Documentation/devicetree/bindings/sound/ite,it68051.yaml
> new file mode 100644
> index 000000000000..341c171b8a8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ite,it68051.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ite,it68051.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: it68051 audio codec
> +
> +maintainers:
> +  - Paweł Anikiel <pan@semihalf.com>
> +
> +properties:
> +  compatible:
> +    const: ite,it68051
> +

No ref to common DAI properties? No sound-dai-cells? No resources?
Bindings are supposed to be complete.


> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    it68051: audio-codec {

Drop label, you do not use it here.

> +        compatible = "ite,it68051";
> +    };

Best regards,
Krzysztof

