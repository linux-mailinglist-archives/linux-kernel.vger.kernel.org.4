Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB3619260
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKDIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiKDIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:04:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2E62656C;
        Fri,  4 Nov 2022 01:04:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso7486637pjg.5;
        Fri, 04 Nov 2022 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUT9DZbpPzw4l4DAivVDi0EHJEPQG34kR+pR9G4kRjg=;
        b=Md/JBNRCn6k9/QhyWKla++aSFaO2zdyAD5qp9CqqZqcQIXpZS6wIvXNCRJXdt4MxRM
         rEz+DMr8ik6JoCzVGfsyAyC1/vhUGZRLed4HsbCr+dYAsvUNxz/KzaIkn44NxF6JnuBi
         GYTpAyF/53lijkJENIBJK3pLmc6I2ctgtrivVQD/ezOop9cMbXHPGYky3QqTo8m0Gscm
         +2qBXPSUBSRbXRSrowinkW4Y03u9Gvwc0jWaZQcFZ+sbKImKoK6YlNtkMafLpp3JsKhA
         i9cOmH7PZxbJ+s5OC1UhFiNo1/EQRba1QUJSM/Q+slAV53xCZlxe/zz++L/WifiDOyDJ
         m6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUT9DZbpPzw4l4DAivVDi0EHJEPQG34kR+pR9G4kRjg=;
        b=Yogt93KT3lBLDD7OuGYm0rh28oeXeRE5Sd4ZD2tRyupnLRcBq9+8YyEtkPWRQPOMjt
         CG6bOs4bdlcRwIgvHUuU82XCZSPBmcgSjfY7pUHyWkrDS3d+k3+uOArMhGHAwZINqi2Q
         t4bg4efdfOREFDMw0h9xl8MVKNHr37JNc1DFDF4unNXEgJVOECmy/6iv4hYyjo0cPD7y
         QNlB4ry0CA4EtfqzMiuheLLZW5zUEm2Arw/WPeQRv7rOFLsfs35dBbcTq7CZSZef1vgz
         XX0JBHaU31s3ovm8jgt+mgB/4uXh6avfj4RwN/BQGcwNKLiD1rY6yDHUUrHtSpZlM7Wj
         5CUg==
X-Gm-Message-State: ACrzQf0lSRajXdlJNt01ttvg8y2fp3k16BK2aWfYDku+8li759zN+6Hn
        vIqTkEfNnD0tW/dcay4FS1WJ7LuzXunXxw==
X-Google-Smtp-Source: AMsMyM4lg9/eYiZ/A3PDExjYt5DR2FhyaBeK7t6Hn+jS98gAmZwB0y00of0wW29wPQBgTP/n2J0kiA==
X-Received: by 2002:a17:902:d484:b0:188:56f3:d374 with SMTP id c4-20020a170902d48400b0018856f3d374mr6547336plg.121.1667549049732;
        Fri, 04 Nov 2022 01:04:09 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-15.three.co.id. [180.214.232.15])
        by smtp.gmail.com with ESMTPSA id h10-20020a62830a000000b0056da2ad6503sm2073670pfe.39.2022.11.04.01.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:04:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A4A11103D98; Fri,  4 Nov 2022 15:04:05 +0700 (WIB)
Date:   Fri, 4 Nov 2022 15:04:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kunbo Zhang <absoler@smail.nju.edu.cn>
Cc:     dmitry.torokhov@gmail.com, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] input: i8042 - fix a double-fetch vulnerability
 introduced by GCC
Message-ID: <Y2THdZRV7Wg/1mSC@debian.me>
References: <20221104072347.74314-1-absoler@smail.nju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FjaVuQlRfQggdm//"
Content-Disposition: inline
In-Reply-To: <20221104072347.74314-1-absoler@smail.nju.edu.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FjaVuQlRfQggdm//
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 03:23:47PM +0800, Kunbo Zhang wrote:
> We found GCC (at least 9.4.0 and 12.1) introduces a double-fetch of `i804=
2_ports[I8042_AUX_PORT_NO].serio` at drivers/input/serio/i8042.c:408.
>=20
> One comparison of the global variable `i8042_ports[I8042_AUX_PORT_NO].ser=
io` has been compiled to three ones,
> and thus two extra fetches are introduced.
> As in the source code, the global variable is tested (at line 408) before=
 three assignments of irq_bit, disable_bit and port_name.
