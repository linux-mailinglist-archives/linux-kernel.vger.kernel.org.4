Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF456FDCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjEJLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbjEJLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:34:36 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AB26B6;
        Wed, 10 May 2023 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Drd9Rp7G3op/c5WB1KWoV3yL4EIRVLpWHq5WHbJVCNU=; b=qSHNEJUMk/o43xuFsiD0NAB/6E
        x8FIjknL0URrrwRnWQlz+TH5rt5A5Ldxcn6AFWOtJw1A7r2mUDkIzhdxk/jSf5Bs96PEr3mP7h3ec
        0dGWaRYUTycEsTLlKwctQ6k3XM0AaoKviMz5ikjtdn0pFMiFQPUgMRtO8IY/166Pe3Pmq0Nyn1OZs
        nohEXghR6kHmvmXnxH0B1GCKPgJ+lcl3wxH2HM5X0UJbOvE43zPj/xskZqaRJcuvE1b5/1z+yNkOO
        gyzniSlNnUbvd97tXrP3+7YuhEg+bKGCALxfZELY1puJDtg3aJjsLEWk6BRVCaMyLfwVJwOmaTbeD
        oOX72QNw==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pwi55-007shm-6B; Wed, 10 May 2023 12:34:03 +0100
Date:   Wed, 10 May 2023 12:34:03 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: sun5i: chip: Enable bluetooth
Message-ID: <ZFuBK9HYmsh/J1zZ@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <f26d11e613df7bd55822ff3fb7689e36bf9e4f7a.1681580558.git.noodles@earth.li>
 <20230416012421.255bfd19@slackpad.lan>
 <ZEGOk1isRhaekk3h@earth.li>
 <CAGETcx-UnEK3CPC38Ef3gmHcq46nXSJbA9QAwEsF+Xt2bDKEWA@mail.gmail.com>
 <ZEJJGGeIu8QW44mh@earth.li>
 <CAGETcx8JDYUT2bdDhJ0PN8_CPmHJ37jCfnuoav6CGFJoovfSqA@mail.gmail.com>
 <ZEa9rcDlIOn+df5h@earth.li>
 <CAGETcx8OK-DNM2hJb2sz0jDyKBRqtmPRxnk_acKgB0pfrD0_JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8OK-DNM2hJb2sz0jDyKBRqtmPRxnk_acKgB0pfrD0_JA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 02:12:05PM -0700, Saravana Kannan wrote:
