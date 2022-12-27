Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E8656BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiL0Ogg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiL0Oga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C82A3;
        Tue, 27 Dec 2022 06:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E71360F92;
        Tue, 27 Dec 2022 14:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C23DC433D2;
        Tue, 27 Dec 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672151788;
        bh=/EDm6xhhHpeJLbxbvhfcWbFizxBuWlsdVT/F3n9zhI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLqf7O8kcixh9nFMoanB7/3AjIQ/vkR6JwoLk/VkZpj/dZIOCVMr9XHmbajyDVUkq
         DMynJ4rVrF1rYXU5ED00w18DFAHLR+lj3isG3KzHwRnKfb+7ni3KrBNcn9IxDrteU/
         gQu3GI7S14K+jwCyCR/BjVfJMh5+E0aQXEY3OyyYHW2f8S83HNMNjoYZzXhJh15dlC
         COFEKUOJdwwzauI7le8XIP39UiH+8Pkl+66lQf145BESc9gHJdmFU18qxf3w0anHaO
         mqCBRpcJwFSMHEHsB88PZNbZ6WsPFSIQY2OObZcZ983HjO2Boqe5fGwrW0cSFI1fD/
         HKWrefRYy432g==
Date:   Tue, 27 Dec 2022 14:36:21 +0000
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
Subject: Re: [RFC PATCH 00/14] Introduce QC USB SND audio offloading support
Message-ID: <Y6sC5e9Zrd2JWTHU@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <Y6agEsfXKMMXPpmz@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1+ZKSFcDOruBirf+"
Content-Disposition: inline
In-Reply-To: <Y6agEsfXKMMXPpmz@kroah.com>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1+ZKSFcDOruBirf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 24, 2022 at 07:45:38AM +0100, Greg KH wrote:
> On Fri, Dec 23, 2022 at 03:31:46PM -0800, Wesley Cheng wrote:

> > soc-usb: Intention is to treat a USB port similar to a headphone jack.
> > The port is always present on the device, but cable/pin status can be
> > enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
> > communicate with USB SND.

> > Create a USB backend for Q6DSP:
> > q6usb: Basic backend driver that will be responsible for maintaining the
> > resources needed to initiate a playback stream using the Q6DSP.  Will

> This looks to duplicate a bunch of the same things that a number of
> different google developers have posted recently.  Please work with them
> to come up with a unified set of patches that you all can agree with,
> AND get them to sign off on the changes before resubmitting them.

> This uncoordinated drip of patches from different people doing the same
> thing is almost impossible to review from our side, as I'm sure you can
> imagine.

I have to say this is the first I've heard of any such patches other
than from the Qualcomm people and I can't immediately see anything that
was on the list either, though I might be missing something since I
don't have the subject or anything.  If other people send things again
it's probably good to suggest they copy in audio people and lists.

--1+ZKSFcDOruBirf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOrAuQACgkQJNaLcl1U
h9AjZwgAhsVgucuD8v8EbY26CtQPykN5gxWGJ+7ciqU2SrnCmlf+PFa++50wRWOa
pDrX7dQ+fLhgUGMXCKWlY7dRqGjtYicvaKElyZXfKt8vdXifdNur+KBhJW979lbF
X2c3CK0pl7plOpv43L4vYExx5Qlr7B4Jz+sYbdw6ND1CqpW7a5lghIAOL2d0kTxB
yPdeMrE4vmzXcN24/XFrTb0zgfTkh13j6et4DocgNe9UhHjgMzgEfHKmM7W/QBZf
RNE8voHGyXvSb0w92ZyX1AGLIZF0sU2gOSR0tAQwH/5w5emoHj3b+LvGz1ArQVmj
ms5nPnW0UpzZU8QkG6f+w8tJiSQCcw==
=XxVJ
-----END PGP SIGNATURE-----

--1+ZKSFcDOruBirf+--
