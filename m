Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA16CB431
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC1CeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1CeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:34:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD073A2;
        Mon, 27 Mar 2023 19:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EDBEB819D3;
        Tue, 28 Mar 2023 02:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73ABC433D2;
        Tue, 28 Mar 2023 02:34:10 +0000 (UTC)
Message-ID: <ea780248-41ea-e6c1-bdc0-3caf4199cfca@linux-m68k.org>
Date:   Tue, 28 Mar 2023 12:34:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "gerg@kernel.org" <gerg@kernel.org>
References: <20220713063653.2584488-6-peng.fan@oss.nxp.com>
 <20230327050642.593778-1-gerg@linux-m68k.org>
 <DU0PR04MB94174D60EE38B56FEB6CD5BC888B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87e68e05-8512-17fc-584c-0022ddefb8f0@linux-m68k.org>
 <DU0PR04MB94172ECC59D563B782DBAA5888889@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <DU0PR04MB94172ECC59D563B782DBAA5888889@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/3/23 12:15, Peng Fan wrote:
> 
> 
>> -----Original Message-----
>> From: Greg Ungerer <gerg@linux-m68k.org>
>> Sent: 2023年3月27日 21:24
>> To: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS)
>> <peng.fan@oss.nxp.com>
>> Cc: Markus.Niebel@ew.tq-group.com; aford173@gmail.com; Aisheng Dong
>> <aisheng.dong@nxp.com>; alexander.stein@ew.tq-group.com;
>> devicetree@vger.kernel.org; festevam@gmail.com; kernel@pengutronix.de;
>> krzysztof.kozlowski+dt@linaro.org; l.stach@pengutronix.de;
>> laurent.pinchart@ideasonboard.com; linux-arm-kernel@lists.infradead.org;
>> dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org;
>> marex@denx.de; paul.elder@ideasonboard.com; robh+dt@kernel.org;
>> s.hauer@pengutronix.de; shawnguo@kernel.org; gerg@kernel.org
>> Subject: Re: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
>>
>> Hi Peng,
>>
>> On 27/3/23 20:01, Peng Fan wrote:
>>>> Subject: Re: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
>>>>
>>>> On 22/8/22 14:45, Peng Fan wrote:
>>>>> Add i.MX8MP PGC nodes for vpu, which are used to supply power for
>> VPU.
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>>>>> ---
>>>>>    arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27
>>>>> +++++++++++++++++++++++
>>>>>    1 file changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>> index 0b165f98a82c..34af983b0210 100644
>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>> @@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
>>>>>                                                   reg =
>>>> <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
>>>>>                                                   clocks = <&clk
>> IMX8MP_CLK_MEDIA_ISP_ROOT>;
>>>>>                                           };
>>>>> +
>>>>> +                                       pgc_vpumix: power-domain@19 {
>>>>> +                                               #power-domain-cells = <0>;
>>>>> +                                               reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
>>>>> +                                               clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
>>>>> +                                       };
>>>>> +
>>>>> +                                       pgc_vpu_g1: power-domain@20 {
>>>>> +                                               #power-domain-cells = <0>;
>>>>> +                                               power-domains = <&pgc_vpumix>;
>>>>> +                                               reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
>>>>> +                                               clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
>>>>> +                                       };
>>>>> +
>>>>> +                                       pgc_vpu_g2: power-domain@21 {
>>>>> +                                               #power-domain-cells = <0>;
>>>>> +                                               power-domains = <&pgc_vpumix>;
>>>>> +                                               reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
>>>>> +                                               clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
>>>>> +                                       };
>>>>> +
>>>>> +                                       pgc_vpu_vc8000e: power-domain@22 {
>>>>> +                                               #power-domain-cells = <0>;
>>>>> +                                               power-domains = <&pgc_vpumix>;
>>>>> +                                               reg =
>>>> <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
>>>>> +                                               clocks = <&clk
>>>> IMX8MP_CLK_VPU_VC8KE_ROOT>;
>>>>> +                                       };
>>>>>                                   };
>>>>>                           };
>>>>>                   };
>>>>
>>>> This change causes new error messages to come out during boot, for
>>>> example:
>>>>
>>>>       ...
>>>>       imx-pgc imx-pgc-domain.8: failed to command PGC
>>>>       imx-pgc imx-pgc-domain.8: failed to command PGC
>>>>       imx-pgc imx-pgc-domain.8: failed to command PGC
>>>>       30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 197,
>>>> base_baud =
>>>> 1500000) is a IMX
>>>>       ...
>>>>       hwmon hwmon1: temp1_input not attached to any thermal zone
>>>>       imx-pgc imx-pgc-domain.8: failed to command PGC
>>>>       imx-pgc imx-pgc-domain.8: failed to command PGC
>>>>       imx-pgc imx-pgc-domain.8: failed to command PGC
>>>>       ...
>>>>
>>>> They don't seem to cause any problems on the hardware I am using,
>>>> well, at least not that I have found so far.
>>>>
>>>> This first appeared for me in linux-6.1. But it is the same in todays
>>>> linux 6.3- rc4. Reverting this change (not completely trivial due to
>>>> a couple of commits after it that rely on it) fixes it - no more errors.
>>> [Peng Fan]
>>>
>>> The VPU BLK CTRL seems not enabled.
>>
>> How to enable it?
>> I have the blk-ctrl config options enabled:
>>
>>       #
>>       # i.MX SoC drivers
>>       #
>>       CONFIG_IMX_GPCV2_PM_DOMAINS=y
>>       CONFIG_SOC_IMX8M=y
>>       CONFIG_SOC_IMX9=y
>>       CONFIG_IMX8M_BLK_CTRL=y
>>       CONFIG_IMX9_BLK_CTRL=y
>>       # end of i.MX SoC drivers
>>
>> Running with the full arm64 defconfig and using the imx8mp-evk.dtb still
>> outputs these messages:
>>
>>       [   18.150679] imx-pgc imx-pgc-domain.8: failed to command PGC
>>       [   18.159241] imx-pgc imx-pgc-domain.8: failed to command PGC
>>       [   18.167822] imx-pgc imx-pgc-domain.8: failed to command PGC
>>
>> Or do you mean something more fundamental, like the hardware block not
>> being enabled by boot loader?  (Something to keep in mind is that the
>> platform I am using has no video output, only serial console).
> [Peng Fan]
> 
> The imx8mp vpu blk ctrl already in imx8m-blk-ctrl.c, so it should work.
> Have you enabled imx8mp interconnect driver?
> CONFIG_INTERCONNECT_IMX8MP

Yes, it is enabled:

     CONFIG_INTERCONNECT=y
     CONFIG_INTERCONNECT_IMX=y
     # CONFIG_INTERCONNECT_IMX8MM is not set
     # CONFIG_INTERCONNECT_IMX8MN is not set
     # CONFIG_INTERCONNECT_IMX8MQ is not set
     CONFIG_INTERCONNECT_IMX8MP=y

Regards
Greg


