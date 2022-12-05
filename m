Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8D64350A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiLET4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiLET41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:56:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B762275CD;
        Mon,  5 Dec 2022 11:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D29EAB81213;
        Mon,  5 Dec 2022 19:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542AAC433C1;
        Mon,  5 Dec 2022 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670270124;
        bh=+ainhBc4WZiDxaPpi3RP92cpTKnJji6lZlAG+T5op+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhL9HiUgjbDSnTfiBZskCOYjyAnry99mvMmrYmKzILTLvpAps0zcTGKHuORgApFkA
         yIWt/rUb7u+BbeanCaJNENR4uyxrtw45hUALsR+SiQM3ZOUXpC/uJle9XuntTGVkjD
         ngKdVVM63q0uIF+Unl2FF3DTz3qAj1OejasAd3tr45dRrSG63T2VNCSgiH6MTxhcDo
         S59Vnla1lVZDVdVHZNOwXNj2u/xm3JKTKhWAJqzumJYR+l0dPWxSRCo3ywEECOX61f
         w+IC0B79IzEm9t0IKm3YZNEYt9gvrtC/8Y/S0r9eCzY9iZk07zLHYwQoBSoAmdWF3X
         lRuc40ztvdkFQ==
Date:   Mon, 5 Dec 2022 19:55:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: linux-next: manual merge of the rpmsg tree with the spi tree
Message-ID: <Y45MpxPpWBSkBsyp@sirena.org.uk>
References: <20221128134120.0afdceb3@canb.auug.org.au>
 <CANLsYkw0Nq38rZzGTTpCL4J3aWJQpX32iOe4zdTT0+CcfhcOmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BIwV8ycDeum5mE+E"
Content-Disposition: inline
In-Reply-To: <CANLsYkw0Nq38rZzGTTpCL4J3aWJQpX32iOe4zdTT0+CcfhcOmg@mail.gmail.com>
X-Cookie: If it ain't broke, don't fix it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BIwV8ycDeum5mE+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 05, 2022 at 10:24:48AM -0700, Mathieu Poirier wrote:
> On Sun, 27 Nov 2022 at 19:41, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> >   1e400cb9cff2 ("firmware: xilinx: Add qspi firmware interface")

> Mark - since this is in the SPI tree, can you send me a pull request
> for this commit?  I will do the refactoring on my side.

That would basically be the entire SPI tree up to that point since it's
all mostly on one branch...

--BIwV8ycDeum5mE+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOOTKYACgkQJNaLcl1U
h9Du2Af/Y5fvGB+yA+kx6PbklAGg4NuRtssMo7eLDUmkS5EWTZGElGK9NcxuPFMG
oEkl4YuzVXbzsSxtpP04cAi3q4qXkAFNiJmVUSsG9WqtT7WyzCzfMjmZD4iUVMkq
t2ND4vLRSJgT7K1P8XdJTv0zUZeYluPOIfIQ0wE5JEmBBMsI0LcC91Um19tvpF6X
3Kgr0szW8gycEvVVwTMwnMOpqNq2I2F/TgjbMrrW0ZdjE7cMZ/cpDnxwbFki654s
HWUtS/xy7b1LX5gSxPqTHrSgJuiE4hRmZrow1g8DcIaGubkpgMfh8+kfKFzS1pG/
ikXjVU1uuYOVP7k9FqCGKJo2hiPnaw==
=pb6W
-----END PGP SIGNATURE-----

--BIwV8ycDeum5mE+E--
