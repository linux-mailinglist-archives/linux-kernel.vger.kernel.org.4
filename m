Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF174C851
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGIVNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63343118;
        Sun,  9 Jul 2023 14:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A1660C40;
        Sun,  9 Jul 2023 21:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AD5C433C7;
        Sun,  9 Jul 2023 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688937213;
        bh=pKIENcFMfmHWW0aomrKnw7J0Z58D77T1uCoJfi49OBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TavIYhZq/WQcEHW6q2SSirWjPCfxH/RVgTPrZkH8RijsFM7ewlis3aoa8YPmZ9RLY
         Uel8TDEeQbSMWmWg8s+7tQaGchtExsEexGzpBYEi3FF+0pK0338VxddLPDbXsLCT1T
         Hg/4SrZ1XMwtigKhok2/BlGZGbEWFYcn+J/mHZxFZ3suIv+CQMO9IXDCLUFpK9N4se
         WL/W7S721STlbO5615JvD+zgJEBS9XnE1/4WJdQyUT9CfZfm0TtH1zugEjbyeqfUZM
         P1ZR5NEV1d8iCp1PBcdXF9pqTlvL805BeNGTK6/mLgjMvQpvBfBPRe7Na91h7kmGRx
         h2/L+rjgTLo/g==
Date:   Sun, 9 Jul 2023 22:13:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com, amit.kachhap@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <ZKsi+UOdjlmDnhdj@finisterre.sirena.org.uk>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
 <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
 <ZKrKjS7sDFxhKoJT@sashalap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+qXkK1XcJkg4nect"
Content-Disposition: inline
In-Reply-To: <ZKrKjS7sDFxhKoJT@sashalap>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+qXkK1XcJkg4nect
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 09, 2023 at 10:56:13AM -0400, Sasha Levin wrote:
> On Mon, Jul 03, 2023 at 12:51:57PM +0100, Mark Brown wrote:
> > On Sun, Jul 02, 2023 at 03:50:52PM -0400, Sasha Levin wrote:

> > > KVM currently relies on the register being present on all CPUs (or
> > > none), so the kernel will panic if that is not the case. Fortunately no
> > > such systems currently exist, but this can be revisited if they appear.
> > > Note that the kernel will not panic if CONFIG_KVM is disabled.

> > This is a new feature, it's not clear why we'd backport it (especially
> > since it's a new feature which is a dependency for other features rather
> > than something that people can use outside of the kernel)?

> The second paragraph (above) suggested it should be.

That's saying that the code won't work properly on systems where some
but not all of the CPUs support the feature.  Note that the changelog
says nothing about fixing any issue here.

--+qXkK1XcJkg4nect
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSrIvgACgkQJNaLcl1U
h9AASgf/VUrMTlXCkMU4qomOSAYkBpeDf7op2KUSgZUUHu5rDYjCyxTgwqmtfnE2
+P4vQIovegrMJBKbupm80uqadBMfxS2kH/yT4BuIBzVTuuR9kSRZeuXaBTtXQxZc
Ha4rsOYJ3bXeoMkGLIJrS6UPUfULg406ccC39LFf1fOZd6YWG2iLM5Z2Z7+szL5D
AiYc6uOS3onLDcUGH/gpoxH5rGbzrFqvgxW9w90H9UgLIoZHFLrorKAuCG20vc7m
D6MMY+DrAiEGdOvpI7CCUPmXZAVpdceLYrAPaRAs5JBLIK0Q4OCWQNK0kjebqv8p
WQWjjUQ57C3uXR4IHyRid7q3EJ1w1Q==
=dQnC
-----END PGP SIGNATURE-----

--+qXkK1XcJkg4nect--
