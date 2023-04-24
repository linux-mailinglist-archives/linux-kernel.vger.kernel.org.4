Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86E16ED390
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjDXRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjDXRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:34:59 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4C6599;
        Mon, 24 Apr 2023 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MALtH7KdH2u58m3ORCeTHdlEibD9lD3fggU3i60p380=; b=H9HsbaBLjOCvrt/dB9ebYNHoE7
        GMLZhTfS+cQXxKiL+lP+lbeQRSbegOnpUf8PXbCI7ZTT4ywxOeXw/PvDgVX3MZakxZplZisWFj+g6
        RN5ulsX/fgpz5g2/rs9vhmwjw/6loibDBlGxJKOX0kM72NbzPPxXqGzjB0NAaAb6V8rKA3OiqBGvW
        J9kTrMs5jD5su6BSHRrDU2Gbjpti5EHa354wcFj0aDpEIaykCUg38ML2ZyA9pNJuXOfrRHYNGmhO0
        7RBH23A7ZzR17zXOFIHsQ1N4Kw3iuHkTeIWBxE2a8E+fdb3z2dXu+ivTroN5h4bxYWEdDSz7+eTU7
        IbG7CImQ==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pr05F-0060iO-CP; Mon, 24 Apr 2023 18:34:37 +0100
Date:   Mon, 24 Apr 2023 18:34:37 +0100
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
Message-ID: <ZEa9rcDlIOn+df5h@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <f26d11e613df7bd55822ff3fb7689e36bf9e4f7a.1681580558.git.noodles@earth.li>
 <20230416012421.255bfd19@slackpad.lan>
 <ZEGOk1isRhaekk3h@earth.li>
 <CAGETcx-UnEK3CPC38Ef3gmHcq46nXSJbA9QAwEsF+Xt2bDKEWA@mail.gmail.com>
 <ZEJJGGeIu8QW44mh@earth.li>
 <CAGETcx8JDYUT2bdDhJ0PN8_CPmHJ37jCfnuoav6CGFJoovfSqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8JDYUT2bdDhJ0PN8_CPmHJ37jCfnuoav6CGFJoovfSqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:45:52PM -0700, Saravana Kannan wrote:
