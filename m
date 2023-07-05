Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9143747BED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 05:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGEDwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 23:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGEDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:52:21 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 20:52:12 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB583E6E;
        Tue,  4 Jul 2023 20:52:12 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.200]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1q8m-1qJ6Oi1S6i-002CcA; Wed, 05 Jul 2023 05:46:28 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 9A6FD3E77A;
        Wed,  5 Jul 2023 05:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1688528786; bh=HnkD9VZba8t7ggYP/ui8iR+F9w6/BbeJgf9U4jNoFts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bACWThQ0STjRLlGa7U+gBKRTJWhMqgAmwoqdoekaINqID8B20JgF/YkCRMIIFp4DJ
         LcQY7l0w3AD1OgJp6jbRZ/a8rNqOT2ArnLR7+74wH+Jh3zsmyZlBVpqvo2+GAmmThg
         PzELgw3ErXm52hghxWYuMYvvLjLyILNgc8vjT5Dk=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id F02BF7E6A; Wed,  5 Jul 2023 05:45:52 +0200 (CEST)
Date:   Wed, 5 Jul 2023 05:45:52 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <ZKTncHqLwgbZbRVl@bergen.fjasle.eu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kOBcq0CHJ88AHU5w"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:pp5kItlLWfUuVEBBrxw4/Cj8PfzSumI1Wv52tVY0+OwNMVQpY0P
 zIVrKPiCWLd1XKNg3xbkcxTZClV5vxqKNv+XoCdIEBagCCsggFhH4TpcaTf4/ItNU+yQ9jG
 p4dPbZ6XYExTqX/0gRgVinshkuU4uy6EKACrY9CRqQRBA/ZX3h9cNzt+zKWedGMsmrG6sU5
 e3FGF+Hz3BBesI8jc90zg==
UI-OutboundReport: notjunk:1;M01:P0:JJCqAKtmOok=;L67Tq7CyphbVRDX9R06hxzDiipa
 MSE6/ROEPnQ3yNP1b3ZzaCkazmJfOaKP4QGzTreG4VmMo6SSOtXrEo+dHrH3cwvTxcCzT+yLv
 fwE6YGKJQC/6RMNdBq2h7DFvKnbeL8nely/PTaX1w1lyjuY0AKVYDKt9zVJ6wvu0ANdsQnGsB
 fcsLGyREcrFGKtS8Qg+LA40HQnyQoir0bdcjerX3HTRprHw9GKgYypWoy9wnUPLWD8e4WxtY5
 ZJdiitgV44IwkULuI/IYtJ+wRq4WCfwHW4WmkaEBWPrlxFV1Dnpf8PWx1KgJTdqKaV5cohLix
 yubSEfzJ0B+tUcrqXm9knai8WgrEPw609F6bIbeAFTBdsYvC58+Ht5L99r7ereCUCN9aos7S0
 6+Q3UlG66udl1MMdJRw6E3dXLQu+L2JAvs02jNBiIoqHuMNJv7YyGAM9w16N9wq+3ZRlul5c0
 zf4KNWW0wHLn2bXrEklDs/NsfFFjPTc866uc0iMcPQ+xQcCtfdwtRQ3/JrrTu7pkfiaYZuas0
 f17EIngueX6YCv2d/PXBXkqGXEIbyFjP1woX4Ib/d16hzCtMekIsHbuENCTmcvbP/d0MCo9UE
 bsSZUX8VTh0ANfm3WkAHYsg6FdEdfraVoJemtxO9BH0a2cRvJ9rpGuli1U6IzsXiL5vaSRflk
 M7Oq7LiKSQ8JeeTbFxpS8RpCbeAtgDGlcrnMjYalyA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kOBcq0CHJ88AHU5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 04 Jul 2023 12:49:01 GMT, Linus Torvalds wrote:
