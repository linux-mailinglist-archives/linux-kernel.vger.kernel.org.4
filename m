Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC936EE54B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjDYQKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjDYQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:10:43 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F86015470
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:10:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 60AF42B066F2;
        Tue, 25 Apr 2023 12:10:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 25 Apr 2023 12:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682439030; x=1682446230; bh=Ua
        ojCscwxi86AjVuIh2qCHuKpN/ZbtkSzMZy6PZ+dq0=; b=rs9Bvn6pjM1EZQb5/e
        0ew6BcvE534Wwf7Fzg9YF9G5XCPwkxWv/hHowRoqwoln8M3w6BS3FVaflLkpC/iw
        UnjfQZBhve3krhuivKbT0UBqx0TAkj7+4OQlO2irX93g5wn+D1JnfH8y1k7TjmIS
        bOPHVnyJC/TE/TE6+LwTclIrPAbVmxJg780W82bFwxtf2ZeS7VJT+Kg4wDQD3Hbs
        IqZ7qG30WK3dclE1EGXiMdmvSes9Mg4JZuBnoXpD+4gZClHEOU2eCYRAivfWwZWS
        DFvo8v7297lyTAvTFcoIBF8nk1vXy7STAQaI+M+sgHeRFGcShMbcOnwP0BTfNzRM
        2K5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682439030; x=1682446230; bh=UaojCscwxi86A
        jVuIh2qCHuKpN/ZbtkSzMZy6PZ+dq0=; b=iRfpC/KUuKid9v5Vzv+Nd4uFvSOmv
        9Htvapj5EI3Et4MTXTMqhfAgGar2TOfcXCAp92v7w59J8Af/HjgMB+SpLoD2whu1
        +6B+zOXJOLpRbFCiES54J7AnESgWNWfBR9XMLAqA8cm+pasBqqjDZYEy2O3tRrxV
        05HeNsYYy5RxjMLSYZpwn+6IFLNEjwVITNM6+ALzGLZbBLh/cKlWliuznrRqh78d
        MP2LJZoFh/JdSBWc4M2412zL6CDbTBilhZlINlBlW4Msy2a0cfz88HNpDUa7KIRH
        3Y06ShqOzp3/tIrhGYbHW21lnTsnSkVPkJ0PuWBdhPwNaNfFS+Zp9pDcA==
X-ME-Sender: <xms:dvtHZERRfaU0QMkLYwj01ATOOt1tV4CZNOano-vE55h_mvXjxTHEHg>
    <xme:dvtHZBzOBDgCqomITd47pDyJdRVEREhLYAkO_FxLKOtryFKk8x9bsYTJQtANZ2oq1
    t3Zmikt5MqjVQ6hFgs>
X-ME-Received: <xmr:dvtHZB1CaWxHfHYGDX3jCUtQ8ud-eQfrwBcpiDn2orGEav4ztX6qByJkBR8y_e0flDDCL7J5FITU4tdehpawrRO4A-jk_1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:dvtHZICg1hf_RrP49Zi1_AhugxGpaAgGWgcjeBGcexA4DETOmd6lMw>
    <xmx:dvtHZNga2Sx_rdmPqqyjyeq6RiP-XAK0SsBbrCFFZO16e-q_Sf_EOg>
    <xmx:dvtHZEoalbbm5lyqLNg6HKNezs9dr-IHd2gDEd1zkhj8KX8oSwBnAQ>
    <xmx:dvtHZMR29DgSlFWknbJFm84tT23VE-RXf5EPdHnaidpBhWQf0ZCd5NDsb6k>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 12:10:29 -0400 (EDT)
Date:   Tue, 25 Apr 2023 18:10:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Beranek <me@crly.cz>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosp.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] arm64: dts: allwinner: a64: assign PLL_MIPI to
 CLK_TCON0
Message-ID: <loz3kx53jl56klgwpiwcmwub4flilgts6nxvdbxashed25c5m4@jqmgtcdw5z7a>
References: <20230418074008.69752-1-me@crly.cz>
 <20230418074008.69752-5-me@crly.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wfstf36tsrjcb6td"
Content-Disposition: inline
In-Reply-To: <20230418074008.69752-5-me@crly.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wfstf36tsrjcb6td
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 09:40:05AM +0200, Roman Beranek wrote:
> Assign pll-mipi parent to tcon0's source clock via 'assigned-clocks'.
>=20
> Signed-off-by: Roman Beranek <me@crly.cz>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 62f45f71ec65..e6a194db420d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -411,6 +411,8 @@ tcon0: lcd-controller@1c0c000 {
>  			#clock-cells =3D <0>;
>  			resets =3D <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
>  			reset-names =3D "lcd", "lvds";
> +			assigned-clocks =3D <&ccu CLK_TCON0>;
> +			assigned-clock-parents =3D <&ccu CLK_PLL_MIPI>;

assigned-clock-parents is fairly fragile, and it's essentially an OS
decision, so that doesn't have much to do with the platform.

Just force the parent in the clock driver, and prevent it from being
reparented. It will be more robust, and we will be able to change it in
the future easily.

Maxime

--wfstf36tsrjcb6td
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEf7dAAKCRDj7w1vZxhR
xSYEAP9ufal853zPBswPlSP34CsO6Dbt8fsbiPRYUozvKqvluQD/Xizu/MNXPNTL
5be4XrGm/g+J+J6/+WtdZT9oLQQhwgI=
=CC4z
-----END PGP SIGNATURE-----

--wfstf36tsrjcb6td--
