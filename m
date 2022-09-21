Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED135BFF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIUN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIUN64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:58:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216885F81;
        Wed, 21 Sep 2022 06:58:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 737D66602028;
        Wed, 21 Sep 2022 14:58:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663768732;
        bh=aNktZ6lpJ/y23RAV97OZGsJSTK5UAMeGZw4X2ENLfXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T3VNbt4RhdWVEG6k5a4izsy7xNSaxwmrgPuw+yNBQbmiV7LMdn2gGoozlgFPVs6Qk
         dDUh9Xz8y/e/k1HiSgJqOHrVmJkjbRlQw9nf9uN2qu/5YoIqexOOSlK5AYM8ievFJm
         +3iXSW4TDXCRmggad4XxjypL7iYgRTqqUtwc/rwpkPmG2xRHNi9Q1PbMutBCADmdAL
         ON4ncaLWMPlbSY9niPdU4O32AAkCWX8ca7NJxMHzrq3CSpYyRMoAXQCGN+TpuP+UyC
         FA9KUxfdqEdkpRgiN0MyMqy1FdBS/f8zun+0+Q6fo7dEIsO1PPJCHTjpn5bjE+dcpp
         xX1l6cjLk+Dpw==
Message-ID: <9234e731-8c2f-b599-39b1-bf5115a16931@collabora.com>
Date:   Wed, 21 Sep 2022 15:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: asurada: Add display regulators
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220908171153.670762-1-nfraprado@collabora.com>
 <20220908171153.670762-2-nfraprado@collabora.com>
 <ab2027b9-17e8-4fe8-3847-84c54d6f9d58@collabora.com>
 <20220921134806.lbg5meuy4fn6pifm@notapiano>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220921134806.lbg5meuy4fn6pifm@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/09/22 15:48, Nícolas F. R. A. Prado ha scritto:
> On Fri, Sep 09, 2022 at 09:46:33AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 08/09/22 19:11, Nícolas F. R. A. Prado ha scritto:
>>> Add the regulators present on the Asurada platform that are used to
>>> power the internal and external displays.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>
>>> ---
>>>
>>>    .../boot/dts/mediatek/mt8192-asurada.dtsi     | 114 ++++++++++++++++++
>>>    1 file changed, 114 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> index 4b314435f8fd..1d99e470ea1a 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>
>> ..snip..
>>
>>> @@ -56,6 +116,18 @@ pp3300_ldo_z: regulator-3v3-z {
>>>    		vin-supply = <&ppvar_sys>;
>>>    	};
>>
>> Can you please add a comment here advertising that this regulator
>> will not only provide power to the MIPI bridge, but *also* to the
>> display panel itself?
>>
>> This is to make sure that everyone understands what's going on, and
>> also that we ourselves don't forget about that.
>>
>> Probably something like:
>> /* pp3300_mipibrdg also enables pp3300_panel */
>>
>> I would then propose to add a "regulator-fixed" that has no GPIO
>> but with vin-supply as this one.
>>
>> pp3300_panel: regulator-3v3-panel {
>> 	compatible = "regulator-fixed";
>> 	regulator-name = "pp3300_panel";
>> 	regulator-min-microvolt = <3300000>;
>> 	regulator-max-microvolt = <3300000>;
>>
>> 	vin-supply = <&pp3300_mipibrdg>;
>> };
>>
>> I would also test assigning this regulator to the panel node, as this
>> will make sure to cover future corner cases (think about PM suspend/resume).
>>
>> P.S.: If you add the pp3300_panel regulator-fixed with that vin-supply,
>>        maybe the proposed comment would become a bit overkill. Your choice!
> 
> Hi Angelo,
> 
> thanks for the feedback.
> 
> I think the current layout makes more sense based on my understanding of the
> power routing here: a single power line output by the pp3300_mipibrdg regulator
> powers both the ANX chip as well as the panel. So I'm going to keep it the way
> it is for now. If there are any other concerns please let me know.
> 

As we discussed, I agree on this decision. Please go on.

Cheers!

> Thanks,
> Nícolas
> 
>>
>> Cheers,
>> Angelo
>>
>>> +	pp3300_mipibrdg: regulator-3v3-mipibrdg {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "pp3300_mipibrdg";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pp3300_mipibrdg_en_pins>;
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		enable-active-high;
>>> +		regulator-boot-on;
>>> +		gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
>>> +	};
>>> +
>>>    	/* separately switched 3.3V power rail */
>>>    	pp3300_u: regulator-3v3-u {
>>>    		compatible = "regulator-fixed";
>>
