Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB26CC21F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjC1Oeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjC1Oeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:34:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F51FD0;
        Tue, 28 Mar 2023 07:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF4DB81D6D;
        Tue, 28 Mar 2023 14:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC52C433EF;
        Tue, 28 Mar 2023 14:34:34 +0000 (UTC)
Message-ID: <c368a0f8-41f0-69ac-04f4-459e5fc8b9d6@linux-m68k.org>
Date:   Wed, 29 Mar 2023 00:34:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        Markus.Niebel@ew.tq-group.com,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        paul.elder@ideasonboard.com, gerg@kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, djakov@kernel.org, shawnguo@kernel.org,
        l.stach@pengutronix.de
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
 <20230327045037.593326-1-gerg@linux-m68k.org> <2678294.mvXUDI8C0e@steina-w>
 <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
 <ecd3a92b-ba1e-e7c1-088a-371bd1a2c100@linux-m68k.org>
 <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
 <426b4776-104c-cb47-c8cc-c26515fcb6e3@linux-m68k.org>
 <20230328134201.yaxrdtetjygkgkmz@pengutronix.de>
 <20230328135100.rbmnfelphe7juhxo@pengutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20230328135100.rbmnfelphe7juhxo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 28/3/23 23:51, Marco Felsch wrote:
> On 23-03-28, Marco Felsch wrote:
>> Hi Greg,
>>
>> On 23-03-28, Greg Ungerer wrote:
>>> Hi Marco,
>>>
>>> On 28/3/23 17:33, Marco Felsch wrote:
>>>> Hi Greg,
>>>>
>>>> On 23-03-27, Greg Ungerer wrote:
>>>>> Hi Ahmad,
>>>>>
>>>>> On 27/3/23 17:16, Ahmad Fatoum wrote:
>>>>>> On 27.03.23 08:27, Alexander Stein wrote:
>>>>>>> Am Montag, 27. März 2023, 06:50:37 CEST schrieb Greg Ungerer:
>>>>>>>> Any thoughts on why this breaks USB?
>>>>>>>
>>>>>>> Maybe you are missing CONFIG_INTERCONNECT_IMX8MP?
>>>>>>
>>>>>> And if that's the case, did you check /sys/kernel/debug/devices_deferred
>>>>>> to see if there was any indication that this is the reason?
>>>>>
>>>>> Yeah, it does:
>>>>>
>>>>>       # cat /sys/kernel/debug/devices_deferred
>>>>>       32f10100.usb	platform: supplier 32f10000.blk-ctrl not ready
>>>>>       32f10108.usb	platform: supplier 32f10000.blk-ctrl not ready
>>>>>       32ec0000.blk-ctrl	imx8m-blk-ctrl: failed to get noc entries
>>>>>       381f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
>>>>>       382f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
>>>>>       imx-pgc-domain.11	
>>>>>       imx-pgc-domain.12	
>>>>>       imx-pgc-domain.13	
>>>>>       38330000.blk-ctrl	platform: supplier imx-pgc-domain.11 not ready
>>>>>       32f10000.blk-ctrl	imx8mp-blk-ctrl: failed to get noc entries
>>>>>
>>>>> As far as I can tell blk-ctrl should be good:
>>>>>
>>>>>       #
>>>>>       # i.MX SoC drivers
>>>>>       #
>>>>>       CONFIG_IMX_GPCV2_PM_DOMAINS=y
>>>>>       CONFIG_SOC_IMX8M=y
>>>>>       # CONFIG_SOC_IMX9 is not set
>>>>>       CONFIG_IMX8M_BLK_CTRL=y
>>>>>       # end of i.MX SoC drivers
>>>>>
>>>>>
>>>>>> If you didn't find any hint there, you might want to place a
>>>>>> dev_err_probe with a suitable message at the place where -EPROBE_DEFER
>>>>>> was returned.
>>>>>
>>>>> I will try that.
>>>>
>>>> Can you check that CONFIG_ARM_IMX_BUS_DEVFREQ is enabled? This is the
>>>> noc/interconnect driver. This could also the problem for you vpu issue.
>>>
>>> I do not have that enabled. Enabling that fixes the USB probing.
>>> So that is good, thanks.
>>>
>>> It doesn't fix the other problem I mentioned with the vpu pgc nodes though.
>>> I do get some extra messages now with this enabled and the 6.1 kernel:
>>>
>>>      imx-pgc imx-pgc-domain.8: failed to command PGC
>>>      imx-pgc imx-pgc-domain.8: failed to command PGC
>>>      imx8m-blk-ctrl 38330000.blk-ctrl: deferred probe timeout, ignoring dependency
>>>      imx8m-blk-ctrl 38330000.blk-ctrl: error -110: failed to attach power domain "g1"
>>>      imx8m-blk-ctrl: probe of 38330000.blk-ctrl failed with error -110
>>
>> Okay, this seems more like a "real" issue not related to some missing
>> drivers. I followed the code and found a poll within the
>> imx_pgc_power_up() in gpcv2.c. Power-domain 8 is the vpumix domain which
>> is used as power-domain for the g1 power-domain. My assumption is that
>> this poll does run into the timeout. Maybe Peng can support you here
>> since I didn't had the time for to test the VPUs yet and he did the
>> integration patches.
>>
>> Just ignore the errors if you don't use the VPUs or disable the
>> blk-ctrl@38330000 node via status = "disabled".
> 
> I forgot to ask: Does your i.MX8MP have a VPU? There are i.MX8MP devices
> (don't know the name) which don't have support for certain IPs. If this

The hardware platform I have is using the MIMX8ML4CVNKZAB "i.MX 8M Plus QuadLite"
(https://www.nxp.com/part/MIMX8ML4CVNKZAB#/) which does not have the hardware
video encode/decoder module (like the "i.MX 8M Plus Quad" parts).


> is the case the bootloader will fixup your devicetree by disable the
> corresponding nodes, we call this feature-controller:
> 
> https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/imx8mp.dtsi
> 
> As you can see the imx8mp.dtsi is missing the feature bits for the VPU
> but you can check the i.mx8mm.dtsi. Here you can see that barebox will
> check the availability of the vpu:
> 
> https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/imx8mm.dtsi

Ok, thanks, I'll take a look.

Regards
Greg


