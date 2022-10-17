Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96C601583
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJQRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJQRhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE56DAC5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE88611EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951A5C43470;
        Mon, 17 Oct 2022 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666028243;
        bh=P21fPjXscYNZmWN0U3OwwfkLHI/4cWb2JN/05W4DDF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spiNhj3I7KQAHvGoOluT5cn9yHVDmqFXmE6bzbCS9580fKsZEGi/+Kf1MtC/JTjWW
         RLLHVTuyGaZ9LCAA++262dxzhAIA5BbLL+66RUEJc7C6YazDWkmijVm81gEbwQ9KhW
         kYh5jDp1mqtwW/8k6k88Dmn86+trxGAugds8i2WPmqb2obtMvSCXVmX4j/ZlGqK7n4
         Rkqk6G6e31j7utGeGBhyslFVnsguAbTJMIFamos4muaQQAAguRfTonSkw6U6N87oib
         16NU0tuSct27DuKcLT+HdoXdNceDFSZsvgLUhQTnQxXDNeqUbhVBZSmwCVK/2NX0LG
         Oc72zqkXvd4VA==
Date:   Mon, 17 Oct 2022 18:37:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     joel@jms.id.au, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH 0/5] fsi: Add regmap and refactor sbefifo
Message-ID: <Y02SztthO39FYIeu@sirena.org.uk>
References: <20221014220540.55570-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="87y+PZY6GlQmpbhu"
Content-Disposition: inline
In-Reply-To: <20221014220540.55570-1-eajames@linux.ibm.com>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--87y+PZY6GlQmpbhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 14, 2022 at 05:05:35PM -0500, Eddie James wrote:
> The SBEFIFO hardware can now be attached over a new I2C endpoint
> interface called the I2C Responder (I2CR). In order to use the
> existing SBEFIFO driver, add regmap drivers for both FSI busses
> and the I2CR. Then, refactor the SBEFIFO and OCC drivers to clean
> up and use the new regmap drivers.

Is there any great reason to provide support in the regmap core for this
rather than just implementing in drivers/fsi?  AFAICT this is just
ending up as an implementation detail of shared code in drivers/fsi and
won't have any external users?

--87y+PZY6GlQmpbhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNks0ACgkQJNaLcl1U
h9Duzgf/fupDXVRfwEFVbuPavfOcttUn/fRBk4JS/3Loa9jnKNweZJL+ygH0T5MF
wNH3E30mUifUbcJ8TuUnnQqn8NWNjPkMGod/Nj2tTyjjyMFoZ+7dfYZFbLWlFhW/
M2htzpN6nkARptmS/HbgOsm3fbxiok7/1BrsXLgHxYmp4Rev0SBGTySFfgMyN8o2
01eLgDtc4A/rDZGQIp7fzmMX5ITwuaTjN0Wuk1y3EBCcnyiIFBqPgdyy8yt+b9ID
LLPIa9u4jdZjIjHL0Lbqi03+/HggHDX3gQ6OMnZGMa7E5CYncn7BXgE9vbPDGAjl
t1mrjvrf+oYExkodMrClNXiQBKsTQw==
=2ZRA
-----END PGP SIGNATURE-----

--87y+PZY6GlQmpbhu--
