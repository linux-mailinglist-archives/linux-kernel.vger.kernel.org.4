Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1869B2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBQTSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBQTSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:18:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA21C7DD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3067EB80CBF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 19:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE32C433D2;
        Fri, 17 Feb 2023 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676661494;
        bh=kCqlDe1M3otG9v8JQIR2BX41ixkYIVaG3kWAScQaQ4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVOuA0KJgFmm66GLeF9OQWKCcVAM6fMS7A1eJpvmAxsJt+y2MwcKZMCGOiohn5Md1
         /1jxo/it1cgy0jACVk/wpzki9P2kUdxojxm4AU1wkhVvTR7f7BtUXfSmJlptLwhKSM
         uZlkXB6dBoGWEczZPomQJ88kY7hs2rEA5p2bnSsYBBPADkd+Ml7peIydv6TNO11PiK
         BciswKRakz2swBaEiMHR5KGFVD8uO8R//vLAf3ykDKq77K7jD6dyaiv3KLU//ocAN1
         GamwmMxRRiI5LBuGs+fqZOu+ryuj3V4Mkfaa2G8P9Pk/cEV/6Vm+l9K9xiBOtzYQoV
         sR7C3+sUKa6Yg==
Date:   Fri, 17 Feb 2023 19:18:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y+/S9OsPC8BTGHku@sirena.org.uk>
References: <20230217185326.23490-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l218fCJv4nwtvb52"
Content-Disposition: inline
In-Reply-To: <20230217185326.23490-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l218fCJv4nwtvb52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2023 at 08:53:26PM +0200, Andy Shevchenko wrote:
> It seems that a couple of members got lost theirorder, put them back.
> Besides that, split field descriptions into groups in the same way
> as it's done in the structure definition.

This doesn't apply against current code, please check and resend.

--l218fCJv4nwtvb52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPv0vMACgkQJNaLcl1U
h9DfEQf+KMrfyckMY60cuhJHFvFvdmKEXKx3Z2K8xkgeBURiEG4lcajPsGu8iK+O
oB6Ipsaqsc18KaEEOn7OR6wZSO+3FPhqeS7RkoMNYIVeBwr2yhlZhInk9UMDxMoP
91mT24UZU7JMYgXpdbms67VEBwxDGnV3RB7ytpdl7HNUN7156pInw0s+fsKpnRjR
CzC4IbHEjkT5IRO6c0PX7hVCN2RJG/b6vB9S2/VG+VrIatUR/0PhhGVbNcpzED8k
SRkRkGflMRLvXty2fcQx02q73knA9CvLotjlWx76iFUQa4g95PLDfkzj3QEhp6Lq
TkEaDfvOf8ANpkQD/htJZrhWxwPF9A==
=b9Gm
-----END PGP SIGNATURE-----

--l218fCJv4nwtvb52--
