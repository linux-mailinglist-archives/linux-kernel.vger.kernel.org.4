Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56A2743AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF3LWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjF3LWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A4C0;
        Fri, 30 Jun 2023 04:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB276168C;
        Fri, 30 Jun 2023 11:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB8EC433C8;
        Fri, 30 Jun 2023 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688124157;
        bh=m5STNqiJvAYLI/NlBN13tyDYzsXURBtP7i6n5935fIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXTFKFInaQsuvChh3L6rrCqd0dYf533iVP+lqfxOAV81gg7IkRu5vnZorwc0vRkEg
         hj2Upkk5KxFMZZaqy76KLCKfuTNscamHnRnJazxR3Iu8S5gWTfLzkSrdWaESpxpDn5
         J6H4srZ7wmkDFYYIOlLO9Sb9fFeJUs/DPyvaX/wYCdvN13ey8dx+Cdb+20LqmoQNC1
         U8O27vgeTbkf0FBqDl3ofjzRXRtVURxtXeM1rigC+rGJT/WaqLaN9g5Ws2uXWzAqUU
         Njnng51YdRI3zBs/f59pD+fxUaYpRZdiv8H8jSaRWvErxs+XcC+MV4O2z+UfZ7/Qqu
         ocZUOmMvxz1EA==
Date:   Fri, 30 Jun 2023 12:22:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/6] ASoC: fsl_asrc: Add memory to memory driver
Message-ID: <f234b307-9ee6-489d-af8f-46cdc966a6cb@sirena.org.uk>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
 <1688002673-28493-5-git-send-email-shengjiu.wang@nxp.com>
 <f6598cb0-6773-4475-85e1-5dfacaa16de3@sirena.org.uk>
 <CAA+D8ANbMYr9ATSfWnbq69ECHOPNTiOBc7QACEeHomCC+rTHng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZYyaaohwRe2QLoL2"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANbMYr9ATSfWnbq69ECHOPNTiOBc7QACEeHomCC+rTHng@mail.gmail.com>
X-Cookie: Old mail has arrived.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZYyaaohwRe2QLoL2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 11:37:29AM +0800, Shengjiu Wang wrote:
> On Thu, Jun 29, 2023 at 7:39=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Thu, Jun 29, 2023 at 09:37:51AM +0800, Shengjiu Wang wrote:

> > > Implement the ASRC memory to memory function using
> > > the v4l2 framework, user can use this function with
> > > v4l2 ioctl interface.

> > This feels like the bit where we interface v4l to ASoC should be a
> > separate library, there shouldn't be anything device specific about
> > getting an audio stream into a block of memory.  I'm thinking something
> > like the way we handle dmaengine here.

> > I've not dug into the code yet though.

> Users may want to get the ASRC output in the user space, then
> do mixing with other streams before sending to ALSA.

> As there is no such API in ASoC,  the best interface I found is
> the V4L2, but I need to do a little modification of the V4L2 API,

> extend it for audio usage.

> Could you please suggest more about the "separate library"?
> Should I place this "sound/soc/fsl/fsl_asrc_m2m.c" in another folder?

The concept of connecting an audio stream from v4l directly to something
in ASoC isn't specific to this driver or even to the i.MX platform, the
code that deals with that part of things should be split out so that it
works the same for any other drivers that do this.

--ZYyaaohwRe2QLoL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSeuvYACgkQJNaLcl1U
h9DZPQf/WRYZwwHKLB9mVIRQZZ3u6JtZ0ySgC91H4ZgQ5NoaNPmmTmrm01BN5uZY
g1Olg2Bv9gQOnIpXDWytRn/v2JUdQ20dZ6cLKy+bbl1BhQqvulFIGTzKGMq4b3IH
7PYrDvV/5kgWexeIpT9DLyjRkbGqKQyBvqNBlFqNfxkMsIrt62KoCV675wsDlMWD
EU1tqBs19JrAxETCTXrL2RJ5S04bAWMke1rUCk0+1VmY3ZdogUqzcG+5aNGu76BS
brxQXCbTUXO///D75UaNwnA/8+O4lhy6G+2AHIjU3ipDArCU7JOtZgb5OAHKIM/N
IqrbcHoRZmDTkY8gRIRocOi8b3wQUA==
=zz+l
-----END PGP SIGNATURE-----

--ZYyaaohwRe2QLoL2--
