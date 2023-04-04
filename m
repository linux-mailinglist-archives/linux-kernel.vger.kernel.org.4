Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFF6D583E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjDDFxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjDDFxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:53:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBE1713
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:53:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so126036239edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680587611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDhm3Zq/DJyn20hY8TZXvxgMSSMPEv2OA+QJtyPqhrM=;
        b=zh60/umTASJLQ7Vw43N6uG6FzSDLBJMnQ+6ytuI5OPq8zXuiTkWHdbIZB1+DeKlzRw
         2sit+JWZPHDMkasaFHM8oy98/RIMNlh8WH286MIxfFydaDCOzJg+Mt+pIJcG3xMGHkyv
         Z2n194ZGN034tuvnMGfGMb+oX4xYxP7YNySxp5e2NpDUoDvW7vhF7p51WSO/dwFBajr5
         M4vM20hDS2CHgOwmi3NWWVZWwBRpSkCSJlja69h8q45TZgaTH7AV1DWQEL6SNACSUSRR
         /PmzulJMQKqBQ00KX/zR3Eb23Z3lSecT3qPVs+kVHVO30Et/dBd5KBbz7RnKfa/yKvU2
         0x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDhm3Zq/DJyn20hY8TZXvxgMSSMPEv2OA+QJtyPqhrM=;
        b=6m/DBdLul3H5sQPpT2wPMF6trCue07aeyuKaxeMGWVMyxzFbqqJp1eZIrjuma9tkRq
         DoTW2IKUjapt6w9IHT8/2jwLiW6ZyeFwRzR8WNOXLazsiXFcUR+pk/uwF13hFcqTYPV9
         Wfq4Knk++oBj+DoO7Lae54eYhAEX4BLdy6jIiB6Cw3p1N/wOTpgNk2Jn5EmXrYRl2+LG
         g5ZGd76svQRWwtK8LmugDSoFmbe5ZCGvJyJGobipmQ2t9lFRc5GsBZO2XKFv5FIvK4m6
         7BVvY0TongUusRoK6kHPSCuwmmjz5jkDDuRowHEDNhHxZ2R+ZNZOQDqrjkrsHOeFWujB
         lZ+Q==
X-Gm-Message-State: AAQBX9fT427HbWQr9Wty07GVM79sxqVISmrZXD+b1+2Sx2YC4KzjJ2T1
        xQTxC79lcydayETcESwQ8hAtvA==
X-Google-Smtp-Source: AKy350ZwxV0C9mQSifOjEwOI+5r+97ktvx6VlWix/9CLGGIoibJQI8YkHkMNqL1LpIbi/wkgfZX4hg==
X-Received: by 2002:a17:906:cc99:b0:931:ad32:79ed with SMTP id oq25-20020a170906cc9900b00931ad3279edmr1025043ejb.12.1680587611134;
        Mon, 03 Apr 2023 22:53:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906a20200b009323f08827dsm5556644ejy.13.2023.04.03.22.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 22:53:30 -0700 (PDT)
Message-ID: <0cc92eb2-7b58-9d74-cf59-09361665e6a8@linaro.org>
Date:   Tue, 4 Apr 2023 07:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] watchdog: dt-bindings: armada-37xx-wdt: convert text
 binding
Content-Language: en-US
To:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230404054449.5665-1-otabeknazrullaev1998@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404054449.5665-1-otabeknazrullaev1998@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 07:44, Otabek Nazrullaev wrote:
> Convert Armada 37xx watchdog timer controller to YAML format
> 
> Signed-off-by: Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
> ---
>  .../bindings/watchdog/armada-37xx-wdt.txt     | 23 --------
>  .../bindings/watchdog/armada-37xx-wdt.yaml    | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> deleted file mode 100644
> index a8d00c31a1d8..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -* Armada 37xx CPU Watchdog Timer Controller
> -
> -Required properties:
> -- compatible : must be "marvell,armada-3700-wdt"
> -- reg : base physical address of the controller and length of memory mapped
> -	region.
> -- clocks : the clock feeding the watchdog timer. See clock-bindings.txt
> -- marvell,system-controller : reference to syscon node for the CPU Miscellaneous
> -	Registers
> -
> -Example:
> -
> -	cpu_misc: system-controller@d000 {
> -		compatible = "marvell,armada-3700-cpu-misc", "syscon";
> -		reg = <0xd000 0x1000>;
> -	};
> -
> -	wdt: watchdog@8300 {
> -		compatible = "marvell,armada-3700-wdt";
> -		reg = <0x8300 0x40>;
> -		marvell,system-controller = <&cpu_misc>;
> -		clocks = <&xtalclk>;
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml
> new file mode 100644
> index 000000000000..e9bdae720bed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/watchdog/armada-37xx-wdt.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes.

> +
> +maintainers:
> +  - Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
> +
> +title: Armada 37xx CPU Watchdog Timer Controller
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"

Drop quotes.

On which tree you based this? Always start from the most recent next.

> +
> +properties:
> +  compatible:
> +    const: marvell,armada-3700-wdt
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      base physical address of the controller and length of memory mapped
> +      region.

Drop description.

> +
> +  clocks:
> +    maxItems: 1
> +    description: the clock feeding the watchdog timer.
> +
> +  marvell,system-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      reference to syscon node for the CPU Miscellaneous Registers
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - marvell,system-controller
> +
> +additionalProperties: false

This should be unevaluatedProperties: false.

> +
> +examples:
> +  - |
> +    cpu_misc: system-controller@d000 {
> +      compatible = "marvell,armada-3700-cpu-misc", "syscon";
> +      reg = <0xd000 0x1000>;
> +    };

Drop this node.


Best regards,
Krzysztof

