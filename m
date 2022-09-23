Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417535E7BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiIWNXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiIWNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:22:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42DA142E3D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E46DB825AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6A6C433C1;
        Fri, 23 Sep 2022 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663939373;
        bh=RVX6YCnEgPI4npfeSwYsvQ8Gf/e9sgc8U0u0H6Y8QiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZ0oqk6fjDZQvffHK8g5EAGsHqnskW4tXF9+aITsnDzzQKltR1oHOBs/kdEaqs+Ti
         2iLNY00l3AXoLayhZuA+kkQrfYcDcJhMUu5qPEc2QfUM8Vr+OEG2ykhfT42J2CDIgE
         5BBY5PObg5NM+nMMGP6ei/FdLv/DyZFIH71yS/2JuBMn5hqWHzRytuG64L8EuC+eYI
         DChRJGRBJRb70SNKclsp8T1GECIXvXR/+IfYq30vbV8eVDfV8Q+LszTxwD87rogkon
         KZlZit6u6dKVrNb2tv9SolTakLYcpDKnrUpwsIag8BjhrI7iv781Y9THX7WrNTJz43
         2IqVLep8/TShw==
Date:   Fri, 23 Sep 2022 14:22:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ASoC: fsl_audmix: make clock and output src
 write only"
Message-ID: <Yy2zKGJXmxq8kwQE@sirena.org.uk>
References: <1662446961-20799-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+p2nOyHK3qW+kWsP"
Content-Disposition: inline
In-Reply-To: <1662446961-20799-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Heisenberg may have been here.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+p2nOyHK3qW+kWsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2022 at 02:49:21PM +0800, Shengjiu Wang wrote:
> This reverts commit 944c517b8c838832a166f1c89afbf8724f4a6b49.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--+p2nOyHK3qW+kWsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMtsycACgkQJNaLcl1U
h9AtDAgAhK+VTWFd0vLsZlcIJo6dWg8eYHQYOKvs5GtUAvSIbwvMar01Ec6xQGHi
QPtAKM+cc1+r4ZsBP0uLWMkK9B7SZk0wmkIU9yqdnvkxL/FSwrTYTZQSXYPKnXd9
iCYAux0/o++sZwgLMvUGdEWRWhK4WBKgpM8f9iwXUR8ZqHSp1LH5w2Xbo6QF3ulN
6NMnguzcSM9SLchdHv74X6DCJzHcSK9CaTrvBgx3YRYN3R8qA83YBKORCt73Jo/n
8tY9AHQnOBhotVM7TxWFptSMVx6iGP8z1EgaD4r5HV9PNg0R2iJBk38azCUD2fEg
xEEhbFgFxktNBWSgNlcJ12zvbSbPRw==
=ZIxE
-----END PGP SIGNATURE-----

--+p2nOyHK3qW+kWsP--
