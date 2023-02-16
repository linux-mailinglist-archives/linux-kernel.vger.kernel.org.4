Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F06999F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBPQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBPQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:26:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3FC497D2;
        Thu, 16 Feb 2023 08:26:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166D661573;
        Thu, 16 Feb 2023 16:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D196C433EF;
        Thu, 16 Feb 2023 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564812;
        bh=vbHAxZJYXbMklTvORNYKsL9yojiYsRz76iRI93JSV+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9N4tdFyLM4rwcMlvUTogdhaXT8q6UoM0R5s4pwJV6N/Hh7BgROd7RR0LjlIHBqhv
         YB5TrGtkf/F77Gq4O9KwDd7uimRwPjZ9riPIn+VvNL5Lr1LwcV9q+WfDfSGKLgMTNP
         jRxneHSml4ox+hH6lu0OYgm5W4mmn2FLyvi0O1r48iOzzuGqodiRSXdxNcq9whhAza
         YqfhZa7tAoZSMf9t2ZpdVxTVxaU/r6Acl8P9q15u0c2b4qTWl9DfgSz9djf+Ma8BLI
         jboKBSUxfk3Z+9GSJfxdbD0m2o8CZp98xrPCMfZiqhxVaLKh6wN0C5rTYlDNiYE+uh
         piALQ540mdpdQ==
Date:   Thu, 16 Feb 2023 16:26:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI updates for v6.2-rc8-abi
Message-ID: <Y+5ZSUB8WYPdA0az@sirena.org.uk>
References: <20230216131125.4A6FAC433D2@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmlF8D8AVX6jJdyq"
Content-Disposition: inline
In-Reply-To: <20230216131125.4A6FAC433D2@smtp.kernel.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmlF8D8AVX6jJdyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 01:11:08PM +0000, Mark Brown wrote:

> spi: Update for v6.2
>=20
> One more last minute patch for v6.2 updating the parsing of the
> newly added spi-cs-setup-delay-ns - it's been pointed out that

Sorry, operator error here - this is clearly pulling in far more
than I had intended.  Please ignore this pull request.

--nmlF8D8AVX6jJdyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuWUgACgkQJNaLcl1U
h9AfIgf9FJvjYEVplolqrBAzdYUxCPtzJvQL3nMjuRMRJpL/8gEhPYnsx3U7bDAh
HIkPavuh8t6SvLJwF72RhHgC50VQfkkcqB4gRQZA+gDQ+D8sKInMAEHKeqGa4zmN
i3XbVCgk05q3pTLczOctWYBGtjizc0GnA92BEaOJCKvuTgOwLixCTInua98tDKhl
oPSR+ITrA87XNailk/C2G7Zv8a3Y51HLpTKyCG9bcD6A0K29Jed71UTAevnx3mw0
4y5Vae6eOpnCF2pKSaONIWyIWapPyeblzo9kPqE+ST1nlFWdbVu81Ke63Bj+Sjfk
nfJuzMPDq2ctWHHXe87RroqRRcLd4Q==
=YH4M
-----END PGP SIGNATURE-----

--nmlF8D8AVX6jJdyq--
