Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F071604F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjE3Mqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjE3Mqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCB11D;
        Tue, 30 May 2023 05:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C8A662F79;
        Tue, 30 May 2023 12:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C61FC433D2;
        Tue, 30 May 2023 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685450767;
        bh=vNEC0h5FUqMCUl8Ov+aQpRdzOhPj63Rtc7WaZ0NKm/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/AfZz6PiiuvkG98oBEVdqbWv+jPRrbM1ZmFpfnEKUo2ACJuZp+r0809x9A/iZVTM
         vcG7i55EGIFL2ZcBogsxmc6ZkiWt5fmvSaF4g5/qVOh3NBgm3fwWIsatDt14wClTxA
         tmmQKyMZT7NFA3z1CqtpXLS9Ov3vZ1ViU6g0v6ftmyo5splrGdZbFm/agEFbZkOYri
         KfdHmKwuLgTuhorDgkTW2j3Veljc3ww6jkX8tW3IE7tRX5NFnHxgN9itzaKzrEhZBf
         64R0+loHjh1/PMXAQJ/6XiPc2K0CswkEq42YqRtoFfZtZ9RYvCNFmtE8YfhC6kkub7
         C0U5AOmVBL3bw==
Date:   Tue, 30 May 2023 13:46:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        festevam@gmail.com, amit.kumar-mahapatra@amd.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW
 mode bit
Message-ID: <49a6ca72-4958-421d-b83c-a9cd1f68596f@sirena.org.uk>
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
 <20230524091948.41779-3-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uFjodanmzd8SBZaz"
Content-Disposition: inline
In-Reply-To: <20230524091948.41779-3-boerge.struempfel@gmail.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uFjodanmzd8SBZaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 11:19:45AM +0200, Boerge Struempfel wrote:
> By default, the spi-imx controller pulls the mosi line high, whenever it
> is idle. This behaviour can be inverted per CS by setting the
> corresponding DATA_CTL bit in the config register of the controller.

This doesn't apply against current code, please check and resend.

--uFjodanmzd8SBZaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR18AkACgkQJNaLcl1U
h9BmVgf9FAi8XyX8CEL/WcQHuPmFhvvwRg0L/XFVNSDRFnsUKGOmUIDypSXGx84k
blL+31TILeLCmrRAdGReFM4911mHCCuTWqo59t7c81yOi4a65am5MPP1Ts+uXZcY
gqoIbBBX7nzOLXlkxIjRBBna5ZmOaK853oW2lH7vWI1NxePbs/nChc5UpCc2JFF9
XujGuTYK8x/gs/141sb8jBZa39XK3qoQnXaSAjhZAXBfhCPu13f7500H4+slpGiM
bnwne6COVh48dv3Lxi/PYBE8xPiRRrN5cNW8Y5QYcKXfxX2ocra+wi0XW5M8LKil
Yo4S4RTd/8OAazre9aWIoUfzRjgNow==
=QLBf
-----END PGP SIGNATURE-----

--uFjodanmzd8SBZaz--
