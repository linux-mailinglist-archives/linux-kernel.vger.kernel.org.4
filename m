Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81F665E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjAKOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjAKOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:54:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768DA1A807;
        Wed, 11 Jan 2023 06:53:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33B1AB81C0C;
        Wed, 11 Jan 2023 14:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F16C433EF;
        Wed, 11 Jan 2023 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673448821;
        bh=l7h8mYJZuBhMPhN7LKosUL1aDMOSgDxgaeg5YFv9Bu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktliF64bXUV/uUQ51zJ3jzem+3h4Q7TxUMIOfZb1j/6hyoNhdE2flmwqFqrmcAFkR
         m2X3D7VNyrPbO8jrGYX9dJgElhxlK0uqRiid/TX18hBF8+mRjQkPPlWcWN1UBmYLac
         xjLq3ckuxBLIB/0HuaB6Oq0YwrS384j7HMwXeLfAgNO6hEZrLMsvLZz0IN4Di+5Y4b
         x7PjRUnn9q3X9Pc5ERSgidOob5M50C6l1g1J4PttZBzuMkPQRV4pDc2UDk8RvMxMAX
         1rAet2ojt3SwUJhgQzXAW4wJ9NhjmA2GifaxYQFk5HSOXDtq8pQAA3Me3ysXo+Vjc6
         +bFU5pLaD/ljg==
Date:   Wed, 11 Jan 2023 14:53:35 +0000
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
Message-ID: <Y77Nb7SJzd6sSB5/@sirena.org.uk>
References: <CA+G9fYsns3krivbPSjQ1c1EQpVyd-bkW84MaUvqMTQr9c=iEaw@mail.gmail.com>
 <77342621-d67f-4d47-a33b-6f721576bf9d@app.fastmail.com>
 <19423616-79d4-9478-c6df-4f226f87a27f@linaro.org>
 <Y76rijHJ3KAZ6D9C@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NyJhWMMx1H0jFDH9"
Content-Disposition: inline
In-Reply-To: <Y76rijHJ3KAZ6D9C@sirena.org.uk>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NyJhWMMx1H0jFDH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 12:29:04PM +0000, Mark Brown wrote:

> We're seeing issues in all configs on meson-gxl-s905x-libretech-cc
> today, not just with the kselftest fragment.  The initial failuire seems
> to be:

> [   17.337253] WARNING: CPU: 3 PID: 123 at drivers/gpu/drm/drm_bridge.c:1257 drm_bridge_hpd_enable+0x8c/0x94 [drm]

> full log at:

>    https://storage.kernelci.org/next/master/next-20230111/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt

> and links to other logs at:

>   https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20230111/plan/baseline/

> Today's -next does have that fix in it so it's not fixing whatever the
> original issue was, I suspect it might even be exposing other issues.
> We are however still seeing the stack filling up, even with a GCC 10
> defconfig build.

