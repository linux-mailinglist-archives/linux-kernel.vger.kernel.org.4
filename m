Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE46716D00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjE3TBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjE3TB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:01:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13F10D;
        Tue, 30 May 2023 12:00:48 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.138]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWjQU-1pbSuN1bWi-00X0pn; Tue, 30 May 2023 20:55:03 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 40D453E741;
        Tue, 30 May 2023 20:54:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1685472899; bh=7+tTLj7ZkkpypDR/yXXSvzEo0hl/cf47+VdmIcrlz/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhSGT3OT8oL/LejA0JHeojZXUI5QUe1hnidspSFisSpbkkq3IAPR5ZCNxtRiIFn+z
         Tvjwk9E7GSq7XBDe4NSmYF+fb1JK3Pe2RGt7rir1jGJ9T3pSvJvnGm2rSmv+ZmyzKy
         kwH0GkM6jya3EUQg9q1chwX6xkdqzhZMDKpfg7A4=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id E6816179; Tue, 30 May 2023 20:54:58 +0200 (CEST)
Date:   Tue, 30 May 2023 20:54:58 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: Add tar requirement to changes.rst
Message-ID: <ZHZGgvbTGGeYQXGE@bergen.fjasle.eu>
References: <20230521132336.1279523-1-masahiroy@kernel.org>
 <20230521132336.1279523-2-masahiroy@kernel.org>
 <ZG5vvdlO8sTbqP4U@bergen.fjasle.eu>
 <CAK7LNASmJrWnV3+z-RE4W57M9tVrd6EwsyA2T07CF8jT3ePS5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2sZq/OllSjUtaAk3"
Content-Disposition: inline
In-Reply-To: <CAK7LNASmJrWnV3+z-RE4W57M9tVrd6EwsyA2T07CF8jT3ePS5w@mail.gmail.com>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:SJYsVbZBKo0C1AVlFP4cTMUa7SxYGJHTftG/AN3wJWN++5uBrqA
 PTksSibSFLQyHRYqrN34vM9fg+95nzA3LXCU/3PqOAHrzb640loeuTbvx/14HTHXrYrvr0M
 wQqJA7hB7loZBdL8ep9dRfxWJnenVpr6fbj4Sg2b9wtWjgrkxBlygUK25P7J6XDYjtguvB3
 D9N60+OU9evh7Yrk+t7GA==
UI-OutboundReport: notjunk:1;M01:P0:yomuKxuFQNQ=;xcRH99lm28Z4nzrPxIGXBOaRxwa
 fYk26KMdNlWL/0UUwLCPkCMKCxL93nRkG8m5hAzBgdysxldGbxPlzJYunnCMG8qdq4b3XuOBz
 crFhjckPK/0qLymOWw3IfagtWnNCGbDYtBgRld+gnuyDiQ82OPC1UqKkPxdxlZHv9o2I3+wro
 Rih1n1usGtBUH7tGx+Vp9G6Ocrs0fsqaJKVU7jN1nHkLM+zvGH8zEIq7cClMP7VobwOZgf4fy
 bP8ai8HWqLXzhLr2/QiPAb0ZFdpZHy2lVS7T1eZnvEUMi8dr9rpolormIwmob9E0wa8kpOGO+
 xz7PlxoPdoMxadBOZSzg7DtCEVKVHquu+D//1HpT7+2WML7UAWE8SsbHTG5kgnLM9Bx2J+D8s
 6PHJ6RARDnNbxs2N1aKSfwHlcGbmsgPZR/z4PBcXNS9ypQhS6bBCbs+NSfemxgKp8/f/cjPZn
 2VH0HpQ83wm7ILBd8xUmNb+0xKNX2Id9bLTssxWCfH01GNCLhHE2PSqo1V+z1SW5Lw7q0AXk3
 9vlqBzI69jjzLlOhrQ/0N5/eAogPLoDV9d8VTLWqlcBqRXhdAcFWcIns+2x1kHEZWAhJubKku
 EOQVWFqZQC4u41mTk6NlIcuzn0Ny2djiwopWL7YRsZDG4A71IfJCJOiIAqDG/nmILUcLpr38W
 G+Wk344iWyDalZ7d+NJZCuWss3NiK46k/8BzDDD5Ow==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2sZq/OllSjUtaAk3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 28 May 2023 16:15:02 GMT, Masahiro Yamada wrote:
