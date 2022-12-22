Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5798F653F34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiLVLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVLph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:45:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EE27DF2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:45:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6FBCB81D2D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB3EC433EF;
        Thu, 22 Dec 2022 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671709534;
        bh=Y1cUmhwFo68wOtgbAIPgTlOJqv2cgBsiYek52x4QyLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhqH8gIh8S0yGDM0PVbhOtJk43xinTwAfGKXCt8ddSLPmt7TbaegxtQ69r2Ninb0G
         H6lLZtScQoHkXCoSnWhj4xCI155ft3FBmzyIp7g0XS2ahTd+Wpe0zxV5QVau5vXc9f
         ErCMQIKyIy5cbddGIYhY0eeKn23yGov6apS7m2sM4yWKx2QwMJZ2ZVIOB2vxSgAGzq
         f7+dj3ldV4IRrBgKKUIt25Bx+PMpfRf28oNs+MzQNFRs6C3h5EyHSPd9SBiwPBFDrk
         YNOV3uMOZRcymr51KlhoTLIXCXfRM6PdRmHACURz5FcjGFLOjTyuRz1ZVWhf3jQTB2
         IVcoNEFhXp6pA==
Date:   Thu, 22 Dec 2022 11:45:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v4 2/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic
 generation
Message-ID: <Y6RDV/mQ2mo+/YFk@sirena.org.uk>
References: <20221221204016.658874-1-akihiko.odaki@daynix.com>
 <20221221204016.658874-3-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8fq1k0An7gXXTJSP"
Content-Disposition: inline
In-Reply-To: <20221221204016.658874-3-akihiko.odaki@daynix.com>
X-Cookie: Yes, but which self do you want to be?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8fq1k0An7gXXTJSP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 22, 2022 at 05:40:11AM +0900, Akihiko Odaki wrote:
> Convert CCSIDR_EL1 to automatic generation as per DDI0487I.a.

Might've been worth mentioning the multiple layouts in the commit log
but not a big deal.  Handling them does seem like something we can defer
to followup work along with improving the tooling:

Reviewed-by: Mark Brown <broonie@kernel.org>

--8fq1k0An7gXXTJSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOkQ1cACgkQJNaLcl1U
h9CUewf/XdZaVW2Uv/Z3iqOKHr50VNgD1bhn33H2JxeBdFCuW9DEeqk+UmT9OAn1
/M6ad30jxa09jOzWoXjzXnYv+0C8j3PbqHq2kSzC3STG+QNbXfBjsvd1tZaOJatS
RRAB64oajyZnJJ3M8Tz1Nw43kLLOajfnGUBrIuGS0PIncg6MwVHkoL2bLNdaSlIE
/ExWW/i18Y0Q2ac08HqRWdwxCvlYDz09+2ErTO5Y1tfgpMLFwT+4mzGGgIJj+xTO
08pzg4SobMMhopkHAeDlaX8WeAOaGqWRbAObM69IhckyHp9Pb0J9cAbPeTfIY/WU
JtFMeiXboDywUYGBM7B+6pt8N4r5Mg==
=0KQ7
-----END PGP SIGNATURE-----

--8fq1k0An7gXXTJSP--
