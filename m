Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C05EA9EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiIZPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiIZPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:12:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E536BD78;
        Mon, 26 Sep 2022 06:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FD72CE117B;
        Mon, 26 Sep 2022 13:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E06C433C1;
        Mon, 26 Sep 2022 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664200374;
        bh=k2v2n6t+zyTtuffx7weAcWN3TAtXEyIzoAOkq3FF0Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+wCJEHKuDkYjLEnPimAmSKirA+Ctq9eB2VUUtgomOI75gD7fnLhPa4GX/rd8w4k3
         sRuM8oF435uBmthiHo46RCnk5a2dwvTv24g1Kfw13N0vOC1Vvj/Xr+fc1t6q/OkVzA
         QTPWumRNrh1y4mBvPL5kZd5+5yN1iMdbdNfxoR4LdXWZnVPc0nVW+1aYDAOAl2d2FN
         qaHAGGj0rr7jV1GOwhkBFiPzRFkMpSK01ivB0RG4l0p5R1jgMqT97f40/LjDdpwPNJ
         iffoDgwkGSGL0d/1vy00aSoXacPuxiIy/vICeaXq8M1MUxTjjnKUafArGCcPJ2qv91
         br9xx7llYtuYg==
Date:   Mon, 26 Sep 2022 14:52:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     krzysztof.kozlowski@linaro.org, andi@etezian.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] spi: s3c64xx: Fix large transfers with DMA
Message-ID: <YzGusRaUtlFLT/d/@sirena.org.uk>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
 <20220916113951.228398-5-vincent.whitchurch@axis.com>
 <Yyh+5ZWXel9SHuWi@sirena.org.uk>
 <YzGsRkyf9tyvjvBy@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2B5iSHg34y3l+us"
Content-Disposition: inline
In-Reply-To: <YzGsRkyf9tyvjvBy@axis.com>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2B5iSHg34y3l+us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2022 at 03:42:30PM +0200, Vincent Whitchurch wrote:
> On Mon, Sep 19, 2022 at 03:38:29PM +0100, Mark Brown wrote:

> > The driver should just set max_transfer_size and let the core
> > handle this.

> Hmm, AFAICS, the core doesn't actually do anything with
> max_transfer_size?  It's only used from spi-mem and a handful of other
> clients via spi_max_transfer_size().

Then we should fix the core to handle it properly.

--L2B5iSHg34y3l+us
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMxrrAACgkQJNaLcl1U
h9CPcwf/dCCgo2vJgex4YoE9LuXAMMgWan1cVainA53TfW5JXJfMRtrVjgTxYo1t
pp4NRfMegQoGHns14myH4ZLz01Y3qEnjf/zYreebvGdfeCmC9KyHPlFykmd5dB6f
KESZtj9c/x3Zlq78P1z3M+Hop3Vtb9lJrlHkTAC0cH+faQ62oHepJhNcF2dqTtol
kyN6VzVsT7EtmvEy2QxghNSjX9tj8366QicwkIxVJxigo11XrPoh7WNpIj4/N8hH
2PYCM7HzOgmVTxfp1hubtLtWmfzSBp5FSfqdjYspERoOsPXdJ9yQDQpONs7aUO7o
Z3llLjce9oLNS+fnxbQLwjfolyee0g==
=8bk7
-----END PGP SIGNATURE-----

--L2B5iSHg34y3l+us--
