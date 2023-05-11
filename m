Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7436FEEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbjEKJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbjEKJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:26:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D78D06D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:26:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965cc5170bdso1228777466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683797181; x=1686389181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1IslJ7/3eQpHk0/ZONImP6ek9rvCI7d+h3hwQhusW0=;
        b=A3Lr/820FEisUc53N/6tIVzuEVp+khhimTcSLGsHq/i4fzqx7tp7I5DIC8bO/XwKAj
         DeCiey9CQk6CwmWdxVDc0ZLz0mFUSFVrXlg5gDkLclK8DPZxwGUd8Yk6O8WeNnw0ZD8n
         Y/BfVlIyj84qT8f0TXBAstume3ASfUzN6q65DvvZ74VUOE188xiWnitj/+IhI6/eUNgH
         i4cs5MlkAoXkApk/gkivGx4lkUZfcNoETbCpJEgZmTQtRt1GRkblYskEkCSle1KNUfwd
         kYSffouJuyUP8LZi2uM6C0wNwsQ+oJ+XUE/aeW0qabBZyLyg45XDKfxconB4I5sjwxsd
         TJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797181; x=1686389181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1IslJ7/3eQpHk0/ZONImP6ek9rvCI7d+h3hwQhusW0=;
        b=QHcQ6/tF819ArqsgXocWAPiCcdkz+6Djr0LDnuG9GypLf27mnBVKhphpULIE8Ep5kR
         EUGrSk2jy06xMNN+rYbYEfiRtS1dWozVJU6wJ7JPTGKKQ+LxZAM4kQKoY2cf/+FsTm9l
         W+ICrnm5BfPiGoFF7r+2kF7je2lzlMbMhUGte0QdHCU2a46bqybqa5mpn6xV8hwiQbH/
         Y0CF0utz51rlD/cWwIKwUozWvn3FwLDD93AXtyUFrcI1X2iInfsSSBmrrga183gvaVQK
         k+U6dWlQsfGPdOI04J5xbae1FtM9UuIdG3cHFb8ADazYJ7CU0XMul+0g/Iph9keJvacl
         UiWQ==
X-Gm-Message-State: AC+VfDzLEUPSYBUK4Puv3AK9WkD4w7cDPYXEf7NhNmxphTK673aykqdp
        4zBLzhcVH4H/RvHdOBTLHAp9Iw==
X-Google-Smtp-Source: ACHHUZ74t7K+CeQz4z8BQyobf4t7TRb93OAiK2Zks93fMy5n6HFkZY/H0v/9xh4mpxhbpUlCfqdB2A==
X-Received: by 2002:a17:907:78c:b0:953:43a1:1988 with SMTP id xd12-20020a170907078c00b0095343a11988mr17157850ejb.46.1683797181377;
        Thu, 11 May 2023 02:26:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7d047000000b004fbdfbb5acesm2818308edo.89.2023.05.11.02.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:26:20 -0700 (PDT)
Message-ID: <9cf5965a-8290-dfff-9f92-07ed2df66650@linaro.org>
Date:   Thu, 11 May 2023 11:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: cdns,usb3: Add clock and reset
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230510132816.108820-1-minda.chen@starfivetech.com>
 <20230510132816.108820-2-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510132816.108820-2-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 15:28, Minda Chen wrote:
> To support generic clock and reset init in Cadence USBSS
> controller, add clock and reset dts configuration.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../devicetree/bindings/usb/cdns,usb3.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> index cae46c4982ad..623c6b34dee3 100644
> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> @@ -42,6 +42,18 @@ properties:
>        - const: otg
>        - const: wakeup
>  
> +  clocks:
> +    minItems: 1
> +    maxItems: 8
> +    description:
> +      USB controller clocks.

You need to list the items. And why is it variable? Your clock choice in
the example is poor, I doubt it is real.

> +
> +  resets:
> +    minItems: 1
> +    maxItems: 8
> +    description:
> +      USB controller generic resets.

Here as well.

You had one clock last time, thus the review was - drop the names. Now
you changed it to 8 clocks... I don't understand.

Best regards,
Krzysztof

