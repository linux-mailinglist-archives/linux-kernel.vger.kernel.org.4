Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837D363C7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiK2S52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiK2S4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:56:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB161BA1;
        Tue, 29 Nov 2022 10:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A129F61890;
        Tue, 29 Nov 2022 18:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A686AC433D6;
        Tue, 29 Nov 2022 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669748177;
        bh=RGuIOhXviKMq41t9CeKW7AFIl48krHdo1X9sgB4ZdIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqVmxaBrBK/XMgdJsfjXkBWJMoeKNTSD6JzHwzxEnFDViQ6xizXwo81TcHZGu4FIZ
         Utbh2JbHpkcwTIuMXC6hoxkUM+ZCRlNieNOWq6TcrVg4SWj8i/LqXVg99SzZYhvpBf
         s47s0MEJ3FtXp/ung6zU1M/CpE8euE0ZLLsc3qGAHEFTtopCJX/UYzhVRSByPFTGnS
         HSNRV7lidXOd2iZzCkzOVgGhPfwxvtAI7EZYPLlvpZe7iveych5nYEirbR9GPu6Udk
         HqYUzDqsas0wusqbQqT8oS4lfCVkYg0HRK1eJl9FHYDOt5UagIqkFQR8Jj3pTaXK8j
         FVMCAlodl4WiQ==
Received: by pali.im (Postfix)
        id B3076898; Tue, 29 Nov 2022 19:56:13 +0100 (CET)
Date:   Tue, 29 Nov 2022 19:56:13 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Josef Schlehofer <josef.schlehofer@nic.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Add channel labels for
 temperature sensor
Message-ID: <20221129185613.gunub5hgjfgvroh5@pali>
References: <20220930123901.10251-1-pali@kernel.org>
 <20220930124618.kyaansrl7ls5kn3i@pali>
 <20221009120506.itwa4n25nljn2tll@pali>
 <20221101224348.xkpzucskunn46i5z@pali>
 <87k03eblsr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k03eblsr.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2022 12:18:28 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > Michael, could you take this patch?
> 
> Yep.
> 
> With these dts patches it always helps if you tell me that it passes the
> DT schema checks, so that I don't get yelled at by the DT people :)

Mostly dt schemas for p1/p2 are incomplete, I sent more patches but they
are waiting and I was not able to setup & run dt schema checker. Hence
I tested everything on the hardware to ensure that it works correctly.
And this patch works on Turris 1.1 board, I also tested sensors tool.
So the important is what is in DTS file, the stuff which is used on HW.

> cheers
> 
> > On Sunday 09 October 2022 14:05:06 Pali Rohár wrote:
> >> On Friday 30 September 2022 14:46:18 Pali Rohár wrote:
> >> > + CC hwmon ML
> >> > 
> >> > On Friday 30 September 2022 14:39:01 Pali Rohár wrote:
> >> > > Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor (chip
> >> > > itself is located on the board) and channel 1 of SA56004ED chip refers to
> >> > > external sensor which is connected to temperature diode of the P2020 CPU.
> >> > > 
> >> > > Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> >> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> >> > > ---
> >> > > With this change userspace 'sensors' applications prints labels:
> >> > > 
> >> > >     $ sensors
> >> > >     sa56004-i2c-0-4c
> >> > >     Adapter: MPC adapter (i2c@3000)
> >> > >     board:        +34.2°C  (low  =  +0.0°C, high = +70.0°C)
> >> > >                            (crit = +85.0°C, hyst = +75.0°C)
> >> > >     cpu:          +58.9°C  (low  =  +0.0°C, high = +70.0°C)
> >> > >                            (crit = +85.0°C, hyst = +75.0°C)
> >> > > 
> >> > > And without this change it prints just generic tempX names:
> >> > > 
> >> > >     $ sensors
> >> > >     sa56004-i2c-0-4c
> >> > >     Adapter: MPC adapter (i2c@3000)
> >> > >     temp1:        +43.0°C  (low  =  +0.0°C, high = +70.0°C)
> >> > >                            (crit = +85.0°C, hyst = +75.0°C)
> >> > >     temp2:        +63.4°C  (low  =  +0.0°C, high = +70.0°C)
> >> > >                            (crit = +85.0°C, hyst = +75.0°C)
> >> > > ---
> >> > >  arch/powerpc/boot/dts/turris1x.dts | 14 ++++++++++++++
> >> > >  1 file changed, 14 insertions(+)
> >> > > 
> >> > > diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> >> > > index 4033c554b06a..5b5278c32e43 100644
> >> > > --- a/arch/powerpc/boot/dts/turris1x.dts
> >> > > +++ b/arch/powerpc/boot/dts/turris1x.dts
> >> > > @@ -69,6 +69,20 @@
> >> > >  				interrupt-parent = <&gpio>;
> >> > >  				interrupts = <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
> >> > >  					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
> >> > > +				#address-cells = <1>;
> >> > > +				#size-cells = <0>;
> >> > > +
> >> > > +				/* Local temperature sensor (SA56004ED internal) */
> >> > > +				channel@0 {
> >> > > +					reg = <0>;
> >> > > +					label = "board";
> >> > > +				};
> >> > > +
> >> > > +				/* Remote temperature sensor (D+/D- connected to P2020 CPU Temperature Diode) */
> >> > > +				channel@1 {
> >> > > +					reg = <1>;
> >> > > +					label = "cpu";
> >> > > +				};
> >> > 
> >> > I'm not sure if you want UPPERCASE, lowercase, PascalCase, kebab-case
> >> > or snake_case format of labels. Or if you want also "temp" or
> >> > "temperature" keyword in the label. So please adjust label to the
> >> > preferred one, if proposed format is not the correct.
> >> 
> >> Ok, if nobody complains then please take this patch as is.
> >> 
> >> > >  			};
> >> > >  
> >> > >  			/* DDR3 SPD/EEPROM */
> >> > > -- 
> >> > > 2.20.1
> >> > > 
