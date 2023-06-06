Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E647236C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjFFFZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:25:33 -0400
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B90B197;
        Mon,  5 Jun 2023 22:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686029097; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=d/DqrB0VcCvMNNwiGP0PDTYPvnQSp+LO7Y+tmw5nChOsFuhNypCMJBcwKdDbrbBtinya9au0W9gZhMOrg1VCCOl6xkYy4U9hcduIl8B1yd0LPTfddbqu2KZaCvG7uHi/IUf5vYY3dN0XqCom5uSJ3gBYc4YzXpw8ox3x7YXR+r0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686029097; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9Po+XWXaAzNpUyuRg3cTc3e8NRWFI9cCB7gdE96Q3dI=; 
        b=kun1f2Q0tedGLnesfebku0h56uvHzhzaKPSvFFOJag7pBaRbVTekSKFBLiev5kHP8wtK2jZlj93sle4IqSwGrA0yl5INUTSCGYvXLu8BjItUQBVc3Ryt6v1wd+C9IPSJniniGFjcXBbjCjB7yJr19Pkw3Jx+jflTUJedR/bOEf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686029097;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9Po+XWXaAzNpUyuRg3cTc3e8NRWFI9cCB7gdE96Q3dI=;
        b=TZbYP4Tk0akq4Khzhtdf81C7Y42puFgW6WFEg7tm0vV3QoTB50RRkoWtSjPyakpT
        QMEt6MyoQ07hxySqfuLmzhwl284fW1/wJLnC5lcaunRhoTNrxPPNmJSq80ZEUTC2OF8
        /nGiuMQj7iPPnEJ4i6qNEb+R/PeAbDsOzWskc4no=
Received: from [192.168.66.198] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1686029095455783.4973963121519; Mon, 5 Jun 2023 22:24:55 -0700 (PDT)
Message-ID: <43c95286-a3f4-6c68-c59c-0c86bbb74928@arinc9.com>
Date:   Tue, 6 Jun 2023 08:24:48 +0300
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
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZH5NJsbY6ZLXYJYz@bart.dudau.co.uk>
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

On 6.06.2023 00:01, Liviu Dudau wrote:
> On Mon, Jun 05, 2023 at 07:35:44PM +0300, Arınç ÜNAL wrote:
>> On 5.06.2023 18:01, Liviu Dudau wrote:
>>> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
>>> a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board,
>>> connected to the main SoC over PCIe.
>>>
>>> The device uses NMBM over NAND, which is not currently supported in the
>>> mainline, so NAND node is skipped in this revision.
>>>
>>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>>> ---
>>>    arch/mips/boot/dts/ralink/Makefile            |  3 +-
>>>    .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 92 +++++++++++++++++++
>>>    2 files changed, 94 insertions(+), 1 deletion(-)
>>>    create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>>
>>> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
>>> index 11732b8c8163a..d27d7e8c700fe 100644
>>> --- a/arch/mips/boot/dts/ralink/Makefile
>>> +++ b/arch/mips/boot/dts/ralink/Makefile
>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>>>    dtb-$(CONFIG_SOC_MT7621) += \
>>>    	mt7621-gnubee-gb-pc1.dtb \
>>> -	mt7621-gnubee-gb-pc2.dtb
>>> +	mt7621-gnubee-gb-pc2.dtb \
>>> +	mt7621-tplink-hc220-g5-v1.dtb
>>>    obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
>>> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>> new file mode 100644
>>> index 0000000000000..859aaa1c1bc2b
>>> --- /dev/null
>>> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>> @@ -0,0 +1,92 @@
>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +/dts-v1/;
>>> +
>>> +#include "mt7621.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +
>>> +/ {
>>> +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
>>> +	model = "TP-Link HC220 G5 v1";
>>> +
>>> +	memory@0 {
>>> +		device_type = "memory";
>>> +		reg = <0x00000000 0x8000000>;
>>
>> Please use 8 digit addressing for the memory start and size offsets:
>>
>> 0x00000000 0x08000000
> 
> Will do.
> 
>>
>>> +	};
>>> +
>>> +	chosen {
>>> +		bootargs = "earlycon console=ttyS0,115200";
>>> +	};
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +
>>> +		key-reset {
>>> +			label = "reset";
>>> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
>>> +			linux,code = <KEY_RESTART>;
>>> +		};
>>> +
>>> +		key-wps {
>>> +			label = "wps";
>>> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
>>> +			linux,code = <KEY_WPS_BUTTON>;
>>> +		};
>>> +	};
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		red {
>>
>> Usually the led name would point to the component the LED is used for.
> 
> These are "generic" LEDs controlled from the userspace. The original firmware
> uses GREEN for normal operations, RED for faults and BLUE for when WPS is
> enabled. I'm not sure if there are any standard bindings that I can use here.

Looking at:

https://www.kernel.org/doc/html/latest/leds/leds-class.html#led-device-naming

You could use red:fault, green:power, and blue:wps. For node names, 
led-fault, led-power, and led-wps.

Arınç
