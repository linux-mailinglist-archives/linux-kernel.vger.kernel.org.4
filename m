Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786F45EB615
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiI0ACK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiI0ACF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FA9F194;
        Mon, 26 Sep 2022 17:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4456116E;
        Tue, 27 Sep 2022 00:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E603EC433D6;
        Tue, 27 Sep 2022 00:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664236922;
        bh=ZdXYo6em+HlkUDfGbNHS0iWVRZqCG576sXLjR0nNhsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gA7/k/dUl4T5FQxoUSKD1VS2619ryVOXQxt/mIZ7Fk+vey2WTkfWfQh+0BP2QPrj+
         LTGWID1L++5fNxohctqOtyzCc8HVDWNrT9snCldg7EHUO6spOn1ljMxur6Q3kaczV3
         +ORoIdE5yfNkGtZogaNpapBaFyoeoyWEpTSPtCBXq0wylT54eKerhtVk54g+AwX3Xt
         sDdwBzAYyKcLmYVGYCKp9LPlgMbwy9bmVJZbvWp77L8q1TGDSdrzdGsGNRudnsn/at
         11BK6UdBvfW2ng3KVQwo8vZ4xZ+S3I/6dLAT3SFQVcQU7460Ok+OvhPB70qjo2p5VD
         EWURNpJNW/3mw==
Date:   Tue, 27 Sep 2022 01:01:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the drivers-misc
 tree
Message-ID: <YzI9dTLick7jAXdv@sirena.org.uk>
References: <20220926213414.792065-1-broonie@kernel.org>
 <20220926231111.grxrydvfksyyk6t3@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QLXosb7uQZuyUgdl"
Content-Disposition: inline
In-Reply-To: <20220926231111.grxrydvfksyyk6t3@tarta.nabijaczleweli.xyz>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QLXosb7uQZuyUgdl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 01:11:11AM +0200, =D0=BD=D0=B0=D0=B1 wrote:

> Similar situation as
>   https://lore.kernel.org/all/20220926210631.657728-1-broonie@kernel.org/t
> but the merge appears horribly broken only in the non-english files,
> the english diff seems mostly fine.

The non-English files just carried on the prior merge problem (in
general I default to skipping out on merge conflicts in documentation in
languages I can't read, admittedly this is usually also in non-latin
scripts).

--QLXosb7uQZuyUgdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMyPXQACgkQJNaLcl1U
h9DsiQf/RH/M+341fn7zo+v8/U0Jyfb6xvKzowwuWqSPPaImjIQsqNV9PVaF/5ls
yjIABgsCz/3HtjjIyg70EgT3SNmXdo3F595a8AieJwVC9FBM9kp4x7al/7PZxvGc
ExapevQ90oi+7aEXfu6HmtfqbTrASsVqwE8CCV9EEP57awmmPQlFDQEAn4D3GuHQ
IDUUYmoWUVm7ENgUobp1oQLl9h5t+G2dVLAbjNebTCPwrN5uNwETQj7Dz6nq6jCA
NHoShtjPl7dgHceAHPvYJCYQU4Fo30lvAA+R0tuRM5ph3WAzWxrGTDafRVTtZlpu
V1VhWXyUCoHKTgUM7llLTlKXM+F6pA==
=aJos
-----END PGP SIGNATURE-----

--QLXosb7uQZuyUgdl--
