Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677BD63D8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiK3PEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiK3PED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:04:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA0F63
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:04:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h10so4469217ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MH/xIL39UefZX1P950jEjmgMlLKkAkSQV+GV99jQEk=;
        b=Wu61ZnY2mnIScXdpJ1ckgMifDj8+Hw0dTYEwtj166q2eJfi3FCS9vg7uVGc+VfFu+J
         agUg9po/GbADwjLrSz1FB9/ALdrRLSvAlngfrwQV5bwZpsoUxGy/Urxt+jgmHsErguHv
         uNwc5Wr85E5U9KUBhro13k3xEzl6ejdhabEQwKVK9mfPunpBqI040hY/7liYSsvINezn
         Y2897cHXcgYEzKiSM1DrDKSkQaetSchO5b9vVcp4WVDmg9o82lEGvrpLXE1Qw1OJnqGC
         iMg3erW6Fb7U74VOnYlXLpg4rnLHt+x9lL2SbkvcWwXGqHDz6BsNw/WrpG4uEPM/3/FR
         qnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MH/xIL39UefZX1P950jEjmgMlLKkAkSQV+GV99jQEk=;
        b=cc5TFQJw86e+Jx+0oljVhtZlMsN7qbI3YoLnH5SbuVz26Wfqo39SyFs16kJ96esuYR
         MgLe6bzCMjzm0ATzp4GPeNbrLt5OxPWIPQw08AISkxMFhGPcPVu4vb/nyvV6pyCIcx5u
         NV5MpRT/F88odzmU0UHxAQexgTd9u+qzJKSqlZEGuJWYROuD2U8LD8qH+WuP63TQzJft
         2tK6EGEBhC4Cce8bLGAcDz7ASVsGWjzqtl3LMIGmbApvH7v1c7ZlQD+3cyTtJgqIT3sb
         EC7F3/nwwbvSFvmam8J33ubuijtVQblmpaWu9MaNo5E6zf+Eue1BcCQ5f2xz1Xo5geic
         fjdQ==
X-Gm-Message-State: ANoB5plWI8eLmG2viOHIi2qV9VbNx2qSVlUHP/CukNfEQ5/fkR/yYyNY
        qkm8cFPT3Csdbv7SA89oaJnuyw==
X-Google-Smtp-Source: AA0mqf5oBP6I+a4BRK5JuNH4t4XFn+zeh2TAVKMgTTo71M9V73ms7LplMdPcAaxcCceCy8gd6Q93KQ==
X-Received: by 2002:a2e:9941:0:b0:26d:fe34:6dc0 with SMTP id r1-20020a2e9941000000b0026dfe346dc0mr15280302ljj.477.1669820639025;
        Wed, 30 Nov 2022 07:03:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 3-20020a05651c008300b0026c35c4720esm157362ljq.24.2022.11.30.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:03:58 -0800 (PST)
Message-ID: <b4b608bf-e347-5500-eb94-bec3611f6a56@linaro.org>
Date:   Wed, 30 Nov 2022 16:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] Documentation: dt-bindings: k3-r5f-rproc: Add new
 compatible for AM62 SoC family
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hnagalla@ti.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, j-luthra@ti.com
References: <20221130134052.7513-1-devarsht@ti.com>
 <20221130134052.7513-2-devarsht@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130134052.7513-2-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 14:40, Devarsh Thakkar wrote:
> AM62 family of devices don't have a R5F cluster, instead
> they have single core DM R5F.
> Add new compatible string ti,am62-r5fss to support this scenario.
> 
> When this new compatible is used don't allow cluster-mode
> property usage in device-tree as this implies that there
> is no R5F cluster available and only single R5F core
> is present.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: Avoid acronyms, use "Device Manager" instead of "DM"

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 48 +++++++++++++------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> index fb9605f0655b..91357635025a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -21,6 +21,9 @@ description: |
>    called "Single-CPU" mode, where only Core0 is used, but with ability to use
>    Core1's TCMs as well.
>  
> +  AM62 SoC family support a single R5F core only which runs Device Manager
> +  firmware and can also be used as a remote processor with IPC communication.
> +
>    Each Dual-Core R5F sub-system is represented as a single DTS node
>    representing the cluster, with a pair of child DT nodes representing
>    the individual R5F cores. Each node has a number of required or optional
> @@ -28,6 +31,9 @@ description: |
>    the device management of the remote processor and to communicate with the
>    remote processor.
>  
> +  Since AM62 SoC family only support a single core, there is no cluster-mode
> +  property setting required for it.
> +
>  properties:
>    $nodename:
>      pattern: "^r5fss(@.*)?"
> @@ -38,6 +44,7 @@ properties:
>        - ti,j721e-r5fss
>        - ti,j7200-r5fss
>        - ti,am64-r5fss
> +      - ti,am62-r5fss

Some order? Alphabetical, so before am64? Same in other places.


>        - ti,j721s2-r5fss
>  
>    power-domains:
> @@ -80,7 +87,8 @@ patternProperties:
>        node representing a TI instantiation of the Arm Cortex R5F core. There
>        are some specific integration differences for the IP like the usage of
>        a Region Address Translator (RAT) for translating the larger SoC bus
> -      addresses into a 32-bit address space for the processor.
> +      addresses into a 32-bit address space for the processor. For AM62x,
> +      should only define one R5F child node as it has only one core available.
>  
>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>        internal memories split between two banks - TCMA and TCMB (further
> @@ -104,6 +112,7 @@ patternProperties:
>            - ti,j721e-r5f
>            - ti,j7200-r5f
>            - ti,am64-r5f
> +          - ti,am62-r5f
>            - ti,j721s2-r5f
>  
>        reg:
> @@ -207,20 +216,31 @@ patternProperties:
>        - firmware-name
>  
>      unevaluatedProperties: false

Blank line.

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am64-r5fss
> +    then:
> +      properties:
> +        ti,cluster-mode:
> +          enum: [0, 2]
> +
> +    else:
> +      properties:
> +        ti,cluster-mode:

It's not really valid anymore for ti,am62-r5fss, so this cannot be
simple "else".  Instead you need to list all compatibles.

> +          enum: [0, 1]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am62-r5fss
> +    then:
> +      properties:
> +        ti,cluster-mode: false
>  
> -if:
> -  properties:
> -    compatible:
> -      enum:
> -        - ti,am64-r5fss
> -then:
> -  properties:
> -    ti,cluster-mode:
> -      enum: [0, 2]
> -else:
> -  properties:
> -    ti,cluster-mode:
> -      enum: [0, 1]
>  
>  required:
>    - compatible

Best regards,
Krzysztof

