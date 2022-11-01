Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8821B614B55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiKANEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKANEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:04:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509C11A82D;
        Tue,  1 Nov 2022 06:04:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1D4G1m001796;
        Tue, 1 Nov 2022 08:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667307856;
        bh=62S3+g55ZcTL/pb8O/4q9XR3gQaDxdYkksjQkw57tqI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=aSUD/339RcZ7DYNKUDBh4E/zIamTYf2HirW3uI9X8GK/tex5iFK2aVE7ACnu7O9k9
         JNoLfZnEi50wYYpsLrM3Re6iGzasB9TSb0U4I/jhd+6BB5lSuOUUw8penqPvEeXrGf
         qIcjQ7jFoPfD2krjyDcUFiLz5LdaVgq1qF+W56lk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1D4GBk038199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 08:04:16 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 08:04:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 08:04:15 -0500
Received: from [10.250.35.234] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1D4FXG058015;
        Tue, 1 Nov 2022 08:04:15 -0500
Message-ID: <2a7afcc3-b973-c993-e4f1-0f1888073f28@ti.com>
Date:   Tue, 1 Nov 2022 08:04:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/9] ARM: dts: nspire: Use syscon-reboot to handle
 restart
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221027181337.8651-1-afd@ti.com>
 <20221027181337.8651-3-afd@ti.com>
 <050f3d65-5720-9c97-1930-bc458c4c2fb8@linaro.org>
 <a4688f2d-0a0f-dffc-92cc-4fa50938d0d8@ti.com>
 <4236ab07-6ad3-efcd-7d5e-c244581d2944@linaro.org>
 <0025ec36-0632-b79e-beba-cf838018a704@ti.com>
 <20221031171430.GA2981736-robh@kernel.org>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221031171430.GA2981736-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 12:14 PM, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 09:30:45AM -0500, Andrew Davis wrote:
>> On 10/27/22 4:27 PM, Krzysztof Kozlowski wrote:
>>> On 27/10/2022 17:07, Andrew Davis wrote:
>>>> On 10/27/22 2:33 PM, Krzysztof Kozlowski wrote:
>>>>> On 27/10/2022 14:13, Andrew Davis wrote:
>>>>>> Writing this bit can be handled by the syscon-reboot driver.
>>>>>> Add this node to DT.
>>>>>>
>>>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>> Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
>>>>>> Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>
>>>>>> ---
>>>>>>     arch/arm/boot/dts/nspire.dtsi | 7 +++++++
>>>>>>     1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
>>>>>> index bb240e6a3a6f..48fbc9d533c3 100644
>>>>>> --- a/arch/arm/boot/dts/nspire.dtsi
>>>>>> +++ b/arch/arm/boot/dts/nspire.dtsi
>>>>>> @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
>>>>>>     			};
>>>>>>     			misc: misc@900a0000 {
>>>>>> +				compatible = "ti,nspire-misc", "syscon", "simple-mfd";
>>>>>
>>>>> You have syscon and simple-mfd, but bindings in patch #1 say only syscon.
>>>>>
>>>>
>>>> I'm not following, are you just saying my wording in the patch message just
>>>> wasn't complete?
>>>
>>> Your binding patch adds nspire compatible to the list of two items, so
>>> you have two items in total - nspire followed by syscon.
>>>
>>> What you implemented here is different.
>>>
>>
>> Is there a list of three items I can add this compatible? If instead you
>> mean I should go make a new binding, just say so :)
> 
> An MFD should define its own schema file.
> 
> The original intent of syscon.yaml was for just single nodes with
> 'syscon' (and a specific compatible). Adding in simple-mfd was probably
> a mistake. Certainly we need to rework the schema as you should get a
> warning in this case.
> 
>>>> Or are you saying something more about nodes that are both syscon and simple-mfd?
>>>> In that case, having both syscon and simple-mfd seems rather common, looks like
>>>> you added the rule for it[0].
>>>>
>>>> Thinking on this, they almost represent the same thing. simple-mfd says "my child
>>>> nodes should be considered devices", why do we need that? Couldn't we simply state
>>>> that "syscon" node's children are always devices, I mean what else could they be,
>>>> syscon is an MFD after all (and lives in drivers/mfd/).
>>>
>>> No, syscon is not an MFD. Syscon means system controller and alone it
>>> does not have children.
>>>
>>
>> The binding lives in devicetree/bindings/*mfd*/, it is mentioned as one
>> in devicetree/bindings/mfd/mfd.txt. If it is not an MFD then the bindings
>> are giving out mixed signals here..
>>
>>>>
>>>> "syscon" often just says, others can use the registers within this node, so as a
>>>> different option, make "syscon" a property of "simple-mfd" nodes. I'm seeing all
>>>> these examples of devices that should have been children of the "syscon" device,
>>>> but instead use
>>>>
>>>> regmap = <&x>;
>>>> syscon = <&x>;
>>>>
>>>> or similar and put the device node out somewhere random. And in those cases,
>>>> wouldn't it have been more correct to use the normal "reg" and "regions" to
>>>> define the registers belonging to the child node/device?..
>>>
>>> Sorry, I do not follow. How this is even related to your patch?
>>>
>>> Your bindings say A, DTS say B. A != B. This needs fixing.
>>>
>>
>> I said it was compatible with "syscon", not that it is incompatible
>> with "simple-mfd" devices.
>>
>> What I've done here gives no dtbs_check warnings and
>> "devicetree/bindings/mfd/mfd.txt" explicitly allows what I am doing.
>> Unless we do not consider the old bindings valid?
> 
> Only that the example is not because it doesn't have a specific
> compatible.
> 
> What needs to be clarified is that MFDs must define all the child nodes
> whether they are 'simple' or not.
> 
>> If so, would you
>> like me to convert mfd.txt to yaml, just let me know.
> 
> No, because I don't think there is anything to define as a schema.
> 

