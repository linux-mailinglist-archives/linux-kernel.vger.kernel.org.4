Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1084D6314EB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKTPeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKTPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:34:20 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2B2A408;
        Sun, 20 Nov 2022 07:34:19 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id c129so10361927oia.0;
        Sun, 20 Nov 2022 07:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOJZTwPNr15y8ww06D1zCbd0k1mlAzde3nhboFPKzxA=;
        b=hUoFeFUMqyRiI5xSmDcsXuT55gJmBOWo2E6M2W4C0U1hJXugy8Yk5jH2zojAFa152i
         j778Sno4ODXAnriCBrl3FECH1/wDjdYOPT7C1UfSrSOA7xlhrhvprAQKvwnWIrI4mQTt
         x+oBUWNiX5l33BJuoLGiwPUsHFJtHtDoiXv8WxCF/GKqFpncc4ehW/mdAssMGrIz7UDu
         D6Dgna9rJtBtGp4QLceFZZno/eq3XUo4KGmMZ0ODufvlA3lW3JB5OKBHG5iZFzISJ1b/
         s9x22JDAnhxH6o7dByJ7kTHG7MTG5FGbCrWq3g+vpP7QIS1cMPY3cVYhV4xELCAfWrPm
         AtAQ==
X-Gm-Message-State: ANoB5plG0/1kjoHg6rPV5oG7wnPaeWx5jo/KhB5Q3SQEzz6n3tiuQkBL
        fQkg2DWtS3ZV+m/QgecapM1jjFHzaw==
X-Google-Smtp-Source: AA0mqf7kN+93jrBbuUgyOvefnXGk1u2wVGAE4286f8VAaiYCD5ye6yKHondK5FBZyfLFLsef2bxFBA==
X-Received: by 2002:a05:6808:98e:b0:35a:7a86:d38b with SMTP id a14-20020a056808098e00b0035a7a86d38bmr2518707oic.49.1668958458864;
        Sun, 20 Nov 2022 07:34:18 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f6:1a48:29f6:113d:266f:a78e])
        by smtp.gmail.com with ESMTPSA id e19-20020a0568301e5300b00637032a39a3sm3894364otj.6.2022.11.20.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:34:18 -0800 (PST)
Received: (nullmailer pid 3096259 invoked by uid 1000);
        Sun, 20 Nov 2022 15:34:19 -0000
Date:   Sun, 20 Nov 2022 09:34:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ad7923: adjust
 documentation
Message-ID: <20221120153419.GA3094349-robh@kernel.org>
References: <20221116191208.269e67eb@jic23-huawei>
 <20221120124543.18973-1-edmund.berenson@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120124543.18973-1-edmund.berenson@emlix.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 01:45:43PM +0100, Edmund Berenson wrote:
> - Add the ad7927 compatibility string, with fallback compatibility
> to ad7928.
> - ad7923 and ad7924 are treated the same in the driver, show
> the relationship in the documentation.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/iio/adc/adi,ad7923.yaml          | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> index 07f9d1c09c7d..165c4b6863e0 100644
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
> @@ -20,14 +20,17 @@ description: |
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
> +      - const: adi,ad7904
> +      - const: adi,ad7914
> +      - items:
> +        - const: adi,ad7923
> +        - const: adi,ad7924
> +      - const: adi,ad7908
> +      - const: adi,ad7918

All the single entry 'const' cases can remain an 'enum'.

> +      - items:
> +        - const: adi,ad7927
> +        - const: adi,ad7928
>  
>    reg:
>      maxItems: 1
> -- 
> 2.37.4
> 
> 
