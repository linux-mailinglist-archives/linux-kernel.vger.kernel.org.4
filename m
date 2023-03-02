Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD266A7CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCBInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:43:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C7313DD6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:43:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eg37so64375960edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677746622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D16qOH+5JX55lVqRDvhnkvR9CnuIAuMrNQM3n0jKjwA=;
        b=qKWQifh5tNPVRlAaK4BQkVh40cnszyxAjxxKoLRHVvm+0Ae1KotlfDl+yqopGv1+L0
         V1HruG+pUjDE3EgmGBmApLvHDJMCwTmZiBGK3IxKQQzeStU9n9zUK7viK3PKeH52rV6J
         dhggj4s0WR8eYeUg+ynljFalbguGS7qsSUF+MGMxElKy3h3XwcJOaC34Gm3aaJEmEFvC
         sBLPCb3ZPzkkBZ9ksc9Ye5BF254AIqPQrGDv1EnTi1V/q9iv0XWFGggBLAViKt+uJMKj
         6H+iwIWnUe1vo+IKF5QlixD0MkbwM5w9cqcp7Z12a9+hciIMPXJlZlV7O7NiSL4eOo+p
         SpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677746622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D16qOH+5JX55lVqRDvhnkvR9CnuIAuMrNQM3n0jKjwA=;
        b=p22SNxOfPYrwCJsfXEyw15Sbhgs4qYTdZ6P0sIgEUoEqpklZV8DqE+engZQKV/qafm
         BEpl1BD7kqSeBxmhBI+rV+Z/AlD7Ldy3bJZxVOxyCbFn8Qr9fTW4BAlceX6jv0IXdcNd
         4Cf0Qo8eA558Y6EtmwE7aBIEANA2us4zYeIJrli7L2+S5FPHvfS181ivPEZcSdCkSfqy
         s4im1OL4z/25CsQQBx8JaodsRyU6wRVvxxmuUZlClWKgJqYV4wjKK+LlwKByEGks6ANR
         KgOkzBQRogMfylttKXOcRC00oHZMoPQXUFPUXat7NzmNNwldcQxthbJpJmYhP2Tw75qU
         BMjw==
X-Gm-Message-State: AO0yUKXZlwT04GRuCKr2Tlnxvy01bP4qCeJk4g/2/F0l1m+6QwPJUGSc
        EjDWgB6YYEsPQPPOCXLInYTFPg==
X-Google-Smtp-Source: AK7set9UWzoNSi1A56L4FXfN6HVzXl1v0lvcV6YMQBEt9+9T7DCJw4Znw7nzLcfbOMKeSD0xujdzOA==
X-Received: by 2002:a17:906:3788:b0:88c:617f:bcf8 with SMTP id n8-20020a170906378800b0088c617fbcf8mr12381710ejc.61.1677746622017;
        Thu, 02 Mar 2023 00:43:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709063bd600b008dd6bf721c2sm6845511ejf.106.2023.03.02.00.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 00:43:41 -0800 (PST)
Message-ID: <28c95e21-c7cc-f004-9925-967123b8a63a@linaro.org>
Date:   Thu, 2 Mar 2023 09:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/7] dt-bindings: phy: cadence-torrent: Add bindings to
 support dual input reference clock configurations
Content-Language: en-US
To:     Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mparab@cadence.com, rogerq@kernel.org
References: <20230301131125.6084-1-sjakhade@cadence.com>
 <20230301131125.6084-4-sjakhade@cadence.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301131125.6084-4-sjakhade@cadence.com>
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

On 01/03/2023 14:11, Swapnil Jakhade wrote:
> Torrent(SD0801) PHY supports one external and one internal reference
> clocks. Update bindings to support dual reference clock multilink

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings. Drop also "to
support", just describe what you add/fix/change. Your subject is way too
long.


> configurations.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 35 ++++++++++++++-----
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 2ad1faadda2a..711097e167bc 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -32,17 +32,34 @@ properties:
>      const: 1
>  
>    clocks:
> -    minItems: 1
> -    maxItems: 2
> -    description:
> -      PHY reference clock for 1 item. Must contain an entry in clock-names.
> -      Optional Parent to enable output reference clock.
> +    anyOf:

oneOf (just like your clock-names)

> +      - items:
> +          - description: PHY input reference clock. Must contain an entry in clock-names.

Drop "Must contain an entry in clock-names." everywhere.

> +      - items:
> +          - description: PHY input reference clock. Must contain an entry in clock-names.
> +          - description: Optional Parent to enable output reference clock.
> +      - items:
> +          - description: PHY input reference clock. Must contain an entry in clock-names.
> +          - description: Second optional input reference clock. Must contain an entry in clock-names.

Your commit msg says this is "internal reference", so call it like this,
not "first" and "second"

> +      - items:
> +          - description: PHY input reference clock. Must contain an entry in clock-names.
> +          - description: Second optional input reference clock. Must contain an entry in clock-names.
> +          - description: Optional Parent to enable output reference clock.
>  
>    clock-names:
> -    minItems: 1
> -    items:
> -      - const: refclk
> -      - const: phy_en_refclk
> +    oneOf:
> +      - items:
> +          - const: refclk
> +      - items:
> +          - const: refclk
> +          - const: phy_en_refclk
> +      - items:
> +          - const: refclk
> +          - const: refclk1

ref_internal_clk?

> +      - items:
> +          - const: refclk
> +          - const: refclk1
> +          - const: phy_en_refclk
>  
>    assigned-clocks:
>      maxItems: 3

Best regards,
Krzysztof

