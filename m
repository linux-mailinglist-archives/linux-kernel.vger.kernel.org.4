Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE5656B31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiL0NFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiL0NFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:05:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC6B64F6;
        Tue, 27 Dec 2022 05:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF9C61157;
        Tue, 27 Dec 2022 13:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84638C433D2;
        Tue, 27 Dec 2022 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146302;
        bh=vwTxEmWywJfahw5LbUuZn51ESYRdcfZxVfhaPmBHhOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyDJl2DdlRkMbWBtXGU8iVomIt/1HSy9522SBbj4G7D5kGJi/ad/TcpFZ/nvQ01UE
         PO95jbfg+dIJCVfvkyCVDhKQzgCtQBV8MeaDmPsP95JUmdE96E7i8wLXIIXi+bwd7k
         XjD5ltD5k4xBZflMzGcf4uZLW4wKK8WKKH+V9i1TcSmayQNjEDkKWNYLofWspacv0L
         npZz8bL6zbtRlUuMu1C3bt+SYC9JOwTtaOSlRwDNoBD+nF+8rdEIm2F7dzDktbKAsL
         PiXEr4OXhwjydYvuKqjate9JFr2ek3tA0S5hU9G3fschIg6QqdWSkkMoYA5Bp7qDTU
         epr57fCnIMPyw==
Date:   Tue, 27 Dec 2022 13:04:55 +0000
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
Message-ID: <Y6rtdy4NPfi/KOqd@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <Y6bAQ8hDLkvrvjQQ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zr2rHEGqLJMRmKJ6"
Content-Disposition: inline
In-Reply-To: <Y6bAQ8hDLkvrvjQQ@kroah.com>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zr2rHEGqLJMRmKJ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 24, 2022 at 10:02:59AM +0100, Greg KH wrote:
> On Fri, Dec 23, 2022 at 03:31:49PM -0800, Wesley Cheng wrote:

> > + * struct q6usb_offload
> > + * @dev - dev handle to usb be

> "be"?  What is that?

Back end.  This is a concept in DPCM which should be reasonably
discoverable to people working on the audio portions of this code.

> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.

> All of the code in this patch series is older than 2022 as I know it has
> been in shipping devices for many years.  Please use the proper
> copyright year to make your lawyers happy...

Are you *positive* about this.  Based on some preparatory discussions
the Qualcomm people had with Takashi and I it seemed like this was a new
version of existing concepts.  I'm sure they had something already but
it's not obvious to me that they're just posting the same code.

> > +static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
> > +	{"USB Playback", NULL, "USB_RX_BE"},
> > +};

> No terminating entry?  How does this not break?  Why do you need to
> specify the size of the array, that feels like a design bug somewhere.

It's how the interface works, the number of entries is passed in when
adding routes.

--Zr2rHEGqLJMRmKJ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOq7XYACgkQJNaLcl1U
h9CIXQf+NY4WahBGVa1iM4YmLUiFB3BREEf7qYR7ISMwWzS7oXc0jYFhfCLrz+tN
ZWQ22VePJY2Pfw6WA94IHsogW9sLLcdPFy5yEupL66jAAGqK6XdViOE9TFu8KDF+
KvAsZsgQPvubruTmt9u2gWQjbSOuSts2dwUN+mHwp73FQAA5jCZMCXEcrAZ27uDi
PHP5l8dkmHFLukFJUb4wGee/qebPwdDna8CWDXwvwrGOHLKKgtDQ/ZKFLJNhcJ1D
3cB9MT2mfY01zTF9wk9J6GmD/nggoM0xFCu/7lX98wA7rMRK1PmvbQEAHCsagvVQ
aiONQx4/PqiG0djaCq8bzmyyIVI8tw==
=pPnA
-----END PGP SIGNATURE-----

--Zr2rHEGqLJMRmKJ6--
