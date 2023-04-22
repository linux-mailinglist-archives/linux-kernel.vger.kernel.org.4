Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B06EB8B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDVLC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 07:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:02:55 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB3C198D;
        Sat, 22 Apr 2023 04:02:54 -0700 (PDT)
Received: from [46.183.248.101] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pqB0z-0005WH-IA; Sat, 22 Apr 2023 13:02:49 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pqB0y-001pC9-2K;
        Sat, 22 Apr 2023 13:02:48 +0200
Message-ID: <cfa5b431bc00405dba363dac46c52c30ffe4ebeb.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] kbuild: add srcdeb-pkg target
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastian Germann <bage@linutronix.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 22 Apr 2023 13:02:44 +0200
In-Reply-To: <CAK7LNARnd=Jryg80NeRddYvHqHGTrzES0T5YNSAKShz3D_JGdw@mail.gmail.com>
References: <20230417142548.249610-1-masahiroy@kernel.org>
         <3a857172b78f1bbd6427600bdd5afa81dd21c73f.camel@decadent.org.uk>
         <CAK7LNARnd=Jryg80NeRddYvHqHGTrzES0T5YNSAKShz3D_JGdw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-hn64AqEG9HbDOBrnAoTV"
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 46.183.248.101
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hn64AqEG9HbDOBrnAoTV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-04-18 at 10:17 +0900, Masahiro Yamada wrote:
> On Mon, Apr 17, 2023 at 11:52=E2=80=AFPM Ben Hutchings <ben@decadent.org.=
uk> wrote:
[...]
> > This is also adding --no-check-builddeps (-d), which is not explained
> > in the commit message.  It might be valid to add this for srcdeb-pkg,
> > but the build dependency check is valuable for bindeb-pkg and deb-pkg.
>=20
>=20
> Yes.
> So, I added --no-check-builddeps to the else arm.
[...]

Sorry, I read that wrongly.

Ben.

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice - John Levine

--=-hn64AqEG9HbDOBrnAoTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRDvtQACgkQ57/I7JWG
EQnlqRAAptvwcLtQeeG4/TsblP6uGCMc+wyYPYJhUP7a+ppGrb9dw7tdFtBv/KY1
aCENZFs2hpjT2R51yeuf4z0Gqhv4JeBP2yZNouYSLLN6TXSxIQECB8t1YrAjsR1f
U2rYMwUuV2XRJjen002HuCIZM/AMl3OeQ8HygF3l3IX5P+d/0R65nkLkpsJBIo8Q
jgr7L0oVVt/XsX6hVlVH2qV2ADbHXNimh/Ikf4v9vLPRaaAApPS5yNGeew42XEuV
b1XVxiomxJ4HEpZlIwS/Cje06rdb7heRNJyUM6Tj+I0rw7JUUy+D5r4fSa7h0kg8
83djzo2jfWAXAuJoHAK+okkDzQZQCkYPB4oWQjgwkmF1sk2jWIWDMyD3x6rtcMN/
eFk5M2ObzJHjJfWgHHLFAX72/iI7anoS6IFBCTdIP3CP1ftO2FULOl3brl7KuROk
E4GUBPXofox16kZ+ndzyA+k7kSwtwI4eZxY87wEUPJ/v78PkSTIQ1ofygeOq/BU/
hgYgvhd8I7lhcCONlUAiBAwcz6YhpNilQwll2sl6wbqh5O5iqrRyNAQpiQX+M1vX
Gip2uinlB7K1nlvDWeNGy9TDEcOkiwpDWgyajxasL0VhFRBPc+BURNXXtJTV3Kys
4C2h/51gTN9CZxzqVPBoPZaF4dUwGgiii9UiMcy1GVMZ7WYeSko=
=25ge
-----END PGP SIGNATURE-----

--=-hn64AqEG9HbDOBrnAoTV--
