Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB16945C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBMMZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBMMZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:25:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699256A71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:25:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so11987334wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnwIgsjpd+c8WpyaE/N+AGgyNzuJ9HH3oMrH5fgQqto=;
        b=qHcVx3AYZkdYmRj3S/2tgiLojLmOd844Reb+AVhIRYce6+expKPAx6iPLHqKPa4TGE
         2ZpKmJ4bQKG3x5fgfUmGwT8zUHMVhNg3nHWMr0mYWzLuw4Tnk8PT1HBaUS3ufHfZXK4h
         1rn4c4I5yiypGX7JEMzeQ/LcV+xf5/QPmKcMHY14WKtUiM7h6Bu9yLCAAppElR6Xa1s/
         +sytG/+sFb9BQQLPGzUoO+nSAcDd7XoNL8jJCzU2E0O8/Ux1t4GPa7fZ/lY4xyeTWhQf
         1riJCuj/MORTprbJZ0btVRyHEl2pUIRDJfpDwA39U//rG1jgMH4VglGHWurATx9oI/Ju
         WAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnwIgsjpd+c8WpyaE/N+AGgyNzuJ9HH3oMrH5fgQqto=;
        b=NK8eZd41Gq2Dhtr/LMF50lwdH6eEAU4AMp5sn1YG5lsYXIkZds06/dPe2LT4mxkpOO
         ALOU1MiPrq7SaCQ5P1HZqCqcp9Imvc/+IkhmyA7z8hFR5n6wGfsWo5t4XZGf3TFtXkF/
         32BeL0qjncSD8mRmCrVqubsccv1Y3P1bMyXjJj+AWnyroFIJQExlErAnVhTYQ1qA0bTx
         Pwi6odsOpXxAclYQ1yqDXzPqiivm1vcih0YsP23+Hc54Ix0IaJt89vvrM1D3k3GBMOh3
         24U6H4okxmvMS8pfgf+ABNrW6O3/aS2p8VN/LuoVr/j/DsCjWfkMuw9Mp/pdB+LXEiB5
         J+uA==
X-Gm-Message-State: AO0yUKXcvQ2nWSF24rdPDYa4ArHOdvB+ilML0v9wvT4CNl1FMiYHf7XZ
        P5y9BU4RjbD/hkPalj0KPH9rSA==
X-Google-Smtp-Source: AK7set+4PpLMgJB1yUGYKL1mzIm6ne1Gn6yPLTOvluJk8/6cXFAXvSFmj+YOt8uoZcz+uSP9NYUfHA==
X-Received: by 2002:adf:fc4c:0:b0:2c4:873:16b4 with SMTP id e12-20020adffc4c000000b002c4087316b4mr12059993wrs.16.1676291140044;
        Mon, 13 Feb 2023 04:25:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b0027cb20605e3sm10368464wri.105.2023.02.13.04.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:25:39 -0800 (PST)
Message-ID: <bd528dd8-6f7e-d4cd-fbe9-ccbab7856fb6@linaro.org>
Date:   Mon, 13 Feb 2023 13:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add
 quartz-load-femtofarads for pcf85263 and pcf85363
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f8cc75cd-465e-4339-8415-7d994963b841@emailsignatures365.codetwo.com>
 <20230213095018.2255225-3-javier.carrasco@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213095018.2255225-3-javier.carrasco@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 10:50, Javier Carrasco wrote:
> These RTCs are handled by the pcf85363 device driver, which now supports
> the quartz-load-femtofarads property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 20 ++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> index a98b72752349..aac7f7565ba7 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> @@ -9,9 +9,6 @@ title: Philips PCF8563/Epson RTC8564 Real Time Clock
>  maintainers:
>    - Alexandre Belloni <alexandre.belloni@bootlin.com>
>  
> -allOf:
> -  - $ref: rtc.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -37,6 +34,23 @@ properties:
>    start-year: true
>    wakeup-source: true
>  
> +allOf:
> +  - $ref: rtc.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nxp,pcf85263
> +              - nxp,pcf85363
> +    then:
> +      properties:
> +        quartz-load-femtofarads:
> +          description:
> +            The capacitive load of the quartz(x-tal).
> +          enum: [6000, 7000, 12500]
> +          default: 7000

I don't think this will work. If you tested your DTS, you would see errors.

Please define the property in top-level and disallow it for other
variants. Other way to make it working would be to switch to
unevaluatedProperties, but defining properties in allOf:if:then: is not
that readable.

Best regards,
Krzysztof

