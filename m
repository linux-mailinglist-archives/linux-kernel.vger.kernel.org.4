Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129897465ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGCW76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCW75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091CE59;
        Mon,  3 Jul 2023 15:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46D7B61077;
        Mon,  3 Jul 2023 22:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD04C433C7;
        Mon,  3 Jul 2023 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688425195;
        bh=n19GJPDF+RLlje7pvmLVRX0hBah4pwQ3Uw2aRRWrRZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q41tQHm/ucNfOIL/xk4eormseBx/XoFSNQ/sBCLP9p8bRKBXLlTMeDv2C9WxNYU2A
         ag6MWrItzRfy4o74hBPcXL1c44UI7AvO8OUhFYQm7aqKuhffuPPB4lLzASpkf8/yOb
         ATknLkheeSaDMtb3KwACZcqXtpdPhmJEU+aFbflVlr3QwN1nIZNyoGz0hY7K6+F11P
         HLwnAn2acqoPTB6pjQbXL46BF+GCYDqJhfXz7/NSn1YDYFQKI2Hlz9Wt6vE5LesJNI
         pMK/H4L3wWGuQPJ6I/KK45Ea3lLYiUz1PJOAChsfqSTYhzfP9x+vkDvrSCBsXSNgLr
         7hu39ueiZOINQ==
Date:   Mon, 3 Jul 2023 23:59:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Qualcomm REFGEN regulator
Message-ID: <b93cb054-fd42-46e5-aef3-dc41b36a85f9@sirena.org.uk>
References: <20230628-topic-refgen-v3-0-9fbf0e605d23@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k23AuSsl7zkPANaU"
Content-Disposition: inline
In-Reply-To: <20230628-topic-refgen-v3-0-9fbf0e605d23@linaro.org>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k23AuSsl7zkPANaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 08:15:53PM +0200, Konrad Dybcio wrote:

> Recent Qualcomm SoCs have a REFGEN (reference voltage generator) regulator
> responsible for providing a reference voltage to some on-SoC IPs (like DSI
> or PHYs). It can be turned off when unused to save power.
>=20
> This series introduces the driver for it and lets the DSI driver
> consume it.

What's the expected plan for merging this - should I be applying the DRM
patch?

--k23AuSsl7zkPANaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSjUuIACgkQJNaLcl1U
h9C0igf/WJJjbSuyFnIa0QzDmk6VH8wPFNOpi/ZVp1QcD4+1z709iGwd35JHzOu4
PvcjIxjBozoxzdVo7NpW0bxnwlZl/3e+3tAOIjpHp9odr49UTBZGcu9gwenlzIp4
11xZldpE7ka90Pq5grV11HF6wtzBvXtNqpG8Md4LfW0+WhhDTmayfNIjXgnbNrar
9y0IPQj460708CQ2rWcG9KKoBLnyT7K+/WKKwwekESMIY7i0JCA8WojeJmccyWCd
wuKNBHyVRv9STOoP4hw7mEOHnaKvcT6FyavOBAlTcvKzMLKmEqi1WacuoSqM0xzl
wrH1dj9NrcRO/Ih3DFwskbtMoc3YPQ==
=wbYK
-----END PGP SIGNATURE-----

--k23AuSsl7zkPANaU--
