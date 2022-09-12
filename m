Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B55B57AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiILJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiILJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:57:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B140B1E;
        Mon, 12 Sep 2022 02:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 316BC611A3;
        Mon, 12 Sep 2022 09:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020C4C433C1;
        Mon, 12 Sep 2022 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662976646;
        bh=oxNRRd+/qnc5PG+8zykOVxGBoTfoKYP7uOymT2bCbxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbdpohZGzTH348w2x8A0rEPWMFgzO1xdYsIj01NJ9ckmQlWj/rYY+XhM/dfZXYT55
         Ag8rRC2TKbdcl86Igyew/j7TrzKqQJqEW+0W/Ew4cRsa7lZxI052BvSW5RVsSzFD+Q
         ztfoCeU0EgxePvUG751fUEVm6zkBi5qEnxq5QCdVaNcBKspV5ct/7tBXrbItN8tkhe
         Xv8O8WV/Gaey61v+xqfS138v2gU9dOK1aoBQD0OIt4OQZRx3Jo3OzsfqPCclxHZNAs
         0qPNYqLnJKLltu6bt23/EgcoD9VVl6mkdop/H8x3BszE9xqgx01thXaFZQjxcQzVuk
         nWVxXjqgeRA4w==
Date:   Mon, 12 Sep 2022 10:57:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 1/7] arm64/perf: Add register definitions for BRBE
Message-ID: <Yx8Cgzr7lQdMLX+P@sirena.org.uk>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dmQSrbmLl2fa1iHv"
Content-Disposition: inline
In-Reply-To: <20220908051046.465307-2-anshuman.khandual@arm.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dmQSrbmLl2fa1iHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2022 at 10:40:40AM +0530, Anshuman Khandual wrote:

> ---
>  arch/arm64/include/asm/sysreg.h | 222 ++++++++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)

Rather than manually encoding register definitions in sysreg.h
can we add them to arch/arm64/tools/sysreg so that all the
#defines and so on are generated instead?

--dmQSrbmLl2fa1iHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMfAoIACgkQJNaLcl1U
h9A04wf/SOgxJF9+6OYpMjh9mbiNsTbNTGbbkkCxc/qdLlCVOQaU7gPYldHik/ko
OQuRpS8874xd3/lf6/y5fBDOCyovXDDh4tIoQjCQVr7zpS83t3fkIbIbC2Y3mOMc
rmRUZ/7JEIi9MeydZu0tj5BnDqqsM5+afgOjbf0wa45veyakZoLp0xsCx28PrepI
IEyGlgzJ3OlWiSYjq9yGqwb5YKKOw0dkC0T4fygwiiG5zecRxoUSoy4FbdFWv1yx
9YSsjM8ScLnb7zTwztWpPu9ZXbOwRwTemYRJZvBrWU1MScuU/+Qc6NdWCixCnr0m
S2k3IvEWnbeMt2bv1kP4cY5LvjR5/g==
=9mtK
-----END PGP SIGNATURE-----

--dmQSrbmLl2fa1iHv--
