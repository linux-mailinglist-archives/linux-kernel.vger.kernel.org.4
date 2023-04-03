Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083336D501B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjDCSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjDCSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C922D40;
        Mon,  3 Apr 2023 11:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D1DA62474;
        Mon,  3 Apr 2023 18:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A47EC4339B;
        Mon,  3 Apr 2023 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680545653;
        bh=dZxhtfWNZthe6C4xSPneZtKMKl2XLrfONcmPfYXK2jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZstyKQH0+x8/mU9b3+M59+yT3SblfTJS/FVkhjxHos8YUryMzPUtFsi8nSJ4T3Zv
         +ep2vLyEI98IrmpcyD6Eru2ott753MJDrXx5qtq2b2gP40+2H4LHrSAiI2sxs0DqfN
         ZEIMgcYQR65Xrs0LocD744pzfk+sIq6ymQyM6OBOIGaZ/z9Z4y4edcGAiDeMumbE/i
         Ox1QX+bx7l7WJlhGqnvJC+WIxAw8indMjTb3w4tbW70snSUM0sG2MKccdlfvRmJ8po
         OpiWE1hgFtBNmQ00BcRSyyu5w9c6zB8eoKuCa54h5I0uc5XtEMLRPKQVtQeeAgHwlk
         O4POQ7nF5cm5g==
Date:   Mon, 3 Apr 2023 19:14:04 +0100
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
Message-ID: <8c513ddc-435e-40ce-b1f8-84eaf8241ed4@sirena.org.uk>
References: <751e5129-3c11-0156-719e-3fe996a149be@quicinc.com>
 <3f434777-c4b6-272f-1971-f9adf3faefe4@linaro.org>
 <a54d4e1b-d62d-559d-1882-e460e696c056@quicinc.com>
 <ca12735e-d6c8-997e-036f-693cd8a9870f@linaro.org>
 <e19393e3-5898-bff2-cc00-d88c9194c7c2@quicinc.com>
 <6e1f6466-7f2e-7bd5-f6a2-5691a30c4e1f@linaro.org>
 <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
 <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
 <5914a8db-3644-1c94-00ba-460ba2c26a5d@quicinc.com>
 <3c5a9608-ecd2-a3c0-e866-7d0070e49b89@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+3527FmE72Bif88B"
Content-Disposition: inline
In-Reply-To: <3c5a9608-ecd2-a3c0-e866-7d0070e49b89@linaro.org>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+3527FmE72Bif88B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 07:53:48PM +0200, Konrad Dybcio wrote:
> On 3.04.2023 16:07, Devi Priya wrote:

> > But, when the regulator driver comes up, it tries to bring up the
> > regulators to the minimum supported voltage provided with the
> > regulator-min-microvolt property in the DT.

> Right, that exists..=20

> Mark, do you think it should be updated such that the requests are
> aggregated before assuming min_uV is "just fine"?

We can't tell if any consumers are ever going to appear, and the
regulator having a voltage outside of the constraints is an urgent
problem we need to fix quickly.  Since we try to bring the voltage to
the nearest end of the constraint the driver could always change the
bogus voltage it reports to one that is excessively high, this would
mean the core will try to bring the voltage down to the maximum rather
than up to the minimum.  The driver could also look at the constraints
when guessing at the hardware configuration rather than claiming an out
of spec voltage, this would mean we wouldn't need to correct anything.

--+3527FmE72Bif88B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrF2wACgkQJNaLcl1U
h9DUkgf5AeX2hkEfb36b/p7jPZcbfRZXttviLT2LkmjynPWAK8PRiewZ0XNVv4An
E51IGruDP7nB2ArHnrhCwICAU0r4r6TRSaY3S6xgxhdCZqi+1VHIKhLTYDNHD9/d
TmCnsqxzC0c3cj9OB8couC3BgfGXOp0pGMuZLzeYlCG+trEbwBu2HnqBGx5L6zBV
n6jUvhhazcyrVfYaxdDBzxHUM/CPiIY5ez7jEcD4PLXEvlSZFDmE5AZTs28HAZTx
b5qtdfIrV4D5JYNfU90pg5JB2kcN3Uc1iYuFX7Y40hD778/gG+9xHi3jsGt2L06/
Vn3MCOS4ssu5v19tKmFquxaxpVcZSA==
=0SE9
-----END PGP SIGNATURE-----

--+3527FmE72Bif88B--
