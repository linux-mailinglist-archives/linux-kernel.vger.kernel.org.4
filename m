Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA05EB5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiIZXo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIZXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:44:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A98A1E4;
        Mon, 26 Sep 2022 16:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87313B81675;
        Mon, 26 Sep 2022 23:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBFBC433B5;
        Mon, 26 Sep 2022 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664235855;
        bh=P3ZX6MyCUs30QoR+fwBF0Oe7I7wz9oH6lnFboQXIXug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSeg1vTws9rAUOU6BPDEzJ6gG5eJ79hc/HHIVRdjTZKUI7QlQTrWCjLMvX5U5L2Si
         wPDJRLHBw1NS4p71xhMv6bEjk1yEF7FTqqho4cp30E38kuFivxvV6FN5xz24IlwO5n
         A3y4sxZb0q+MzXYUnCfoMsR4rmKrcDzGO/8noYdsX7cfRHY0EM7yB6/tiPcQOcBLtk
         +0cSNSGBK8Znx6Ie9UkdaQ+jwPUjRIERh2eonA7Fl0EyjUwdGOJouX2SQlUigeb7sL
         zo8Wrs742yadMtRdybzmxQQ/S9wX5N9DU9x3fd8oPMbif8hR2dFjRBJrUN2hHm6Xe3
         7PMCLkDplgjaA==
Date:   Tue, 27 Sep 2022 00:44:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 jc_docs tree
Message-ID: <YzI5SmGq9sK4gnFT@sirena.org.uk>
References: <20220926210631.657728-1-broonie@kernel.org>
 <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PxdvaDtjhg1lVtwt"
Content-Disposition: inline
In-Reply-To: <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PxdvaDtjhg1lVtwt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 12:46:21AM +0200, =D0=BD=D0=B0=D0=B1 wrote:

> If I'm reading the merge right (very much not a given!),
> it seems that the NBD_REPLY_MAGIC (and LO_MAGIC?) constant(s) survived:
> they both need to go for reasons listed in
>   bd5926220ffe0: LO_MAGIC doesn't exist
>   82805818898dd: NBD_REPLY_MAGIC is part of the line protocol,
>                  not a magic number=20

> This also reveals that I missed NBD_REQUEST_MAGIC
> (needs to go, same reason as NBD_REPLY_MAGIC)
> in the first pass, but that's unrelated here.

I preserved NBD_REPLY_MAGIC since the conflict was due to it being
updated by the NBD maintainer, I went with their logic instead.  IIRC
they'd also moved it within the file which might make the resolution
harder to read.  LO_MAGIC is gone.

It's not at all clear from what's in the file that your logic about not
including magic numbers defined elsewhere means we shouldn't include
them in the table here, though the commit messages are rather brief so
perhaps there is more to it.  It's certainly a very strong definition of
need as far as I can tell.

> The process here is unclear to me; I assume the "linux-next" here is
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
> but the latest update to the default branch appears to be from
> 4 days ago (and pending-fixes at 7h old has this file last modified in
>  2021), so I can't really validate if this merge is as I read it

I'm still in the process of building today's tree, all being well it
will be updated soonish (or I'll give up and hopefully things will go
more smoothly tomorrow).

> (or, indeed, if it does include... the conflict markers?
>  because it does appear to introduce them
>  (or, at least, if I leave in the conflict markers and commit a merge,
>   it sure looks like what's represented below)?),
> so idk.

I skipped out on resolving the conflicts in the translated copies of the
file but messed up on resetting the to the base state.

--PxdvaDtjhg1lVtwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMyOUkACgkQJNaLcl1U
h9DoYQf9G2EDMkaLBy7A2oDuLPgpdJjAlrLe/YoIu8uG9dXRUt2uF3uGmWdBQbK+
iQTnwc06FQ9QVCEMfuq7ympDDAfgLEf0rJeww7gEgWb9C0w5Ru9SlyDSuTSNG7CZ
QKltddDcJQLbnxBR4KbYvBv8HzQ+cuvC3NV0mfUyBZXUHzxc0kN0kyx4CQwunajw
30Ja+g6jH/q/3YctVZb5NCGlpvfz0qvFUl6AGnQB1xZUNV5RMvudBeRyGrJuMkji
uAAgqUgPeiVFe3JMc83O1Pn/5NWgj7uNB6eyIoEhNA0ogNm6i/Lb4n4A7A1EmFSs
+EQTwBvaJGNxWFg9G+57RsmrU123SQ==
=IPE7
-----END PGP SIGNATURE-----

--PxdvaDtjhg1lVtwt--
