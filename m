Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0C696424
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBNNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBNNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:03:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790623860;
        Tue, 14 Feb 2023 05:03:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8CF1B81D52;
        Tue, 14 Feb 2023 13:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD3C433D2;
        Tue, 14 Feb 2023 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676379815;
        bh=MHDYka/ZDMHL6lJhmsMxhG+q+n7bvOhWhH3cKlaHVak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kO3pNMThmktgf+HrbQ7D682OVJSli1hTvgHRncyS9DYCSwxKEtKd1VkG/XxlETx9w
         ABiSpl/xHnmNegkzcOd4VRIz1c4y8LUpFCUlXw6rGjAaje6Kb6ttO+RvTH8VI2OLUk
         tzPHhcbc3meWqZlvcpulZA8CloaKva5OYIA91tqKkHSgl6ARPwPYHZYPZgLKVroCk6
         WA95wCJH+XvREBq0fNQAICb9Us0hqcqZW7KLc42un6C5vjTAwjWu14VroSM3g6pt3W
         xDb+eX2+skill2ZT6Gun489jmVxdDnaq9sl2lcc1cZ4yrWI62cLLoqnOvqecj2wAz+
         5MVDoVe7WWg7w==
Date:   Tue, 14 Feb 2023 13:03:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: spi: spi-st-ssc: convert to DT schema
Message-ID: <Y+uGpJviop/66Kpk@sirena.org.uk>
References: <20230213192349.17101-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCEjhhAvduqhiov+"
Content-Disposition: inline
In-Reply-To: <20230213192349.17101-1-avolmat@me.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCEjhhAvduqhiov+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 13, 2023 at 08:23:48PM +0100, Alain Volmat wrote:
> Convert spi-st-ssc.txt into st,ssc-spi.yaml for the
> ST Microelectronics SSC SPI driver.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--rCEjhhAvduqhiov+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPrhqMACgkQJNaLcl1U
h9Bn2AgAgxldXNFUP19NOpKn/+rFAEfCPVsP2ERPGq/hnp7Vd+efTzRR9188Phfl
QOHzv3R3Y8VEJO39hgBGVl+vwiI43HdANeDfBWHXuKHMWBWLm4L4U9ak+hssS0bR
2PvXPiwLv5HitW1fYTwwYoEA2fMYjJbKCRd2V92LXGCuUmnPkhVCrDM/29wZhOAb
RXtLtMDz6CI0z6OoFwZTOyXe4pSP3DqjzSD4g9XxJRKRuoqcjp9sCtQuYXNMMItD
L92ro3ywbDmlG1VaaAyCfiDv89PIuepJWWMlSJ8KLAphoOynfmuyCv/n0gOr2UTT
XhZwHwQuA5PMWR4PWTOQOLa0z/N2Vw==
=hvJ2
-----END PGP SIGNATURE-----

--rCEjhhAvduqhiov+--
