Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CFF698F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBPJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjBPJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:12:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357D42BFC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:12:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id fj20so1872558edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8xTaSVWV8eCcA3aGYZTtzHQygaT6P6tleF9HZfYaVg=;
        b=dE/QylYHy5/d+CtAyaD0GfhSEd/r4N9dWV2ka4PTSahYakJz1OOeGqyBUu1Sk4yXEP
         nlaR4zg2QYHUrZcreq3MQ5zC3zPDhLpWxoqMeRQpLIxi2Sui6ue2gv2G/MChJveAMBVb
         Nbf7v83FDvUoN0LUp41sk2r8jlVJeHkl9ZIYh8IxUMnt4ovKEWvfiCqFwWTnJbT3O9PW
         u8jsPZOF+UEIbpgfSy8muk/JSShBHPXTXxqytVY7uWMywFcGdqBfr7JLkpZSWuDT0bji
         3Y2QJL5bGeZVI3eJhYt202NRDZGrwuPaE6di9N/zXMONonRl88Cjw6hJ2IAElR5wb1qm
         wyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8xTaSVWV8eCcA3aGYZTtzHQygaT6P6tleF9HZfYaVg=;
        b=7y/BZ/rIJsqm7gVrf/29qLRaMkqbE66GldYXP86MR8Jw78pVeJ+pel3Bs0hz4RGji/
         zp9NAPtT7ZpvXVlfqr+XNTh4fFir75AP7yA57ASGtHUfCXFKaC9/RasEG6EIE2u0ciP6
         W0MsWXN8E6z5NNVo58nDtqjMlEIdVkH3arCSQ20v5kRDOhIRisMHE+zzD25+aG0KrO75
         4f/Vswdw96X1C+Wm4Nm1jotIjOktEyuBquKU79Go1NcEVmIGR8Xfx2PgLqrlky/nLt0q
         TzXRjQL6UohDLBE+PfxnQVimaasP1h0wIn8ftv+L2Z2rtGno2vly/PuUTRWivGgHzvjS
         R7uw==
X-Gm-Message-State: AO0yUKX4lPncTwCVkzqD4v4CRYCUBuEo69EADtEWC3lyg5YcKCP78g54
        wCLB04ySeWu/vuN47FB7YDzyhw==
X-Google-Smtp-Source: AK7set8kMK8vzlUIrZY76WpBhXiwWpWpNnBam4ADmn49dwO8Wg9z5RT7JiA1OUaJ8X6cNOiBTcHsJw==
X-Received: by 2002:aa7:c497:0:b0:4aa:a8e7:c04c with SMTP id m23-20020aa7c497000000b004aaa8e7c04cmr5680600edq.21.1676538737890;
        Thu, 16 Feb 2023 01:12:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a25-20020a509b59000000b004acbda55f6bsm536899edj.27.2023.02.16.01.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:12:17 -0800 (PST)
Message-ID: <9c1f4d0e-83c9-014e-bdb1-38b4b0fb2bbf@linaro.org>
Date:   Thu, 16 Feb 2023 10:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5739
Content-Language: en-US
To:     cy_huang@richtek.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lgirdwood@gmail.com, u0084500@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
 <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
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

On 15/02/2023 03:00, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the binding document for Richtek RT5739.

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/regulator/richtek,rt5739.yaml         | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
> new file mode 100644
> index 00000000..7dc4f78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt5739.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5739 2.4MHz 3.5A Step-Down Converter
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT5739 is a step-down switching voltage regulator that delivers a
> +  digitally programmable output from an input voltage supply of 2.5V to 5.5V.
> +  The output voltage is programmed through an I2C interface capable of
> +  operating up to 3.4MHz.
> +
> +  Using a proprietary architecture with synchronous rectification, the RT5739
> +  is capable of delivering 3.5A continuously at over 80% efficiency,
> +  maintaining that efficiency at load current as low as 10mA. The regulator
> +  operates at a normal fixed frequency of 2.4MHz, which reduces the value of
> +  the external components. 

Can we drop the marketing from kernel? Last part of sentence is not
related to this submission at all. The internal frequency also looks
unrelated to the topic...

> Additional output capacitance can be added to
> +  improve regulation during load transients without affecting stability.
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt5739
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  richtek,vsel-active-high:
> +    description: |
> +      If property is present, use the 'VSEL1' register group for buck control.
> +      Else, use the 'VSEL0' register group. This depends on external hardware
> +      'VSEL' pin connecton.
> +    type: boolean
> +
> +  regulator-allowed-modes:
> +    description: |
> +      buck allowed operating mode
> +        0: Auto PFM/PWM mode
> +        1: Forced PWM mode
> +    maxItems: 2
> +    items:
> +      enum: [0, 1]

So you always require two items? Thus I wonder what's the point of
having it in DT? To skip the property entirely if none of the modes are
allowed?


Best regards,
Krzysztof

