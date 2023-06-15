Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676B7731E35
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFOQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjFOQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:50:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC60295B;
        Thu, 15 Jun 2023 09:50:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 558FF5C011A;
        Thu, 15 Jun 2023 12:50:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 12:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847824; x=1686934224; bh=X3
        HDdXjVYFrsPwZ6fIrdWBpt1YYQn9x1VHpMTUUyLp8=; b=3yHfjgs9M8GimsQPe0
        CwMP0sCbrJ1JY+IEJq5uGPGHkYcwnrIDRyZbyX1SJljZcLFs9aFdrpxdV0hLsH0a
        Vi58m6cSt5Gw9uxAfpWq+F78JJO24k6GBH4/g1mxc5Qmz2c3ZELTi76L+1dtyoNC
        xsO9UisolHAe5QeNUoT23s6LJa12CkRMX5vyv9wWFoSH8Pi00PzOijgw3DyDHXAI
        q1VFdW7VHcC1mf8GdREvLMoHzYelVvo6eCbeO5v5nkMJq/7rFGJgDyLGdk7GOaYG
        mnPAEw1qeAYzwUyYVW2Tc4qzQVi7a03C0JVbOX5Pf1c64lgG38bRl7g69XPd+NZx
        FHJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847824; x=1686934224; bh=X3HDdXjVYFrsP
        wZ6fIrdWBpt1YYQn9x1VHpMTUUyLp8=; b=h3Vh4XIfRw+jmDriULl3rUTyoJPsh
        fYl3xMZZ8oDO7piyjcVismszzTJRNGFYu4NxoeMJCZg/ot9EmU5j9rYn3M2LRUtU
        dOT+8cNCJVLQUt4rpkZejisPjyDtQ37gXDDj2+U8D/8ZJ08YxWnuilPV1Sy9TNbd
        IzldF52UKii6pTemRnWxfbhWwtdMDJtbdr1XcpxfoLVU7OMwEjCmU4UkVacNEa8P
        ah25sDazTLg3BOqFwRVFylDbQp0LHHi75d9+++tJdhJyWG3J+17y3+lSeOY4Ma4o
        PBoeXC7B0J64hdd34cAlwT5YN+eltVM9lgkgYTk4MhmunRHwrunrZqqbQ==
X-ME-Sender: <xms:UEGLZHhLIyTdIn-T1IhJKpR3Mu7-J14ISwN_PdsL36kq71BlUmqY8A>
    <xme:UEGLZEAOawOEx5rL5X1aP_I_kMU-NpwIaONwqAN0S6VG7NkLNAn0EPYFN3cX7afe1
    M9ljyw8z_mqafZRpWI>
X-ME-Received: <xmr:UEGLZHHpwj3M9JevbhqqePZ8cni-qN2urZZReLLoUbWuL2UMEFHKVqgjdP1Y_2gZMfvn7FmhkQNhoFxJrYqQGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UEGLZERXyOARo15FgZy-P7_q6XJh1ZpPOemfF4NiVhwnf7c7UaEN6g>
    <xmx:UEGLZEwEqFpkjf125tzNi5WtsrYXt6IDXJxgcgZM5mUoJgsz4pgaog>
    <xmx:UEGLZK64XOwJ7x24OT4V3VREcgss6le_PBxJdVm7Knn1ujA243KXZw>
    <xmx:UEGLZDkQM5O90zV63CJ2pSi8DuspQIiQyGM57O8iRjAHIdFec7fVOg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:50:23 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:50:22 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] clk: at91: clk-system: add support for parent_hw
Message-ID: <cplgsa7fsgsm26fvjmmnx4qqdd4fxj7n4y34fyryae4xcm2frj@b73iktzauorx>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-7-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ceawbbtf6gyzicbd"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-7-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ceawbbtf6gyzicbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:22PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in system clock drivers.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-system were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ceawbbtf6gyzicbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBTgAKCRDj7w1vZxhR
xWRhAP9BWevgHGocEccdrfIuYWIOaSeFT1S6hkImAGquO9Me4gEAhRg5haanxHru
2zm5dzvkX4BMNsLyrpKLkQjoVXjjdwQ=
=Slqf
-----END PGP SIGNATURE-----

--ceawbbtf6gyzicbd--
