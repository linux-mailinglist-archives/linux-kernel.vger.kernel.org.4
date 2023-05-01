Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2276F3993
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjEAVMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:12:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF31FDD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:12:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aae90f5ebcso4415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682975562; x=1685567562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9+mgGd9+Jp4BeaqO8OgptqLi9JIHDz1Ll48RjzQaSc=;
        b=csDpshoSF+g09wU//tMGH/EjBTJVcA/8IKTO17Fp0FlnYWymNWXUOyqCTdvRh8k3Er
         LLEeylGIX7p03GIQIc7qGjfzXmgslFk9q876fiARTwJQ3BD2INneXhEKammmaXQ22xWq
         2JCv/dkAuf31QwAARY9nPPdlatq0PyAj8ZlyCWiIFafHvYrCvAActNpvcfpnBSdJbLof
         DimfdVhEPZoSXwgDoCSO9Pcip6hEHllWhPB36mwG16R4gYf2U9lRv2anEABeIYBWguR3
         eoKjLL5ZN5rgASlEhTW0OXSd4jKCgLy/cRIyvztVCEveK0FKHNY2Qxm4+dJtWFZEoICe
         GbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682975562; x=1685567562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9+mgGd9+Jp4BeaqO8OgptqLi9JIHDz1Ll48RjzQaSc=;
        b=NKAx/U6ueQczW7q8ulfZf46k1CIZ/b9+XK0efPCpFPef2yyTc1cWzCfR4xsv3zS7RQ
         yQahvF9QrOgspGNTkQbCMeZyWY+jHMNFwngcWq2bTZGwfjcHbnjvLKuorqVkJ1ENVN9Q
         nv1r3JQ46cVAwlvjPYlZqYOJ+QajItl/E8sYsGOfXq7tqme9CZ0VrdNG3a5yXZ/rHJkO
         Kagyo9FUj0nf4ey0Le4Sm35/piALz3+hdo0K1E82xJDk4wJplgYEZqzYu0906LQWIeG+
         0etDhQp7yeD9MkqZVNeORQHLwcx2myNX3+FJ2WtIRxUHtP82c3s5YBJ7/Vs7Hoaz1ZS1
         K2YA==
X-Gm-Message-State: AC+VfDxSMvqkzd4FKii0l3M2E+ZljBvQX3H+GIAq5138r2YVlUULAFEN
        r1TaeC+q2RE48odtNI6EesIAxF6ClPQR4GuMDOuoGw==
X-Google-Smtp-Source: ACHHUZ6JB2tgg926bAnCef6ZxCIZYlbBK1YTJijyfrcPOT2ZN2y2uwuhOaxdPVBRzFuYmNm52D/YGx3ji1DJyBU1feg=
X-Received: by 2002:a17:902:d507:b0:1a9:5f69:10d0 with SMTP id
 b7-20020a170902d50700b001a95f6910d0mr68484plg.14.1682975562184; Mon, 01 May
 2023 14:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681580558.git.noodles@earth.li> <f26d11e613df7bd55822ff3fb7689e36bf9e4f7a.1681580558.git.noodles@earth.li>
 <20230416012421.255bfd19@slackpad.lan> <ZEGOk1isRhaekk3h@earth.li>
 <CAGETcx-UnEK3CPC38Ef3gmHcq46nXSJbA9QAwEsF+Xt2bDKEWA@mail.gmail.com>
 <ZEJJGGeIu8QW44mh@earth.li> <CAGETcx8JDYUT2bdDhJ0PN8_CPmHJ37jCfnuoav6CGFJoovfSqA@mail.gmail.com>
 <ZEa9rcDlIOn+df5h@earth.li>
