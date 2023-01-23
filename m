Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB7677AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjAWMTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAWMTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:19:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FDFBBB6;
        Mon, 23 Jan 2023 04:19:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D528860E9F;
        Mon, 23 Jan 2023 12:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AFFC433EF;
        Mon, 23 Jan 2023 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674476376;
        bh=/UE80dW4QUmwYJGNIovZ1MTwLypUd44/RC0OvJ6z9RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyu+kWu22XiPKryfvYio/3t84OOQmj1eZ9e2qvynSZxTFa5f3bI6+zhHV0BPjbyg9
         UIB4/LkcdjNdE7hwajwiGhxc4vE3Q7IjGpiASz0F7gRg3VUFHFDcNL7U4KHle+iAV7
         s/Ov1tloAY/kop0o0s02fj5CnkEuXS7YBdc/QhI9lCr/KlI4yCOtqBrMyJsIa5ojpg
         zTsp/Z1AQMnZ3YC1az9eKRVA3aBPAwOYYcIZsgxgYDEB7nxH+qezXE0vZAFno6b/jD
         ZEUZc0NI3dekjwuevSRV7ZUWm1N/Rku1K6nq5ROsNiLh6qDXTA40JCCa91limv9yxy
         zIoV1SnCrL4xA==
Date:   Mon, 23 Jan 2023 12:19:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Message-ID: <Y857VOG5upNJfpdM@sirena.org.uk>
References: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
 <20230120082054.610626-1-michael@walle.cc>
 <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F2NJRR7q1YrufWdq"
Content-Disposition: inline
In-Reply-To: <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F2NJRR7q1YrufWdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 23, 2023 at 10:37:58AM +0100, Alexandre Mergnat wrote:

> Yes I want to expose the SPI on the pin header for two reasons:
> - It's an Evaluation Kit board, I believe exposing SPI helps new
> customers to try/understand it.

That's not how this works.  Anyone connecting something to the
SPI header will need to update the DT to reflect whatever they
have connected, if that is something that should be controlled
with spidev then they should add the compatible for that thing
to the driver.  If that is something that has a regular driver
then the regular driver will be used.

--F2NJRR7q1YrufWdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPOe1AACgkQJNaLcl1U
h9CJ+gf9GkI4+fuHtKD9NFRFbMvHD73e01pZDSR9e8hgGqpBvCOFdvnbGM3XbfH/
JE9mfuuiW37qqJn55qD2ZsPTUFxGjiWOqe0prsHjRx3Ana5GHfibpVLv5/mPPUlT
ZRZr/vVWEJy3L0YabKPVe+18PSVlwtUhhsialkjCfRLzat/LWJL5pKwHb6YpCwlf
NPtZlw+K+dZnJkxobsjvXR51Q07F2idjTBCEqiEBe5BMDMCesW3Gcd5Bl0T1rLXL
wmrb+tpS6qqelUP3+yOPgy69z0jVfVTJ/AOYDqhNT86dyYkNAnjcj8tYN3dHuN5a
v4cMmOkxJ01vdv/bbVqa/28BioVk/Q==
=dFfU
-----END PGP SIGNATURE-----

--F2NJRR7q1YrufWdq--
