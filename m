Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C863EEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiLALGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiLALFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:05:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B789AD992
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:05:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so1927067lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJ+12nfyyTkgnpRxkhSczeW684U0Z3MyPpVBPUH63N4=;
        b=Pq3N/E3XVx4A+B6KaT7zATRc1xex4JEnlIeXASyXQwFiVfrDUYfA3LvfpILF8VzKpV
         nLihd5WxJLL6XeWFqCxhGGtuZCFRsDFq2VYSgQQoWxwZBwtVCHzYqRoLEoVXfBE5pBvW
         iy0kgt5+lptF0dQuw5bvFrVMZVIc+yVF7MLcUz9u/FB7DpoGBFGXGnZQmGv8Exw9Tl83
         H6u0kpC0Bs0Vspxe2O4AedRQhUGkKY4fq6F50gee2r/bUQ7X0kWm4Fle8VZHS4vm8zpk
         B2cYeN9tDPwGNV/gmu3GFRSHSB1EyJo1s6WCJMPwx/MKKAiur1dFrSLa69D5fAL18pAu
         m6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ+12nfyyTkgnpRxkhSczeW684U0Z3MyPpVBPUH63N4=;
        b=uK5DWY1LbZuQMs6zxVlQFzdq3btL4rn3wOtw095VL4Xvlh2a9o41fcm27IO/YzQMpA
         j3jTpp9mWidO7KwANdWf9TWDfo9ye8/FCzkWmiR9SA7Ozkh9jtuky5RXQsppC3r3vggt
         PGf9V2fLMOJqgQkRanS1SnDXBCnzfA8odGWNObwEryxq4HNeujeUxlCdP7Zhr/WD1U9w
         K14USPLY8widMN8S2yz7FnF9BZIdiRCiSSEK4EWJldviNvKeyJsqJ+4r+Uldt+vtNJEc
         sLZOQCBBnVlyhae0rKzV4Ot5xbky2NEgRvFfhlTmmgTYZtwOSQKjdmkzh/ZsEIz3BuL6
         Klqg==
X-Gm-Message-State: ANoB5pl2lJfGeC7pq2GYm0HLJqEb9muOkUjxUF4+9d4ZKO7wf66EybW0
        nQt7ZlOwzw0d5E+b90yDPaebhA==
X-Google-Smtp-Source: AA0mqf5bNGiLehJjFTNkoSES7AUznPLQmpDmBmFmia/T8Abr14CJG2m8TfKNIbFLa5VW4x8mY6YbsQ==
X-Received: by 2002:a05:6512:258a:b0:4a2:27f0:46a5 with SMTP id bf10-20020a056512258a00b004a227f046a5mr18154806lfb.611.1669892706811;
        Thu, 01 Dec 2022 03:05:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b00492f0f66956sm611237lfb.284.2022.12.01.03.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:05:06 -0800 (PST)
Message-ID: <60991459-945f-35db-f26a-fb27824728ad@linaro.org>
Date:   Thu, 1 Dec 2022 12:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127132448.4034-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 14:24, Jisheng Zhang wrote:
> Several SoMs and boards are available that feature the Bouffalolab
> bl808 SoC. Document the compatible strings.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> new file mode 100644
> index 000000000000..91ca9dbdc798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalo Lab Technology SoC-based boards
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description:
> +  Bouffalo Lab Technology SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Sipeed M1s SoM:
> +        items:
> +          - const: sipeed,m1s
> +          - const: bouffalolab,bl808

I don't think that SoM is usable alone. It always needs a carrier, so
drop this entry.

Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).



Best regards,
Krzysztof

