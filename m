Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEC5F0F20
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiI3Pk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3PkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CB79A41;
        Fri, 30 Sep 2022 08:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22EF96239F;
        Fri, 30 Sep 2022 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DC4C433D6;
        Fri, 30 Sep 2022 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664552411;
        bh=BTRN9+H2vdtq8ALBlYzWaaxmawleBBNHN47RA04/iTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9ahcQU1FGRkEwQoOOr7qjpezYPv60K3JG2A9/JSAyMIw18k2j2Mx7aXCKzl/VVE5
         FBT8S6DQ+G/mp9JtgR0ToY1JZq8EMn9cIPEKXifCDYfI2m/3ANsdGh9KXueTNnMg6l
         moeMmBj5bxr1MhmkG2nZU3j7cDgkON8I4JYyAJnXiazViKzkYHvOyCzCxS91/gSszc
         6f8Dfg3T0XXMEQTFT+21GMCXhR1q1WQLNqk5EbyF91vu7khRgGM3Gv5iSVyQJ1m46z
         Co1YbvgfeY2LF42hEFssWmNaVOCuCzMF5VgNg8j4nlwTSnVwPU6gsazQ4NweResLN/
         eLVqoXawUgFBQ==
Received: by pali.im (Postfix)
        id F201393F; Fri, 30 Sep 2022 17:40:07 +0200 (CEST)
Date:   Fri, 30 Sep 2022 17:40:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>,
        "maukka@ext.kapsi.fi" <maukka@ext.kapsi.fi>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based
 on Device Tree
Message-ID: <20220930154007.rsrz6ezvdpwlx6d7@pali>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
 <YyzPVMrfcOkvngxl@lunn.ch>
 <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi>
 <Yy2iqE8XgXe8qYd9@lunn.ch>
 <20220923180226.vmjcefxlujg2r6u3@pali>
 <74f2b413a617a4315cc34a0ef386dd8d@ext.kapsi.fi>
 <20220926122318.qmt4dnes7caua333@pali>
 <BN9PR18MB4251A251E516E3ECD35F4E94DB549@BN9PR18MB4251.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB4251A251E516E3ECD35F4E94DB549@BN9PR18MB4251.namprd18.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Elad! Thank you very much for this information!

With information from other resources, I think I understood it.


Andrew & Mauri: here is my recap:

On https://docs.kernel.org/arm/marvell.html is Datasheet document for
88F5281 SoC (it is different! not 88F5181!) and in its section 3.2
Device Pins Multiplexing it is documented. SoC pins named MPP[0], ...
MPP[19] are configured via registers 0x10000, 0x10004 and 0x10050 as
documented in User Manual. And SoC pins named DEV_D[16], ... DEV_D[31]
are configured via that undocumented register 0x10008.

Normally 32 DEV_D pins on 88F5281 SoC are used for Device Bus Interface
but when SoC has configured only 16-bit or 8-bit Device Bus or it does
not use Device Bus Interface at all then pins DEV_D[16] ... DEV_D[31]
can be used as GPIOs.

Elad wrote that clearing particular bit _i_ in 0x10008 sets DEV_D[i] on
88F5181 to GPIO but datasheet for 88F5281 says that clearing bit i
(value 0x0) sets DEV_D[i] to Device Bus mode.

I have no idea if 88F5281 and 88F5181 have inverted logic or if
documentation has bugs. But at least it this explanation makes sense for
me.

So code "writel(0, MPP_DEV_CTRL);" either changes all DEV_D pins to GPIO
mode or to Device Bus Interface mode.

In most cases Device Bus is used for connecting Parallel NAND or any
similar Flash memory device. Mauri, you can check if your board has
such memory. Or if it uses GPIOs connected on DEV_D pins. If not then it
does not matter how you set that register.

Anyway, just for completeness, the "proper" way for using MPP_DEV_CTRL
should have been in pinctrl/mvebu/pinctrl-orion.c driver. But I think it
does not make sense to spend another time for this old board to convert
this code into proper pinctrl driver.

Hopes that this helps to finally understand that old undocumented mystery.

