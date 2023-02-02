Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B768881C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjBBUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjBBUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:13:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F8252A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:13:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q10so2781815wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Mc/xaxMClUd+iZwnvlYiGDh8sCfZ7txe4S/VfjiJo0=;
        b=CTKK5zVBQIiM2ZNG2b/WsQHNX87h8kXn9n63OWxK60sT5zG5tGIkW9aW92RBjbKx4H
         mWDYcjHQVICjqLd9O/v98hP2HYXUqNGeZ+q97vJd+AcT4WSFxHGnNtc1MDwOkcAk3p3Z
         j+1AjeerHEbsxXCCM1O702xmUggORoC5iv8V/aDzHci7BcgVJd7bhxHgszapTwh8ek5K
         q/6Lmxr2kzVnxBbWq7/htu2SMXsk5S0fhOhjk9aWgOOYMPQe3fJV5q3HoSNdpr9TLrtm
         QVz4SJMaxSFcta8NBXZhAw2OrrRw2b1x2VOMyTGVl6rOvQlkHtBj2Ti23T7SlUAzwu+n
         Ooag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mc/xaxMClUd+iZwnvlYiGDh8sCfZ7txe4S/VfjiJo0=;
        b=mtWuyFN2P2UH/ZDHsHUa+G43H7s20Q1fj7Zcg4i6vQuoVDiDoeU9OD4ALpQOqkqUro
         trMeZWPOAB5hQn48cUOeItApcU8LUyIV7cN5VQnImTIVQOJTEierEowWEChTrrwkRaIC
         mtnymGBd8gTUB7lpKKgKTgz23YoAUXosKEtLRYiT1enmZdhzfbeZSQuW2EZ+bJmnK832
         WbvYjrjm269uwfB5eXrmL2AISsLbJd6i7D3pwTKs0KVn9XTmMOBFkwMwkc02P0U88SeN
         zbWCt/HKwhHYsu6ovxIgebNeNRw5gDkM0pCSIFupoE+im/xsGBFoczSqzs2AyHc0jz5J
         ZlIQ==
X-Gm-Message-State: AO0yUKXUyZjGdk9WFxb/yy39yHcDjXXVRaKLXgw02xK8/UFEZFvSHfTR
        M+ZfMrrbFbUxyZcdKHYEKkSkLg==
X-Google-Smtp-Source: AK7set9sUrbys5hAtykvo71RuvHH/h3Rtv/uhcagXWwgXfysolM3UaVSrAzU8ypG64zqJDE71tk0SA==
X-Received: by 2002:adf:f452:0:b0:2bf:ddf6:5063 with SMTP id f18-20020adff452000000b002bfddf65063mr6736633wrp.35.1675368803734;
        Thu, 02 Feb 2023 12:13:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d5108000000b0024cb961b6aesm278729wrt.104.2023.02.02.12.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:13:23 -0800 (PST)
Message-ID: <28cf0c1f-ee5f-79e4-609a-2cdd24db9f1c@linaro.org>
Date:   Thu, 2 Feb 2023 21:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202101032.26737-1-maarten.zanders@mind.be>
 <20230202101032.26737-2-maarten.zanders@mind.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202101032.26737-2-maarten.zanders@mind.be>
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

On 02/02/2023 11:10, Maarten Zanders wrote:
> Add a binding to configure the internal charge pump for lp55xx.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---
> 
> Notes:
>     v1: implement as bool to disable charge pump
>     v2: rewrite to use string configuration, supporting all modes
>     v3: simplification by replacing string option by u8 constant,
>         removing previous Reviewed-by tags as it's a complete
>         rewrite of the patch.
>     v4: added notes
> 
>  .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
>  include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/leds/leds-lp55xx.h
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> index ae607911f1db..22e63d89d770 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> @@ -66,6 +66,12 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  ti,charge-pump-mode:
> +    description:
> +      Set the operating mode of the internal charge pump as defined in
> +      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
> +    $ref: /schemas/types.yaml#/definitions/uint8

This should be then uint32

default: 3
(and drop last sentence about default)

> +
>  patternProperties:
>    '^multi-led@[0-8]$':
>      type: object
> @@ -152,6 +158,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/leds/leds-lp55xx.h>
>  
>      i2c {
>          #address-cells = <1>;
> @@ -164,6 +171,7 @@ examples:
>              reg = <0x32>;
>              clock-mode = /bits/ 8 <2>;
>              pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
> +            ti,charge-pump-mode = /bits/ 8 <LP55XX_CP_BYPASS>;
>  
>              led@0 {
>                  reg = <0>;
> diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
> new file mode 100644
> index 000000000000..8f59c1c12dee
> --- /dev/null
> +++ b/include/dt-bindings/leds/leds-lp55xx.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

> +#ifndef _DT_BINDINGS_LEDS_LP55XX_H
> +#define _DT_BINDINGS_LEDS_LP55XX_H
> +
> +#define LP55XX_CP_OFF		0
> +#define LP55XX_CP_BYPASS	1
> +#define LP55XX_CP_BOOST		2
> +#define LP55XX_CP_AUTO		3
> +
> +#endif /* _DT_BINDINGS_LEDS_LP55XX_H */

Best regards,
Krzysztof

