Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21456EC9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDXKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjDXKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:13:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E93C29
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:13:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94ed7e49541so607680166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682331181; x=1684923181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXT5E7OZ//jITYhQyuIDwwm6YKH5XMhlBfr843lviiE=;
        b=OigjKAGujgNRJ+N8F2U0AQWOHRXdAHvmGIlvvT4yO9400zgdG0i7R44EN+qSZdaMKf
         csW7d/Na9QqPuIO4LjfzRnTHxpu4ZRoZ50JxzfajJ8r3Fw7P3njZIABA6b8eyNb1V2IC
         6dXUiCTAO9IZITjT1KHCy5ArpeXTtac6OnVHFM50zb+Nt0iLmngLnXtde/lSN25ybPHJ
         G0L3gpgIhnGDU0lrpggfe/vwb6pfThsMjlN30SNe5R6rWRSCOHZFOWlxkljTcJsgZcEX
         9vjpV0WZIMYrQIv/0kNTwukyyHS/ThWTOrLcTPaAxXsT++x2p2QX4ngxMLBHrq4eHL3j
         S+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682331181; x=1684923181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXT5E7OZ//jITYhQyuIDwwm6YKH5XMhlBfr843lviiE=;
        b=gDODpohpXuyr7//+3+b8rzrXk+HoO704MOS2weLJUMzESYCW0wqnHohJZy64jh/UA9
         9SzD+dQ4dpZ/tKGZcnVJMD8Zu652PRqjsV03aI2IhA1BjeF4xBmat9Lq1vNMqnzE0h/v
         T5xpQkyt3RJajUUsJEsR/XVws0MqsnJbakbU8LyHXPQZQcApOu4Tt4NCsZKeSYFJNSXS
         DbCvrmecaWRH7zTBtmxUcwjnQJwonpou4QfXjgHzIuZkJZ2+nDv+GAn5IIW7V/XpaI7G
         B97/4pdshTG6HJA2iHjTnqUUiGxpe3iU7dI2lbUS/mS7LHbv8pIh7CZ9obwvZMx2EMoE
         PrNw==
X-Gm-Message-State: AAQBX9coMnwbrL5pzYnAemfllXEW1hsPLc42MO48WbCwr6qM5qCNHpkl
        KrT1av1fSNRDkxWRMdjFicGdFg==
X-Google-Smtp-Source: AKy350ZcDUTAUkG8ilfYffZZ4XTVkbuSs/h45mgeenDcde3aQ8x58MxSjhfoQ6DuXmDmQHajwdCmXg==
X-Received: by 2002:a17:906:3451:b0:953:4448:837b with SMTP id d17-20020a170906345100b009534448837bmr8395981ejb.53.1682331181124;
        Mon, 24 Apr 2023 03:13:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:fcdb:bf53:d053:3a52? ([2a02:810d:15c0:828:fcdb:bf53:d053:3a52])
        by smtp.gmail.com with ESMTPSA id hb8-20020a170906b88800b0094bb4c75695sm5351923ejb.194.2023.04.24.03.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 03:13:00 -0700 (PDT)
Message-ID: <06d60a20-a620-b9f6-adc3-337973dfb8a8@linaro.org>
Date:   Mon, 24 Apr 2023 12:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: ROHM BU27008
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682067567.git.mazziesaccount@gmail.com>
 <30daff0d94cd4d05de0194808ab9a6984caf78dc.1682067567.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <30daff0d94cd4d05de0194808ab9a6984caf78dc.1682067567.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 11:38, Matti Vaittinen wrote:
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add BU27008 dt-bindings.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../bindings/iio/light/rohm-bu27008.yaml      | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml

Filename like compatible, so rohm,bu27008.yaml

> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml b/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
> new file mode 100644
> index 000000000000..d942c2817680
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/bu27008.yaml#

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BU27008 color sensor
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> +  and IR) with four configurable channels. Red and green being always
> +  available and two out of the rest three (blue, clear, IR) can be
> +  selected to be simultaneously measured. Typical application is adjusting
> +  LCD backlight of TVs, mobile phones and tablet PCs.


Best regards,
Krzysztof

