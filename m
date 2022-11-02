Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8AB6162DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKBMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiKBMnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:43:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317024952;
        Wed,  2 Nov 2022 05:43:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6D6F03200939;
        Wed,  2 Nov 2022 08:43:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 02 Nov 2022 08:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667392995; x=1667479395; bh=2ljwfRfuML
        ubvQuGUCmVfn79dRgv0MQ+cLuAbpZvYZM=; b=EV50IlqSfdXYpMSKTJNtJCJPlI
        BDbfRNy2WM4CJEAiGyp8dulOeuUYPHfQRxFrlHQuE2n6X+j4XJrLKj63cwWOrJhu
        SCP8zDxtAf85c4CvyRPWUzeiwtF3Nn5s6iMa7UrznLl8HwtzbRvmH0oGBtBQgww3
        x22KkHckxB8Bcgg/Q8pEPnCrdrwEgH6axkBNX78HbHr/1TiQDom204HIgeuzb35C
        FbGgWFCPJfileGrVC9OuwZrGfe0W8LZKn8TRYvqEOHJ8MgZi7hmlG0H8mi74OPxw
        KSeC6SjYDYeENNA8n0GnVeiTepsf8qM50mX/SfJGIzGIalqDj5zMxM0cXadw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667392995; x=1667479395; bh=2ljwfRfuMLubvQuGUCmVfn79dRgv
        0MQ+cLuAbpZvYZM=; b=QpIHGclRgGaUrS+c4UWrVaDB4MmjWjPSHGqFNWhNIwBj
        HBU5DXAZPm7W/dTyb97eP3XpgE23u/wiEpASZuLvksk8eB6jHckfQ1MDFb2H7k2k
        0Obih3fpfE/nCdBExS1lrBbplY3NjWiZQjYne1bZXRW8gaiANg7gGRuvQCRYhFlU
        P1ss40ks75qa+we9zOjl3VOx9N3EslZjg5DrFcWfxBUPhn2kixJyRrBSa6FzOMOt
        oVV1zLWv6VTgKA0XTG7TBmt/MurmsOYNHCnKoVducdrxC9MvtqAxJD7ApL6rmEoi
        XZhpBxbB6MNZySV74/XvcTognZbQOa/4M+IUql7jRw==
X-ME-Sender: <xms:4mViY2oMvw36nhSoOeNikn2A_KQopTlNrWB9X2lvJsSHCBz35s9Rtg>
    <xme:4mViY0qhLSUzZD_dbLwXdLhmH4TgqxfJEt9Fzn47yvjHhanL8ThRZlmNDHzeJXxl4
    18Rl9Vl2BpwpDQjnbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudejgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4mViY7OA7qbEpdp8cFYC2-UDho_MPh8IFQi5yjMtTNJEbF65vl_Thw>
    <xmx:4mViY14KFX9B_x91A7mIo2M-GHJNc-Mmyi3mK15wqEgmy4XIlLXS8A>
    <xmx:4mViY16iMVKtH4wr2OrXEf30ky7J49Ctn-q0V51wAKNr1iwR0NWThw>
    <xmx:42ViY_v7WugSbrkOwtdAvvJebZv3a7Ne63WDE9urc8aBDC1lWPRv_g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3E385B603E9; Wed,  2 Nov 2022 08:43:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <1756ff9a-babc-40c6-8002-9f464e023c52@app.fastmail.com>
In-Reply-To: <20221101215804.16262-1-afd@ti.com>
References: <20221101215804.16262-1-afd@ti.com>
Date:   Wed, 02 Nov 2022 13:42:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Davis" <afd@ti.com>, "Lee Jones" <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Daniel Tang" <dt.tangr@gmail.com>,
        "Fabian Vogt" <fabian@ritter-vogt.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] TI-Nspire cleanups
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022, at 22:57, Andrew Davis wrote:
> Hello all,
>
> This series is an extended version of the series started here[0]
> and here[1].
>
> We break out what was the first patch into one for DTS change and
> one for code changes as suggested by Krzysztof. Those are now patches
> 2 and 8 of this series (I kept the ACKs, hope that is okay).
>
> As also pointed out by Krzysztof syscon nodes need a specific
> compatible, add that as patch 1.
>
> While I was adding that, I noticed some other dtbs_check issues,
> so while here fixed some of those up too (patches 3-6).

Hi Andrew,

Thanks for the cleanup series. All of this looks reasonable to
me, but we need to decide how to merge it upstream. I can
pick up the patches directly into the soc tree once everybody
is happy with the latest version, though usually I prefer
to take the patches or pull requests from the person listed
in the MAINTAINERS file.I'm happy to

It looks like there has never been a maintainer listed for
nspire, so it would be good to fix that. Between yourself,
Daniel and Fabian, can you find one or more people that
are willing to be listed as either reviewer or maintainer
for future patches, and decide what status you want the
platform to be listed at ("Maintained" or "Odd Fixes" I
assume)?

       Arnd
