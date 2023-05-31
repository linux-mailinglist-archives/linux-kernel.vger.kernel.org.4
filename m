Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4C71814C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjEaNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjEaNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A5123;
        Wed, 31 May 2023 06:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C78A63A67;
        Wed, 31 May 2023 13:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8286BC4339B;
        Wed, 31 May 2023 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685539263;
        bh=38r927G2inyVMml0LWLz7BZPDRXvg4VePw65RoNKYtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdZne+qt+TBfcx78L1P/e2jFK0kSzM5OFwvU2lxOWm2TlFradzemowoi00+tmv6y0
         sWY0vKMfcns0lX4vAY/CH6ckpM41qmMi1xxJxqhdUeryyDNpqMpv5VLXnjTFxKv5YT
         30pidaxePH2tzlQBSPb4vfBLDSguMgjWY93t7Ya/SLeTzGPsOFra84VCLvf9MR2KbQ
         vf2dSCmwUct0o7VADfK7uJOVALI/Hv4GXRwP19ty6V6ofqoGe4+N9AN+pZH+WtAalo
         AsJXlkNLdL/RX27xAB+do3GU73RxNpW897H95tp6qq29koGhTPCIRNZF0s6kd6Xn8P
         VIb+hnRbwW75g==
Date:   Wed, 31 May 2023 14:20:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v1 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <075db1ba-e15c-4c3c-9430-99c866eca24d@sirena.org.uk>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-3-william.qiu@starfivetech.com>
 <fecc9d6a-022e-49d9-a452-8a63c409ebf3@sirena.org.uk>
 <042c560d-1f36-8e97-3796-7423245592f4@starfivetech.com>
 <86555925-b8dd-29a8-60cd-5c2ff2c1432a@starfivetech.com>
 <eb68722b-bcab-4aa1-aa4e-54bfe95ef414@sirena.org.uk>
 <93ba0b97-45aa-e59d-1454-80c4f245acc0@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G6ktQj/BvBBSNjYO"
Content-Disposition: inline
In-Reply-To: <93ba0b97-45aa-e59d-1454-80c4f245acc0@starfivetech.com>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G6ktQj/BvBBSNjYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2023 at 02:19:16PM +0800, William Qiu wrote:
> On 2023/5/30 18:33, Mark Brown wrote:

> > You could always specify a different array of clocks depending on which
> > compatible the driver sees, just like you'd conditionally request clocks
> > individually.

> 	If specify a different array of clocks depending on which compatible
> the driver sees, since there will also be clock operations in the suspend
> and resume interfaces, this can make the code look complicated.

If you store the clock count and array in the driver data that should be
fairly simple I think.

> 	as following:

> 	/* Obtain QSPI clock. */
> 	cqspi->num_clks = devm_clk_bulk_get_all(dev, &cqspi->clks);
> 	if (cqspi->num_clks < 0) {
> 		dev_err(dev, "Cannot claim QSPI clock: %u\n", cqspi->num_clks);
> 		return -EINVAL;
> 	}

> 	This way, the code will look simpler and clearer. How do you think
> about it.

I'm not clear how enable and disable would then work?

--G6ktQj/BvBBSNjYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR3SbkACgkQJNaLcl1U
h9A5YAf6AyXRsEmaDvRUFjWZZNZoMgo2EFDR0Jl7tIiuqYCoBj6JUWnZZBV7bZnq
tVBoRN8pUEPIdzISOFwas3GYdOHZdSMagbeH2d8DZp7Cn7YTBcHKdw4otXRB+4QN
tXJITLg7JSbzgd6gP/wfMp+q9Yyf0q+T9kRsrBTFSYuJmh6yg8CRaHrHmdomTBAB
ZvB/TwoNFJYrvpRIJXUQC3mOviO7eQCVr9z6ZG8iwlzlxym7ZSC/rRbG2MtKlxls
zIaL56Kwe4MQg7LgQejCY+z4ZLUdqpLb9DiVOp9bRspzRuWdRABZsdzahkgEZCbL
C2/G7xzOwRn0cvaF+TipvT73i+QPxA==
=6EZR
-----END PGP SIGNATURE-----

--G6ktQj/BvBBSNjYO--
