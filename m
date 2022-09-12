Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96B5B5578
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiILHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiILHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:43:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBD1AF38;
        Mon, 12 Sep 2022 00:43:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQz9L4j8Pz4xG7;
        Mon, 12 Sep 2022 17:43:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662968598;
        bh=Hf64YqxWfZ7MGpbdGEo3OeEjS4uL2Y3kkUsK2sSqPq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BU0LxPwY+P2ZSD+gRvvSiBCQWRhNBiR5OIZnYnQOydK4sO9gd9y3sXKxnft3YQZtx
         dNxoZcFDnXPkgQv8/EyEUJrNUBQI4HNSzckW5WrGuNm5oxMxmrJVPfxhojfm2EHlEc
         smFgLurT7bhjX+UBrwL7sjzb4shK0dm64htG9YrcXQcbgzIfpKa8pRW5fjW+kUbjJD
         gSuBWsXMJAeUSifbkmPlhgYXZv6xxBpd5kDjs6HDPrRdy/Lz55Cik0VWyGEznLyqJM
         MNm3z36/pfCIRF5I1wKxxtKvDJhreq4JaMP01xCrRAEfgWqnM5Ov4a2Re2ORyDxHQJ
         xiIGL56BohfXA==
Date:   Mon, 12 Sep 2022 17:43:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220912174316.5f3b2baf@canb.auug.org.au>
In-Reply-To: <CAK7LNARiGrDcnkFFH8fZMpAVyUePRr58Zz_=nUf7nicfiKoQyg@mail.gmail.com>
References: <20220909090024.47458048@canb.auug.org.au>
        <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
        <20220909152453.5400cf7e@canb.auug.org.au>
        <20220909161354.2c94a495@canb.auug.org.au>
        <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
        <20220909174904.0342dcb8@canb.auug.org.au>
        <CAK7LNARiW66Hk5JJgRYb-edkb6sgTWPbNr1iETkq-RASCo-YkA@mail.gmail.com>
        <20220912095559.26de75c9@canb.auug.org.au>
        <CAK7LNARiGrDcnkFFH8fZMpAVyUePRr58Zz_=nUf7nicfiKoQyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_x/RtfZg.wmsuypITEknuGy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_x/RtfZg.wmsuypITEknuGy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Mon, 12 Sep 2022 14:06:01 +0900 Masahiro Yamada <masahiroy@kernel.org> w=
rote:
>
> BTW, as you may have noticed already,
> sub-directories are now listed in ./Kbuild.
>=20
>=20
> So, you will need to move the rust/ entry accordingly.
>=20
> obj-$(CONFIG_IO_URING)  +=3D io_uring/
> obj-$(CONFIG_RUST)      +=3D rust/              <--- Move from Makefile
> obj-y                   +=3D drivers/
>=20
> I have not tested the merge result, though.

Thanks for the heads up.

--=20
Cheers,
Stephen Rothwell

--Sig_/_x/RtfZg.wmsuypITEknuGy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMe4xQACgkQAVBC80lX
0GxYGQf9Gc7UbrPtT1wfAsD8yYvawAvfpEdDSvlOLkrZZNrgkg9cJsDqcbR++2eV
FHuw69N54Y85RD6vk8LAjNpQAPTNc7z88ActEEGEV+fEUkSzEPqebcKKZAmdfNhq
heTCHG92h06abduzd9ODZzVi2v3IVCVxnjr884MJHEAdrokox21AF5tuBmKi26FT
pFWIGM387sw27hMc7NWc4IEq849TDbCxzpSYiKvpk68DWhnmyd60y7C/ivhVRVsx
q9XVfrUTaiQCeDEx+3V2Vkv0T0iEMAEOtDyrYK88knv/snX29Q77a0CD6RKBlj6L
rukz8QnTa21hnOB/YKC5+beQG3tJpg==
=FeBL
-----END PGP SIGNATURE-----

--Sig_/_x/RtfZg.wmsuypITEknuGy--
