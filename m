Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC748731E32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjFOQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbjFOQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:50:11 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B72952;
        Thu, 15 Jun 2023 09:50:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 51BD15C011A;
        Thu, 15 Jun 2023 12:50:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Jun 2023 12:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847808; x=1686934208; bh=BZ
        U94koPKTLERhvaih/Gnl/jt0ifWyqUPkOp6oZTa3k=; b=kqYLd9dwCIioix03qS
        WVo2RLf7O3YGVg5iCTZUH1v/pFVj1eT0bMbHwgs1zyjLcg/+R+fcC+f1YqXI/F7C
        9otMQEh63S2XYa/312X3RtxgqT6pHQoDud8G27r4Sv6Wy7OorY6g8vxTDaV3oVEW
        2ZeiHA1PUMMAdaONva13tkc0EOd8JAZfQ/hG2leQLGx0otNpKKJFtxLSYBvkiO7Z
        tFQVFHh3og0VWgtzqm19PRQ2RvqHM/NTQhsZMloJ1mexUc33scC98Iciy1XxaXa8
        qUUEiTQ6IWimwwLQYLcixss2RdVZA8e8Q/73Aa7JSo+HnebiwAN+G/P7SND2uBN3
        /miQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847808; x=1686934208; bh=BZU94koPKTLER
        hvaih/Gnl/jt0ifWyqUPkOp6oZTa3k=; b=mwLkj2K77dVhOMzFPvX9c8dgieN3N
        uyQL234Z1cT/xXWzdJy95kGrUBQgjRKky9zUaEmTK0JE81PSy0/iG0psL/NKtfBA
        FdGf63sDnDo9+B2SdcmEaL4X3RZgINO7UiDcDr7zmSejHbWZN8YOtIoZFiXwbk7K
        iGCizT2PuQlgFoN2eeWqSSE6czogYtOx8Pcc41gNSSRo+NmpcKKWuYm5ljR+52Wr
        2Qdp/FmDiA1xpjvSc8TExF0GC7tZfB2ocZyU+D+P5bcj10EZYjY7tPzV51l+ti3o
        Y6vZ2sXJfpiztqS0INjYOqTx4cXOihGoVPI6kaAURq3tMPQY+yUISE1JQ==
X-ME-Sender: <xms:QEGLZNPxaLu9ii7EG1b6HiEdYpTtVL079DNla2WNRB68E5A9GC_xaQ>
    <xme:QEGLZP-kbEV88fXlXoOr0vbeI8LLLm3AnR5F8dTUtCvNBNVP9G0t0jdb0btnnJTso
    CLn0LAT4R-d3NPKd38>
X-ME-Received: <xmr:QEGLZMSy818Y4anzRcZgSri8LnRlkvPB90xSWBYGNjdkq_WuLaeg4u8Kh1p0fq-I0UKfTDsV-VmiuaD9sJUT8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QEGLZJuh8tbYbtp29Ql6bFDNuJK658IGEm6TGgTo29QTwYG7hYYH6g>
    <xmx:QEGLZFfVpyMLaO2wZsmjg2pnzXZeUOmejCcB1ucD_JzYYJ2b_pfhwA>
    <xmx:QEGLZF2cPJcPi9vg7hUlgXcbHtSGkvt9Ly7lG3KXyArmDwpeWmDejg>
    <xmx:QEGLZEzUxPwLZ8hiieLif0dBX3c6jwCKWYlIXCToR8taclHUh34zDg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:50:07 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:50:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] clk: at91: clk-sam9x60-pll: add support for
 parent_hw
Message-ID: <6xk7ua42x626lzaj7poo67fiuzlclgplp2zr7t3wdsnzib2wbj@qmgbh3gvy2ph>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-9-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zrecytlzra4fazcl"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-9-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zrecytlzra4fazcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:24PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in SAM9X60 PLL clock drivers.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-sam9x60-pll were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--zrecytlzra4fazcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBPgAKCRDj7w1vZxhR
xT5fAQC/wwrldw/IE4iHv/BwH6pHfCq36a6SXAGN5xJ4Dqq4nQD9GoLHfQjd6FN/
yQE7h6PGLLgfVjpkukVAtTS27LAJLA8=
=F+ce
-----END PGP SIGNATURE-----

--zrecytlzra4fazcl--