> On Mon, Apr 24, 2023 at 10:34 AM Jonathan McDowell <noodles@earth.li> wrote:
> >
> > On Fri, Apr 21, 2023 at 03:45:52PM -0700, Saravana Kannan wrote:
> > > On Fri, Apr 21, 2023 at 1:28 AM Jonathan McDowell <noodles@earth.li> wrote:
> > > >
> > > > On Thu, Apr 20, 2023 at 06:43:06PM -0700, Saravana Kannan wrote:
> > > > > On Thu, Apr 20, 2023 at 12:12 PM Jonathan McDowell <noodles@earth.li> wrote:
> > > > > > On Sun, Apr 16, 2023 at 01:24:21AM +0100, Andre Przywara wrote:
> > > > > > > On Sat, 15 Apr 2023 18:46:03 +0100
> > > > > > > Jonathan McDowell <noodles@earth.li> wrote:
> > > > > > >
> > > > > > > > The C.H.I.P has an rtl8723bs device with the bluetooth interface hooked
> > > > > > > > up on UART3. Support for this didn't exist in mainline when the DTS was
> > > > > > > > initially added, but it does now, so enable it.
> > > > > > > >
> > > > > > > > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > > > > > > > ---
> > > > > > > >  arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
> > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > > > index fd37bd1f3920..4d72a181d8aa 100644
> > > > > > > > --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > > > +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > > > @@ -255,6 +255,10 @@ &uart3 {
> > > > > > > >     pinctrl-0 = <&uart3_pg_pins>,
> > > > > > > >                 <&uart3_cts_rts_pg_pins>;
> > > > > > > >     status = "okay";
> > > > > > > > +
> > > > > > > > +   bluetooth {
> > > > > > > > +           compatible = "realtek,rtl8723bs-bt";
> > > > > > > > +   }
> > > > > > >
> > > > > > > As the kernel test robot already pointed out, there is a semicolon
> > > > > > > missing here.
> > > > > > > Otherwise looks good (dt-validate passes), but don't know if there are
> > > > > > > any wakeup GPIOs connected (can't seem to find a schematic?).
> > > > > >
> > > > > > So there are wakeups, but if I add:
> > > > > >
> > > > > >         device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_LOW>;
> > > > > >         host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> > > > > >
> > > > > > then some odd sort of dependency issue happens where the serial port
> > > > > > load is deferred waiting for the GPIO to appear, and then the device
> > > > > > doesn't work.
> > > > >
> > > > > When you say your device doesn't work, are you saying it never probes?
> > >
> > > Read your whole email and it's a strange issue. Also, going forward to
> > > avoid confusion, only reply to questions with respect to 6.3-rc7.
> 
> Sorry it took a while to respond. Life got busy.

No problem, I appreciate you looking into this.

> > Just to be clear, in my initial mail I referred to 6.1.21 as that's
> > where I started, but in my reply to you all output was quoted from
> > 6.3-rc7. 6.3 has been released since, so all details below are based on
> > that.
> >
> > > > The bluetooth device (realtek,rtl8723bs-bt) never appears, apparently
> > > > because the UART it's attached to never loads - it doesn't even try to
> > > > load the firmware.
> > > >
> > > > > <debugfs>/devices_deferred should tell you what devices have deferred and why.
> > > >
> > > > root@chip:~# cat /sys/kernel/debug/devices_deferred
> > > > serial0-0
> > >
> > > Do you see this in 6.3-rc7 too?
> >
> > That was under 6.3-rc7. I see it on 6.3 too:
> >
> > root@chip:~# cat /sys/kernel/debug/devices_deferred
> > serial0-0
> 
> I somehow didn't connect the dots earlier... but serial0-0 is NOT the
> uart/serial device. It's the child device of serial0 and in this case,
> it's the bluetooth device.
> 
> So adding those gpios in DT is not breaking serial. It's just
> preventing the BT device from probing.

Aaaaah.

> Looking at the logs in the non-working case:
> 
> [    0.715083] 1c28c00.serial: ttyS1 at MMIO 0x1c28c00 (irq = 53,
> base_baud = 1500000) is a U6_16550A
> [    0.724132] device: 'serial0': device_add
> 
> I don't know why all of the ttySx are showing up as serial0, but this
> is the serial port. As you can see 1c28c00 is already probing.
> 
> [    0.724228] device: 'serial0-0': device_add
> 
> This is the child devices getting populated. In this case this is the BT device.
> 
> [    0.724311] device: 'platform:1c20800.pinctrl--serial:serial0-0': device_add
> 
> I can tell it's the BT device because we see a device link being
> created between pinctrl and serial:serial0-0. So it's a device sitting
> on the serial bus.
> 
> [    0.724378] devices_kset: Moving serial0-0 to end of list
> [    0.724390] serial serial0-0: Linked as a consumer to 1c20800.pinctrl
> [    0.724401] /soc/serial@1c28c00/bluetooth Dropping the fwnode link
> to /soc/pinctrl@1c20800
> 
> And the fwnode like that was converted to device link clearly shows
> that the serial0-0 corresponds to the bluetooth node.
> 
> [    0.724441] serial serial0: tty port ttyS1 registered
> 
> Serial port works.
> 
> >
> > Without the device-wake-gpios line in the device tree it's empty.
> 
> I think the issue is at the BT driver level or some other framework.
> 
> Add a print at the start of the BT driver to see if the probe() is
> actually getting called. I'm guessing it is and it's returning an
> error from within.
> 
> If you don't see that print, then debug the really_probe() function to
> see how far within it the BT device goes through before it errors out.
> It's possible pinctrl_bind_pins() in really_probe() fails for the BT
> device because of how the GPIO pins are configured in your DT.

Thank you! That was exactly the pointer I needed to go and find the
actual issue, which is a real facepalm moment. The AXP209 driver does
not have support for GPIO3 (which is in a different register and needs a
bunch of special casing). So the Bluetooth driver tries to request it
and gets failures, so can't complete the probe.

I've added support to the pinctrl-axp209 driver for GPIO3 and everything
is working just fine now. I'll get that cleaned up and a v2 patch set
submitted. Thanks for all your help.

J.

-- 
101 things you can't have too much of : 49 - Bandwidth.
This .sig brought to you by the letter V and the number  8
Product of the Republic of HuggieTag
