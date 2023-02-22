Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56AE69FBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBVS6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBVS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:58:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43487125A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:58:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so7283022wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZExv16LneJdJojxchxyl8kHM1ihqG5eeGh+aD+CDB8=;
        b=XesKCxOtC6YIaWHD4mg2rAnro0pj3DqnIlLJmusRMCM1rKT4maaoKLEOAjqrK2X6TJ
         nmrzxsoINL2Vz8EwumJ6IQazQ97ME1T23Y9gQEGIM6DkkI8y3LERzJVJcK2PpDgVYKgW
         XN8y4L9zOX2KHj4SjW6X3u8y1vfTrR8TkUD4SOquixxaajLT6MZqQdt8EXRC2dN7nQcO
         gHfGaeVAV7DnBxnu3B5jHLP367O7tpc65SFQg1DwImC7JQb81vU0RbT+qhYsDh9UqXhj
         hhrbf9RZhN/2yQpYFBt1tveu1o0/KSuVB9Iqn/qFkNYe9+XO8C+7Ui0oFkfnh79MaYSr
         hL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZExv16LneJdJojxchxyl8kHM1ihqG5eeGh+aD+CDB8=;
        b=PujCZdf7gjhLP/UMncDCKcMoe6xdjmrmMChqYI7mFWtZT2w1Ia57Z+S2uyb3ABHlah
         YjmbiGXU5izt4WtbseJwmKsljTavgyjcgwhZhjtDVdbHsHUxbsvAz6NsP7Vs6nMgWb9w
         2SvMMuaDLCI0zsQHu38ymj5UnyGDLt47TQ+fKs5HXyKJGRx0n+yPmRj1ZMWeKMYpRZE5
         okeoJ/6h6ofS5ZD2ZrQZTjOBd4dYCcRe42m0AEBhs8z3Q9fuURjTkphOZUuWnDYqbmvI
         L+/F+78pIag+BwFY7XqG0vmb772baQ5G45/zjQRRW/YSG2sWbR5j1Lz2XEU1qUH6izVV
         bSRg==
X-Gm-Message-State: AO0yUKWXTbbAKQE/xqBgHhY3jub0cYGTMwKNGsm1itWj3Mrln05QAmjh
        7pmoq9sk1l+tU1Tv7pPoU1pPTQ==
X-Google-Smtp-Source: AK7set9xOyM/dCt/cz/X48ePaa+6DCGe05eitjZbvtPxZdqVp2/OG8ogIQc4Hu4YGKAOEvJeOyG3nQ==
X-Received: by 2002:a05:600c:32a7:b0:3db:15b1:fb28 with SMTP id t39-20020a05600c32a700b003db15b1fb28mr7423858wmp.19.1677092282743;
        Wed, 22 Feb 2023 10:58:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh21-20020a05600c3d1500b003e2052bad94sm2790414wmb.33.2023.02.22.10.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:58:02 -0800 (PST)
Message-ID: <e6b2a6f4-d710-7f74-e85d-1cd3f5b96460@linaro.org>
Date:   Wed, 22 Feb 2023 19:57:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
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

On 22/02/2023 17:14, Matti Vaittinen wrote:
> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial dt-bindings.

Driver can be "initial", but bindings better to be closer to complete,
even if not used by the driver currently.

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../bindings/iio/light/rohm-bu27034.yaml      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml b/Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml
> new file mode 100644
> index 000000000000..a3a642c259e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml


Comma as a separator, so:
rohm,bu27034.yaml


> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/rohm-bu27034.yaml#

With filename and $id fix:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

