Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C866D504F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDCS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjDCS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59261AD;
        Mon,  3 Apr 2023 11:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8181B61849;
        Mon,  3 Apr 2023 18:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828C4C433D2;
        Mon,  3 Apr 2023 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546504;
        bh=lXVuRDL3OOhM/7oo7YuhjrICNT7KyEsvlL2vir4NKoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RoTi57o9UoUkogq8ICPwNO4zH+5q8or3+UFEpbEhbu16062MsHxnOdQ2x8b1JxICb
         4Kz7264DwAaWTX3yyP399WaCG8PGcuZjgMpqbIdFOdQ9FRmQFL1XzB+KkptLCMo+mK
         2RY3nkzZO6rT1X9EN48iavRDb3kjAlRMZRgUyMSvawJSDsgA604x0VxAzkgxpK1uab
         WQN14Fdtrzyi7Rdxcb3e0IKiw6UsWks6M/BJounEsmW8KJHeStwfhuk726CcV/ixzG
         WXqwKeX2580FT1HB3b21nVHq+fZ4J+Jiue9g/YY6wSETD00UwA2nBk6i1TAB2TdN1b
         L+n8kSTEWMpGA==
Date:   Mon, 3 Apr 2023 19:28:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Message-ID: <a657284f-a408-48a8-b294-0add65b3e2a2@sirena.org.uk>
References: <a54d4e1b-d62d-559d-1882-e460e696c056@quicinc.com>
 <ca12735e-d6c8-997e-036f-693cd8a9870f@linaro.org>
 <e19393e3-5898-bff2-cc00-d88c9194c7c2@quicinc.com>
 <6e1f6466-7f2e-7bd5-f6a2-5691a30c4e1f@linaro.org>
 <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
 <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
 <5914a8db-3644-1c94-00ba-460ba2c26a5d@quicinc.com>
 <3c5a9608-ecd2-a3c0-e866-7d0070e49b89@linaro.org>
 <8c513ddc-435e-40ce-b1f8-84eaf8241ed4@sirena.org.uk>
 <fe4dd395-cd1d-55e8-1be9-f588f69a8b13@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eJO3awvhoD6CB9ap"
Content-Disposition: inline
In-Reply-To: <fe4dd395-cd1d-55e8-1be9-f588f69a8b13@linaro.org>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eJO3awvhoD6CB9ap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 08:21:25PM +0200, Konrad Dybcio wrote:
> On 3.04.2023 20:14, Mark Brown wrote:

> > than up to the minimum.  The driver could also look at the constraints
> > when guessing at the hardware configuration rather than claiming an out
> > of spec voltage, this would mean we wouldn't need to correct anything.

> Hm, all of what you said sounds like a valid concern.. And then we
> probably shouldn't shoot up to max by default, as going too low is
> not going to cause as much potential irreversible damage as going
> too high.. Especially with programmer error..

It sounds like the driver should just be reporting a value which is at
least within the constraints.

> Too bad Qualcomm's firmware architecture doesn't allow for reading
> back the voltage..

Right, their interfaces here have some serious drawbacks.

--eJO3awvhoD6CB9ap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrGsAACgkQJNaLcl1U
h9Brzgf/fHXT5Kvi+p/X1tFyM8ue/cFz1bfRsZhhHC3QWHYVy42iBGd89Om++a18
sXyeCOE007CEnQ/sf4VmRsHd3kqJngCeBFep6aEhN6A63epUDXCZVjN/WQtJwNzH
8oM3mmYdndld/BdpG4A61FOlUInvxD3Dq7/I+RyUm6CFF8VFowhzw19UU6zfKwNF
7a65sQqgdXurpz9hDBZ0r5sB6gLb810Y9E2D/RcyvmrmwvFbv/ZlbbTUjqDf8Trc
N8znzhC+ZfBRiDt/9YBx2wxLrV7UhCt2NP7RS9KP5hKfedc1e3dBomXE8rArDM0F
HpJ4JUhGggNDNkTFs2gjAGJcJdtrhA==
=RhOj
-----END PGP SIGNATURE-----

--eJO3awvhoD6CB9ap--
