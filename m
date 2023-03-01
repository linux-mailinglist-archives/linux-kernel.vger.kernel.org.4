Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30F6A7591
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCAUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:47:26 -0500
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 12:47:17 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14F3E636;
        Wed,  1 Mar 2023 12:47:16 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.48]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2Dks-1oTv5w3m18-013cG9; Wed, 01 Mar 2023 21:41:38 +0100
Received: from localhost.fjasle.eu (unknown [IPv6:fdda:8718:be81:0:eadf:70ff:fe12:9041])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id E21AB3C015;
        Wed,  1 Mar 2023 21:41:34 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 2633B6C9F; Wed,  1 Mar 2023 21:41:34 +0100 (CET)
Date:   Wed, 1 Mar 2023 21:41:34 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 12/12] kbuild: add srcdeb-pkg target
Message-ID: <Y/+4fg3XX90CsTak@bergen.fjasle.eu>
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <20230215012034.403356-12-masahiroy@kernel.org>
 <Y/k+v/Yj8VQ6q32H@fjasle.eu>
 <CAK7LNAQXQDy1ijtbWTj97oejT=WAh8n3=PrHHBhDeAOjM66TfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQ7+L4TpDzkeMgn9"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQXQDy1ijtbWTj97oejT=WAh8n3=PrHHBhDeAOjM66TfA@mail.gmail.com>
X-Operating-System: Debian GNU/Linux bookworm/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:9zO9Zc2X72jMuqlEoVXeFnJ4dbzeSGoXoz/9LOZMeYOnSPSbN+y
 MClV+uzhlBxL4TX4CDfZSkqwCXVjG19OKzRQ1oZAIi3C0D65deRQTSVRgXqqwql2z5Km9Wt
 rBl/D5nBk1Kzpud2DM8PHHcSmPzzjcUdJUTkiIFlaUJWOMJIYTkNyM7j1FCY6mOHLLt0XjM
 3x84fuoTkIKgP0PF5iltQ==
UI-OutboundReport: notjunk:1;M01:P0:/7DwX/mjjuk=;vkgUb9SvuP9I8rVREwPUZUznLgk
 xMiZE/Wk/PCcTFvcYj3LqoRcMW7lawBD+Dtpsc/N8uaEEq1BOivZwBoXhOOhTygizq1zm0xT4
 SpfkL0rFWru9j6SlwBGeWw7SnmzXZ8SgGYUwToWFzh+E4Lnc/Cy1xMnM92+TU/ImT0wevNt8+
 OsW3DBoGnXs4oru5n/ia//QoZqF43iejBLvXrFWoyoi+SQ9Ps57iPpcSJpl9Ca8lKm3jMrKof
 pgN+gCyGtsoj7l+0E4xR2aML8UKO/hDTrwlfEOWJHn99ikPKmzbeplEemFsXGh1zsQ6tQNGnJ
 QjuPk6ZvlEXutbhzfpu/952BCk1G033qxGDU9eZPsw4Fq9Ldhg9m/m6tALUx4VH/tehOo/ldW
 KcdjKjQjCJICEZrA5QovLnNZP2cu4EJjRfoCwd05LdaMMjwdn9dak9CqDNgoLyZC8NRW6L3cK
 A1ceJDfviXyyvu9fI8GO/PXKtZcxZduYAygma2DRKp9wmdLTBkwHkPxOiZil5VLe6f+7bgoZ9
 8TMuovCMx760FrihptbcTxlQMgdJxnd82NcGNZ97skmJ6sT2oNgMzPNzmgWTdBeK60Jd6zSZb
 WRoPyz3Pz46LKlA8oc/CDEG8OoQqYVHuK+rFzOl/RsJN0jHoobsKF0trDB3YF4fqexz3y4aaU
 gIyhQh6EGXlHjBQvRlsyITdhpavjXTwq+RmfH+l/QA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQ7+L4TpDzkeMgn9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 25 Feb 2023 19:14:30 GMT, Masahiro Yamada wrote:
