Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145D645B30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLGNoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLGNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:44:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460D242F56;
        Wed,  7 Dec 2022 05:44:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAAB0616F6;
        Wed,  7 Dec 2022 13:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3391C433D6;
        Wed,  7 Dec 2022 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670420661;
        bh=VFZvFoWtRtHDwGt2tI+fGMM46K2cotQeVJ2L5ZZaBPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2L79QUvq4uN2qx3Q4uSBjGr0Q/nhjo51yIDbF6HjGaYfGszqaYo7YRJ0kQVFl5cS
         xEZv6MDSl+Vic7G51DqR6GOXwVHkkBntKrorhQXEKDgcU6cRygXHwFUF+4Nh5Oplrx
         xb2VW5NVWqx6fIF17PXh3f/DFqNWRTe+x4jmO/vPGjs1s4JPCPaIfMNW2g8+Aotsmf
         ZfcKxJBsN5euprGFl3h8uGOeuo1gpPy89NsPsAjY9rCTwX+okEtq6tkiSCeUIdzjhA
         cOApRlgFifTdi43DUWiETpqMLr/VmJYhnuttWyl9xCyQx4ZzC98gwptD15HP19hnvw
         F9OotwLpf17zg==
Date:   Wed, 7 Dec 2022 13:44:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Han Xu <han.xu@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/2] spi: spi-fsl-lpspi: support multiple cs for lpspi
Message-ID: <Y5CYsDFdAEduswvm@sirena.org.uk>
References: <20221206225410.604482-1-han.xu@nxp.com>
 <4ed39c8f-3736-30d6-8d8c-92a4882b72e7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FHJ0wrEYDAahKs6C"
Content-Disposition: inline
In-Reply-To: <4ed39c8f-3736-30d6-8d8c-92a4882b72e7@ti.com>
X-Cookie: What!?  Me worry?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FHJ0wrEYDAahKs6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 07, 2022 at 12:08:43PM +0530, Dhruva Gole wrote:
> On 07/12/22 04:24, Han Xu wrote:
> > support to get chip select number from DT file.

> > +		fsl_lpspi->num_cs = 1;
> I am not sure I understand why you are setting this to 1 here?
> I am assuming it is because you want num_cs to default to 1 if
> it is not specified in DT.

> Please can you also add a dev_err and be sure to warn about this?

The binding says that this property is optional with a default of 1 so
it should be totally fine for a system to not specify anything.

--FHJ0wrEYDAahKs6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOQmK8ACgkQJNaLcl1U
h9DQmQf/dQmK1zhfWMV21+4MZi7jWAQPkVACX1YRD9SdP5J7ibe5UCdIXWgVK7Bd
lwYspDicnRBZIDaXfvADRgPQLSup2v+exb+xKbRGjuCC/O7ksuy4o+5l8XDfGpU3
S1AdnIyj30a5glmYiFHqLSxE1bLAlcA4dT6sZ00aWv7lsiPH8HyRhtPWH4W2TgMv
Ud76wPUbLFwz9tAF9tUUgRqlOPIRK+O51e4g1g6ErgruBvm0HrFgyUpYEqXS/Lwj
McNBNljYHdAejLfh9BPnC0xvfg1WRYR+2+PfP9IRso8PMud4eAwMn/1ir0KVtcyJ
czYfh9SX61D2s1KQ7alWZYQPfSxa4A==
=pwb/
-----END PGP SIGNATURE-----

--FHJ0wrEYDAahKs6C--
