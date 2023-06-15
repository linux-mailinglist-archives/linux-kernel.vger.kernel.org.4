Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D95731E25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjFOQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjFOQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:47:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F42D5D;
        Thu, 15 Jun 2023 09:47:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 90A685C0102;
        Thu, 15 Jun 2023 12:46:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Jun 2023 12:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847600; x=1686934000; bh=Al
        OuG6PNs93exqL769S9HMnsloeBXg7DZ3ft2P5Esy0=; b=qXBzgAsIUN8NYop63E
        d1smNeyIJZZLMh7Aimx8z1wfEbS+ZIVWOGREOTkPTTgg7fMdU6918zyp2XhbEHVV
        FoqLVsfqhnAQBG/8XoRo3DGzmBfCL7NxKMV50JsOENjJ3EKaiBQdF/OgIjdM6vMK
        cqDGTny9RCyLAk+UL24LyQSiathi2odNa+LEEdOX/Z+gsUFNFMiq2Grm2MSMdxSC
        C59mA3z/79wF6r1x86t3ox2qt/2fgbrvrbtKm0L+B7Loky8wg5fS3r9hWm3b93eI
        kqAARB69tvHNagkNMaUJRFm8xWKVtwwCGMZDpyOYH3L7lG76Z5KnvOOjyBVHqq5D
        +rzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847600; x=1686934000; bh=AlOuG6PNs93ex
        qL769S9HMnsloeBXg7DZ3ft2P5Esy0=; b=JeRCldvXOleYf9GAQhgrl2KtxV5Cn
        TvCugHC/N0Gblg78AKpwxd7FLjxXQdD0qnHoP2Z3GHdfh5Lh0KqKT80cBpIOFpdH
        lYFsONCz8Bx17svAlBX/oMWfexLfIWO14a+XXXOHsMTTg5iCqFJX2pDAkEwJ5cl5
        v3Wo/wF+1RxDqhxyK39mR/3cQr9blE9MFidic/ixk7+x4VRztDG5nr52ezhlM7HK
        6Cb/wUXMtSn6vWXi0zQNWxpmQYc5egXqZuMe2v5jQienXGMqTYYNtUTnzrdaSWeg
        16Qjqu8fOnA261XWOgweyl4iMxnxjeQTJbJcql+EmtAmfmNLbCvBX4Wlg==
X-ME-Sender: <xms:cECLZLSBTdI6tOXvSe7xOnTqO8j9ARiy8dNgRRkGAyJJQsZuWSebwQ>
    <xme:cECLZMwNbh91zlTZ9dUvhmws7HhikoVqbYfiKGtVS5EUecKKjJ_hPJ16TQoMmClNA
    ZJP_x3zEhBxKvGsK5w>
X-ME-Received: <xmr:cECLZA2AsdlP01hZ-cJ1CJauIY_FQQnvSm9DttF5swkoA8b1qnsYLCVvU15r0EyobVk0c4ra3olgFUmIHKPu4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cECLZLCffsC7mBt9s4pVLvzAbx-Fnv2TV4BCO2kM5wJ53Kr4c7gFwA>
    <xmx:cECLZEji5csGdL9ZcYR0Pauc6IA789vU1DRHX5OAOsJBymdCVL8x8g>
    <xmx:cECLZPqkdOUuMKbVSQoo8b-4RGrmjhozlOzNBf0CyBhtExBVpN7jMA>
    <xmx:cECLZNWFpMYW8wb3ym8kZ_ovc0IUfVAlTMQqAVWoit8h4OAnRYhSkw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:46:39 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:46:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] clk: at91: clk-generated: add support for parent_hw
Message-ID: <adyhnl233cbcruh7jtmjnlelpd6bfjeqrpgjf5nga55ditriqe@epkuhabb2ypk>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cn6afijotohso5ln"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cn6afijotohso5ln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:18PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in generic clock drivers.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-generated were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--cn6afijotohso5ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItAbQAKCRDj7w1vZxhR
xd8EAPsHzcGPnHWU2rtQAHnafr9HQ3GEjMyIY0RcCWe6eU7njgEA1JBP2+obevM1
HHuRmtlisrPAeQxGhayXXMyKQfBFpAc=
=uOKV
-----END PGP SIGNATURE-----

--cn6afijotohso5ln--
