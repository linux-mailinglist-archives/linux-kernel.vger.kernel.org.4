Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820EA7020FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjEOBMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEOBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA510E9;
        Sun, 14 May 2023 18:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4E261008;
        Mon, 15 May 2023 01:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFBDC433EF;
        Mon, 15 May 2023 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684113148;
        bh=f5Xlg+QbTFg0pici3vAmn0EcoPyOE5nAD8GQAZUAmjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LN94eJqOgHGhjfficjWr9zHQ2cTpdsgWxL0Gp1snEhI+qjQ9ffBAjSVlDWg5QDPUd
         Bpk/cL4Om2VRqYMerfc/a1qqb0WIpnD/0UewsLIOrwF3yBFshvVMp0Poqp5PcCAecM
         LWSKuM8H/oz0RBKclz9Rk2AMARTxKZ+EsuLcbErof6EV9QdT6wOX+3bdmtvTSt75+V
         tkcDqfiwodiQggi0yqUaiY2sOrf0cNrkSn3itarMFie9iy8LlSueQZvDVX24m6l7TC
         cE3jBLGb0RyQ19GSLKkUav51DTIOU04KM0BKL2HvXFGq8Hcir/pgWPQu+yHrw5q35a
         VX+zIgRMgajRQ==
Date:   Mon, 15 May 2023 10:12:24 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Message-ID: <ZGGG+APx1/G5IrgL@finisterre.sirena.org.uk>
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOzonUtVZwvU79d7"
Content-Disposition: inline
In-Reply-To: <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOzonUtVZwvU79d7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 13, 2023 at 11:38:22PM +0530, Amit Pundir wrote:

> Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> running AOSP (Android Open Source Project) with v6.4-rc1
> https://bugs.linaro.org/show_bug.cgi?id=5975.
> Can we please go back to synchronous probe.

Please submit a patch...

--vOzonUtVZwvU79d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRhhvgACgkQJNaLcl1U
h9BfEQf/SthD1BTRGduOYD7Q637Ki3vpiR2eq8leJIGRtvmY4LbWCG4zDkC/Eo59
xzyT++Pa5HLRZo+WxPGTCZmDzSB3qb0ut3LWKHfA69mupx4+IqzE11a3LEKVqUsb
kUThU0Es/Zd/x/ZyKTZpJiommWXfXQb/XZ98PGkaTPiz9bD6FZZebEMrMLVb1C4r
2/fH2Sebnz2C1TPacdJWW24rgMD+riu3FUwmVNa93dWpeIckUuvWsUypwgxPGji5
NiN5B+3hYKEEOcbvf4dxjwHJwICHwGfXkKs3Q/To1gupxp9hjd6+5xI/ZINQK3FO
6LhisrNhXeqVHa3PnOKn43bDJ7LM9g==
=2Xlk
-----END PGP SIGNATURE-----

--vOzonUtVZwvU79d7--
