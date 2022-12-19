Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0055651195
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLSSPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiLSSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:15:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E513D64;
        Mon, 19 Dec 2022 10:15:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2783CB80E28;
        Mon, 19 Dec 2022 18:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA13FC433D2;
        Mon, 19 Dec 2022 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671473699;
        bh=TsG+T1Egkcx7gNOFhm9GYhlDIE0AcHBvOcUGK0fBm+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg18VMXtGyTQ0Kvf30VHD+od6GvZL7Bn4JJn3M68W1Rp3O2nfP+0LtCrzxKS6s3jW
         cfUVNdcqXHau5UY2LucKUKbPmHv8MZD9mm0Fk4jt51tp3v70xMsdgGmzu8703z1UMC
         kXbShpGH2IkGvCbwGDsze2VKh+EUSeiaxJBpRM7DoviZpcsmdGqnd4SwIxmCJ+tKme
         Xjme5ZDsApHGzmGKS+5XKrBigXjduES7CHJ2z5TJrR98rDu8v271614fnSXwFyENHF
         PNPZyR1t8xt24mCJWkObdboJFqqyPGx40X+3pSD9psjiOF8JSuRVE97Kfo4PnRTUb7
         XTYSxozpdaqiw==
Date:   Mon, 19 Dec 2022 18:14:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Witold Sadowski <wsadowski@marvell.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
Subject: Re: [PATCH 4/7] spi: cadence: Change dt-bindings documentation for
 Cadence XSPI controller
Message-ID: <Y6CqHoUEsNyFGLqA@sirena.org.uk>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-5-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WXT6nA19UxLAo44p"
Content-Disposition: inline
In-Reply-To: <20221219144254.20883-5-wsadowski@marvell.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WXT6nA19UxLAo44p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2022 at 06:42:51AM -0800, Witold Sadowski wrote:

> Add parameter cdns,read-size.
> Parameter is controlling SDMA read size length.

Why is this something we would want to configure statically in DT?

--WXT6nA19UxLAo44p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgqh0ACgkQJNaLcl1U
h9Bgpgf+Nd66EDcVHEBigqaNJZs7RtRB/Eq6sHkD5PqoUlR8zktQfYnBjk+xInI8
yfGwSgsKK+9V/McOobp13uXu3h0rYfUGFvZn2bAkitp/FjfYqTIRjTnLamVmjHf6
2w5OWPpalALS6HbLak4Gef8HoT2vjAW6dLaBMN7GYDlKpYBdIza2HCKTSL8NIziQ
STX1E5Sil5fAr8uSzRckC4IIEcoj2G2WBtGV6+I8445dy3/vdtmCaTkT9S+GxnCV
jsSak/JCt+G1Gcota6fr7KBOBR7uoNfTiXXYIGnhg63nRnFxYZrLA8u19F7z6Ao1
lEnIxXBfe8foqrSl+Ba+qsgCquMIiw==
=awMf
-----END PGP SIGNATURE-----

--WXT6nA19UxLAo44p--
