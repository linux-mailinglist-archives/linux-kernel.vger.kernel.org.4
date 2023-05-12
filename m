Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868A6FFE55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbjELBRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1465A4;
        Thu, 11 May 2023 18:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44FE6147C;
        Fri, 12 May 2023 01:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D101C433D2;
        Fri, 12 May 2023 01:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683854247;
        bh=GP6BPXevhWnrkVIoBZsm+CHI+jrvHkRHfe5odiywFS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLjaCvxoL/HFrvbfK5IiaeGtrBmtH3b2C4yoXiFkVJNqHSF0DEKDaZIvhgGjb2PCm
         efUf9POZ+VA4QfH5sMz/wplRlA08Qt9V1qAJibEaAFWwzttGrlQgyyaZTBu6aVnnlQ
         st9AUYJTrMTGf2QAdgU/nbvJ4lyCmstq1ZuzXAvNNiK8mrsF4wigL628f7NpoF/8I4
         7u4pDd2Y/ldEMvueGWpZ/RaiWbHmd9hhw539auM0wdtPjrl12WUinAOYirvegGQBU+
         lNHj8y50r6734Pp2/R6CrTWW1uNfcEDvnMQDCxK9KTRlKBRtlP3+gsi1esAb+HFu6F
         CAx236ZLtvtFA==
Date:   Fri, 12 May 2023 10:17:23 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] spi: Add option to keep the MOSI line low, when
 it is idle
Message-ID: <ZF2To/SJTUQGqXer@finisterre.sirena.org.uk>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AM4rZvbXgAGV4xfL"
Content-Disposition: inline
In-Reply-To: <20230511231317.158214-1-bstruempfel@ultratronik.de>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AM4rZvbXgAGV4xfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 12, 2023 at 01:13:13AM +0200, Boerge Struempfel wrote:
> Some spi controller like the imx spi controller switch the mosi line to
> high, whenever they are idle. This may not be desired in all use cases.
> For example neopixel leds can get confused and flicker due to
> misinterpreting the idle state. Therefore, we introduce a new spi-mode
> bit, with which the idle behaviour can be overwritten on a per device
> basis.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--AM4rZvbXgAGV4xfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRdk6IACgkQJNaLcl1U
h9ARnAf+PTIsXBL9f5P53wIz/Bpa8AbFFDoHP9w2vJgyPZDCXQX4rBb8CbVNBe/d
lVthf01AOLZQUDq/E2Sgcm1RhL4n1BFT+QcLEIgMHU3GxY8mA53QrnBFo4zs6IO+
+0dHOnMSXTR+V5KMK45v64A7IS/ExpfEZzsiFGYsETsJMRIUlHM2vzSb9Y94g2By
asZIrAFvVIZOXBygsCRm5DeHKXQGEEp4b+40RhxNygGVo3HWcDP7Wb04CqwNg9CS
kQp9uDq5coTSy1RKCHefC6//URaCMreiayeYpR7PIqZkUYMwgxkowrqRIjW/AJPm
nzY0945BM4aWP9qGv2jO3aIa7EfWBA==
=jMST
-----END PGP SIGNATURE-----

--AM4rZvbXgAGV4xfL--
