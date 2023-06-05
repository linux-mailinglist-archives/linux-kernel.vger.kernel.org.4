Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31346721F86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjFEH3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFEH3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:29:07 -0400
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB7AD;
        Mon,  5 Jun 2023 00:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685950101; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WlP5YypkeKmFYvGzAd069nw5ts7I0UqhETPH244i7PAQA7lpfSeFn85tFdNUsa+PzVoIfoJZeYfDwiv/HTeT+xJ/CHdOcGN5PRdezurXwMeNs2g3Sk9vnNu0JMSTV+Oi+DCDHbKjAYUzTa26YNrFVN8gWIttERY+9LRbrQKzFkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1685950101; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ccVwnrlCz84dc8VMGxnIrxOfBma61xV7p75ZZ+ZbU6A=; 
        b=IWgSIIJyA8S7eyYqaaojw2skLh5Xdn0IXRfEZyiwVc3tHQuPwzZbpCUXjtgqsLyS5NHcud7fmv+O19fx1IRXqodC80cX/CzALVYwFkXrIQ8YfPmhaosEglDqbMAbUsMOBCgO5CRCsnbAKyC9G5pgBPpUdZEMmtRDsSoOfW60ml0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685950101;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ccVwnrlCz84dc8VMGxnIrxOfBma61xV7p75ZZ+ZbU6A=;
        b=e931tzMLd3aJFXvyl+41uKBhXJ5vYfJmn9DKtgwzptg6h4GTthHsZCqtATiRh0L/
        feqJPVHOTJkEZKe+4a1cDRrW5maSQKvbIGxTnW/68j7zn3Qv8UCAkXu4z1/H3GJt8oo
        ZH7YzUzKs2Kwa2bI1y2fqhB6ZwHbDL9iI0gIrZMc=
Received: from [192.168.99.249] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1685950099479143.40592505033294; Mon, 5 Jun 2023 00:28:19 -0700 (PDT)
Message-ID: <827e74ed-3ef8-af6c-28af-ed9afe6aa10f@arinc9.com>
Date:   Mon, 5 Jun 2023 10:28:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
Content-Language: en-US
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-2-liviu@dudau.co.uk>
 <ZHTK+qG0xBWfn9gt@bart.dudau.co.uk>
 <cc70b28c-7bbe-0766-4a43-c0d7584e108a@arinc9.com>
 <ZH0Ck794eem2DUdw@bart.dudau.co.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZH0Ck794eem2DUdw@bart.dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.06.2023 00:30, Liviu Dudau wrote:
