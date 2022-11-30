Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2B63DBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiK3RR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiK3RR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:17:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE31578E1;
        Wed, 30 Nov 2022 09:16:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB0761D1D;
        Wed, 30 Nov 2022 17:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2955C433D6;
        Wed, 30 Nov 2022 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669828578;
        bh=yyriOptA5RWxFE38x5xxIOr09IYVT+AppLmF6+AlJsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLna48rhaHtiXHKuJdHhpAsQJCkScar0R0IKfCommkdtCEofbO762Dlh5m8nqx5O+
         XXzjbc/lT/F4r3Dp1sM+Byeje/txzqS4EqGRaXoSBilQSLWb/nG1HoD24ZkV32EYKQ
         zUwyUQm4GNoRnZOZiKjPpXaTpB+X97mjqaakC8cwoWGeLO8lcm9feZe0+xEDkrBxup
         39NsZSUS1JSRjP6ZV0wYmAFYYMQ7o+17T+w2KeuQCDgr5nDCZ7okdbDF4dhMnXKB0s
         3mjTr2VnMqrBRvSaBRUEFSmkphzQO+30ac77g1Xiqh5s9YbyuEYhlgIB/tZy4nWlIN
         61YV+oqNT1DaA==
Date:   Wed, 30 Nov 2022 17:16:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4eP2yFKsmxzyX/4@sirena.org.uk>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4eN4utrDnEnKu/8@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6SJAvmLG8+E8QRmv"
Content-Disposition: inline
In-Reply-To: <Y4eN4utrDnEnKu/8@google.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6SJAvmLG8+E8QRmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 30, 2022 at 05:07:46PM +0000, Matthias Kaehlcke wrote:
> On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:

> > Add __maybe_unused tag for system PM ops suspend and resume.
> > This is required to fix allmodconfig compilation issue.
> > Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")

> This is incorrect, it should be '2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add
> system suspend/resume PM ops")'. I see you fixed that in v2, but this patch
> has already been applied ...

with the fixes tag already updated as I was applying it.

> Mark, I appreciate you being responsive and picking patches quickly, it might
> help though to leave 'external' reviewers at least some time to provide their
> feedback :)

There's a balance with hanging on for utterly trivial patches to get
reviewed, especially in areas where reviews aren't relaible or
consistent.

--6SJAvmLG8+E8QRmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOHj9oACgkQJNaLcl1U
h9CVTgf/Yk6JQALmBhkO871ntVkBaSxGqlp+3vln0kZMki5ZCf9OWnSUtXUmaUk/
Vmk6rTe1hZ7fKFIcV1q1D6y8OnlRPFTBbCZl8OwPBESHXxFm3kWkiBpReuEr4Lzl
x9H399V3j+XaqQH2a7a08ls4Xr+L7pcnP6jIqmTp2H0axiGSWoxxBbIBeNO/BSoF
nYuaDojavoLEjR4LOyCgzGu1+E+NFeqrE2lkdlhc9KWObJ5a2iaRgCkXq6SdYJmH
wcqu9ldjoiWBJElKShLPW/2OKS2ADP7IVNi8QngsYt6iYO8p58lCOnfI58vhpdwR
/LsOtpk0Wtk94W2lYsNxwf3TYWQQbg==
=0l3+
-----END PGP SIGNATURE-----

--6SJAvmLG8+E8QRmv--
