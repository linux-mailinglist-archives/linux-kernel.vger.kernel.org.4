Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9E6D836C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjDEQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjDEQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10A40D3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B7B63F6C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E49CC433D2;
        Wed,  5 Apr 2023 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711355;
        bh=w0QOoZC6Z1FdtspycG1J5Gl9DW3sbrtz8bGzU0Vx3A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTX4+bOwCN7O5P+7WSnlZg4lWu7ihxfoHwodA5t87v0CNuiUo/aCrUf0ZTnbk0JL2
         m/el1ZL8MJ3F8mZXoK7FPW2UFZR0iZEQSo+9BLdCmnOWM2gOGmOM0YFrYpQn+JrtWg
         OgIon2tRxHTGMls+k4e8vmIlh8HVCmtkaaqcSMMlFHI95QV5gBrut7cSi9ZQ6ALbuS
         0I0t9eLoTMhL3YYteXJcw6GrIgRb2cJTsdjB57WaJ594VXq96pOOAHRV1AJpdw4Lr1
         T5dCzBZAcCqMbHyX0QpPkUN2HsRRkc+qNzb5pt4M+mkop0pxQ7GAUstU6J32NowB6j
         jh+spj617h41Q==
Date:   Wed, 5 Apr 2023 17:15:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <e86dd4a9-540a-461f-a78a-5acb480e98b9@sirena.org.uk>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
 <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
 <20230405153651.GS8371@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nprJI15YJuH1TX2C"
Content-Disposition: inline
In-Reply-To: <20230405153651.GS8371@google.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nprJI15YJuH1TX2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 04:36:51PM +0100, Lee Jones wrote:
> On Wed, 05 Apr 2023, Mark Brown wrote:

> > I'm waiting for the MFD.

> To do what?  #deadlock

Whatever it is you need to do to be happy with and apply the shared bit
of the series.  We're somehow on v10 here for what seems like it should
be a very simple change, I've not followed the ins and outs of how that
happened.

--nprJI15YJuH1TX2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtnrQACgkQJNaLcl1U
h9BZgQf+LnRk3Hq0trgC9NQD/uZERKo/0K3IQO8A8cO/vY10LGr+6uUEH/Fe8lw6
7k0r20zI/GSzcGNRcbBDLd3UE87pQAg0lZs1jptVIzgyND+wUe1qPaJEv/WSNlqI
Sny2lH2OhJDy1O+I3rbyXPOzCALs4Nnz2VjuCryvgQHAhBJy6wRiTlrugEGuNMYN
li3yAANYYRkaFon75/vTNk7N1WDC/lh0pLqTPhDhBRznlyjo/yyMIqA9NTlUn1Da
vvWJEowPsC1He8gyP1vKqOLfC22Sa4vhWnBfREM9YZFk4nTOuUc6qIOby/c/ujAN
KHpowtF8CIusmLNfSQktnpW0h7xo+Q==
=tvgq
-----END PGP SIGNATURE-----

--nprJI15YJuH1TX2C--
