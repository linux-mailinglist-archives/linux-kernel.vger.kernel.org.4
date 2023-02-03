Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72268A182
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjBCSVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:21:15 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B728A9121;
        Fri,  3 Feb 2023 10:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675448455; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gLAiOwe07/bEw/oJjB1ieVZQpcRfDa/FzB71vs5P8bJ7U/sz8m/qX72VXZa5nYXjvTLzHVVJIu+uimIlIzhAjnlfz5PJCO7eRmaCHqrb9vDWGGT1xcLjEn3J769jI3rezdTCT1j3l5LcwgjzsGQNaOMSiRhehFLPkI0FRpKN/tM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675448455; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yUtfqLVzdOYg9WyJPcHo+LVr7DkxewoBgkCmk5Ny6hg=; 
        b=mO3XYGvINqT0a2FwSyH3kK9l5NXcZMkVtg8kp5NFW5FUo1g6AA51fy6CBOcx3W2LtRynuxhLsvJPMS87+gZZcv1lcScsUgMU5vzIednHIKGSKc8uTs4qMbDmBxXdY6h/jgO+DdndRe8eFdVvwJt0mBoB4iOAYAuIZBJy2+wFrSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675448455;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=yUtfqLVzdOYg9WyJPcHo+LVr7DkxewoBgkCmk5Ny6hg=;
        b=S5BsZgqh1ovGWZgiWB/Wpri0pbxjHrOQAiWdIDwDS02sfumVg4vfNAshmwq/fLT/
        /US+W/ENkWKI6Xb43IBjyR24/HTfRDGWoyBLS2fJ9jqyu7W/e9Ezc+xY2HJx6rvafu9
        frEdLX4LbMYIQN0jd3seryJyF25TQhlIl1yh/ttY=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1675448452891469.6679163758016; Fri, 3 Feb 2023 10:20:52 -0800 (PST)
Message-ID: <75d3758a-5502-03a4-b3a2-990f9339705b@arinc9.com>
Date:   Fri, 3 Feb 2023 21:20:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
To:     frank-w@public-files.de, arinc9.unal@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
 <20230201185656.17164-5-arinc.unal@arinc9.com>
 <AC473057-266B-4403-9270-8007E0EC257C@public-files.de>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <AC473057-266B-4403-9270-8007E0EC257C@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.02.2023 18:36, Frank Wunderlich wrote:
> Am 1. Februar 2023 19:56:55 MEZ schrieb arinc9.unal@gmail.com:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Mux the MT7530 switch's phy0 to gmac5 which is wired to the SoC's gmac1.
>> This achieves 2 Gbps total bandwidth to the CPU using the second RGMII.
>>
>> With this, the interface name to access phy0 changes from wan to eth1.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>> arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 15 ++++++++++-----
>> 1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> index dc9b4f99eb8b..64700253fd35 100644
>> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> @@ -182,6 +182,12 @@ fixed-link {
>> 	};
>> };
>>
>> +&gmac1 {
>> +	status = "okay";
>> +	phy-mode = "rgmii";
>> +	phy-handle = <&ethphy0>;
>> +};
>> +
>> &eth {
>> 	status = "okay";
>>
>> @@ -189,6 +195,10 @@ mdio-bus {
>> 		#address-cells = <1>;
>> 		#size-cells = <0>;
>>
>> +		ethphy0: ethernet-phy@0 {
>> +			reg = <0>;
>> +		};
>> +
>> 		switch@1f {
>> 			compatible = "mediatek,mt7530";
>> 			reg = <0x1f>;
>> @@ -200,11 +210,6 @@ ports {
>> 				#address-cells = <1>;
>> 				#size-cells = <0>;
>>
>> -				port@0 {
>> -					reg = <0>;
>> -					label = "wan";
>> -				};
>> -
>> 				port@1 {
>> 					reg = <1>;
>> 					label = "lan0";
> 
> Hi
> 
> I still see Problem with "renaming" the wan from users PoV. I got another way of using second gmac for wan some time ago using vlan-aware bridge (have not tested with recent kernel versions).
> 
> Maybe this works for you too? If yes imho it will be a better way.
> 
> https://github.com/frank-w/BPI-Router-Linux/commit/c92b648bac996b34dc75a4fff15d7fb429bfe74b

Frank, the comment section of that page is full of my comments testing 
it out and chatting with you. I don't understand why you're wording it 
like it's new to me.

> 
> Have same for r64/mt7622 in my tree...
> 
> It should use eth1 for wan-traffic too but is full userspace configuration without breaking userspace for users not wanting it.

If your argument is that connecting the wan port to the second mac 
should stay off mainline and to be left to the individual to do so, to 
not break the existing userspace configuration, this hack will need much 
more complex changes to the userspace configuration compared to this patch.

On top of this, you still need to change the devicetree to enable gmac1. 
And it will cause issues due to the nature of this method. Frames with 
the same MAC address will appear on different interfaces which will 
flood the kernel log, if eth1 were to be put in a bridge with other 
interfaces.

To summarise:
					This patch	Your method
Changes to the devicetree		Yes	(-)	Yes	(-)
Changes to the userspace configuration	Yes	(-)	Yes	(-)
Changes required in userspace		Simple	(+)	Complex	(-)
Does it work properly?			Yes	(+)	No	(-)

Using this patch would be the proper way to connect the wan port to the 
second mac.

I can also argue that I see no good reason to not want this, therefore 
this should be the default way. The UTP port for the wan port is 
seperated from the other 4 ports which already supports that this 
should've been there when the DT of this device was added in the first 
place.

If someone were to not want this, they could change the devicetree to 
fit their own purpose.

I did this on GnuBee GB-PC1 and it was easily addressed on gnubee-tools, 
a tool for building a firmware image for the said device.

https://github.com/neilbrown/gnubee-tools/commit/e1cdab9fd5f03ec4582176ab6eac9157df2a6f21

To conclude, in my opinion, gaining 2 Gbps total bandwidth to the CPU at 
the expense of a tiny change in userspace configuration is absolutely 
worth it. You clearly don't think that way and that's fine. It's up to 
the maintainer, Matthias, to decide. Matthias can take the remaining 
patches if they please.

Arınç
