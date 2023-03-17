Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6856BE9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCQMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCQMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:53:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD2EE062
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F24E5B825A7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E1FC433EF;
        Fri, 17 Mar 2023 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679057606;
        bh=2kLofOs64TtyjJq8drEVxBua+nc3RcF0W0R2/wfjVbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzDgjadCqo2zjAzmUIJKs3/YQKZv+NJefPbwKaMIA8kTw+ErB4m/IhKjCy6si0rHI
         AgCwot2cwTOngvCSDbP+mW1czmOrBX9JAf1cZifOil+oQWRJhXIGBFG7prwDpXqrN6
         8OXPyAn2qVFgpYpjQmqjj8IcDh4tFL2wLw4Tzo3+g4woRvDy3VLgtiuN46VyaLqHUE
         yHpXZCgTXDSb/Lbe50rzaNiizkYcGkxtXRIm/BtOWAULHIXLNFfTa5yhX+kOI1Q6xy
         U7WSF1AWX/4PzhJU1RcAJ5AWo6cK/Nsciq7hmlE2POvdAC3qEewjhWbhAPgDXojUqz
         I1LHORzD0+vcw==
Date:   Fri, 17 Mar 2023 12:53:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dongxu Sun <sundongxu3@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH 1/4] arm64/signal: Use system_supports_tpidr2() to check
 TPIDR2
Message-ID: <18314ae0-76f0-4e61-a657-cf05f817ee8e@sirena.org.uk>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
 <20230317124915.1263-2-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QD5Nnjf1fviTPT6N"
Content-Disposition: inline
In-Reply-To: <20230317124915.1263-2-sundongxu3@huawei.com>
X-Cookie: Life is like an analogy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QD5Nnjf1fviTPT6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 08:49:12PM +0800, Dongxu Sun wrote:
> Since commit a9d6915859501("arm64/sme: Implement support
> for TPIDR2"), We introduced system_supports_tpidr2() for
> TPIDR2 handling. Let's use the specific check instead.

Reviewed-by: Mark Brown <broonie@kernel.org>

--QD5Nnjf1fviTPT6N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQUYsEACgkQJNaLcl1U
h9C1Qgf+M3+Tyg/LZHF0OdovLd77gJQ9a6TBsyzh27ueOfHY4hRk0Nba9EjJRsnk
D882pG5rXEEKssmTdpdZBWuWRo8ndCts9EnN/M6UNRn4g49aGdiN5EV8F5dJ6m4f
VLyUF3axaYh88VlAkmDMwRM2VjY1Kjego4d4Zxl4TLbtt+gOUbPFYvIqrsqnj3ko
y1Bn7vocoo6OWSq6hjmOqkw56TYHXRF3B3QwsFLvascSfz9plI1sbwRKnO8Ub9M0
6OVDCo2SMzK7Sud65TAtGsjRINFEl9dsEdLH7X6RoYXkTkSlsfHX5Zc6KgMb59Dj
4ObsmFTvRtlyWxuqgW3vKf5GPk060w==
=NB1u
-----END PGP SIGNATURE-----

--QD5Nnjf1fviTPT6N--
