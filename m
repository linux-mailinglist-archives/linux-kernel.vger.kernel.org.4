Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976216D7AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbjDELHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjDELHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5972691;
        Wed,  5 Apr 2023 04:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE3863B9C;
        Wed,  5 Apr 2023 11:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F168C433EF;
        Wed,  5 Apr 2023 11:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680692819;
        bh=tZlbR34ZjyPbv/3dJsICI4RK7eIDXLNRd//OxCOHqcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fH1p2nKpKNzDL5smdpznE/O/SOpk5MwUs70bjZci1OCnJHYnAyFVYZk/mjUYoAbqH
         iQS2UycQvcgi7aQrhsMtvAHe2v+QRLNCbYBvR7RzHivDsq+spQirDn8dl/lQDHlFgb
         fbyl5viS097dEhdITvTrc+E94z15LVppv9XuwSGubzbHTNGhxfXHlmOS793X+RiYnE
         v4Y3jRb8FmO1by+fwqGY3NwiodI/j1M7yLYfc/hg5ZrYOp+yN3auTT5dMnagCRUuOt
         VQTQ7yU6SaosuEl5zo+f3OdRbU8RVsGVS4uP0z4iDESGL3e4UfhVGUNs51MBdFseM9
         9+CpUR4OkBofw==
Date:   Wed, 5 Apr 2023 12:06:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: a couple of breaks
Message-ID: <31ea09c7-7187-4d44-a25a-cd5378cefd69@sirena.org.uk>
References: <20230405165707.189c1a99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a4XUj/Jd7bWnpAZm"
Content-Disposition: inline
In-Reply-To: <20230405165707.189c1a99@canb.auug.org.au>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a4XUj/Jd7bWnpAZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 04:57:07PM +1000, Stephen Rothwell wrote:

> There will be no linux-next releases over the coming Easter long
> weekend i.e. no release on Friday or Monday.

> After that, I will be on vacation from April 13 to May 7 inclusive.  So
> Wednesday April 12 will be the last release I do until May 8.
> Unfortunately, that means I will miss the whole next merge window.

I'll try to provide coverage for for the part of this that's in April,
I won't be able to cover the first week of May unfortunately.

I'll not cover the coming weekend.

--a4XUj/Jd7bWnpAZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtVk4ACgkQJNaLcl1U
h9C+iwf/RJKYZSH5RTMoL7LATXl+2Yg/TaBcXJnVWjhOduyNaj18TIGmwKlthOYD
2Z2i7GkBvE511jvIM/YwLvwPrggLdqHIgoGkofSDcszTxCUeMrxcMrnSyq5vHFOQ
vxXuNP0C6/AIYw3PEu5zEGWmCLFQRS6nO297qY1S0OTakAbHTPTeb3A8O0YC3vnk
PztooPDB5rMgXi5AfKuc8bThUWZZQ+B88YyHvKbJf4VHInDXDSM2wPrF9DSFsaNM
bhjvl2h6/5PRw9br76FdbSq0LpFCa9OihATOtMcQI1fzexPsNoz3POGnIiFq7qfd
Y++0wvz5t141+0Rt92kyaZlMixmb5A==
=B4OL
-----END PGP SIGNATURE-----

--a4XUj/Jd7bWnpAZm--
