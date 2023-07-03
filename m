Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F237465D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGCWse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCWsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79439E6B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F17446106C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B970C433C8;
        Mon,  3 Jul 2023 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688424511;
        bh=3fk5FuSTND6Vyf0CQPwBc+LERjV2SJkerOpRoKKsjAw=;
        h=Date:From:To:Cc:Subject:From;
        b=ui9kEgELz10AMF/0zx6XpoIYp/YDf4f+Cl7QyaBuLl65V1XJ5h1PmyeARZuIl/xVx
         0v2t1cMgth+T/wNFq/Okv97V0OlmqjedENrAmL/z7MRGcdL5CifAzzdUATu+W52EPP
         6fN6mromiYqclQ+7bckgIkY25t8XB2I3JR9K4EN+AiKCPJSVxPiO7MW59HAQrdock5
         SuFKMh13byOu/agMsHwMtJlkXnn2zDWKQwhMqOG8v+ErBDEWDoFMYOZNi051sSJZrV
         bNc+WdCBkyjopBDXSZXJFAXuMBO08S3dBiCOVk7XTd4S99K3bphB9QqrPeP4MfULim
         wfHAkWGlXlIlg==
Received: by mercury (Postfix, from userid 1000)
        id A01C71061814; Tue,  4 Jul 2023 00:48:28 +0200 (CEST)
Date:   Tue, 4 Jul 2023 00:48:28 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for v6.5
Message-ID: <20230703224828.qldulem675s5y6ec@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plj23nropv4onoag"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--plj23nropv4onoag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.5

for you to fetch changes up to 42877c38ac78e456fd9e149842a96a3576fb36e5:

  HSI: omap_ssi_port: Drop error checking for debugfs_create_dir (2023-05-27 18:50:27 +0200)

----------------------------------------------------------------
HSI changes for the 6.5 series

 * fix build warning with W=1
 * drop error handling for debugfs

----------------------------------------------------------------
Arnd Bergmann (1):
      HSI: fix ssi_waketest() declaration

Osama Muhammad (1):
      HSI: omap_ssi_port: Drop error checking for debugfs_create_dir

 drivers/hsi/clients/ssi_protocol.c      |  2 --
 drivers/hsi/controllers/omap_ssi_core.c |  1 +
 drivers/hsi/controllers/omap_ssi_port.c | 14 ++------------
 include/linux/hsi/ssi_protocol.h        |  1 +
 4 files changed, 4 insertions(+), 14 deletions(-)

--plj23nropv4onoag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSjUDwACgkQ2O7X88g7
+ppWiRAAk0ae1SOKcbGBU47ok5FhF+iz0oBvjkL2JZildi8O5snHaxRsszLKbYeE
YybXqI0e2L6c1OpjA2SebxvsSBoMldZr3jWCdjkUyRl+3T6d9xqtAaw46O4R+UXT
XxEgVEIpx+hiMXzae0yLUuFhKtmIY8FojN60tDfr8Ea+SH/sPkInqNKuA53gPrYZ
Kluij1V5HMTN/jUXNHSrAZjS+WS9xP77c8p0T/15jQP3LYF8rAeKmMhJQm8YzAnb
BJIGHaqk3eqLk/WKPuYLF68ZFtANsLtLpyq3Z/yNCfvYrCNbQoGaGGv20y5sASen
05BcFcqzx3uBvyAYkFhrXkL5s3q67p9UdFhFT2RVbQ2XlGHJToS9Owo/Aba3Ty7U
UGEJQgmD4k+D4URiMwmFhWldjJk95qaCnAe8ntf4tN4iYbAGeGtfoSC7yPMBQ5RU
xRrfZ/PoK3gzB1cFGm8oFL6xuTWljpxlsUgSO7re6nko5vyW+LUNcWQWxSWSSkc8
xsOwQbFG7SXXGit7+42hjojLLlmf7L5nx2eih1/bgDrqr55CymzPvPutLNsRBc+p
TJRM2BhXUQIKb2hgA44AC+lG09tNb5I7Zt75F61C1CRzd4xwSAazA5YX41RIsWGk
MCuw2y+J/2uvfeDIZqQ0dT12W1pqjJwL1QlJsxN/AOxwhv0YTzU=
=cLVU
-----END PGP SIGNATURE-----

--plj23nropv4onoag--