A bisect landed on 0e4dcffd331fa7d ("drm/panel: raspberrypi-touchscreen:
Convert to i2c's .probe_new()") which is obviously not credible.  I
suspect that what's happening here is that the fix you applied is making
an issue somewhere else visible in defconfig and is as a result
confusing the bisect.  Ard mentioned an issue with non-EFI biits
introduced by EFI changes here:

https://lore.kernel.org/linux-arm-kernel/CAMj1kXGFa=Zriyp_mS7bbQr0wiwikt0ObjOKUSNGpJtFvLmnkg@mail.gmail.com/

which seems like a plausible culprit,

bisect log:

git bisect start
# bad: [c9e9cdd8bdcc3e1ea330d49ea587ec71884dd0f5] Add linux-next specific files for 20230111
git bisect bad c9e9cdd8bdcc3e1ea330d49ea587ec71884dd0f5
# good: [7dd4b804e08041ff56c88bdd8da742d14b17ed25] Merge tag 'nfsd-6.2-3' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 7dd4b804e08041ff56c88bdd8da742d14b17ed25
# good: [ecf8827ab7dd5731813f90146d9936165b170f32] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect good ecf8827ab7dd5731813f90146d9936165b170f32
# bad: [64208e4940ede76709f1ff5b01d1b78efc2951cf] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect bad 64208e4940ede76709f1ff5b01d1b78efc2951cf
# bad: [1077dd31ba60b39a231560beec24b97eadf8bd8f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect bad 1077dd31ba60b39a231560beec24b97eadf8bd8f
# bad: [1577a2c2aad943fbc6a5e959ae83c4ef8bc3d4de] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
git bisect bad 1577a2c2aad943fbc6a5e959ae83c4ef8bc3d4de
# good: [ec787deb2ddffc6cd6afe0e2fbbbd490ddc383ed] drm/amd: Use `amdgpu_ucode_*` helpers for GFX9
git bisect good ec787deb2ddffc6cd6afe0e2fbbbd490ddc383ed
# bad: [0e4dcffd331fa7d2a6ae628b51a7f418dfa90367] drm/panel: raspberrypi-touchscreen: Convert to i2c's .probe_new()
git bisect bad 0e4dcffd331fa7d2a6ae628b51a7f418dfa90367
# good: [c702545e19ebb6113d607f2a30ba2ee6cf881a3a] drm/gud: use new debugfs device-centered functions
git bisect good c702545e19ebb6113d607f2a30ba2ee6cf881a3a
# good: [977374cf481d3bea916b2775e6ecc682b9689550] drm/vc4: plane: Add 3:3:2 and 4:4:4:4 RGB/RGBX/RGBA formats
git bisect good 977374cf481d3bea916b2775e6ecc682b9689550
# good: [67d0a30128c9f644595dfe67ac0fb941a716a6c9] drm/meson: dw-hdmi: Fix devm_regulator_*get_enable*() conversion
git bisect good 67d0a30128c9f644595dfe67ac0fb941a716a6c9
# good: [29ef7605e2fd44038a70df0f46b7821464081b22] drm/i2c/sil164: Convert to i2c's .probe_new()
git bisect good 29ef7605e2fd44038a70df0f46b7821464081b22
# good: [307259952625798fbea89b04aebbc5106ff18c68] drm/i2c/tda998x: Convert to i2c's .probe_new()
git bisect good 307259952625798fbea89b04aebbc5106ff18c68
# good: [446757576a646eba6fae085396bdfbd74245ff28] drm/panel: olimex-lcd-olinuxino: Convert to i2c's .probe_new()
git bisect good 446757576a646eba6fae085396bdfbd74245ff28
# first bad commit: [0e4dcffd331fa7d2a6ae628b51a7f418dfa90367] drm/panel: raspberrypi-touchscreen: Convert to i2c's .probe_new()

--NyJhWMMx1H0jFDH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO+zW4ACgkQJNaLcl1U
h9AHxwf7BIatpjLOKRRwSZ6vH/lCXj5Af5JfwhejQkMbMaJQjABJCa1CkiRZ3sPX
J3gj8vQg98ni2fWKtuCgQMH+9Zz342rciBN0A82EON8QDeRAlyDgnrapkvDxxEvD
yEHbC+Uc7jer377/QGxkzbYYuoY6H74OAFjnM7wYwuy3o8e/SKZgUgxk/H9+VWzP
f/VBTWJNmU9gFRoh/SnHgDu90V4Aa6HzkNQyaDvlK33fMpHO+4tuRKDPHWg2vQyJ
h5CthYdC5GnTAvwh6Kjhasv7GBuqSp0Cc9Xv4DPGb8sYv6meszd2gCMb6hczoxsJ
XNR+frbS/QAt7PFbucr+amCmHxgodA==
=l6iC
-----END PGP SIGNATURE-----

--NyJhWMMx1H0jFDH9--
