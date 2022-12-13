Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19B64BA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiLMREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiLMRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:03:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C52251A;
        Tue, 13 Dec 2022 09:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEDB3B812A2;
        Tue, 13 Dec 2022 17:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E66EC433EF;
        Tue, 13 Dec 2022 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670950892;
        bh=uH0LYOSexEh5rmYdYN0yvY9zCHzaNdE5DduFSGRtqbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMVuCAzlQrQHOlsgTwtFZ+g2DaAoEPxa0+vuEZjFvdj6e/v79u0Kle9K+EB37sTht
         bhP1tiiO+FoqeCieMeEcTS0vq1TtyipfxvUflLhdGnwp5xh68oULfypFNoywHnDSCm
         /iA2G+keMD7peo0uOV1NSk6zf+DhsttgOoUGAvl7WpzIfnwzOJldQxrz5ccnixN+hw
         CR0vpp9gmUKY7Nb9Rc4GAZ/ywx5wY6mx62VbO0AF2ZTgW/TobmW9yIPZmeN4LJV5F1
         uTVIghQx24MF7a24ZgmhTDCiseGw1S612dXJFShK/W/3Uz55jO8i98n6tehWX0LjtM
         25PbCqI2G18Hw==
Date:   Tue, 13 Dec 2022 17:01:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
Subject: Re: [PATCH v4 1/9] spi: mtk-snfi: Change default page format to
 setup default setting
Message-ID: <Y5iv5kPsOFm0OQni@sirena.org.uk>
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
 <20221209064317.2828-2-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jC3ytWRRxsiHrz4c"
Content-Disposition: inline
In-Reply-To: <20221209064317.2828-2-xiangsheng.hou@mediatek.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jC3ytWRRxsiHrz4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 02:43:09PM +0800, Xiangsheng Hou wrote:
> Change default page format to setup default setting since the sector
> size 1024 on MT7986 will lead to probe fail.
>=20
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  drivers/spi/spi-mtk-snfi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Angelo, you've not reviewed this one - is there some problem with it or
was it just missed?

--jC3ytWRRxsiHrz4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYr+UACgkQJNaLcl1U
h9BU0gf+IvrSdMswYwsbTgS7DBClWKuOuNQAt7lGGUz71eyMXy9UAzCuEDoScV/w
pB+m2dTLcH79ILHq3hDSDj5S/DjmXwJi6Li/mHhYHvk02J0r6WDrU2zw3z2SECrc
fEB8quuER9gh7d9QInhiVNRbNoSL4WAE0B/qIhA4CxJEBximJKR8j0Z/tSSa7GK3
hQ9hudThr90bPE3ykzjPwygyt0uVMgqLHq3zuVX2azJ9yXmrbfWQn6xHvxGXfyt0
3eeRvgpqUL+FpIMvShXLit8oIoZ5tw/HEa5K2I9RlwAja/TnX1ph49NSRYE/swwk
8TCiI+HH1h0TM4w9Q6/TRJMSq91cxg==
=XCqN
-----END PGP SIGNATURE-----

--jC3ytWRRxsiHrz4c--
