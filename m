Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D091474DD39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGJSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjGJSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CCB12A;
        Mon, 10 Jul 2023 11:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B13061189;
        Mon, 10 Jul 2023 18:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13745C433C7;
        Mon, 10 Jul 2023 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013235;
        bh=KcI+NOKnYQtBf7lGL0/ugmzoGRjW610KKOJKS1UghPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3BClZNOjCbyv8FrMIs/HaLAgNajYHAxxCaQ1ote2+SWMS4meF3b68jfKA5YcW99R
         wNmeyJ6+As5htJ3tx7OdZQ2q+ahwgkM2nRTgxu5nRuVRPjDWU20ov0dNIpn8miBksi
         VoBrJACSurQ3mamyZ7JkneXFRmAk9oz44dW8BRF3fuJCRqkTkCIU6hEmghU8KYOkn+
         /PXXWhnBTpktTwXLsrwCvdZvAyxyaElA3zEewG0A66t6TZX+5GIyElII7OX14VtQio
         +j7Z9YVzxqbl6K2nb9mTulzQxj2v5MHs7dexrGMpdrzAmMi6cVyUqkeDHS77JLkGrU
         pZ3MM92UTQraQ==
Date:   Mon, 10 Jul 2023 19:20:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: Convert Omnivision OV7251 to DT
 schema
Message-ID: <20230710-octane-disarray-44b363c02f73@spud>
References: <20230707210646.868758-1-robh@kernel.org>
 <20230710-underling-angelfish-c47d363a59f5@spud>
 <CAL_Jsq+5mtgCAfFZOZTUjqFLW0DM5A6exD+PbznO71A8SDyyTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q5Ldc3obMTqxnFUa"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+5mtgCAfFZOZTUjqFLW0DM5A6exD+PbznO71A8SDyyTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5Ldc3obMTqxnFUa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 12:03:38PM -0600, Rob Herring wrote:
> On Mon, Jul 10, 2023 at 11:57=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Fri, Jul 07, 2023 at 03:06:46PM -0600, Rob Herring wrote:
> > > Convert the OmniVision OV7251 Image Sensor binding to DT schema forma=
t.
> > >
> > > vddd-supply was listed as required, but the example and actual user
> > > don't have it. Also, the data brief says it has an internal regulator,
> > > so perhaps it is truly optional.
> >
> > ov7251.c:
> >         ov7251->core_regulator =3D devm_regulator_get(dev, "vddd");
> >         if (IS_ERR(ov7251->core_regulator)) {
> >                 dev_err(dev, "cannot get core regulator\n");
> >                 return PTR_ERR(ov7251->core_regulator);
> >         }
> >
> > Looks like the driver's probe function disagrees?
>=20
> Doesn't the regulator framework return a dummy regulator if missing?

Huh, I think I misunderstood how _regulator_get() worked. Apologies for
the noise, I thought it was returning an error when it used a dummy.

> > I was going to ask how it worked, but the one user has
> > status =3D "disabled"...
>=20
> Saw that too, but figured there's some other include with that
> overridden. We should really add a built .dts output target to avoid
> trying to manually walk includes.

Probably gonna sound like an eejit, but the user is in a dts - can an
include overwrite that status?

--q5Ldc3obMTqxnFUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxL7wAKCRB4tDGHoIJi
0vm2AQD+6+DJYbJipYGtlJyH4ZxdVLnJ7E2dwEk5797T2mhiYgD+PGQvwhzDjkNC
5GsnAsFeFhlDxKYPl8sfeTelufvqZwc=
=0t3A
-----END PGP SIGNATURE-----

--q5Ldc3obMTqxnFUa--
