Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4C717DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjEaLSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjEaLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248CE49;
        Wed, 31 May 2023 04:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC4A639D3;
        Wed, 31 May 2023 11:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62899C433D2;
        Wed, 31 May 2023 11:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685531888;
        bh=Ll1/Ug8UK9hxE2OKZEPPVr1xtMG9ijS+84aoC3Gnhto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS5tnMhg9dv/nEvtJavi2PI+hRGUJL9Jm8c6rWsTj+N64YAzyXvPqhli6NgFz5mpD
         HWp0Cf+CXto4sg+Vsfcu1MKS9DkNoW/I/CQ6mGKlJYogW4uBmwSZBmWmgq1UbF2D8X
         bY3xnM43ddParzMZBUCN5LjlskkrK8aFmp3vfBbMdyvUeE51VikfvwrSZivg032J5U
         KIzxbWJwvJhNJOAvk5ISf4a4IjZkhrVsCwaJzlfyya3VzUBLBtB1lMeSdikebo5nwN
         f5ST+F0aWPobLZ97Rx0a+AL+bupQWbNx+WdqDxUHefA8Ps230xp2cGFZtWo7PZABFk
         VixdoO05gRI3g==
Date:   Wed, 31 May 2023 12:18:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     ping.bai@nxp.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Message-ID: <d178be98-189c-44af-a55a-e0a46747fe61@sirena.org.uk>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-4-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oZr5QrGIUF584tX7"
Content-Disposition: inline
In-Reply-To: <20230531065724.3671795-4-joy.zou@nxp.com>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oZr5QrGIUF584tX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2023 at 02:57:24PM +0800, Joy Zou wrote:

> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <2237500>;

These look a lot like the maximum ranges the regulator supports which
probably isn't what's safe for the board.

--oZr5QrGIUF584tX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR3LOgACgkQJNaLcl1U
h9CB7Qf/aTpLdKql8y+xSzuuW25MV67mA2HgI8OrwDkTTq1ECN6W7MKtVrakQ1vS
oqZxXv2rLaBL1QCF5qjHNC1uKAdTLAKk7I+G/FEM8+p2h/P/GJM6IDnHDVCt9jwG
gq9sHtMRHPdJTI0KyONe+DUga5MwNeK7hMseanMrvX9pHXAcLqPRpbIVmZb9Q9et
7A+0nPZL9WiPprzGQYpLKHS0Yzd7BceadlyBLOWR42ey/V0u05C1tTJdv3kWuOTw
PrMp28GUFRozCCIjIsLHiSyJ+L5LyaAPJmutMqvRMVmz1YvdXMqe7O1uPdJrNeCx
jyaMspcttqI1MdE7cw7HxLLuZC7SYw==
=qi+3
-----END PGP SIGNATURE-----

--oZr5QrGIUF584tX7--
