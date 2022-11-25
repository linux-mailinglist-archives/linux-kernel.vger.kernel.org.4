Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7E63913A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKYVuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYVuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:50:15 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B448740;
        Fri, 25 Nov 2022 13:50:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D1D9C5C00B3;
        Fri, 25 Nov 2022 16:50:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 25 Nov 2022 16:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669413009; x=
        1669499409; bh=S1O8VZU+Rduz5/f4O46rBMJK70Funpw/H3+pweGpMJ0=; b=Y
        S2avTfkHFGy8sgHxyQ7JLwvolqnfDfK3or1D9V5RS3HRK5jyCYf26riMYJOaWP3w
        vTHhVlAtaVg6RBRfjeRaLrCABUycfuonOjFWbVpX0bawYLnGNRXSb5aij3sEht0G
        e6iT1XJJjECgcVE8CoVGyXrm7/QPGeDas0UEXlfA00rS94jy26298MIOoBPLrmWy
        9FcGSsb3MmhVQfP2Xl9frjLO+sANB0WgIagJExMQITNx0b0rPxc7XQvBBVmFPfcW
        veyx4zjPnWKrHTVaZbI6FTJ/NlQmKuOZ/cO2FD6O+ttNmbqz0htXLbtVhioUoUzf
        Oo3C+9BP4b94949hx4How==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669413009; x=
        1669499409; bh=S1O8VZU+Rduz5/f4O46rBMJK70Funpw/H3+pweGpMJ0=; b=w
        IsWJCIPr8U6zbCg/ci5FWsELdhw8kYbvT0EDWaJYz6LLS6mPG3lFQpkiS1b9xJ5r
        TMhZhCIMXxjuTJa9ZiZ0f2RyT3VZkPXLmT0iZ+TlycbqviEQ747g63BIDUSecJX+
        srcuv1AoHBUuEpneFeuylMsuSym+ADwi+1Jj+dAC1vRfT2135S8b0xe2gPZWcTZS
        LqMMWURqyOTLjhCvjMIdspPuTgvqY7jBcIB1RNjXxtqhs/siCdpVRkpuDYsF5eQ+
        kSIMK2eJ0U7WsmO7IHvCW/FZBl+No/5kibR/eUyWUK8Dk+MH5we5QUxCcKsR3Vu2
        8TrC61xlWVMgIXzhplpdw==
X-ME-Sender: <xms:kTiBY3AApzIykYciPmg1VQbBFR6cJs8J8TIJmWX2GGkPHGyl0YqbKg>
    <xme:kTiBY9jrtWpdT1SRYzkJFLLFuBmVrU9-22uoUY1ywPHM88nwJ7WUHCspfRCk3T28r
    IBoWsvKoMqzio1vaw>
X-ME-Received: <xmr:kTiBYynT2ZN1F4L5SfbvHpXL5ImYdS6oPxgRUECTznTrUvaG5FCDA1zOeS-tv0uP8Rq0IQMFp9RYwv2R-vzeEbgn4qjmQU2--FUZbdAn6dydUF6SUiVra9TArw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:kTiBY5wqJSSNoYHKXweOh3sbcWvekohw8Xk7fhu2GhwcxGZB83-0YQ>
    <xmx:kTiBY8QQL5RobcITmakzeN0NnAL6omZ1O1fmmdLLMjCTWbrL4Mrdaw>
    <xmx:kTiBY8bXsE4VfiugOQ9EHAYIQdO7KCIgjg1GD0J7MsFoY2UQTnUvgw>
    <xmx:kTiBYxQcUlR0UQCWfPY6iRQPL_eVZ9YFK3HIIR4N780I-fXyeeX7Zg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 16:50:08 -0500 (EST)
Message-ID: <2979be86-e561-e5ff-b348-367a7c20fab1@sholland.org>
Date:   Fri, 25 Nov 2022 15:50:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20221125195401.61642-1-samuel@sholland.org>
 <20221125214050.711997f1@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] ARM: dts: sunxi: Fix GPIO LED node names
In-Reply-To: <20221125214050.711997f1@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 11/25/22 15:40, Andre Przywara wrote:
> On Fri, 25 Nov 2022 13:54:00 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi Samuel,
> 
>> These board devicetrees fail to validate because the gpio-leds schema
>> requires its child nodes to have "led" in the node name.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> That looks alright, though the comment in the binding says that we
> should just have led-0, led-1 instead, so just (hex) numbers. The
> "status" name is also in the label, so we wouldn't lose information.

I am not a fan of giving the LEDs meaningless enumerators, but I can do
that if the maintainers insist.

> Actually, also "label" is deprecated, in favour of "color" and
> "function", shall this be fixed on the way? Or is there anything that
> breaks (older kernels) when removing the label property? 

The label is exposed to userspace as the path in sysfs, so we cannot
change it. There is no way to construct that exact label using function
and color -- see led_compose_name().

Regards,
Samuel

>> ---
>>
>>  arch/arm/boot/dts/sun5i-gr8-chip-pro.dts | 2 +-
>>  arch/arm/boot/dts/sun5i-r8-chip.dts      | 2 +-
>>  arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> index a32cde3e32eb..3222f1490716 100644
>> --- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> +++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> @@ -70,7 +70,7 @@ chosen {
>>  	leds {
>>  		compatible = "gpio-leds";
>>  
>> -		status {
>> +		led-status {
>>  			label = "chip-pro:white:status";
>>  			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
>>  			default-state = "on";
>> diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
>> index 4bf4943d4eb7..303191c926c2 100644
>> --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
>> +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
>> @@ -70,7 +70,7 @@ chosen {
>>  	leds {
>>  		compatible = "gpio-leds";
>>  
>> -		status {
>> +		led-status {
>>  			label = "chip:white:status";
>>  			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
>>  			default-state = "on";
>> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
>> index 0af48e143b66..b84822453381 100644
>> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
>> @@ -67,7 +67,7 @@ hdmi_con_in: endpoint {
>>  	leds {
>>  		compatible = "gpio-leds";
>>  
>> -		status {
>> +		led-status {
>>  			label = "sina31s:status:usr";
>>  			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
>>  		};
> 

