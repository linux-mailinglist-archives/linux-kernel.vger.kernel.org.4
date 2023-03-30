Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2876CFD01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC3Hjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC3Hjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:39:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB114449A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:39:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so23426406lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680161978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1BFQFEcp+Yc7eK7+gRqJuLKGd2zLsXk3LDs9OcFmZs=;
        b=ruldmbq64NM+hwrT/y0is2vQMgd+GIg71Oboaq2lJYwssqBaw6eK86sRZ2/R9RWiWb
         qZGN+9RZW8Hob34SVoK1OPpL7PTvxVES2P37JZsx/bI5K3VPsMxTmqbIwMAsAFDP3jgR
         T9C9SpPHR2VTbi2RXgEVjnJ881PG78j/N1bSrbfYc8FyzzmbDrY1kNi4QESoxY7PWhXX
         Zz+UC8n1m+4CUFohK0Yzqz7RbGeBP6u84ND8MOgCw5xw1EZOC1LX63X5yQwcNFxVM3P0
         Z3ublQZNxVx67c9jRHkN7OFj4gfp82jHCEmbRP2axY0oiNuIwEHShdjoVOaKESnCGBcB
         3hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1BFQFEcp+Yc7eK7+gRqJuLKGd2zLsXk3LDs9OcFmZs=;
        b=Yx/cuqbwTwKLLw8FH0Wo0sKwC8YNLnIJvxBKzaul3ErSHhQICBa9I9TDV1XvvOzvkW
         S+4zbtcaozJkrISq+NE1LgGe5DupKRoAvZ/quqJb/X+YEkFNhJ3EvYjt6sJdNbTnbcEZ
         D6z3alGbf57/IjlhjihelNJVT1oKJ75tOW3PEB/FbN2J/KgG267qv7DUvGbTrxMPppgq
         mHRhroHOD+b+oQ3cAtldiqsjIS1mnS4DWhRYs6Q8b9zTaE2qVbvYA8RwucCug7zcM/aj
         vz85FjU578c2/jIGidjrEAmQM5rsS4MioyPkvqdSkSIsXb1f1tjYBwFZpbnVdmWh4LSO
         j9mw==
X-Gm-Message-State: AAQBX9feFxys4fhO67pScvomlc7Ww8kwl4Boy50sDFPuqiFVNqT+jUPv
        iWRwHzAV6ow0uJJHysidVjFmYQ==
X-Google-Smtp-Source: AKy350bAQUuZJ9AdRREDwN63mloWL2b2FNGC4p1ekLCHdHGiBahv9ED14kOttKyL58M6k3Pwu6iDbA==
X-Received: by 2002:ac2:5458:0:b0:4ea:fabb:4db1 with SMTP id d24-20020ac25458000000b004eafabb4db1mr6418948lfn.1.1680161978106;
        Thu, 30 Mar 2023 00:39:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512219000b004d85895d7e0sm3956796lft.147.2023.03.30.00.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:39:37 -0700 (PDT)
Message-ID: <c999da90-1cb9-c767-23bc-c28d37708cf2@linaro.org>
Date:   Thu, 30 Mar 2023 09:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: sound: Add TDM for StarFive JH7110
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230329153320.31390-1-walker.chen@starfivetech.com>
 <20230329153320.31390-2-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329153320.31390-2-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 17:33, Walker Chen wrote:
> Add bindings to describe the TDM driver for the StarFive JH7110 SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/sound/starfive,jh7110-tdm.yaml   | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
> new file mode 100644
> index 000000000000..d65b9ed781ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/starfive,jh7110-tdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 TDM Controller
> +
> +description: |
> +  The TDM Controller is a Time Division Multiplexed audio interface
> +  integrated in StarFive JH7110 SoC, allowing up to 8 channels of
> +  audio over a serial interface. The TDM controller can operate both
> +  in master and slave mode.
> +
> +maintainers:
> +  - Walker Chen <walker.chen@starfivetech.com>
> +

Missing allOf: with $ref to dai-common.

> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7110-tdm
> +
> +  reg:
> +    maxItems: 1

(...)

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - dmas
> +  - dma-names
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tdm: tdm@10090000 {

Drop tdm label, not used.

Best regards,
Krzysztof

