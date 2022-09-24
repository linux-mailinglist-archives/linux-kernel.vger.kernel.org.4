Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE26A5E8C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiIXMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiIXMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2560EA;
        Sat, 24 Sep 2022 05:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05A5612B9;
        Sat, 24 Sep 2022 12:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E68C433D6;
        Sat, 24 Sep 2022 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664021016;
        bh=lMsPphrkpmvBuxrpjVK2x+AlRbY1TOLztXjW1MgzoCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCdFqbMXJ/DSuvHB9Do+wLvCGPkmOrwMIire9EGLUT/+vG8YrdnF3U6gv3+kx1lql
         HtGBRzGCbi6c+EfqNAD6+TkfDzzeAFYyz/W2O+Q/EN2G0Rm3l9lRMFs6JeziRprMSl
         7LyZAnCM/uobgtgOTJfexJZwvRAn2upuQDnEOR16V5R71IIWRwApXNZ4al1K0/SVQ6
         4KihoFBticY3eIfjGG9msv1PAwFi+FcuFFq+BpXagjvGknkvVZKVVOeqn4fCeXk+gn
         1PuVBWj0SmIU2vZKY5cPk+lRw151o2cFaEXLOzjN/TgORLCU04fTI17+6BXmZIMYXn
         6TzoZu4BD6TfQ==
Received: by pali.im (Postfix)
        id 5C7738A2; Sat, 24 Sep 2022 14:03:33 +0200 (CEST)
Date:   Sat, 24 Sep 2022 14:03:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: marvell: espressobin-ultra: add PHY and
 switch reset pins
Message-ID: <20220924120333.arrmvh4kujcobi3x@pali>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
 <20210927154159.2168500-3-robert.marko@sartura.hr>
 <20210928153251.ogmtnpg3slhp4lb7@pali>
 <CA+HBbNEhfSo-sb28j3A7MOM6wDFurGaeoU+3mmVmZbducoQ-Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNEhfSo-sb28j3A7MOM6wDFurGaeoU+3mmVmZbducoQ-Eg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2021 18:02:19 Robert Marko wrote:
> On Tue, Sep 28, 2021 at 5:32 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Monday 27 September 2021 17:41:58 Robert Marko wrote:
> > > Both the Topaz switch and 88E1512 PHY have their reset and interrupts
> > > connected to the SoC.
> > >
> > > So, define the Topaz and 88E1512 reset pins in the DTS.
> >
> > Are reset pins connected only on ultra variant? Or on all espressobin
> > variants? Because if they are on all variants then definitions should go
> > into common dtsi file.
> >
> > I see that "gpionb 2" is on v7 variant connected to LED2. So I'm not
> > sure if this one gpio is also shared or not.
> 
> As far as I know only Ultra has the reset pins connected, on the v5 and v7 Topaz
> reset is tied to the system reset so it's not controllable.
> I checked both the v5 and v7 schematics and it's like that.
> >
> > > Defining the interrupt pins wont work as both the 88E1512 and the
> > > Topaz switch uses active LOW IRQ signals but the A37xx GPIO controller
> > > only supports edge triggers.
> > > 88E1512 would require special setup anyway as its INT pin is shared with
> > > the LED2 and you first need to configure it as INT.
> >
> > Do you plan to finish also this additional setup?
> 
> Yes as the MOCHAbin board that I have sent the DTS for also has it connected
> so I can use it as Armada 7040 supports level triggers, unlike the A3720.
> It's in the queue but as a low priority, so I don't know when will I get to it.

I have WIP patch for A37xx gpio/pinctrl driver which adds support for
level interrupts. I think you would need it for testing...

> Regards,
> Robert
> >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > > index 8a700afd0570..96855a10b4a0 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > > @@ -118,12 +118,16 @@ &usb3 {
> > >  &mdio {
> > >       extphy: ethernet-phy@1 {
> > >               reg = <1>;
> > > +
> > > +             reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
> > >       };
> > >  };
> > >
> > >  &switch0 {
> > >       reg = <3>;
> > >
> > > +     reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
> > > +
> > >       ports {
> > >               switch0port1: port@1 {
> > >                       reg = <1>;
> > > --
> > > 2.31.1
> > >
> 
> 
> 
> -- 
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura Ltd.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr
