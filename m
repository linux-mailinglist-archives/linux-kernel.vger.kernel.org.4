Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5E6E4E65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDQQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C56E8E;
        Mon, 17 Apr 2023 09:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B1261182;
        Mon, 17 Apr 2023 16:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF05C433EF;
        Mon, 17 Apr 2023 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681749548;
        bh=JCqP49Xpz85bHJtVkhJeBIQ8R7VedWXznxPSZaz5a90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSIGsY6qXIZBY2NmJowvUhPOroGWnVYrnpjj4HZdKj0Loy/wX1y/xPyPuwYFUvvn+
         co7RimQUmLGRtnUpjGKsE5ICf4LznyfxJdKLNrJhKG9zduhhxqq8la7D/XX438acy/
         vayM/0atTfF7YHY/j1icwAFcAIrXbORhu/5XOrdnoKT6HXkg9shZkPnSZ0A9VuYHUw
         7xwk6ljyzDwt62NfX80+9EJZNRSnRyazJ3g8BauDFFtcO339AIHkNCgYgkfimoFrKo
         ABvdpia6wEBBeoawryExFPwqHBhlqku09RoYg8jBmycH2TzqjUolgLQfVyl6YZlu5N
         AGVCKbHVg077g==
Date:   Mon, 17 Apr 2023 17:39:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v3 3/3] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <85225dd4-7ecd-4ce9-8447-184f749022fe@sirena.org.uk>
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
 <30a752c9-3ea0-43d3-959a-da2e8b526cb4@sirena.org.uk>
 <CAD=FV=VCbcUnf42tK-HV8j=71BXXytxku_0rGjKyhyR3WG4SUw@mail.gmail.com>
 <46249e7e-ac2c-00d3-b3b0-7b15848e7b7c@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8OVq0bfjkI9I0UjH"
Content-Disposition: inline
In-Reply-To: <46249e7e-ac2c-00d3-b3b0-7b15848e7b7c@quicinc.com>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8OVq0bfjkI9I0UjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 09:27:16PM +0530, Vijaya Krishna Nivarthi wrote:

> However, Like Doug pointed, dma_alignment is not being used by core.

The core will use kmalloc() for any new buffers it allocates, this is
guaranteed to satisfy DMA constraints.

> Is it up to the SPI consumers to read this and ensure they are providing
> dmaable buffers of required alignment?

If they're doing anything fun for allocation.  Or they can just use
kmalloc() themselves.

> The dma_addresses coming from core are aligned for larger sized buffers but
> for small ones like 1 and 3 bytes they are not aligned.

In theory even buffers that small should be DMA safe, in practice that
rarely matters since it's vanishingly rare that it's sensible to DMA
such tiny buffers rather than PIOing them so drivers will tend to never
actually try to do so and I'd expect bugs.  It is likely worth checking
that DMA makes sense for this hardware.

> I have not checked the spi-nor driver, but is it the consumer driver's job
> to ensure required alignment in all cases?

Yes.

--8OVq0bfjkI9I0UjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9diQACgkQJNaLcl1U
h9AnLwf/SFrq8jwQOq601LZUGWq/RZOBA8bDTO1wfWl54flsCjecwLtsvd9kSxAu
RnvPBbH8WYfqFWPPqrNhFXCLnLQUAopOnN2jv1l4qU+JXtAaWh64c/6tzoDFIlH6
zrYIjh7HhLcxd72py5K9AXJwYFI+VtKCq08obGiUICl9PwZbOxJZnehf7wFnJhKM
J93W7fU9FohfKY35qWab854R+xgi5b53NJN5GkuvG+t43QOV1ERFYT26GyHdjKtI
UEiqahdm+2iw6i0xxqIeurkjasM63IXU+K/F4Te+rGPda7wwXQpzTUt3muhnXx2f
5Ls7OU3Ht8KLYxk8ckc6BUuI5f8fBg==
=m+st
-----END PGP SIGNATURE-----

--8OVq0bfjkI9I0UjH--