> On Fri, Apr 21, 2023 at 1:28 AM Jonathan McDowell <noodles@earth.li> wrote:
> >
> > On Thu, Apr 20, 2023 at 06:43:06PM -0700, Saravana Kannan wrote:
> > > On Thu, Apr 20, 2023 at 12:12 PM Jonathan McDowell <noodles@earth.li> wrote:
> > > > On Sun, Apr 16, 2023 at 01:24:21AM +0100, Andre Przywara wrote:
> > > > > On Sat, 15 Apr 2023 18:46:03 +0100
> > > > > Jonathan McDowell <noodles@earth.li> wrote:
> > > > >
> > > > > > The C.H.I.P has an rtl8723bs device with the bluetooth interface hooked
> > > > > > up on UART3. Support for this didn't exist in mainline when the DTS was
> > > > > > initially added, but it does now, so enable it.
> > > > > >
> > > > > > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > index fd37bd1f3920..4d72a181d8aa 100644
> > > > > > --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > @@ -255,6 +255,10 @@ &uart3 {
> > > > > >     pinctrl-0 = <&uart3_pg_pins>,
> > > > > >                 <&uart3_cts_rts_pg_pins>;
> > > > > >     status = "okay";
> > > > > > +
> > > > > > +   bluetooth {
> > > > > > +           compatible = "realtek,rtl8723bs-bt";
> > > > > > +   }
> > > > >
> > > > > As the kernel test robot already pointed out, there is a semicolon
> > > > > missing here.
> > > > > Otherwise looks good (dt-validate passes), but don't know if there are
> > > > > any wakeup GPIOs connected (can't seem to find a schematic?).
> > > >
> > > > So there are wakeups, but if I add:
> > > >
> > > >         device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_LOW>;
> > > >         host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> > > >
> > > > then some odd sort of dependency issue happens where the serial port
> > > > load is deferred waiting for the GPIO to appear, and then the device
> > > > doesn't work.
> > >
> > > When you say your device doesn't work, are you saying it never probes?
> 
> Read your whole email and it's a strange issue. Also, going forward to
> avoid confusion, only reply to questions with respect to 6.3-rc7.

Just to be clear, in my initial mail I referred to 6.1.21 as that's
where I started, but in my reply to you all output was quoted from
6.3-rc7. 6.3 has been released since, so all details below are based on
that.

> > The bluetooth device (realtek,rtl8723bs-bt) never appears, apparently
> > because the UART it's attached to never loads - it doesn't even try to
> > load the firmware.
> >
> > > <debugfs>/devices_deferred should tell you what devices have deferred and why.
> >
> > root@chip:~# cat /sys/kernel/debug/devices_deferred
> > serial0-0
> 
> Do you see this in 6.3-rc7 too?

That was under 6.3-rc7. I see it on 6.3 too:

root@chip:~# cat /sys/kernel/debug/devices_deferred
serial0-0

Without the device-wake-gpios line in the device tree it's empty.

> > > > Error in dmesg is:
> > > >
> > > > serial serial0-0: deferred probe pending
> > > >
> > > > on 6.3-rc and on 6.1 I get:
> > > >
> > > > dw-apb-uart 1c28c00.serial: Failed to create device link (0x180) with axp20x-gpio
> > >
> > > This error message doesn't block anything. So I don't think this is
> > > the cause of your blocking issue. But I still want to understand why
> > > this error message is showing up.
> > >
> > > > I'm not clear why it's trying to link the serial port to the GPIO; it
> > > > seems that it should be the bluetooth device that depends on both the
> > > > UART and the GPIO,
> > >
> > > A fix for the device link error message went in on v6.3-rc3. Is that
> > > the 6.3 version you tested this on?
> >
> > I originally tried on 6.1.21, which is where I got the "Failed to create
> > device link" message. I then moved to 6.3-rc7 as I saw there had been
> > further changes recently. There I just get the:
> >
> > serial serial0-0: deferred probe pending
> 
> If the deferral is related to fw_devlink, you should see the reason
> for deferring in the devices_deferred file. So I don't think the issue
> is related to fw_devlink.

Ok.

> > message.
> >
> > > Also, I tried looking into the UART driver
> > > (drivers/tty/serial/8250/8250_dw.c) but it wasn't clear how it ends up
> > > populating the bluetooth serial device. If you can point that out,
> > > that'd be helpful (assuming 6.3-rc3 still shows that error message).
> >
> > I have the following in my device tree:
> >
> > &uart3 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&uart3_pg_pins>,
> >                     <&uart3_cts_rts_pg_pins>;
> >         status = "okay";
> >
> >         bluetooth {
> >                 compatible = "realtek,rtl8723bs-bt";
> >                 device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_LOW>;
> >                 host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> >         };
> > };
> >
> > uart3 is a snps,dw-apb-uart, defined in arch/arm/boot/dts/sun5i.dtsi
> >
> > The UART and AXP209 device drivers are compiled into the kernel:
> >
> > CONFIG_PINCTRL_AXP209=y
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_DW=y
> >
> > The bluetooth bits are modules (btrtl, hci_uart).
> >
> > If I remove the device-wake-gpios line then the Bluetooth device works
> > fine, and /sys/kernel/debug/devices_deferred is empty.
> >
> > Somehow it seems like the GPIO is being parsed as a dependency for the
> > serial port, even though the serial port + GPIO are both dependencies
> > for the bluetooth device.
> 
> I'm fairly sure that fw_devlink isn't causing that. Because even
> without bluetooth, fw_devlink doesn't consider any suppliers listed in
> child DT nodes as mandatory suppliers. That has been the case since
> the beginning.

Ok, I just got confused with the 6.1 message about the device link and
thought that might be the rough area.

> > Even with that, given both are built-in I
> > don't understand why the serial port never completes setup.
> 
> My guess is that the driver itself has some bug that's sensitive to
> device probe order even though it shouldn't.
> 
> Can you add #define DEBUG 1 to the top of drivers/base/core.c and
> share the boot log? I can try and help debug it.

Thanks for any input you're able to provide. dmesg from 6.3 with a
failure to complete the probe:

https://the.earth.li/~noodles/chip-bluetooth/6.3-not-working

and just for completeness, without the device-wake-gpios line:

https://the.earth.li/~noodles/chip-bluetooth/6.3-working

J.

-- 
Most people are descended from apes. Redheads are descended from cats.
