Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6C656B35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiL0NFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiL0NFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:05:09 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E66556
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:05:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f20so13688078lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ypp52Jl9epzjpr9pbWfQ6VvmlV2hnbQoOTkfbsiQ3I=;
        b=EoNAUxYY+zmf6Wsj+ariOLgHS1aIkJtMZ+xZEJof9u7wv2KLNKBzovaDAMLreyJZyh
         OOJADUWiItyv6TmJAgTkq8vDrIlqrjfuDNu56QgaQBw8A/Ca3poWSX1V7dHZilcoWbqs
         54IqPXsQ/+L8WbJcxsya75oBY4sE2o+b9vBIIbe8ysPikDoVO5qgllgUjCdTCHv6n7c8
         jdF/TO1DEoPRJqDBiN4dBKchNXRo6CqkS9lZwhZ+UaeKqKrHQ/bc6YBsYSUX0kpeMlVn
         VdJ5+GchDmVmXS0JkYY+6mUuFyZBW7pmrDlN8pC7dxyHYnw1CPEwJIGj8tFhWVtS1z0F
         LhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ypp52Jl9epzjpr9pbWfQ6VvmlV2hnbQoOTkfbsiQ3I=;
        b=hg02EV1kmV7G1cpTixXHs2wFEYuCjzYperELoBO89z4X/SZBVlMOLNWJWgQQywM/tK
         yb1VR4kbQhtdzE+5CQls3kFWUd+aVtVcwZ+6lBn2E7BfG6urNKFdkptOngcl99KbcM09
         P2p5YkU81f7lRQk5jYQ19rAVaZJac1ui+RjoLE/j4bDOTcfrOGasRFblyXFF3oNhWrnl
         2ryejluH1vgVwE9nx+vdDpEriYpILBz4kT0fZnuaLFsSMXziVMgafRI+6IdHs4EBZC++
         Uwki6cyGSWgXBgqOLMe27T8vwI/7VxpM0Dskil7OX+bXkD5vToJ/RdRN27h4wPeJT3oU
         7KOA==
X-Gm-Message-State: AFqh2ko+EPC1g0fJ1tWYct+gBjJaG92kz3Z5JoJeVR9hY5megG6hapXo
        W5b0Ys5S+zUJUTPf48DBhHaKWA==
X-Google-Smtp-Source: AMrXdXsrcaAyC6pf/voNWRFUuNfp7Hu/TWeVnY47/GLGkCGxBbKiCOmVDwvsMujUhs8TkrotZIovWg==
X-Received: by 2002:a2e:92cf:0:b0:27f:a604:22b8 with SMTP id k15-20020a2e92cf000000b0027fa60422b8mr4544273ljh.40.1672146306070;
        Tue, 27 Dec 2022 05:05:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u9-20020ac258c9000000b004bb8a796a6bsm2244389lfo.66.2022.12.27.05.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 05:05:05 -0800 (PST)
Message-ID: <fc5866ef-4eea-bc15-7cbe-d2e00c37e282@linaro.org>
Date:   Tue, 27 Dec 2022 14:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: Add bindings for StarFive
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221227122227.460921-2-william.qiu@starfivetech.com>
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

On 27/12/2022 13:22, William Qiu wrote:
> Add documentation to describe StarFive
> designware mobile storage host controller driver.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

The subject is a bit redundant and not precise. No need to mention
"bindings" twice but "StarFive" is really too generic. Do you add now
all possible devices from StarFive? I see only one. Rephrase (use git
log to find examples).

> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> new file mode 100644
> index 000000000000..430dd5f24933
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/starfive,jh7110-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Designware Mobile Storage Host Controller
> +
> +description:
> +  StarFive uses the Synopsys designware mobile storage host controller
> +  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: biu clock
> +      - description: ciu clock
> +
> +  clock-names:
> +    items:
> +      - const: biu
> +      - const: ciu
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  starfive,syscon:

Name is not specific enough. What is syscon? Any syscon? This needs to
be specific.

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      arg0:arg0 is syscon.

What is syscon?

> +      arg1:arg1 is syscon register offset, used to enable MMC function.

Describe the argument, not what it is used for, e.g. "offset of XXX YYY ZZZ"

> +      arg2:arg2 is used to enable the register shift of the MMC function.
> +      arg3:arg3 is used to enable the register mask of the MMC function.

That's not how the phandle array is described. Instead:

https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42



Best regards,
Krzysztof

