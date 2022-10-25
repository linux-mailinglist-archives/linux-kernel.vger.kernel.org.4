Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676760CBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJYMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiJYMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:25:07 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4649A9C9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:25:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z8so7338299qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRvNij7ZOIekp+J81NtM1ZKFkAXFSj+/+Qrfb79WT7o=;
        b=VoH0weBN/SoMr1M/mpxKzE/2RftN/KUPBJ8bTLo5sMZSu/nxHvLl7ZWGDyHo2+oDKP
         c6xRxDTGFpNlt0rBh8LlaY/GyI0bD2HFEp36CNMnB5RMJ/zu+/RGQSZfFvZLClVHhBVp
         Q1g3R7G9ZiGO6miRfFuFRlFveBd0ZEj7s0p3MKZYKEUZ+f4SKi9iuWrm+pPhe2s7QK+r
         fNjgS4Y9O6y2/ZLF9NVNh+NOaBkw220XrA3kGua/aHE5DS6AIKL0KOR3hWlk92AnayPA
         5Ldq03oCapJszTtAv2P+2GvHNOFMnti8liZFkCjsk3sqtt3p6eFbMjFBGdOFEjL65EbR
         anDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRvNij7ZOIekp+J81NtM1ZKFkAXFSj+/+Qrfb79WT7o=;
        b=H1Eov/GHDKjbvUAyWHGUXT2bECfXPf72/yy4rIIf5QQSnJj3mt2wSD10qSwz37djv2
         Au97cOeY3IPe2nAMcHWslRaJk3cdAok7jFjHhLD9798mH8Q8uokC2ZfO6xqGz77DvzJA
         4xZQ6tzialD4khNo9mPiCxr3VhDam2EkTvu9QMeAuOMIWhBJwluTtSUNesBiYN4JXw9W
         Ee0LtiBF5dkpsdqESBws67LacKSQkpujHKjpZDh6+IrrQZ642r/Kl3zK7qTw4kUPtsX6
         4Gy51ivhNt6lz5KCRgVYRPbdBbYhNX0+7TLezIPIjbrkD0r9Om/ikW4TMKRoIc5eZbOF
         SWfA==
X-Gm-Message-State: ACrzQf25KqNNjHV/G7zs9D+NPf6AY9OOykWsfVl6cXYYfX6861qMnihw
        RZGsGZszDCecU3tGC6giW5x3Kg==
X-Google-Smtp-Source: AMsMyM6txyZvLp+XIQgGwi6nnoaZ782KMl4c3wdGT5paqUoILle4KcYW+NMfUd+MT4R3iIbCSz4PIQ==
X-Received: by 2002:a05:622a:647:b0:39c:f902:0 with SMTP id a7-20020a05622a064700b0039cf9020000mr30072243qtb.277.1666700704433;
        Tue, 25 Oct 2022 05:25:04 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y9-20020a37f609000000b006b8e8c657ccsm1847920qkj.117.2022.10.25.05.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:25:03 -0700 (PDT)
Message-ID: <a980821f-9177-8eb7-ee36-1b1e614d30fc@linaro.org>
Date:   Tue, 25 Oct 2022 08:25:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221025101713.11893-1-vadym.kochan@plvision.eu>
 <20221025101713.11893-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025101713.11893-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 06:17, Vadym Kochan wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Dropped deprecated compatibles and properties described in txt file.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> 
> v4:
>    1) Remove "label" and "partitions" properties

I think you did not read the feedback.


(...)

> +
> +  marvell,system-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Syscon node that handles NAND controller related registers
> +
> +patternProperties:
> +  "^nand@[0-3]$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      nand-rb:
> +        minimum: 0
> +        maximum: 1
> +
> +      nand-ecc-strength:
> +        enum: [1, 4, 8]
> +
> +      nand-on-flash-bbt: true
> +
> +      nand-ecc-mode: true
> +
> +      nand-ecc-algo:
> +        description: |
> +          This property is essentially useful when not using hardware ECC.
> +          Howerver, it may be added when using hardware ECC for clarification
> +          but will be ignored by the driver because ECC mode is chosen depending
> +          on the page size and the strength required by the NAND chip.
> +          This value may be overwritten with nand-ecc-strength property.
> +
> +      nand-ecc-step-size:
> +        description: |
> +          Marvell's NAND flash controller does use fixed strength
> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
> +          will shrink or grow in order to fit the required strength.
> +          Step sizes are not completely random for all and follow certain
> +          patterns described in AN-379, "Marvell SoC NFC ECC".
> +
> +      marvell,nand-keep-config:
> +        description: |
> +          Orders the driver not to take the timings from the core and
> +          leaving them completely untouched. Bootloader timings will then
> +          be used.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      marvell,nand-enable-arbiter:
> +        description: |
> +          To enable the arbiter, all boards blindly used it,
> +          this bit was set by the bootloader for many boards and even if
> +          it is marked reserved in several datasheets, it might be needed to set
> +          it (otherwise it is harmless) so whether or not this property is set,
> +          the bit is selected by the driver.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        deprecated: true
> +
> +    required:
> +      - reg
> +      - nand-rb

I have no clue why you are doing some random changes. Now you dropped
additionalProperties for nand@ about which no one asked you to drop.

No. It *must* be here.

Best regards,
Krzysztof

