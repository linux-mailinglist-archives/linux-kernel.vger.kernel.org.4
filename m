Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B985702095
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjENWvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjENWvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:51:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B04110EA;
        Sun, 14 May 2023 15:51:12 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4ABD660574D;
        Sun, 14 May 2023 23:51:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684104670;
        bh=5X6s/35EjIL/j/tIEBwv4UCLHvPjHhXLzzfqo9HA6O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZ/Mi+tp3zrvSBufhtKmx4NGodOrfTryMzjxzIu3IwVG8CdHf0NxcW4FRKr9ztofe
         b+XVurqqf301WnIrYSbxpyeMIwbpmyr2w4DAdpL2+xb+tbAN110T4oGKbXDZ7tQ5Qb
         cfpgHyYJnQe8wphN/HLZokqiwq0QYH7QyU3JvcATMGpN5G0vvoDbeORwxFbb0ky4lx
         3MYiOC5y76DWeplSwFGNBHDowYyIyxMdmiwr9QOdm4rRpVUH5nACHnkRsjUYSwyEhD
         blul3AlIbAlAV1m4FjG4IxglGUWQh6jLTO7JhhTOB4PnT1lMzvSNV1oCvLqfP3U6FC
         LI+SukIZZJEBA==
Received: by mercury (Postfix, from userid 1000)
        id 4949B1061381; Mon, 15 May 2023 00:51:08 +0200 (CEST)
Date:   Mon, 15 May 2023 00:51:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 05/10] power: supply: rt5033_charger: Add RT5033
 charger device driver
Message-ID: <20230514225108.pkn2zufrfgic7r4c@mercury.elektranox.org>
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-6-jahau@rocketmail.com>
 <2e0f37ef-b80c-1a4d-2159-29598ac11156@wanadoo.fr>
 <b2a52060-6727-b91d-79aa-55cdb3cbc63c@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32wuacfcnymnc56n"
