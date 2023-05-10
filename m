Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5B6FDF93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjEJOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjEJOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:05:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66C46A9;
        Wed, 10 May 2023 07:04:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 25D705C03CB;
        Wed, 10 May 2023 10:04:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 May 2023 10:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683727499; x=1683813899; bh=wM
        6SDco88kp4YADCbkeOBWt0pTNKlI1nsYPoeHLmTzg=; b=AjtDMh7JqzUXSz5eph
        BeAQJ5/xd6gdK++n0BxRqjYtS5ztp4GA/6XyQcrIasbItlL0Rx4IS36McYHRHsjC
        ZAj1DHVdGmpPof6JaVGrsL62uFw69VULRzLVxiecAQGlCgPWkeJXbDJxvE0puzU4
        4eV6cDTFoWCPOVt4h0nJQGJCHV0DusClZOpMfF2kgk+KT+wYj7+PCKqL+owV68UO
        IqBkeU7N17+iTvawk0NV0sz/SrL10ARQoHqLZ89hz+ixRA23fBzHZ+u1PABjck3R
        VCH6khum4cyaRT/cDc6YycGTE2t2i88+lN8lLFJ69s6+o8xlU/Kfjs680UJdUi7a
        VSbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683727499; x=1683813899; bh=wM6SDco88kp4Y
        ADCbkeOBWt0pTNKlI1nsYPoeHLmTzg=; b=NVkLjC71xQBYAvTfvwaNfOZs0rRn9
        y0jx75Enqd0/fj2mmwk6ZNx2r/7pBD0A5IwdR6M6Bbnkfq4wCkRkKevH83l4oqlD
        LJkPMRAoZmLfQzfi9aoUfFpg1vqFKGZ5zRNK/t+uP6SFgoJ9NR5zjlCUDhPLyavS
        u9zQVZF4ucoAFUaNLAB/yk4PiIeEnGx6Qi7DRIjimdVm7trxdyEU/RysCByJ/P/1
        6vRi0YBTd6InvEHNBylxEAElKcuh3ut7BHrow6FvGvdV31jFw3EQzo2wSAXz8Gsp
        o9Guq+So5cRWTzt3iSqM/RWNx6Gx74j/TVP9jEwmxa57XNDvx+MbWywnQ==
X-ME-Sender: <xms:iqRbZE5mHkpDfkwW24tST7xzvjvlyK06eWfpOabw8ZZ169Gtgi9ivg>
    <xme:iqRbZF6_uRqkW0BJNbmj2vyo6SxuVUE7WRYUXIoF5Iur6FwKTopD1BehW5Y7lIAnl
    I8ZsK6woXzNd_aWu5s>
X-ME-Received: <xmr:iqRbZDdHDSnKK1xKJIXg8_L1--QWG-ojnsC5mGnbCC5nTGxv5fmkxzkQ1cv2I8_Wj8YN0UHTDIMQs5dOLLMSAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:i6RbZJIoOgb4RbcB0A0K-hlSabZdGGk5ob2w8GQE8V7ugCRkMHKYwQ>
    <xmx:i6RbZII2EiYyRvHhb4-biDYlTJ6c1_B5SF3JfQBDFGpe-oCwsEZqqg>
    <xmx:i6RbZKydeA-Hj3dtsn4O3gHbifo4687BY1ygrneaA11KV7oMW0-vwQ>
    <xmx:i6RbZBdzExa4XidpaQGSPZ3h0ne2ZnnKViGyTcDjeXCC6y5XJP6SGw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 10:04:58 -0400 (EDT)
Date:   Wed, 10 May 2023 16:04:57 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Beranek <me@crly.cz>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ARM: dts: sunxi: rename tcon's clock output
Message-ID: <42ggtl2bdnu7lq4qfz4jiil6muoidv3ootqwlph2ka4hf5m4tt@onfdg3qk33mn>
References: <20230505052110.67514-1-me@crly.cz>
 <20230505052110.67514-3-me@crly.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bkrodvy425jnr2mo"
Content-Disposition: inline
In-Reply-To: <20230505052110.67514-3-me@crly.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bkrodvy425jnr2mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 07:21:08AM +0200, Roman Beranek wrote:
> While the rate of TCON0's DCLK matches dotclock for parallel and LVDS
> outputs, this doesn't hold for DSI. According manuals from Allwinner,
> DCLK is an abbreviation of Data Clock, not dotclock, so go with that
> instead.
>=20
> Signed-off-by: Roman Beranek <me@crly.cz>

Acked-by: Maxime Ripard <maxime@cerno.tech>

--bkrodvy425jnr2mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZFukiQAKCRDj7w1vZxhR
xSBWAP9JfPrBAPEs/DfFGQ27+DE+19B/UxW5xlVLe4YhNZiMVAD/X7jPhUkCz2ph
Pq7rgjT/bJu4Uj+TvNiQvXc6C9g3pg8=
=jqnF
-----END PGP SIGNATURE-----

--bkrodvy425jnr2mo--
