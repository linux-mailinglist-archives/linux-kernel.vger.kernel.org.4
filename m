Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF10764B56E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiLMMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiLMMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:47:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CB21008;
        Tue, 13 Dec 2022 04:47:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6BA8B811B9;
        Tue, 13 Dec 2022 12:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A4C433EF;
        Tue, 13 Dec 2022 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670935660;
        bh=C0kWfzBMeUnkMCqjJc8AA1etPAtrgwywD/A/JsLxtAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUa9dHjgNMtaO5Rte1RyIlkjg7PjS9qLM5wvmaPtlIm1i+M9BtZ2oLTLpADlhDu3o
         x1m2S4yg9KCU9g/fw7NRbXQjMa0ezQBmBpZfj9x9GIjN2oGNqXIYNFRS7/VW/K9gJR
         r7+ipzGE9olQsN3hF39wOKbfLDJI6d3MFKIfCMh9AZjM5RPWhXW9mm2JpICki85o2f
         iQ52HZAkGfoQnBgWsoKGf5uX809LMyrMCQWivN2P21DRritJ6ctRyYTKZ5wTtsDxPR
         Yf+LYN33DOt5nLomrpDTGVVFV3tfp4KdO1fxgFVyI0ikrgItl2w+JXPTU+2KPpk9MA
         J/osE4R5HaU8Q==
Date:   Tue, 13 Dec 2022 12:47:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com, linux-spi@vger.kernel.org,
        Javier Martinez Canillas <fmartine@redhat.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Message-ID: <Y5h0ZiGaPg2tx0qs@sirena.org.uk>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
 <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
 <Y5hvlX35nr8xQKEd@x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyNsimEDc1OgCcyo"
Content-Disposition: inline
In-Reply-To: <Y5hvlX35nr8xQKEd@x1>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wyNsimEDc1OgCcyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 07:27:01AM -0500, Brian Masney wrote:

> We can't add a generic qcom,spidev compatible to the spidev driver since
> this is just a software abstraction. Instead, each type of device will
> need to have it's own compatible that uniquely describes the type of
> device. So you might have a compatible like qcom,spi-video-codec. There
> will need to be a DT binding added that describes the hardware. I suspect
> that a SPI device can simply be added to trivial-devices.yaml. Once the
> DT binding is accepted, the compatible can be added to the spidev.c
> driver. If an in-kernel driver is written in the future, then the=20
> compatible can be moved from spidev to the new driver.

> Mark: Is my understanding above correct? If so, will it be a problem to
> get a compatible added to spidev.c if the corresponding userspace code is
> closed source and proprietary?

No restriction on what the userspace is.

--wyNsimEDc1OgCcyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYdGUACgkQJNaLcl1U
h9CzHwf+JP5CRJsjmYyyOlQmaCl1IOkTdl4br1Sd0Op4ooGVbIFEieXnBYfuUNon
mPjbGv0f9Pn24dLxRMprh//Yh+Fv40ri4NEAVxq9OyShVcpg69lqzBdVlU8aGgds
ljdMeZk7F3SqvHDKMzmL/cWho+aEh8ANg103ipEEq9nEYZZMXcyCLzPExqWcGw/3
9djKGOGHrBl0b7LiCrQhQkbBh2I20mPKxGInjDdpyM0ck9AtFvhEsnii9DS7/Xsv
DRPUvphwzRjpZBNLMXAaDJNcPQcJFh98VCm32/nBVHyT18bNHWo1aQzNAqoIqNqV
FtASMiphe8tykKruLxRsrCwQOT9yJQ==
=TKvN
-----END PGP SIGNATURE-----

--wyNsimEDc1OgCcyo--
