Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16B76A246B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBXWnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBXWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:43:00 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F988696;
        Fri, 24 Feb 2023 14:42:54 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.255]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3lLh-1pVxw40mTz-000wTV; Fri, 24 Feb 2023 23:37:11 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B245B3C1C6; Fri, 24 Feb 2023 23:37:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1677278227; bh=NVte4m3e/9C0o4T5mfInbxtnfjIrFf5rYpccNuHdXQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYWWYz9/ejeGIpYRRJ56T7uLPlxwG5Qh5ZEaPg2XiJejNHki9W5EfJJGaEmHHZ7Vk
         pvuFTtQBrcjYYBPRfxZr7xJWbZTG7gq9eu9JToJx1KRPkhMuaCx73Q+JOSaHyHSo0V
         t3phKZopWFDeXmWAMlT9FRaedxl+PUYQL85b2jNU=
Date:   Fri, 24 Feb 2023 23:37:07 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 06/12] kbuild: deb-pkg: make .orig tarball a hard link
 if possible
Message-ID: <Y/k8E8N5W8L91EpB@fjasle.eu>
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <20230215012034.403356-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxYSgjOh4Jmozfz8"
Content-Disposition: inline
In-Reply-To: <20230215012034.403356-6-masahiroy@kernel.org>
X-Provags-ID: V03:K1:8a0zJCfyzBwCzlfBiDCwhvMXDdDSPXNNzVawKks10QebQhaJqCq
 QC2vIVukdjRLoD+0BM25V0HArqrDd6PltvBTBj4YANn75vfkwl5lihtCyi1YmQpLrGOLw/m
 5K85Pg11qPhudbapCfHeiLduufXKKbLvzWydcG7bAzC5MPCVRaklKqJHkToZYHOAnC4pyet
 zuZ1HkA5A+z0vdfgq+Svg==
UI-OutboundReport: notjunk:1;M01:P0:ZIWKOIp/cPE=;6x1lYNRUJ1sJffHUDCFVK3f62oi
 /BtSsLmb7fL/YOrsca0KiR/jX303cgnHfWIQsyEKwtbFmr5jldAketftWvfcH8bOsWIDZJA7A
 LuFLRdaZKwJYzMAcEnZ7+6oVMnpffqt9mXYn+ybfrcaH6Rtd4fhD2CbDWR68+af17PARvhr9h
 dtTKc+zFQ1WNwsR1CyiJ5fdS4zJhYAO2xuNNVxpeIYi9l/HgkjI3z7PfhbnHfBlyTi47jCeai
 eNufxAE4V3J6+D3UVScCWtA2udPoWskn1VCdQ15sqIdYVYyM5e59rHSKRJQHWLfDOQrpTZz+Y
 Wz+GHGvQdTUjflh1xoj4ED6Qq3D8zbTt0VquGvmB4SVKMz/fh4X17D7jYWpdLDZTVN4bP0gxd
 OUfyAP1EMvCFjJMfIzX/lYc5sHjlLVY8eL8omwWcv9dUP5ueMuiyaINy8HmUkhQCY75NoKAgU
 u0YsXh7GAmYiHNEweppdCFOhmtfLnIUaBUhAgMCRQSyhaK/P+hQWw+MkbNBh8fYAIpBNrt0y5
 4MGCMQy04XPTR+CE6yESljKv74Q43CrKJ0PPKpf3EW0LWL3OmcG0+bo7E/OSxRoiWXl9GQM2U
 rl54kjo2q3NlR+NsCvkK65PzsEfSKKwv0AoKGGDcB+/uGBE/KpbFpPuQMK5geUUfGIcMBtw5a
 umERpQgZ4rCXcmGgMJCbrNt22XSvCXi30uCtCyMwEA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxYSgjOh4Jmozfz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 10:20:28AM +0900 Masahiro Yamada wrote:
> If '..' belongs to the same filesystem, create a hard link instead of
> a copy. In most cases, you can save disk space.
>=20
> I do not want to use 'mv' because keeping linux.tar.gz is useful to
> avoid unneeded rebuilding of the tarball.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v6:
>   - New patch
>=20
>  scripts/Makefile.package | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index c207f4ec47ac..80a96eb61426 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -96,7 +96,11 @@ debian-orig: private source =3D $(shell dpkg-parsechan=
gelog -S Source)
>  debian-orig: private version =3D $(shell dpkg-parsechangelog -S Version =
| sed 's/-[^-]*$$//')
>  debian-orig: private orig-name =3D $(source)_$(version).orig.tar.gz
>  debian-orig: linux.tar.gz debian
> -	$(Q)cp $< ../$(orig-name)
> +	$(Q)if [ "$(df  --output=3Dtarget .. 2>/dev/null)" =3D "$(df --output=
=3Dtarget $< 2>/dev/null)" ]; then \
> +		ln -f $< ../$(orig-name); \
> +	else \
> +		cp $< ../$(orig-name); \
> +	fi
> =20
>  PHONY +=3D deb-pkg
>  deb-pkg: debian-orig
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--qxYSgjOh4Jmozfz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmP5PBMACgkQB1IKcBYm
EmmeQBAAv13H1JZw7oaHPtLFIWBB84ySrshJfkep+41mj8MCBxMNookp1I/hmUuD
634ioubZhgXjp+xR7TKjj25rIivwHjwtDumMZ5ewvlV6ohSbO8MyRe8O0RKGjJVr
gNPJncxz1bGhXDtcXNGvHsJ65mTJdl5l7KUbMSJCi4ggL4//+VFsfnv7Jxb+0RSZ
gjKhTyHB4LWRYMxAc3moAMiggC9/67KUq2TH6OctuA+kz3tD/dS4yari7eRERq0q
SdU/N6+h5U5rrY7qQk5iSMMGeNf+/gYkAPUt+v+Iu5fwVP6bXqe7ymq4QIvq7Cqf
vjCulHXP0AlcYpb4m+oW2jl52M+BMzS4mXaszueabEZRLEIl2s9A98aYhg5seDg3
DhZ0ScnkrwBbw9sbIUoTynhwX+Y9rJCvC3RylfzcSWanGrsSWPtspMiUV+y0+Emq
iF6AdxQ6NnEoO9KZ2EuVnbyWAmLAusgiEN0Bt06WpFXbLNg4N0M9Ciz5ZNLEy3U1
MNvtDYCDOmC8hL/Cus5GQDqDlZL7rV/UI1oT2rssEZIDbko5Ant/P0iyUmu6Lyuc
XQYPHs2Pzh42QlMGGpqREujgyZFDiXLjShJO9dZZsgB2yTyY9kjbhnSFm/L6ySBH
Qjzw5GxdPB8EAGPeU3NArgM+JJbgLMfk/mcqNz454hQIn/y9aDY=
=S61U
-----END PGP SIGNATURE-----

--qxYSgjOh4Jmozfz8--
