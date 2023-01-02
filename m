Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060465B79A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjABWVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbjABWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:20:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644BC767;
        Mon,  2 Jan 2023 14:19:46 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 365476600363;
        Mon,  2 Jan 2023 22:19:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672697984;
        bh=DNtlXpKIC0EdNIYdf8lj6Wk9BsIcMijC32TABZnsYPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEbDU3pb/CgbERQln4UcdFK+hR2FQ62OF1SR7f7kacRyoL4Nik4rsCQyfvppU3OIH
         l7BQch+U6ItxEhld6LRP5yG/nA90OAPmT+7W9IBdFN9bicoxreK/G0F0rqtBuPXMne
         n5BYzlB0DCCYdOWqRgxKUAgZuLoRsfuqxUzgdIIMs1JFOWetFDWViTq4ia/Fzv0m8A
         i8Vy53V0sVlgoQXJGjoXCx18XaNYxb5IVBDGNpWJ4PfSpTG4zGP3KqsUJ0uY3uZzoy
         aLCj5YbVPNzWp1lJfRXn7VVqCBOXY0+0k1chwKCX4Do67v0Vd0fPNFB6vNkFyF2RJ1
         aR46ltf8XDy7g==
Received: by mercury (Postfix, from userid 1000)
        id AAE38106076E; Mon,  2 Jan 2023 23:19:41 +0100 (CET)
Date:   Mon, 2 Jan 2023 23:19:41 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Denis Arefev <arefev@swemel.ru>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] power: supply: Added check for negative values
Message-ID: <20230102221941.hw35od6uhu7fbfny@mercury.elektranox.org>
References: <20221206091723.28656-1-arefev@swemel.ru>
 <1184e45f-d88c-b8b1-952d-7d6bd1ae2129@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6z3y7co7hg7rakoo"
Content-Disposition: inline
In-Reply-To: <1184e45f-d88c-b8b1-952d-7d6bd1ae2129@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6z3y7co7hg7rakoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 06, 2022 at 06:11:23PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 12/6/22 10:17, Denis Arefev wrote:
> > Variable 'pirq', which may receive negative value
> > in platform_get_irq().
> > Used as an index in a function regmap_irq_get_virq().
> >=20
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >=20
> > Signed-off-by: Denis Arefev <arefev@swemel.ru>
>=20
> Thanks, patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Regards,
>=20
> Hans

Thanks, queued to power-supply's fixes branch.

-- Sebastian

>=20
> > ---
> >  drivers/power/supply/axp288_fuel_gauge.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/s=
upply/axp288_fuel_gauge.c
> > index 148eb8105803..36c7039c99c2 100644
> > --- a/drivers/power/supply/axp288_fuel_gauge.c
> > +++ b/drivers/power/supply/axp288_fuel_gauge.c
> > @@ -640,6 +640,8 @@ static void fuel_gauge_init_irq(struct axp288_fg_in=
fo *info)
> > =20
> >  	for (i =3D 0; i < AXP288_FG_INTR_NUM; i++) {
> >  		pirq =3D platform_get_irq(info->pdev, i);
> > +		if (pirq < 0)
> > +			continue;
> >  		info->irq[i] =3D regmap_irq_get_virq(info->regmap_irqc, pirq);
> >  		if (info->irq[i] < 0) {
> >  			dev_warn(&info->pdev->dev,
>=20

--6z3y7co7hg7rakoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzWH0ACgkQ2O7X88g7
+prkow//WeGRJ+8c+zBWyca2ncxQuK0f5OqpVwrMJN8p6yHN8roPoMMszV4T3PYG
/kkWcgJ3SAHs5qolXwGGsSJ+1ehh2I/4fKrhn8aKokbFGfq/IS9lIa6B5nd6xJsV
l1reydmzHvs0FK8SAYV/hx852Bw9ZA0epi0bxClzbzor5AUu2ALHRVoNAIGz/KX6
nHry0NIKurs2tOdYXdIpmJutuaKG2oTFyzNmYQ3SRDrFSXRCHkpYtyWIYSqPI/BF
u4Ov7G1YvSf3TfNkVEWkYn1d/pyhe68JgAUpGYLwCMA/qSnZBIBHur56HE/n+a6Q
v/pMNSoEVReBEgvh8SGsmEEFzC9MSOMLG3KYIwqb9AEWHfHUMztMwJuPJzC0dsAt
d7ltTqzVnEvJruhGAex2vOkM7EHMKmgidvjp44g0LyD87E3P8Th7l/3vmyxg0wLG
ey//FLIEUjb885TV26RLRJi2YHkqJy2574hjNNedK3LEU0oM9Sz1uuqukfZp9B6e
H0Ld442yT0DEix5lqmcg8Tvhw80iUlCjt9Kt5vguaY1r9lvr+rVb1sUJL8Oeg7yM
pGyDYnJjlwuNgUf8f940uVkg8A0Hbq6fX87q3Q9TRMdtcM+sij+1Cbi7cUceQEiM
U0dg7TcjPJyUsXNozZri6tHqMP4IziZ6cL5mP8mV//fInB/vmQg=
=rXS/
-----END PGP SIGNATURE-----

--6z3y7co7hg7rakoo--
