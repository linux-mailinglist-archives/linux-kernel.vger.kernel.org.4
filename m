Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCA6A5F53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjB1TKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB1TKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:10:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75997A249;
        Tue, 28 Feb 2023 11:09:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03592611A7;
        Tue, 28 Feb 2023 19:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E36C433A7;
        Tue, 28 Feb 2023 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677611395;
        bh=gde8IKisDzu9sAnMKJl32lrJ++3Ft0RREzi/TZND7hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbz9wDXmTkRSRmqwsMr5YZLETsMMOYWjU+WxEl0woCAHndRhCYfMUsJFwUCGBscIF
         oLAupNzYzFfbYpTlMc6JI7aUjT7Wf0TcBDN+ZDxJlEamHTGlLGiABBzPA9wQEVbQ7P
         MdvkrZrAemwjb7zyeCFjhsbMTfnFVjzEirDcQLT9nk0e1WbdFQNm7lU7BqtD6lBprt
         kckB5AYHB6bdYzPkat5h2Ip+qkzRtylrTc1BltYSwJ485Vi6zZ44TOVQmV/J15qJzI
         emAWwSEoByIYknpXvMjD+9fr+KUbFTWgQaRP1SBCFqu7FZkdkHXrXlKoUatnj02LSD
         hkNUWtbsl6rhg==
Date:   Tue, 28 Feb 2023 19:09:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, quarium@gmail.com, jhentges@accesio.com,
        jay.dolan@accesio.com
Subject: Re: [PATCH 0/3] Migrate PCIe-IDIO-24 GPIO driver to the regmap API
Message-ID: <Y/5RfjJCDdrZbHgJ@sirena.org.uk>
References: <cover.1677547393.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="am13qCBnQ13SKXJA"
Content-Disposition: inline
In-Reply-To: <cover.1677547393.git.william.gray@linaro.org>
X-Cookie: For external use only.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--am13qCBnQ13SKXJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 08:53:39PM -0500, William Breathitt Gray wrote:

> A patch to pass the device regmap and irq_drv_data as a parameters for
> the struct regmap_irq_chip set_type_config() is included. This is needed
> by idio_24_set_type_config() in order to update the type configuration
> on the device as well as irq_drv_data for idio_24_handle_mask_sync().

The values from the config buffer are supposed to be written out in
regmap_irq_sync_unlock() - why is something custom needed here?

--am13qCBnQ13SKXJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP+UX0ACgkQJNaLcl1U
h9CJbwf/avAwzbrNVJxgLTlyUR/TcrzPYIWkFD/m+mVmuCNF8Mq6cdY+g8lmleeW
mhVxMmvwu+giPGP0MUCkCEc4/Ahm+0q7ZSj/jg4AA0eIwFZUT0uZQpETfG6NeSHG
DLQ4vP5MRxt2p+n66XQhjnrFWeEvxXiTSOEQ8yjZfujJRQL9Zym5Hfna9SNxNTaF
rGxMcOdJfgbPCk3Z0fjVP0IsuSwZltmS+IB5HaVFQQykqo+Q51/U32lnfiCa4UZ0
ZGqLhiTW0Q/Z950bkFex6ql2iigGpUrV2Ay6WLpv7IA6ag7PGJDlJfDyZhUZl4v9
kGZu8ZNjv89yYN6UnQxTCUO9rXnTRQ==
=/N41
-----END PGP SIGNATURE-----

--am13qCBnQ13SKXJA--
