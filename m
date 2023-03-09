Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156AF6B1FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCIJP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCIJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:15:21 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51906B971
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:15:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so4234315eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678353316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5q8KQOzCQWOJTqdyqK3y1vIAkUs5tdLsy8yXKdX+F0=;
        b=eC7LBTnawutc5RwLnhfn1YG+rYbLKnbNiN6fETTvSSKIKTS/O5JKglmmvBAgljM08A
         VyGMlZ1xNFFZJBjOxZ+G0gCB317iz7438XRa6b5UmZ9+8q8DMb9bJTGL/UJbi7/HUhM/
         eBRCR3YjBJwmtUoqt/xNlgTFd3JiaKB/3z1Icqlzio0HpxNlEabmVXYTiuPci+saCbpG
         ri5ZXW+fh8WSJpt/TZsUwg59NnAf64hG+CPZ381dy1cBVTeyaTLaSKont+6nkNspJhUm
         RLal67hr1/wYty1IZ5mNocVAR/zoyKocQqvBX8WXdfl8MSmEWxkO2s+VO/3dEXme81hC
         JCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678353316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5q8KQOzCQWOJTqdyqK3y1vIAkUs5tdLsy8yXKdX+F0=;
        b=Lo4eVw+DUEHQaqQ9NsxbQJVlhtIRCVDljPSWZAcLhv5X+ObzocUe9+gHwmIHBKP1K7
         F4LEb82qPi1aT7dSXvc++3nkSygCJmH0/ibwDeSCSApiin8xQ72ooE7qjCaIkpGDwpbm
         L1ay7zayLiE5sUA+EBkF9mXNDgBoINxBjCHJ9Fa018hLaIs1Gh8DznYsw8CymHj5N3Jb
         JXjaBvSAsqkbuNbRX6EQlkAjYTRbMmOReRW7XT+LHfDj1NnzOW5WgSh+XNRKrh9xA/op
         EnAPuLjq00y5Rgp4a8qRPr1FYiw/TzqYFd5BzMIIKl7YJ7BG9gUYKF6Juasx+S23tI2e
         zf5w==
X-Gm-Message-State: AO0yUKVMUkjNOxT3upSLX+FH2DHK5tTgc1yLiT9o2cAPIz8Am1zNceH6
        Kl88W5Z+Hevu5J5+aCeS2RDPBQ==
X-Google-Smtp-Source: AK7set8xwtxCT7nFJQpgOv90l8MyYk/13E3cgWr+yoj7OFzq7eSsX4qzkbHVVhC0/n/vMJqEyTKK7A==
X-Received: by 2002:a17:906:304a:b0:8b1:4051:6d2c with SMTP id d10-20020a170906304a00b008b140516d2cmr19889796ejd.19.1678353316452;
        Thu, 09 Mar 2023 01:15:16 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id uo17-20020a170907cc1100b008b17ed98d05sm8531971ejc.120.2023.03.09.01.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:15:15 -0800 (PST)
Message-ID: <1b8bce82-a59d-f655-1277-3cc1110b818f@linaro.org>
Date:   Thu, 9 Mar 2023 10:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] dt-bindings: power: pd-samsung: Add Exynos850 support
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308230931.27261-1-semen.protsenko@linaro.org>
 <20230308230931.27261-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308230931.27261-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 00:09, Sam Protsenko wrote:
> Document the compatible string for Exynos850 power domains controller.
> Also add power domain indices which can be used in "samsung,pd-index"

There is no such property...

> property to specify a particular power domain in the device tree.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../devicetree/bindings/power/pd-samsung.yaml   |  1 +
>  MAINTAINERS                                     |  1 +
>  .../dt-bindings/power/samsung,exynos850-power.h | 17 +++++++++++++++++
>  3 files changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/power/samsung,exynos850-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> index 9c2c51133457..a353a705292c 100644
> --- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
> +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> @@ -21,6 +21,7 @@ properties:
>      enum:
>        - samsung,exynos4210-pd
>        - samsung,exynos5433-pd
> +      - samsung,exynos850-pd
>  
>    reg:
>      maxItems: 1
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f305..53e11e48639c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2720,6 +2720,7 @@ F:	drivers/pwm/pwm-samsung.c
>  F:	drivers/soc/samsung/
>  F:	drivers/tty/serial/samsung*
>  F:	include/clocksource/samsung_pwm.h
> +F:	include/dt-bindings/power/samsung,*
>  F:	include/linux/platform_data/*s3c*
>  F:	include/linux/serial_s3c.h
>  F:	include/linux/soc/samsung/
> diff --git a/include/dt-bindings/power/samsung,exynos850-power.h b/include/dt-bindings/power/samsung,exynos850-power.h
> new file mode 100644
> index 000000000000..a8d877b5515a
> --- /dev/null
> +++ b/include/dt-bindings/power/samsung,exynos850-power.h

Filename matching compatible, so samsung,exynos850-pd.h... but I
actually wonder why do we need it. How power domains are organized in
Exynos850?

Best regards,
Krzysztof

