Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6095A656C56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiL0PLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiL0PLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:11:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0449E60;
        Tue, 27 Dec 2022 07:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F881B8106C;
        Tue, 27 Dec 2022 15:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D01C433D2;
        Tue, 27 Dec 2022 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672153895;
        bh=vJFbSuGYShvkxrhsg3x4ZX9c59Djy1db+HUXeEPs4Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+YTTVJVpNMmLoJLD77Wx0lLkd46IABLuElsajSxMkkYxSejLQdPAjr5hKlwHKdEV
         7/b+eTuRi9//jPc/DoaT/pFksIFrRKJ8KETWR0ozYQQEJVlPmBZcMnUCwK+aJiJy5i
         MWnguaAaX0l18HHwFPn9alVuyUbwTDTeI3c8j2367T2o4Ju2xOcQNWZcBdLQPOOlP3
         uz2tpG6YsyQl+RTfGFsLQIvUs2CVKdvW1e7wjq4fL4rh3xlcWPOk22rUDXa/6rAbwA
         AdfV78bE3VsjQrHYKsndJQkrNEL/5okmk1X9KUtYpzZObnbjGTcAWetjNgNIX7tl3C
         YEyZhh9IlawsA==
Date:   Tue, 27 Dec 2022 15:11:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Message-ID: <Y6sLH+8nVFImL0Oo@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <Y6bAQ8hDLkvrvjQQ@kroah.com>
 <Y6rtdy4NPfi/KOqd@sirena.org.uk>
 <Y6r26VfIfpE8zpPY@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bScRnfjqovRwO9fK"
Content-Disposition: inline
In-Reply-To: <Y6r26VfIfpE8zpPY@kroah.com>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bScRnfjqovRwO9fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 27, 2022 at 02:45:13PM +0100, Greg KH wrote:
> On Tue, Dec 27, 2022 at 01:04:55PM +0000, Mark Brown wrote:
> > On Sat, Dec 24, 2022 at 10:02:59AM +0100, Greg KH wrote:

> > > > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.

> > > All of the code in this patch series is older than 2022 as I know it has
> > > been in shipping devices for many years.  Please use the proper
> > > copyright year to make your lawyers happy...

> > Are you *positive* about this.  Based on some preparatory discussions
> > the Qualcomm people had with Takashi and I it seemed like this was a new
> > version of existing concepts.  I'm sure they had something already but
> > it's not obvious to me that they're just posting the same code.

> I thought that this same code has been shipping in devices for a few
> years now in the last few Samsung phone models.  Is this not the same
> code that is in those devices?

> If not, why not, what happened to that codebase that makes it not worthy
> of being submitted upstream?

I don't specifically know anything about that code but I'd expect that
for out of tree code breaking new ground like this there'd be a strong
likelyhood that there'd be design level issues and that's what the pre
submission discussions were all about - how to fit the concept into the
kernel subsystems in a way that might be maintainable.  There's also
been the whole transition to their new DSP firmware going on.  It's
possible that what was shipped was implemented in the same way with the
same code but I'd not assume that this is the case without actually
comparing the two.

--bScRnfjqovRwO9fK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOrCx8ACgkQJNaLcl1U
h9CnuAf+MGvd+7W+bQWW+xi1CuE7tof8WZ9OioNEjvAye+7vSMT+3xz69FpZCsDj
qjLn5KpAJ0d+8GmyK2A7q7G0mq7m86Vfy32SL0CJ85glIwXsle7Et1qMjHlChD3a
Z5W81ijSkUe8OJVIvYBgsUKOdpLiJLtrhRype+FPWs8jU5FPpS42j5PNC0U9XNkP
jJJmYssHD+Hu2jzMljinkqK6yD97EQ7QlKHUDf3Y4CzpnIx3JBhkGszFGzNHHxp+
qtkKie0btBhrJzPDM5nrRn8ugSehraG7r0RRTv/d4IsIgoQkrnwtS2e36SP7WVTz
N6aswJRsm0m/Qxjwxgx5P8lS6k6JnQ==
=AYE8
-----END PGP SIGNATURE-----

--bScRnfjqovRwO9fK--
