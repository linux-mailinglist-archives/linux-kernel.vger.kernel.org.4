Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CBB5F71CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiJFXa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiJFXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:30:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875ED6C12A;
        Thu,  6 Oct 2022 16:30:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mk72q24Frz4xFv;
        Fri,  7 Oct 2022 10:30:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665099013;
        bh=AvsXYVMr5pUsHxl5+ynS9PRlAPjPZ2qP64JqGIETe9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d9hTaRTcxSo/v79Y4TBfO7he6feFJdrTte1OkN9NIETv8dMDCVtCaWeJZXMH5MzV+
         umR+KfyJqalfm/t+Dz/VvQTW1MpIit8cBkXmFTvbRSSc/trrKYx/FHDyww8RFHj4z2
         WnkzMTfpbeCJGxwi0jVz8i+KMChPMyd5Vm7NBxRu/r/Z5F2EVZtAumjaPExZJahc0x
         KaJ3cFu5ND+ZUexN0GReNVKPnW+O5bcaNBmQq8FLEHbga9egAtnNtVReyWEs1un2iO
         wJ8fJKTvy4olDu60p4GKbrfBPgTyfD1IlruI6duNo80GOCY6iW3aflcdcvSpNmyVyv
         qELDTs5Ylenrg==
Date:   Fri, 7 Oct 2022 10:30:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Message-ID: <20221007103008.3ad5913f@canb.auug.org.au>
In-Reply-To: <d019295b10f2d84e945d8e55ecc52e4f@milecki.pl>
References: <20220725095913.31e859ec@canb.auug.org.au>
        <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
        <20220815105419.4df1005b@canb.auug.org.au>
        <20220831091654.45d5ed41@canb.auug.org.au>
        <20221005114841.4540d325@canb.auug.org.au>
        <abbe10d1-4c2a-5fad-3f92-e55c514d3ce2@gmail.com>
        <CACPK8Xecn8ZREAqcLcuZHjA=NhaanRMKu4W39okAkBFX4aaOnw@mail.gmail.com>
        <f8416a63-3460-4b43-8532-2d5eacea4457@app.fastmail.com>
        <20221006111725.01ed0eac@canb.auug.org.au>
        <d019295b10f2d84e945d8e55ecc52e4f@milecki.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wpbl.L1Cxku3v9fLwievJ4F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wpbl.L1Cxku3v9fLwievJ4F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rafa=C5=82,

On Thu, 06 Oct 2022 07:14:05 +0200 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.p=
l> wrote:
>
> On 2022-10-06 02:17, Stephen Rothwell wrote:
> > On Wed, 05 Oct 2022 09:21:21 +0200 "Arnd Bergmann" <arnd@arndb.de> > wr=
ote: =20
> >> >> Agreed. Alternatively, we could just remove the pcie@ nodes from =20
> >> bcm5301x as a hotfix, as they are clearly not usable in the
> >> current form, and none of the three versions (5.19, Rafa=C5=82's
> >> patch missing ranges, and Florian's patch with incorrect ranges)
> >> actually conform to the binding. =20
> >> >> I'll tentatively apply the revert for now so I can send the pull =20
> >> request tonight. If someone comes up with a better fix, I can
> >> use that instead. =20
> >=20
> > I applied the revert to the merge of the arm-soc tree today and *all*
> > the warnings are gone. =20
>=20
> As explained by Joel, there are dtc and yaml warnings.
>=20
> Not "*all*" warnings are gone
> dtc warnings are gone
> yaml warnings are back
>=20
> Which may be OK, just clarifying.

Ah, OK, now I see.  The build I do (arm multi_v7_defconfig) does not
produce the yaml warnings (for me anyway - maybe I have not installed
some optional build tool?), so I never saw them - all I saw was all the
new dtc warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/wpbl.L1Cxku3v9fLwievJ4F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/ZQAACgkQAVBC80lX
0GyhKQgAgt10n1faLLVS2zCSGPjeQQpYAqxAP24Q7MmFdIbpzlEITRH3aefwXW6c
r3WHzyqB2noUhWTmx59fAbNj3hbK3SZ06QiZsgFPZx0mfkOePA8FPzw0ASRkUDDD
XQqRdqPXljueIshrJf6CfhQ/fiLFr2UhOWG+Mel+hyJdCb76c9X8oyfMCEDy8ypU
MFYbGhN5iM0IjAhee9cFwc3xtop/jxW3MrbQQ7jWtw1xC5HlXzGddqOOZA6b0U7v
i81W2F0/7RqUGEUAtoza9lM+w+o9HQuH6Q1ju/lvq9Nbey4oP2AWJJycB/9L1eO8
Byuv4OCgELAXF0vYO6Gk0sfk0Qx+Hg==
=l9W+
-----END PGP SIGNATURE-----

--Sig_/wpbl.L1Cxku3v9fLwievJ4F--