Content-Disposition: inline
In-Reply-To: <b2a52060-6727-b91d-79aa-55cdb3cbc63c@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32wuacfcnymnc56n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 14, 2023 at 07:03:03PM +0200, Jakob Hauser wrote:
> Hi Christophe, Hi all,
>=20
> On 14.05.23 16:31, Christophe JAILLET wrote:
> > Le 14/05/2023 =E0 14:31, Jakob Hauser a =E9crit=A0:
>=20
> ...
>=20
> > > +static int rt5033_charger_probe(struct platform_device *pdev)
> > > +{
> > > +=A0=A0=A0 struct rt5033_charger *charger;
> > > +=A0=A0=A0 struct power_supply_config psy_cfg =3D {};
> > > +=A0=A0=A0 int ret;
> > > +
> > > +=A0=A0=A0 charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP=
_KERNEL);
> > > +=A0=A0=A0 if (!charger)
> > > +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
> > > +
> > > +=A0=A0=A0 platform_set_drvdata(pdev, charger);
> > > +=A0=A0=A0 charger->dev =3D &pdev->dev;
> > > +=A0=A0=A0 charger->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > +
> > > +=A0=A0=A0 psy_cfg.of_node =3D pdev->dev.of_node;
> > > +=A0=A0=A0 psy_cfg.drv_data =3D charger;
> > > +
> > > +=A0=A0=A0 charger->psy =3D devm_power_supply_register(&pdev->dev,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 &rt5033_charger_desc,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 &psy_cfg);
> > > +=A0=A0=A0 if (IS_ERR(charger->psy))
> > > +=A0=A0=A0=A0=A0=A0=A0 return dev_err_probe(&pdev->dev, PTR_ERR(charg=
er->psy),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Failed=
 to register power supply\n");
> > > +
> > > +=A0=A0=A0 charger->chg =3D rt5033_charger_dt_init(charger);
> > > +=A0=A0=A0 if (IS_ERR_OR_NULL(charger->chg))
> >=20
> > Hi,
> >=20
> > Nit: charger->chg can't be NULL.
> >=20
> > > +=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
> >=20
> > Why bother returning specific error code in rt5033_charger_dt_init() if
> > they are eaten here.
> >=20
> > return PTR_ERR(charger->chg)?
> >=20
>=20
> Thanks for the heads-up.
>=20
> ...
>=20
> Writing towards the list:
>=20
> The way it is done in the current patchset is taken from the original
> patchset of March 2015 [2]. I kept the original as far as possible.
>=20
> By now I'm not happy with the way of initializing "struct
> rt5033_charger_data". I realized this in the course of the review. As I
> didn't want to disturb the review with this, I had planned a small clean-=
up
> patch after this review is finished.
>=20
> The cause of the complicated handling of "struct rt5033_charger_data" lies
> inside of the "struct rt5033_charger". There the "struct
> rt5033_charger_data" is initialized as pointer *chg.
>=20
> The clean-up would be:
>=20
>  - Inside of "struct rt5033_charger" change the
>    "struct rt5033_charger_data" to non-pointer "chg". It is then
>    initialized right away.
>=20
>       struct rt5033_charger_data      chg;
>=20
>  - Change function rt5033_charger_dt_init() from type
>    "struct rt5033_charger_data" to type "int".
>=20
>       static int rt5033_charger_dt_init(struct rt5033_charger *charger)
>=20
>  - In the probe function, call the function rt5033_charger_dt_init() in
>    the same way like e.g. the following rt5033_charger_reg_init():
>=20
>       ret =3D rt5033_charger_dt_init(charger);
>               if (ret)
>                       return ret;
>=20
>  - Within function rt5033_charger_dt_init() and all other functions
>    using the charger data, get the address of the already-initialized
>    struct &charger->chg.
>=20
>       struct rt5033_charger_data *chg =3D &charger->chg;
>=20
> This would also solve the issue reported by Christophe because the errors
> inside function rt5033_charger_dt_init() would be passed to the probe
> function by the "ret =3D" and being returned there with "return ret".
>=20
> I'm not sure how to handle this now. I would prefer to get the review of
> this patchset finished and send a clean-up patch afterwards.
>=20
> [2] https://lore.kernel.org/lkml/1425864191-4121-1-git-send-email-beomho.=
seo@samsung.com/T/#u

Sounds sensible, until then please use 'return PTR_ERR(charger->chg)'
as suggested by Christophe. With this fixed:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--32wuacfcnymnc56n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRhZdsACgkQ2O7X88g7
+pqqGA/5Afn0kyYuYYCNeFMbpA31bUx5pcgtxQm3ln66uNZTQK5BOgyxagGQnTFY
6lDDlMrWSNTe5gd/OehNmA9YPqKgREqZA4uVrC7LFrb2bghL5GCReDx3onB0rsKP
7qb2wfG0vQs0eAFC7BMwHiLfxpdc6X5y9KWP55rW2bI8PFGDoDNNNw3SvyyvMbXi
GY7+fWE75LluZmRNXOko1SK6OsuOLlHE6jsmilqgNVKadLZx3Q+wjLvttS1m4WnY
1RNs7YWgnXdjEaoEXm6NtfMnbJMilCSfBDn2brlhfNTjNWxaHvdLEUH0ZOgscM0C
UMl8BALb66LFFDHnO5Ok5YOqkZKo4S/ckTelc6LTeh/Y55Tl5lBR3LJwUKz92XjD
SXIAWWpnqGls4zHyMNknqdLMTj39dB3Sp10x+Eg+R16ceOL/YGotn+9p0v9JHcy4
njIf0y2kyeQa6xjRBQ6/j0RACvQKTkEazB4nDBJ92suehdUX8xXSji8FgWEQpiSy
h9fhWh90KKHdy47kXP8oSb4xjmlX6tlXrjNv5ms2ayUL6hdlSB4C5B+Z4BnLjsaL
UVrY1WaezXoxpdV64Ft7+UqynRNsYb++zGLdzNV1wd9qa16i/XFwAD073pGoNjoo
AnPtnUc61zdidPSNPrRBRw5J+HwPyelqxUo6DID+tdeCVkqWZvA=
=Zev5
-----END PGP SIGNATURE-----

--32wuacfcnymnc56n--
