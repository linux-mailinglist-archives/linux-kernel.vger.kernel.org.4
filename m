Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9374566B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGCHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:51:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A4C1;
        Mon,  3 Jul 2023 00:51:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 889F85C0162;
        Mon,  3 Jul 2023 03:51:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Jul 2023 03:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688370684; x=1688457084; bh=a0
        67LZeVQMZ0ZGZuHnF8xunPWCpSqz/3yx++wdTK+PY=; b=5NHvHuLq0dgHv63G5Q
        xjzRYMt7Fz+fd81h/Fp/o+E6EKXn+zjbYSxLdZJEY15Oim+yaMEdkT3E4vC+WAv9
        S4PvQ+qNyBZj1Rpq1R8/ejs3ZfCoBSQLqWPNlseoKC2ud84pI8wBJx3T4DrLamvx
        kTaoIfeGXit3N60tQP/z0Gri2Na8dNFNXQLWPAxnIdpEWZYbVMLwWBZUIz6IO3nW
        vCsiyJEP6BR6JS4NorHOSDKewU+KKyvfPZkeGo5btzhV//JGw8f8mAP+XnZBYPhI
        xHe4S3HkuefmJN8IWcVrOMWswG06ca57vXS0H5EE2A8UkksWc7Vt3prF4hk2tegT
        fw9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688370684; x=1688457084; bh=a067LZeVQMZ0Z
        GZuHnF8xunPWCpSqz/3yx++wdTK+PY=; b=RwR4v3kX1fVK6CV8QYHrqz1fcdteT
        Jp/SeajvzwpZvwM5HBwo/8AMyHe5w++KVtikm7R+XGValtuENeo8QlYUplOCEyGT
        d0Sl9I9b1w+mzbzmIEFtMnpcPmbPQGpEPxhfeM9/pDeEe2COQ5fx/G4OMuZC6tqI
        vOB7Zq4uBkaJF5/ZuNaf2x9NOhCxuzfj7SweN3llxxpTZ8QCAgoiUi8bwfcPmi6x
        1in6lFf/hIiWMCCUl9ggzfVb9XfywMtrYsxENqfiMBm2q+ea6LnvjP5wNgWhI6sP
        s0kB6TNOgkXnmRk/J6KAdPkilZy66xDpcKPOeWOUVo1mggfAVaMG/LBEQ==
X-ME-Sender: <xms:_H2iZKvVyQDzfy-hM4B6v7j2GKx7MjEutKoh_qH8eKpY9oI-spnMeg>
    <xme:_H2iZPe3gTeK-fgu9sEQfD6HoZcAKM8Kuj4pB7M2BhUyM-ocbnsrX36v7PtsbJQaq
    cfKmN4CB-AeBCdenoc>
X-ME-Received: <xmr:_H2iZFyWl-4PzIDpaDmCoxpUmLI7NgxKcWJ6_5-8-RYxuVaVyZNa4hX4kTSq99yrRrfIxEhTvHoxpszZLL0voQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:_H2iZFMZVXHpea2NUZwbbgo8x0ZKaEfkm6-7wm_rtM5jlOVYnv753g>
    <xmx:_H2iZK8exEQ5gUPSQmPL2Lr-zzvd4uCzKQbFUS9OakzvEptTyzBLiA>
    <xmx:_H2iZNXmTAdFPRs8Rv5Qp5QXhhwkHyZlK60qGGRz4Q20dPtUh0ni3Q>
    <xmx:_H2iZL26uxViSrdJkOHGYdnMlVW43x_tp98-B8CpuVe8MKgGf6dAkg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 03:51:23 -0400 (EDT)
Date:   Mon, 3 Jul 2023 09:51:22 +0200
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
Subject: Re: [PATCH v3 0/8] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
Message-ID: <tz2mcnyn32kedmkme2abaohhlveu37rohghddgg5njzw3534jq@qg3pevlpy4si>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lrrl2y36lc5sskn"
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lrrl2y36lc5sskn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jul 02, 2023 at 07:55:19PM +0200, Frank Oltmanns wrote:
> Changes in v3:
>  - Use dedicated function for finding the best rate in cases where an
>    nkm clock supports setting its parent's rate, streamlining it with
>    the structure that is used in other sunxi-ng ccus such as ccu_mp
>    (PATCH 1).
>  - Therefore, remove the now obsolete comments that were introduced in
>    v2 (PATCH 1).
>  - Remove the dedicated function for calculating the optimal parent rate
>    for nkm clocks that was introduced in v2. Instead use a simple
>    calculation and require the parent clock to select the closest rate to
>    achieve optimal results (PATCH 1).
>  - Therefore, add support to set the closest rate for nm clocks (because
>    pll-mipi's parent pll-video0 is an nm clock) and all clock types that
>    are descendants of a64's pll-video0, i.e., nkm, mux, and div (PATCH 3
>    et. seq.).
>  - Link to v2: https://lore.kernel.org/all/20230611090143.132257-1-frank@oltmanns.dev/

Thanks so much for that new version. I know it's been a long discussion,
but it definitely moves in the right direction and we're fairly close to
a final version now.

Maxime

--3lrrl2y36lc5sskn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJ9+gAKCRDj7w1vZxhR
xSpUAQCzJTw/bSuVBopvVdY76PIZRdtNoVFQA435YDTBIoKiZAEApHbj+QVUdSkK
bLpQ/UPDveZ4umuDTdkAThnns04rdQk=
=bWgY
-----END PGP SIGNATURE-----

--3lrrl2y36lc5sskn--
