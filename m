Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C1665B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjAKM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjAKM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:29:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D73C23;
        Wed, 11 Jan 2023 04:29:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ECC8B81ACC;
        Wed, 11 Jan 2023 12:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7004FC433D2;
        Wed, 11 Jan 2023 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673440144;
        bh=Zscbi5g8KaLoxtqKTYTy4v+bGIgrfP5nEZUwDmWu4fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/JK1rDKHYHvhajygf8w2mRW7bMgVgUH371tQZ88bFcNbixMBZAxLFSALrT2UDs3U
         6K8/8oxZLnMz3x7nh2jq3/MZ+CUaRUaFJYW7Q7lH0eSBnQdanynH3q02mFxJ4y/Xpx
         ddxMtPWrOJGgLsZ1UMh0wbHwaEKw69eDLBaHEDQ+X8jpgLHTK5qyboL8RW79Ymp+sV
         p3BzBmpCthJfVLY02wHyti3OQ7na5Y027dZ+vDHqN9gNq0te3IBkBl1g1bStQgJVCi
         j/NyxJqDNJm2CSXGEcHXG8wj7sWDGcPdnotZZkDNhNtg6vHzuhzisPWlGNUUFasEoj
         BAwxQQCCLgU9g==
Date:   Wed, 11 Jan 2023 12:28:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-next <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: next-20230110: arm64: defconfig+kselftest config boot failed -
 Unable to handle kernel paging request at virtual address fffffffffffffff8
Message-ID: <Y76rijHJ3KAZ6D9C@sirena.org.uk>
References: <CA+G9fYsns3krivbPSjQ1c1EQpVyd-bkW84MaUvqMTQr9c=iEaw@mail.gmail.com>
 <77342621-d67f-4d47-a33b-6f721576bf9d@app.fastmail.com>
 <19423616-79d4-9478-c6df-4f226f87a27f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZN5I8D63BKoaTA7"
Content-Disposition: inline
In-Reply-To: <19423616-79d4-9478-c6df-4f226f87a27f@linaro.org>
X-Cookie: Life is not for everyone.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZN5I8D63BKoaTA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 11:34:41AM +0100, Neil Armstrong wrote:

> I merged a fix that could be related: https://lore.kernel.org/all/20230109220033.31202-1-m.szyprowski@samsung.com/

> This could make the driver to return from probe while not totally probed, and explain such error.

We're seeing issues in all configs on meson-gxl-s905x-libretech-cc
today, not just with the kselftest fragment.  The initial failuire seems
to be:

[   17.337253] WARNING: CPU: 3 PID: 123 at drivers/gpu/drm/drm_bridge.c:1257 drm_bridge_hpd_enable+0x8c/0x94 [drm]

full log at:

   https://storage.kernelci.org/next/master/next-20230111/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt

and links to other logs at:

  https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20230111/plan/baseline/

Today's -next does have that fix in it so it's not fixing whatever the
original issue was, I suspect it might even be exposing other issues.
We are however still seeing the stack filling up, even with a GCC 10
defconfig build.

--OZN5I8D63BKoaTA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO+q4kACgkQJNaLcl1U
h9Dk9ggAgiyNXp8FESi8ST8bCJzfxxMvylBdG+Z+1Q2//2usTBZ89jQ94M9CVgZr
AHSsut/qzDLYBEQQ9VnLXutGV1MEWqwl+K0vILqKKTV2+uwAcbpWOENJwnbGzN7+
fz8MtV05xlt9M1K7qtQnRb01xgt7zXr0lY1HVOpQyJzInoCypdlp9laV/nsQDYh+
X5WPh12TqUbzc1LBqHBV1xpOZ8C+NNptsRuyLM3IJex6Am6xcNTnH4OcEL1vAuWp
ASrh9a7w1rxfYBYVUMJIhdCNHZZmaj+NuB2hAEJNnQ7NNGPeaCYMvpe8S5DE4/Uz
owLmp0WY+mpnbwzg6IPpQHjNeFiqJA==
=gr7z
-----END PGP SIGNATURE-----

--OZN5I8D63BKoaTA7--
