Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7E1720096
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjFBLpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFBLpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928D194;
        Fri,  2 Jun 2023 04:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746D460921;
        Fri,  2 Jun 2023 11:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793CC433EF;
        Fri,  2 Jun 2023 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685706300;
        bh=ar8irlPxQ03WqRUZe/aeTAqrjnl1t+FeNYGJb4UItCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwS6zF6m2mj48pWPiiuWC3HXF/81djLjU2P2+80DIepL+C7in4y2EnwdlrGMeTJzb
         YNcxOCNdAljelhDsv/cuMH8Gxl+QPpcCVGQiqn8jukLdvK1VV8KqnpxEkVDtgd0JW9
         +8k0xKXv/EBd+Ym51avSa1I7UKq7BIXAaR2ZpH4yTPk9SXzvzcsrA6uqUeWYrp69gq
         GkV2utr1uD+aDeWCgcp1r8xqI6urNQh9mgYlyEeMaoAl6O71FUQ66GBBr1oCY1m7Q5
         7L9q38dPX2i/3R7BRu293HzjKZ/Xy3I56Xz5VQYWPg/EGLQ7RUz5hF2wcXm+1tcvbF
         tWx5HKFutStmg==
Date:   Fri, 2 Jun 2023 12:44:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] spi: spl022: Probe defer is no error
Message-ID: <b1c53730-6675-4c91-b891-cdbe57576759@sirena.org.uk>
References: <20230602-pl022-defer-fix-v1-1-b80bfca3e1b4@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UUdbCFR0TYiZly+"
Content-Disposition: inline
In-Reply-To: <20230602-pl022-defer-fix-v1-1-b80bfca3e1b4@axis.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UUdbCFR0TYiZly+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 01:11:51PM +0200, M=E5rten Lindahl wrote:

>  	if (status !=3D 0) {
> -		dev_err(&adev->dev,
> -			"probe - problem registering spi master\n");
> +		if (status !=3D -EPROBE_DEFER)
> +			dev_err(&adev->dev,
> +				"probe - problem registering spi master\n");

dev_err_probe().

--1UUdbCFR0TYiZly+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR51jcACgkQJNaLcl1U
h9BE6gf/VHIu+QukYghZvEPG5FRLJdZkVDycGIVFhdCzOI38jChe9Dudz8uj16A3
Uu+YNmG1Pf9wuqYn78SLvFSiqWscf4gkAuv7HpT00QQPhlTvMeuo56ghSFxvCODE
wzrtdhoNpqeXeKZ9s9hmyi3YGbhVC6SlZPk+K1UGB2oZ85FWr0vFROQmDmSrxnUS
UHEtKEtl3yEbK47EswYhNdZMeP3k7j+/aI+wbu28/mlGlpeBbOwiQmxSvEInCe2O
F7QAdlRtOBTwPE8f1um0etzF50KvzRhm90zCfcN0DYw7yt/paM2IQwZTmcR3WeZ2
ZG5I/E2PMOsUQqHJWUkpw18yVddcfg==
=es7q
-----END PGP SIGNATURE-----

--1UUdbCFR0TYiZly+--
