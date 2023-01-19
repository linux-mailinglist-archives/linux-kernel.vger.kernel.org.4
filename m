Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591CF6732EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjASHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjASHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:49:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA3677BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:47:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d2so952292wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Xf6l0pkTfUQcg4s8+KxcfrawM+/+acLE7U/I+YkgqU=;
        b=HrbySDZwWkFSdLCzEXOLs+V+c7gkYZ6AExZCLr+NnmyUpp8N4Anc9Iifb0OmxEDgRK
         LliDSj2RcZiSm2fEnw+hf/QjrpXb5sZE15ijxtyEOU6g2E1zpMKl26nT23mbVE8mYo0k
         V17qUu5V196yRzkaQXIGyNi6UH+Qwoh9a5Vf3Lt5/V/JvaBh0iktV4lqC0dCeWB/2E0A
         L8fFj9HhfFQSKZc7UnU0zps0mYU27k60DWTN2oy5VyYKa9lMpdxO4fWjsqQPqfhRpDTI
         YbXzZGOxAdPjLIQJrN1ETEYU9M9jO21Ddp+adUdG7WO9uB1q47KLSlv9dmrSvXJ7W6Za
         5Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xf6l0pkTfUQcg4s8+KxcfrawM+/+acLE7U/I+YkgqU=;
        b=jMhH0pI27asR+Jn5G4XpcqeNLsn9U35oThMBR13FxmGVSvM/HUdyBhZzysj71yzNKv
         f3Ki+wH+pfQwHfZBVrmKLmPWgXrPpViWTpnCkH0CrxUMj0JmXTH19vI+oNHkq0nmDaTp
         06INonI1QORlYMFrJWEqh8YKqe6U/fJXjy92GRtEcW/wdqod1lVA8pIPGJqmVDGHdd/R
         8dr/VBXPwF4hMXepfqaDSqCBFudkwdU59Ek93p9rz7LAqYr00QypTqnVhHVvxdbMob00
         gmy4WlFXE+mbrbjkvuom9k43w51Ydll51NCPSQqKGIkmBKIPYNXr7BrMY0GowmrPHHQ+
         8RhA==
X-Gm-Message-State: AFqh2krzbtZbnMvldTeZMchnh63g0W4LiD+EsRUJo2yDUtnWRqiJLbM6
        95XK9VY9PHRw/2XGuhg4SMfLCQ==
X-Google-Smtp-Source: AMrXdXuS8zdsDRinJUZd6MTyyHb3fpLxBdnccwy/4L69izCoZWdPOKRFFyFqnBBwK+HpW9Gq3M3pog==
X-Received: by 2002:a5d:5251:0:b0:27e:7f5:6634 with SMTP id k17-20020a5d5251000000b0027e07f56634mr8289121wrc.60.1674114426892;
        Wed, 18 Jan 2023 23:47:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q18-20020adfdfd2000000b002bdc129c8f6sm21608096wrn.43.2023.01.18.23.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:47:06 -0800 (PST)
Message-ID: <f85cdf27-7ea0-14a8-10b0-7a9ac137a040@linaro.org>
Date:   Thu, 19 Jan 2023 08:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-3-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119035136.21603-3-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 04:51, Brad Larson wrote:
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> 
> ---
> 
> Changes since v6:
> - Add reset-names and resets properties
> - Add if/then on property amd,pensando-elba-sd4hc to set reg property
>   values for minItems and maxItems
> 
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3..f7dd6f990f96 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -16,12 +16,14 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    interrupts:
>      maxItems: 1
> @@ -111,12 +113,36 @@ properties:
>      minimum: 0
>      maximum: 0x7f
>  
> +  reset-names:
> +    items:
> +      - const: hw
> +
> +  resets:
> +    description:
> +      optional. phandle to the system reset controller with line index

Drop "optional"
Drop "phandle to the" and rephrase it to describe physical reset line.
Don't describe here DT syntax (phandle) but the hardware. What is
expected to be here?

> +      for mmc hw reset line if exists.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
>  
> +if:

Move the allO from the top here and put it under it. Saves indentation soon.

> +  properties:
> +    compatible:
> +      const: amd,pensando-elba-sd4hc
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +else:
> +  properties:
> +    reg:
> +      minItems: 1
> +      maxItems: 2

No, why do you suddenly allow two items on all variants? This was not
described in your commit msg at all, so I expect here maxItems: 1.

Also, unless your reset is applicable to all variants, resets: false and
reset-names: false.

> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

