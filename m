Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C866ECBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjDXMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDXMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDF6E40;
        Mon, 24 Apr 2023 05:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DC9615CE;
        Mon, 24 Apr 2023 12:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E082C433EF;
        Mon, 24 Apr 2023 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682338027;
        bh=ZLvIBgHd8Xg6EPpA6BcTGe7XE4uE+coPaHGOJpY0rUI=;
        h=Date:From:To:Cc:Subject:From;
        b=AOKHjWyMFXePILFj7uB/Wy9lFgYdyPHnQYYFeTlFXyv+HavVXrC8lxw/PShbKPEJX
         gNUQ0rivqhuwY7gVK1SA+HmnU9QXGL+fhyjrNz1HS6kzDWRfTqKBhSlEQ+KTYAhkBK
         ++j/GquM6tUOMb5u3JIsTXgQ4Jc7s1F8R6xsKA8uoUDYFKq6CzDw+5PyFcZ5YTHmSr
         xB+P+e+ltGBUvJDaYVHUECgrNKt6J4h+xYCc6twDQ+asQCVmfb23WqSr03FdY+sVMH
         gfTD5cYV/MTxGxLkCttNB8cWlZZWsQgH9a5mw0BM+6VRB9rvO7Ue6hHlTsSbMHydVX
         /k4yvvHc+c1+Q==
Date:   Mon, 24 Apr 2023 13:07:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Missing signoffs in the hte tree
Message-ID: <143a3e5b-ddc9-4ce1-88ea-9e4d80761cc1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g/MTGu/LAgKnLx3m"
Content-Disposition: inline
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g/MTGu/LAgKnLx3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commits

  1af0f6b5060cf ("hte: tegra-194: Use proper includes")
  3798a6e3b6a89 ("hte: Use device_match_of_node()")
  981501927e482 ("hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()")
  58e1189d075a4 ("hte: tegra: fix 'struct of_device_id' build error")
  499c35fe9bf2e ("hte: Use of_property_present() for testing DT property presence")

in the hte tree for today are missing a Signed-off-by from their
committers.

--g/MTGu/LAgKnLx3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGcOYACgkQJNaLcl1U
h9Dj0Qf/TEEUKMDzKEyGSlm9uhO4nto6A0eNKKtmCqsKWZxK927jLPohFWkoNC5g
a5AN2yqWfJ7/rpI3g5wqRkkCVD2idjVtyALryjCIV+kwCPdrlKjD+XwvrBcDxDty
b0g3M2RfmO87IXThErup9J8r5V8K54VQHsMEXLfy4cuuNIz7bswewOWCTa6N9n4a
PUtiaUNieeTTCqLnsJplEhpV2YkNut53y64/RMX1X/5IZN7d+xw/kifCthOZyHaP
zRMtGfyT2agyUqfyTsV+UWQg6qfARaghbltkX+vc7Z4XCR5k/L8/nLsSIJPTZ7UO
uPOoytoSqwbaV/qrInJpHOK4p/FWHw==
=1lTh
-----END PGP SIGNATURE-----

--g/MTGu/LAgKnLx3m--
