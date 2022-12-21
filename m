Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A96531DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiLUNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiLUNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:34:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248FA19035
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2B6617CB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF18C433F0;
        Wed, 21 Dec 2022 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671629685;
        bh=WqWR0d44+oC0M51OxsJIk5oYzW5Ewe38o6BJGMCz944=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSN6k2D3YaVWrsm0u1NnBATOWav1SPvpxVC5Qc3+KeNG4kFYC5BhBlpRUkUuffEHo
         V7tOKTKpWTi8p82CMsN7tiDvBA34Uc1gR7mMrdwD315dPO5RUP3u85SpQ0++9C9XaO
         2jBoCAhOVg/6bnz+J+IrkfN6pKwcqMCBkxJnLjIa+S//8J7fIjJSNTFLO9YbpkprCy
         hSHebH+WnK21ogAZxqRvkBPiFJRQGgodD3QxNpdDb7As0CjBWyOB/YTyDeIjg7Ahq6
         Xv60z9ryBv4gfT4g7hDGD/dYkBebh4LupvK57Dh5AYlcZNaLCVPy71ZI8vvhrX82oa
         KcjdrPs5K23xg==
Date:   Wed, 21 Dec 2022 13:34:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Dong Bo <dongbo4@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu,
        Nianyao Tang <tangnianyao@huawei.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Synchronize SMEN on vcpu schedule out
Message-ID: <Y6MLbsTpNI4E+5qe@sirena.org.uk>
References: <20221220105024.13484-1-dongbo4@huawei.com>
 <86v8m6bcuh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1wLM/v5tW57IqQt"
Content-Disposition: inline
In-Reply-To: <86v8m6bcuh.wl-maz@kernel.org>
X-Cookie: Programming is an unnatural act.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1wLM/v5tW57IqQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2022 at 10:15:18AM +0000, Marc Zyngier wrote:
> Dong Bo <dongbo4@huawei.com> wrote:

> > If we have VHE and need to reenable SME for host in
> > kvm_arch_vcpu_put_fp, CPACR.SMEN is modified from 0 to 1. Trap
> > control for reading SVCR is modified from enable to disable.
> > Synchronization is needed before reading SVCR later in
> > fpsimd_save, or it may cause sync exception which can not be
> > handled by host.

Reviewed-by: Mark Brown <broonie@kernel.org>

--X1wLM/v5tW57IqQt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOjC24ACgkQJNaLcl1U
h9BfMgf/Q43z96bvYnITDmaGHJxEC1F3oW2EdvKLoge3nzDZJTbsZX1jqW5k6Hes
vfx8GK+A0zVG6XqyT6MpRm6WIldfEpQwTtvdTDFs1DiY2GEpfQozQKllrquASy9W
W3B1UCB90Dv4c519bT3WRCInlUpHRJijyj/m4cijPK4bhLWqVlJXEPJCZ9kZtd3+
zaoOdLKZliZ4qYYe1KydiQO+tBNtSwflYRRfD0taUdpYPjDURuIcGubtuwdOkAqa
4enKZHb2JCUxTuBqOw9ocMglWfRjG+RtRmTdqHap1s0dmP0ywB7v79TBty2HYd7A
JcOErjeidYrL4XN6aYR91H1EtqhvKg==
=+pAK
-----END PGP SIGNATURE-----

--X1wLM/v5tW57IqQt--