In-Reply-To: <ZEa9rcDlIOn+df5h@earth.li>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 May 2023 14:12:05 -0700
Message-ID: <CAGETcx8OK-DNM2hJb2sz0jDyKBRqtmPRxnk_acKgB0pfrD0_JA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: sun5i: chip: Enable bluetooth
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 10:34=E2=80=AFAM Jonathan McDowell <noodles@earth.l=
i> wrote:
>
> On Fri, Apr 21, 2023 at 03:45:52PM -0700, Saravana Kannan wrote:
> > On Fri, Apr 21, 2023 at 1:28=E2=80=AFAM Jonathan McDowell <noodles@eart=
h.li> wrote:
> > >
> > > On Thu, Apr 20, 2023 at 06:43:06PM -0700, Saravana Kannan wrote:
> > > > On Thu, Apr 20, 2023 at 12:12=E2=80=AFPM Jonathan McDowell <noodles=
@earth.li> wrote:
> > > > > On Sun, Apr 16, 2023 at 01:24:21AM +0100, Andre Przywara wrote:
> > > > > > On Sat, 15 Apr 2023 18:46:03 +0100
> > > > > > Jonathan McDowell <noodles@earth.li> wrote:
> > > > > >
> > > > > > > The C.H.I.P has an rtl8723bs device with the bluetooth interf=
ace hooked
> > > > > > > up on UART3. Support for this didn't exist in mainline when t=
he DTS was
> > > > > > > initially added, but it does now, so enable it.
> > > > > > >
> > > > > > > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > > > > > > ---
> > > > > > >  arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/b=
oot/dts/sun5i-r8-chip.dts
> > > > > > > index fd37bd1f3920..4d72a181d8aa 100644
> > > > > > > --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > > +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> > > > > > > @@ -255,6 +255,10 @@ &uart3 {
> > > > > > >     pinctrl-0 =3D <&uart3_pg_pins>,
> > > > > > >                 <&uart3_cts_rts_pg_pins>;
> > > > > > >     status =3D "okay";
> > > > > > > +
> > > > > > > +   bluetooth {
> > > > > > > +           compatible =3D "realtek,rtl8723bs-bt";
> > > > > > > +   }
> > > > > >
> > > > > > As the kernel test robot already pointed out, there is a semico=
lon
> > > > > > missing here.
> > > > > > Otherwise looks good (dt-validate passes), but don't know if th=
ere are
> > > > > > any wakeup GPIOs connected (can't seem to find a schematic?).
> > > > >
> > > > > So there are wakeups, but if I add:
> > > > >
> > > > >         device-wake-gpios =3D <&axp_gpio 3 GPIO_ACTIVE_LOW>;
> > > > >         host-wake-gpios =3D <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 *=
/
> > > > >
> > > > > then some odd sort of dependency issue happens where the serial p=
ort
> > > > > load is deferred waiting for the GPIO to appear, and then the dev=
ice
> > > > > doesn't work.
> > > >
> > > > When you say your device doesn't work, are you saying it never prob=
es?
> >
> > Read your whole email and it's a strange issue. Also, going forward to
> > avoid confusion, only reply to questions with respect to 6.3-rc7.

Sorry it took a while to respond. Life got busy.

> Just to be clear, in my initial mail I referred to 6.1.21 as that's
> where I started, but in my reply to you all output was quoted from
> 6.3-rc7. 6.3 has been released since, so all details below are based on
> that.
>
> > > The bluetooth device (realtek,rtl8723bs-bt) never appears, apparently
> > > because the UART it's attached to never loads - it doesn't even try t=
o
> > > load the firmware.
> > >
> > > > <debugfs>/devices_deferred should tell you what devices have deferr=
ed and why.
> > >
> > > root@chip:~# cat /sys/kernel/debug/devices_deferred
> > > serial0-0
> >
> > Do you see this in 6.3-rc7 too?
>
> That was under 6.3-rc7. I see it on 6.3 too:
>
> root@chip:~# cat /sys/kernel/debug/devices_deferred
> serial0-0

I somehow didn't connect the dots earlier... but serial0-0 is NOT the
uart/serial device. It's the child device of serial0 and in this case,
it's the bluetooth device.

So adding those gpios in DT is not breaking serial. It's just
preventing the BT device from probing.

Looking at the logs in the non-working case:

[    0.715083] 1c28c00.serial: ttyS1 at MMIO 0x1c28c00 (irq =3D 53,
base_baud =3D 1500000) is a U6_16550A
[    0.724132] device: 'serial0': device_add

I don't know why all of the ttySx are showing up as serial0, but this
is the serial port. As you can see 1c28c00 is already probing.

[    0.724228] device: 'serial0-0': device_add

This is the child devices getting populated. In this case this is the BT de=
vice.

[    0.724311] device: 'platform:1c20800.pinctrl--serial:serial0-0': device=
_add

I can tell it's the BT device because we see a device link being
created between pinctrl and serial:serial0-0. So it's a device sitting
on the serial bus.

[    0.724378] devices_kset: Moving serial0-0 to end of list
[    0.724390] serial serial0-0: Linked as a consumer to 1c20800.pinctrl
[    0.724401] /soc/serial@1c28c00/bluetooth Dropping the fwnode link
to /soc/pinctrl@1c20800

And the fwnode like that was converted to device link clearly shows
that the serial0-0 corresponds to the bluetooth node.

[    0.724441] serial serial0: tty port ttyS1 registered

Serial port works.

>
> Without the device-wake-gpios line in the device tree it's empty.

I think the issue is at the BT driver level or some other framework.

Add a print at the start of the BT driver to see if the probe() is
actually getting called. I'm guessing it is and it's returning an
error from within.

If you don't see that print, then debug the really_probe() function to
see how far within it the BT device goes through before it errors out.
It's possible pinctrl_bind_pins() in really_probe() fails for the BT
device because of how the GPIO pins are configured in your DT.

Thanks,
Saravana

>
> > > > > Error in dmesg is:
> > > > >
> > > > > serial serial0-0: deferred probe pending
> > > > >
> > > > > on 6.3-rc and on 6.1 I get:
> > > > >
> > > > > dw-apb-uart 1c28c00.serial: Failed to create device link (0x180) =
with axp20x-gpio
> > > >
> > > > This error message doesn't block anything. So I don't think this is
> > > > the cause of your blocking issue. But I still want to understand wh=
y
> > > > this error message is showing up.
> > > >
> > > > > I'm not clear why it's trying to link the serial port to the GPIO=
; it
> > > > > seems that it should be the bluetooth device that depends on both=
 the
> > > > > UART and the GPIO,
> > > >
> > > > A fix for the device link error message went in on v6.3-rc3. Is tha=
t
> > > > the 6.3 version you tested this on?
> > >
> > > I originally tried on 6.1.21, which is where I got the "Failed to cre=
ate
> > > device link" message. I then moved to 6.3-rc7 as I saw there had been
> > > further changes recently. There I just get the:
> > >
> > > serial serial0-0: deferred probe pending
> >
> > If the deferral is related to fw_devlink, you should see the reason
> > for deferring in the devices_deferred file. So I don't think the issue
> > is related to fw_devlink.
>
> Ok.
>
> > > message.
> > >
> > > > Also, I tried looking into the UART driver
> > > > (drivers/tty/serial/8250/8250_dw.c) but it wasn't clear how it ends=
 up
> > > > populating the bluetooth serial device. If you can point that out,
> > > > that'd be helpful (assuming 6.3-rc3 still shows that error message)=
.
> > >
> > > I have the following in my device tree:
> > >
> > > &uart3 {
> > >         pinctrl-names =3D "default";
> > >         pinctrl-0 =3D <&uart3_pg_pins>,
> > >                     <&uart3_cts_rts_pg_pins>;
> > >         status =3D "okay";
> > >
> > >         bluetooth {
> > >                 compatible =3D "realtek,rtl8723bs-bt";
> > >                 device-wake-gpios =3D <&axp_gpio 3 GPIO_ACTIVE_LOW>;
> > >                 host-wake-gpios =3D <&pio 1 3 GPIO_ACTIVE_HIGH>; /* P=
B3 */
> > >         };
> > > };
> > >
> > > uart3 is a snps,dw-apb-uart, defined in arch/arm/boot/dts/sun5i.dtsi
> > >
> > > The UART and AXP209 device drivers are compiled into the kernel:
> > >
> > > CONFIG_PINCTRL_AXP209=3Dy
> > > CONFIG_SERIAL_8250=3Dy
> > > CONFIG_SERIAL_8250_DW=3Dy
> > >
> > > The bluetooth bits are modules (btrtl, hci_uart).
> > >
> > > If I remove the device-wake-gpios line then the Bluetooth device work=
s
> > > fine, and /sys/kernel/debug/devices_deferred is empty.
> > >
> > > Somehow it seems like the GPIO is being parsed as a dependency for th=
e
> > > serial port, even though the serial port + GPIO are both dependencies
> > > for the bluetooth device.
> >
> > I'm fairly sure that fw_devlink isn't causing that. Because even
> > without bluetooth, fw_devlink doesn't consider any suppliers listed in
> > child DT nodes as mandatory suppliers. That has been the case since
> > the beginning.
>
> Ok, I just got confused with the 6.1 message about the device link and
> thought that might be the rough area.
>
> > > Even with that, given both are built-in I
> > > don't understand why the serial port never completes setup.
> >
> > My guess is that the driver itself has some bug that's sensitive to
> > device probe order even though it shouldn't.
> >
> > Can you add #define DEBUG 1 to the top of drivers/base/core.c and
> > share the boot log? I can try and help debug it.
>
> Thanks for any input you're able to provide. dmesg from 6.3 with a
> failure to complete the probe:
>
> https://the.earth.li/~noodles/chip-bluetooth/6.3-not-working
>
> and just for completeness, without the device-wake-gpios line:
>
> https://the.earth.li/~noodles/chip-bluetooth/6.3-working
>
> J.
>
> --
> Most people are descended from apes. Redheads are descended from cats.
