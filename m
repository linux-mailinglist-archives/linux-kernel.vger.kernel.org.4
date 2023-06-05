Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECAD7223A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjFEKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFEKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:35:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECFA12D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:34:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso6937628a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685961298; x=1688553298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFq5oGkqVQ3sub4JCKqcWdAZJhLFL2YkYQs99Cty04o=;
        b=eZ9V+gIQetiODGpzOE/DVwsx5nXiBXaMfrU86OFR0YpPaivq3MAh5SkrE6C2GjhgNL
         /lOeKCSVH0Y0VbG+T3zyaTPzGd9pdjSwBTyuBw20kIgFSTBrFcfBilo6V84kwfKCQe/1
         7lr//Ay0N4QwKwdIN2CKcrC3hbQwaJeyn9tiT0EjWbTcp5nbIMYC5NFp+eLSI9ynjNAd
         6k1sfoZj/qzgtcny0Jq3tjOoQHe/mPmd+YAee1GrUpYui2TM0f7NAoaKO7DkdDsJlTjt
         sTzmBj9ZcxGJUdDNVJPNiGnyqBKTizHPc8iChG1HbXPpsblGrzb8hIqmOSeFAM2lvSVQ
         Tp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685961298; x=1688553298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFq5oGkqVQ3sub4JCKqcWdAZJhLFL2YkYQs99Cty04o=;
        b=aDTzL0xOBxZI1zjhwHrvsk7SAoWpGv5k9tDLrVEnEO5bZ7kU291BzG1RuhIhoOKuuB
         80c8RQ9F6iwwZ6mQWg4UzW5JblRPiQMhGyzLMlrMf87V8i0d7EEcHF81J+L6GnR1IsPG
         eulaWIMdYiQeufyWy339te5UbSdrWd5lDnkO1xsx2SYd4/KU5YTzuBRtIvQr5K3ayN0+
         ASvxs3xkLWWOMpk5v3s7S5uuF13AoihIMyZB3DShTE1gGFcpxNNWri6QPYOQplA3q0lA
         /NTAPf/mvtbYzXAPT+5ZX3x5mA8/TWLHin24lnri5lxXp8MyfYpf7LTxjgJ+rrBivpDe
         mw3A==
X-Gm-Message-State: AC+VfDz09CaSjTmc0vuxMNIsGqGzTa9YPSuNf7R7CmsTS4RB8JnHTw9q
        qFlseTlBFkv5bzyGY1HQ+KBY1Q==
X-Google-Smtp-Source: ACHHUZ5+XtjfkEfVdH+SHr9LWWN02kLyYG3gz7kWxBFVXGEK6U0G8WHiam5TJMMbVl0NoG1DZ9XjbQ==
X-Received: by 2002:a05:6402:6d4:b0:514:9528:6e6f with SMTP id n20-20020a05640206d400b0051495286e6fmr8643302edy.7.1685961297889;
        Mon, 05 Jun 2023 03:34:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s18-20020a056402165200b00510b5051f95sm3680533edx.90.2023.06.05.03.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:34:57 -0700 (PDT)
Message-ID: <6818f4b0-4222-c3bb-c55f-bc0d26d7a681@linaro.org>
Date:   Mon, 5 Jun 2023 12:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Content-Language: en-US
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 08:05, Cong Yang wrote:
> Add an ilitek touch screen chip ili9882t.
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> index 05e6f2df604c..f0e7ffdce605 100644
> --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> @@ -15,11 +15,14 @@ description:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: elan,ekth6915
> +    enum:
> +      - elan,ekth6915
> +      - ilitek,ili9882t
>  
>    reg:
> -    const: 0x10
> +    enum:
> +      - 0x10
> +      - 0x41
>  
>    interrupts:
>      maxItems: 1
> @@ -29,11 +32,13 @@ properties:
>  
>    vcc33-supply:
>      description: The 3.3V supply to the touchscreen.
> +                 If using ili9882t then this supply will not be needed.

What does it mean "will not be needed"? Describe the hardware, not your
drivers.

I don't think you tested your DTS. Submit DTS users, because I do not
believe you are testing your patches. You already got such comment and I
don't see much of improvements here.

>  
>    vccio-supply:
>      description:
>        The IO supply to the touchscreen. Need not be specified if this is the
>        same as the 3.3V supply.
> +      If using ili9882t, the IO supply is required.

Don't repeat constraints in free form text.
>  
>  required:
>    - compatible
> @@ -41,6 +46,18 @@ required:
>    - interrupts
>    - vcc33-supply
>  
> +if:

Keep it in allOf. Will save you one indentation later.

> +  properties:
> +    compatible:
> +      contains:
> +        const: ilitek,ili9882t
> +then:
> +  required:
> +    - compatible
> +    - reg
> +    - interrupts

Don't duplicate.

> +    - vccio-supply


Best regards,
Krzysztof

