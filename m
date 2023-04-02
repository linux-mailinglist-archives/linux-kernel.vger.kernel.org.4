Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF76D38D6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDBPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDBPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:41:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A9D30B;
        Sun,  2 Apr 2023 08:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6707B80EB9;
        Sun,  2 Apr 2023 15:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470D0C433EF;
        Sun,  2 Apr 2023 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680450104;
        bh=X8FfzYHrAuUKE3zJ6qzT9QqKCngtcx0tl2Nj4mn67Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bb34a33KLaz9DXa3ewP7QXMwl+2z2fuAcHWK28Dm3ehJEFLVod+RL2F46G4QIHDP4
         WBwZ+fOPLzVPAjM4ThJrW5ekbo2iNlzQyrKL346y+OrxRitgYbuwCyPdfZmlokkIno
         9R7CRAtM/layBYNhmnu9TTOnUK1epCLlkl/HQZQWrpSL+dUWdR2zueuQofaauU2QC6
         Q8x8mzQB4WXbqn420KJEZJJoCCVO4QA4qZo2m7zulaNPOaaD6kYmJm7QI6ppRC7lLo
         M79C2C1ZBWGkK7B9j0ZXi8FDpogKKBhgz7vEy0l6+anjm982tJnbajIdfIrebvxDy0
         yeJlSETqROVMw==
Date:   Sun, 2 Apr 2023 16:41:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v6 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZCmiNSxMWmdolMub@sirena.org.uk>
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
 <20230401095652.17364-3-zhuyinbo@loongson.cn>
 <9fcb66fa-aadc-8660-bd4a-452c4811ced9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvXndZYD6JZZKYZ4"
Content-Disposition: inline
In-Reply-To: <9fcb66fa-aadc-8660-bd4a-452c4811ced9@linaro.org>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gvXndZYD6JZZKYZ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 02, 2023 at 12:04:00PM +0200, Krzysztof Kozlowski wrote:
> On 01/04/2023 11:56, Yinbo Zhu wrote:

> > +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
> > +					  unsigned char data)
> > +{
> > +	writeb(data, spi->base + reg);

> This wrapper does not simplify anything.

This is an *extremely* standard wrapper which adds the base and
register to work out the address to write to without having to
duplicate it for every caller.  There is absolutely nothing wrong
with it, or the read equivalent - they are useful and helpful.

> > +#define	LOONGSON_SPI_SPCR_REG	0x00

> There is just one space after #define.

It's using a tab which is again not the end of the world.

--gvXndZYD6JZZKYZ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQpojQACgkQJNaLcl1U
h9DtrwgAhNjHfhiDX2uDjuOLGg9Uls8GWn70l02hs8RXoyyz11Z+s7ZZPrpIPsVb
ztuyKMKes405NVC/wWM8H5bM4HRaMXu4+AxHNDvU+5btyoHEaFdNS4ykKviNFl2Q
MKPtOp05bMZO+mjVJlxdTKN0dvWyCvbsfqoDUB+24BzrGftUnL+XrepL2nYt31AW
Ju3aKRNNuM5lUQVoDw3JMyYHw67H/hXjFMfTR+rZV2MfBEPU+2VMAdZdclew8IGz
RcnBiP+3ybiVEBonFNEoK+zJU9Mhsm/1pvejIRGk2MpeE0tnGSWQlE4f3t2/keek
6Q6w+ZshfhM+BCukFyNsi7Hv7mn3fg==
=6S/o
-----END PGP SIGNATURE-----

--gvXndZYD6JZZKYZ4--
