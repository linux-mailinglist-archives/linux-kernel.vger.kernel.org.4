Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A445B779A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiIMRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiIMRQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:16:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D213D5C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DFFEB80F92
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D1DC433C1;
        Tue, 13 Sep 2022 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663085071;
        bh=6Tb1sUxJd8dJSLR0kzh76bNzgOnCELvZEdTlXBGdo74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PheyAgfTkCSP3WusJLXvYkxhsvdu5x7NwAb77YJp6uTLsFzMXhfPj5sL/UkcNBYlJ
         igl+prwhPZ8shp+dhWpY5Unxz2BzCpBSiZsxZQSe6dwXpPGFxf6PKcR5pl9jIhZbDY
         Kw1LFol0B4iu2dKWbOCou+G7BrbXvAUKD3Y6w8WCN+LuN2L3gxutkJDjpR2FNoLAYR
         KIwb7oDhgeHYnXcjcvnUSlh9Vm7lc5jfmcLJgx5yYMrzmp0YH6Qb3VbP0OzI1fR2VD
         WGhQa57ASkwWj8RlzeKHeRHiRazD2+A087uFkiGjqqiKAhhP7ILqfHXpWSuWdpnC9S
         gfilQsh4igr4g==
Date:   Tue, 13 Sep 2022 17:04:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: sunxi: sun4i-codec: set debugfs_prefix for CPU
 DAI component
Message-ID: <YyCqC2EypxnoJFk7@sirena.org.uk>
References: <20220911145713.55199-1-mike.rudenko@gmail.com>
 <20220911145713.55199-2-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnCcChlqU0Imzw0K"
Content-Disposition: inline
In-Reply-To: <20220911145713.55199-2-mike.rudenko@gmail.com>
X-Cookie: ... I have read the INSTRUCTIONS ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tnCcChlqU0Imzw0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 11, 2022 at 05:57:12PM +0300, Mikhail Rudenko wrote:
> At present, succesfull probing of H3 Codec results in an error
>=20
>     debugfs: Directory '1c22c00.codec' with parent 'H3 Audio Codec' alrea=
dy present!
>=20
> This is caused by a directory name conflict between codec
> components. Fix it by setting debugfs_prefix for the CPU DAI
> component.

This doesn't apply against current code, please check and resend.

--tnCcChlqU0Imzw0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMgqgoACgkQJNaLcl1U
h9BpWAf+JC1VIGpEuZdvAM6o78KE4CJpeeq0Ui9NrveL6c7kukJdKu+CocTWndfh
i3O+dtlkWNqZgOk7sOs4LRx651un/NqsygQkWr25B4CjGXoxJCf6YpaMXE7TGVuf
gJ6HYi2zSWoK7Yni6uScEU7D2HtnCQnwfI33jWM2GK6pwGZOTby86HtC/p1wnT+q
QFUTx54l0bYUkVfq+FLuPyQRmbMGQ4A8XFsQ9TQOlXC69sWna9yc5APBNXOcPR/6
lEUm8A0MZJJ8jZbUqOaG/PBZitXZ0r3vVNnLauiJaIOBHjwj6BW2Ut8oRZMoRDvG
x+5GTQ058lJw4SZvzZl5908v44s69A==
=2cfA
-----END PGP SIGNATURE-----

--tnCcChlqU0Imzw0K--
