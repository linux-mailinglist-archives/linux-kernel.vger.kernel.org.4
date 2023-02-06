Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BEF68C6AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBFTVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBFTVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:21:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E35EC68
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:21:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n13so9431090wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGhlandvp32zJuT9yzD1H530+wjS7yGNPZyYGw6c5iw=;
        b=RK9KdUt9G34mb44xh/5h3OJn/2y9DCQCHJYG6331S3Nkcfl1SCla9sdyBucGntiPxP
         fCwsuLQRfMDC19jPGH1Y7GtU7tj7qiU+PNQ9WWEc9RdVP7nGXvPJ1whG7edf62isi0WJ
         9hY/eOpkb+YzwOk7lCraIXsxuQRi2r3r0WGQQUCCsSVgxAV0n7+DM7Wqb4Ph4/ZV5WuJ
         2BzG6Bys/oFKYCIL40QiJjohO9wOQasfG/5PnsgCj7Dmr/+j84I2kvOCRHhTLFAIn3Gp
         7rlmaIm9O+vHBDwcnfD0bj856GTRBl1D7nA+L9/lE1Wr4pZiY507foIqIiNwdphuGrZy
         W5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGhlandvp32zJuT9yzD1H530+wjS7yGNPZyYGw6c5iw=;
        b=oxmI0vUZWbF6ZGSgxlCYDUc+8w4i3gfZgRbxUQwKJqaA8zDZJ6ldC52ouYzZKhkwYT
         tb9v8WQkWrvsp+BTowbDxfWRoXhr5FNHzqzAmBh0vblYqXprywD6Ecw7C1kXW8pDud2X
         72+OzKjB4fcQ5u+dpkMI1DM7N4Ff/ITUDHfhdwMPqDwEtoBVGVU3jtAbsJFktvC1X/qu
         410E3kmBrzrS3jdN2UL5k6xoY7ToOYbLMotPwzScNbjFeGCSngrNUc76prBUIeKuX4V1
         ek1+4rvKKkz5w/RIkS0Ap2aK7wYY/BoZcXqa8S1/8W0VjxkGLI241u3apgP/PQdndqFV
         czNQ==
X-Gm-Message-State: AO0yUKU0wm+b/KFIPaW++U/Ss9d/H4RedHLrqUVi/9o5ZW9Sb6B/20sn
        jTTm/hyIFAWP5ECH+3oZAjdoHA==
X-Google-Smtp-Source: AK7set/SDIe02vvcqIXxVdYR1JTowEX0cXIGhrq4GDN8fP/pcdD3VeaD4VIm3863dwYdvnDd4WXa9w==
X-Received: by 2002:a05:600c:1714:b0:3df:dc29:d69 with SMTP id c20-20020a05600c171400b003dfdc290d69mr676718wmn.36.1675711304635;
        Mon, 06 Feb 2023 11:21:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003dc5b59ed7asm12549446wmq.11.2023.02.06.11.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:21:44 -0800 (PST)
Message-ID: <a711905e-dbfb-4258-62be-250a9549a9c4@linaro.org>
Date:   Mon, 6 Feb 2023 20:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: meson: convert axg sound card
 control to schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-8-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153449.596326-8-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 16:34, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg sound card to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-sound-card.txt | 124 ------------
>  .../sound/amlogic,axg-sound-card.yaml         | 183 ++++++++++++++++++
>  2 files changed, 183 insertions(+), 124 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
> 


Thank you for your patch. There is something to discuss/improve.


> -};
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
> new file mode 100644
> index 000000000000..b7459fad0e7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
> @@ -0,0 +1,183 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic AXG sound card
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,axg-sound-card
> +
> +  audio-aux-devs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: list of auxiliary devices
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |

You still have everywhere | which should be removed. Here and in almost
every other description when no special formatting is needed.



Best regards,
Krzysztof

