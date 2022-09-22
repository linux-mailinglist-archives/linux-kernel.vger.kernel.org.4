Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C25E60B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIVLPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiIVLPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EB7E819
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2757561059
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99077C43140;
        Thu, 22 Sep 2022 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663845308;
        bh=JNI3lIGNV0Nkh9j3sQZdQKSI24Alqy8iO+0cEFYVqAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5i4pe54n5Wae8GI5qfes2xg2Ty0k9wjZakoKdrGz91vZklnybnGTI72cQtEA58P3
         yXifOdepTcH+DY4Y35lF/5nRY1sVX3W/7P40ylA3syK/EKzXGBH6NapTor/B2LqVdm
         kJQCWLPf2MEHQwKt7FBvmj0UIUEph2+PynbifUj+MvCmBvPqr5U63o/mHIUKE4SUNq
         TXNrjwa4Q+TkTEDnO9KTwPa/2rRc4jgRWqxSipcSOAaNStYcZD9wlZrKGYsOePh98I
         6WBitPg82/3d6a2l5ffQmcXqrPThPcFJzXv1g3MY00z3fiS0PwJfs77lJZdgGBMaXk
         f1MddQtTbBz9A==
Date:   Thu, 22 Sep 2022 12:15:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: arm_spe: fix ID_AA64DFR0_PMSVER_*
 undeclared
Message-ID: <YyxDuDQ2tYCSqfvZ@sirena.org.uk>
References: <20220922081136.2508758-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="doi2GbWbTzCo1hQI"
Content-Disposition: inline
In-Reply-To: <20220922081136.2508758-1-liushixin2@huawei.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--doi2GbWbTzCo1hQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 22, 2022 at 04:11:36PM +0800, Liu Shixin wrote:
> Convert ID_AA64DFR0_PMSVER_* to ID_AA64DFR0_EL1_PMSVer_*.

This should already have been fixed by a patch from Nathan
Chancellor.

--doi2GbWbTzCo1hQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMsQ7QACgkQJNaLcl1U
h9C7/wgAgd0jC30m7iWSXYNEkMchZUdc3dmoxSzJOBzkA9qkRqu+PQX39hidyG2i
xGwD2B9IrI7e+3dhxthzBuMuycZCSIGlyF3yB1yFnRgI7eTL/H7CT3EfvnU8Ebc3
i1h33mBiXq3PXkohv0dcLu20kbwcMDfp/DeytuNyPCj4/LrRYF4ZKL1NIj5FO+3U
6xSTpLoo6mWYQNby0FDPVtNz9u+HedP9Y+R/DJOxMYQCLRH1crF0DbwjCD/C4rcO
7b9bAPXjoEqkCcV1gh/GX3hVAtva++MIioTdW+3/mqtdAB2kvqDDdHnkKegIGLj7
55r7kmFBRYu16N1kG0ykpLBazK8dbw==
=I9qT
-----END PGP SIGNATURE-----

--doi2GbWbTzCo1hQI--
