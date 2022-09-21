Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2475E5694
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIUXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIUXIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:08:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D6A6C20;
        Wed, 21 Sep 2022 16:08:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXvGp45RXz4xG9;
        Thu, 22 Sep 2022 09:08:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663801714;
        bh=o8A11v5386hRj0+IwrIDdZxBNoP6APmGk3QIng37BRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BlsDbVHmeiFpI1pIalAN4wcffG41hC0PvhqpDHw4qUZLXghCiM5vTk04YLk6vnYuR
         l5ftPMlxDHrDM8e0qEehjVah6S+lBr6K/Urh6BJWjJupNNKByyvRJOFvdr2dqpWSve
         DPvmT3scSKoKR1DEFxZGHeq3GRlUKIDLwwbF/FgBb6DilwMsmStG6OWJilYHOj52V7
         L8jtJqymUyf+Bdwm1tSk1QEJ9553BT2VXAMFTuGfNvw2msrOiy34M7eVDEIGbEQ1QX
         iwGvCQiufZ4NQZi1uXR+u74bRRPEUq7v6Aro7U9CwL3i0BNUQnrKYNh3zEV1zSPKpY
         eYvDBGsBkoaQQ==
Date:   Thu, 22 Sep 2022 09:08:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 21
Message-ID: <20220922090832.4eb474ce@canb.auug.org.au>
In-Reply-To: <Yysv1zoONYyZnM+u@sirena.org.uk>
References: <20220921185740.6e19ee1e@canb.auug.org.au>
        <20220921231304.5a5d0624@canb.auug.org.au>
        <Yysv1zoONYyZnM+u@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eUsKL/VPu1cRxJ.wXWscxre";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eUsKL/VPu1cRxJ.wXWscxre
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, 21 Sep 2022 16:37:59 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 11:13:04PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > On Wed, 21 Sep 2022 18:57:40 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > Changes since 20220920: =20
> >=20
> > I forgot to mention that there will be no linux-next release tomorrow
> > (while all Aussies remember their Queen) or next week. =20
>=20
> I'll not be able to pick this up tomorrow but I should be able to
> provide some cover for next week.

Today should be fine (I skip a day or two every now and then anyway and
I will do Friday). Thanks for considering next week.  I think just one
or two should be OK.  I may even have time to do a couple myself (this
is not a holiday so much (helping my daughter move)).

It is a pain that it is at this end of the cycle again, sorry.

--=20
Cheers,
Stephen Rothwell

--Sig_/eUsKL/VPu1cRxJ.wXWscxre
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMrmXAACgkQAVBC80lX
0Gy6lQf/UMIP3yUNfOIhv/nzUwTtQF7GecU91M1/x0lxuTxBz6uIeIIoA3/O//Tf
DrcU80jg57eM+jMP7mmj3Lbig8vNJ5OOUMTd3QhzxMYsphI0m4E/G8KKQ2BdO/WM
4ZqDWOIrSIkkZ7NVAd4n8asaXkTRt0ymAfopyn3H9KQ8AC6jfgqJdMn99eeScQxC
CVn7RrWE961gM16rkWXEFxoMYoIUYq11gjRG9NwsLtgue2LYExZ1h1IJZswaFJns
gAOEht400KNyzjdhDs/LjwDnHb/TQJJ9ibQaPEsqIF0YGTSew93p9NFRLB5FRutY
6+ssyJwRewPZn1fOWAOtBmx5n7OIRQ==
=nYwU
-----END PGP SIGNATURE-----

--Sig_/eUsKL/VPu1cRxJ.wXWscxre--
