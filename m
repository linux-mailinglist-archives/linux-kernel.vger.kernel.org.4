Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC6731E20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjFOQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjFOQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:47:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E935AD;
        Thu, 15 Jun 2023 09:46:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9EE2C5C00F2;
        Thu, 15 Jun 2023 12:46:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 15 Jun 2023 12:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847573; x=1686933973; bh=H3
        S22l0gwDYzvOUNHaJBfBTgFXZRIY5tYNbZsAjwXm0=; b=gB679vUQCxv25+1JMM
        AIFTpNtaRfNr/+tZhxAAyfYHUQFqxfkirhCuRQP24mwTVEOQ3X0a48WW1wD0kydm
        B9iHRBumYaYFRgBwV+594J168/uNbjqW/D+s++WjhRYncAHz25JDOYBr5g8kux8T
        FtuzP4S5aSpwZl/lNd9I7x23qGt/xg069/GsvtdZlo9Ji+77hCb6ZSyk+p5RDmQh
        HDlLE+g63Twh3r+t8/41t5uyldwToB89Q4NareE6v1S/AFvLm/1UGBCZR2FZLOgl
        2cgKhYd0Jvw5XpZIH+7zMpcSRo9d1FHJeDIAJggxLsGNUEwKgYU7D5sW6DTc57hK
        QJ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847573; x=1686933973; bh=H3S22l0gwDYzv
        OUNHaJBfBTgFXZRIY5tYNbZsAjwXm0=; b=dJSarRJYTKzy9Z+5pY0FAnpHxwIvu
        d0yOwf4Dh1utw3WlpCtbYfz0cvmVF8lceBPiKz1yk2gSNGO46V8cpF+aVLh737d5
        vMuG9FLPhs2Rt2QsyIrIyZ0+3soUbaM+D4XRd4G3MsjhOFCHntu19OSJyEtWNreJ
        aZtuCMWVtjNZSkEhZLK+wcWkxuLfJswyWVDEky78vYyLronqEsO3yw7CjYw0KgrF
        WHr+W8RYnLDAet095JxWQwHPB5AqfDzuscVq5fblL/LJUSIsxfWvYSE8/GpLmaMk
        GBR1iq59ebSz9EMBsakeCfZp6FJ9/eBLmOXo6S0n7SNwphxd1P7Oixqbw==
X-ME-Sender: <xms:VECLZAQZfSwVQvNhM_m0358Oy5Ib-fXJzPoc0yLyi7-2ol_IHDTIfg>
    <xme:VECLZNxaYyUzAQc_HS993y-ho734OvxUwXXInpFUVf3wgQHsM6utJv7fBPO1W2DKc
    CpfpTmHOzK4yO1KswE>
X-ME-Received: <xmr:VECLZN2vH7GhOQiMiysXgWzkHbujCmm4RfQW7bxVsDYy4H901bSHqbGSNgcAAdH-p4gMoXHPO49oJmgyOPDkpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VECLZEDbHe0rDLhf2BQxede109jhWTq5lo5_1qfSaO09EHgQVWdo2A>
    <xmx:VECLZJie9aO6_AghlXyrqIG-Sd5KlD4vHmqW4nYpowqEwJ37_fGyhw>
    <xmx:VECLZAqzFwGEKN7wUYFNBSBP1wAyaWpEzmE4Wo-4QnbIoAyg-TnxqQ>
    <xmx:VUCLZKVJPgDZ1QnM25f-K7Re8dLZ9eNSB_5YuousC5gp-auQpUA3vg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:46:11 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:46:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] clk: at91: clk-main: add support for
 parent_data/parent_hw
Message-ID: <c3onzai6zdbh2maiz6wqxqyf7tcmgruqi6c3luo7mrxze4s73m@p67cxvryq42d>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3b5oq37ptsaifkp"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-2-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3b5oq37ptsaifkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:17PM +0300, Claudiu Beznea wrote:
> Add support for parent_data and parent_hw in main oscillator clock driver=
s.
> With this parent-child relations are described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-main were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

--y3b5oq37ptsaifkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItAUQAKCRDj7w1vZxhR
xQJbAP985zHzCTVksGOotfrJJJyVaMhg4LQpQvDv4J5ArSgm6AEA9Ns1Ce3yAPkS
TSQOKa5ZFqrcdgc9hulZ7vYGpvFKmw8=
=Vqa/
-----END PGP SIGNATURE-----

--y3b5oq37ptsaifkp--
