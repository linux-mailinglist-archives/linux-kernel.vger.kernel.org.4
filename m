Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13826B651B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCLKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCLKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:52:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB284C6D4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:52:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn21so7603224edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678618366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=900txtAGvWx9ztLyEjZvdDNUK0CxcxUZTDDXgC9Au6w=;
        b=imGN+RreuhMJyMiWZXtTpSUbiJNFwJzj7WGIKTLDcKt2Jo4IkBkC+H9FQme2lyOQGs
         HPJ0u+GOlH2fpnOl0aJOkBVlZMJ33YPlOyAWHk66CHl5UvLArNgm6+mK4OFa0YasW2PL
         SeIQTfJANrv8jFJfWLNMTrmkDwgFrZ5xneBdPcyEah52G/rRjB/hwze631eYaLzp69Gk
         gcBkd/li50Wx1+H+8NvcD7AwtQMovhclWGNDJz19fyZX/p0Ok0FyJXAfp9CkHdiZGuHI
         kFs3xLdOYvGigfXabJBcPB0bLB65S34H2pFQ+pXRhnOVCVGX/Octq/CoLhOiQMOB85aC
         CbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=900txtAGvWx9ztLyEjZvdDNUK0CxcxUZTDDXgC9Au6w=;
        b=RHKsmV7/sMN06xR5/+8oNDVXyYnjWNaPqwQx5vn2BSjl0blICBStoV5NE5+DxWWPrr
         RhodKxr8rRsfl44oIvUmi+pqEai7dU0rKELv6MfHJwtjR3O+Or7PARXOnVhjJOqVEHun
         A0O6/OMUzn9C4oHsAdEt32O1vkjlOovQVSUJhk8ra2oaUMmeOIkkZaRfAlEm3srCMEmX
         BLwCi46on5EjvbI5CsX1MSo1Yx8hHN3vBvS7Sl2F4kbLr/GsguaLTZTUtV3mteYsgThn
         +ystrdFkmLmWG3+BLF3U4CSx81mXy8LBh+vnlYG4Y6fGngAbdYsxTzp2QWGELf9evMyA
         2pBA==
X-Gm-Message-State: AO0yUKUZp1M6qghUSi1YnEN67hGyMCFjbvv5EP2gSO83qHsZn+bk1l/n
        oMLUYah/vCpW/aS0HeDQzBDskQ==
X-Google-Smtp-Source: AK7set8Cl50YNvkkPM5DP76bG9jwBHrwRy9KsxnOQ4CyZU0Kck9F72SYJrEJu0OOwnM/i28qA8zdtw==
X-Received: by 2002:a05:6402:204a:b0:4c1:d49:3ecc with SMTP id bc10-20020a056402204a00b004c10d493eccmr28765808edb.29.1678618365859;
        Sun, 12 Mar 2023 03:52:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id s2-20020a50ab02000000b004fa012332ecsm1849637edc.1.2023.03.12.03.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:52:45 -0700 (PDT)
Message-ID: <fa6bfc86-23a7-0a2c-8819-ca76d1086238@linaro.org>
Date:   Sun, 12 Mar 2023 11:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
Content-Language: en-US
To:     Vijaya Anand <sunrockers8@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>
References: <20230311200305.82087-1-sunrockers8@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311200305.82087-1-sunrockers8@gmail.com>
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

On 11/03/2023 21:03, Vijaya Anand wrote:
> Convert the binding document for adi,adau17x1 from txt to yaml
> so one could validate dt-entries correctly and any future additions
> can go into yaml format. Add address and size cells to example to
> prevent errors regarding reg format.
> 
> Signed-off-by: Vijaya Anand <sunrockers8@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>

Thank you for your patch. There is something to discuss/improve.

> -Examples:
> -#include <dt-bindings/sound/adau17x1.h>
> -
> -	i2c_bus {
> -		adau1361@38 {
> -			compatible = "adi,adau1761";
> -			reg = <0x38>;
> -
> -			clock-names = "mclk";
> -			clocks = <&audio_clock>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
> new file mode 100644
> index 000000000000..9c1dbf2b4e70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/adi,adau17x1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781

But what is this? Codec? Amplifier?

> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adau1361
> +      - adi,adau1461
> +      - adi,adau1761
> +      - adi,adau1961
> +      - adi,adau1381
> +      - adi,adau1781

Please put them in some order, e.g. alphabetical.

> +
> +  reg:
> +    maxItems: 1
> +    description: The i2c address. Value depends on the state of ADDR0 and ADDR1, as wired in hardware.

This exceeds 80 characters (see coding style).

> +
> +  clock-names:
> +    const: mclk
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      phandle + clock-specifiers for the clock that provides the audio master
> +      clock for the device.

Drop "phandle + clock-specifiers for the " and make it simpler, just
items with description:

clocks
  items:
    - description: .......


> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

Instead:
additionalProperties: false
Unless you plan to reference dai-common or component-common

> +
> +examples:
> +  - |
> +    i2c_bus {

i2c

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      adau1361@38 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "adi,adau1761";
> +        reg = <0x38>;
> +        clock-names = "mclk";
> +        clocks = <&audio_clock>;


Best regards,
Krzysztof

