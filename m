Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B3694066
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBMJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBMJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:10:29 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C41206F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:10:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so11372280wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFbbit3gfVSlgEGux20SeiHF54l/GxrKyyVrimdp8r8=;
        b=nBndPv6WkmSBKfAb2M7U9jz/A31aNjmjBMJtFrtQZcQPzPPxvHn/SBniepw7wVATDd
         w1SYEKYE4RjeolvbpnvYEWuEYQA00XwBwHTkWh1y+Y7iA9H4dKfTn8F0bN0lO6Rk8rdp
         iR4DvWMvJzX+1b2/E8M5AICc4t8Gjh8PCdsIiOreAIoSNQtGVCCvcfWrLvnYKApZiTe1
         ErgMEZ4Bng07Xh6F97nA8awqDqa6n1qZWoDNPBcqbZsHnYNoC9u2UrJBKicIaIjD8iY1
         /7igOGeDzKs0Kv+W/9mLfS2iwCacgEWZBvgDczbSD1+Gacf5ZhtNp5LSDJL88Z+kFPlo
         OqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFbbit3gfVSlgEGux20SeiHF54l/GxrKyyVrimdp8r8=;
        b=N95Mc4E/fMSDDeeV/HgGxak0PXvtOUbqzYxso5pvYCwCtqn/XS1x+ZjZHfIMZInLED
         Z/XQFiK4ysW5XFVzM+zejXAWnQ6aux+TshIf0NQg0lVXdF/wT97uREhWmfLoVvIH2TRY
         bTGgoa1pdXy16SJXCsDCHZVZmNGemVJRMcmot8wjhK8F5mqOzoIm/GNwrr5vifBzCMZY
         U2mpSpxEcQUmd3z4GNPwNyiW0zaROH/WJYOvZKBRUWhn4FaR3kMr3Fs6Fk1TNj9rGDCe
         Sq/PDV133AzoIhdnEny6DqHa9XJ6ItYafrWJ9g7xrx9sR9+9NAk15RMGiron1/oX5bxv
         ln4Q==
X-Gm-Message-State: AO0yUKU3PquUSrvgsCnXg7BBIN1OVkazKJVa+CXbXv5wqVpDYJA+1QY9
        4S4bW7hIfBdpBMnT0VuPpCTCXg==
X-Google-Smtp-Source: AK7set/XS7U8EouqlbaDbYShhig4AocctLD3MXJSNH/OT5ab67nu06wZbc7r15szbOVfLyun8GrDAg==
X-Received: by 2002:a05:6000:15ce:b0:2c5:5e34:6171 with SMTP id y14-20020a05600015ce00b002c55e346171mr885696wry.25.1676279426398;
        Mon, 13 Feb 2023 01:10:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b002c54241b4fesm8917783wri.80.2023.02.13.01.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:10:26 -0800 (PST)
Message-ID: <2d76ec86-6580-28b0-0f80-a5c497f8cef7@linaro.org>
Date:   Mon, 13 Feb 2023 10:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213045432.32614-1-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213045432.32614-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 05:54, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs maximum three reset controls.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.yaml  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> Changes since v1:
> - Restrict resets property changes with compatible strings
> - Fix maxItems from two to three
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 7dc2a2e8f598..25dd5ffaa517 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -45,6 +45,9 @@ properties:
>                - marvell,armada-8k-ahci
>                - marvell,berlin2-ahci
>                - marvell,berlin2q-ahci
> +              - socionext,uniphier-pro4-ahci
> +              - socionext,uniphier-pxs2-ahci
> +              - socionext,uniphier-pxs3-ahci
>            - const: generic-ahci
>        - enum:

Top level is saying reset=1, so did you test your bindings?

>            - cavium,octeon-7130-ahci
> @@ -76,6 +79,20 @@ properties:
>    resets:
>      maxItems: 1
>  
> +if:
Keep it in allOf like in example-schema. Will save you one re-indent
pretty soon...


> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - socionext,uniphier-pro4-ahci
> +          - socionext,uniphier-pxs2-ahci
> +          - socionext,uniphier-pxs3-ahci
> +then:
> +  properties:
> +    resets:
> +      minItems: 1
> +      maxItems: 3

And entire allOf goes to the place like in example-schema.
> +
>  patternProperties:
>    "^sata-port@[0-9a-f]+$":
>      $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port

Best regards,
Krzysztof

