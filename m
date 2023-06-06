Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE1724843
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbjFFPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjFFPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192D10D2;
        Tue,  6 Jun 2023 08:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D47661323;
        Tue,  6 Jun 2023 15:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074CEC433EF;
        Tue,  6 Jun 2023 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686066825;
        bh=PcAvLu57+uPUyhNIbnTyWjEN30qr9EKto+KBv+2pxKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efPBv2fpEdY/h4jXsv61647g0ZfryKfikn7qwuUEjMRvw5Regxy3iTZ2gfpn8GN4+
         ncvHlHCEds4sqVys46nBRzZz/tQMQOdJWbh8oq9T97FvXbrlgUfOKaOelG81uywXaB
         tUK2MYQ0JwdeZnaKvSs1GemHPhJPB2yoIVCR7fyXDxh0ybLiUGzyCVai7MJr/m8Mwt
         cdEsb0ZDV8iIXJcgwnffFTkYIQg2fZi4vilpSJ8IR8EKWpFWx3qUMJkCiUeBKj1/5H
         KBFEVyYyGZLDhBjcQv0VroEBRBfiDbEvWp9mW0rnOiSl4FP2Zp3ArB/E/7W4gGRoaW
         7DQhbflGeLlHw==
Date:   Tue, 6 Jun 2023 16:53:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com,
        quic_ptalari@quicinc.com
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Add interfaces
 geni_se_tx_init_dma() and geni_se_rx_init_dma()
Message-ID: <9dd8ac78-984e-4588-9a45-0ceb3c51845c@sirena.org.uk>
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
 <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=Xbx9h3B1u5NcK7XeEKWC30pn=AWYToqYbAs+oNrV+7Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oIxXRhOs3lXBAO+h"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xbx9h3B1u5NcK7XeEKWC30pn=AWYToqYbAs+oNrV+7Ww@mail.gmail.com>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oIxXRhOs3lXBAO+h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 07:18:17AM -0700, Doug Anderson wrote:
> On Wed, May 17, 2023 at 5:18=E2=80=AFAM Vijaya Krishna Nivarthi

> > The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
> > initiating DMA transfers. This is not suitable for spi where framework
> > is expected to handle map/unmap.

> Mark and Bjorn will have to coordinate how they want to land this,
> since normally patch #1 would go through the Qualcomm tree and patch
> #2 through the SPI tree. In any case:

Bjorn?

--oIxXRhOs3lXBAO+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/VoIACgkQJNaLcl1U
h9DNbAf/fh8LlkDLW/S414Dw4hRRtPWFWa3f5q+YMrH3wppUwQm3QCcDf+gxyrP2
EAkEmr83Baazi1kD7OGICz+rMl1Jn5x9+JBPaR9TJfydd7WUT6M/Q4mNfKoGRXDA
W7gX134fbTMD0V6oU0imcLqLZA1KFNyzEgRvR9eArYWQCXGz51NaUGnjwjgvGbF2
ovQlhIgs9aTysO30q2+a9Hi/LqFgohqhM/L7WtV4m01NlZtVB63rkPTCyuWS2q9K
KQNLxCWpyaa3YV+znaJpHj/iAOGwF+oxTKvCGpdVCttXv028zMLTtfori7Qzf0xY
abNBPxbokhhGRUiGSDhyzyc5URAzBQ==
=Cizk
-----END PGP SIGNATURE-----

--oIxXRhOs3lXBAO+h--