On Wednesday 28 September 2022 13:32:27 Elad Nachman wrote:
> Hi Pali,
> 
> I do not have documentation for this controller, as it is almost 20 years old...
> 
> I did manage, however, to find some very old u-boot code for it.
> 
> From reverse engineering this u-boot code, it looks like this is a "DEV" MPP function register, similar to the MPP0_7, MPP8_15 and the MPP16_23 registers.
> 
> Basically, setting bits of this registers assign the pin to the special purpose, while clearing it makes it a GPP (General Purpose Pin).
> 
> For all of the boards (over half a dozen) support by this u-boot, this register is set to zero (see above).
> From user guides I have found for few of these boards, only MPPs up to MPP19 are used, hence it make sense to leave these MPPs as GPPs .
> 
> Hopefully this helps in some way.
> 
> FYI,
> 
> Elad.
> 
> 
> -----Original Message-----
> From: Pali Rohár <pali@kernel.org> 
> Sent: Monday, September 26, 2022 3:23 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: maukka@ext.kapsi.fi; Andrew Lunn <andrew@lunn.ch>; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; arnd@arndb.de; olof@lixom.net; sebastian.hesselbarth@gmail.com; gregory.clement@bootlin.com; linux@armlinux.org.uk; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device Tree
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hello Elad! I hope that would not bothering you. We are doing here cleanup of kernel code for older Marvell SoCs (Orion) and there one unknown thing about 88F5181's 0x10008 register. See below.
> 
> On Monday 26 September 2022 14:56:48 maukka@ext.kapsi.fi wrote:
> > On 23.9.2022 21:02, Pali Rohár wrote:
> > > On Friday 23 September 2022 14:12:24 Andrew Lunn wrote:
> > > > > > > +	if (of_machine_is_compatible("dlink,dns323a1")) {
> > > > > > > +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
> > > > > >
> > > > > > I spotted this in dns323-setup.c as well. Do you have any idea 
> > > > > > what it does?
> > > > > >
> > > > >
> > > > > No idea. I have tried to replicate what was in dns323-setup.c as 
> > > > > exactly as possible.
> > > > > I can try to leave it out and see if anything changes.
> > > > 
> > > > It is best to keep what we don't understand. It will be there for 
> > > > a reason.
> > > > 
> > > > 	Andrew
> > > 
> > > Hello! I tried to index all publicly available Marvell SoC 
> > > documentations into kernel documentation subfolder:
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.kernel.org
> > > _arm_marvell.html&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXc
> > > zjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=QnvtICgYrknBcrJ4SBYkL8zUxNtqo3A40bjE
> > > TmCHhBbdWQOUaRffkiMgtuRkQ2WE&s=QiNvxcOSpDNOTgiK8nuCZ18pgJRKBtgVu-SeG
> > > E9n7CY&e=
> > > 
> > > For Orion there is linked Datasheet and User Manual, so you could 
> > > try to find in those documents that mentioned register and check 
> > > what it is doing.
> > 
> > MPP_DEV_CTRL refers to register at address 0x10008. According to the 
> > 88F5152 user manual it's 'Device Multiplex Control Register' Offset: 
> > 0x10008.
> > 
> > Bits    Field     Type/InitVal     Description
> > [31:0]  Reserved  RES 0x03FF0000   Reserved. NOTE: Must be 0x03FF0000'.
> > 
> > DEV_D[31:16] receives no hits in the documentation, only to 
> > DEV_D[15:0] are referred.
> 
> In linked public document I found same thing. Register is for 88F5182 reserved. (You have typo in comment, it is 88F5182, not *52).
> 
> > Maybe 88F5151 is different, hard to say.
> 
> I have feeling that for 88F5181 it is not reserved and has to be configured correctly. (Also typo in your comment, it is 88F5181, not *51).
> But I have not found any copy of 88F5181 user manual document on internet.
> 
> In past 88F518x and 88F528x documents and user manuals were available publicly on Marvell website, visible from web archive:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__web.archive.org_web_20080607215437_http-3A__www.marvell.com_products_media_index.jsp&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=QnvtICgYrknBcrJ4SBYkL8zUxNtqo3A40bjETmCHhBbdWQOUaRffkiMgtuRkQ2WE&s=k1vn2-NVEU2OsJYVTmuWMRKdN2t1MQ9pduTkGaasU4s&e=  
> 
> But Marvell deleted these documents from their public website and for kernel developers they are now probably lost. I do not know about any other backups.
> 
> 
> Elad, could you please help us? Do you have access to functional specifications / user manuals for 88F518x and 88F528x or have information how kernel developers can get access to those documents?
> Hopefully they were not totally lost. We just need explanation for register 'Device Multiplex Control Register' Offset: 0x10008.
