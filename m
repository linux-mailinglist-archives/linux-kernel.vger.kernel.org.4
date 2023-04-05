Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B56D8485
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDERHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDERHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898ACE9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EAB662A9A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B829C433D2;
        Wed,  5 Apr 2023 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680714426;
        bh=9BXhb3Nj4kbsbN9M7Hz+URDo5so/VRfyJroXLt9UzsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBJnDGwCYW3xO9ZXYYONK2M6uotlQauSjkY2twPGsdgjyVjfjdCqtyvphWcMhYyPi
         9lWq9Tcx6Qyh6z79Xi9MZg9ENn9SWa32dZb605UKsyJR9+zOKCPXfSBKEO8OB7qwso
         qjPpxly3wcq+XZ8sGhkyNUdhS8E8TeGGiXZGBz4VSSSzr5Ve11osF3WOHgjjMdetEu
         2wfhcOUQPfjVo2RDdflf6k0RCV6ftrLEuOYhKaIhQCf2PsU5vzr6GGV5TPB+Y4v2sQ
         XEvDBzpsdvDmGwkfqX8+mHq23iC8vqrLLqJe+L0Vj2M54Iut8IHJKt9V77Bmw0NbLv
         LZoINms9fFKFA==
Date:   Wed, 5 Apr 2023 18:07:00 +0100
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
Message-ID: <185fbb80-7fa3-4c88-9f96-92894370a3aa@sirena.org.uk>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
 <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
 <20230405153651.GS8371@google.com>
 <e86dd4a9-540a-461f-a78a-5acb480e98b9@sirena.org.uk>
 <20230405163906.GT8371@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ffiu+KLSaUpGaMI"
Content-Disposition: inline
In-Reply-To: <20230405163906.GT8371@google.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9ffiu+KLSaUpGaMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 05:39:06PM +0100, Lee Jones wrote:
> On Wed, 05 Apr 2023, Mark Brown wrote:

> > Whatever it is you need to do to be happy with and apply the shared bit
> > of the series.  We're somehow on v10 here for what seems like it should
> > be a very simple change, I've not followed the ins and outs of how that
> > happened.

> From an MFD perspective, reviews happened followed by an approval in v9.

> I can't do anything without an Ack from you or some indication that you
> want me to apply the first 2 patches and share an IB.

Yes, please apply and share a branch like you usually do.

--9ffiu+KLSaUpGaMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtqrQACgkQJNaLcl1U
h9CFMwf/ZEXZnXzyQYsWnglJ8ZOmvX/KrARIdAWEWLWB1a2YfKeWcDKxVW/J8NAf
4NWo8PHVP7Nfma1sHCaLIp2JSF62xA/ZxjemyOamcEg3dwOOfO1DxYs3ZE2T1T8t
57Jl8Nu2f+hlqLR0xbeYuMruLLgROYHCfAa6cIN8CTVCEhTEB6ksDq7PP5Bt+Bqn
6Td8vFIB404zt5XORr4Y0/2b1ZGp6fydkNqI+kwi904fz8RZb7P3Mgc/h1+wy/rq
7Vd3SMUS0vyWLMnRiOubw9plr4D70P4RsBQLabEH/AbxHo5haqCDdacRwmt0vUYS
bWqgBPj3TVQij8Ng35ZSGD/TtJ0O1Q==
=nzqD
-----END PGP SIGNATURE-----

--9ffiu+KLSaUpGaMI--
