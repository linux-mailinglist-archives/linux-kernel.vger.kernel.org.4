Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C363C6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiK2RuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiK2RuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:50:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951235F85D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:50:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3514DB8129E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 17:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9946C433C1;
        Tue, 29 Nov 2022 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669744206;
        bh=ycRd6/bpOsddiBTr2+ho9ifE5v5GUNPoC+DXJ1wmy7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/jXcv/2r5OUu7Bmyfx76SztZh5TrwuuPEvrw0E+Ikud897UEPCoNim+7pGcsjy31
         HjRzjqG9Jj3OugH3gX+gag2y/ATIG8us1Z42NSgzn8uDC8/DTc1x22+/SiJGJh3AWU
         W/cWLp9Yg0grz0eavHmdTCfiqPtLRcA1uBJA/ltg/6GxdbsD6JI9/gp3/zSYtemWCD
         Byy9bfFJB2ch1JmvBkY8N87zCUVBpQ2rDm4GgsotI8NYbcyRUGUhlj+238WXHmE495
         uEezRBGzDL2jBFRb5jvTeklNPhsGaOFvnKEiqJpeHPekEUvuQfVHWC5s4lScygyV9W
         QzHtCEhqVz1TA==
Date:   Tue, 29 Nov 2022 17:50:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rui Zhang <zr.zhang@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] regulator: core: fix use_count leakage when handling
 boot-on
Message-ID: <Y4ZGSpVWjGsx2nTS@sirena.org.uk>
References: <20221122103251.13064-1-zr.zhang@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Oz+oEfCH8qa07XI"
Content-Disposition: inline
In-Reply-To: <20221122103251.13064-1-zr.zhang@vivo.com>
X-Cookie: Programmers do it bit by bit.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Oz+oEfCH8qa07XI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2022 at 06:32:51PM +0800, Rui Zhang wrote:
> I found a use_count leakage towards supply regulator of rdev with
> boot-on option.

This doesn't apply against current code, please check and resend.

--1Oz+oEfCH8qa07XI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOGRkkACgkQJNaLcl1U
h9DcSwf9EPGTsDZKaQBUpaQ3X9wvMet6pNpxSpEei5KcMVhQRtDZfRWpvegeGAme
IdHKfkuYyF+ZYZvH1RBoQE2/tZKPlKxKZplKK4Cfm6v++vz8EtZEEF+ko0AQTRid
8VI3Sy7NS7EsT2HVWE9Pf19d8lT4Vt/PzW3V8aYEJyUuTfH6LTSJNbVSeWLb3gFF
rLbrIyYMpSeJrWl4YgEOUnOExJhLbxso3udH+GTypwMUkO3F5NDL8eu+b8UfcPaf
im/jJjc8Xuvqswlyu6eb4DiYHgMDyZ2v1gVQbSmSnYuuxXYbO3PirPPG9XirOiYy
nlzwQ1hMbwT/B0sEMlk4/yVgIugvTw==
=K06v
-----END PGP SIGNATURE-----

--1Oz+oEfCH8qa07XI--
