Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C548565CE29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjADISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjADISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:18:15 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8BF18E32;
        Wed,  4 Jan 2023 00:18:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BD04D5C01B5;
        Wed,  4 Jan 2023 03:18:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 03:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672820290; x=1672906690; bh=sMeTVClvIY
        fuPYuMRUbp+49sG5zkB1a9qX5hlrXd14U=; b=m0KSjLZB/tFB/hVcAvmwjid+4L
        O8mqu0I9xmhgNX0IIcj7txjwMjC/hKKIkV3Q/HU1fYJ8s6gdDw89oNhgxWy8CLcl
        SpjLj4TQxJ2FZ0DlvLTGvJoqOlvJNSSg19+R6JvnrXBFMdInU/2CmVDADxYZ0cdf
        u11bPDmdpqfjIzfhgKObw76PyUIhUKa/W4gpvLLV+NsQsXHezH+74CaPLSq8vyAW
        aqn78wB9x9xkhUSm7Wp5B1ht2f4BDrE0Zd4ZSb7w79BXK6eSlCKnGOPMWzSsuwv6
        6QdWgARa7NAFbweGzQtrBz44fyx5FUdSrF6TwLlIdc0IPOfrFEwVnawVwqew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672820290; x=1672906690; bh=sMeTVClvIYfuPYuMRUbp+49sG5zk
        B1a9qX5hlrXd14U=; b=ZAtrIOGplKB6sTP3Mya9p4i9BUddEnVf8m9cm7KbG54t
        Zsq1MVA8Zer87zOsphfiWKA09PMo+iNd+JI4XVSjlkwxnLBrutV1R+hsYiJ0BUoA
        jpQXpN25Eix3sBKECqkiSFjc3G5v/qENmZmG/tWG7MlONUGD7zG8EgZD1NLyKMej
        bFVo7pQvbkuqOo3mczDwKwhOba7E9sX8KBtaO/N6RD+rdVa/qfdOZ/pWKJx4jgPC
        54vvTQ6DrJpLisBfJHvrvERyJSuxbEyt70/9HLdcr1cdBNvuN03EnrU9riQG03dj
        u/rii4hUEw6ceQEI2YIj7afbdcLCMfdlxIA7s6IDRA==
X-ME-Sender: <xms:QTa1YwYdte0aQZViO8nBtAzwnjqsg0bssKUJQoC1PhDbJkbvfBiHYw>
    <xme:QTa1Y7bbriuc-Uf1IUfkKGbA_kq8Y8CAhat0_wp6RrTcBDUYugyT8PCl2kYUN6G3G
    cUW8Q4_-0zOb77sfaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeehgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QTa1Y69oAQqvgmo_0WadEAZCbjCOfiL41cXDP85H5ELKiiQA3wHKqg>
    <xmx:QTa1Y6o43g4sC1oC9dcf43ToR4Lj2JNsFIYEmWlYoCyIivQSL3a7OQ>
    <xmx:QTa1Y7qgguAE5D-MNdTzzpxyqHwi3iITTJVTWnnU7QV1Z7yJeCfB9w>
    <xmx:Qja1Y5hbKaL9mFyosQHTTu3WmQFUj6oWRoPlpduSWZnxdkqzJrHB2w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32F83B60086; Wed,  4 Jan 2023 03:18:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <ed198390-1bde-44ec-9f3f-b0e016b4b24c@app.fastmail.com>
In-Reply-To: <Y7TBh+CJdZPJ6Xzl@spud>
References: <Y62nOqzyuUKqYDpq@spud>
 <20230103210400.3500626-10-conor@kernel.org>
 <b5712732-40a2-4e29-b29f-e0ab5516d518@app.fastmail.com>
 <Y7TBh+CJdZPJ6Xzl@spud>
Date:   Wed, 04 Jan 2023 09:17:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        guoren <guoren@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>, soc@kernel.org,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: Re: [RFC v5.1 9/9] [DON'T APPLY] cache: sifive-ccache: add cache flushing
 capability
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023, at 01:00, Conor Dooley wrote:
> On Tue, Jan 03, 2023 at 10:28:19PM +0100, Arnd Bergmann wrote:
>> On Tue, Jan 3, 2023, at 22:04, Conor Dooley wrote:
>> > From: Daire McNamara <daire.mcnamara@microchip.com>
>> >
>> > SiFive L2 cache controller can flush L2 cache. Expose this capability via
>> > driver.
>> >
>> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
>> > [Conor: rebase on top of move to cache subsystem]
>> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> > ---
>> > This commit needs more work, and a way to enable it from errata. I've
>> > not gone and done this as PolarFire SoC has archid etc all set to zero.
>> > So we need to go figure out a workaround for this, before adding in
>> > errata enabling code for this. I've included it here as a second user of
>> > the cache management stuff, since what's currently upstream for the
>> > ccache driver does not do any cache management.
>> > ---
>> >  drivers/cache/sifive_ccache.c | 45 +++++++++++++++++++++++++++++++++++
>> >  1 file changed, 45 insertions(+)
>> 
>> My feeling here is that the cacheflush code is unrelated to the
>> EDAC code and it should just be a separate file. From what I can
>> tell, all of the existing contents of this file can simply
>> get merged into drivers/edac/sifive_edac.c, with the newly
>> added code becoming a standalone driver.
>
> Sure? I'd like to do that independently of whatever is done for the
> ax45mp CMOs though, don't think it's worth holding up that platform's
> support on me splitting this out.

Right, no need to touch the existing file as part of this series,
it probably just gets in the way of defining a good interface here.

    Arnd
