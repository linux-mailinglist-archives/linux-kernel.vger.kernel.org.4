Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29710617C50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiKCMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKCMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAD463B6;
        Thu,  3 Nov 2022 05:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CDC61E6B;
        Thu,  3 Nov 2022 12:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806FEC433C1;
        Thu,  3 Nov 2022 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667477752;
        bh=lb+yhTjLdYWAcAFuFJyixOYk9xymzg+WXLtCRRYpazQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFPqOtBZ1LQN3MRSXw8wD80GQITX9z7WvAcAGd8R0yR+JG1gsq3KKOMcadsUvITbg
         Go3WB7nrU0KWof32165s8ntuHDQsleDPBLmKlsb0nteoprltNHIVJAffSU5GOfbfD8
         3mACPKykQgoYJVvyNEbmy6UGQeMAmGU2GJ+ysJC6y49ImQCt9WM2IyTV3hyriWZ/nN
         w5wx8p/EU6hskHRjH3eROcd/4eyncfpv8ofZw+XGqfB/PUFNFcRuo+EwtAbB6ZdmdC
         6rnSZ92e7M6JOHUSVjiyVfUdQ2HTXCkMPKeiA03Pd0SuLakY6duPpHvmn0wMRhZt4c
         yAGSJEMd9SXuA==
Date:   Thu, 3 Nov 2022 12:15:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm: omap2: n8x0: stop instantiating codec platform
 data
Message-ID: <Y2Ow81ALm1Osd8xM@sirena.org.uk>
References: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9EYEQ54xQSULucWt"
Content-Disposition: inline
In-Reply-To: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
X-Cookie: Dead? No excuse for laying off work.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9EYEQ54xQSULucWt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 02, 2022 at 04:20:02PM -0700, Dmitry Torokhov wrote:
> As of 0426370b58b2 ("ARM: dts: omap2420-n810: Correct the audio codec
> (tlv320aic33) node") the DTS properly specifies reset GPIO, and the
> device name in auxdata lookup table does not even match the one in
> device tree anymore, so stop instantiating it.

Tony, I guess it makes sense for this to go via ASoC if you're OK with
it?

--9EYEQ54xQSULucWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNjsPIACgkQJNaLcl1U
h9DlTAf/asblbZFEARghGgXN8jEX/Nx2xRTnXdqdxRsCN7G2r0ooPwGDM6oo0Etd
egiQIAbLwWUiwm2PlBjSKiZk7NHm8qcRw4meTosE0btDeB0+WfU2dM4eV2Rr+kFf
axlFieNV1c5Lr6yb7FpZB1uw3DYa7AaUCZjI6PPNIsDTgbpTVzYIofxlPwJb1sTB
Rv+oEtL/JfC50069op4dOpcscgKBnCM5HcYfwhok8Pv0e/gmhhlj1SYbQ2JfMtx8
tSOZlUr6lvm+bWRJJWppr3xOXp3avhhWNj3/DsanZihVjQvT+5fNAgSYPoG/rX1g
eVhYNFdrAWlrAP0HuDSXLGjH3K8c4Q==
=6G4B
-----END PGP SIGNATURE-----

--9EYEQ54xQSULucWt--
