Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC672EBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjFMTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFMTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:09:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580B19A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:09:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so13895246a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686683345; x=1689275345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKlCZA3/0PkDlUywQkb1PhLDuUB0+9ELHymR4eA15rU=;
        b=lZ1wJxBDp4pcSXNcp8cWxLTeTK+HfrIKZf+m6Da9S4dJxZnFROIxyPWK29t5lg1uIz
         f1vRtdGpZwRVf763rgTVMVwR52eCt803s6ILFw2sgIwPUWkL73MljIkpr4sheWylcuRy
         IdJCUShTOt/IM3ybMAIoedKwvM1U2UAUzAByDo40cgdBapXMYB33FM8PLgrfRI7mCy3G
         i1kcpoccvYIFngDig6XYaxjmxrD3eM2eiDq0BOxzXbr3Q7AGJ/44syvx/knQZz6NUWv5
         Ru5Sc4OsHz5xRVMvUd9RxoIXp+VA99Mg8ZtC+zGhpZ10wgU6JWA4QDHTWWzWtgq2dNae
         r2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683345; x=1689275345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKlCZA3/0PkDlUywQkb1PhLDuUB0+9ELHymR4eA15rU=;
        b=hDIE/7Xz30Tf20Y5gj3qmxSj1mAEkm3wO4Niu3y7hzXVOiqdD2r7cNWbD4SqR/i/qB
         GGwbxFtsvJovOa2qKD6gH8xut4AxXdCSA+7PsI3PijByMqDBqc98Exh4fMI3rkz5D+V6
         E037j7wwRMj+ay+3O/QOYM6sVXJUdGItis1ruDyIxrHWBnlAvXRPZVL0fV9Fnc5o81Yy
         GEz3xh+0e4mKjLPZesLlq4/cn9QkL/fGeVDlU0MYBIJ2oSEaDsNFQKgeVDi8EoZOTyaT
         53+E35n8SdrwLrPBThx5P0oqfI0E/h7yL/01w5lkHXGq5y3HXSwFR9CXQZTZmqjzILcW
         dtZQ==
X-Gm-Message-State: AC+VfDzyookQdele9BO3ljceoZexzYrqI5so/SjWInK9CujNLYgwJrBp
        ltBenjzTVDuFanlrPha/guYzsg==
X-Google-Smtp-Source: ACHHUZ4yc/iBIzssqHOIK2gvJxevALXcV3FSbVA9Not+FCwtqKOBEB2uVioxt8Oj1PA/XRY9ZE8rTg==
X-Received: by 2002:a05:6402:2691:b0:514:9e81:6185 with SMTP id w17-20020a056402269100b005149e816185mr9449038edd.16.1686683344773;
        Tue, 13 Jun 2023 12:09:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j25-20020aa7c0d9000000b005148f0e8568sm6820301edp.39.2023.06.13.12.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:09:04 -0700 (PDT)
Message-ID: <0600a505-d1bf-f4be-57ef-51d34c77501e@linaro.org>
Date:   Tue, 13 Jun 2023 21:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/8] dt-bindings: rtc: isl12022: add bindings for
 battery alarm trip levels
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-4-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613130011.305589-4-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 15:00, Rasmus Villemoes wrote:
> The isl12022 has a built-in support for monitoring the voltage of the
> backup battery, and setting bits in the status register when that
> voltage drops below two predetermined levels (usually 85% and 75% of
> the nominal voltage). However, since it can operate at wide range of
> battery voltages (2.5V - 5.5V), one must configure those trip levels
> according to which battery is used on a given board.
> 
> Add bindings for defining these two trip levels. While the register
> and bit names suggest that they should correspond to 85% and 75% of
> the nominal battery voltage, the data sheet also says
> 
>   There are total of 7 levels that could be selected for the first
>   alarm. Any of the of levels could be selected as the first alarm
>   with no reference as to nominal Battery voltage level.
> 
> Hence this provides the hardware designer the ability to choose values
> based on the discharge characteristics of the battery chosen for the
> given product, rather than just having one battery-microvolt property
> and having the driver choose levels close to 0.85/0.75 times that.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/rtc/intersil,isl12022.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> index 7c1e638d657a..d5d3a687a34d 100644
> --- a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> +++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> @@ -22,6 +22,18 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  isil,trip-level85-microvolt:

Why encoding level85 in the property name? Your commit msg (datasheet)
suggests this is quite flexible, so why it cannot be just list of two
trip levels - for first and second interrupt?

> +    description: |

Do not need '|' unless you need to preserve formatting.

Best regards,
Krzysztof

