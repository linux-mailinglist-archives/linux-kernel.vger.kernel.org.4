Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F96234DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiKIUrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKIUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:47:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C042FFFF;
        Wed,  9 Nov 2022 12:47:41 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.48.111]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mc06b-1pPkCb0Bgt-00dZTI; Wed, 09 Nov 2022 21:41:38 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 0BE303C0EF;
        Wed,  9 Nov 2022 21:41:27 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id EAC546442; Wed,  9 Nov 2022 21:40:55 +0100 (CET)
Date:   Wed, 9 Nov 2022 21:40:55 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modpost: Join broken long printed messages
Message-ID: <Y2wQV6JX0nbkpGtL@bergen.fjasle.eu>
References: <d7365c44c13b563e9576cf23bd68d64e5ea57f6f.1668000538.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C1efxTHKFb4PJVpW"
Content-Disposition: inline
In-Reply-To: <d7365c44c13b563e9576cf23bd68d64e5ea57f6f.1668000538.git.geert+renesas@glider.be>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:gvRJZdwuLpqulJ/Nco7xilXQ/oYnKssoI35mKqzOTz0DFXASemC
 UTDMT95IOKrgqr5L/yRVQg90CyEkVNCyCOgBJA11AfjS+j6LMMi30CHF47Kn6chzBHdi9EV
 UsiCBEBp55k4XXxvLz3/KlfAUoBPmH6SfsasCR6rxrfVbPKhjM2C+23r+fR9dFydt9ipacI
 h3rKwlYG+SxQZ73JPdtDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0yl11DVIV58=:ZMwfPhMxnb8gcsqj+HAFTI
 RrMVdbMWzRWi2c114PQkW+NVNPDW6MDGNXUd6KN/6hwBC4aE62AelzHGBl4qolJapyE+c47iZ
 1sZyfzfGQZHqxk+JdKkZhf3d7/QPzQdBMcolPeqwgP9Us0DQAXwMzO4ueOBUAWBalwzETd0nN
 ajB20vXWgC0od/BiiXBgaEftXP5XzmEubKthCm8l6Q2HjJDVx7bFSUQMYEl0Y9zQFBirodgb7
 J0LTZAd4rtiQwMlNCT1fY2+VLIiGF9SoG5G1gbfbp0L+8ywwQKevdIMHp49a3IEfdS26KqVUZ
 UWc5xqIuWxm3qbZYZuCs0ZOyUoqGSJv0dkZfBqJzrvBgECJ6IN8hFq2fGjE5pbRrs0wYXA5yT
 u8eVLGt+BAzOxEFGHKDYmjzuJN2g1syQO2HVAxUDWtVNUHL6Ug1MqLlMRJBJD1o8xFUkpk7Nh
 xXVWFWH0mure43suXgpvD78cCHqtcrFLZZJ2+JaGOuqtib1ifTKIdpXu7Gl/YCCXYBy6Yud9a
 gUHZbySI3RQvCXMYfgXuas/byn8uBImBJNdd4x8CXLmCJcmBxnG7rgtPA+vCtVimbW7C8SNo4
 8OzmZrVoZbBa13EK68v9rzHpKs2ScRgF/0B97kZf9VVbP7kiFcf6XfklSeV190lLYiZEerzVR
 o3EIGbNw3KE45+QOLAXdZkg94A9xVvqW5/WXMdMPw3E3M0jdvM9fQY4/dhaOgc9Zmq+s8r9Rq
 FafZU15XM3fBqBMHSgmsr6GM0juumenvVBnhZuDaq7+Pbip5F6SShfjHBtYbX15LQdCxYRvHd
 WVy+wjeYG8vLatff/T+hOn3X4FwjA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C1efxTHKFb4PJVpW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 09 Nov 2022 14:30:55 GMT Geert Uytterhoeven wrote:
> Breaking long printed messages in multiple lines makes it very hard to
> look up where they originated from.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

