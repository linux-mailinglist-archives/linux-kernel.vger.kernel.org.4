Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA66732312
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjFOXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjFOXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B9273D;
        Thu, 15 Jun 2023 16:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3874461F82;
        Thu, 15 Jun 2023 23:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDCAC433C0;
        Thu, 15 Jun 2023 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686870433;
        bh=1PjAQXC6EO6kyUJubG5wMVdHRFYZIFiLVImaErWPjBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMgHW0sLFNHkyTREetfSgwDQToYlSsp1sZ8YAWd7yGIa/Ull2kkuyCsUXtTtXl3eV
         vcA+Qx8wNvwW/rlbmyy2notXaHBgobRx7d/1MPrjj251Hg2zJW3g8YPtsgOAnkHpcb
         D+i2nuJqImqv+PV47OVKG4mhnPegQ27xvuOc1Fyw8whi8af3rE+27PXqKXuc/G1qH5
         yLqyWD6+toB//A4PP0y+O3Rf/9d1MvbO+H89bWERcJHXm474jBIIMNaykvQd4uLt3s
         RKHGhA8L+DzFTNibj0HBGi6fy4zvjjZmaqvalrDF6aDABFNLBtQO77OtXZOeaB9W/H
         f1atP3ctfAeyQ==
Date:   Fri, 16 Jun 2023 00:07:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        =?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Marek Vasut <marex@denx.de>, Suman Anna <s-anna@ti.com>,
        - <devicetree-spec@vger.kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove last usage of "binding" or "schema"
 in titles
Message-ID: <20230616-skydiver-unwritten-5cc47e04bf07@spud>
References: <20230615213154.1753313-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UYzgGdFRAKyKvt7y"
Content-Disposition: inline
In-Reply-To: <20230615213154.1753313-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UYzgGdFRAKyKvt7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2023 at 03:31:54PM -0600, Rob Herring wrote:

> -title: Restart and shutdown handler generic binding
> +title: Restart and shutdown handler Common Properties

With the new caps for Common Properties, the title here looks a bit odd.
Should probably be s/shutdown handler/Shutdown Handler/ for title case,
but w/e...
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--UYzgGdFRAKyKvt7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIuZmQAKCRB4tDGHoIJi
0vaOAQCvuB+Vy9A841viHe6D4DHohHomPDJhhehcVREBQDS3/wD/W6WhHVSt6J46
5pM/kAhmxxmkyTHVvMdH2/sXzNDawgM=
=Uxoq
-----END PGP SIGNATURE-----

--UYzgGdFRAKyKvt7y--
