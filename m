Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF536D79D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbjDEKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525C3C0E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 234A0625F5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C689FC433EF;
        Wed,  5 Apr 2023 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680691025;
        bh=LOuR9TtB86T+Q9WWjShnNVuimPOb5yR1lT9uwWKEgWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svFX32sTjK0xr6iQy6gCHp8S6a6xL55COcW5tySWwoURqAMkjYehwbaPYjZTkcA+I
         iWRK5tohCB67qhAj2DgLLpMJ2gRW1DH16LpTyDT1Ic1etDHLrjhXXhVqapTousW08m
         lWiJl3RJelg//Sy0uyAPpIL6g/hEoN6Fdgij/8byOHIfbM1r2BJP6XeJgExpiB3VWP
         VapAJwvgUglL1IVQkwuHtR5X/iFdVN98j9fMxwFtZc0xUK550bBWfztvR4t/7MoCaQ
         SiNFRpFXg3A3rMVoLVYErh+rbv/GNEF5AdpM8fSLgnJX7IkfFM1qag1sQ7yKx2V48C
         xFnxlhKTjxouQ==
Date:   Wed, 5 Apr 2023 11:36:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cujomalainey@chromium.org, tiwai@suse.com, perex@perex.cz,
        kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF: pm: Tear down pipelines only if DSP was active
Message-ID: <895e14af-9de9-416f-8776-14598c351136@sirena.org.uk>
References: <20230405092655.19587-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C32NnwYngeq9oPHf"
Content-Disposition: inline
In-Reply-To: <20230405092655.19587-1-daniel.baluta@oss.nxp.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C32NnwYngeq9oPHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 12:26:55PM +0300, Daniel Baluta wrote:

> With PCI if the device was suspended it is brought back to full
> power and then suspended again.

> This doesn't happen when device is described via DT.

That's not a property of DT, it's a property of whatever integration is
being described by DT.

--C32NnwYngeq9oPHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtT0oACgkQJNaLcl1U
h9DIhgf/fx9LD2s9a00ng1ln3S1ybatL2hkNilg5ZkmbzAbWkjPVsKSLcD6B4n9R
JKEJTLxC9mLzy+vKzTRzKg5/pB2AozTCndd8KfhNZJRG3GijD7RxCZu/QexmE15U
QGlV8NWMz6gHWL51ZzpI+rDRX9++3hb+CbD2DlUV45bOQRUqcgGSQI2idaVQ12Cc
aLpnGZ0dGtIF0aXJXiqOdM1qfe4E3pOWVlyUUYUWJbVc99/gVFgBJ/VlyteTJlRs
kJEzliwFh2OPKxbgYt72TDkl997dY0kVcwaRpSpSbzfcNxCzXxLwJLoQ+tvfhbyo
rQpNKag6jdtBxTpbouUH7ALja+8/UA==
=NTeu
-----END PGP SIGNATURE-----

--C32NnwYngeq9oPHf--