thanks, I do appreciate such changes!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  scripts/mod/file2alias.c | 18 +++++++-----------
>  scripts/mod/modpost.c    |  8 +++-----
>  2 files changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 80d973144fded3b1..7df23905fdf1cb36 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -140,25 +140,22 @@ static void device_id_check(const char *modname, co=
nst char *device_id,
>  	int i;
> =20
>  	if (size % id_size || size < id_size) {
> -		fatal("%s: sizeof(struct %s_device_id)=3D%lu is not a modulo "
> -		      "of the size of "
> -		      "section __mod_%s__<identifier>_device_table=3D%lu.\n"
> -		      "Fix definition of struct %s_device_id "
> -		      "in mod_devicetable.h\n",
> +		fatal("%s: sizeof(struct %s_device_id)=3D%lu is not a modulo of the si=
ze of section __mod_%s__<identifier>_device_table=3D%lu.\n"
> +		      "Fix definition of struct %s_device_id in mod_devicetable.h\n",
>  		      modname, device_id, id_size, device_id, size, device_id);
>  	}
>  	/* Verify last one is a terminator */
>  	for (i =3D 0; i < id_size; i++ ) {
>  		if (*(uint8_t*)(symval+size-id_size+i)) {
> -			fprintf(stderr,"%s: struct %s_device_id is %lu bytes.  "
> -				"The last of %lu is:\n",
> +			fprintf(stderr,
> +				"%s: struct %s_device_id is %lu bytes.  The last of %lu is:\n",
>  				modname, device_id, id_size, size / id_size);
>  			for (i =3D 0; i < id_size; i++ )
>  				fprintf(stderr,"0x%02x ",
>  					*(uint8_t*)(symval+size-id_size+i) );
>  			fprintf(stderr,"\n");
> -			fatal("%s: struct %s_device_id is not terminated "
> -				"with a NULL entry!\n", modname, device_id);
> +			fatal("%s: struct %s_device_id is not terminated with a NULL entry!\n=
",
> +			      modname, device_id);
>  		}
>  	}
>  }
> @@ -1154,8 +1151,7 @@ static int do_amba_entry(const char *filename,
>  	DEF_FIELD(symval, amba_id, mask);
> =20
>  	if ((id & mask) !=3D id)
> -		fatal("%s: Masked-off bit(s) of AMBA device ID are non-zero: "
> -		      "id=3D0x%08X, mask=3D0x%08X.  Please fix this driver.\n",
> +		fatal("%s: Masked-off bit(s) of AMBA device ID are non-zero: id=3D0x%0=
8X, mask=3D0x%08X.  Please fix this driver.\n",
>  		      filename, id, mask);
> =20
>  	p +=3D sprintf(alias, "amba:d");
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2c80da0220c326ef..56d856f2e5115150 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -519,9 +519,8 @@ static int parse_elf(struct elf_info *info, const cha=
r *filename)
>  		int nobits =3D sechdrs[i].sh_type =3D=3D SHT_NOBITS;
> =20
>  		if (!nobits && sechdrs[i].sh_offset > info->size) {
> -			fatal("%s is truncated. sechdrs[i].sh_offset=3D%lu > "
> -			      "sizeof(*hrd)=3D%zu\n", filename,
> -			      (unsigned long)sechdrs[i].sh_offset,
> +			fatal("%s is truncated. sechdrs[i].sh_offset=3D%lu > sizeof(*hrd)=3D%=
zu\n",
> +			      filename, (unsigned long)sechdrs[i].sh_offset,
>  			      sizeof(*hdr));
>  			return 0;
>  		}
> @@ -1355,8 +1354,7 @@ static void report_extable_warnings(const char* mod=
name, struct elf_info* elf,
>  	get_pretty_name(is_function(tosym),
>  			&to_pretty_name, &to_pretty_name_p);
> =20
> -	warn("%s(%s+0x%lx): Section mismatch in reference"
> -	     " from the %s %s%s to the %s %s:%s%s\n",
> +	warn("%s(%s+0x%lx): Section mismatch in reference from the %s %s%s to t=
he %s %s:%s%s\n",
>  	     modname, fromsec, (long)r->r_offset, from_pretty_name,
>  	     fromsym_name, from_pretty_name_p,
>  	     to_pretty_name, tosec, tosym_name, to_pretty_name_p);
> --=20
> 2.25.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--C1efxTHKFb4PJVpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmNsEFIACgkQB1IKcBYm
EmnqkBAAyHxGSkc1QiZy0ks7S6hWW5047gXf3CRy7XGmEEy5lE/5ljMYFnkQ9rkY
c/FvuVwBsjq45sUEj4T5u+EbN2TJiGQaFfWPrflkJ7qq2iCTClIf0zJMWwIXlwIH
OL9zqXYgTNcNlkkyzpNLcB2VceAsX9TDLRj7UlXik3AcXFlktIYHeOqqZ00kQ+kW
AXuTuQjX7mf/IKVNT+Th1lv/1oRhXvBlX99ebD6MoaN1KbQt6Ce2sNUzBbOar+eY
nofkEKYgqWECrtBxjDq01eeXk36LNmOXbeuhPvmt8kjFSbM1pf7Ji+W/Zft0bSCU
AsxR5KSFAqTatVcPukyxDrFIXj2iixnIijT3PPvTrO3PWLid8UpT/0w/W4hpYpP3
jy+GbnVdJ1IFlvA34aKrKMP+OtxhRnj7oMtqKKgJz7LrFLl3veESwxYDI2FADNXk
lzaIy/oe59qW9HJp7hoH5Z9QtD6yZwB6f/GOcTGT2hB80c/dLMgLK5f++y9wGNtO
9u5ERmNbMy7bdofLjQqpttEfwfOkEc2NSY6dC1d9hKwinLap/Ww0lPm/K3N2V6+D
SFvUUW71+PDSXyZhPy200rp++pp7JR+wdRfmGGODG/TXn8NEhda2NQXxwpNOeDr3
TfHJ83W6oZ8SerhZsf6h6EwUpaW4qh+N5QYhmk7/hZYJbsUDNR0=
=9+nj
-----END PGP SIGNATURE-----

--C1efxTHKFb4PJVpW--
