Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F95BD219
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiISQWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE331365
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BAD6164E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B3FC433D6;
        Mon, 19 Sep 2022 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663604559;
        bh=B0CM8ML6KxRFE5rJXhGiSkQX5bHZqoHOnkyADesm7FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZodCOVKCNbksZJbp4jgIL8Ib9uaODAZK6hB+3PHD4zroWWRUgY6QkZKx4fBvRhFRy
         w31roT4Aa6atxTya3oOtx3rf+QGORtyuClS/dWPthZ/SewWxsazigIDaFCbzufHVWg
         EiT68jTrXY6cpQcUHlL2MhjHBJ9zmPLUeLIRalvmrI+eDpR95OhJqDbOoCa4y6mbns
         HJX1e4AKheXgBM8fdgtm1xOhy1dA2jPYH6YmN8mZtgfa2QWteXMEe0JcCczZSct/yI
         D7S6USSIBRBbA2NIvx3rdUXNtWj+Ex+V4FP6fwwBKJ4iMzKmxsS6eP4tadEtXJ86dS
         z8bpvHeCsLsXg==
Date:   Mon, 19 Sep 2022 17:22:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64/sysreg: Fix a few missed conversions
Message-ID: <YyiXS0k4EUS0KaZh@sirena.org.uk>
References: <20220919160928.3905780-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TVzyo+OGs1VMM75J"
Content-Disposition: inline
In-Reply-To: <20220919160928.3905780-1-nathan@kernel.org>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TVzyo+OGs1VMM75J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2022 at 09:09:28AM -0700, Nathan Chancellor wrote:
> After the conversion to automatically generating the ID_AA64DFR0_EL1
> definition names, the build fails in a few different places because some
> of the definitions were not changed to their new names along the way.
> Update the names to resolve the build errors.

Ah, I was just working on the same fix:

Reviewed-by: Mark Brown <broonie@kernel.org>

--TVzyo+OGs1VMM75J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMol0oACgkQJNaLcl1U
h9BM+Af+N/LP5DV7hS4FTJ/7rQVaTNRCeVBwLp8oDEqtdlFTLWuMKNlXlaxPnFOh
T/Ozt7VtBQ2vU6n7/IBPLTlNTXwshsJVdHM2zAeBoKUifO7JKUOK2BHIciXA3L24
Ao7UB7+4QxuaRz3jaI8j2xXXXOHZY2SUEos0Y6ZaFyp9d14tKASh2anQrJqYY4MV
IZ3PiChTMS32f74Ku9hsiqGRArYMLp5qbL7VPCdeP04zm83FKtgXNX5odze17iYK
pzMP14YxMF+IlQr2zN6SyBdjC4diQjPnLP9hzNdyTnoGgXuRA8T1mkk5Oypys1Hq
AN9Kdd4D0yPveeOigVJvfj0CjGtEGA==
=zpZn
-----END PGP SIGNATURE-----

--TVzyo+OGs1VMM75J--
