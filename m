Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7A745664
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGCHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGCHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:50:13 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3BC2;
        Mon,  3 Jul 2023 00:50:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1541C5C0190;
        Mon,  3 Jul 2023 03:50:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jul 2023 03:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688370608; x=1688457008; bh=fO
        iPJH964JbMWdWtw/Lr9kGAyKHEcXeffDI0IDClADA=; b=5O0eNBSbTrxUjX2Ym5
        2u/+TXoHE2iMdhZX+ASAVWARZj5IBBR4e6LlS2VMSj4qq7G0KRAVlcyChqscWeL1
        7Gv2OxxhpEH0zRSYCNekH8XrQAzQmKaRH/PQBy1CKNGj6HeRBDyjSVFTnsMIvYLU
        0MC7mkInIfkH8N6GeKImgYTaFwxgkoQ6OvjNTOV8cbFfdTDDF25pexDPe9S05WB/
        xwAv8l7IsHSl9XgwawXulUOhD3Q5rCVT9foeNLtv38pZ3TsnbF+QvBds/y3mkhuN
        eRXJmdZONUuVVEp20TGJo9TIcJpY0GVvwrnwZMVIsfqPuzjLGBEi0I9HxKnX6cAq
        ThnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688370608; x=1688457008; bh=fOiPJH964JbMW
        dWtw/Lr9kGAyKHEcXeffDI0IDClADA=; b=k5ZNUpnkNASHl1XDqlS0QZv9vvXJr
        7Z1rRQXtqwyocnI/q3J8KaodIeVfDQjC/s5MP9qN0KyFq1nPd+Ss4yDaoPJiwEKH
        1cuIF4YnOqEiZla8KBt/Gb/C+OL4pvDt5lQExuAhenB7s5DwJUVkPpZ6j8+xy4U7
        CyY8wp6M9c4itQxebu/5/KM0IKcPxEGeoJzAhgmluzrwXGgRd75TM/lbEJClXxd6
        13YOFWcM4GzADROWDLJJDij32zSyQdwm2ToZkzo5+CtL8aj1Ed+K8ldiheZ/cuEz
        jsHuqFO7RXFsSuYpXjzhGZtnZaiP07bODiTKe4yOuMbPj8TyzRbWonzkQ==
X-ME-Sender: <xms:r32iZKOsudebHk-m8NJf4QR533FMlUe21lZ5MiBfdvnM_OX5GtNrOQ>
    <xme:r32iZI8PY3MIUAVeP7Qyxttf3KBeZwA_OPL2txhHJ0Tx7L7SzAEO-o20E_Dzan87J
    ILfhjudCg-7O2Nkz7E>
X-ME-Received: <xmr:r32iZBRyXHLZcWAeFO7kNBdBOagQkz5OchkrXdSC_a-kdaoe_pjj08B8F82TTO_0MyMxcOUsXj4lmS4wt_I9fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:r32iZKv2LYdeX2BOhDNDOxeQlQx4T_t4kpqIU5rBUub3vzhGvx9iTQ>
    <xmx:r32iZCdtF8aSx9QlwgnqDj7gTzHoTGaVkUvHPrwFVBCdLDhJWkKDJA>
    <xmx:r32iZO0f5VZe50vN6Rq0IcMhTYV9Dzymww-DtIb2BLHtplYkLkogYA>
    <xmx:sH2iZDWX3yDYWX15_5Qrq96uLHK6r_AHEMR63PLG-Ti0vIgl3jF43Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 03:50:06 -0400 (EDT)
Date:   Mon, 3 Jul 2023 09:50:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] clk: sunxi-ng: a64: select closest rate for
 pll-video0
Message-ID: <lfcpuv5euy5w6e7jzn6fm2qusjj52w2hhn5sosqvoz54zc56py@5wh2eea3rrs3>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-8-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="scpwnkcrk67jfkfn"
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-8-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--scpwnkcrk67jfkfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 02, 2023 at 07:55:27PM +0200, Frank Oltmanns wrote:
> @@ -541,7 +542,7 @@ static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
>  static const u8 tcon1_table[] = { 0, 2, };
>  static struct ccu_div tcon1_clk = {
>  	.enable		= BIT(31),
> -	.div		= _SUNXI_CCU_DIV(0, 4),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ROUND_CLOSEST),
>  	.mux		= _SUNXI_CCU_MUX_TABLE(24, 2, tcon1_table),
>  	.common		= {
>  		.reg		= 0x11c,
> @@ -549,6 +550,7 @@ static struct ccu_div tcon1_clk = {
>  						      tcon1_parents,
>  						      &ccu_div_ops,
>  						      CLK_SET_RATE_PARENT),
> +		.features	= CCU_FEATURE_CLOSEST_RATE,
>  	},
>  };

I'm not super comfortable with having to set it twice for dividers (or
composite clocks). Could we set CLK_DIVIDER_ROUND_CLOSEST automatically
if CCU_FEATURE_CLOSEST_RATE is set?

I'm guessing we would need it for muxes as well?

Maxime

--scpwnkcrk67jfkfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJ9rQAKCRDj7w1vZxhR
xfKdAQDoedHfL48OImEDGH6Me5/cxerV8zCFt0MPDatzDChGWAEAs70t/UrLzho6
FXnXOCNE5lVTqlIl/hE5si3bdNAfXwU=
=lwbj
-----END PGP SIGNATURE-----

--scpwnkcrk67jfkfn--
