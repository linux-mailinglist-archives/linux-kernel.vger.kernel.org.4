Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9565B6A0382
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBWIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389542BEF8;
        Thu, 23 Feb 2023 00:05:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD6E4B81977;
        Thu, 23 Feb 2023 08:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC9AC433D2;
        Thu, 23 Feb 2023 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677139515;
        bh=k4PgJ+r3/+Al+F8IRjbgHFh3Bx1C+z9IdSSuseSYm0A=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=JoEcs+HD4LfnnWaSclPQSvevNxcim6Tucuoo2FG8khSHM5ZRBM9hMPJU9JEKkLKCv
         KaIBdbPipiBDR8Yve/azeCtbepWIeo0lPlPMjdprM0ongKTKevKRKNGAj12VrKfbWj
         RZ33Zu+e+hV4GWPjlBq/uz48B3M/PShNePiw9Jz/fkkNAKj9c5FCfxEvjbybqCHt1G
         Vg6rpP/DOA/QbW+Nr1/tuHmzcMlQ6IWMIHdKZPa71MZoTbBXVXzxpXFIkahnaW9npb
         tODZKGFN2SDVjrBNmT+6MA2Ikhq/IHKfOXkwmEzzV3T1jAc6FKoIdxoPhA3mrs2QkR
         9ga6Dg/n0giPA==
Message-ID: <9e890c83-495b-87d5-68bf-838c7cf0c003@kernel.org>
Date:   Thu, 23 Feb 2023 09:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] Mips: ls2k1000: dts: add the display controller
 device node
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sui jingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230222165514.684729-1-suijingfeng@loongson.cn>
 <f153bb62-ec3c-c16d-5b43-f53b5319c2e6@kernel.org>
 <32a56a81-e9b5-138b-4dff-35c2525cc0b6@loongson.cn>
 <f1cb010c-be28-9b1b-da1f-93d5e2fb213f@kernel.org>
In-Reply-To: <f1cb010c-be28-9b1b-da1f-93d5e2fb213f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 08:58, Krzysztof Kozlowski wrote:
> On 23/02/2023 04:19, Sui jingfeng wrote:
>> Hi,
>>
>> On 2023/2/23 02:32, Krzysztof Kozlowski wrote:
>>> On 22/02/2023 17:55, suijingfeng wrote:
>>>> The display controller is a pci device, it's pci vendor id is
>>>> 0x0014, it's pci device id is 0x7a06.
>>>>
>>>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>>>> ---
>>>>   .../boot/dts/loongson/loongson64-2k1000.dtsi  | 21 +++++++++++++++++++
>>>>   1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>>>> index 8143a61111e3..a528af3977d9 100644
>>>> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>>>> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>>>> @@ -31,6 +31,18 @@ memory@200000 {
>>>>   			<0x00000001 0x10000000 0x00000001 0xb0000000>; /* 6912 MB at 4352MB */
>>>>   	};
>>>>   
>>>> +	reserved-memory {
>>>> +		#address-cells = <2>;
>>>> +		#size-cells = <2>;
>>>> +		ranges;
>>>> +
>>>> +		display_reserved: framebuffer@30000000 {
>>>> +			compatible = "shared-dma-pool";
>>>> +			reg = <0x0 0x30000000 0x0 0x04000000>; /* 64M */
>>>> +			linux,cma-default;
>>>> +		};
>>>> +	};
>>>> +
>>>>   	cpu_clk: cpu_clk {
>>>>   		#clock-cells = <0>;
>>>>   		compatible = "fixed-clock";
>>>> @@ -198,6 +210,15 @@ sata@8,0 {
>>>>   				interrupt-parent = <&liointc0>;
>>>>   			};
>>>>   
>>>> +			display-controller@6,0 {
>>>> +				compatible = "loongson,ls2k1000-dc";
>>>> +
>>>> +				reg = <0x3000 0x0 0x0 0x0 0x0>;
>>>> +				interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
>>>> +				interrupt-parent = <&liointc0>;
>>>> +				memory-region = <&display_reserved>;
>>> NAK.
>> Err :(,  please give me a chance to explain
>>> Test your code against the bindings you send.
>>
>> I can guarantee to you that I test may code more than twice. The code 
>> used to testing is listed at link [1].
> 
> I wrote - test against the bindings. I don't believe that it was tested.
> Please paste the output of the testing (dtbs_check).

OTOH, dtschema has some hickups on loongsoon DTS, so I doubt you could
even test it. Anyway, where is above property memory-region described in
the bindings?

Best regards,
Krzysztof

