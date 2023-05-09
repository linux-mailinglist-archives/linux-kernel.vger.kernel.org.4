Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99BD6FBE4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjEIEj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjEIEjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE767688;
        Mon,  8 May 2023 21:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A5C62DFB;
        Tue,  9 May 2023 04:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADADC433EF;
        Tue,  9 May 2023 04:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683607157;
        bh=XhiuFaCJ6NwdwKam/Cyef7P/+G3d7UCQ6LK4Q3XNOfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCT8dSEOvZ+0E+qJsK2en3YBzm3oFErN2H4XkAsssS2KA/dEuyyVbCI100mdvBrC6
         3irKQRyTq7FY2WNCB3nwhPWsrQ2fXIn9NKCBFAe3OCAPan1uPqrELyzOQB9I7HPLQF
         ME1CSxMkV6GZ2mdGMpvCKSlWEf7LC3bjHwENE0Ee8zyCv2oDUvWrrBSIQ58xrHu8fa
         rGTOrXf6VfP147tIvFo2KVSdz4c3spSfK3szkPmnll4noubg6EbMnqpSmzU2bK1U89
         DYtq0y6HRrQ5giFj3XDkkXJIIa6DM1IBKyjX86l1TO78I0kiS3lAeVm0g6IeA2J/Dh
         OU7vETfYR7Svw==
Date:   Tue, 9 May 2023 13:39:02 +0900
From:   Mark Brown <broonie@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZFnOZptCM7JDFTQz@finisterre.sirena.org.uk>
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn>
 <ZFkPZhF8QqScXAmH@surfacebook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PvPFwm68AkT2apH1"
Content-Disposition: inline
In-Reply-To: <ZFkPZhF8QqScXAmH@surfacebook>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PvPFwm68AkT2apH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 08, 2023 at 06:04:06PM +0300, andy.shevchenko@gmail.com wrote:
> Wed, Apr 26, 2023 at 03:10:45PM +0800, Yinbo Zhu kirjoitti:

> > +		loongson_spi_write_reg(loongson_spi,
> > +				       LOONGSON_SPI_SFCS_REG,
> > +				       (val ? (0x11 << spi->chip_select) :
> > +				       (0x1 << spi->chip_select)) | cs);

> Too many parentheses.

The code is absolutely fine, there is nothing wrong with adding explicit
parentheses even where not strictly needed if it helps to make things
clear (which is obviously always a problem wiht ternery operator use).

Please, stop this sort of nitpicking.  It is at times actively unhelpful.

> > +		bit = fls(div) - 1;
> > +		if ((1<<bit) == div)
> > +			bit--;
> > +		div_tmp = rdiv[bit];

> I believe this can be optimized.

This isn't constructive feedback, if there is a concrete optimisation
you want to suggest please just suggest it.

> > +EXPORT_SYMBOL_GPL(loongson_spi_init_master);

> Please, use _NS variant.

It really does not matter, the chances of any collisions is pretty much
zero.

--PvPFwm68AkT2apH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRZzmEACgkQJNaLcl1U
h9AJXwf/bcA5vAd/CeUpexx9xVC7N3Q3Um30fxyeECrqf+W5wNVVem1NNz0HDn+n
vPaQ/8HhN/Gdu+A6tLZ1pzepHE1+E+E5kcMgYJHNNY7EPFs49BXvHSqN7IyCxOCm
sUegi8DfHJMK00T1w5AnRK/mY0TeKwBz0kHP8R1qTCtjZVn6rqAgrSLQoQ8t9RGF
Znln4s59Bwt2AdavPgQ3503/vwMkMIZQGW9FPoaf2KWD17MNAUVUkH9eD81b0WIF
6Uibp0Mk898jyQDW4UwqyfM66xdb9k17aRFeFzbRJfWL0jeXHdbUWJsMwrOB5QJ6
jeGknTmherSiz61uL4rkk7VW1Ia2Kw==
=s4B1
-----END PGP SIGNATURE-----

--PvPFwm68AkT2apH1--