> On Thu, May 25, 2023 at 5:13=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu=
>=20
> wrote:
> >
> > On Sun 21 May 2023 22:23:36 GMT, Masahiro Yamada wrote:
> > > tar is used to build the kernel with CONFIG_IKHEADERS.
> > >
> > > GNU tar 1.28 or later is required.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  Documentation/process/changes.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/process/changes.rst b/Documentation/proces=
s/changes.rst
> > > index a9ef00509c9b..3c0074214d75 100644
> > > --- a/Documentation/process/changes.rst
> > > +++ b/Documentation/process/changes.rst
> > > @@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0            openssl ver=
sion
> > >  bc                     1.06.95          bc --version
> > >  Sphinx\ [#f1]_         1.7              sphinx-build --version
> > >  cpio                   any              cpio --version
> > > +GNU tar                1.28             tar --version
> > >  gtags (optional)       6.6.5            gtags --version
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >
> > > @@ -175,6 +176,12 @@ You will need openssl to build kernels 3.7 and h=
igher if module signing is
> > >  enabled.  You will also need openssl development packages to build k=
ernels 4.3
> > >  and higher.
> > >
> > > +Tar
> > > +---
> > > +
> > > +GNU tar is needed if you want to enable access to the kernel headers=
 via sysfs
> > > +(CONFIG_IKHEADERS).
> >
> > CONFIG_IKHEADERS does also require 'xz' (cp. kernel/gen_kheaders.sh),
> > should it be mentioned in changes.rst as well?
>=20
>=20
> It is true, bue 'xz' is required in other situations too.
>=20
> For example,
> CONFIG_KERNEL_XZ
> CONFIG_MODULE_COMPRESS_XZ
> CONFIG_INITRAMFS_COMPRESSION_XZ
>=20
>=20
> If we document the requirement for 'xz',
> we need to document the requirement for
> 'gzip', 'zstd', 'lzma', etc. for the same reason.
>=20
> So, I want to go only with 'tar' in this series.

yes, sounds reasonable.

Kind regards,
Nicolas

--2sZq/OllSjUtaAk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmR2RnoACgkQB1IKcBYm
Emm88g//VqDBnVK3E88ObcPSlVWeotqPiFEgB3D0C5nO6R78W17Xbm4AacqwX0W2
J34f4r2MAMa5Qx4d903ReJ/XhSPfn67d4NqtUg/FPcwU6XquYkVA+ZA4SzyjNpsP
jUD43JJ/CevePo4gi2PlvBDfE0WOl8b54hkyHyS3mU+bHLck8Kq6bzZYKtddBpwO
hRMPzEhW/wKhCa714nSX0C/oAz9r0pohOZuGuXt44kKZm+wXyZJ+wpEqbL0ZXa20
KGQc6Dh5NwkK5W+MO2+KhmjBxayBzhtu65BNG0cLJRgbV/MWX/vrSUeuKHVo7agT
nA6VQntt8bZb3dM01bLI24mm2/3zWuiLLt80ooxVjpRjlTgJW4HirzKWI9OsM0ME
iqVa1ZSInhuK3Hw8DCu9U1UD1350apwa6AV4bUSDry8RHOqaHK/ItjI2bsKQY1KR
Io+dtZCqsO0Yer9d5CtGzdEpbr/5HtcNvvSP8orBrpG7apZzZvpoApx9rkvkrZp6
FisTytNo3bIcgk9tH890t14wm9BY1RY83L4CUnOWROESNwbADH5DCC8ISoPp3Yxa
bpGEVY3IxcrRnP+/aaU7n/HTnAY3nrmIl4u3LOL64i1cgc/yvRQMuzqh19OdSq5Z
pOA/nwwyMWTpl9AuEH7aJO1MDocy2EBYWojVNYJaaqAZdH3FLGs=
=L/i3
-----END PGP SIGNATURE-----

--2sZq/OllSjUtaAk3--
