Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6621A686811
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBAOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjBAOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:18:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACDCCA17
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:18:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA096617B0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832E1C433D2;
        Wed,  1 Feb 2023 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675261084;
        bh=vTP/X6ya/oaxLU99qz7rXk2PwqTpzySESekwPkpiGPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5RGF1iOPGw8fMgb5L/4bBVFta8ZX1PBWQ89IFmrXAuCKP/7BQqYEoK6YfT0iO8Wy
         w/vwfgZ5ShWrg6Y8uVCw3f6N/mJ0xd5NOab5CttDoKQB1jI1RyusgVrZw6pIBTO/kN
         yDgnBkbVquIuzvTj7LOlhp3Jl71XoYh/damOs+PQ9zuBHqVbU7dDu6jvdvGINrxXUq
         oHTeLquX9NmO3YT9Bg3JRV5TSB4QAeNhCKpHKNFaaLGUvJ4Nk+Z/gZBVBLL2hF5Pit
         JSDrI3QFm75nxfNvn415Gxs1suwDCFV41FK9iovVh2ib14CdjFNqCzmgtSNXMKuEL1
         B55ECUbu0myUw==
Date:   Wed, 1 Feb 2023 14:17:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com
Subject: Re: [PATCH 2/4] KVM: arm64: Introduce finalise_el2_state macro
Message-ID: <Y9p0lWH9xTphfnxU@sirena.org.uk>
References: <20230201103755.1398086-1-qperret@google.com>
 <20230201103755.1398086-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+lYXR+bUApKLkVCw"
Content-Disposition: inline
In-Reply-To: <20230201103755.1398086-3-qperret@google.com>
X-Cookie: Oh no, not again.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+lYXR+bUApKLkVCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 10:37:52AM +0000, Quentin Perret wrote:
> Factor out the first half of the finalise_el2 function into a macro to
> allow its reuse from the nVHE PSCI relay code. While at it, make the
> register allocation parametric for the check_override macros as they are
> now more widely exposed.

Reviewed-by: Mark Brown <broonie@kernel.org>

--+lYXR+bUApKLkVCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPadJQACgkQJNaLcl1U
h9Bslgf+OZ8HuOi4ji7AehHmLidk3usjkIfXZ3xsQgfT91cOI9A7fvx6/vbkw1DT
tuILvtqEmD8oHn/ELWUiuKA8+cCtP4H5jSU7Q3+R0OrjaF+yluTFaHofc+lwXA6S
Unz9NKJy0/pxzouiEoLpUI+SXURv7Bf3MPuh7cuWn2BMQFKRlbFYA2hvHbIMVLSO
fEvwe3LX8hg1oP8Bzh1drAsqlT1KICg8XYNCBh18kP82GmO8gMcQKbTHYN7f0pM/
9BloBdWbp42hAme8cy1KOBPwE1PBxapIaKt2P+Xw3SXUD/RnO1piI26feCZbnWG8
2M2agEtd3G4AeI37ZcfRqtRSIO78Qg==
=wgJY
-----END PGP SIGNATURE-----

--+lYXR+bUApKLkVCw--
