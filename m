Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEE65B798
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjABWUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjABWT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:19:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E95D2C4;
        Mon,  2 Jan 2023 14:19:11 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 460E06600363;
        Mon,  2 Jan 2023 22:19:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672697949;
        bh=BLJbVRLa6vU9x48lI1oADTM668QrEUJZpEUHZDoKilM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BV9WFTJhRanMth17kUksQgkLo/DITr8aewk8fmVGB102rdKiwTc48im5KUx3ef3A2
         azLE6BMdruBFCeRcQTQ/3W8uB0uo4RoRGVXo4xevtVHNhe1BCP7UuZmQoyUsVkaope
         RKfIMyoe325BjbKZNWhcy+9T73RRBqJF73zU4HOq3M4mo1/RnvgJMYorrcLryp0JlN
         sN7zfwQq1xj9pkhRcly3EwZU/LnMNlUFrtam21ICLd0AVsjv8Nrh3R63rANUIQ1xTI
         bjvpDOA3wnjFugqHCu4NCik+o+52ykOt2tDVrRZP/yUCgxEGLCPuqLoGG2gOWYQx8y
         T+gvcW9OwViaA==
Received: by mercury (Postfix, from userid 1000)
        id 39AF6106076E; Mon,  2 Jan 2023 23:19:07 +0100 (CET)
Date:   Mon, 2 Jan 2023 23:19:07 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: cros_usbpd: reclassify "default case!" as
 debug
Message-ID: <20230102221907.i474olwdaxjfbyns@mercury.elektranox.org>
References: <20221212213857.3636830-1-grundler@chromium.org>
 <CABXOdTd34M1fCEdYfT7F7RAMDmvEj=Ak_Wcg+HgcU83nOFor8w@mail.gmail.com>
 <CANEJEGtOE8HYDPJi80=TQ==4bwLh2=c7Dn3450Girxm5Uhgz9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="meeynkt3yy72gcwp"
Content-Disposition: inline
In-Reply-To: <CANEJEGtOE8HYDPJi80=TQ==4bwLh2=c7Dn3450Girxm5Uhgz9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--meeynkt3yy72gcwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, queued to power-supply's fixes branch.

-- Sebastian

On Thu, Dec 29, 2022 at 11:53:55PM -0800, Grant Grundler wrote:
> Hi Sebastian, linux-pm folks, Benson,
> Can I get feedback on this patch please?
>=20
> I was just told another user feedback report had 70% of the dmesg buffer
> filled with the cros-usbpd-charger output.
>=20
> cheers,
> grant
>=20
>=20
> On Mon, Dec 12, 2022 at 1:49 PM Guenter Roeck <groeck@google.com> wrote:
>=20
> > On Mon, Dec 12, 2022 at 1:39 PM Grant Grundler <grundler@chromium.org>
> > wrote:
> > >
> > > This doesn't need to be printed every second as an error:
> > > ...
> > > <3>[17438.628385] cros-usbpd-charger cros-usbpd-charger.3.auto: Port =
1:
> > default case!
> > > <3>[17439.634176] cros-usbpd-charger cros-usbpd-charger.3.auto: Port =
1:
> > default case!
> > > <3>[17440.640298] cros-usbpd-charger cros-usbpd-charger.3.auto: Port =
1:
> > default case!
> > > ...
> > >
> > > Reduce priority from ERROR to DEBUG.
> > >
> > > Signed-off-by: Grant Grundler <grundler@chromium.org>
> >
> > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> >
> > >
> > > ---
> > >  drivers/power/supply/cros_usbpd-charger.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/power/supply/cros_usbpd-charger.c
> > b/drivers/power/supply/cros_usbpd-charger.c
> > > index cadb6a0c2cc7..b6c96376776a 100644
> > > --- a/drivers/power/supply/cros_usbpd-charger.c
> > > +++ b/drivers/power/supply/cros_usbpd-charger.c
> > > @@ -276,7 +276,7 @@ static int cros_usbpd_charger_get_power_info(stru=
ct
> > port_data *port)
> > >                 port->psy_current_max =3D 0;
> > >                 break;
> > >         default:
> > > -               dev_err(dev, "Port %d: default case!\n",
> > port->port_number);
> > > +               dev_dbg(dev, "Port %d: default case!\n",
> > port->port_number);
> > >                 port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> > >         }
> > >
> > > --
> > > 2.39.0.rc1.256.g54fd8350bd-goog
> > >
> >

--meeynkt3yy72gcwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzWFoACgkQ2O7X88g7
+poAsg//ZJQZu59/9ioVlvjqZKhtjNev8c3XmQA3/uQzriY1OkXzzPiGpZUxzMIm
645SQCDlF6ABJi5G2G2VGqR/KqYL01Rv7kcpIclV1VFFQpYjIsXR8oZToDXq3SV0
xS5fJhrph9ql8cnLHBD0K8Wu17zHpZmW66Da2jy3M9vNDkwbN9Gg3gjzbpOxh0R5
qBPV3eVb9r1xJ0+0O2annlI2UuYZSvbhPZDXtiz2Ab5g+5rhe9UjOSxeL2zKc3CD
MrJaK5+XRrWc3lsmozxqlaN3PY8g+c59saejj+VgiLHymVV3vKaB2kEiiyHK9U+e
cRlWqbhIld0jJhRtu/U9fbEoEsClEqIIKm3Qy5nguPEnUtDJlh3ZY5aEZxarMVx6
JAKlHRojurayX2s/UP6IjXPi267kcmiO8UulCh6fZMOgfRDD6mCArF94KsswrPYF
OMJSi3OlJmtT/HSWlB4JQMdiObe/3CG1elf7xD1n3knf8oEHBtQMFCcn4uG5CyXG
6LF5uxmg5ZiovrVKWIUAVUBQOnVxUb5dTzGiPup7ar3LyCcO2P3a1MNEnILkMZdG
z7j3pxml8DN5XspzwYisn6nC05oJZ9SFtamaD5EBjSJidhf5tg8S17897n+ukg2X
W961DCkCp9i257D25untMzlDdSWWEmwVTie6pRKizGMWz5nD2vo=
=mPYL
-----END PGP SIGNATURE-----

--meeynkt3yy72gcwp--
