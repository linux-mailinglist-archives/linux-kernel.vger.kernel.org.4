Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41F6ECB91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjDXLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDXLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA234496;
        Mon, 24 Apr 2023 04:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD5E86128D;
        Mon, 24 Apr 2023 11:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B5BC433EF;
        Mon, 24 Apr 2023 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682336904;
        bh=WsRZ+/RkbmfKSvIkK5oqZOi4qtrgkWx7OzyTwn3oSZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZG4kDlc8BLNykxIQeW7euzkxyO4LfrwGLlaiZwec70yrh1IEoPUvMS6HCrVwYdPkG
         e8q3tnj5Xl0sAbYxzl+fZJzrREoi2O9p/AK1561yWoTSUM8WDbizDlUpiepMUdHRXB
         l+Pouc6WfbCD6NxFIb8in+cqHUIAeXMW2PZpCqGK9Xj+zpQIm8i7ixDEPgSgPTBb3F
         oS9UYsaE1ZN8aBmip7tkT55AVBuJznkd4JP69Cgx9xwfCG+/uxq35hiO2+++6uRyd2
         MaMe160iADSA5LOw+fAiB0Qrf4kBpmhkekAUH3fwJ5DZyQZo+YfPpyutg2BEAwErw2
         HWffMEAEXQn9g==
Date:   Mon, 24 Apr 2023 12:48:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li Ningke <lnk_01@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
Message-ID: <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
References: <20230423032446.34347-1-lnk_01@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6j9QIhvVoXDS8bt"
Content-Disposition: inline
In-Reply-To: <20230423032446.34347-1-lnk_01@hust.edu.cn>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x6j9QIhvVoXDS8bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2023 at 03:24:46AM +0000, Li Ningke wrote:
> Smatch complains that
> drivers/spi/spi-davinci.c:915 davinci_spi_probe() warn:
> platform_get_irq() does not return zero
>=20
> There is no need to check whether the return value is zero as
> `platform_get_irq()` only returns non-zero IRQ number on success
> or negative error number on failure, removing them to solve this
> problem.

Is that check valid?  0 was a valid interrupt for some architectures...

--x6j9QIhvVoXDS8bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGbIIACgkQJNaLcl1U
h9Casgf+KIwtYlodKe8H8PSdPE/oTgeLmc+0elLcipRwbHokM+HJMWUu8NDqdte0
wppWJ/gdFfBVF0PXYHaIxqlHI0hXUiyRaZ2udzF0ZCwPSkiSMFtMmIsiFH1ZRqwh
ns0h9ebnmdP+Rz4P7OIyiJeYIzYEzFWk2syPSEGoWMAy1+DZ6mET/oScMYYbMYNz
SMAJlE397/Wb8sh/OQ9/m3ANc9HV1CnK0CYEI+m6fOj4k6dNmb8urjmPRV+J+zmR
2X7kCCXu75ZOPm8aYaq5bOllmay4kQDu4cdOnO/1u83CF2iFDeqCz393e4eBmW0j
xQmhFfE5cSr+1ZKVZJmmADHt+OBI4w==
=9lLB
-----END PGP SIGNATURE-----

--x6j9QIhvVoXDS8bt--
