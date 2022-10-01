Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54E5F1F8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJAU6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiJAU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:58:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41DF5C379;
        Sat,  1 Oct 2022 13:58:03 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1010B660205E;
        Sat,  1 Oct 2022 21:58:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664657882;
        bh=C+MnW4H7R+Fuy1N+P3DLx4h/ETVoGGzeo6k5om+x/CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDKNM+p3XWPeEaGrs8is+6gaR6cCq4aUR9McR/wDU+G3/uc2eC9JGIRBOkO/GCWX4
         hbwThNbuPPcQvjPm1Cogm00TgTuthe4aySxUtDJAXhNcImUNAv2sgUNgEfn5YXoBko
         w79aPswaSOpk08VJL57z+Fmao82bz432zJC8Hns2yuYKIu8JTFwfR74GJpzqMzpexK
         lNQNbnoSIgxqdxjjj8QVppVTxQ3WBcmHVK1Fz4xw/qtylUzkGk5lviqGRJfbXUgnF8
         CgkxRfPpx1PXNCo9c02fQ7WnQ8PFriz0Dp7DqFI8EKWOYJbriHQ81AENzU+llVGMVe
         3VrPLQpuzETeA==
Received: by mercury (Postfix, from userid 1000)
        id 7B323106090C; Sat,  1 Oct 2022 22:58:00 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:58:00 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Documentation: power: rt9471: Document exported
 sysfs entries
Message-ID: <20221001205800.msywk4yvqgegjqpe@mercury.elektranox.org>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-4-git-send-email-u0084500@gmail.com>
 <20220916180823.p672rojsrjbpy4ft@mercury.elektranox.org>
 <CADiBU39FMkDOrMHXTQF+0JGX2tDn_iVXCb19jM6MopnKmaXOpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bkvol2kvrsmj5v4m"
Content-Disposition: inline
In-Reply-To: <CADiBU39FMkDOrMHXTQF+0JGX2tDn_iVXCb19jM6MopnKmaXOpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bkvol2kvrsmj5v4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 19, 2022 at 09:11:09AM +0800, ChiYuan Huang wrote:
> Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2022=E5=B9=
=B49=E6=9C=8817=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:19=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > On Thu, Sep 15, 2022 at 12:30:15AM +0800, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Document the settings exported by rt9471 charger driver through sysfs=
 entries:
> > > - sysoff_enable
> > > - port_detect_enable
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > > Since v5:
> > > - Recover all the change in sysfs-class-power.
> > > - New a sysfs-class-power-rt9471 file.
> > > - Remove 'charge_term_enable' sysfs entry, directly integrate it in
> > >   'charge_term_current' power supply property control.
> > >
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power-rt9471 | 29 ++++++++++++=
++++++++++
> > >  1 file changed, 29 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Doc=
umentation/ABI/testing/sysfs-class-power-rt9471
> > > new file mode 100644
> > > index 00000000..ad5b049
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> > > @@ -0,0 +1,29 @@
> > > +What:                /sys/class/power_supply/rt9471-*/sysoff_enable
> > > +Date:                Oct 2022
> > > +KernelVersion:       6.1
> > > +Contact:     ChiYuan Huang <cy_huang@richtek.com>
> > > +Description:
> > > +             This entry allows enabling the sysoff mode of rt9471 ch=
arger devices.
> > > +             If enabled and the input is removed, the internal batte=
ry FET is turned
> > > +             off to reduce the leakage from the BAT pin. See device =
datasheet for details.
> > > +             It's commonly used when the product enter shipping stag=
e.
> > > +
> > > +             Access: Read, Write
> > > +             Valid values:
> > > +             - 1: enabled
> > > +             - 0: disabled
> >
> > I still fail to see why this needs to be controllable at runtime.
> > This looks like a hardware property. Are there any known products,
> > which need this disabled?
> It's just a switch, actually 'disabled' is not needed.
> For the enabled case, mostly used in below scenarios
> 1. Online testing, USB IN -> Factory testing -> write 1 to enable ->
> USB out -> immediately VSYS off -> pack
> 2. Offline testing no vbus -> Factory testing -> write 1 to enable ->
> immediately VSYS off -> pack
>=20
> The 'disable" can use to cancel the shipping mode in case 1 before USB ou=
t.
> It's more like the testing.
>=20
> Like as you said, shipping BATFET_OFF is all the hardware behavior.
> To leave this mode after VSYS off, there're three ways
> 1. power key pressed
> 2. VBUS IN
> 3. control BATFET_OFF to 0 (But it need SOC to be alive, at the time,
> VSYS off, no one can execute this I2C command)

