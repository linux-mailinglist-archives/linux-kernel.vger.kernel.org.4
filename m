Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F66607688
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJULyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJULyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719D24C95E;
        Fri, 21 Oct 2022 04:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E78F661E3D;
        Fri, 21 Oct 2022 11:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B40DC433D7;
        Fri, 21 Oct 2022 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666353238;
        bh=KJhnl0M5yBG2dD3JOiVvCDClcYtjP++x/Ni7GrtQW2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t81YNIzDw5GjXfpGl7y1vzZy959OrQi2J3gywq6fAWQf9WgVWvLTqdAXKv6Zb3C5+
         yAze1TdE41wibkVTyT5B1IRhzTqXBFIDQ19OwRhH87adZZxQ5Ka5Pao3i0LPxLOeJq
         xaLFPEYzrIMzMJSvOAkEVVmWNVskQGZ8D2ghozaqODi32+f5Ymbv+jxOIn0glBSioy
         5Iay+9eK3JgR6eFRmZvYY0YipKkzclFJLSqqw6ttAN+sK/cWrlHEvuTFJUdwbVIqD0
         EvGLCY02aglGYrBmh0PK5Fklx+Qtreru6BRy/3lafQuDc0Ot7AhHQyKdLcEL5wK5he
         OeTM7tMiobvpA==
Date:   Fri, 21 Oct 2022 12:53:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Message-ID: <Y1KIT4nk7C8SQ45x@sirena.org.uk>
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120@epcas5p2.samsung.com>
 <20221014102151.108539-3-p.rajanbabu@samsung.com>
 <Y0lPz91gbovAub9D@sirena.org.uk>
 <04a101d8e523$30804b80$9180e280$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0NRq6XULMyp1OM7X"
Content-Disposition: inline
In-Reply-To: <04a101d8e523$30804b80$9180e280$@samsung.com>
X-Cookie: PURGE COMPLETE.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0NRq6XULMyp1OM7X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2022 at 01:30:25PM +0530, Padmanabhan Rajanbabu wrote:

> We can overcome this scenario to an extent if we can get a flexibility to
> Configure both PSR as well as RFS.

Why does it make sense for the machine driver to worry about this rather
than having the I2S controller driver configure the clock tree?

--0NRq6XULMyp1OM7X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNSiE4ACgkQJNaLcl1U
h9AGOgf+IEqa8qDBK4xEe3hcK5GsxodK66zuf2kT88FfCFha0D2TVSs+NPkpUn7L
pZwG9CQwoe46jn3+jqPpW4zRh+R16km+qTITXYDB47Q1nhWLfniJDVVTdPe1QH+/
8kdEv3iM6CHGUDqbQli1zATLN2a31b0BMEqRIgMacO9cjxTUYGZAjFxnh3CB9LAp
Chcs+uexRoy6Rm7hhJswsqSM7fvq5HkJDgaTD8hoyd/03jvUpkapl3TWF/mbDgKG
Tu8SyfBzJU1bmmc5NXKX+FSuywemGUsfYTLt+8A693mt/ogxKQROj1SIOi3Mbzgl
hJd7F0TXV8+UxhsaY8JDMmTv6W6MEQ==
=kBk6
-----END PGP SIGNATURE-----

--0NRq6XULMyp1OM7X--
