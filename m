Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F896629DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjAIP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjAIP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:28:01 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8003AA;
        Mon,  9 Jan 2023 07:27:54 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.169]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N17cq-1on28P2f5W-012aag; Mon, 09 Jan 2023 16:27:31 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 931743C1B9; Mon,  9 Jan 2023 16:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1673278049; bh=s4fwN7O0YOUIvKRdDW8HwVKR/TWCB1S1O0HUPcdIC34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aqwh38l5TMV5qhD3wstQlMwgbTvb1EqYTI2tlIYS9jiuxGaCqmTJb5in3/PbfC6kS
         6c//83OPdRQoAKQiGjswT+ayElNQLbjZHq0xHxyjC9WhOwC8TGxm8rvL/q09TSYk44
         38yt++IerEC95GHCFQB9x4lk629tGwlXI7/oSkOQ=
Date:   Mon, 9 Jan 2023 16:27:29 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: replace $(dot-target).tmp in filechk with
 $(tmp-target)
Message-ID: <Y7wyYe52A6U5qOAQ@fjasle.eu>
References: <20230109134040.3191458-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J+023HwIdzFgwpYN"
Content-Disposition: inline
In-Reply-To: <20230109134040.3191458-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:kH6MaxCkdNqlhcIhC8UCAOpCLC/H3AViG+TujyrhZzqgrKI5139
 D+8tcLB6b7Wy2/opT1AE49P0aTT+5JpYMMKvcUJYBeyloEdLWj01hpq3JHy1CQvnT4LR2QM
 +8APzS9CWqOha+IR0Hv5ciPw8c1Ziruri4s4iNTHfpwdaf2RvrgWlaox9wk8GyjhcT1wwpt
 xwePL7I9mpg7BfTW5u2sw==
UI-OutboundReport: notjunk:1;M01:P0:m4ixR/S2FJI=;I4/1E/Xn+21fFwl8nB2VR8FH4Oi
 mINfUYo55WpkxngFjNsHPjvitiS6BaARGToBpMEDMPCSijk61mnbkkxkq7utPDjtw6/kOWZ3d
 jFJ/sJd4/CW7GdUyvqpcLIGoR9zJ5G7v69saG2FUpaedjN5y5KULOQOvTvVX0mWTWDz823JnR
 cFkamR0QPbrHk53yIAAi0FTINleVll7WzaCLM567OED+OpgKTDiZR3hu4mAtBcBsGJytcic2T
 mhoq05a51Hb6S+vX6bLOhcebabR7KaYtMeEGCx4B2Sb8dt5n464JlIunYfMB5wn2cBdyi9bQO
 rSHiBmCYt/WYD7GaBXGxqZhSk5yYwxegvyUI7U+MT5SNjPQ6y8gsNw6QVWKTKGYHR1qidnUpR
 A49C7vxiAJGE1TaIlNcwyglEBaq2JCsYA5K2V7fAatFTk6FDxYSoF5QyZxK9YhvpRw3KsgKez
 vAxZzXtSuswn9w3LzZVkR4EAmJBI5YHq4EnjsUJ2dX3NBzM1OkTOrUhJUJvvcTdB00dJLKQb+
 YzjyW4ZFr7M0BrnuFn9txXmcVHKZsEW6O9JGvDHd+DNMAK9VFqVbqnqhPL2Tbtl2DH9XFgImH
 O63v8wgBgtXV9mg//3PYv1xQ6Wu1gy27kcLjjDOzEYWYX0SNKA5rrf2IWCtMfvMKa8mxXDTxi
 k6RRKU1HDdwc6k4Lgjeri77Uc7y4T+jJIpQVFgAwbg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J+023HwIdzFgwpYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 10:40:40PM +0900 Masahiro Yamada wrote:
> $(tmp-target) is a better fit for local use like this.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Kbuild.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 4648ab8f11d4..7778cc97a4e0 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -99,11 +99,11 @@ define filechk
>  	$(check-FORCE)
>  	$(Q)set -e;						\
>  	mkdir -p $(dir $@);					\
> -	trap "rm -f $(dot-target).tmp" EXIT;			\
> -	{ $(filechk_$(1)); } > $(dot-target).tmp;		\
> -	if [ ! -r $@ ] || ! cmp -s $@ $(dot-target).tmp; then	\
> +	trap "rm -f $(tmp-target)" EXIT;			\
> +	{ $(filechk_$(1)); } > $(tmp-target);			\
> +	if [ ! -r $@ ] || ! cmp -s $@ $(tmp-target); then	\
>  		$(kecho) '  UPD     $@';			\
> -		mv -f $(dot-target).tmp $@;			\
> +		mv -f $(tmp-target) $@;				\
>  	fi
>  endef
> =20
> --=20
> 2.34.1

I do fully agree.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--J+023HwIdzFgwpYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmO8MmAACgkQB1IKcBYm
Emnt9xAA4DA0k9/FPc8eRMgBFJYzTSo5f8eUs/0kifdQzUADg1wKTWqP1XItSnyP
SGPsMM6JhODbVPJYdqQfnqSDVH/YtSImMtpld+pQmh/j6IR7SkgSx0g8GX8ixl8V
DCUjDpeq82nyGELNNOppesmYpIq/UyEXdhur0KZjoMIHfTHroQ5an4EDUOCAz2aB
PK1ayUPHQRgdSFI2jT83JsaEn/m+NAAEX5zydhmQB3Ad/S0ip1beB/ueszR5pVoL
AWfk8aoeU1ADD6jN1uB9nVT5t3w8DNZFilkOA2JKkJds2L+bd0eyD0JvOgVuNLgn
j1sS6kNao82Ci5HrDG0nSMRSlwaT6b/+Vr3pwAc+xqMmY5H9nUP4E60PEYTlMmap
NeSYfUjzUJj16oktrDqyfbmHe8Pu6Lg7UBsFWbi8+J4FBlH710TXa86x2M//7GRD
xj0iO37oagNo4abuCsJXIChlJDB2CtK9ctcjk6yca4ppzv+6i/ZAiB9N4d17D7lX
mFgAyfNx5QX9+2zNLS4C4mllCwelWTDVwojmI47s9+t3xRprdx5yE/3IirT7fqoZ
1zxtm0meunGZO2x3vrPCmfigmvRtYu6LEQOXriJDWhybuFixuH8pG0kIyeb46qr/
UPLAKaFXG3Szswd+w/NfPWTanGP4Z3KNHIDjAIYRjWavs0UZnVs=
=HSC8
-----END PGP SIGNATURE-----

--J+023HwIdzFgwpYN--
