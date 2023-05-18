Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB9E70775C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjERBVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERBVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B230DC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 089DD64C01
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C94C433D2;
        Thu, 18 May 2023 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684372899;
        bh=39nlpA1RzHT8pYtCTp7PaqpEp2GiJkE0xxzjQjCCJt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJbDv6ajSYowXXmI2QVZPIBUIpSCiJJTwHk/4Ss/A8iw122GoQdaeokaN/PTTn7t/
         1sgZd+F201kueh+PljtzEr7kDDM56tWWr7ZcVeWm+c9r+DM+PiiFGkAFgCdHmdhAA9
         xXHpnXwImJJLQCxCoED4lwOAfwVloALt1s7fvDKzI3A0YGGhU7s+rR6lm7j2Hem/8f
         JAaWakaOI5Ushi4/4/RBW51AZa+L6PZKX+IwCDh0xmFAgbWmFpVT5pu0iUfel5kDmj
         UxdxUrhSxJDtD+vNIajcU9S2eDGjRtpJQqthQ1AhpX95qEEmEMXne1KWO4ehYz1U9H
         5vq9YJX5uzd0Q==
Date:   Thu, 18 May 2023 10:21:31 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        peter.ujfalusi@gmail.com, tiwai@suse.com
Subject: Re: [PATCH] ALSA: ti: Use pcm_for_each_format() macro for PCM format
 iteration
Message-ID: <ZGV9m6KbuIMWOX13@finisterre.sirena.org.uk>
References: <ZGTltcv6hSlJWLnh@finisterre.sirena.org.uk>
 <20230517234215.3520-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YRHTtDTD+Ecy08wI"
Content-Disposition: inline
In-Reply-To: <20230517234215.3520-1-minhuadotchen@gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YRHTtDTD+Ecy08wI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:42:15AM +0800, Min-Hua Chen wrote:

> Thanks for your comment. I think the subject should be changed to:=20
> "ASoC: ti: davinci-mcasp: Use pcm_for_each_format() macro".

Yes.

--YRHTtDTD+Ecy08wI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRlfZQACgkQJNaLcl1U
h9Daywf4/uVAMHN0cNVICkG/0mGaj3iO98U13izxrGtmT/G/SPp+zrr6oe5q3+jK
sAbxQPnNuGINxqmQtj9vQye1H1EK8gsEMdet7JGA+wMomX4xdrKDktSc5PH7/Elw
TmKKFTbQQZqxlYbx7EYuTbEVWrz8bxHz3oOYEXhZkAo34NIka4mlvZBp7mf5v2bM
eNmTjgcFBciliKvr4V0w/2Aaty/sNHxNT9MieZcAb0DoLQ9v74R86b4wZONwxur+
rI7cBtr2v0wL9A6uku7Kagmn3kkRYGpNkQzMWx+WqCfaaXN2bTQe7wgrMdHfnWrD
S7CSZIU4+oy1Lf+x48RQGVDs5L4b
=gxBk
-----END PGP SIGNATURE-----

--YRHTtDTD+Ecy08wI--
