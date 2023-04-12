Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC86DFAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDLQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C9DC;
        Wed, 12 Apr 2023 09:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BDCF62EF9;
        Wed, 12 Apr 2023 16:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE0C433D2;
        Wed, 12 Apr 2023 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681315989;
        bh=/0S26gb8KpLqR0YlfOZcdKRH1XnHiL9rtqGI/3Tcoss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNkvJFjSFVWhZPYlQzrd97H1DOKSC16+073o+ggjNmIDWF6VSeJmPnE9Rs5AtkAU3
         5kiRmrj8M1HDs5KkY5ACA/9nE5QsUh9VPn7pjVVCyUGrtCvOJMEJZ4ZMnhxDxuDzMz
         kZUfzRmI3frZoOMt0Y3u0EJFai1dD6ro2Hz1QeW+OL87oPkkbbnYSGhyZwgHciUuD8
         gEQ1oxWILHhwtPaCs2zx+ThP78mva0xDGN8GxN79ssVoh/sV69mY/bKZAe7piHdafW
         iKn1JEprWmE7NLLklDg3WwopvkeQCptngGOLKgPwO7wQrfoHhCMteMiU3JBgP+/fYY
         eNNEqWtPRfMrw==
Date:   Wed, 12 Apr 2023 17:12:58 +0100
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
Message-ID: <af2db163-9ab2-4efc-af55-933d2cc4c747@sirena.org.uk>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
 <d784dab7-a1a6-4db7-aa13-e39e9904f342@sirena.org.uk>
 <0b182a36-0254-6720-4a35-f9e617c12797@quicinc.com>
 <92690348-21c3-45de-bdb1-d0977b859702@sirena.org.uk>
 <92f61ba4-a847-1ce3-f0c8-e9c0f0fafa0b@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wOQQTZxC3PT0p1bY"
Content-Disposition: inline
In-Reply-To: <92f61ba4-a847-1ce3-f0c8-e9c0f0fafa0b@quicinc.com>
X-Cookie: Happy feast of the pig!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wOQQTZxC3PT0p1bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 08:59:06PM +0530, Vijaya Krishna Nivarthi wrote:
> On 4/6/2023 8:58 PM, Mark Brown wrote:

> > > > > +	if (ctrl->xfer.dir == QSPI_READ)
> > > > > +		byte_ptr = (uint8_t *)xfer->rx_buf;
> > > > > +	else
> > > > > +		byte_ptr = (uint8_t *)xfer->tx_buf;
> > > > If we need to cast to or from void * there's some sort of problem.
> > > the tx_buf is a const void*
> > > in v2 I will cast for tx_buf only?

> > Or just keep byte_ptr as const - we're not modifying it are we?

> We are modifying it, hence did cast for tx_buf only

If it's being modified won't that upset the callers that thought it was
const and didn't expect the data to change?

--wOQQTZxC3PT0p1bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ22IkACgkQJNaLcl1U
h9D+twf/TOmsGa643rsnWDsZfNBApi0JXvXHXYCag47meGDFLz+PkBbWIPigc/fp
Szd3VZ2L8nTQsyL66h/EbTvHnOjWhEmDzZGhv31O/1IGABj7cfdFpuYbAoCiJWRY
jlQKKnRLLl7tSTPt2srRVhGK8XwBhyHwLtA9uJ/xn5KCW7o1+xJYD8Xz819ZrBt3
X3SppUUi19CLEpTnbKIefujQ6Fg4+9221kxBhQToXebzYQXs+BVRSp0n4INrhQ+X
NvhwqYekwIkSQQWGrJl5W1YfAmW1AZC0DYqK12JEDvphAIMRH9srCAndvuj4Opt3
LeYZV5x0pSV7l0MEiS09JC+ACqPjsA==
=UAxl
-----END PGP SIGNATURE-----

--wOQQTZxC3PT0p1bY--
