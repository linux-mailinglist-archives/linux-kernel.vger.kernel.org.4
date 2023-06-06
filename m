Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E56724789
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjFFPW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjFFPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:22:24 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E942E40;
        Tue,  6 Jun 2023 08:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686064932; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fQLWl1OJQgI+y16x11Nujul31DbOOZGxHC9Jy8zMjwxNcByl6utzoadZEJzxSzhNwgQSQR3t3Dx9vfA9DrFp3Ogd2vwDp0rJ1W2xuqNnhMpUW9LZ21qfBPhORyTL+ao3OiVm3dgmiQwJtPV8zyK/jKp5VISSWnflbg5c7vgPdpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686064932; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5NyaYE9lJ5b6pxkKhpQXFKjTx0CZyg+2SN/WxV0H/pM=; 
        b=HfYmxrltidB8T7t4j0LIUlRUBJn8iwKkW0HPCNfy1NeG1eMgpncli0qKzUhFXrbl5n5okqo8uzpS+GWDH5DXWhlpBVy5qxtd3IuyBBOwSj8DucooeeE+T0Ob5hYyYArrCnoErnGaL5JGy59+O6UecRPyBFkbppCW2OXMJRlTX/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686064932;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=5NyaYE9lJ5b6pxkKhpQXFKjTx0CZyg+2SN/WxV0H/pM=;
        b=V8pesKFOFlk+xfIWUrAdHLdhU7/6hSNS4K7kAycDr9s5XlbNTvtm+jLRqQZN7u1x
        SK7YnJufRxJbtFPdvhLZp2srQfEkFQfqrtRGJFIycXL/DaqdlIyHMbGICLOQMfJhZi3
        VmbONVjuEOKSlsdboUXc6fOQ3Y5cB5morJ1iOP8E=
Received: from [192.168.99.249] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1686064930095554.2192890935327; Tue, 6 Jun 2023 08:22:10 -0700 (PDT)
Message-ID: <3895c69f-6033-0976-0902-b9aab644bd0e@arinc9.com>
Date:   Tue, 6 Jun 2023 18:22:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230605150114.601102-1-liviu@dudau.co.uk>
 <20230605150114.601102-2-liviu@dudau.co.uk>
 <552b4604-d1b3-0052-62aa-424944c5ecb1@arinc9.com>
 <ZH5NJsbY6ZLXYJYz@bart.dudau.co.uk>
 <43c95286-a3f4-6c68-c59c-0c86bbb74928@arinc9.com>
 <ZH9DP+QdwRu/uS2D@bart.dudau.co.uk>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZH9DP+QdwRu/uS2D@bart.dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.06.2023 17:31, Liviu Dudau wrote:
> On Tue, Jun 06, 2023 at 08:24:48AM +0300, Arınç ÜNAL wrote:
>> On 6.06.2023 00:01, Liviu Dudau wrote:
>>> On Mon, Jun 05, 2023 at 07:35:44PM +0300, Arınç ÜNAL wrote:
>>>> On 5.06.2023 18:01, Liviu Dudau wrote:
>>>>> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
>>>>> a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board,
>>>>> connected to the main SoC over PCIe.
>>>>>
>>>>> The device uses NMBM over NAND, which is not currently supported in the
>>>>> mainline, so NAND node is skipped in this revision.
>>>>>
>>>>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>>>>> ---
>>>>>     arch/mips/boot/dts/ralink/Makefile            |  3 +-
>>>>>     .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 92 +++++++++++++++++++
>>>>>     2 files changed, 94 insertions(+), 1 deletion(-)
>>>>>     create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>>>
>>>>> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
>>>>> index 11732b8c8163a..d27d7e8c700fe 100644
>>>>> --- a/arch/mips/boot/dts/ralink/Makefile
>>>>> +++ b/arch/mips/boot/dts/ralink/Makefile
>>>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>>>>>     dtb-$(CONFIG_SOC_MT7621) += \
>>>>>     	mt7621-gnubee-gb-pc1.dtb \
>>>>> -	mt7621-gnubee-gb-pc2.dtb
>>>>> +	mt7621-gnubee-gb-pc2.dtb \
>>>>> +	mt7621-tplink-hc220-g5-v1.dtb
>>>>>     obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
>>>>> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>>> new file mode 100644
>>>>> index 0000000000000..859aaa1c1bc2b
>>>>> --- /dev/null
>>>>> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>>> @@ -0,0 +1,92 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include "mt7621.dtsi"
>>>>> +
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/input/input.h>
>>>>> +#include <dt-bindings/leds/common.h>
>>>>> +
>>>>> +/ {
>>>>> +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
>>>>> +	model = "TP-Link HC220 G5 v1";
>>>>> +
>>>>> +	memory@0 {
>>>>> +		device_type = "memory";
>>>>> +		reg = <0x00000000 0x8000000>;
>>>>
>>>> Please use 8 digit addressing for the memory start and size offsets:
>>>>
>>>> 0x00000000 0x08000000
>>>
>>> Will do.
>>>
>>>>
>>>>> +	};
>>>>> +
>>>>> +	chosen {
>>>>> +		bootargs = "earlycon console=ttyS0,115200";
>>>>> +	};
>>>>> +
>>>>> +	gpio-keys {
>>>>> +		compatible = "gpio-keys";
>>>>> +
>>>>> +		key-reset {
>>>>> +			label = "reset";
>>>>> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
>>>>> +			linux,code = <KEY_RESTART>;
>>>>> +		};
>>>>> +
>>>>> +		key-wps {
>>>>> +			label = "wps";
>>>>> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
>>>>> +			linux,code = <KEY_WPS_BUTTON>;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>> +	leds {
>>>>> +		compatible = "gpio-leds";
>>>>> +
>>>>> +		red {
>>>>
>>>> Usually the led name would point to the component the LED is used for.
>>>
>>> These are "generic" LEDs controlled from the userspace. The original firmware
>>> uses GREEN for normal operations, RED for faults and BLUE for when WPS is
>>> enabled. I'm not sure if there are any standard bindings that I can use here.
>>
>> Looking at:
>>
>> https://www.kernel.org/doc/html/latest/leds/leds-class.html#led-device-naming
>>
>> You could use red:fault, green:power, and blue:wps. For node names,
>> led-fault, led-power, and led-wps.
> 
> Without making any changes in the device tree, because of the use of 'function' property,
> I get this:
> 
> # ls -al /sys/class/leds/
> drwxr-xr-x    2 root     root             0 Jun  6 14:24 .
> drwxr-xr-x   37 root     root             0 Jan  1  1970 ..
> lrwxrwxrwx    1 root     root             0 Jun  6 14:24 blue:wps -> ../../devices/platform/leds/leds/blue:wps
> lrwxrwxrwx    1 root     root             0 Jun  6 14:24 green:power -> ../../devices/platform/leds/leds/green:power
> lrwxrwxrwx    1 root     root             0 Jun  6 14:24 red:fault -> ../../devices/platform/leds/leds/red:fault
> 
> May I suggest that I change only the node names and not add a label, keeping the 'function' property instead?

It seems to achieve the same result so, sure.

Arınç
