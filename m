Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4586B1C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCIHem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCIHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:34:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D8497F4;
        Wed,  8 Mar 2023 23:34:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PXLXd6R6Pz4xDn;
        Thu,  9 Mar 2023 18:34:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678347250;
        bh=yREH8XlXjO2yrtDQJPqN3+hY68a+a+tqz32NFHOHlPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rwe9vIkBN6RE++GTWx3khXKOV3+3jAIZZzWxqGaEJyJHerQ7YKwHp7xVRgnFU5zJz
         QhUSrnVfncTS8jedADW07qYAexCSzuFOjXI2rb2Jnf+jBlPnPl3ISEvvqLkYEcZw0I
         gUHZo6p9EJo8dCEY3c/XozfejpXxnl29dUZvid3RAXbXOFCZcemHXJmRTtl6j4PcG8
         vV9tm/aB7AZwqSVma+Pal9hCBhK/rP9S8O+D0O1J508EJYA/6zX8CXimPqHV52gaQV
         WwiB6iuc4CT0yDVdMdXDfl0w47H5eL2gCp2C/RdO1BBTcrTth6eBehW81/0pUb23gG
         n68X8H0qSXhGw==
Date:   Thu, 9 Mar 2023 18:34:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@kernel.org>
Cc:     Simon Horman <horms@verge.net.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error while fetching the ipvs-next tree
Message-ID: <20230309183402.21420df2@canb.auug.org.au>
In-Reply-To: <ZAlz581aBJewZLw3@kernel.org>
References: <20230309085415.0b738f0a@canb.auug.org.au>
        <ZAlz581aBJewZLw3@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p41gf7XpppYsgCtM+f3Z/r7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p41gf7XpppYsgCtM+f3Z/r7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Thu, 9 Mar 2023 06:51:35 +0100 Simon Horman <horms@kernel.org> wrote:
>
> On Thu, Mar 09, 2023 at 08:54:15AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Attempting to fetch the ipvs-next tree
> > (git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-next.git#mast=
er)
> > today produces this error:
> >=20
> > fatal: couldn't find remote ref refs/heads/master
> >=20
> > Should I switch to using the "main" branch?
> >=20
> > I also notice thet the ipvs tree
> > (git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git) has both=
 a
> > "master" and "main" branch.  Should I be using "main" there as well? =20
>=20
> Sorry for not letting you know in advance.
>=20
> Yes, please use main for both the ipvs-next and ipvs trees.
>=20
> I plan to remove master from the ipvs tree too.

OK, I have switched both over.

--=20
Cheers,
Stephen Rothwell

--Sig_/p41gf7XpppYsgCtM+f3Z/r7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQJi+oACgkQAVBC80lX
0Gzn3Af+MESOhteNxnVP2X5QwfqW9x3D96mtRdCcVR+FpCyVXpSz1lv3sOVPuAUI
84llb1msk3EsXcarDKSnjZNYYSsiOSju+uqqx/zcs8HGtqeD5tHU90xpANH47+jb
MFIEQz//2vPZr4d2sevqb0WPG5RVkXJ89dydYjcBzWs5kMuFFFrCFJv6NfDCdEfY
eX8sgWV6y0Hb0V4wzkJZF7w1CouFrzHT7pt14ZoJgP/QoStM/7g+mfNYPJUtdROx
eMnMsRCVzqLfz1Ry6MJrgLej4GNC5UeM8T+6EUPcc5xTo2RG94kRhJiEa1HwoxUR
iT/sAGuHeUAwYaGLYxUQooy9IHWS3A==
=coC4
-----END PGP SIGNATURE-----

--Sig_/p41gf7XpppYsgCtM+f3Z/r7--
