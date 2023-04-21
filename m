Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F326EA5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDUI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:28:26 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12124E3;
        Fri, 21 Apr 2023 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UvG09/bWiSWNE+FsalNqF2CIFPzlOov2h8jwZ/B2Hkk=; b=b1lqPxG56Gk4PK2AN3q/ZFM5MK
        b371yhL6dx9Zhzr3uXxyMkYkNdY0a2wR8vn7lSeb1ApFm26B4jGFql1MoRigZsSZ0rFGw7Xi8JtOP
        TJ4EOFBVZ+OiOQE439t0C7LqPQZXhHPKZh2CGIiT3CFkSSZjWjGT5UrFAScg0kxyEGG9TOzQBcqxj
        rz+nPKu2Il2cOER1R0BLqvClrWohQJiQ4d1yUTLtxF4/gdL/QMpgLmG4fhNNvH6Rz8z0+C/xLLmIl
        cEk1wH3WQWa0Vail651RFg2G+T4WCwyVZjmiKn0y7P5wbc0/ZlooFUUYrw+6i66ZmWWRAYEBaJPZe
        IE+IzjtA==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1ppm7k-0033d1-Rz; Fri, 21 Apr 2023 09:28:08 +0100
Date:   Fri, 21 Apr 2023 09:28:08 +0100
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
Message-ID: <ZEJJGGeIu8QW44mh@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <f26d11e613df7bd55822ff3fb7689e36bf9e4f7a.1681580558.git.noodles@earth.li>
 <20230416012421.255bfd19@slackpad.lan>
 <ZEGOk1isRhaekk3h@earth.li>
 <CAGETcx-UnEK3CPC38Ef3gmHcq46nXSJbA9QAwEsF+Xt2bDKEWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-UnEK3CPC38Ef3gmHcq46nXSJbA9QAwEsF+Xt2bDKEWA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 06:43:06PM -0700, Saravana Kannan wrote:
> On Thu, Apr 20, 2023 at 12:12 PM Jonathan McDowell <noodles@earth.li> wrote:
> > On Sun, Apr 16, 2023 at 01:24:21AM +0100, Andre Przywara wrote:
> > > On Sat, 15 Apr 2023 18:46:03 +0100
> > > Jonathan McDowell <noodles@earth.li> wrote:
> > >
> > > > The C.H.I.P has an rtl8723bs device with the bluetooth interface hooked
> > > > up on UART3. Support for this didn't exist in mainline when the DTS was
> > > > initially added, but it does now, so enable it.
> > > >
> > > > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > > > ---
> > > >  arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > index fd37bd1f3920..4d72a181d8aa 100644
> > > > --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > @@ -255,6 +255,10 @@ &uart3 {
> > > >     pinctrl-0 = <&uart3_pg_pins>,
> > > >                 <&uart3_cts_rts_pg_pins>;
> > > >     status = "okay";
> > > > +
> > > > +   bluetooth {
> > > > +           compatible = "realtek,rtl8723bs-bt";
> > > > +   }
> > >
> > > As the kernel test robot already pointed out, there is a semicolon
> > > missing here.
> > > Otherwise looks good (dt-validate passes), but don't know if there are
> > > any wakeup GPIOs connected (can't seem to find a schematic?).
> >
> > So there are wakeups, but if I add:
> >
> >         device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_LOW>;
> >         host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> >
> > then some odd sort of dependency issue happens where the serial port
> > load is deferred waiting for the GPIO to appear, and then the device
> > doesn't work.
> 
> When you say your device doesn't work, are you saying it never probes?

The bluetooth device (realtek,rtl8723bs-bt) never appears, apparently
because the UART it's attached to never loads - it doesn't even try to
load the firmware.

> <debugfs>/devices_deferred should tell you what devices have deferred and why.

root@chip:~# cat /sys/kernel/debug/devices_deferred
serial0-0

> > Error in dmesg is:
> >
> > serial serial0-0: deferred probe pending
> >
> > on 6.3-rc and on 6.1 I get:
> >
> > dw-apb-uart 1c28c00.serial: Failed to create device link (0x180) with axp20x-gpio
> 
> This error message doesn't block anything. So I don't think this is
> the cause of your blocking issue. But I still want to understand why
> this error message is showing up.
> 
> > I'm not clear why it's trying to link the serial port to the GPIO; it
> > seems that it should be the bluetooth device that depends on both the
> > UART and the GPIO,
> 
> A fix for the device link error message went in on v6.3-rc3. Is that
> the 6.3 version you tested this on?

I originally tried on 6.1.21, which is where I got the "Failed to create
device link" message. I then moved to 6.3-rc7 as I saw there had been
further changes recently. There I just get the:

serial serial0-0: deferred probe pending

message.

> Also, I tried looking into the UART driver
> (drivers/tty/serial/8250/8250_dw.c) but it wasn't clear how it ends up
> populating the bluetooth serial device. If you can point that out,
> that'd be helpful (assuming 6.3-rc3 still shows that error message).

I have the following in my device tree:

&uart3 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart3_pg_pins>,
                    <&uart3_cts_rts_pg_pins>;
        status = "okay";

        bluetooth {
                compatible = "realtek,rtl8723bs-bt";
                device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_LOW>;
                host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
        };
};

uart3 is a snps,dw-apb-uart, defined in arch/arm/boot/dts/sun5i.dtsi

The UART and AXP209 device drivers are compiled into the kernel:

CONFIG_PINCTRL_AXP209=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DW=y

The bluetooth bits are modules (btrtl, hci_uart).

If I remove the device-wake-gpios line then the Bluetooth device works
fine, and /sys/kernel/debug/devices_deferred is empty.

Somehow it seems like the GPIO is being parsed as a dependency for the
serial port, even though the serial port + GPIO are both dependencies
for the bluetooth device. Even with that, given both are built-in I
don't understand why the serial port never completes setup.

> > and that the GPIO is actually optional so shouldn't
> > hold up loading, but I can't see how that should be represented.
> 
> Optional dependencies should get ignored after the default
> deferred_probe_timeout runs out and the supplier driver hasn't been
> loaded yet.

When I say it's optional I mean if it's not listed everything works
fine, but I don't believe there's anyway to express that in the DTS.
It's certainly not required for the serial port, just the bluetooth
device.

J.

-- 
Web [                     Don't be a stranger.                     ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24