It would allow for simple register regions to be 'simple-mfd' without
needing a whole new binding document for each. Same as we already have
with 'syscon.yaml'.

Making every simple MMIO space create a new binding document is not
reasonable. Neither is defining all nodes up front in that binding,
we don't expect that for top level nodes or 'simple-bus', why should
we for 'simple-mfd'?

My point with mfd.txt is that this *was allowed*, and there are already
a large number of users of the existing style.

> 
>>> Unless you are asking me what your device is in general. This I don't
>>> really know, but if you want to use it as regmap provider for system
>>> registers and as a parent of syscon-based reboot device, then your
>>> device is syscon and simple-mfd. With a specific compatible. Was this
>>> your question?
>>>
>>
>> Yes, I would like to use it as a regmap provider, my question here is
>> a much more general one: why do I need to specify that in device tree?
>> That is not a hardware description, my hardware is not "regmap" hardware.
>> This "syscon" stuff feels like a bodge to make the Linux drivers and bus
>> frameworks interact the way we want.
> 
> Bingo! It's a hint for create a regmap. We could just have a compatible
> list in the kernel for compatibles needing a regmap. Maybe that list
> would be too long though. So call it h/w description for this h/w is
> referenced by other places.
> 
> 
>> I know at this point this has little to do with this series, but I'd like
>> to just think this out for a moment. The latest Devicetree Specification
>> talks about "simple-bus" as a special compatible that communicates that
>> child nodes with compatible strings need probed also. ("simple-mfd" seems
>> to be used the same way but without needing a "ranges" property..)
> 
> Yes, both cases are saying there is no dependency or setup of the parent
> needs. If the child nodes depend on the regmap, then it's not a
> 'simple-mfd' IMO. Therefore 'syscon' together with 'simple-mfd' is wrong
> unless it's other nodes that need the regmap. The schema can't really
> check that.
> 

'syscon' also provides for reusing the same single register by multiple
users, such as bit-mapped registers. It also allows re-using the existing
simple syscon device compatibles. Again because people do not like writing
bindings for simple nodes.

Andrew

>> Both of these are properties of a node, not something a device is "compatible"
>> with. "compatibles" are also supposed to be listed "from most specific to
>> most general", so which is more specific, "simple-mfd" or "syscon", etc..
> 
> I would say 'syscon' is more specific if I have to pick. It implies some
> registers exist. 'simple-mfd' should mean there are no parent resources
> (...the children depend on).
> 
> We've probably got enough of a mixture of the order, it wouldn't be
> worth the effort to try to enforce the order here.
> 
>> Seems like Rob might agree[0], these are not really compatibles. We cant fix
>> history, but for new nodes, instead of growing the problem and forcing these to
>> be overloaded compatibles, we allow these to become new standard node properties.
>>
>> For instance:
>>
>> main_conf: syscon@43000000 {
>> 	compatible = "ti,j721e-system-controller";
>> 	reg = <0x0 0x43000000 0x0 0x20000>;
>>
>> 	simple-bus;
>> 	syscon;
> 
> Umm, no. This ship already sailed and we don't need a 2nd way to do
> things.
> 
> Rob
