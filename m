Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2E63FB0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiLAW5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiLAW5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACFC7240;
        Thu,  1 Dec 2022 14:57:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8719262169;
        Thu,  1 Dec 2022 22:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E94AC433C1;
        Thu,  1 Dec 2022 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669935450;
        bh=TBfuELpSzb+mNB+KGhsJR1KS+PLQ2psvSjnArr0l67U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTxVOKu12kBYKDZa/QZJxEWsTveLDaAK2keHquTWLXJyk+85s9/sm/SSbYFjDDWpi
         xUxavKGimMWhzyRtUxJlv3GMRrcRUVFpEoO7uVMqhneExCCGM9e5kM9WsMT891ryjN
         MMpD2Be8s3pqjQPUX0vq40pbDrTBfSt/Z9/x8OFkr7Yz+2B+DfJli4T1PPRaMnAt3d
         Dfs2jAswQabKi3v3bRgqB5/aj0Br1Dm+Yb6iWNpr2JEwJtgbZCl4VcFlozz8tSRXov
         I3uiQP1MHBPlSHJ3tTxuq0IwAckjcbj/dIBLu3Ewzr/fwN1crH6wlSb5HT41/KRbOK
         nKxtIEx1yqpYg==
Date:   Thu, 1 Dec 2022 22:57:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com,
        vkoul@kernel.org
Subject: Re: [V3] spi: spi-geni-qcom: Add support for SE DMA mode
Message-ID: <Y4kxVP97C66oi0Bi@sirena.org.uk>
References: <1669713814-28876-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=WW-YttMn2+_6MdKwVDQO2stHjiisSdX8vFoOFBMnsjRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MCfNU2/ldKjB0tuT"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WW-YttMn2+_6MdKwVDQO2stHjiisSdX8vFoOFBMnsjRA@mail.gmail.com>
X-Cookie: Leveraging always beats prototyping.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MCfNU2/ldKjB0tuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 01, 2022 at 02:40:32PM -0800, Doug Anderson wrote:
> On Tue, Nov 29, 2022 at 1:23 AM Vijaya Krishna Nivarthi
> >
> > +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
> > +               if (m_cmd & SPI_RX_ONLY) {
> > +                       ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
> > +                               xfer->len, &xfer->rx_dma);

> In response to v1 I asked if it's really OK to use "xfer->rx_dma" for
> your purposes since it's supposed to be managed by the SPI framework.

> It still makes me nervous to use it, even though it seems to work.
> Since we're using it in an undocumented way, I'd be nervous that the
> SPI framework might change what it's doing and break us in the future.

I'm a bit nervous too - why exactly are we doing the open coding here?

--MCfNU2/ldKjB0tuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOJMVMACgkQJNaLcl1U
h9Dtkwf/dQzK7cnApqI9SmkAIOQ5X0plaNHltBhmjGmnnGvfP9HGSZ7IJ8JfPn+/
KNsxtOLIdjGqCwYdxT9bt5E+UbJ2yjdiObxXRyTHbAWm0K80x3J1FmizLtUUjkpV
7pHystlQj4LEOdAcLGygnHPYGLsyipEvsLnykheTgAm048f5aDneB4DDF14jlYPA
3Y1RXKpDJwCZUpOBHHj0oex4PBl1h1z9iqGQA/e9YRStRJWCNWgZHMdvRZ+bAORA
/vuYYUM4BGpJJQc0nnl5zRHTXGnTo8hxM1tytIMWE2Iu5WtjV9rze3AknVFOiudS
3O5lWJN1Rv8dLrqlpXuWwl7dEGQyJw==
=XeYp
-----END PGP SIGNATURE-----

--MCfNU2/ldKjB0tuT--
