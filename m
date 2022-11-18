Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BF762FC17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiKRR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiKRR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:56:35 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351376A693;
        Fri, 18 Nov 2022 09:56:35 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AIHuSH9060725;
        Fri, 18 Nov 2022 11:56:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668794188;
        bh=fEXsV3TD0XyH+BXYuxbAlTRcrFjFQrVVL3bi6Q6mMIE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VuYuIJES0iiZCYxStWKQoqQNC90VKsazhvom5/eAB3uJzlxa+jopkbDH6bjgUZhAC
         +t8VILBvxXpk3e/Zca/YyQIcYzI4ths47fL+vP5mDh3QeuBLpkSLwJvjttvslG6lS1
         IedEjNbQRgUSFw2mKE0LzAn7TEjHJbt6fY9gvuJU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AIHuSt6125149
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 11:56:28 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 18
 Nov 2022 11:56:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 18 Nov 2022 11:56:28 -0600
Received: from [10.250.38.44] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AIHuR7w110433;
        Fri, 18 Nov 2022 11:56:27 -0600
Message-ID: <8c123fa2-caab-d2dd-5eb4-688f1c6abb33@ti.com>
Date:   Fri, 18 Nov 2022 11:56:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
References: <20221116130428.161329-1-a-nandan@ti.com>
 <20221116130428.161329-5-a-nandan@ti.com>
 <b57433e7-b309-bd1c-f794-3da74021f03c@ti.com>
 <20221118174754.y37pq77drvla2uxj@tinderbox>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221118174754.y37pq77drvla2uxj@tinderbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 11:47 AM, Nishanth Menon wrote:
> On 11:40-20221118, Andrew Davis wrote:
>> On 11/16/22 7:04 AM, Apurva Nandan wrote:
> 
> [...]
> 
>>> +#include <dt-bindings/net/ti-dp83867.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include "k3-j784s4.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "ti,j784s4-evm", "ti,j784s4";
>>> +	model = "Texas Instruments J784S4 EVM";
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial2:115200n8";
>>> +	};
>>> +
>>> +	aliases {
>>> +		serial2 = &main_uart8;
>>
>> This feels hacky. Your chosen node picks serial2 as that is usually
>> the one that is wired up on K3 boards. But on this board it is main_uart8.
>> So why not have this be serial10, then choose
>>
>> stdout-path = "serial10:115200n8";
>>
>> Also, I've made comments on previous version of this series, it is
>> nice to include folks who have commented before in the CC for future
>> versions, that way our filters don't hide these away and we can more
>> easily check that our comments have been addressed.
> 
> Please stick with the standard of serial2 as the linux console standard.
> We ended up with that to ease up capabilities of various distros to
> uniformly work across SoC and board variants.
> 

The chosen "stdout-path" is for setting the kernel's default output terminal.
Distros and other userspaces need to use their own policy mechanisms for
picking what serial port to run getty on or whatever the issue may be.

Some look at the kernel command line, and our bootloader provides
that too, so still no reason to fake alias names here.

Andrew

> I do agree that phandle is the wrong approach here (baud etc information
> missing). "serial2:115200n8" is probably the way to do this right.
> 