> However, as shown in the following disassembly of i8042_port_close(),=20
> the variable (0x0(%rip)) is fetched and tested three times for each=20
> assignment of irq_bit, disable_bit and port_name.
>=20
> 0000000000000e50 <i8042_port_close>:
> i8042_port_close():
> ./drivers/input/serio/i8042.c:408
>      e50:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # first lo=
ad
> ./drivers/input/serio/i8042.c:403
>      e57:	41 54                   push   %r12
> ./drivers/input/serio/i8042.c:408
>      e59:	b8 ef ff ff ff          mov    $0xffffffef,%eax
>      e5e:	49 c7 c4 00 00 00 00    mov    $0x0,%r12
> ./drivers/input/serio/i8042.c:403
>      e65:	55                      push   %rbp
> ./drivers/input/serio/i8042.c:408
>      e66:	48 c7 c2 00 00 00 00    mov    $0x0,%rdx
> ./drivers/input/serio/i8042.c:419
>      e6d:	be 60 10 00 00          mov    $0x1060,%esi
> ./drivers/input/serio/i8042.c:403
>      e72:	53                      push   %rbx
> ./drivers/input/serio/i8042.c:408
>      e73:	bb df ff ff ff          mov    $0xffffffdf,%ebx
>      e78:	0f 45 d8                cmovne %eax,%ebx
>      e7b:	0f 95 c0                setne  %al
>      e7e:	83 e8 03                sub    $0x3,%eax
>      e81:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # second l=
oad
>      e88:	40 0f 94 c5             sete   %bpl
>      e8c:	83 c5 01                add    $0x1,%ebp
>      e8f:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # third lo=
ad
> ./drivers/input/serio/i8042.c:419
>      e96:	48 c7 c7 00 00 00 00    mov    $0x0,%rdi
> ./drivers/input/serio/i8042.c:408
>      e9d:	4c 0f 45 e2             cmovne %rdx,%r12
>=20
> We have not found any lock protection for the three fetches of `i8042_por=
ts[I8042_AUX_PORT_NO].serio` yet.
> If the value of this global variable is modified concurrently among the t=
hree fetches, the corresponding assignment of=20
> disable_bit or port_name will possibly be incorrect.
>=20
> This patch fixs this by saving the checked value in advance and using a b=
arrier() to prevent compiler optimizations.
> This is inspired by a similar compiler-introduced double fetch situation =
[1] in driver/xen (?).
>=20
> [1] GitHub link of commit <8135cf8b092723dbfcc611fe6fdcb3a36c9951c5> ( Sa=
ve xen_pci_op commands before processing it )
> ---
>  drivers/input/serio/i8042.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index f9486495baef..554a2340ca84 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -405,7 +405,9 @@ static void i8042_port_close(struct serio *serio)
>  	int disable_bit;
>  	const char *port_name;
> =20
> -	if (serio =3D=3D i8042_ports[I8042_AUX_PORT_NO].serio) {
> +	struct serio *tmp =3D i8042_ports[I8042_AUX_PORT_NO].serio;
> +	barrier();
> +	if (serio =3D=3D tmp) {
>  		irq_bit =3D I8042_CTR_AUXINT;
>  		disable_bit =3D I8042_CTR_AUXDIS;
>  		port_name =3D "AUX";
>=20
> Signed-off-by: Kunbo Zhang <absoler@smail.nju.edu.cn>
>=20

Regarding patch description, there are several guides:

  * Wrap the text (excluding code or terminal output) at 80 character
    or less.
  * Please write in imperative mood instead (no first-person pronouns [I, w=
e],
    "make foo do bar").
  * When referring to past commits, the format should be
    --pretty=3Dformat:'%h ("%s")'. The commit hash is at least 12
    characters long (set core.abbrev to 12 on your .gitconfig)
  * Last but not least, place your SoB at the end of description (before
    three dash line).

Also, is this patch also applies to stable branches? If so, add Cc:
stable@vger.kernel.org to the SoB area.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FjaVuQlRfQggdm//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2THbgAKCRD2uYlJVVFO
o0cYAQDGnZxCETueLvCH1+rHlb5Hvmkk58Q94D/TcbWkIeAskgD8DH58m2pzzXa3
2sm/HYMWThEKp4rm5fFgq1P5EDfmGAw=
=YTdx
-----END PGP SIGNATURE-----

--FjaVuQlRfQggdm//--
