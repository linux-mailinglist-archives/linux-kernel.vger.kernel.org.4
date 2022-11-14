Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EC6277DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiKNIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiKNIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:36:41 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D951C10E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:36:39 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c25so12197095ljr.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTEjizgK12vbPhLWwinQMtA1pCqdItXWmozqdg50nZw=;
        b=MH5HrumJHEerfCAmCAxyabzajxtCKGY4N1/zdkGvwRKg47JNE8L+sTUVtBQ/x6DvtH
         Cpr5mXU8diCaYtEDv3BahxuP7NBto4sBDsoYmiylnu6eu0k52kRYFuu6z+kIGYfo+VUG
         1zjSpcde8JazuQ4eiC9nUSewURMfofFkZ3QYqyXZ+rP4WALZQqhDkmsVp+YNpZs+oBG0
         r21KXlNlBJEi2m3U7FzAajtr8KmjkSr4j0L67MHR9zWfxcrfYPctGS+B5JzWm0tup2OH
         VZVdC7uYss5C8myBNKAatvua1SImYoNsSTJ6QjJCJnAbRIwkxx0wJ4LekJD1DrkXQI/7
         c+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTEjizgK12vbPhLWwinQMtA1pCqdItXWmozqdg50nZw=;
        b=yiwO25Tb/wBnvu1o6BeAz6ZIFq4ih0bVfn3GvaqF/qh3364fHEPjYIWVRX1Z48dz5z
         aKCUgiIV342wqXnK58tl6P9OLpL24rWrzpf0UwfRBxeLYgDMje7MrCNbvjUvn+Co+cQb
         PGmtUD+wMkHeQHPlyNQ+1BnIpWHKT9TSad7wAo9KG2dsC5CXZfBeLAi3No4qABPMG3CZ
         I0KfDzVZqLWFITlr1C1i72hbOFXeYgUzhCpoXja5jiHr9SznEVulmezGOFqVaC8ZsRk4
         2vFQ5ZeSibr8g0577Ib4r0sOO41toRRnkBEG1Zh5l/YxZnfz5pdkoVim8s0HY9rZPs84
         5qEQ==
X-Gm-Message-State: ANoB5plrS/33QVclivDUiPmrphKf6af+ocoM1J8cC24WGfWHqKvkjfgz
        f3+R1T+3lV+efO96PmVguZt3lGoS8LCE8qox
X-Google-Smtp-Source: AA0mqf5ureuJ0OvXRBMKbOyPj06BKiN5ustz7hPEnpAjwdnbagssD5btEaHfUpLOiAXZy7Z9dFwL7w==
X-Received: by 2002:a05:651c:130d:b0:26e:a:b5c9 with SMTP id u13-20020a05651c130d00b0026e000ab5c9mr3833473lja.481.1668414998294;
        Mon, 14 Nov 2022 00:36:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a1-20020a19ca01000000b004a03d5c2140sm1733277lfg.136.2022.11.14.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:36:37 -0800 (PST)
Message-ID: <09da5c6b-490a-b003-70de-cfee9835260f@linaro.org>
Date:   Mon, 14 Nov 2022 09:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/12] dt-bindings: mfd: Add Cirrus Logic CS48L32 audio
 codec
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org, tglx@linutronix.de,
        maz@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-2-rf@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109165331.29332-2-rf@opensource.cirrus.com>
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

On 09/11/2022 17:53, Richard Fitzgerald wrote:
> The CS48L32 has multiple digital and analog audio I/O, a
> high-performance low-power programmable audio DSP, and a variety of
> power-efficient fixed-function audio processors, with digital
> mixing and routing.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/mfd/cirrus,cs48l32.yaml          | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> new file mode 100644
> index 000000000000..d128600c0b72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/cirrus,cs48l32.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS48L32 audio CODECs Multi-Functional Device
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  The CS48L32 is an audio SoC with extensive digital capabilities
> +  and a range of digital and analogue I/O.
> +
> +  See also the child driver bindings in:
> +
> +    bindings/pinctrl/cirrus,cs48l32.yaml
> +    bindings/regulator/wlf,arizona.yaml
> +    bindings/sound/cirrus,cs48l32.yaml
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/cirrus,cs48l32.yaml#

There is no such file.

Best regards,
Krzysztof