>=20
> On Sat, Feb 25, 2023 at 7:48=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu=
> wrote:
> >
> > On Wed, Feb 15, 2023 at 10:20:34AM +0900 Masahiro Yamada wrote:
> > > This new target builds only the debian source package.
> > >
> > > Factor similar code out to the 'build-deb-pkg' variable.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
[...]
> >
> > While testing, I stumbled over one thing, not really related to this pa=
tch:
> >
> > As tar complains about any kind of tree changes while it creates an arc=
hive,
> > 'olddefconfig' and 'srcdeb-pkg' must not be build at the same time.  Is=
 it
> > sensible to add another 'mixed-build' check in top-level Makefile again=
st all
> > target depending on linux.tar.gz?
> >
> >     $ make olddefconfig srcdeb-pkg -j8
>=20
> This is already done.
>=20
> The mixture of config targets and non-config targets
> are treated as mixed-build. [1]
> So, Kbuild internally divides it into 'make olddefconfig -j8'
> followed by 'make srcdeb-pkg -j8'.

oh yes, and already for quite some time.  I didn't check carefully=20
enough.

>=20
> [1] https://github.com/torvalds/linux/blob/v6.2/Makefile#L335
>=20
>=20
>=20
>=20
>=20
> >     #
> >     # No change to .config
> >     #
> >       GEN     debian
> >       UPD     .tmp_filelist
> >       TAR     linux.tar.gz
> >     tar: .: file changed as we read it
> >     make[2]: *** [scripts/Makefile.package:58: linux.tar.gz] Error 1
> >     make[2]: *** Deleting file 'linux.tar.gz'
> >     make[1]: *** [Makefile:1654: srcdeb-pkg] Error 2
> >     make: *** [Makefile:358: __build_one_by_one] Error 2
>=20
>=20
> I ran the same command, but I could not reproduce this.

I cannot reproduce it any more; I don't know what might had been the=20
problem on my site.

Kind regards,
Nicolas

--hQ7+L4TpDzkeMgn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmP/uH0ACgkQB1IKcBYm
EmkvsRAAsf8Yja7cS/DwEWB6AJlkdZGIVCFqWoD8pnU9xV5VybktxqWsnCe8tXPc
Ctb2WCFTfmmS6BgemhygV9utTTBmIqdOak2d84VpSxmowdiOLlCYaW6hDVOPoSBj
ZH630V0BwXC8D8O3o1xnofEUPOxuRGVpV6vqISbnpDQNdVnXNdWvm+8DsLPidPVC
S9eodeAbX4sa1ZV0avu/Iir8svN1ptO/JFHC5XsJrZ6gEgwQWt8jUK1660sJUROn
00IXUoxOY1FAcv1onqXNXrGAPbLdCF3oJTV/joxINgLU+HWixy3wEZYh0gOJnd1L
+l48uzxRKUnxFgF5fcTEa+J2dXf2YWjy5srrmluippRFYvCSCF9OKyGXYjUsH00b
PaZRNejhnhd6eaFhxAgALFX4G/ZIpleg9bA/32awh0X5bN1LmnKanE/dtwr49eVb
41L+4484H/2u32BzMLDCu01qk0jjBGpdOpsDB6wHQDc9/xQx0X0m8z99RdiTP0kS
XMIE7OG2BIyE6dxzeadmEegyEwX0WcdGAkiY/5fSykCzoTqJ7vqzyINdyCj80AMD
o6f1lsDGOdNzRQdBk7Z1bNIviVEi0gn4DoJe3ovucGuhZEzQYKahhH79Awu905Ln
9RQky37EEXt4rSOHnACEm4FABd063PQQtsLnIlPHd7QJScUFzXw=
=O+xX
-----END PGP SIGNATURE-----

--hQ7+L4TpDzkeMgn9--
