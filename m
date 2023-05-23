Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3684E70E49F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjEWS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjEWS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8C19B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED40660DBB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FA3C4339B;
        Tue, 23 May 2023 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866356;
        bh=84usJSpGpBI3Z1x+GJuKV/qWu0n30FukNBqyQZYcTnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0rcMVWwbJRUDv3Um5Xnvj3WqCjt+Mr9kgb1/f+nNfZTjEeKRbKoj4GIoGWTlf8H5
         JuAAp+iIaQ0kmMaWbvhMVI5c1hcAH7u0HJXQl9iU/8rSA69avpEnUEThrJZ1jRQAlq
         reJMs03Xg0tBpZMYRB/66Ds2w88vFKinR1Lvp75moTFXIIc90XNwQpGU8FIjV04Fw8
         p2HjbbVaqQJ8rr5P9C/M6otjPhuHbUStXJjwonISLMamsAZMY4bhevw6Pczvzrj1Vh
         SZfVgi+t0nCIpiI4gGdyrm8W5hvgggGndQFAC+y2MEqoGPUKAshp8q9gXd7SOExFLn
         HV8weKmzxe3SA==
Date:   Tue, 23 May 2023 19:25:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: dwc: move DMA init to snd_soc_dai_driver
 probe()
Message-ID: <bff15efe-2234-40dd-ba48-622148f8f869@sirena.org.uk>
References: <20230512110343.66664-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/wIEsaftd97g4Bi6"
Content-Disposition: inline
In-Reply-To: <20230512110343.66664-1-fido_max@inbox.ru>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/wIEsaftd97g4Bi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 12, 2023 at 02:03:42PM +0300, Maxim Kochetkov wrote:
> When using DMA mode we are facing with Oops:
> [  396.458157] Unable to handle kernel access to user memory without uaccess routines at virtual address 000000000000000c
> [  396.469374] Oops [#1]

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--/wIEsaftd97g4Bi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRtBS4ACgkQJNaLcl1U
h9BV2Af/YCikO3HWyyALlDKIAdamItXVN5sLIyRESGSHgnY0mJDLx1esF6J8kwqt
cgTLZ8amlgBl5WZ9u2LDNU+b5ppISah4xbhyS8IoOYAFIJVEngfxM/VHDNQGAyL7
2dYWg5D45U1Lb55YAUeEWfmLrXX0nI7piQZv1aeZAdvy81ZBaBk0bF/IgPNWr0uz
sKa+6a3+mRPNjU5JDMlAndudNiA8J72a7yXFO3aiLvJoWhU6EIRderm5Em/R8cmi
ChAqNaMW4B3w994TlP5nzcwvrwGxDdW7bs26xpIVCzC1yAT4yrGIrrSx/dN8+KCX
Lx37403VVBojsk4HIhCgyaKDMM9YzQ==
=mo+1
-----END PGP SIGNATURE-----

--/wIEsaftd97g4Bi6--
