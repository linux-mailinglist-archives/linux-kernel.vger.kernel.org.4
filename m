Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D96B3FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCJM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCJM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:56:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AB77DD16;
        Fri, 10 Mar 2023 04:56:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78FAA60C81;
        Fri, 10 Mar 2023 12:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7080EC4339B;
        Fri, 10 Mar 2023 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678452967;
        bh=jPMaeC9AwdVfx8liXNLn9Ay2rJrAk5t8HQx3UJJMzzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZLnRnoAj+SbTetcE+2ApW375KsjVBqhO5X7BR6EpS4NdkIlWOEwKfl69xtzLxrG3
         i/7JsD0jCHdaLJVAUru6EwDuiP1p25hgd2nPeooph0Wia9XOecqXMf+qLq9zttXXBC
         w9DaCo8Cb9Xjx89js+v0Kk+qJNRCYUaJqGqREv8NYBs5umopFb8HnnP+w0leC1KXxc
         BRpvSw4duE8T0HLLKB/pn8h8rP2T2cbzK5joxdWjDGGcs20d4V4SsNaYyVFEtNfU5x
         /1N4z5YToyPV31zbHpUGjv0yBh9AWeQqFRJU57GbibrRtP3fRRvAZF40dniidKvD3/
         NiU8K6yx7fTzQ==
Date:   Fri, 10 Mar 2023 12:56:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZAso695fdT3ngjqf@sirena.org.uk>
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-3-zhuyinbo@loongson.cn>
 <1f0c2592-4433-47cb-9b73-d345e157dbf2@sirena.org.uk>
 <fb502e11-a12f-58ca-4171-edec55b71fa5@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y6RAIHyXin5w4R1a"
Content-Disposition: inline
In-Reply-To: <fb502e11-a12f-58ca-4171-edec55b71fa5@loongson.cn>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y6RAIHyXin5w4R1a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 06:01:23PM +0800, zhuyinbo wrote:
> =E5=9C=A8 2023/3/8 =E4=B8=8B=E5=8D=8811:03, Mark Brown =E5=86=99=E9=81=93:
> > On Wed, Mar 08, 2023 at 10:59:08AM +0800, Yinbo Zhu wrote:

> > > +	hz  =3D t ? t->speed_hz : spi->max_speed_hz;

> > Please write normal conditional statements so that things are legible,
> > though in this case the core will ensure that there's a speed_hz in
> > every transfer so there's no need for any of the logic around ensuring
> > it's set.

> Do you mean to achieve the following ?=C2=A0 and drop spi->max_speed_hz.

> if (t)
>=20
> =C2=A0=C2=A0=C2=A0 =C2=A0 hz =3D t->speed_hz;

Yes.

> > > +	loongson_spi_update_state(loongson_spi, spi, NULL);
> > > +	loongson_spi_set_cs(loongson_spi, spi, 1);

> > Note that setup() needs to be able to run for one device while there are
> > transfers for other devices on the same controller active.

> okay, I will add a spin_lock for it.

We also need to take care not to change the hardware
configuration for the currently running transfer (can't
remember if that's an issue here or not, but it's a common
one).

--Y6RAIHyXin5w4R1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQLKOcACgkQJNaLcl1U
h9CLKAf/Q9FDdX8dTJxMWq/G1/CWXeHieDV6WDHZDv+dTLGszVLvim+aM8FPnH+/
a/70yPXsVd6Yhz/E68Xr4CUIk8Z/1TinpwByHROAeTVHtFy/YDsQTukTdOERhHW5
8PwUdCc5+vWjzVc6Bt3TBfqrDMre3vJyilAoksCMc4ztD7n0Sf5OrymHoHBzzDXn
9kNu9nEBTm+hvGIFnbXOmZ+vHpRqUBZhQA1sXLpP//igfU1dKFO0ZnJWbTRA60Fy
XN/RtGaApwdjybtfQTYWoTRwODyF9Godt0XMIoKeiWQ+g3O94SHNzT9Z88rGLPB6
nws9Qb5xO9EHlRdHWGc+r+0/Iql2KA==
=8uAc
-----END PGP SIGNATURE-----

--Y6RAIHyXin5w4R1a--
