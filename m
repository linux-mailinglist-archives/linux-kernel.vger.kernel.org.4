Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA148656837
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiL0IK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiL0IKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:10:21 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E965A6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:10:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y25so18650623lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCYHbxHWnWYY7tZ4H0UhQ5PUVEgDjPe+BXvjxGYqJRE=;
        b=I2NrB8W1olYs8aDi8D6AgwGHmQOx6Q6w80is4wEh108GPccO6rvIdd1cdztaHdw6p9
         LICStazFg0X2HEnszNDnv6fDOsoyA/SPj/golzNIyitKASbSi3LNTOvfLA4Xfkuab3bI
         MFsXCnZVvRUutwum3+gkpyfBoRIuTDKdS84g6XIx5cDtyZ+YF+ruxFTouBJbr9zgPQqe
         K+CW2OBjjLP+3sqOGbaTqtOxVnZl4z7rNDWxoL1jWJ3MYDyZaUhVj3zDDDa+nNL4rbE6
         iHtLGdu8iv0il0VXgPuh+eeYoaOwOFHjh9T9c/mFAzUDRvkFhsZJlgmewXOnV4IRAlVk
         6k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCYHbxHWnWYY7tZ4H0UhQ5PUVEgDjPe+BXvjxGYqJRE=;
        b=WBu9n409ppe3EnXkQJPoIjyz8WXdj4cHXk28iMrz6pQxGO5HaG9PIlHHTt0YQ0Sakf
         LgVfPOvrIr/tg0XMLNChZ2DgRJqG/8vVx55XOwOJDmOV5wd3+lSXHHuk+gWMe8WFd2fy
         8CQeD10CVwcMWtOKYU224R3Sr/X/A3qB+5aJHj9sEMPd3GrG2pa07TbtkTlDPNRAr46Z
         qoVveTOJ1+WAVslmKp2CEVLY1OjFyAxOQ5Aza9M4BRfWM3wj9viqL2+Pskv4j2E+Yr2E
         uh2KoUASJnsxRKH383n/7bak3MGKgFL0jMnT+mAj83FtNVeKKYog09Nzq7LPNI5yc9p7
         AVLQ==
X-Gm-Message-State: AFqh2kojHgMBluRCYi2IC3QO1/xfL5X4T5vb0mOSHdS1MjzOjmTXivvG
        sQGUPHHUgHohw9lZdIxnQaiTww==
X-Google-Smtp-Source: AMrXdXt2DIN5Gj2xtHFHBMjJp8E4i8/4isztDv37CttrVPWaAwDqhKA0w9BU/g1FQYRzYxCkMsMnVQ==
X-Received: by 2002:a05:6512:1116:b0:4a4:68b7:dee8 with SMTP id l22-20020a056512111600b004a468b7dee8mr8042309lfg.68.1672128618052;
        Tue, 27 Dec 2022 00:10:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m1-20020a197101000000b004b094730074sm2140275lfc.267.2022.12.27.00.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 00:10:17 -0800 (PST)
Message-ID: <7f6a2072-f26b-e2f0-9c07-d2ea43c8c4bc@linaro.org>
Date:   Tue, 27 Dec 2022 09:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [net PATCH 2/2] dt-bindings: net: marvell,orion-mdio: Fix
 examples
Content-Language: en-US
To:     =?UTF-8?Q?Micha=c5=82_Grzelak?= <mig@semihalf.com>,
        devicetree@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        chris.packham@alliedtelesis.co.nz, netdev@vger.kernel.org,
        upstream@semihalf.com, linux-kernel@vger.kernel.org
References: <20221227010523.59328-1-mig@semihalf.com>
 <20221227010523.59328-3-mig@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221227010523.59328-3-mig@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 02:05, Michał Grzelak wrote:
> As stated in marvell-orion-mdio.txt deleted in 'commit 0781434af811f
> ("dt-bindings: net: orion-mdio: Convert to JSON schema")' if

Drop '' quotes.

BTW, read the original binding to find the answer for your first patch.


> 'interrupts' property is present, width of 'reg' should be 0x84.
> Otherwise, width of 'reg' should be 0x4. Fix 'examples:' and extend it
> by second example from marvell-orion-mdio.txt.

The original binding did not say that, unless you mean giving different
examples? Examples are not a binding.

> 
> Signed-off-by: Michał Grzelak <mig@semihalf.com>
> ---
>  .../devicetree/bindings/net/marvell,orion-mdio.yaml  | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> index 2b2b3f8709fc..d260794e92c5 100644
> --- a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> @@ -47,9 +47,10 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    // MDIO binding with interrupt
>      mdio@d0072004 {
>        compatible = "marvell,orion-mdio";
> -      reg = <0xd0072004 0x4>;
> +      reg = <0xd0072004 0x84>;
>        #address-cells = <1>;
>        #size-cells = <0>;
>        interrupts = <30>;
> @@ -62,3 +63,12 @@ examples:
>          reg = <1>;
>        };
>      };
> +
> +  - |
> +    // MDIO binding without interrupt
> +    mdio@d0072004 {
> +      compatible = "marvell,orion-mdio";
> +      reg = <0xd0072004 0x4>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };

Why? The same compatible, the same nodes. No differences. Missing pieces
is not a big difference justifying new example.

Best regards,
Krzysztof

