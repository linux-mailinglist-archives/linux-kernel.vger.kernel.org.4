Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B08731E38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjFOQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjFOQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:50:50 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AAF2D45;
        Thu, 15 Jun 2023 09:50:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B331F5C011A;
        Thu, 15 Jun 2023 12:50:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 12:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847837; x=1686934237; bh=vI
        /hsoiUvma2GUe2XFIA+w7iata8Xrp62/nT+TjfC1g=; b=501D+/oPYAwT3uVkcX
        WkZ22rscfGQnEb9BadEIsQbZwxbfzGrxruC6TK8eRql+8GrIU93YruZPdSbB+SyV
        jLh3k+eMCQ6mZQgubyrKBG+hZGEZzA35qn6FdgiFpZGfgM75EhTOXY1Twz/e69K3
        25vCmGnjmJSVrNtzHQuHCZ1hLJwtazKZDf9cCK4CZim54PMKWS+T2UPbDLBuYb4l
        OK/J1OYOG+ZtvaO080RD1ScCbTsafgQ62N3L1IsGAbpkFGCk3P7gvvpQiFFKBO6D
        JyavBwqB93znXbOM3+KgFRB8clsw3GcRmlW65fLUdzQcoGy4tVYOeS77JA8qYl4c
        Szfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847837; x=1686934237; bh=vI/hsoiUvma2G
        Ue2XFIA+w7iata8Xrp62/nT+TjfC1g=; b=SWlMtKwCbPZh1rGH88mftqv4A+lVF
        NVavhAo4ULQuqhBs46Yp9EhGhIuap1tin+pCLlHiJQgcPnQ/YubGnGBL9ogRIprw
        ZwvlircCWkX2yyETVd8ZAEisQAiSsJtDP6jfORxZNpEOdyuyxGeDspdCi1Q1XUvh
        2i1F8SpRLebq3ChDwT/zuRTG8vsMHu/Wkt4qImPksDustaClKEOcfSiU+A/fbuWM
        1Yexpq+2KSiQAEd/pUhpdjfSIkK1TJeb08zYytUirbwy/7G9+8+lbCFPNPcsFN7m
        9IAevR65wckDEPiT0DNzai9qv05pJQ+rOemYH3H9FmviNe2fEyPqQHmAw==
X-ME-Sender: <xms:XUGLZMJKQj-A5n59OhC1Vm4bRqg08icJuclqa35RC1ItFV3HryHbyg>
    <xme:XUGLZMI8Mu1alpdTsMau7UuEMmy5h2FdhBWPMxsa035kothOTgGLIX3jw3WlOmdn1
    iLX2BrSI1_uuZP9xzc>
X-ME-Received: <xmr:XUGLZMuCMlcUzb8yHA9--S9qI_tXYRlH5MTqRjwKAuMmwlvQ2WYYtYbJHdpGWfQDsDb_roMbTawatH-VjDUIlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XUGLZJZ-C2RU9kbFU4ASeptjcCZHHpsEP5_VrnciMxJNevOO-3PpJA>
    <xmx:XUGLZDZuK-9BuKu1Zn-BXQWnUOOVyh2K6_rx6BtCEubfE0teogDasg>
    <xmx:XUGLZFANMckhOCy2-lVRpj791UaNs-nVhEQ56zzC4ZdlPhLPhddusQ>
    <xmx:XUGLZBO0gyTJxDU-A4XQws8NBft9O8FDxvE-L_RGqsVl4AtNdAQHvA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:50:37 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:50:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] clk: at91: clk-utmi: add support for parent_hw
Message-ID: <r3432f4teontgh5obljdggl4dn5n3fn3bxjntlpzxzjrw7s2zp@6uleyrrdwx7k>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-8-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67qssutobxzdeit6"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-8-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--67qssutobxzdeit6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:23PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in utmi clock drivers.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-utmi were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--67qssutobxzdeit6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBWwAKCRDj7w1vZxhR
xcO3AP9Ngpz6vvvc6cBWVZFmqHd6QGEA3f4N++MeMjbbUkZgqAD/Xb341DBKY8k0
1DxM5M86J0W4/N8/uwzctcDcdw253wc=
=/xzB
-----END PGP SIGNATURE-----

--67qssutobxzdeit6--