> On Sat, Jun 03, 2023 at 03:06:08PM +0300, Arınç ÜNAL wrote:
>> On 29.05.2023 18:55, Liviu Dudau wrote:
>>> On Mon, May 29, 2023 at 04:08:32PM +0100, Liviu Dudau wrote:
>>>> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
>>>> a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
>>
>> Do you mean MT7662 5GHz WiFi?
> 
> Actually it's MT76*1*3. Will fix for v3.
> 
>>
>>>> connected to the main SoC over PCIe.
>>>>
>>>> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
>>>> improve routing bandwidth.
>>
>> This is not always true, I'd prefer you remove this sentence from the patch
>> log.
> 
> If your comment is about the statement not being always true in general, then
> I agree. However for this device the port marked as WAN on HC220 v1 is the
> second port on the switch and according to the DSA bindings docs only PHY0
> or PHY4 can be connected to GMAC1, so I picked the one that worked (PHY4 did
> not). More on that at the end of the email.
> 
>>
>>>>
>>>> The device uses NMBM over NAND, which is not currently supported in the
>>>> mainline, so NAND node is skipped in this revision.
>>>>
>>>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>>>> ---
>>>>    arch/mips/boot/dts/ralink/Makefile            |   3 +-
>>>>    .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 129 ++++++++++++++++++
>>>>    2 files changed, 131 insertions(+), 1 deletion(-)
>>>>    create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>>
>>>> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
>>>> index 11732b8c8163a..d27d7e8c700fe 100644
>>>> --- a/arch/mips/boot/dts/ralink/Makefile
>>>> +++ b/arch/mips/boot/dts/ralink/Makefile
>>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>>>>    dtb-$(CONFIG_SOC_MT7621) += \
>>>>    	mt7621-gnubee-gb-pc1.dtb \
>>>> -	mt7621-gnubee-gb-pc2.dtb
>>>> +	mt7621-gnubee-gb-pc2.dtb \
>>>> +	mt7621-tplink-hc220-g5-v1.dtb
>>>>    obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
>>>> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>> new file mode 100644
>>>> index 0000000000000..f003ae615a58e
>>>> --- /dev/null
>>>> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>> @@ -0,0 +1,129 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +/dts-v1/;
>>>> +
>>>> +#include "mt7621.dtsi"
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/input/input.h>
>>>> +#include <dt-bindings/leds/common.h>
>>>> +
>>>> +/ {
>>>> +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
>>>> +	model = "TP-Link HC220 G5 v1";
>>>> +
>>>> +	memory@0 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x0 0x0 0x0 0x8000000>;
>>
>> What's going on here? Just do 'reg = <0x00000000 0x08000000>;'.
>>
> 
> Right, hangover from 64bits world :) Will fix for v3.
> 
> 
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		/* add 'earlycon=uart8260,mmio32,0x1e000c00' to
>>
>> 8260?
> 
> Duh, I feel stupid. It's 8250 and (as you mention bellow) not needed to
> enable early boot messages.
> 
>>
>>>> +		 * bootargs for early boot messages
>>
>> Isn't just adding "earlycon" to bootargs enough?
>>
>>>> +		 */
>>>> +		bootargs = "console=ttyS0,115200";
>>>> +	};
>>>> +
>>>> +	gpio-keys {
>>>> +		compatible = "gpio-keys";
>>>> +
>>>> +		key-reset {
>>>> +			label = "reset";
>>>> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
>>>> +			linux,code = <KEY_RESTART>;
>>>> +		};
>>>> +
>>>> +		key-wps {
>>>> +			label = "wps";
>>>> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
>>>> +			linux,code = <KEY_WPS_BUTTON>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	leds {
>>>> +		compatible = "gpio-leds";
>>>> +
>>>> +		red {
>>>> +			color = <LED_COLOR_ID_RED>;
>>>> +			function = LED_FUNCTION_FAULT;
>>>> +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
>>>> +		};
>>>> +
>>>> +		green {
>>>> +			color = <LED_COLOR_ID_GREEN>;
>>>> +			function = LED_FUNCTION_POWER;
>>>> +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
>>>> +			linux,default-trigger = "default-on";
>>>> +		};
>>>> +
>>>> +		blue {
>>>> +			color = <LED_COLOR_ID_BLUE>;
>>>> +			function = LED_FUNCTION_WPS;
>>>> +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	resetc: reset-controller {
>>>> +		compatible = "ralink,rt2880-reset";
>>>> +		#reset-cells = <1>;
>>>> +	};
>>
>> We don't use this anymore.
>>
> 
> I've copied it from disassembled vendor device tree. Is this not needed
> anymore for reset?

No, you can just remove this node.

https://github.com/torvalds/linux/commit/64b2d6ffff862c0e7278198b4229e42e1abb3bb1

> 
>>>> +
>>>> +	mtd {
>>>> +		compatible = "mediatek,mt7622-nfc";
>>>> +	};
>>
>> What's this got to do with this device?
> 
> This is the NAND Flash Controller bindind. Left over from interrupted
> development of the NAND support. Will remove for v3.
> 
>>
>>>> +};
>>>> +
>>>> +&i2c {
>>>> +	status = "okay";
>>>> +};
>>
>> Why does this device need i2c?
> 
> It doesn't. I was curious if there was anything hanging on that bus so I've
> enabled it to scan it. Will remove for v3.
> 
> 
>>
>>>> +
>>>> +&pcie {
>>>> +	status = "okay";
>>>> +};
>>
>> Do both WiFi chips work by just enabling pcie? I was expecting 'compatible =
>> "mediatek,mt76";' on pcie@0,0 and pcie@1,0.
> 
> Nothing else is needed and I can modprobe the mt7603e and mt7615e modules just
> fine, with the devices becoming available one I put the appropriate firmware in
> the right place.

Ok I checked the mainline Linux source code, looks like the MT76 driver 
doesn't look for the compatible string at all. I suppose the compatible 
string is there for the purposes of describing the hardware and checking 
whether the devicetree bindings for the hardware are proper. Therefore, 
I would like you to add the compatible string regardless. Should look 
something like this:

&pcie {
	status = "okay";

	pcie@0,0 {
		compatible = "mediatek,mt76";
	};

	pcie@1,0 {
		compatible = "mediatek,mt76";
	};
};

See if both radios work with these bindings.

> 
>>
>>>> +
>>>> +&spi0 {
>>>> +	status = "okay";
>>>> +
>>>> +	flash@0 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		compatible = "jedec,spi-nor";
>>>> +		reg = <0>;
>>>> +		spi-max-frequency = <50000000>;
>>>> +	};
>>>> +};
>>
>> I thought you said this device had NAND flash, not NOR.
> 
> Appologies, I will remove this for now as I haven't finished looking into
> storage problem yet.
> 
>>
>>>> +
>>>> +/* gmac1 connected to MT7530's phy0 */
>>>> +&gmac1 {
>>>> +	phy-handle = <&ethphy0>;
>>>> +
>>>> +	fixed-link {
>>>> +		status = "disabled";
>>>> +	};
>>>> +};
>>>> +
>>>> +&mdio {
>>>> +	/* MT7530's phy0 */
>>>> +	ethphy0: ethernet-phy@0 {
>>>> +		reg = <0>;
>>>> +	};
>>>> +};
>>
>> Remove the two nodes above.
> 
> It would be nice if you can provide some explanation to some of your requests
> so that I can learn more about this. This is my first time dipping my toes
> on MIPS and MT7621 world, so I don't have that much experience and would like
> to know more.

The bindings above are used for the PHY muxing feature. Like I said on 
my previous mail, I would rather use the changing DSA conduit feature 
instead which makes the PHY muxing feature redundant. It is also better 
than PHY muxing as you'll be able to choose freely which DSA user port 
will be affine to which DSA conduit interface, from userspace. Like so:

ip link set lan1 type dsa conduit eth1

I see port@0 is defined on the DSA switch node which averts the PHY 
muxing feature so the bindings above are already unnecessary.

> 
>>
>>>> +
>>>> +&switch0 {
>>>> +	ports {
>>>> +		/* phy0 is muxed to gmac1 */
>>>> +		port@0 {
>>>> +			status = "okay";
>>>> +			label = "lan2";
>>>> +		};
>>>
>>> I've made the changes to look similar to the gnubee-gb-pc2, and things mostly
>>> work, with the exception that I can mount an NFS root filesystem only on "lan2"
>>> interface at boot time. All other interfaces (ports) hang forever waiting for
>>> an DHCP response from my server. The only difference is where I plug in the
>>> ethernet cable, no other change (not even a restart) on the server.
>>
>> This sounds like a userspace configuration issue.
> 
> Which userspace? On the server side? I don't touch anything there, only
> change the ethernet port where the cable is connected on the device and
> reboot. It only works for "lan2".
> 
> If you're talking about userspace on the device, I don't agree as there is nothing
> loaded there but the kernel, and it is trying to mount the NFS root.
> 
> I have to admit that I don't really understand how the whole MT7530 DSA is wired
> inside this device. I mostly did trial and error and it is very possible that what
> I've got were just half results that are more confusing that they should be. The
> vendor device tree uses the old bindings and drivers, with the gsw node outside
> of the ethernet one and also a mtk-hnat_v1 node that seems to bundle all ports
> under one single MAC address, so it's hard to understand from there how things work.
> I was trying to both enable NFS root and squeeze the maximum speed from the switch,
> so I thought I need to enable gmac1 and use the PHYs of the switch to enable 2Gbps
> routing. When I've tried PHY4 things didn't work, while with PHY0 I've got all the
> connections to work (but only if I've used LAN2 as the initial connection to the
> NFS server).
> 
> Now I've tried removing the two nodes as suggested and I can mount the NFS root over
> any of the three physical connections, but the iperf3 speed is only about 512Mbits/sec
> vs the 730Mbits/sec that I was getting with the GMAC1 enabled.

GMAC1 is enabled by default on mt7621.dtsi so your 512 Mbps test also 
had GMAC1 enabled, your problem is not there. What I did notice a while 
back with my MT7621 board is that I get better performance on the port 
that uses the PHY muxing feature. I assume this is what's causing the 
speed difference on your device.

Anyway, this SoC is not very efficient at processing packets at 
software. You'll get ~933 Mbps bandwidth whether you do PHY muxing or 
not when using the hardware flow offloading feature of the MediaTek 
ethernet driver. Here's the relevant documentation:

https://www.kernel.org/doc/html/latest/networking/nf_flowtable.html#hardware-offload

Arınç
