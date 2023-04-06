Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA16D9C48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbjDFP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDFP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04099E61;
        Thu,  6 Apr 2023 08:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C545647DF;
        Thu,  6 Apr 2023 15:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72296C433EF;
        Thu,  6 Apr 2023 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680794914;
        bh=jw9QDNpzIUYXB+9TakAdXq9GVBcm2ix7VND/CemLEy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTPLish9joEfAk9+CCA/5O/JHM4jCNpuIpQR1oVHz1ViiLF+KxhBNXU8TNlXSkca1
         1YrmxjOJ9KTZYQHBAicx8rXHq6CLcwk4KmZphs2ldA0q+02mB1Y9xsi0RWSQwNJRZc
         P/YDszwqvmO+liPpm1DQrU+1HN5FS4d3i9NLgi6+QD4914OhStpt5EWLRNFXVwn5nT
         aycLztlLYZHq3NOWdwC8wCxGV0gd3eSISP9GH+ImQps3xQderzBQx7bK9JM9/Pr10t
         YI+CaYhW9K6T/B/BoRBTxcS1W8KFdEQeKjzZNiWxIlxhJBcv2Oom+8+WyDis8w/7df
         k/grSMm4nBVEw==
Date:   Thu, 6 Apr 2023 16:28:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <92690348-21c3-45de-bdb1-d0977b859702@sirena.org.uk>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
 <d784dab7-a1a6-4db7-aa13-e39e9904f342@sirena.org.uk>
 <0b182a36-0254-6720-4a35-f9e617c12797@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zYcIuw0bOKg30pT2"
Content-Disposition: inline
In-Reply-To: <0b182a36-0254-6720-4a35-f9e617c12797@quicinc.com>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYcIuw0bOKg30pT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2023 at 08:23:21PM +0530, Vijaya Krishna Nivarthi wrote:
> On 4/4/2023 11:47 PM, Mark Brown wrote:
> > On Tue, Apr 04, 2023 at 11:33:20PM +0530, Vijaya Krishna Nivarthi wrote:

> > > +	uint32_t reserved2:7;
> > > +	uint32_t length:16;
> > > +	//------------------------//

> > What does this mean?

> That separates the part of cmd_desc that is visible to the HW and the part
> that is required by the SW after xfer is complete.
> I can add a comment in v2?

Yes, please.

> > > +	for (ii = 0; ii < sgt->nents; ii++)
> > > +		sg_total_len += sg_dma_len(sgt->sgl + ii);
> > Why are we calling the iterator ii here?

> Calling it ii helps in finding iterator more easily in code.

> should I stick to i in v2?

Given that multiple people queried this...

> > > +	if (ctrl->xfer.dir == QSPI_READ)
> > > +		byte_ptr = (uint8_t *)xfer->rx_buf;
> > > +	else
> > > +		byte_ptr = (uint8_t *)xfer->tx_buf;

> > If we need to cast to or from void * there's some sort of problem.

> the tx_buf is a const void*

> in v2 I will cast for tx_buf only?

Or just keep byte_ptr as const - we're not modifying it are we?

> > > +#if NO_TX_DATA_DELAY_FOR_DMA
> > > +		mstr_cfg &= ~(TX_DATA_OE_DELAY_MSK | TX_DATA_DELAY_MSK);
> > > +#endif

> > Why would we add extra delays if we don't need them, might someone set
> > this and if so when?

> I believe its used when some slave devices need a delay between clock and
> data.

> Its configured as 1 for PIO_MODE(FIFO) right now.

> For DMA_MODE we are not using same, both seem to work for DMA.

If some devices need this to be configured it needs to be configured
either from the driver for that device or via DT depending on the exact
requirements.

--zYcIuw0bOKg30pT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQu5RoACgkQJNaLcl1U
h9A2Wwf7BdgiPpI1nqHATQUbOCXG1wEA33/yRFJIYrDDrS9X/qxM8mjv67vm0aDY
QKBjEGMftTCIqiZrDffi2CM3F4EW/xcP/JPs28pSAvtyvRUsnV9uu0Y2/SFJGBrc
XcZTRofs4b7k4pyqYjgYc/HGGskigoHjQzOAqwIEHGET6ijey7Xtek1jhZJbd2X2
h41M3eoh/zbrq+TPylPgGuDHR0UpsFKeJr3aRho0y2SaDcRDcRX88U9n0ITaPzDK
SDZr73Z0IxFV06aJF75tkQ7+XnmflXgxnDY374rw7g9WdbOQr/HNOup5VOeBhBAG
rJ/Ia5knt+Zqdud8qUBikIeVSRN1sQ==
=R5Mx
-----END PGP SIGNATURE-----

--zYcIuw0bOKg30pT2--
