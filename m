Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA145B6C63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiIMLaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIMLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:30:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7826439B98;
        Tue, 13 Sep 2022 04:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26F0EB80E8B;
        Tue, 13 Sep 2022 11:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777C0C43470;
        Tue, 13 Sep 2022 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663068603;
        bh=42XNTFrrvK+igHhL2KfxLoxvedsbp3aB3youitKlCzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhBp87gpSAlBDbr3TdP2iinPMoe6QF8zvMTo9CwRN3bdJTLIB2/Ry+R781MMfMAOY
         DkaGqSqiFnVF76mFsZWmEduT7Qx7iLjpb+7f4Yds3jvuVQVJQaDCqcRzEVrsBXbSzL
         GFSUIxgmrppCafBQvoEPxzCLqP4AbB8DpQMBCdwLAqgh0wtwF/50GaLNJVaDlm6I2c
         Z9eKmLROn7NKv8I83LtDCvlQrb/6mLWbaNMfsSKFhLkpZSMOkxNBc5SZxzXHdu+kR1
         2NhO3qZvvBwuXOQWRK16jGlymTnGl12lTFZbGoNMQNTQSowyAWyyGbZ4r5u0z4TMs4
         XA9wj1wVy73rw==
Date:   Tue, 13 Sep 2022 12:30:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 1/7] arm64/perf: Add register definitions for BRBE
Message-ID: <YyBpuQdNBDLpjJWx@sirena.org.uk>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-2-anshuman.khandual@arm.com>
 <Yx8Cgzr7lQdMLX+P@sirena.org.uk>
 <95599654-a302-dd64-e1c8-4d9a723aed85@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yfGsNmzYPSvOmyzg"
Content-Disposition: inline
In-Reply-To: <95599654-a302-dd64-e1c8-4d9a723aed85@arm.com>
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


--yfGsNmzYPSvOmyzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 13, 2022 at 11:54:09AM +0530, Anshuman Khandual wrote:
> On 9/12/22 15:27, Mark Brown wrote:
> > On Thu, Sep 08, 2022 at 10:40:40AM +0530, Anshuman Khandual wrote:

> >>  arch/arm64/include/asm/sysreg.h | 222 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 222 insertions(+)

> > Rather than manually encoding register definitions in sysreg.h
> > can we add them to arch/arm64/tools/sysreg so that all the
> > #defines and so on are generated instead?

> SYS_[BRBINF<N>|BRBSRC<N>|BRBTGT<N>]_EL1 registers are encoded as per three
> distinct formulas where <CRm> and <op2> are derived from corresponding <N>
> Just wondering if those could be accommodated in arch/arm64/tools/sysreg ?

It'd need some work on the script but if there's a reusable
pattern there (I'd guess there might be) then adding some support
for generating patterns like that seems like a sensible thing.

> System register description via arch/arm64/tools/sysreg seems bit cryptic.

It's very close to the way they're definied in the ARM, and I'd
say a good bit easier than typing out all the individual defines
and making sure there's no typos.

> BTW, do we expect all existing sysreg definitions to move there ? Because
> still there are many registers and their fields present in sysreg.h

Yes, we expect all registers to be converted.  This process is
onging and if you don't do it now someone will just have to go
and convert it later.

> Besides, there is also some benefit in being able to grep system registers
> and their fields, across headers and implementations simultaneously.

That's true.  On the other hand having consistently generated
defines that are tied to the architecture means that people can
look at the ARM and know that there's a define already provided
without having to go check, and having everything generated in a
very consistent fashion means that we can write helpers which
take advantage of that fact - the SYSREG_FIELD_GET() and _PREP()
helpers are an example of that, once James' series for the 32 bit
ID registers lands we'll be able to start adding more for the
cpufeature stuff.

At the minute the major advantage is that you only have to cross
check the input file with the architecture when reviewing, and
that has a format that's very close to the architecture so is
much easier to validate.

--yfGsNmzYPSvOmyzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMgabgACgkQJNaLcl1U
h9AvSgf+Oj93mMUlfykS+eT56crBYR5Zami1qCoWVgsH419ERrwTJLbcJZ4kpHxD
T7XvMmjhrCrLQvLUg+GisRbh+1+FilBzMkrsCHAlQ86zlGhByaixPKq4lk/N/e4Z
YBdPiiP3OhS74JO3h9Os6UB+G21vxjrHQBDtNbE0ZHEBGgrB42Ge/AlmlvgDUB76
59dy4Z9SZ+CGZIUAdQxrivcd4c/tC5Ld8LPmSJR9fWl2wXkBIY7mA1bI1fVC5dp6
aLJk1J98UdePlIRctcIH9gu7UjwkWtfPqdnIYZ8eCQlmfpBL2YF2eUiJoNqnlR+F
on+zyETlin/QBU48W8F0xCY44AIj+Q==
=0n7r
-----END PGP SIGNATURE-----

--yfGsNmzYPSvOmyzg--
