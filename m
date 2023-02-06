Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BA68BD89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjBFNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBFNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:11:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBF15579
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:11:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85536B8109B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CAC4339B;
        Mon,  6 Feb 2023 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675689074;
        bh=bj7z4VfBMW0oYbqujy/aQRtk9/bVRQMqEKQV5nfKues=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENQBymOO24Jnyr4VXvEPADyvpAYXELsy8/mAecH3s6YB24bNFEVL8BFmZMrOvWAcn
         ZlO0x03R3ukRxX57XbPUaCgM1mFij9Dp2DMSBkHwrZFVSK5LPo2mCIYsynkL/BDRA2
         Lny52Ca7Vc+5ltaljbmgUaWNgc5pAXyQq6AEZ3e28zeMs5CLytMYIfEtbZ0lRGXeBo
         rWt335esryV+W9Wb0BSl5QlTI8U4dPWd3IVkU+4eLfWUT4iB6CFQSAQYPRHEqgKQan
         4/lyKzwSM9JLPTdZ8ocIKeabdHCcHvCSVi36DPgZ2C0E+nRlYNVT0lQtaCJz1abJX1
         v9mZQyaG5dVaw==
Date:   Mon, 6 Feb 2023 13:11:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Liu <andy-liu@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: tas5805m: add missing page switch.
Message-ID: <Y+D8bf/19aOL7Wzl@sirena.org.uk>
References: <cover.1675497326.git.daniel.beer@igorinstitute.com>
 <1fea38a71ea6ab0225d19ab28d1fa12828d762d0.1675497326.git.daniel.beer@igorinstitute.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lwql8M/YpjFd8AGP"
Content-Disposition: inline
In-Reply-To: <1fea38a71ea6ab0225d19ab28d1fa12828d762d0.1675497326.git.daniel.beer@igorinstitute.com>
X-Cookie: Hope is a waking dream.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lwql8M/YpjFd8AGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2022 at 09:38:38PM +1300, Daniel Beer wrote:
> In tas5805m_refresh, we switch pages to update the DSP volume control,
> but we need to switch back to page 0 before trying to alter the
> soft-mute control. This latter page-switch was missing.

You should just use the register windowing support in regmap, it will
take care of this for you, avoiding any further similar errors.

--lwql8M/YpjFd8AGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPg/G0ACgkQJNaLcl1U
h9AuSQf9EIW5Ag9rte8wlMbJdknCSfP5QH1E+2rlRNZ1vU7bbCbj80l55CjyNJoN
qk3UDHU5n/Vx/NF2rvqO+FS9WmVsaZOQF6QQLeNjId4674oNZbWPjGeGY0Xb/PPH
1MLwW0+33bChc4YGHuBu/aaVrTUxYdTSDoPKCSBz4eU3yHgmxhv5nYmIsa8CGNHT
aiHQebGLtf5GuZ7MOkSbQi1NsdCeVBzC4/VCpYtflEjFF136pYUp3PEXUjdah+lR
m6P62noZIflD/Hyu6CrkK+PajErpp7vKwcn46Z6LcGCx2FJ96N3rZUS20fG4c5Bs
16awfDAQeRN1MBCfGB33EUHNaCajFg==
=W1Zr
-----END PGP SIGNATURE-----

--lwql8M/YpjFd8AGP--
