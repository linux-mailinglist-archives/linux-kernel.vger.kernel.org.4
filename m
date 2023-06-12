Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F6572BB66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjFLIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjFLIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:54:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE96122;
        Mon, 12 Jun 2023 01:53:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 907F35C00BF;
        Mon, 12 Jun 2023 04:53:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 12 Jun 2023 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1686559988; x=1686646388; bh=O138OwL0TXhDIA3R83x9D9x7Tx/L+g0kciU
        XuuE1oMc=; b=n/nDLBnX6mxxmi/bL5blJqyDaOEnXu4C8iVA+hmC2YqiK1Pzhft
        I2PtIux3urVPzwe2JwVY8hvvBgE3bRRN0Y+CSMokHQXOHr6OoI25CffHqQ/5Ceap
        sT4cNCn2eW9BDe4xT8FfUNEmVyKwJYKAO9zkofVe2INLrqHCVnXziqpN3lYpDOeI
        xuYTIcKB57l/wpKMuxB78jS+L2sOoMkPdMo/8CJGFXpzi5ms/400AGSIBxVGBLop
        z/ZhhCJ7iVcgdm4oRujV3hAT7u/VO4IgIzWMrUmjfTTJSYhxaqowqmHKjAdSr6+n
        saY3j13ZcLLvXPji5VtXLeabdmLWhRi07EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686559988; x=1686646388; bh=O138OwL0TXhDIA3R83x9D9x7Tx/L+g0kciU
        XuuE1oMc=; b=bq9WNzy8kON88LJVCK3rdB09IXR5dyl7gyGrf+869xdoDURcQCE
        FueXd3bGpPvZK1cql+y0XRnFBAjcicBN+FaZC8IV2zcOPlWdB2vlUojde6AbMTJd
        a7kBHLR8fsyhVd/FBoNnghZNEiEYBeeEixG+DwPerDOzQaCbkk7PDPyVmaaED/Fg
        zPe6ihX6kspcnhQulUDamfxLDqRxBURp83gV2nGTtT05Xkj1sujcWWCPtV6YYYn1
        bi067qbGaEC8+jD6SWoEYntBFPz5nWP9nJ9Tz4lU/o6L9UO7nL3L0I42Ks1ZjnUy
        5DKJfIblE1FV+Bb5wR6436RxKJ1vDNHTfDg==
X-ME-Sender: <xms:89yGZIEkzHMzX590XegUje6E8QSmUINtK5T-2bSwD-VPUwZM7SEzlg>
    <xme:89yGZBWNmYO7xnZSuHm7TZDCjky7lpsH78qMXIB2OWBOn_QJToaqs2wwQ_ED_9PLu
    ozGzpXZezZgh8fXgyw>
X-ME-Received: <xmr:89yGZCJI3jkmBWITOFA6J3dceGjOGUq4ipCgVcq_w5rs7U8-aCXJZ_j7besO53t0rNbPUFeCQMPAbQsXG3vqlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhfstddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepgeehheeljeeftdektedvudejvdekueejkeevueektdeuvedthfeljeff
    gffhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:89yGZKGurpg_m4UCVIxUnG7h_PccRp5f9Fza6JsyCY_RFcogsdpR7A>
    <xmx:89yGZOXE9Mns50yrQ22RPCrFvSPohW9NPqlW51z9aM7b9iP_BuVGDw>
    <xmx:89yGZNMvIIC1Ynt7lIZ8ZRiYNCDP34Il6aoLb7-Ae7miuyxAhMLo9g>
    <xmx:9NyGZHNa2tjW7YtIT8zu5Vjdc1c__I6l7ZHtxHzYO2UhMinRNwYlUA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 04:53:07 -0400 (EDT)
Date:   Mon, 12 Jun 2023 10:53:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/2] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
Message-ID: <pk3som3qkrs66hk3hf6zczmd5hqsrb5u2pkmolngqinjm7b753@27vlqdbxemwa>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <87legv2093.fsf@oltmanns.dev>
 <vvmdk3fqtjt3jspxgvlbypdxajchymydshya5b5ivk3wfodwwr@yyi26m6toosh>
 <871qim1eow.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <871qim1eow.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:29:05AM +0200, Frank Oltmanns wrote:
> On 2023-06-07 at 14:27:46 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Wed, Jun 07, 2023 at 09:35:20AM +0200, Frank Oltmanns wrote:
> >> So, my question: Is spending the 30 ms fine or do I need to optimize f=
or
> >> speed in order for this patchset to be accepted? Or is 2 ms also too
> >> much of an increase, in which case I'm out of ideas. :-)
> >
> > You keep mentioning it, but it's really not clear to me why you think
> > that both are intertwined, or depend on one another?
>=20
> I'm sorry about that. I guess, I got carried away. And furthermore I
> took your mentioning of all bets being of how often setting rates
> happens when HDMI comes into play as encouragement to optimize for
> speed, which it clearly wasn't.
>=20
> I saw the increase in time as a regression, because it might break
> boards that I don't have access to. But since you say it's fine, I'll
> speak no more of it.

I'm not really saying it's fine, I guess I'm saying it's fine until
proven otherwise :)

Maxime
