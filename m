Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC0639C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiK0SB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0SBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 13:01:53 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EEB2656;
        Sun, 27 Nov 2022 10:01:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F325532005BC;
        Sun, 27 Nov 2022 13:01:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 27 Nov 2022 13:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669572108; x=
        1669658508; bh=/S8xgN1TqDhST2WRf1W/rFD7HHYhr22aZHBwksUlEbQ=; b=C
        xbMrL5UPdgRpk+w+VKjmn3yb1Git5FXiGMrkEU6y0HFwrv/MxnFidJkzoypah3Ce
        b7wIvaMTys4yRnhuzFiKP/2U/bfxbwbcPAtWy/EVRkBCyslI8jn5PCRkN/EL6HNU
        lVS9ZLkfdgTtIPGAwTnvHUfHvjut3UZARctmEmxLIfSYC8yjNq4WPZuXIH2V24zS
        6BpxnBDF72n7QB1tp6d5vjE4DbCOX9ebjHhAlH9pputIdE6zKv2TpEdBKQuVbf6D
        0q0NrteFGbmik96XqvDgE7QE2VL7CMlIBH3vKhRFZcAbENP3lysmoJqD8AI5sMDi
        ggqGgERjyaRfJCDB5zPig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669572108; x=
        1669658508; bh=/S8xgN1TqDhST2WRf1W/rFD7HHYhr22aZHBwksUlEbQ=; b=f
        LQy8J/EddQ81AylhUKYRHohUR9NVjNfUqSllgBUqpT6d/GKFnKid05C8VD41MC6U
        rTivicwc3OIbGjr8Hpo1SyeekoWGefs44baUdQz05KeX1H7KW8AtTYxa+VwebIiP
        gzcjFhP3A+tFC7lYnSWNI13FuRdy9HY3IRqQ98ghwrluMnhDAg6VlxdxIGLvyFJR
        nxpLVJR8qemZbUzcUs7z96DTPu7Dt2fu0cPUCjN94p6BtOHakQGHPNaRYMkrR7uO
        XlJMAj1PJC9jj5vx/csm8xCJfnSP8BKeblvaO5oFbeK/KlyVbHf8R+Vntv3LTS8E
        bw4qFeYs22oiWKKEPzGHg==
X-ME-Sender: <xms:C6aDY2DkbQvatQBmm83JvESkYUkSTJl4HxJ-kDLENKoIqSpmnHR7Pw>
    <xme:C6aDYwiZbqmrPJVc_n_9U5Zi27GIyGRg-cnOt3xjZIv484kXJlQ9oFT81ZvBzhSZn
    3CIr1eo11tzzS--bw>
X-ME-Received: <xmr:C6aDY5mwVHxIAu1aPd42y3H7YQUlwu0xSB4jniCtIu_44QoQgRlz4RynGVrxOQXc5p8wicUoltqsn_2qR5M31DfcZFdPrLnb-Hk_5EyPA3hm8scrFzyEzbdJBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegteekvefhgefhgfeigeejffejvdeihedvfefgtedvjeeiudet
    teeihfffgfeugfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehs
    hhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:DKaDY0wTqMaMWa2epKUnN1uwLfTMppA5b9lFPgiKxU3_cwGS3g9qzA>
    <xmx:DKaDY7RDOoUWeDfpqZ2x9fMGc8_2at52JPpoT5oMRt2Fxnucia0SSg>
    <xmx:DKaDY_YneRVbm9it-gqiwpnxW8Yxo_SBRhmOI0iDX41ehbI0CRwiFA>
    <xmx:DKaDY6EhnemRf9VZ2CqTZS-qN3bq-AgA4iq0mqIPHuMyZa6Lthmo3A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Nov 2022 13:01:47 -0500 (EST)
Message-ID: <b68807e9-3907-9f9a-8eee-b7f24be3c78f@sholland.org>
Date:   Sun, 27 Nov 2022 12:01:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125220903.8632-1-samuel@sholland.org>
 <e4be94a3-cdfc-cdf8-5d69-0eef480033f9@linaro.org>
 <20221127174219.34d0406c@jic23-huawei>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
In-Reply-To: <20221127174219.34d0406c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 11:42, Jonathan Cameron wrote:
> On Sun, 27 Nov 2022 13:51:19 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 25/11/2022 23:09, Samuel Holland wrote:
>>> Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
>>> the compatible strings were undocumented. Add a binding for them. The
>>> hardware has an alert interrupt output, but existing ti,adc081c users
>>> do not provide the 'interrupts' property, so leave it as optional.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>>  .../bindings/iio/adc/ti,adc081c.yaml          | 55 +++++++++++++++++++
>>>  1 file changed, 55 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>> new file mode 100644
>>> index 000000000000..caaad777580c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>> @@ -0,0 +1,55 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/ti,adc081c.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI Single-channel I2C ADCs
>>> +
>>> +maintainers:
>>> +  - Jonathan Cameron <jic23@kernel.org>
>>> +  - Lars-Peter Clausen <lars@metafoo.de>
>>> +
>>> +description: |
>>> +  Single-channel ADC supporting 8, 10, or 12-bit samples and high/low alerts.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,adc081c
>>> +      - ti,adc101c
>>> +      - ti,adc121c
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  vref-supply:
>>> +    description:
>>> +      Regulator for the combined power supply and voltage reference
>>> +
>>> +  "#io-channel-cells":
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg  
>>
>> Why not requiring io-channel-cells? If it is an IIO ADC provider, you
>> need the cells, right?
> 
> Only if anyone is using it as a provider.  If it's purely being used via
> IIO then there are no consumers registered.
> 
> So historically I've left it up to those defining the binding to decide if
> they think #io-channel-cells should be required or optional.
> 
> It gets a bit non obvious with some of the more complex special ADCs on whether
> they will ever be consumed.  This one is generic, so quite likely it will be.

I kept #io-channel-cells optional because there are already a handful of
boards using ti,adc081c without it.

On the board I am adding (Clockwork DevTerm), the ADC is used a
temperature sensor for a thermal printer. So whether or not the ADC is
used as an OF provider depends on how the printer driver gets implemented.

Regards,
Samuel

