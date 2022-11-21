Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD35631C91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKUJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKUJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:14:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCEB71198
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:14:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g7so17892754lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzJ1Wp+0Y1BV5FI5ALPYO3ykaQyEtvnk1yBBPpwmu2k=;
        b=MY2ZMsvAOIUWpv95uOKNW6RZvGBkO6P4O7pJxf+QWNCVKvCPJ145yjyVAUbuYmBn8b
         oU6gBohmHFUdG07x6n2J8CrhD3SITPX3MUfjvL1iRod6zLQaAWW11QrKVH7kGg8ilLeE
         robaC3v13YDu3jUEzxAE6pknR+aTYym1e+0TrGG2elX+74u5NdetMKcLoMA2DvwASg/E
         SwRPz32w7pUuJHc0j9AOCQzPtfqHBumQr/deLliEIaZsoXOsx8Gri2TwUr9rWEE5PmCS
         /2GwO1QHxOPtqvg+YZgHNYCgIyCEJkHUvbjF47T/CEfc6LWF1NbvdMYm3ONK/m2nX/zI
         usjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzJ1Wp+0Y1BV5FI5ALPYO3ykaQyEtvnk1yBBPpwmu2k=;
        b=y83qe3UyjIBK59QFY/B9wYgg28KWlYfmrFWtCykNLFpg3G9+AfkkyNNFRfjWOZDx6j
         rbvtwTsaDTstsNcah+jiMMuClwveB2oNqi9K6YkLWcgdVKARsreu4aHKlBSgRaT4tvYU
         krwes/k02+HJts4cTVWP6dA36pxIqUEzdHqJZR6lnm9Gdj2iCKDisT8ImF71b1X259UW
         YGrJOHefC09R06Qh7h/MZhHNmYn/UWiU8XyjnFQOMM2Np3+8MLPwF60zIKh5Y9tBmA81
         LoFQ+SqjkWFuH3L90k8szcTdFs6QrF/Sly6c4BddhqO8iNhoSIV1gxpzYCLIHcrEo5R3
         ggbQ==
X-Gm-Message-State: ANoB5plhjmAZTv9BB/Z6VStmkJHhE2AZ/Y71thqzzVJcO6QhsgEvKLbt
        3M93x7185LgYNc8J4KRaqqcpoA==
X-Google-Smtp-Source: AA0mqf66WvuXOvvEgmjWbFNbdtend+6s+HRKZkNnVe5YBS4XvYhP3v3obghSZgzSgUT+GR7d0mkgag==
X-Received: by 2002:ac2:5e23:0:b0:4a6:fd95:a0a4 with SMTP id o3-20020ac25e23000000b004a6fd95a0a4mr5940005lfg.485.1669022039057;
        Mon, 21 Nov 2022 01:13:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g2-20020a2eb5c2000000b0025ebaef9570sm1385005ljn.40.2022.11.21.01.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:13:58 -0800 (PST)
Message-ID: <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
Date:   Mon, 21 Nov 2022 10:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Content-Language: en-US
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221120153419.GA3094349-robh@kernel.org>
 <20221120170630.29354-1-edmund.berenson@emlix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221120170630.29354-1-edmund.berenson@emlix.com>
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

On 20/11/2022 18:06, Edmund Berenson wrote:
> - Add the ad7927 compatibility string, with fallback compatibility
> to ad7928.
> - ad7923 and ad7924 are treated the same in the driver, show
> the relationship in the documentation.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------

Do not respond with new patch to some old thread. Each patchset starts a
new thread.

>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> index 07f9d1c09c7d..e553853e25d5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> @@ -11,7 +11,7 @@ maintainers:
>  
>  description: |
>    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> -   AD7918, AD7928 8 Channels ADCs.
> +   AD7918, AD7927, AD7928 8 Channels ADCs.
>  
>    Specifications about the part can be found at:
>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> @@ -20,14 +20,22 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - adi,ad7904
> -      - adi,ad7914
> -      - adi,ad7923
> -      - adi,ad7924
> -      - adi,ad7908
> -      - adi,ad7918
> -      - adi,ad7928
> +    oneOf:
> +      - enum:
> +          - adi,ad7904
> +          - adi,ad7914
> +          - adi,ad7908

You already started shuffling the entries, so make them ordered. What's
the point of changing the order from one non-sorted to another non-sorted?

> +          - adi,ad7918
> +          - adi,ad7923
> +          - adi,ad7924

Then deprecate this as alone compatible.

> +          - adi,ad7927> +          - adi,ad7928

Ditto

> +      - items:
> +          - const: adi,ad7923
> +          - const: adi,ad7924

I would expect lower number as fallback.

> +      - items:
> +          - const: adi,ad7927
> +          - const: adi,ad7928

Ditto.

>  
>    reg:
>      maxItems: 1

Best regards,
Krzysztof

