Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26B636C62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiKWV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiKWV22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:28:28 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77D6EB69;
        Wed, 23 Nov 2022 13:28:20 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAchM-1omzyU36Xg-00B3Q6; Wed, 23 Nov 2022 22:27:14 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 4C46E3C0EF;
        Wed, 23 Nov 2022 22:27:12 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id A99151C7; Wed, 23 Nov 2022 22:27:09 +0100 (CET)
Date:   Wed, 23 Nov 2022 22:27:09 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kbuild: fix "cat: .version: No such file or directory"
Message-ID: <Y36QLYKPsP3BXLO3@bergen.fjasle.eu>
References: <20221122143902.272330-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opuONV987I6dLKzv"
Content-Disposition: inline
In-Reply-To: <20221122143902.272330-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:wcB8KOZbw5w+MYlywG4BsR3ncvHl56OhmVFsdGM7Aet/YbjVvgN
 WvCIzFA6CL9N3a8CK2Rn1MvoeQ6XXYZ7ZXTX8EUUhhD46dr6SeYncgO41/iMuiQhMTG2jg2
 w/EFBEICTHpDB/dCYexrf0nG9E3/hmgmATfpkqMj3h/hrkEGsrwoPeG7cwhEMMqFt8Zt3vY
 Mxcp0OnAe+mh9ks6SOaGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ARpKhisvOE8=:OEn2gdwYL8tIzybSXwhFRj
 guMacs5EupCnt/VVXhlgRyZ3RpScByNPXwbGcQ0w5R7IIMfDZHLEb74IvHBwUMeUIWbwIQjHR
 h6FGw5seNbLpbrjfKeoq9MTeTobU4teTzDJRBqjvhbB2GjKbDsdySmzqXgRn7bnH7rOiKRAqE
 BrHAgkI6b5j1xzLievoyqmbxbxQTG3B3xS0EU2RqjC0gAOKpChpNXGMFUWY2PCNxhzxKooT0M
 xVp60hVtqM388u8vKreKQWBRUACnF6fp2CFKvgurzXXb61AuX3nLS0YT4dR9u+OgdyTk5Kir7
 MBGhbyUKnj4/elqZpABpCGbxSS27bGFwdcYbW2sE1dSXHaLsm1TVBB4fx09y1YkTyGiOeXToL
 2UKeh+T4EC3FEb3+fiA/cGuM0NxptDzcTJBHU8j3a8AAZo3YNFNZmopzRrohVsmEqGBSaAibt
 UAqFwRL2yxODlBQ2MwsKIJUDKTCPNj+2C8fYropxNHjPFlqBbj4aAcYXngC6IrHYvR2nZExTI
 wlpip0BQH/g3ogTnJYPN8fRFxLcNNEptVJ9padEbsBOk2qnFzb2favEXt/3a/QXdNpalHy3y+
 E4PTTvHU1upT6/IIzgHH4jXLFFkxbYxoi1AZJU1ueW89wueSi8WLF5gM5s5pkzNoD1WUQDAfd
 jcokrVyuEJfojDGvv6zh1+61AF6bTWTSMbrUm3ywO7rZvXPDMsBQBGZggX+eRpVVTRbifDeHB
 ZOx7bpCHUDLTgcMeTb40swwWKdLx6ir10eIrKOV4Jc6u4DuKovcw313aHqjAiLp3pqk0Vmu2v
 2L3i4Fh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opuONV987I6dLKzv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 22 Nov 2022 23:39:02 GMT, Masahiro Yamada wrote:
> Since commit 2df8220cc511 ("kbuild: build init/built-in.a just once"),
> the .version file is not touched at all when KBUILD_BUILD_VERSION is
> given.
>=20
> If KBUILD_BUILD_VERSION is specified and the .version file is missing
> (for example right after 'make mrproper'), "No such file or director"
> is shown. Even if the .version exists, it is irrelevant to the version
> of the current build.
>=20
>   $ make -j$(nproc) KBUILD_BUILD_VERSION=3D100 mrproper defconfig all
>     [ snip ]
>     BUILD   arch/x86/boot/bzImage
>   cat: .version: No such file or directory
>   Kernel: arch/x86/boot/bzImage is ready  (#)
>=20
> Show KBUILD_BUILD_VERSION if it is given.
>=20
> Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
>  arch/microblaze/Makefile | 4 ++--
>  arch/x86/boot/Makefile   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 3f8a86c4336a..02e6be9c5b0d 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -67,12 +67,12 @@ linux.bin.ub linux.bin.gz: linux.bin
>  linux.bin: vmlinux
>  linux.bin linux.bin.gz linux.bin.ub:
>  	$(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
> -	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
> +	@echo 'Kernel: $(boot)/$@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`=
cat .version`)')'
> =20
>  PHONY +=3D simpleImage.$(DTB)
>  simpleImage.$(DTB): vmlinux
>  	$(Q)$(MAKE) $(build)=3D$(boot) $(addprefix $(boot)/$@., ub unstrip stri=
p)
> -	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
> +	@echo 'Kernel: $(boot)/$@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`=
cat .version`)')'
> =20
>  define archhelp
>    echo '* linux.bin    - Create raw binary'
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9860ca5979f8..9e38ffaadb5d 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -83,7 +83,7 @@ cmd_image =3D $(obj)/tools/build $(obj)/setup.bin $(obj=
)/vmlinux.bin \
> =20
>  $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build F=
ORCE
>  	$(call if_changed,image)
> -	@$(kecho) 'Kernel: $@ is ready' ' (#'`cat .version`')'
> +	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat =
=2Eversion`)')'
> =20
>  OBJCOPYFLAGS_vmlinux.bin :=3D -O binary -R .note -R .comment -S
>  $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--opuONV987I6dLKzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+kC0ACgkQB1IKcBYm
Eml09A//Qu7/V7O//D0qcovJqkD36htLpW40EJBvtf3BenETYOczNBo1ehrBXnuJ
1LoQJhynIgM4rlEdPve+5yJVH78Kh/y30v8dqLjUgVxykJlM7lzBrY/LrMKaUKjs
Q3C7tq4jHwNWqrCzbz6jkVS1R4y1ywafeyTYZ5WvgIePMzntKASv+EsKwRMaESpR
AAHpeQRXm8hJPvZXHs+lN12sqv7lLsGcCqU5I9gnBxontih+umtw9pfPGpWEJmTb
F9E6KF1c2tcT/OOTY1OUM2DOrCvynGDNGMsRLmbgPvhSu8sebVeje7GNz229k5qb
vKnId+5bkXZ4r3PtnCmN0MFTynyaP+g2wUXwYbwHnJ9cHacXwXtZWpOfYhNhXnOQ
eh4QUAyd1wUrNyf8h4poKkqD4ndHDsKYXpLI+hBeMn5fAzxl5/HBHaK7wcNT1RBd
GDIQqmv7+AAvxSSsSI2dLVScQjwl2FXofJWT1TANmYNoDC9cfQb/NDSNu7VS1l5E
KDulm8kAMBaUhU1938+pyl6wrlw7rPR5T8+ZTj90uSCtPTwlE8UGCSim0qyFbdSk
eacQgKZy6jaLQJq6GauflvTZ3BDjgE3AHyZtf0VdS2KNPjeoQQlXCpnHgZ6CHWpW
rvjl/fnxiABR1bxXuj3GnZu+aVWLsAbOjZ5ARAmfv9mxhzviXJ0=
=wyvE
-----END PGP SIGNATURE-----

--opuONV987I6dLKzv--
