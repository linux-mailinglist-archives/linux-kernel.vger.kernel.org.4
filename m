Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0923068B790
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBFImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjBFIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:45 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAED1D93E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:41:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j25so6059657wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VF3j3MRDdF8n8OyA+nQrmUxdMViUka5P0dDhKvF9Cs=;
        b=RZmvbBqJPu59NEcQKGTy+NuU00/pyxdiCciV3lY+ZJFkGWY6lOKgPO/3EBgdLcFsAs
         BJ2U0KiOrNWMTyU8NvdlStDETJowb2CVP0ZVeaVML1WknTuU+/NHEfxN/xRQZRINva9E
         EyBOnkYYlfkc1ZtjwD8QUmkV7YkZ5T6TMK3BnhVZe76K1R49T8YbUmvtx+lJ2vOMzkOr
         GiWbiuZGZhvnUsI0g0g4LjTXzQhH2HajjN/5ZZG7GqZy3QHa2SU0Kj5SKTBvuRYTsuIE
         zAXDGHc0E8cBDb5YtxEg4MIfQSZgVAHVdPol3O+QQz14huxaKG1/YvIBNVcOQmuzVemm
         yT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VF3j3MRDdF8n8OyA+nQrmUxdMViUka5P0dDhKvF9Cs=;
        b=ncDDCaZXxLWnQyHNC1QIrbh8dXh43hGMciUxgcg0dyyzVCd974CgGeagdyWiiFc2Ms
         4xVoqz4NZxbrS7QlVjjEFXgv4sEY54YK+EsIxh5Pda7U1ZvOElMkYa0oxLrsghK7PLel
         OT1VPlKtak/pvjf6W/b1nhrpzcYCo8zlDkczi/Jid2ZNOMDWArwx/NKU+Y8+bHbKSyxU
         W6Mt9j0Gx/6OuRaENSeTVyVNu3/3cTNzuCN6RqGQaaxItDfdoTn59vuU+pWf/T1otWL5
         CHC567SF3W+3Fen4i2WjARBCEIrVxIUaKkisC4jL2kgDgSRN30nHyrp9q48FJ3/zLxXf
         gW7Q==
X-Gm-Message-State: AO0yUKWQ2NjxWT0xkm0Y0jr+9uIwmhGJ57ejl06LyUBdfKZvH7xt93Ar
        kYK0IAiJo1TvV5enGYDy2W/7Dw==
X-Google-Smtp-Source: AK7set+LmJWRqmstWTgtfJr2oiq1AohLOY1rh7Fjr5hdugHUF6tO0yD4dWs5rOvm8gyGxzUBtmE5nw==
X-Received: by 2002:a5d:66cc:0:b0:2c3:dafd:c729 with SMTP id k12-20020a5d66cc000000b002c3dafdc729mr8449746wrw.47.1675672894408;
        Mon, 06 Feb 2023 00:41:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6085000000b0029100e8dedasm8198595wrt.28.2023.02.06.00.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 00:41:34 -0800 (PST)
Message-ID: <177cbf68-4e13-dabe-f14c-17a36c201e26@linaro.org>
Date:   Mon, 6 Feb 2023 09:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/3] dt-bindings: intel,ixp4xx-expansion-bus: split out
 peripheral properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
 <20230127093217.60818-2-krzysztof.kozlowski@linaro.org>
 <20230130191215.GA3125737-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130191215.GA3125737-robh@kernel.org>
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

On 30/01/2023 20:12, Rob Herring wrote:
> On Fri, Jan 27, 2023 at 10:32:15AM +0100, Krzysztof Kozlowski wrote:
>> The properties of devices in IXP4xx expansion bus need to be also
>> applied to actual devices' bindings.  Prepare for this by splitting them
>> to separate intel,ixp4xx-expansion-peripheral-props binding, just like
>> other memory-controller peripheral properties.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  ...intel,ixp4xx-expansion-bus-controller.yaml | 64 +--------------
>>  ...tel,ixp4xx-expansion-peripheral-props.yaml | 80 +++++++++++++++++++
> 
> Kind of odd to have these in 2 directories. Can we move 
> intel,ixp4xx-expansion-bus-controller.yaml to 
> bindings/memory-controllers/?

Indeed mostly we kept them so far in memory-controllers. Some of these
buses are used for attaching some type of memory, but I don't know if
ixp4xx can work like this.

> 
> Or maybe all the external/parallel bus interfaces need their own 
> directory?

Except the IXP4xx, I wouldn't know which one goes where... Example is
exynos-srom which can work with memory (SRAM, ROM, flash) or devices.

I'll move it to memory-controllers.


> 
>>  .../mc-peripheral-props.yaml                  |  1 +
>>  3 files changed, 82 insertions(+), 63 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml b/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml
>> index 5fb4e7bfa4da..a771796ec499 100644
>> --- a/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml
>> +++ b/Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.yaml
>> @@ -56,69 +56,7 @@ patternProperties:
>>      description: Devices attached to chip selects are represented as
>>        subnodes.
>>      type: object
>> -
>> -    properties:
>> -      intel,ixp4xx-eb-t1:
>> -        description: Address timing, extend address phase with n cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        maximum: 3
>> -
>> -      intel,ixp4xx-eb-t2:
>> -        description: Setup chip select timing, extend setup phase with n cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        maximum: 3
>> -
>> -      intel,ixp4xx-eb-t3:
>> -        description: Strobe timing, extend strobe phase with n cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        maximum: 15
>> -
>> -      intel,ixp4xx-eb-t4:
>> -        description: Hold timing, extend hold phase with n cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        maximum: 3
>> -
>> -      intel,ixp4xx-eb-t5:
>> -        description: Recovery timing, extend recovery phase with n cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        maximum: 15
>> -
>> -      intel,ixp4xx-eb-cycle-type:
>> -        description: The type of cycles to use on the expansion bus for this
>> -          chip select. 0 = Intel cycles, 1 = Motorola cycles, 2 = HPI cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1, 2]
>> -
>> -      intel,ixp4xx-eb-byte-access-on-halfword:
>> -        description: Allow byte read access on half word devices.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1]
>> -
>> -      intel,ixp4xx-eb-hpi-hrdy-pol-high:
>> -        description: Set HPI HRDY polarity to active high when using HPI.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1]
>> -
>> -      intel,ixp4xx-eb-mux-address-and-data:
>> -        description: Multiplex address and data on the data bus.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1]
>> -
>> -      intel,ixp4xx-eb-ahb-split-transfers:
>> -        description: Enable AHB split transfers.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1]
>> -
>> -      intel,ixp4xx-eb-write-enable:
>> -        description: Enable write cycles.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1]
>> -
>> -      intel,ixp4xx-eb-byte-access:
>> -        description: Expansion bus uses only 8 bits. The default is to use
>> -          16 bits.
>> -        $ref: /schemas/types.yaml#/definitions/uint32
>> -        enum: [0, 1]
>> +    $ref: /schemas/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml#
>>  
>>  required:
>>    - compatible
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml b/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
>> new file mode 100644
>> index 000000000000..8f782c80e88b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Peripheral properties for Intel IXP4xx Expansion Bus
>> +
>> +description: |
> 
> Don't need '|'.

Right.


Best regards,
Krzysztof