> So this keeps happening to me - I go to apply a patch I just
> downloaded with 'b4', and I do my regular
>=20
>      git am -s --whitespace 2023<tab>
>=20
> and the dang thing doesn't autocomplete.,
>=20
> The reason it doesn't auto-complete ends up being that my kernel tree
> contains some other random stale mbx file from the _previous_ time I
> did that, because they effectively get hidden from "git status" etc by
> our .gitignore file.
>=20
> So then those stale files end up staying around much too long and not
> showing up on my radar even though they are just old garbage by the
> time I have actually applied them.
>=20
> And I always use auto-complete, because those filenames that 'b4'
> generate are ridiculously long (for good reason).
>=20
> And the auto-complete always fails, because b4 just uses a common
> prefix pattern too (again, for a perfectly good reason - I'm not
> complaining about b4 here).
>=20
> This has been a slight annoyance for a while, but the last time it
> happened just a moment ago when I applied David Howells' afs patch
> (commit 03275585cabd: "afs: Fix accidental truncation when storing
> data" - not that the particular commit matters, I'm just pointing out
> how it just happened _again_).
>=20
> So I'm really inclined to just revert the commit that added this
> pattern: 534066a983df (".gitignore: ignore *.cover and *.mbx"). It's
> actively detrimental to my workflow.
>=20
> I'm not sure why that pattern was added, though. These are not
> auto-generated files from our build.  So before I go off and revert
> it, let's ask the people mentioned in that commit.
>=20
> I *suspect* the thing that triggered this wasn't that people actually
> wanted to ignore these files, but that it was related to the misguided
> "let's use .gitignore to build source packages" project.
>=20
> But at least for me, it's a real problem when .gitignore contains
> other files than the ones we actually generate.
>=20
> The only one that actually commonly affects me is the *.mbx file,
> although I could certainly see the same being true of the *.cover
> thing.
>=20
> And there might certainly be other patterns like this that I just
> don't react to, because they don't have the same detrimental effects
> on how I work.
>=20
> Comments?
>=20
>                Linus

Thanks for sharing some details of your concrete workflow.  I think,=20
having this in mind, it is quite a fair point to criticise the handling=20
(or ignoring, respectively) of files that are are not generated or used=20
during kernel builds.  But in general, I don't find it that easy to=20
draw the line; should we also remove

   *.kdev4
   *.orig
   *.patch
   *~
   \#*#
   patches
   series

=66rom .gitignore?   I don't think so, even though they (partially) fall=20
into the same category.

=46rom my point of view, this is a decision of personal preference.
I do like the ignoring of *.mbx and *.cover, as I tend to have those=20
files around for some time by intention.  But a revert would not cause=20
any trouble to me and optimisation of your workflow is magnitudes more=20
important, so I am perfectly fine with it, if you want to have the=20
commit reverted.

Kind regards,
Nicolas

--kOBcq0CHJ88AHU5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSk52oACgkQB1IKcBYm
Emn36xAApwKAOGE3Kyrg5laz1NIiZ3UJi2bbR5vBRUdRTv4XiYpNJGuEuFvTugcO
VcKbHcbVcL5s2Uau1Mau33eTbcxHKPn/mLrcqeOZICLv9XqeOgZbTMVD3nByhVwd
kJAqpSfJplElzs1O6r7duqaKRr6oXELHMtTxzl7Rn7ZcxqnJWV5MIG/YSjrjRNe6
rua6akR6k0i8I2Z78C2yN2wFnWMuLoMwJaCzPDkSqNg0H25wzr3Ge4fj63KuGpLm
IL7X/Eu30FbVMgcR9nev8ud0yb2FrAWenxwBfQDTEkSLiCKa+zLuax5uEFWI70zs
PCikiUAdhrm5vVzPaLQwQdi0d6EcWa2MgiO5IUWEPqk4iBYpV8G2JNb5JqJF9siV
650RFrrk9D1P8YH6aFH9byVivN4H/5Ay30by5xEyf2m/LeURPt0cQ4E3n3IMj5y6
p6xL7Znmd5vpbnVnbetnYQRlbmpa5jb8A3YP7rovMuIzRoWc52oFqdVcy4kxfQnH
v0B3+oKf4oMef1SQk9M5XGLI+p74IlYbKaFTf1C8DhEKgEPEBNvebD3viheDhPfA
Ms0odI0SeKQgf0mSy84aio7aO9zmYLS3M/IgRNFOoLoPE+mdJkwfRhCmbY3x6Sz9
BSJxB0mBb6T/lw3cZBNh+vAVddUkbpUtpkMU6CswWIIgt0BtHYk=
=Tr0v
-----END PGP SIGNATURE-----

--kOBcq0CHJ88AHU5w--
