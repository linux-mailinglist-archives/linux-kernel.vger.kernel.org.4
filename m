Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0A6D6113
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjDDMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjDDMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EF170C;
        Tue,  4 Apr 2023 05:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1B76186D;
        Tue,  4 Apr 2023 12:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC6C433D2;
        Tue,  4 Apr 2023 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680612069;
        bh=rw4qIC7uCyYCBqc1et6NhrlK94J+qMpfhpHt/7eZvDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGY/G4T/xZC6RSK4Z6NIfVwbo9GAvd0aSRgemY1jwU3aZq5E2bKUF74v+ieI0uLNk
         vwiIh06ul9gL+YBT8JI4l/8CrpngEPoDc9MmWWwb77S0e/2LXF2mDg+Do7XvqcRK2L
         fMEFkq68o61uTZ8gJtAYq8JJEh0GzO1GvMf20tynmifyd7MC2sXkGizzp6/ZRXR7PX
         n3JK8dnFNEeQoyclwv6f0n0hAAjy00a8Tsj3PNz4s/vq3xU1ARHPAijeJzpTuLMgWj
         LM4BPyApgLNvPuVNPAvyr+a1/ensZnR1zpjRAEAsmMV/gduTQ2jN0Gaz9aWZqZHW/x
         f15LBQuDJM/Yw==
Date:   Tue, 4 Apr 2023 13:41:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 1/3] spi: s3c64xx: support spi polling mode using
 devicetree
Message-ID: <c564b03a-970c-49b8-b5b6-ba1bff767f79@sirena.org.uk>
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
 <CGME20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9@epcas2p1.samsung.com>
 <20230404060011.108561-2-jaewon02.kim@samsung.com>
 <a4a9d1d1-c5cd-460e-96e0-6db8048518c6@sirena.org.uk>
 <4b652b3c-20e1-1d87-1ee3-3aab43507100@samsung.com>
 <aca77fe7-5fed-4ba1-ab28-8b66281224d2@sirena.org.uk>
 <c227cbce-8b2d-41d7-122c-f271f8396349@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZAwT+g2SqJn0iERz"
Content-Disposition: inline
In-Reply-To: <c227cbce-8b2d-41d7-122c-f271f8396349@samsung.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZAwT+g2SqJn0iERz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 09:22:25PM +0900, Jaewon Kim wrote:
> On 23. 4. 4. 20:41, Mark Brown wrote:

> > There's no value in describing the DMA the guest shouldn't use then
> > providing an additional property telling the guest not to pay attention
> > to the DMA when we could simply not do the first step.

> Is it correct in your opinion to change to polling mode if there is no=20
> DMA describing in DeviceTree?

Yes, exactly.

> Currently, if there is no DMA, the probe failed in s3c64xx driver.
> So I added the "samsung,spi-polling" property not to check DMA.

> If your opinion is to switch to Polling mode if there is no DMA, I will=
=20
> fix it in the next version.

Great, that sounds like a better solution.  If there is a description of
DMA but it can't be fetched then an error should be right, but if
there's just no DMA described then switching to polling mode seems
better.

--ZAwT+g2SqJn0iERz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsGt4ACgkQJNaLcl1U
h9A0xwf+LXon+Ytjh6xYW1t9VB+LJ9cWsO3ZSg+HdYsbw6+eUUlH4tKe72l5tOEN
6VREtMU8nBpV+hzQ3hCYj1DicaNSEFE3CSsGpjcnBVbSN+9wxppR1A+M9QOIvBhv
HY1gTtlCuYfjO0/eK6BJDaQxmVJNizYG2br00ZC/7sfSMj443Hw7FOsPP7fhVju3
v41flAorHWvztLR7GQgVhomTps/euPjTAeghcEstxuzI7uwg3HwbAF17ZRWOmfU/
dHfo+gqJETqnr0G7y6z+f52Qk398YxotyAZgijb9K6ELZtoCXpOdgbC2kPwmod6+
VKmKZ/jVNE9H317FFVCkcbiVrFFtZw==
=0Sj3
-----END PGP SIGNATURE-----

--ZAwT+g2SqJn0iERz--
