Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13296786A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjAWTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjAWTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:43:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B212069
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:42:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so11390085wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bbZbxQ5uVGlh9D/fI2txo5pcGdK/f5Akir30Ty5LuY=;
        b=cot2k2ijWyoodQXHtjiy3DvScVigolXDLEZseLa1A1QxOqy47+6bCCKB8Z8wCZeCnO
         0Y1tw2NrkysgPZU9PAmF+dokp+3lHN+dIdAUc0tcSWX+BjzfdjwYPkKseJsUq2eqO01z
         pbuSa8zGLgGD5F8dDRyW69pFWHktXUYJ6skl2mJn9F+El5uIJFAbjM3eNyhljqVyXC1/
         QNm/AfJAcdz1nQTjs8/3u73KbxNom1nxcp+jn9ZuMEphdFG855jrse7UWXtE/1kTLpv1
         7cKT9CBuJNsMbPVhFK5ASAZtu/lFkJ1XgxoSD7yBtpHh8KRq5Fq8fX25u5qtYmSYQq+H
         XGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bbZbxQ5uVGlh9D/fI2txo5pcGdK/f5Akir30Ty5LuY=;
        b=Rp46K6s9SSHi73n5yV/6zxOjuh/u13WtXDAaYFWk2MCRlDwJl52xOMvo4/RyE9TYI5
         0W5hXncLroqNdTlz6vilC5oYtFGFiNOOOs2dleZd5ABibxr36RVP1PxmRwQ91nKHUtac
         iada/JTs7gg+b87gm4z67Pxxktvi6DFZ2yJt09FAmHxF26AIwk2qwf2M/p4uwA/gK0oE
         gBFrIj3WibPho/oCPlXssOf43VkOEe3buXtrDY3TLTKsBNIXWbNWEKLxfoA2OxHUozy5
         /l5OXzVPE+FNMEXInB6zAbfhuWrdNqpCVEpQq3gIuoA/NsHehVO8AjLZouQIDTcMAvQN
         942Q==
X-Gm-Message-State: AFqh2kqrtEqNCiq6cjA87/S04xWcirgDF7bnHdvcZNdHZvYe7BmqGTzH
        4LzVXZXBY4OoKn44HWiRdhZ7Pg==
X-Google-Smtp-Source: AMrXdXtSLS0mpG09KaQBLwMq3nRzoSYY4U9CZEHM+7j07D15D+Rg4N4o7ThmjqgFezh5GNalUbA/hg==
X-Received: by 2002:a05:600c:3b1b:b0:3da:11d7:dba3 with SMTP id m27-20020a05600c3b1b00b003da11d7dba3mr24548270wms.5.1674502976439;
        Mon, 23 Jan 2023 11:42:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c40-20020a05600c4a2800b003db16770bc5sm11037540wmp.6.2023.01.23.11.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:42:56 -0800 (PST)
Message-ID: <d05161ed-eb30-2d4d-e9bc-4b40e8ae09e7@linaro.org>
Date:   Mon, 23 Jan 2023 20:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-5-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123192735.21136-5-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:27, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support for SD6 controller support.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..26ef2804aa9e17c583adaa906338ec7af8c4990b 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>  
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> @@ -18,7 +18,9 @@ properties:
>        - enum:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +      - enum:
> +          - cdns,sd4hc
> +          - cdns,sd6hc
>  
>    reg:
>      maxItems: 1
> @@ -111,6 +113,34 @@ properties:
>      minimum: 0
>      maximum: 0x7f
>  
> +  cdns,iocell-input-delay:
> +    description: Delay in ps across the input IO cells

Use proper unit suffix -ps, so ref wont' be needed.

This comment was also ignored.

> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,iocell-output-delay:
> +    description: Delay in ps across the output IO cells

Ditto

> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,delay-element:
> +    description: Delay element in ps used for calculating phy timings

Ditto

> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  cdns,read-dqs-cmd-delay:
> +    description: Command delay used in HS200 tuning

What are the units?

> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes (everywhere)

> +
> +  cdns,tune-val-start:
> +    description: Staring value of data delay used in HS200 tuning

Same problem - missing units.

> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +


I don't get why the feedback has to be repeated. It's a bit a waste of
time, isn't it?

Best regards,
Krzysztof

