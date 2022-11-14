Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BBB6277EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiKNIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKNIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:39:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CFE5F75
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:39:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j4so18174381lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oFfY/N68Q8NBaNJQXMJs0RKI38kQ4LuijQR5F4a/tc=;
        b=yuLv1bnAvS6XAzdHgwoHAvcVJtX6207M2s8jV7pyKDwCP0CvT+cd/3Xt5lGkm5BJU+
         Q3bYi1/IdjR/HZ6wSnY3VzbZxVNhNiTzBlTeFymDfsvA2BVYsaJsdu2WjdPWt1We6hGh
         3hITpvEWn0FqxFGvSmZSrz5NFWa6G4yfkl/fA1R8/xfPWlADILvzE2GlOqZA/V+1T1B+
         FBRBSipZrrC3341jQFwwckdqD8qpq0qJus/exN3S2VdhlcIU7s5K3tkPREmFa4PLEdOJ
         omWmfNZZu1y4hgmSMuEj8DKaKHWeqQiGVe+LTK11PL+kiZ6/26T9+V9A1noq93R9Isan
         IjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oFfY/N68Q8NBaNJQXMJs0RKI38kQ4LuijQR5F4a/tc=;
        b=aBPM/LZClseTavPDaKjWPmASdhDTiCEmuztoNovG/nCvVvGTR6bl2YrZHXkPWGoT+l
         9TwGjUqkn+ktsN75yTUsgZmP1Mfx+mlLEDHXqn6KylSaDnvCo/nzBPbxw3CbHXRBtDcC
         HceUa8KXwyEbb6LuAMooGPBSghoX2RtomUIHHhGtp4Uc3v+QYBG7FXH2bqy+XXnzW2WC
         i6BVBFJNAIDOz920eFWXhEzJaaZ5bwZUZvDspc5FgRm5f6saEzK0cG5xR3GYUKoil4Ek
         gUItfooIPL46jyNZ464e02kCKKJ65iayE+s9wtd3xHb2avG9FU74WDr0AUnKqPb6b+KC
         JD8g==
X-Gm-Message-State: ANoB5pku+wDUPmQTIKftM9F0T9Rl0JkFCYxHEBOYHLAVi+Lg5OnHTyw6
        vFp/ZemblfGNW6JXjLvUTz0few==
X-Google-Smtp-Source: AA0mqf55Qbw0TgvF9gSuSuMW1+4uG6FK38zccVWIo/t5cBVtuwBpj2peQhN7JVCP1hdYk91xYoHmJw==
X-Received: by 2002:a05:6512:3132:b0:4aa:1754:9ae3 with SMTP id p18-20020a056512313200b004aa17549ae3mr3586939lfd.344.1668415190232;
        Mon, 14 Nov 2022 00:39:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004a26ba3458fsm1739532lfo.62.2022.11.14.00.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:39:49 -0800 (PST)
Message-ID: <e0386c67-da39-b77b-2c92-6d70ee321fa9@linaro.org>
Date:   Mon, 14 Nov 2022 09:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/12] dt-bindings: pinctrl: Add Cirrus Logic
 CS48L31/32/33
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org, tglx@linutronix.de,
        maz@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-5-rf@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109165331.29332-5-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 17:53, Richard Fitzgerald wrote:
> Codecs in this family have multiple digital I/O functions for audio,
> DSP subsystem, GPIO and various special functions. All muxable pins
> are selectable as either a GPIO or one of the available alternate
> functions.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/pinctrl/cirrus,cs48l32.yaml      | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
> new file mode 100644
> index 000000000000..b24fbae6a8f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cirrus,cs48l32.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS48L32 audio codec pinctrl driver

Drop driver.
s/pinctrl/Pin Controller/


> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +The Cirrus Logic CS48L32 codec has a number of GPIO functions for
> +interfacing to external hardware. Certain groups of GPIO pins also
> +have an alternate function.
> +
> +The properties for this driver exist within the parent MFD driver node.

Drop driver... so probably entire sentence.

> +See the core bindings for the parent MFD driver for an example:

Drop driver. Describe hardware instead.

> +
> +    Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> +
> +And the generic pinctrl bindings:
> +
> +    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Drop entire sentence.

> +
> +properties:

Your schema does not match on its own. Where is the compatible? This is
not how schemas for devices (also MFD) is done.

> +  pin-settings:
> +    description:
> +      One subnode is required to contain the default settings. It
> +      contains an arbitrary number of configuration subnodes, one for
> +      each group or pin configuration you want to apply as a default.
> +    type: object
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        allOf:
> +          - $ref: "pincfg-node.yaml#"
> +          - $ref: "pinmux-node.yaml#"

Drop quotes.

Except this, test your patches before sending.

Best regards,
Krzysztof

