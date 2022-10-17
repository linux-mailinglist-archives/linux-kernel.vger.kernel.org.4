Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F86014A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJQRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJQRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5371BE5;
        Mon, 17 Oct 2022 10:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C824611D9;
        Mon, 17 Oct 2022 17:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E48C433D7;
        Mon, 17 Oct 2022 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027123;
        bh=krHlaJzPvLjQqfJuSv/OVHfYALtY3FAQJLdgKatZOm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7M2rYpWGeXCqLI4Opi4t6ajVMC2lKhzCAL0Vw3a3fdHhjhGlyLkcXVv0d3bFwi/F
         W0PD3eF/AHvwFEjuzq7Qh9opmJHw5nQnjVTNCnxSe3UYiNZyZ6ibleqyoR7wUOmhbZ
         jyOzIBf4Q5fb50wxyPsZEAnmvJj1LAaOJL4KDGKQjrSs/5lkpbDen2RcqAZrIZSxyi
         ddZg5zWB6AmeBYl58MStmQFeiODN7MWKOvOihqHMf4+gUrMkuKLBeqyQuIPvcsBdo9
         FmGyB7RPpPIruHQ1Jxrm5nhXcYCaBPsXwHrVnDYcUH89YQ4PbTF99gO+umGt1m6zQ5
         kLOLhiLqQ1opg==
Date:   Mon, 17 Oct 2022 18:18:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y02ObkYoUQlY9oG/@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iarKEsYMc7Q7b1jP"
Content-Disposition: inline
In-Reply-To: <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iarKEsYMc7Q7b1jP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 08:12:40PM +0300, Andy Shevchenko wrote:

> Since the PCI enumerated devices provide a property with SSP type,
> there is no more necessity to bear the copy of the ID table here.
> Remove it for good.

They do?  How?  Are you sure that this is true for all existing devices?

--iarKEsYMc7Q7b1jP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNjm4ACgkQJNaLcl1U
h9DbhAf5AcLRs0gT2Pw6dKgWb3AtBuOjEWr3JX9AmLoLe+FnXpaiWLLVf5gCwt8b
kt87wygjh54g162FT99FD0khjx6suHEw/N3wCp6vw5H10AMG9qUALjNXubc0Ryfy
IbXhPi+DiAeutRDzPTA0Le2lEZYzBIFR+1xXJkYwvax9kWbnTZ3+kQfLy/SwUM0t
mnJyYrMjruDGWKJZ3ac9HA1qMswwsMfmnIDEzJxQNaRKm6JT+X5oHHa0c4SsGBpK
bafBjJoQD89XC+XoZBWTlznzrQ+hYnLL8dYQkRuxbEUWH+IL2cwKznz8vma6qgN0
E324AeijGqW54+nDFaVDT3Wn5qVnWA==
=zGfN
-----END PGP SIGNATURE-----

--iarKEsYMc7Q7b1jP--
