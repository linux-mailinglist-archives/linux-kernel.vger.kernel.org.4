Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6977256BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjFGIC6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbjFGICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:02:48 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203871735;
        Wed,  7 Jun 2023 01:02:43 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E591624E307;
        Wed,  7 Jun 2023 16:02:35 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Jun
 2023 16:02:35 +0800
Received: from [192.168.60.122] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Jun
 2023 16:02:35 +0800
Message-ID: <ab89b684-8b49-2088-b0d2-ca362fd9dfb4@starfivetech.com>
Date:   Wed, 7 Jun 2023 16:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] dt-bindings: display: Add yamls for JH7110 display
 subsystem
Content-Language: en-US
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <20230602-uncommon-rejoicing-e73c0c475f9f@spud>
 <TY3P286MB26116576E3E502CAE53834599852A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <1991848.PYKUYFuaPT@diego> <20230606-geometry-blurb-1f0f07d4bf6a@spud>
 <ifgjvonhkzcwrklzch5efguor2x6az4m737dwte4uyow7ar5dr@z4glaxse6dou>
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     undisclosed-recipients:;
In-Reply-To: <ifgjvonhkzcwrklzch5efguor2x6az4m737dwte4uyow7ar5dr@z4glaxse6dou>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/7 14:41, Maxime Ripard wrote:
> On Tue, Jun 06, 2023 at 11:37:53PM +0100, Conor Dooley wrote:
>> On Wed, Jun 07, 2023 at 12:22:33AM +0200, Heiko Stübner wrote:
>> > Am Dienstag, 6. Juni 2023, 20:41:17 CEST schrieb Shengyu Qu:
>> > > > On Fri, Jun 02, 2023 at 03:40:35PM +0800, Keith Zhao wrote:
>> > > >> Add bindings for JH7110 display subsystem which
>> > > >> has a display controller verisilicon dc8200
>> > > >> and an HDMI interface.
>> 
>> > > >> +description:
>> > > >> +  The StarFive SoC uses the HDMI signal transmiter based on innosilicon IP
>> > > > Is innosilicon the same thing as verisilicon? Also
>> > > > s/transmiter/transmitter/, both here and in the title.
yes,innosilicon is the HDMI IP  and verisilicon is the DC-controller IP

>> > > 
>> > > I think that is not the same, I remember Rockchip has used a HDMI 
>> > > transmitter from
>> > > 
>> > > Innosilicon, and there is a existing driver for that in mainline.
>> > 
>> > Yep, I think Innosilicon is the company you turn to when you want to save
>> > a bit of money ;-) . In the bigger SoCs Rockchip most of the time uses
>> > Designware hdmi blocks and looking at the history only the rk3036 ever
>> > used an Innosilicon block.
>> > 
I have done a HDMIcomparison of the rk3036 and the jh7110, and they are both based on ip Innosilicon.

the hardware of them .
Some parts of the hardware of the two are common, such as the logic of hdmi I2C to obtain edid, and the register definition is consistent.

Many registers are defined differently from the linux main line inno driver, including registers that contain specific bits
and some registers in linux main line inno driver no longer used in my new inoo hdmi hardware.

>> > Looking at the history, 2016 really was a long time ago :-D.
>> > 
>> > > So Keith, if that's true, I think it is better to seperate the HDMI 
>> > > stuff and reuse existing driver.
>> > 
>> > I'm not so sure about that - at least from a cursory glance :-) .
>> > 
>> > The registers do look slightly different and I don't know how much
>> > the IP changed between the rk3036-version and the jh7110 version.
>> > 
>> > At the very least, I know my rk3036 board isn't booting right now, so
>> > I can't really provide help for generalizing the rockchip-driver.
>> > 
>> > At the very least both the binding and driver could drop the "starfive-hdmi"
>> > and actually use the Innosilicon in the naming somewhere, so that it's
>> > clear for future developers :-)
>> 
>> Seeing "based on" always makes me a little bit nervous to be honest when
>> it comes to using a compatible from the IP. Is it the IP? What version
>> is it? etc. Perhaps "starfive,jh7110-hdmi" & falling back to some sort
>> of "innosilicon,hdmi" would be more future/IP-silliness proof.
>> Driver can always be generic & bind against "innosilicon,hdmi" until
>> that becomes impossible.
> 
> Given that Neil was saying that there's at least two
> generations/revisions/models of an HDMI controller from Innosilicon, I'm
> not sure that compatible is enough to reach that goal anyway.
> 
> Maxime



I will change the  the binding  to meet innosilicon,hdmi .
for the drivers part , I will study the possibility of RK-HDMI reuse.

Thank you for your comments















