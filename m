Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB87F66C2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjAPOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjAPOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:53:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9787C5B96;
        Mon, 16 Jan 2023 06:41:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 611F0B80FCD;
        Mon, 16 Jan 2023 14:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECFDC433D2;
        Mon, 16 Jan 2023 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673880076;
        bh=DBpFvUPk6aIKzxRtTgvzA2wsR/gccADGxoulyVLE4+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ir3us1sa/T4GamrJrao7UGS7x1tYciTsv9XWDvOoWpZv8wnh8S5fGsZx59Pm6mRgN
         ExS+nAmO62zPdnEcz0wWEI9pRLyz2koLMpITe6hvCRDOqLz0oE6skQOGhH4kFHYhoy
         DmIU/MFv7RRVqARixVOuh8SOdaOZBsEW4h1iknv8bOGwROf9mO3U15YMMRuT4LFJXq
         R2rvZ2Mx5IyJJPnEHcEgUj7SbCAkSCcqxdHqeX3uyhftiBsWeukAalsKRPXkP0SiMy
         VKh5qbkhOtuioxGBDcgcqJopwspTANN4VADUabuTyQQ/tQg5h7tiYigDzio/mIZ9sN
         2rI+LuX2wh8xg==
Date:   Mon, 16 Jan 2023 14:41:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP313a variant
Message-ID: <Y8ViBxFk+YRBmCch@sirena.org.uk>
References: <20230116142501.767142-1-andre.przywara@arm.com>
 <20230116142501.767142-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R4/rqsV5InU2Lm75"
Content-Disposition: inline
In-Reply-To: <20230116142501.767142-2-andre.przywara@arm.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R4/rqsV5InU2Lm75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 16, 2023 at 02:24:59PM +0000, Andre Przywara wrote:

>        - enum:
>            - x-powers,axp152
> +          - x-powers,axp313a
>            - x-powers,axp202
>            - x-powers,axp209
>            - x-powers,axp221

Probably better to keep these lists sorted.

--R4/rqsV5InU2Lm75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPFYgcACgkQJNaLcl1U
h9DEJQf/W4YVdfe7oceJbRfGjUZeyoD1zDIZRw0/5GhFhmLThRiwd54aAEKHncvZ
mU86HzAE8meVc/bRnCRSOnJ0oKxF3RIvcUiLzGCGC7xa8pv4VRU7XR5TaX20ch2t
Wk5+0/84PAtTBezwYkl6dhQtG+SBoj+/05pM5hlYshfR6k3hQoyjjSP+iTP948lM
upu6oKOexUZZcgP6nb/dVpns/n42j74gky8cPc+KAt2XdgMH6vDGp7wHtlffhmfd
YwZL/svKsSzHckcXURY6pQaZtpovMgEUa1q+kZGuHctsirGeC9dMp6hkOsHljpwY
zKhX7+iaRLrW5kYsNBRMsMwFz97SiQ==
=DlAX
-----END PGP SIGNATURE-----

--R4/rqsV5InU2Lm75--
