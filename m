Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BF6D1980
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjCaIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCaIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:12:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C1F26BD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:12:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pi9rc-00078K-Vo; Fri, 31 Mar 2023 10:12:01 +0200
Message-ID: <809d5523-e0b4-cad4-f6ab-ddc0e4fe482d@pengutronix.de>
Date:   Fri, 31 Mar 2023 10:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Content-Language: en-US
To:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Greg Ungerer <gerg@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        paul.elder@ideasonboard.com, linux-imx@nxp.com,
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
 <c368a0f8-41f0-69ac-04f4-459e5fc8b9d6@linux-m68k.org>
 <20230328151100.msl46qupstwplkgw@pengutronix.de>
 <792028b9-cd4c-4ff4-a7cb-e60c518aa573@kernel.org>
 <2924b1a62f126678870160bdbbf4e5d51aceb8d4.camel@ew.tq-group.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <2924b1a62f126678870160bdbbf4e5d51aceb8d4.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.23 09:45, Markus Niebel wrote:
> Am Freitag, dem 31.03.2023 um 15:55 +1000 schrieb Greg Ungerer:
>> On 29/3/23 01:11, Marco Felsch wrote:
>>> On 23-03-29, Greg Ungerer wrote:
>> I agree this is the problem, I don't agree that the boot loader is
>> the
>> only place to fix this :-)  I should be able to generate a working
>> devicetree
>> blob from the kernel that is good, and ready to use no runtime
>> changes
>> required I figure.
>>
> 
> Just to point out: the approach of run time fixing in boot loader is
> used for the other i.MX8M SOC, too. If you know exactly what SOC type
> is assembled, you could disable non available IP in the board part of
> your tree.
> 
>> It is not overly difficult to break out the vpu nodes and have them
>> only included when you have a board that has the iMX8MP-quad with the
>> VPU hardware blocks.

This breaks out-of-tree DTs that include imx8mp.dtsi. Logic should be the
other way round: imx8mp.dtsi is full-featured SoC and any new includes
strip away, not add nodes.

> Depending on the SOC type there is more to look for than the VPU: core
> count, ISP, NPU - just to mention a few. Current approach allows to
> keep a single tree for all types.

+1.

@Greg, does your board always ship with an i.MX8MPLite? If so, just
disable VPUs in your board DT.

If it ships with either VPUs available or not and you don't want to do
bootloader fixups, you may want to check out Kbuild's ability to apply
DT overlays at build time. This would give you separate DTs for each
variant while not having an extra file for every combination.

Cheers,
Ahmad


> 
> Regards, Markus
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

