Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E88E6999CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBPQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:20:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCCC83DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 044A4B828E1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA28C433EF;
        Thu, 16 Feb 2023 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564430;
        bh=4/Mra1uduX8keyCHbdM9fzHuDKiiGoVReok56faIhNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebZC7z7iwhtoZcYsHbsUDXUfX1aJ9BBwrTQeBbZ3ktFOx5dPrOyoOgSOsnk7t+yTk
         SbEzns9u8/snEs3ghpg8eQQ4HWXYQwrO5f3ZR+7xuhs6ODm4P3qTA7+q1YCeSHBxNk
         8X0gfjex4vPzEoXbTXNR8H0lwrjUDaPApbPPslJMM3NbvHsZB7ob0074Pkn2vrxgii
         k/mVsM17Ppr2LyNtgpNNCg8CcRTCWEHAjmONsIr9y+9Xi0lYInAV8AyL/k3ekpciIa
         V5tFtGFYz27PrbYnt5ZXujGcV6cJoWUOo1KR7LchH77Qt7OiAaj55CUZgxlmqnWnc7
         4zCgaBMjnHvVg==
Date:   Thu, 16 Feb 2023 16:20:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] KVM: arm64: switch HCRX_EL2 between host and guest
Message-ID: <Y+5Xy/Hqu4FKLTUE@sirena.org.uk>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-4-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q7jxvfpgnyMhcdqv"
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-4-kristina.martsenko@arm.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q7jxvfpgnyMhcdqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2023 at 04:00:05PM +0000, Kristina Martsenko wrote:

> After this change, SMPME is no longer set for guests, which should have
> no effect as SME is currently disabled for guests.

SMPME is mainly set for the benefit of any future guests, it is
used to turn off SME priorities for guests.  While it's true that
we don't have any guests support yet it's there as safety to
ensure we don't forget to enable it later on or something
otherwise goes wrong.  We don't need priority mapping on the host
since we don't have any priority mapping support at all, and it's
difficult to see a reason why we would want to remap our own
priorities in the host.

--Q7jxvfpgnyMhcdqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuV8oACgkQJNaLcl1U
h9AbuQf/dYenzWHcmALSd/TVql2lkH47+tYsmsFjjo0LoUnrjf1CCIHC59/DRgNO
99qTOxbxoqnLktQLteXIyI2hqTJm27jExVnklJY8ffYJT8W19P3j7xMB+ho44f+D
V0+CXwSYW6SFELOHcplmJpiZ83EFGXxBI05QHIuxHYI68n0w+ZgJfh9gvDNNK8nf
oV/vEGxOWBmz1mcZ7mrlttthS7BLuHkrB/sBgcLSOfSe73y0nLbJpS+ulkn/tDQK
goLRiRebsyRHKX27f/V0zKQWDeWSuT3fFqX4kMSBE0HD5nU0CH4yhba1VscZtbNs
oYhzKsw6QjdmvCeNwZ/TpUFyDufYuQ==
=leqC
-----END PGP SIGNATURE-----

--Q7jxvfpgnyMhcdqv--
