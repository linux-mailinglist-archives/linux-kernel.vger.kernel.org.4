Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D37731E31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjFOQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbjFOQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:49:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279D1A3;
        Thu, 15 Jun 2023 09:49:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A571C5C00E8;
        Thu, 15 Jun 2023 12:49:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Jun 2023 12:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847796; x=1686934196; bh=w8
        Es8k037nukRduWOvds6FkLeGIi3U3V1qR32gcTXY4=; b=13iWsc0c1xhSbMZoDx
        MDQhyJ4yzwOQcT8WhhPdHcm+luVdKIgNhCN44nWQOxWEt7In5wiPLJJPuLcp5U9S
        uNoA3pU81KNJuY8AD0VaIeRIU79Q1RkmYNimvhtAXp4yPfT9K09dJQVlSopsObwd
        IaRR3aQMpaXxD7h/noL6TzzOQB/2EVux9yy/gNumPtgie5ZdfY9QjYXnHSLqMmfA
        t0ytZ7aLLaaIm+nun4tRzCGEN4lRYaz9PRrngSZR/nx4jfzSuKNLgk+hgw/GUErr
        T2DGS916Y5a68akwQV6vLLqYRUUIvq1paANDTCNdm6o9Yskb56+FKX6vtub4NOMK
        EwHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847796; x=1686934196; bh=w8Es8k037nukR
        duWOvds6FkLeGIi3U3V1qR32gcTXY4=; b=DC000jgKGElMxBwGg+bGmtY0InK37
        HMQzGr7En78Wczge3TJK0sejQ3+cbq908IIToF6jEyB9BGoRrihW1BJZ8huxogH6
        JfTeZKbjTFdbq9GpoF2jeEyDoWnRa6CiE3Kh4DJwsTzLK0QyIkcnTL5b7B5qPmrg
        jepUwq4XFa+12fmShJK5K0m9y3WJzs36uJ2WiloYgTJ22ie8wsqa3zMJNg6vuYCG
        hBElBMAqRUz0k7J/bSktAntNJF+p2ju6WbLPS4oHwo4ISHaM5g36bF1SoPl9dMfv
        9gdOx8sxe+OurWwDAhf7PKBNylf+MdowRBI8RNYAoBDL47JcW+4PitYOA==
X-ME-Sender: <xms:NEGLZFT0Y440pkSJ_2qNp7PUcqA4sBcEVUBYDGLV_nQr3N4XwMmmfQ>
    <xme:NEGLZOybeMt6XUProOabtwvr3QKMim-9nBsLULQ2GRR3yiJIMVRXhlQ9A_d1QnZzw
    ECBcxP9WdnLHoNa-3Q>
X-ME-Received: <xmr:NEGLZK3DYFuLaEDgH3J4hSamgH6uojTNbXsidPCSXAR_-TerCSRX-7vASWTk7VdPjYmvA1A-YdJKS_aR_5l1og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NEGLZNAqYIZ_l065j1PNdu3KI80F8AOzIH3eZ6ml9xvKjsp8aeeEow>
    <xmx:NEGLZOjebLH_6DJxv6LJV4qG95M06HHhUI7cCtjbvvzJ70bGSWFOlw>
    <xmx:NEGLZBr1ZYpiTrzU1ndWk3ofDinTUyhxoHWDwI9l-jvznU7WgT1nTw>
    <xmx:NEGLZHXxK7dcexmHBlX3FYoYma98QL8nh_FYSRJoPPQH3FFS_uwYIQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:49:55 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:49:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] clk: at91: clk-peripheral: add support for
 parent_hw
Message-ID: <p6vcv2ttjycvtoar4mi6cf3osjgfyzskaoqy73qhtpcwvzi3pp@65im2rfk4g2h>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rl5idc5measutn64"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-5-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rl5idc5measutn64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:20PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in peripheral clock drivers.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-peripheral were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--rl5idc5measutn64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBMgAKCRDj7w1vZxhR
xW4XAQDEARpZcCfupZk/RP1g9psVCnRL4BLJH39FiMXz9+zMMgEA4dpTUKUh9LoI
qnPLObwm0vlQxZavftsrZH97UCwFrwU=
=5rx3
-----END PGP SIGNATURE-----

--rl5idc5measutn64--
