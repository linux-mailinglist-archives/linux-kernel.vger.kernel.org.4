Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803866D33D3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDAUaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:30:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED7BC669;
        Sat,  1 Apr 2023 13:30:31 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77EBA66030C4;
        Sat,  1 Apr 2023 21:30:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680381029;
        bh=YzmZJzLAOt9Kefz8r1tk+YrbDj+ypz+EkDt0+WX3YpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKi4CdANBtbKhg0xQoFMSHXZcwmziR9fMMChivQ0oyM4iVY/Jfen9Q0BYeafYXJSO
         h3TDxA1UFtbHk6EaWlFeGsAjtEpY/U+WU2OK7Mow562NQuuenTNaCNNgrjsm8t1DGM
         8apySrygtU6RQ6gRyKzU8CqbvBkqn9rpAjkhl8wjfAF1TBh/vpNZQuUhBa6QuW722C
         LiBUhyuhU0bpgyJq9UeHiH0uCsIS7sVAufIDem3wsQAk+McE+NE1q9DKEKQvHnQgJp
         LSiP8dj4Z4veg87Os6q5Dz7Rok9IIPDetdXaB1b4gHdOEJDlo98oZh1BClWiS+qB/O
         KzU+ab3OEnhTw==
Received: by mercury (Postfix, from userid 1000)
        id EA5EE1062746; Sat,  1 Apr 2023 22:30:26 +0200 (CEST)
Date:   Sat, 1 Apr 2023 22:30:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tom Rix <trix@redhat.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Andreas Kemnade <andreas@kemnade.info>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] power: supply: twl4030-charger: remove unused cur_reg
 variable
Message-ID: <20230401203026.nzk4aygv7sr7quhe@mercury.elektranox.org>
References: <20230401113432.1873847-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfptafjvzvw5h7cx"
Content-Disposition: inline
In-Reply-To: <20230401113432.1873847-1-trix@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfptafjvzvw5h7cx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 01, 2023 at 07:34:32AM -0400, Tom Rix wrote:
> clang with W=3D1 reports
> drivers/power/supply/twl4030_charger.c:242:16: error: variable
>   'cur_reg' set but not used [-Werror,-Wunused-but-set-variable]
>         unsigned reg, cur_reg;
>                       ^
> This variable is not used so remove it.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/power/supply/twl4030_charger.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 7adfd69fe649..5fa5b2311330 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -239,7 +239,7 @@ static int twl4030_charger_update_current(struct twl4=
030_bci *bci)
>  {
>  	int status;
>  	int cur;
> -	unsigned reg, cur_reg;
> +	unsigned reg;
>  	u8 bcictl1, oldreg, fullreg;
>  	bool cgain =3D false;
>  	u8 boot_bci;
> @@ -357,11 +357,9 @@ static int twl4030_charger_update_current(struct twl=
4030_bci *bci)
>  	status =3D twl4030_bci_read(TWL4030_BCIIREF1, &oldreg);
>  	if (status < 0)
>  		return status;
> -	cur_reg =3D oldreg;
>  	status =3D twl4030_bci_read(TWL4030_BCIIREF2, &oldreg);
>  	if (status < 0)
>  		return status;
> -	cur_reg |=3D oldreg << 8;
>  	if (reg !=3D oldreg) {

I think the correct fix would be checking for (reg !=3D cur_reg) here.

-- Sebastian

>  		/* disable write protection for one write access for
>  		 * BCIIREF */
> --=20
> 2.27.0
>=20

--mfptafjvzvw5h7cx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQolF4ACgkQ2O7X88g7
+poTpw/4qkx6YJ+9tkZXsBoUZCdHoevMWeMg4FDt6d351ZoMDrZQyLWkrrQglRt6
rwnpaReLsWPt3q9TmZwsQ5892JZOZw5QMOUHyfGhlCBPp7wiY35PQ0Ihff0NyzoJ
KermMpArXyjcL4meLX8Q5NRlanU4TpDJwN03SmJziryemQI5ytwGxjBBXOcvq2hB
ck2Py7rSk8FgBAtNAA2tjV05eJL6rVRcD3JknZicSQ1F1CissdhlJS72OdUhRDVj
ydmiXywW1jTEMCMrXG92x3COR0Niv/MH0PjlMakYKrjUlD0hMXUsNLq4CRjknhRu
QnGF1kGtBSd15ANhNNcqOmSTyC7uWzvQTOnE1Ge0wbMNVXSNeHFvieRxN5EOEAC0
6Yt9xUDMQtMIVoBgzUk3GAdwSvW+mYBXC14UlTFzfRKh0GozhZSuG8Ee+rtEdovn
xqdTx/mxR75AWTiL/JsbAzrkCv3+Yt7sSwvcsz5CseNXxWvuWt/W7apC9HSvEd7O
L7eR1iaB42II2oJJBtZra0Lp4bscslMwmXK7B9/Zjkdn5SnD0vttBuBAEpgksU/4
thNJUNt8jtS0WSKbAjeJEWpFwxo9Yha1grP4wXqDgGpuEYZjUFLqp+C/HgSoS4sO
Onf5LmXisLayRqToKWUUEmRfOa+a/xTicUvyxrxeOVdmLOolbg==
=28ub
-----END PGP SIGNATURE-----

--mfptafjvzvw5h7cx--