If factory testing and preperation is the only use case, I don't
think exposing this in sysfs and creating userspace ABI is worth
it. Just tell factory to use i2c-dev and poke the correct registers.

> If what you care is no need to mention 'disable', then just remove it.
> It's fine.
> >
> > > +What:                /sys/class/power_supply/rt9471-*/port_detect_en=
able
> > > +Date:                Oct 2022
> > > +KernelVersion:       6.1
> > > +Contact:     ChiYuan Huang <cy_huang@richtek.com>
> > > +Description:
> > > +             This entry allows enabling the USB BC12 port detect fun=
ction of rt9471 charger
> > > +             devices. If enabled and VBUS is inserted, device will s=
tart to do the BC12
> > > +             port detect and report the usb port type when port dete=
ct is done. See
> > > +             datasheet for details. Normally controlled when TypeC/U=
SBPD port integrated.
> > > +
> > > +             Access: Read, Write
> > > +             Valid values:
> > > +             - 1: enabled
> > > +             - 0: disabled
> >
> > So basically this depends on the hardware integration (e.g. it
> > should be disabled when power source is a DC barrel jack instead
> > of USB) and is not supposed to change at all during runtime? Then
> > the information wether it needs to be enabled should be derived
> > from the device tree.
>
> It's a switching charger integrates OTG boost.
> For the case 'DC Jack', there's no need to use this kind of product.
>=20
> With typec integration, at most time, it still need bc12 to be enabled
> by default. Just in some case, like as power role swap (SNK -> SRC -> SNK=
),
> to automatically identify the USB port, this may interrupt USB communicat=
ion.
>=20
> So as my understanding, keep it enabled by default, just in some case,
> it my need to control at runtime.

This should be part of the description. You can drop the sentence
"Normally controlled when TypeC/USBPD port integrated.", since
that's hard to comprehend. Instead add the information that this
is supposed to be always enabled, but can be disabled to avoid
USB link loss (?) when doing a USB PD role swap.

-- Sebastian

--bkvol2kvrsmj5v4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4qdQACgkQ2O7X88g7
+ppxIw/8DkLHJMoXwLJ8PAlPJGmYJK9NsgOqwqEh51BxbW66BYqGdcEgcUWsxhc9
iOC/o/Tj6uEbPuJVBSIPdQevlwqlfWmlla/FnUeu3KqYpJYFikLibb9ILOB0IwkQ
b4HEpsI05VGy05ybpOcfZA/dePqaenyXQjMUTZiU4zYnnuze2wjf4M98xJVMPyiY
mcmanJTIrEVo959TuXap63YPQV5ZAoyjpmKm6+HviY1iHih/XTDwV5/nsr+8PLbo
esoeXRWxiaRDSE0Y14SlR2ViIc4I1ehb23NWN7emKMTxJIvue1XQbZlBtoqXgzN4
Lftkktovz+H5XE50doVGju8+/lK8Mtqol3hsYDy8P4SvgkFV1TK90k6U+uMnZobD
lyM1ua0HyaeDwKfJhHdMH3aLYdhcgiBC4FxRw945HMiawujgYWnn6mX7A1otlHuf
WP+z/xY4t76M1XfQGWjXmZPetXH4Kmj8fHJuvD04hXxyu2/cZujx9YHBmZGI9TSx
Ps+KZEma02ZHqaNxmO1gDe0TEwLB1J0+CHShHHexZPSncyWwNqyJRXfUOlWxYUXm
wE+k4+1nQWfPte1wHsTe7DXQnzM5eUS9f+4X9UmHWQAvqkuoVoQgxWTZFgTJazcf
KslR4jNeNl6mufySsNvJHCEiiXu2NnNTTlhmA4zOAdpyS+Ls+N0=
=lOwa
-----END PGP SIGNATURE-----

--bkvol2kvrsmj5v4m--
