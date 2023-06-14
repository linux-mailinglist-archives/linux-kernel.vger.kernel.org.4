Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD572F7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbjFNIU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbjFNIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:20:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38DD1984;
        Wed, 14 Jun 2023 01:20:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 394F032007CF;
        Wed, 14 Jun 2023 04:20:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Jun 2023 04:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686730852; x=1686817252; bh=1y
        EMxu0G9MwUKPOyf/FJb7HTbU6HblEER4OOakIzOqY=; b=fAX5C12HUFFcTTPMdF
        Ir2pCY81OG0YZpJa3p7vFQwVoSm/uKg9BTuH51Kjvoi1If/QNTgJO4VUdOLW0ChD
        7VE3a/cy3P6f86cBBL2DUvTJBBPFTLdpDwXiKu5gMrEc6nNYLrRKBAXBqqw2ZQpl
        w7FZ4AMEZa+0OwtA7IYMoR6EUSu+Ankts6JHthLO8oqTBeavaIe4Y9lWM/zwoQzU
        2UjtSv/HaEmE49hWrJ2LEDY4TV9/QAALJB+VGeu8a8q68XLpga/6p8Pn6NqPsQ/u
        SJw2q5sQ4jDsUIRCejMkDf+Fhq0hKQ6FimceoCGurs70apYLi1Ogmzyva5yPrCLB
        VGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686730852; x=1686817252; bh=1yEMxu0G9MwUK
        POyf/FJb7HTbU6HblEER4OOakIzOqY=; b=crgIalStnsNyIrYG7VonJagMqQCiL
        t0a/6b3QL+Zi/5Ww70gohYNMC7dC73r/rdF/ll9rXN5iweF3iXrtz8dqV/wfyc7U
        nQvD7ogQHkIouU14/Y2pO3SjbuGFjZKjM7nbxMmjsNxaB3taRvEHqmCRkIGz38Q1
        WkLKrCn+P03cf4g0OuDRk79WwAm+M9o5pb9xWoyFOq01PEP3y2ewFw2zyX945Yqa
        uOlYp/HwnB7qSaDXjDHkUFZRuiRPfX6X0pJgnACCRAOjVmQU2qMo4qtFmy0Wz4Cg
        MS21rdCmep7ggsYzW3uvrPvoMMu8qoLgmsPH/10DENQpSFoQclQh172Ig==
X-ME-Sender: <xms:Y3iJZC5ok3huCmiIRvP33bh5p9w5nOIwU2uQgJ4xVqofo1HHxBT13g>
    <xme:Y3iJZL7Luvwkv6G8RLGJ2U1nBksGQYt8sdyVknt7JJur7Foy-fyOOOqY0xI5_N_AQ
    aiyutgGHHUhS3KiyaY>
X-ME-Received: <xmr:Y3iJZBfMHf1KvQDRgxeMoKrDgzsYScZysRy-8TvIZLKEPLIyBJrAqAkf9840IsBx0QQGHZtOxEjzkExiQdtKUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:Y3iJZPL7I-d4inHlPeejZdUqBYTyHvaRikd0WpN2z1pCXmXwtv9KgA>
    <xmx:Y3iJZGJ2CRqUemyHVmgA7Zgfc77hcwPmdO5dDv97e_gfIFP6yqfjig>
    <xmx:Y3iJZAwQojU_GpKGQJdx1CdKrmRc0OTLi8I47afI-iOpX-zJnHPDDw>
    <xmx:ZHiJZLEvkS2ZqezYfUHk6wBrmqe6VcAF7wFLDDN4EzAOyNkpS36_Aw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 04:20:51 -0400 (EDT)
Date:   Wed, 14 Jun 2023 10:20:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] clk: sprd: composite: Simplify determine_rate
 implementation
Message-ID: <tfk6kycpvlwh7sy4cbm7pip2i5qlro4tiuh7xnzkg5zrntq3aq@iswzxdlkfbkc>
References: <20230613195443.1555132-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxw7iuexgh4mfzjs"
Content-Disposition: inline
In-Reply-To: <20230613195443.1555132-1-sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxw7iuexgh4mfzjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:54:42PM -0700, Stephen Boyd wrote:
> The sprd_div_helper_round_rate() function calls divider_round_rate()
> which calls divider_round_rate_parent() which calls
> divider_determine_rate(). This call chain converts back and forth from
> the rate request structure to make a determine_rate clk_op fit with a
> round_rate clk_op. Simplify the code here by directly calling
> divider_determine_rate() instead.
>=20
> This fixes a smatch warning where an unsigned long is compared to less
> than zero, which is impossible. This makes sprd_div_helper_round_rate()
> unnecessary as well so simply remove it and fold it into the only caller
> left.
>=20
> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Closes: https://lore.kernel.org/r/45fdc54e-7ab6-edd6-d55a-473485608473@or=
acle.com
> Cc: Maxime Ripard <maxime@cerno.tech>
> Fixes: 302d2f836d78 ("clk: sprd: composite: Switch to determine_rate")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--mxw7iuexgh4mfzjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIl4YQAKCRDj7w1vZxhR
xb+pAP93GGWbEXfcYr7b2IfwCcZ8pQzdNfiq+YAVx8HSZ907mwD/WkB8eWJwE4Fs
94TtOnmikPhnfB1hcx7EidWX+4mU3QM=
=lYcZ
-----END PGP SIGNATURE-----

--mxw7iuexgh4mfzjs--
