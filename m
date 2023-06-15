Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA6731E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFOQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbjFOQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:05 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3C2686;
        Thu, 15 Jun 2023 09:50:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 896C55C00DB;
        Thu, 15 Jun 2023 12:50:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 12:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847852; x=1686934252; bh=8r
        cNAyML+y0Rntmc8b1zmnBL+V8Jvai2s3TWDYfgZms=; b=MA8RVSsca6Hy/n1KGS
        /g9qI/dSMW8fIScGW381S4Fe8EZ58/BZ68Y46GRyD6RU0DdRf1S7iFKQGKUqjYcp
        FWxlyhvX1nWZOowtdh+0Y8ghBbUDT59/Zc3k0qWF77JYnDChQrDb8q78BALSvqGA
        rg+NDqf6TjSdVq85rG5OEelmibAhN3S6dTnbPoj21fjRb8U4+t7Il1scWp1tuPj6
        laBP5zxtUo8wg9eW6NVEYxYCiKPT++wKN6KaIHwDuituWS9r2zkWvUxo1MikgN5q
        RbMLakb76UzWgFUwNj13m7DjPatfNu9YZHP4YGqpcS3u7omLoOVwa+WDcBH1OSUT
        0eZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847852; x=1686934252; bh=8rcNAyML+y0Rn
        tmc8b1zmnBL+V8Jvai2s3TWDYfgZms=; b=M1oM89fsLYgW+nQs6lO3F3q/70wL8
        ULxChx1qwV2Vl7N9PE7+/biGp65zOKEFa7W4B0XPoy38ZDkQcXhsUthSBbO1QXns
        9PWJ8k8jVe09LgY+2VvwDZYNwKo8A010hlo99IcUghjt0I6P+niloWUN5pFRiiHC
        n0kL9fsAdhvPAeiV8Wo7JeBxyukCvLoeiD6P8mCyHRX4goM2UPJpxVGIGaSISWuq
        uFG34A4BqIsUsSeJhgFJIQwk1P8nIpfZfUPNH7qukqTf0Lrjcp9tMKBVLO7rccLP
        lKTcdQTGzRUH/4QSRlEdpcppn6Ge98G/tDxZIdUZvrJmwHllMfCy6BsVQ==
X-ME-Sender: <xms:bEGLZNEENBP90p5D-Mb-6mfO58hQ4pg9Q3S40Urs2SUYxShO8o3BZQ>
    <xme:bEGLZCXvG-A7LlTlC0fp8x7d73rvpF7DXeSX6_P7S8hXcex3PVNRmljQCm1digURO
    H85e22sVxHfzsWQcUg>
X-ME-Received: <xmr:bEGLZPJoPAg6b_hy4nR154wFAylvYqGV6dds8lKG06oukPcGucu7H2rOtb-RlpZb5VC1B3AUeIOauRBnQkoXWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:bEGLZDGH_afCQysnN2FiiJYryXHK6j3nWthabepuPMbvxiMVUCHtiA>
    <xmx:bEGLZDVa2KnKmtRunu2K3uom-gLtHmhv0X1losbspuaUdDySQxm9Wg>
    <xmx:bEGLZOOi7FFZv5w4-1ztQuOpjEZVA8gxhfXPxHA7gSfhfs51R5OCDA>
    <xmx:bEGLZPpxfxWeTwTKQhzRdRx1RwzKsFqZ7-1pFRlrC5RR2Q5K4UAvTw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:50:51 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:50:50 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] clk: at91: sckc: switch to parent_data/parent_hw
Message-ID: <7i3czgzxmkrgwjeogijhkb2hf5aenwv3qfjulzu4h3rpeunpod@qtwaavl4eqw4>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-10-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bnlxwil7t5zvhuit"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-10-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bnlxwil7t5zvhuit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:25PM +0300, Claudiu Beznea wrote:
> Switch slow clock drivers to use parent_data and parent_hw.
> With this parent-child relation is described with pointers rather
> than strings.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--bnlxwil7t5zvhuit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBagAKCRDj7w1vZxhR
xdrJAQCE63NMr1hjH5dwhyTQrdYmnpzRFQWvSxDkQSPCYqxQ3wD/TNt9GxJ+YQsG
12WFOv8G7Fb1QGRCuvaIGRWhaF0HnAg=
=Y5V1
-----END PGP SIGNATURE-----

--bnlxwil7t5zvhuit--
