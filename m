Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4C17179A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjEaIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjEaIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:08:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC6135;
        Wed, 31 May 2023 01:08:32 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7BE638603A;
        Wed, 31 May 2023 10:08:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685520510;
        bh=c2dLKCbUbaFW+8QKah5Ba2UZhD+rn8WUlFyDcSy4UDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qqfkikiO0dd8q3mDg6lz5btvKbsk7hv6/A2fTvTSSpnGEBxE5uIRnzfXN6wcDDFyB
         wEYorBBEfOhRJvahWX7yN4gSR8yXtM8z+Yl4uL2hs08DoRXxgyWdq6801GoUir/P1E
         HwCYeSnr1qZ96ivv16xbakV+qiUIa8h4decIxeJdHSDpqiV8h2a1XhnUOcpxP/hehl
         Koq0HHGj+yCook0NyTHb7ZyjT7+Dh40SI5mwML9vivCXd0/4J0otHAsTY+3Olfjoaq
         ddkayOkC2X1r9cQOrmLUfETF6OvP03mibN/Pt0H7RB9H17nGRy+7Hgcmq9n0ctXiIq
         rrhAiHc5Km9hQ==
Date:   Wed, 31 May 2023 10:08:28 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v8 2/3] net: dsa: mv88e6xxx: add support for MV88E6020
 switch
Message-ID: <20230531100828.3f0a3200@wsk>
In-Reply-To: <dd68b82b-7bb7-3f4f-7243-e3a4b745cd97@gmail.com>
References: <20230530083916.2139667-1-lukma@denx.de>
        <20230530083916.2139667-3-lukma@denx.de>
        <dd68b82b-7bb7-3f4f-7243-e3a4b745cd97@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KuUStryJVJf1l7OpeRAR0j6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KuUStryJVJf1l7OpeRAR0j6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Florian,

> On 5/30/23 01:39, Lukasz Majewski wrote:
> > From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >=20
> > A mv88e6250 family switch with 2 PHY and RMII ports and
> > no PTP support.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch> =20
>=20
> > --- =20
> [snip]
>=20
> >   /* List of supported models */
> >   enum mv88e6xxx_model {
> > +	MV88E6020,
> >   	MV88E6085,
> >   	MV88E6095,
> >   	MV88E6097,
> > @@ -94,7 +95,7 @@ enum mv88e6xxx_family {
> >   	MV88E6XXX_FAMILY_6097,	/* 6046 6085 6096 6097 */
> >   	MV88E6XXX_FAMILY_6165,	/* 6123 6161 6165 */
> >   	MV88E6XXX_FAMILY_6185,	/* 6108 6121 6122 6131 6152
> > 6155 6182 6185 */
> > -	MV88E6XXX_FAMILY_6250,	/* 6220 6250 */
> > +	MV88E6XXX_FAMILY_6250,	/* 6220 6250 6020 */ =20
>=20
> =C3=BCber nit: only if you have to resubmit, numbers in ascending order.
>=20

I hope that v8 will be the last iteration :-)

> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/KuUStryJVJf1l7OpeRAR0j6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmR3AHwACgkQAR8vZIA0
zr0ziwgAsgmaxJ2Kf6VzDlQZtAa1xjjVuuhFXpuqSMx3oF6IXJMsm8Wd3Au+Drt8
We83e2pK0DTOKy+L5GaFwmW4rA6cAuK867XJeOPgQCABP8v2N1DVGxtFVJFAGiaZ
+FFjGbst1D8DM1jLQra278VCYjUmnQQdD8ae8iqeSuJLRUoCBZUa5Y4+Q8amRybP
qE+Nu8gSOUgVw+8nmkV+P/K+sVyRR7HGgifNQCLl2u5EeNjrWMAsFgZEqRI8NUUE
CBmVj44mzLeWEyuxUos7osxQ86lImI5ZZNDAe4D8t9g6Dgls2TY8DFCakMu9EOxK
rppGFFweVvo9SzNB78LbDTLcngw67Q==
=jEBG
-----END PGP SIGNATURE-----

--Sig_/KuUStryJVJf1l7OpeRAR0j6--
