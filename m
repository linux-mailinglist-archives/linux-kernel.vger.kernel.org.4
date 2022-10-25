Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED460CDED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiJYNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJYNvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:51:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC910EA37
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:51:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z8so7508912qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+mqcVWm0AEyKqwn45YWNhbq4qASPXjQGGnK5kO9ut8=;
        b=mzhWGerQaeCo4oCs74RRj4EDEWH3Qi0wScKcihS+5XDNPf20ELttCNdk3a5BfIE7XK
         y8t6BZ7IpDLUbPM15WX4Ed/oTH2NoYlxoiiNSk5dbL1IAQRZ5SjROpKtnxZhC5Kaazqj
         xo+DfKeYMwa1b5hDZ+h1JteKAKnPWrpe98PysrLzhgRgnSs7W2BgLx0Jr+W/LOqqfSd2
         zh+ZQIj1FzJqLdapKqAdoF2QtuD4iCGxDJx7N7TT5S4A5Hwc3Vsi8KdW7RuYnNnp5RJG
         /1jcAItdUKYqPzRWMCz8iD33RIeXWX7f1QkddyNakXMp1S0ENxlRxkXnCkial2O2eNwb
         D0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+mqcVWm0AEyKqwn45YWNhbq4qASPXjQGGnK5kO9ut8=;
        b=YF1MXF1ceHzkdV6P1BxSON93P86uuHZ63dmPjSM+4Ebqi9fw/UTuSAPezuCN96lZig
         b7oXX3FfVK9LDU2q9t2Yamm6fjzCIrTeJxF8CEsSuQHdsThiZduK3feFIc9ZrdFK1Dd3
         66XpDrcmrFGIcjuvWyGeVckj+4AA0qrirN7K76XPzRbXM4nnN37hnfE7qdPcnpctQR61
         exi/9oUXLelOLNme9phGiZtDL2p3bqoVuHbmZY9vEsSr6P05uLe5tU33uqwMzITuJ3bM
         Lw/Kn6tII2P3r/eJ/lBUVARc71isIFw9/OaHeSSs3BpVD2q8hj1peSRnSBLkR/n32Os+
         cnWQ==
X-Gm-Message-State: ACrzQf1ZBtL+7hnbXTHPQfInM556d6bSUF9HNad006bPU+IjXd/AWgHt
        aehE4eZIfHVve6kEcYny4DKNjg==
X-Google-Smtp-Source: AMsMyM4tUcycY/M+2R0J1maIQysSHMIjRHyIp4wr18kHZbrqytMPiYlyexOAAb6mFRGhkKGaHJkrwA==
X-Received: by 2002:a05:622a:15:b0:39a:1fcd:3750 with SMTP id x21-20020a05622a001500b0039a1fcd3750mr30978428qtw.56.1666705877206;
        Tue, 25 Oct 2022 06:51:17 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d1-20020ac847c1000000b00398df095cf5sm1643683qtr.34.2022.10.25.06.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:51:16 -0700 (PDT)
Message-ID: <0950c52f-4b53-a823-a30b-c68bc73671e1@linaro.org>
Date:   Tue, 25 Oct 2022 09:51:14 -0400
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
 <a980821f-9177-8eb7-ee36-1b1e614d30fc@linaro.org>
 <VI1P190MB0317E39BD8D5531F94EB185C95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1P190MB0317E39BD8D5531F94EB185C95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
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

On 25/10/2022 08:52, Vadym Kochan wrote:
> On Tue, 25 Oct 2022 08:25:01 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 25/10/2022 06:17, Vadym Kochan wrote:
>>> Switch the DT binding to a YAML schema to enable the DT validation.
>>>
>>> Dropped deprecated compatibles and properties described in txt file.
>>>
>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>> ---
>>>
>>> v4:
>>>    1) Remove "label" and "partitions" properties
>>
>> I think you did not read the feedback.
>>
>>
>> (...)
>>
>>> +
>>> +  marvell,system-controller:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Syscon node that handles NAND controller related registers
>>> +
>>> +patternProperties:
>>> +  "^nand@[0-3]$":
>>> +    type: object
>>> +    properties:
>>> +      reg:
>>> +        minimum: 0
>>> +        maximum: 3
>>> +
>>> +      nand-rb:
>>> +        minimum: 0
>>> +        maximum: 1
>>> +
>>> +      nand-ecc-strength:
>>> +        enum: [1, 4, 8]
>>> +
>>> +      nand-on-flash-bbt: true
>>> +
>>> +      nand-ecc-mode: true
>>> +
>>> +      nand-ecc-algo:
>>> +        description: |
>>> +          This property is essentially useful when not using hardware ECC.
>>> +          Howerver, it may be added when using hardware ECC for clarification
>>> +          but will be ignored by the driver because ECC mode is chosen depending
>>> +          on the page size and the strength required by the NAND chip.
>>> +          This value may be overwritten with nand-ecc-strength property.
>>> +
>>> +      nand-ecc-step-size:
>>> +        description: |
>>> +          Marvell's NAND flash controller does use fixed strength
>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
>>> +          will shrink or grow in order to fit the required strength.
>>> +          Step sizes are not completely random for all and follow certain
>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
>>> +
>>> +      marvell,nand-keep-config:
>>> +        description: |
>>> +          Orders the driver not to take the timings from the core and
>>> +          leaving them completely untouched. Bootloader timings will then
>>> +          be used.
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +
>>> +      marvell,nand-enable-arbiter:
>>> +        description: |
>>> +          To enable the arbiter, all boards blindly used it,
>>> +          this bit was set by the bootloader for many boards and even if
>>> +          it is marked reserved in several datasheets, it might be needed to set
>>> +          it (otherwise it is harmless) so whether or not this property is set,
>>> +          the bit is selected by the driver.
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +        deprecated: true
>>> +
>>> +    required:
>>> +      - reg
>>> +      - nand-rb
>>
>> I have no clue why you are doing some random changes. Now you dropped
>> additionalProperties for nand@ about which no one asked you to drop.
>>
>> No. It *must* be here.
> 
> Sorry for this mess, I was confused with the "label" and "partitions"
> because I got errors about these properties when I used only
> "additionalProperties: false", so I tried to put reference to partition.yaml.
> 
> Then I looked at other nand-controllers schemas and I did not find inclusion of partition.yaml
> for them so I decided to just drop it at all. My understanding is that "additionalProperties:false"
> is needed for nand@ if to have "label" and "partitions" properties, otherwise it is not needed.

A final schema (not used by other schemas) must always finish with
additional/unevaluatedProperties false. You have errors since beginning
- I wrote about it in your first patchset (v1). You had error visible
after adding proper unevaluatedProperties in proper place.

You have partitions node, for partitions. But you reference only *one*
partition.

Best regards,
Krzysztof

