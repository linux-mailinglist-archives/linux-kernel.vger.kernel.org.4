Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B8681635
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjA3QTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjA3QTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:19:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA18A7A;
        Mon, 30 Jan 2023 08:19:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2006118E;
        Mon, 30 Jan 2023 16:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38D2C433D2;
        Mon, 30 Jan 2023 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675095543;
        bh=njr6W+Xwj/RIjnPwkPZx0WPEFYVoTi3RI/NZkQ71He0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4pV9f9QVf9hjJO00A1v6XCQxfx3XVceL2Og+/lnnm0Nb1idnuUlwNImdtKyDjoQy
         xPO3+WYVshtAzycehccoXY3U8yGDgleBYbqnLB9VMNOZLtUMbQUs140UaDu12+HkzT
         /eXZf8rra8k7G3b519MGLAU0Yb948BS3vzGE9Gw0VAqkbe9Eo/YXpniDWCWxQoTKhV
         Kdb1xyoVTjQ9Upq3kUTM0L6L7kHF4zY1V8nh073JfkVyxYBDhytNnjKzszIYD/Mkgw
         ympSumFq1JWmAyCTaA/i1M5yk1hdP+Gi3LLP/kKMtQmrjQYUdWzuuDUv6F6reHOb8/
         2ni4oaiuI7cGQ==
Date:   Mon, 30 Jan 2023 16:18:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
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
Subject: Re: [RESEND PATCH v5 00/10] Add MediaTek MT7986 SPI NAND and ECC
 support
Message-ID: <Y9ft8BIzESLQ0TTh@sirena.org.uk>
References: <20230130030656.12127-1-xiangsheng.hou@mediatek.com>
 <20230130171145.2c844d34@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CMu4i+MTxKFAnMnD"
Content-Disposition: inline
In-Reply-To: <20230130171145.2c844d34@xps-13>
X-Cookie: Some restrictions may apply.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CMu4i+MTxKFAnMnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2023 at 05:11:45PM +0100, Miquel Raynal wrote:
> xiangsheng.hou@mediatek.com wrote on Mon, 30 Jan 2023 11:06:46 +0800:

> > This patch series add MediaTek MT7986 SPI NAND and ECC controller
> > support, split ECC engine with rawnand controller in bindings and
> > change to YAML schema.

> I would like to pick-up patches 3, 7 and 10 and apply them in the mtd
> tree as they look completely orthogonal with all the other (spi/DT)
> changes, am I right?

> Mark, is it okay for you?

That's fine, assuming there's no dependency issues.  Xiangsheng, it's
generally best to avoid mixing patches for multiple subsystems into a
single series when it's not needed since it makes merging things more
complex.

--CMu4i+MTxKFAnMnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPX7e8ACgkQJNaLcl1U
h9CP4Qf+Pd13QIe/NKJYmT5Ku/sdC2wKEgISZktdgp6nkJnezPBcHDPZMRAovciN
tEkeKbKAngXsLPelmzMjY5z14PseLyy1afFboVV8Vz43LUE144H9WRx917uqatkP
/QCJ0/l9/izHntwO0zWOPNIomAyoITzsO8Sk79DmtqEMjSx7GNMrr3xX1RaxHDam
O2J/ho0Qt84u81akb1jCSR6yWcLO0AJ4gJ5FYby9GU/qIGpdSGYGppQ2uAVJUSsa
Hn4knoLT4QarM9J+obdb1FQz6GHRB8hTRaqMrAy1reHcP6XEJgkaQkxP+cFc2RRS
5o+l86XRsBjIv5jTxDO/VSl7U3kV/w==
=fnzJ
-----END PGP SIGNATURE-----

--CMu4i+MTxKFAnMnD--
