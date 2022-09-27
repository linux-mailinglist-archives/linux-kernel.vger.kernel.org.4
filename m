Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6535ECC77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiI0S4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiI0S4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:56:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC249108082;
        Tue, 27 Sep 2022 11:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA5A0B81D16;
        Tue, 27 Sep 2022 18:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65ADC433D6;
        Tue, 27 Sep 2022 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664304970;
        bh=HGeVjbiYpPP4sCGDrfvtvA1zLFNV5aRj7HXgPohKZLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLXHqfTyq+MVxdikgquIhYXcjuRva7NE3ztgxneY+6gFqyBVHSNmEjDIhkVkWHh07
         QQsdP32Egskccqe0JDCzhVBzxOPnbISCLDxGgBUSMHkK9FMqDmtF1dq8lh+5Iz8jFs
         Cmu2jfHwbUWGDlDFWnMrm5ZRyQadXSFLgR2qgW4H02NAHP7e9HtuXMvjgGY3VYoItR
         FJ8+eYlpRqoKP54kC9lkCKOfcOfdPDXkqRDn+akWi7AJVN22HFDnEQcI0eJ7KIWh09
         poBJJwLrRwJr1LkxW/jMS8NR/pzRii5CxnUebOxevlbnCrfN6cPZWHE2QrAdUP9vUr
         UeL4Y86vqb+3A==
Date:   Tue, 27 Sep 2022 19:56:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <YzNHRs2+qvLMOX6l@sirena.org.uk>
References: <20220926235348.1269963-1-broonie@kernel.org>
 <YzJF2hx4O6vnkVKC@yury-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2s8fUrKXh5fcqHWA"
Content-Disposition: inline
In-Reply-To: <YzJF2hx4O6vnkVKC@yury-laptop>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2s8fUrKXh5fcqHWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 05:37:46PM -0700, Yury Norov wrote:
> On Tue, Sep 27, 2022 at 12:53:48AM +0100, broonie@kernel.org wrote:

> > After merging the bitmap tree, today's linux-next build (x86
> > allmodconfig) failed like this:

> Hmm, this weird. I checked the next-20220923, and the drivers' code
> mentioned in the log differs from what I see, and looks correct.
> bitmap_weight() definition hasn't been changed in bitmap-for-next
> patches.

> Allmodconfig build looks good to me.

> Check what I see in next-20220923 below.

I'm seeing the same issue again today, the driver hasn't changed here -
the=20

> > /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.=
c:492:3: note: in expansion of macro 'dev_err'
> >   492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
> >       |   ^~~~~~~
> > /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.=
c:492:51: note: format string is defined here
> >   492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
> >       |                                                 ~~^
> >       |                                                   |
> >       |                                                   long unsigned=
 int
> >       |                                                 %u

>                 dev_err(rvu->dev, "%s: No space in id bitmap (%d)\n",
>                         __func__, bitmap_weight(table->id_bmap, table->to=
t_ids));

This is coming from a patch Stephen had in his tree "fix up for
bitmap_weight return value changing" which had been in -next, apparently
fixing some other issue which had been in your tree.  With that removed
things seem fine.

--2s8fUrKXh5fcqHWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMzR0UACgkQJNaLcl1U
h9CDpAf+JJss5+Ogh/R1JZDYOB9qss0vqzDdg64JTt/Cg0/l+uvIDaanrxrLHLYH
P0d4YOGC6KSgiVNE3kA/sdalsUNs5rlOEvauv2k11EoNnPH5lddtArscIt6z/ql7
4P8OkFFOYZLnNSX/mVHnjIGPH8SkBOxagFlCBD5qe3QaQQzSJYcvGvNcfHeq1vPA
AaYU2PR1FNnmsiYopdnzMJGYrYk8zJddzUt/PRveHhk3o4e71yrx0SFp+2ZrcNWT
+cdgw65nWaKOmW1MIUCdJ6KVzAb0cW4cdKY0w/1MeH5MLhz5apmpOIPJMxiC8Qb2
MmBpjklaayaCWHTQV+/8vojjTjqYgg==
=QM7F
-----END PGP SIGNATURE-----

--2s8fUrKXh5fcqHWA--
