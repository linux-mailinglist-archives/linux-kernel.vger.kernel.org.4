Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74572EB28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjFMSmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjFMSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:42:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0977E3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:42:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so10047105a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686681724; x=1689273724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9J/4CK07txoWvpRkuIct5M/3DR+A6hR9YqitxGo9vo=;
        b=xHwJevKZzycIwLN/4ZqriOCeYi5DJ96nxJzDAAZ0N+jJnd0V8WmUNr1RxOMEoPvxX5
         09gskRLCGdXoN7u+104ZDtC4DDYiAEuSSs872rlQ378IODj4EVgWt2E/TRwO+JtHxWo7
         ZXWfdEcvIcEO9yfqWr2CyFnXkIsbCe35lgFDe+te0ybeiw/zDv3o7MUGybqRjTGZoOSI
         5gPVdO2zDfg/WHFWksLTpUkHgxD9zgziIFzZaL/6awMT8kqkFKO/7NWOg/mGF4FuYW5b
         pSkCTLzmmwX46aPrAlddBGryxTYcHXZZGJtcQ1ZTOVzCG2AJEfmeg5/Hox4XK3XrGe+y
         vHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681724; x=1689273724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9J/4CK07txoWvpRkuIct5M/3DR+A6hR9YqitxGo9vo=;
        b=WvKT5tk5iRT3YhibwmFwoqcKjhbjaCrIwHBKb7/QFv+rMFTqyuu2J17i4tWz1twzD2
         XEjpjM6nT+osMuBpfjG4AcnYef7/42T0Q+WMAx+UrErZ0DagxX7bDG7ROvTYlccvbrFX
         fyQ/6mmzplWmpJxJPW4dL3W2f4fOGB72ZOoC9t8TQK3EagD9LuMWfAApL+vFgQkiyDDr
         ZzwFLCOMtKJ1C05a+ekNBuZhd0OwdomrwiGGdujjw1NrNTmmZ3nHGa2ZG5L3CSgwvPaL
         r2zMnTmKnIyGDFghBQyJy8Fc9EH7IBAczwAC2SJjQeOiGFbUIaZZQoWrJa6Tnl13YR/E
         kTvg==
X-Gm-Message-State: AC+VfDwhMv9ON3hxd7vJkEDgfmrmfntpgT0eaKPI6D1j6aOp7cnDabMj
        4/VFqag/grks/cfcGvM5mKmTag==
X-Google-Smtp-Source: ACHHUZ4f5uJfXxJ457q4UknWNqD0gfSHRZjl8xS4OTPNrTEg99TpXgpzNXgzXCMlipTdb7eHArGrXQ==
X-Received: by 2002:a17:907:807:b0:977:d027:eeb9 with SMTP id wv7-20020a170907080700b00977d027eeb9mr12854684ejb.35.1686681724047;
        Tue, 13 Jun 2023 11:42:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906379800b0096a6bf89259sm6961056ejc.167.2023.06.13.11.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:42:03 -0700 (PDT)
Message-ID: <22dadcf6-9879-efb2-9987-7f286b38b93b@linaro.org>
Date:   Tue, 13 Jun 2023 20:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: ROHM BU27010 RGBC + flickering sensor
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1686650184.git.mazziesaccount@gmail.com>
 <98e0b6fba7ff7515b541a517296d5b89dc73ce5b.1686651445.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <98e0b6fba7ff7515b541a517296d5b89dc73ce5b.1686651445.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 12:19, Matti Vaittinen wrote:
> The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
> IR and flickering detection) with five configurable channels. Red, green
> and flickering detection being always available and two out of the rest
> three (blue, clear, IR) can be selected to be simultaneously measured.
> Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
> and tablet PCs.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.
e.g.: "dt-bindings: iio:"


> 
> Add binding document for ROHM BU27010.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../bindings/iio/light/rohm,bu27010.yaml      | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
> new file mode 100644
> index 000000000000..2bde9d2f1def
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/rohm,bu27010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BU27010 color sensor
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |
> +  The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
> +  IR and flickering detection) with five configurable channels. Red, green
> +  and flickering detection being always available and two out of the rest
> +  three (blue, clear, IR) can be selected to be simultaneously measured.
> +  Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
> +  and tablet PCs.
> +
> +properties:
> +  compatible:
> +    const: rohm,bu27010
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true

Isn't vdd-supply required for the hardware to work? How does it get the
power otherwise?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      light-sensor@38 {
> +        compatible = "rohm,bu27010";
> +        reg = <0x38>;
> +      };
> +    };
> +

Trailing blank line.

Best regards,
Krzysztof

