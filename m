Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A16D5F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjDDLl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjDDLl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77BD8;
        Tue,  4 Apr 2023 04:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82AB63286;
        Tue,  4 Apr 2023 11:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB21C433EF;
        Tue,  4 Apr 2023 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680608485;
        bh=LActs9cB9p0LQYEk8rDW9gaV5d6wDeHIvJjBxEW4Z9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KetfXc+CtxS3y+yBADDAT3q6MNhLMzEghU47hmbcUaKZIdblmbGA/DjkZArBws7D8
         zM92aPI79ajJWYSUh2ithE/sjFtwsMVmZJH4po7yQIs0HcgUXB0Qoy9s/cqD5Em0mI
         53HXpIKvQ+VuswMGWoNfTdSZtR6zeIA90TqTDZM6ZS2wKaZwKKnGulm+Tym4HtEDHE
         d2a/dxuLzjCd36MWbpSIBPd43SBwhnyma1I8rB9yyRdvMLDTYl2npgWkFENIr+jsT+
         Muo+OqfEeLqAiz2V0YgL99aPcpKXAN3ilN3OyOFQSWagg/eK4VSrZ/HDcXopoMxCkS
         OZPJG1jDspUKg==
Date:   Tue, 4 Apr 2023 12:41:19 +0100
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
Message-ID: <aca77fe7-5fed-4ba1-ab28-8b66281224d2@sirena.org.uk>
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
 <CGME20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9@epcas2p1.samsung.com>
 <20230404060011.108561-2-jaewon02.kim@samsung.com>
 <a4a9d1d1-c5cd-460e-96e0-6db8048518c6@sirena.org.uk>
 <4b652b3c-20e1-1d87-1ee3-3aab43507100@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qTiTBPXDz7t7Bp9O"
Content-Disposition: inline
In-Reply-To: <4b652b3c-20e1-1d87-1ee3-3aab43507100@samsung.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qTiTBPXDz7t7Bp9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 08:17:13PM +0900, Jaewon Kim wrote:
> On 23. 4. 4. 19:54, Mark Brown wrote:
> > On Tue, Apr 04, 2023 at 03:00:09PM +0900, Jaewon Kim wrote:

> >> This patch adds new 'samsung,spi-polling' property to support polling mode.
> >> In some environments, polling mode is required even if DMA is supported.
> >> Changed it to support not only with quick but also optinally with
> >> devicetree.

> > Why would this be required if we can use DMA?  If this is a performance
> > optimisation for small messages the driver should just work out when to
> > choose PIO over DMA like other drivers do.  It is hard to see this as a
> > hardware property which should be configured via DT.

> We are providing a VM environment in which several Guest OSs are running.
> If Host OS has DMA, GuestOS should use SPI as polling mode.

This sounds like some sort of virtualised environment with passthrough?
If that's the case then the host OS will be in control of the device
tree provided to the guest so it simply shouldn't be describing the DMA
configuration if it doesn't want the guest to use DMA for some reason.
There's no value in describing the DMA the guest shouldn't use then
providing an additional property telling the guest not to pay attention
to the DMA when we could simply not do the first step.

--qTiTBPXDz7t7Bp9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsDN4ACgkQJNaLcl1U
h9C3KAf8DV4SXi2OjERrSCUUpD1ubMl2HYYT7sakdZVKmhuWQGTJTflIZrYSvRZa
ay7Kj0GfvKczDNDmj0YFQXUc1XO2t6lvCwG6fOGAyLK/2yXk2hLuCxkQOSS0q+gr
2Rc79LUas5oAAPZtdJm9dSfqoJunAtG8367ZGGrAtDlf4NeQqOkudgVBoXw+mFV/
4HCt0xk63edTgijrBS0ZKSBTvj2tjjWcww0HdF9rmuP020iBJ0rD91D3lXP/oKhk
CNWHiFFM6KVADYL7O0Wk646L/4BC8AE9POkZXzns4d1hVHWVyIwz9gSEZpMZ764F
ZgiLCU5fVdfqj9AR2V2m/kU/MorzUw==
=lg0g
-----END PGP SIGNATURE-----

--qTiTBPXDz7t7Bp9O--
