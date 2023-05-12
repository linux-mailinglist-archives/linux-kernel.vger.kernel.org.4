Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BDD6FFE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjELBNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B3558B;
        Thu, 11 May 2023 18:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA4060FFC;
        Fri, 12 May 2023 01:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B360C433EF;
        Fri, 12 May 2023 01:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683854012;
        bh=aQ7zPlNmVsfJ6XDXRfCpc6HWSuhQVY5D6ruU1fXY+m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5cyWSTH9QNw/zLTM5vff8gz3woUNgcnfJzStrkHALoO+nMBw+8CAGnzFqv5FIfkz
         cs9xr9vZqTkqFRL5rHglMycRofQlzEzAn/tFgy9IXRGVFLmWBz3tH+a+MEces3Th8c
         qpOI0Hmoz7qIx6lreiDtkmK0hdCTdI69ARzA0s4OAsliNnWTq4bK0XBPWAzHv4RvUN
         lDcefFgvhNlujnhQHFw0wEkoQ500OL0k6CsvLNXCSDyXAi54UaA67UE+QqlOfw5x1U
         XNxAooEDHUXcrKiwexTn9NHKaHyCEK5GU6EA+f7Gw8dkmPgEuCui9CVAYAvgUFZ5Ww
         qYpadf5jHwJ0A==
Date:   Fri, 12 May 2023 10:13:29 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v10 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
Message-ID: <ZF2SuZaXTLwEs2F9@finisterre.sirena.org.uk>
References: <20230509082244.1069623-1-joychakr@google.com>
 <20230509082244.1069623-2-joychakr@google.com>
 <ZFxFCweHVgHyA1E1@finisterre.sirena.org.uk>
 <CAOSNQF1GtxY7ud-kobHW=HHvYcq3ySp+YTvvHnPAkxmP5Nv85A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8cwnejA8p/IFRQgf"
Content-Disposition: inline
In-Reply-To: <CAOSNQF1GtxY7ud-kobHW=HHvYcq3ySp+YTvvHnPAkxmP5Nv85A@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8cwnejA8p/IFRQgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 03:02:00PM +0530, Joy Chakraborty wrote:

> This patch seems to be applied already as per the reply to the cover lett=
er:
>=20
> [1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
>       commit: 5147d5bfddc807e990a762aed0e56724afeda663
> [2/5] spi: dw: Move dw_spi_can_dma()
>       commit: d2ae5d42464e990b4d26734c180fbff64233992c
> [3/5] spi: dw: Add DMA directional capability check
>       (no commit info)
> [4/5] spi: dw: Add DMA address widths capability check
>       (no commit info)
> [5/5] spi: dw: Round of n_bytes to power of 2
>       (no commit info)

> Whereas [3/5] to [5/5] has not been applied.

> Do I need to rebase and send the whole series again or resend the last
> 3 patches based on
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git ?

You need to resend the last three patches, I probably just picked the
wrong one to reply to.

--8cwnejA8p/IFRQgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRdkrgACgkQJNaLcl1U
h9DUBQf/QEFlAahN5OJMfbizzAedSf0bfPLWWbdzutNRwQjPNvivw6gyTJFzQCpP
zGG4fWIas4lOvlbjB4FNLaFM6dZUEIf7Lz3mvKPPUlZZoNAFsiI8Y2mMHQmvBKte
96PJ++fZT8xX7d5zUT9UYP2NyK0l//0T+qTQ+4WsuGvPRAEsL76OwtVaH5Im4zMl
SNpRkUATdksHM5yGwGCC0ewE2EUtkdn1BtLZMEqOYOGD9adFmRLjVWQ2z09L2ncx
0Kb0b8SVThroOtCUg9PGabzL07ITLNCXHI1cfsSJUOMI4vgWipQ/DiDHSIv82CD9
CYqbC2NviCXqCJa7a/cqq7Kf76h9Ww==
=CC9Z
-----END PGP SIGNATURE-----

--8cwnejA8p/IFRQgf--
