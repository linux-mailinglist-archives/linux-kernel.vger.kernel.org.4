Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC1677605
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAWIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAWIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:03:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB70125A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:03:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so9980962wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dzfs5ayDVPBEFWi6GbEHfnFVVTv1Tlc/N+Efj3HvIw=;
        b=uHQTjhqYS3Wm9lOke9dw3/x+mCfFAf9h+GbxVZakZZFB0Mx+Nq/TiyjEn8BmNHLiCu
         tbDDnYHXY5nb3GMHzS2M8gGDbd+S7nNpXh+A16mLujIr07d/825m/u0UViAbYZKl8qvo
         tKlhSHF1zCy84JXpB148/zkq8K+uEU7Ux6Fb7ASuCGnY134PwozAnH9yZ6/xaItB9bw5
         ChfQyz3zJmBkHStT/el3WTJQVd/dFMee7v34f81GiMjlXMXjyrAkpLy9ixUinZx1NuEI
         VMl4XGl2Lx8KC0z2aAZs3mmuRGIxQ1snU0FlS5jZz0xXVxVbB3CCNaWnxG8MJSom31Ij
         wT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dzfs5ayDVPBEFWi6GbEHfnFVVTv1Tlc/N+Efj3HvIw=;
        b=hcAE1jktW59Cq+fiaSSL20g2Gs2DsRkG1BvTsLrEtpehM8QZBesVNgfMo9My13eOAK
         Ijlx4WiEJwah9mPfsDDdHy7t3LFMwy1XsvgGPS/gTRi5PqeizAsuT/gmLqcesV5e3J1J
         ZZ1nI8Kvhj/q+rYkTlNzS0qtYvEItPpscbBRo6x2rzJEiGtL/27xMewSwSHGjcb0k2r+
         clobJl9KsRrVgpMwBsdwh0+D89/ZeUsSx1R/B8GCHax5XNlfFAwPQvkCyW+euihdocLb
         J11oYIr3CHTsMGIEeHnT1xUq60wV0jKcLsHa25bVbsGWj7l9YUzXCyN5l5Qci0hRuz3v
         GVrg==
X-Gm-Message-State: AFqh2korc+dmgBNkdyZbCBuKKSWrpa/Atrq4AFAq+nAHkyNty7OAZv4a
        NS9iSj5qwyOhve+Hure/w1Ge1TaR+5PazgVn
X-Google-Smtp-Source: AMrXdXtpbE8glln9/q7ZVfr2RyHvgbZzXmhmHrf/P3AWmIrsKlvyTV0fI9FEVqJwgoRnk6PMApkxbA==
X-Received: by 2002:a05:600c:a11:b0:3db:f1f:bc31 with SMTP id z17-20020a05600c0a1100b003db0f1fbc31mr19745446wmp.16.1674461009396;
        Mon, 23 Jan 2023 00:03:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003d358beab9dsm9822845wml.47.2023.01.23.00.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:03:29 -0800 (PST)
Message-ID: <9c71faa2-d186-7b54-e388-ec483a93b3a0@linaro.org>
Date:   Mon, 23 Jan 2023 09:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 03/15] dt-bindings: arm: ambarella: Add binding for
 Ambarella ARM platforms
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Li Chen <me@linux.beauty>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-4-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-4-lchen@ambarella.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 08:32, Li Chen wrote:
> This introduces binding for Ambarella s6lm SoC.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: Id95d91218625a1f0b3413aac101c2ca8831f0385

Please run scripts/checkpatch.pl and fix reported warnings.

> ---
>  .../devicetree/bindings/arm/ambarella.yaml    | 22 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/ambarella.yaml b/Documentation/devicetree/bindings/arm/ambarella.yaml
> new file mode 100644
> index 000000000000..2c8ff75b57b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ambarella.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ambarella.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella SoC Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  compatible:
> +    oneOf:
> +      - description: Ambarella SoC based platforms
> +        items:
> +          - enum:
> +              - ambarella,s6lm


Best regards,
Krzysztof

