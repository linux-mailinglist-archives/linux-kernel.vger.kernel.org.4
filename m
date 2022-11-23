Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6C6351EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiKWIHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiKWIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:07:22 -0500
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507639A248
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=v9PgXhCmqI29ZYXgPAHvSLye931Cpyl30FyKc9Ddc2c=;
        b=vjVzBjygmhEML8xNq9QcJpmvcDo3ZOZR1fV/x8cyhVzf3AGz8IW8jLZiBinQVwVRAMlaDfvVn0krX
         7AEsk4YiFydMiFHx8BZYmJrLV9qXpy3I6HHZgOL6zkdHI+pTIEqBWJDvOeVtZp5z8sQZKk9KGQULSp
         8Bsnuq1lD8hseLGSCVe+/37Sm77B/IXH9tQl2FaIBZeMNQHZsp79+Y/VgZ7vhlS8If8kBW9WZiDNrO
         OpQ8m5GjwGrj9XcvFOA7rFg5J/TA4VXKuaTx2h2hLtnSTJZ/P8hfLY/+mwSGXQQHdUibtiGifGvipb
         +onxPL61agKTdKwUE/zJDaYF4LJzAPQ==
X-MSG-ID: d324982c-6b05-11ed-a7cd-0050569d2c73
Date:   Wed, 23 Nov 2022 09:07:07 +0100
From:   David Jander <david@protonic.nl>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/7] arm64: dts: imx: fix touchscreen reset GPIO
 polarity
Message-ID: <20221123090707.128c7b4d@erd992>
In-Reply-To: <84af9a9e-5d82-7420-e72c-4d984135f2d6@theobroma-systems.com>
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
        <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
        <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
        <20221122081851.6cb762d8@erd992>
        <907b9321-14dc-dc99-80fc-e1a20ee33a1e@theobroma-systems.com>
        <916a6953-d9b4-c257-c08b-f5277ead71af@arm.com>
        <84af9a9e-5d82-7420-e72c-4d984135f2d6@theobroma-systems.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 17:22:45 +0100
Quentin Schulz <quentin.schulz@theobroma-systems.com> wrote:

> Hi Robin,
>=20
> On 11/22/22 13:46, Robin Murphy wrote:
> > On 2022-11-22 09:58, Quentin Schulz wrote: =20
> >> Hi David,
> >>
> >> Thanks Fabio for the Cc.
> >>
> >> On 11/22/22 08:18, David Jander wrote: =20
> >>> On Mon, 21 Nov 2022 15:18:32 -0300
> >>> Fabio Estevam <festevam@gmail.com> wrote:
> >>> =20
> >>>> [Adding Angus and David] =20
> >>>
> >>> Thanks. This was apparently necessary ;-)
> >>> =20
> >>>> On Mon, Nov 21, 2022 at 3:12 PM Quentin Schulz=20
> >>>> <foss+kernel@0leil.net> wrote: =20
> >>>>>
> >>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >>>>>
> >>>>> The reset line is active low for the Goodix touchscreen controller =
so
> >>>>> let's fix the polarity in the Device Tree node.
> >>>>>
> >>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >>>>> ---
> >>>>> =C2=A0 arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> >>>>> =C2=A0 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 =
+-
> >>>>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts=20
> >>>>> b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> >>>>> index 9fbbbb556c0b3..df7e5ae9698e1 100644
> >>>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> >>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> >>>>> @@ -107,7 +107,7 @@ touchscreeen@5d {
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&gpio1>;
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <8 IRQ_TYPE_NONE>;
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq-gpios =3D <&gpio1 8 GPIO_ACTIVE_HIGH>;
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio1 9 GPIO_ACTIVE_LOW>; =20
> >>>
> >>> NACK!
> >>>
> >>> The PRT8MM has an inverter in the reset line. The reason for that is=
=20
> >>> that the
> >>> reset line needs to be inactive when the driving side is unpowered.
> >>> The DT was correct, this change will break it.
> >>> =20
> >>
> >> The DT was correct. The implementation in the driver is changed (the=20
> >> polarity is swapped) in this patch series, therefore the DT isn't=20
> >> correct anymore, hence this patch. =20
> >=20
> > I'm not sure it's quite that simple... FWIW I'm using an add-on LCD=20
> > module with a GT9271[1] (and I won't be the only one - Raspberry Pi and=
=20
> > other SBC users using DT overlays or custom-built DTBs are a whole othe=
r=20
> > can of worms here), where GPIO_ACTIVE_LOW is correctly specified per th=
e=20
> > schematics, thus "wrong" for the current driver behaviour, yet it *is*=
=20
> > working OK as-is. I guess that's because /RSTB ends up driven low for=20
> > long enough between the current "deassertion" by=20
> > gpiod_direction_output(1) and gpiod_direction_input() allowing the=20
> > external pull-up to take it high again.
> >  =20
>=20
> Correct, that seems like it is the case for "current-wrong" GPIO level,=20
> provided you have a pull-up on the RESET line (as recommended in the=20
> datasheet).
>=20
> c.f.=20
> https://github.com/hadess/gt9xx/blob/master/specifications/GT9271%20Datas=
heet.pdf
>=20
> with the current driver, what I assume we should get is:
>              ___________________
> INT _______|                   |___________
>=20
>      ____________           __________________
> RST             |_________|
>=20
>     ^
>     L__ pull-up on RST so high by default
>          ^
>          L___ gpiod_direction_output(0) (deassert GPIO active-low, so hig=
h)
>             ^
>             L____ goodix_irq_direction_output
>                  ^
>                  L___ gpiod_direction_output(1) (assert GPIO active-low,=
=20
> so low)
>                            ^
>                            L____ gpiod_direction_input() (floating,=20
> pull-up on RST so high)
>=20
> This works because of the pull-up on RST and that what matters is that=20
> the INT lane is configured 100=C2=B5s before a rising edge on RST line (f=
or=20
> at least 5ms). However, the init sequence is not properly followed and=20
> might get broken in the future since it is not something that we=20
> explicitly support.
>=20
> With the proposed patch:
>              ___________________
> INT _______|                   |___________
>=20
>      ____         __________________
> RST     |_______|
>=20
>     ^
>     L__ pull-up on RST so high by default
>          ^
>          L___ gpiod_direction_output(1) (assert GPIO active-low, so low)
>             ^
>             L____ goodix_irq_direction_output
>                  ^
>                  L___ gpiod_direction_output(1) (deassert GPIO=20
> active-low, so high)
>                            ^
>                            L____ gpiod_direction_input() (floating,=20
> pull-up on RST so high)
>=20
> This should work too and does not rely on some side effects/timings and=20
> should be future-proof.
>=20
> As for OOT DTB/DTBO, nothing I can do unfortunately, that is correct.
>=20
> The fact that we have both "interpretations" of the RESET GPIO level in=20
> Linux is worrying, albeit with OOT DTBs. A driver or subsystem rework=20
> might break boards in which case people should update their DTB as=20
> suggested here or we'll decide to support both interpretations, which=20
> ain't great either.

Thanks for the detailed drawings. Yes, it seems this is an unfortunate case=
 of
both polarities kind of working.

Our DT was correct, but the driver was wrong, even if it seemed to work
correctly, so this NACK still stands.

Our board has this GPIO pin wired to the gate of a MOSFET which acts as an
inverter and also isolates the signal from the GPIO port power rail. So from
the GPIO point of view, the signal is ACTIVE_HIGH. Please leave the DT like
this.

Thanks for fixing the driver.

Best regards,

--=20
David Jander
Protonic Holland.

