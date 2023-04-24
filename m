Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58E6ECC71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjDXNA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXNAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC913A94;
        Mon, 24 Apr 2023 06:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8F961A2A;
        Mon, 24 Apr 2023 13:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03845C433EF;
        Mon, 24 Apr 2023 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682341222;
        bh=fteR76QTVItOEEcM+S+xe2WjKVQ8K+77OkWCF3do05U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnN3x7ZYgoKl4vlHWNJyFpimRHKeDYZ44Krv0rCJqTPNVTRfhO34+o/U0l5Ib1GtY
         tr2+i+k1hmyk7T4+BOhYC8j9hJ7hXh4SRE5loa42DIj/F3Hx5kiE4SQKWO2H8fXCj4
         GKzEDd234Uy+IKOMkgaPnPxHcPC+DpDql5zkjWMYwsgWB52XBlhe/3btd/yztNWdYj
         ci90Omo8GXtRZHZfLRfiIDLPRQ4vVFNQTrx56kWdm5gaXdB3bDXfRQe2/XErwfAIMi
         3bzTNZKCAi92XgrzQlMouYS5vYWXisTtniIlcCMpCaEKuTfe+FXnsRrg3kxf+8mAhr
         O9InyLAmOyk5w==
Date:   Mon, 24 Apr 2023 14:00:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Enderborg <peter.enderborg@sony.com>,
        Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <55ab40bb-8b3e-496d-bf45-6c4ebd01e43f@sirena.org.uk>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twwtZg5AgNt9nx7z"
Content-Disposition: inline
In-Reply-To: <2023042421-landowner-magnitude-a38c@gregkh>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twwtZg5AgNt9nx7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2023 at 02:53:12PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 24, 2023 at 01:32:14PM +0100, Mark Brown wrote:

> > There's issues with partially created debugfs structures getting in the
> > way of people trying to debug things, just completely ignoring all
> > errors can create confusion as the diagnostic information people believe
> > is being shown to them ends up being partial or mistructured without any
> > indication that this has happened.

> How do you end up with partially created debugfs structures?

The ones I've seen have been name collisions caused by for example the
debugfs structure created being flatter than the device model structure,
though obviously something unanticipated could come up.

--twwtZg5AgNt9nx7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGfV0ACgkQJNaLcl1U
h9DJYwf/TTBIVw0o1yEbPfrrayohucG1g5k1JQliO/VyIp3MQJEDupEfsczMrWZL
Y8oMnHjC0xlOy658EasXHArP8E3+efPZleYlNPESJJ9hW+Xj/rRPYdxJDdpwzE6l
s/lUCVOAe6azDuusWVocOyPrFuT5qeTgkvYYTV12RTxkapIUx2rT9Oed+h46ONWG
j4sQrbbLgaWsWUI+I7/XMB8HLKS1lGNE3GrJtF5UDdxX4HlplyCHzn+x5lOOtklV
oa27Cq9BSef9PkMvc4eGcDu89Esgm3dv44/n6HBnEug3hm/Xdwvd4DFJg77YCPZb
yQCfYq9MBCIYkzZl+0l8++MyGhRjuw==
=YueL
-----END PGP SIGNATURE-----

--twwtZg5AgNt9nx7z--
