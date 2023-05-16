Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1757051FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjEPPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjEPPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA3113;
        Tue, 16 May 2023 08:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8417061358;
        Tue, 16 May 2023 15:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C52AC4339C;
        Tue, 16 May 2023 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250577;
        bh=v3khn2qaXA16HTUtgz0oG/C+/wvqlltw+erESJStMg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=un0SOnED+udTHYUV86fff16uX+tEOzlXNy8FAI54mIf04q0HzTGHBtc20D6HCmYRh
         aUQqiAusXT7JQmzLyiExPCO8yC+pTpkWF+BfZBrR7n574hiSmI/dHTKnomFC2UVTcE
         W0lgP12+sNucB5UZDzzWkbakAjb8NpPZV9GoUwIfTLBKQq4Qkv4AOizY5aPsPncuno
         qmJi2xrufdY7PwPkqlJouYrJPbSAChrau74TyyiDzGJYl1K4IEHnvjUR1p2LDQ23t3
         Twcy4EUMs1KB2G33xO6twHoXdgREWPVRCf78KmznpGOMFKl+5Dny5HLFqwfN3cnPRx
         xU43in9RBLbTg==
Date:   Wed, 17 May 2023 00:22:54 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Message-ID: <ZGOfzspBW4/inoXe@finisterre.sirena.org.uk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
 <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
 <9f403dd7-1ac8-bebe-1b24-bede61087bba@rasmusvillemoes.dk>
 <38eef5df-ca8d-41f1-93e7-e13c1d7b6232@sirena.org.uk>
 <a56c2cec-b10c-ec73-2179-6b92251a7419@rasmusvillemoes.dk>
 <9f9d4f04-70d1-7d62-7d27-c76e80d2861f@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kqyCqZiqJy17bCvW"
Content-Disposition: inline
In-Reply-To: <9f9d4f04-70d1-7d62-7d27-c76e80d2861f@prevas.dk>
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


--kqyCqZiqJy17bCvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2023 at 01:43:23PM +0200, Rasmus Villemoes wrote:

> So, what's the conclusion here? Will these three patches be applied, or
> will we just live with the status as of next-20230516, namely that

As pointed out by Amit this will need a resend against current code.

--kqyCqZiqJy17bCvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRjn84ACgkQJNaLcl1U
h9DkoQf9GWlOzilOU7ZrPzq6wS72EN5viJTMe3H5ndQtocCUrI/Assfd4M1BPGtP
3Lw8wLAWxe3KdQLzhLfJ0pJPE4H36tQ9VDg2FOUUHkSDicdJXgb9ITZAeOiL5utv
YMkUr2k5wjGgCF313grLLcyLcnRpkjN4shtSCc3mC+97AE9+AOxP/z/E+WN2JaNL
/Id9IMb8jIWo8SDmGRN1VtXDXL/z6BQsCvBXpx71vksr/fFgFY7p8kT74oM4aIbv
fw8zKY/9g7J5xjx8cB8otTUWW2JdbmmgR95QouNTzo7SgmqsPKEeOhvpC0LuwZXu
fu8dvbK4Sh6eEStj0xNMzcldi40f6A==
=Y5lk
-----END PGP SIGNATURE-----

--kqyCqZiqJy17bCvW--
