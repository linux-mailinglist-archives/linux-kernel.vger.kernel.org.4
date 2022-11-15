Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453A629C12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKOO0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiKOO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:26:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905A2C64A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:26:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so24598625lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRh5aMVcKhERES1ONTqHwjcTV3lsnsm7B9arRoDIzwg=;
        b=DjbAMkTvi7XSmsMtHXkX+GA+YmTTsy0zB9gSrA+0UZqcwdniK+dARLL5vbJnMqz65N
         MXnbWwvaGFevhUCJAJvG/ItgyqUqz9FOd/qIuJuVSA/gw1QrrKW2wno4bB/4A5PKf8yC
         o3PJhxSKSlHZYc2eN9gvnSPXNKICm9MeLKVoJkQJOx/kSGnGlV+mGPxaHAtQotNtxeDm
         NZArgDB3LLgkZkyj2YUK5j+MjUEaouSJfw4MBCd8ZIAlgLaqZmdzlvU49jI3HREJNXmK
         Y0ex2Hwrr84xHYiIpE5oRs3lcaq8jKwCTe3VBi8KvvYdXsPq/jlA8JU6yRFcDkTLm12i
         /hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRh5aMVcKhERES1ONTqHwjcTV3lsnsm7B9arRoDIzwg=;
        b=NWkL2rN6ymB8PdCpMaaIpYtAv8SvgR5KA2O3A70k2A64Vo+7nusCK0jRweAjEBtdGs
         BfKvv0sMePaBrsDMxljI6hygFsEhVzwE6YM7bUCIO0NAumwhVxiCUqw+h7JrhednO6mN
         uua1O0l5xunAECLXOAlegVjC1q0tDeV+Q2zZRDd609L23sRlZ2EmgTc3TjrrYCxodwoo
         Uv89vthNGV5CynXqegzJW6JiJwvU/BCbWX+++TI7Ef246hJVIP/BGbb9chZD9bzFyEwY
         DR3k3hpkfkTGnHrOoOCzyfhRkx1s/VNjG8zjRJXr+3M9ZQ8+T+xUNpCXpV4/vjeqN/I6
         YJ/Q==
X-Gm-Message-State: ANoB5pktBRmEfR/2P14xUWsTmHZm5UnJZz4pxSJnWmt9fb6rtD445GMi
        WHOyHGg4ISiEqRaaiRJQc2hBgg==
X-Google-Smtp-Source: AA0mqf6xyTSdvIGlDY8pOSsCVEj97KZz0oQHmB+lhcNQ27kEuxY3WCJuO8UtXG9mqsufvthMcLH3sw==
X-Received: by 2002:a19:5515:0:b0:4b1:82c6:295b with SMTP id n21-20020a195515000000b004b182c6295bmr5328743lfe.67.1668522373845;
        Tue, 15 Nov 2022 06:26:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b00494603953b6sm2228200lfr.6.2022.11.15.06.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:26:13 -0800 (PST)
Message-ID: <0b4d2bc0-0f45-4bff-dee9-825efa5b5a2e@linaro.org>
Date:   Tue, 15 Nov 2022 15:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
References: <20221111224651.577729-1-vladimir.oltean@nxp.com>
 <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
 <20221115135912.ksjk7zxqsyazqhtf@skbuf>
 <c9b82051-a9f5-883f-5455-1cb06aa6521b@linaro.org>
 <20221115141904.26lyetiforkgoqaf@skbuf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115141904.26lyetiforkgoqaf@skbuf>
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

On 15/11/2022 15:19, Vladimir Oltean wrote:
> On Tue, Nov 15, 2022 at 03:08:37PM +0100, Krzysztof Kozlowski wrote:
>> On 15/11/2022 14:59, Vladimir Oltean wrote:
>>> On Tue, Nov 15, 2022 at 02:46:21PM +0100, Krzysztof Kozlowski wrote:
>>>>> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml
>>>>
>>>> Why second "fsl" in file name? It does not patch compatibles and
>>>> duplicates the vendor. We do not have compatibles "nxp,imx6-nxp".
>>>
>>> Ok, which file name would be good then? There are 9 different (all SoC
>>> specific) compatible strings, surely the convention of naming the file
>>> after a compatible string has some limitations...
>>
>> If all DSPI blocks fit here, then maybe: fsl,dspi.yaml
>>
>> fsl,spi-dspi.yaml is also a bit redundant.
> 
> Ok, fsl,dspi.yaml and fsl,dspi-peripheral-props.yaml, and MAINTAINERS
> entry for fsl,dspi*.yaml?

Yes.

> 
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    description:
>>>>> +      Some integrations can have a single compatible string containing their
>>>>> +      SoC name (LS1012A, LS1021A, ...). Others require their SoC compatible
>>>>> +      string, plus a fallback compatible string (either on LS1021A or on
>>>>> +      LS2085A).
>>>>
>>>> Why? The fsl,ls1012a-dspi device is either compatible with
>>>> fsl,ls1021a-v1.0-dspi or not. It cannot be both - compatible and not
>>>> compatible.
>>>
>>> LS1012A is compatible with LS1021A to the extent that it works when
>>> treated like a LS1021A. LS1012A has a FIFO size of 8 SPI words, LS1021A
>>> of just 4. Treating it like LS1021A means roughly half the performance,
>>> but it still works.
>>>
>>> I didn't invent any of this. When I took over the driver, there were
>>> device trees like this all over the place:
>>>
>>> 		dspi: spi@2100000 {
>>> 			compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
>>
>> Which looks ok...
>>
>>> 			#address-cells = <1>;
>>> 			#size-cells = <0>;
>>> 			reg = <0x0 0x2100000 0x0 0x10000>;
>>> 			interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
>>> 			clock-names = "dspi";
>>> 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>>> 					    QORIQ_CLK_PLL_DIV(1)>;
>>> 			spi-num-chipselects = <5>;
>>> 			big-endian;
>>> 			status = "disabled";
>>> 		};
>>>
>>> but the Linux driver pre-~5.7 always relied on the fallback compatible
>>> string (LS1021A in this case). I'm working with what's out in the field,
>>> haven't changed a thing there.
>>
>> The driver matters less (except ABI), but anyway it confirms the case -
>> fallback is expected always.  Why the fallback should be removed if the
>> devices are compatible (including halved performance)?
> 
> I don't think I said the fallback should be removed? I think you're
> talking about a typo/braino I made, which puts the LS1012A both in the
> bucket of SoCs with a single compatible strings required, as well as in
> that with fallback required. Obviously both can't be true... I didn't
> mean LS1012A but VF610.

To be clear: ls1012a, ls1028a and lx2160a should be either followed by
compatible or not. Cannot be both.

Best regards,
Krzysztof

