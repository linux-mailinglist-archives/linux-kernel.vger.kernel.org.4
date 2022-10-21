Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333FF607175
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJUHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJUHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:51:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3923B6BE;
        Fri, 21 Oct 2022 00:51:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 503915C00A5;
        Fri, 21 Oct 2022 03:51:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 21 Oct 2022 03:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666338703; x=1666425103; bh=Bb2mHnT1JP
        70JzG2D69kGVHJtQMGKIn402mRECKC4F4=; b=YJndt3bVrfFKDrdAek/qsaZKfC
        GIY2+JfgU75WsfND4cO4kRG3x+O+L72Sx4MhBQ1Mrt3o7WTkd2pY6UjdmMLwfF+9
        6FmMOPyH5dNToYT0vWd/jvRIe21+raA7qoHdxaYFHtyMiE4yzGfCAHpbE9Mhwmw2
        XDX4OWes+gg95jH50EkrKu5BcIGHEna27w6XkRO3+A7xOU3kTEGzrzZn6M/Qstdq
        AQMHP8oRaJRAHtDmzKR+txQuwt2kccfz20uYH3pyCih6kdhdcP7EnZPfd9VSF2LX
        21PVkV4JX2DuEZaA2ucVt01O08H1WGOn2e30kjQMozGtQTARP12lAnQkC/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666338703; x=1666425103; bh=Bb2mHnT1JP70JzG2D69kGVHJtQMG
        KIn402mRECKC4F4=; b=P8j9ROzxMhxfBLefQQ/EED3Qm8fMars4PuUmKq6vKSiw
        hBKNIvZx//r/DeiaVUPTqpRU0AxT0vdIpk3SooqlFDv2HxYrbtIO5z7b6cjp8c91
        BKG4jFAHl7cLSRjKtJTAhSmQA9II+sVD7FafJYfZrWEi8CTl6NcJc2J+l756NSlp
        oRzHJY1ullMZJlB807oCWUDci32NCfjGeuGq/lGU67u4r7+IVYb65gSr9ofl+peo
        8Hpd0gbmuYClvPA5HCdruWC0hTk2//MzSlQkfdO7YqeE7/ia5ndAfiNCLbO1IiBJ
        hCCP8LZFHlHjLZlR5EEJckEmkCNqHcjnUKB8Zl0gQw==
X-ME-Sender: <xms:jk9SY2r6Ig5ji619KxJgCjJET4nnh55Y6oEwwGrI6QBBsuE3Zm3m0A>
    <xme:jk9SY0r3jX90q8rFlAOcq1IX21hQp7gikJAG4I4MmNBJe4YKbs2uwHdAi_k3hoPK7
    IGa7tK9K9yRzkjiaOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeljedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jk9SY7MeN_fxobJB-fqC_YlU-Ev85a3NcnYPyvb8hSin8RUKeNxIjA>
    <xmx:jk9SY15Q9JM-W1-0jZaaUQug-1DZcRbyiYgA8wnVRbMMz01Tn3lfwA>
    <xmx:jk9SY15wJlZo0WGK_pfL_XK54dYpRLPtNFkYon57j9T99kVGHhkx1g>
    <xmx:j09SY5qo-mVAQ0XblG-tDD1wHSfn7K4EOn_k433Fz7n4rOmjGuUzzQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 35876B60086; Fri, 21 Oct 2022 03:51:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <09cbb91f-bea8-4c22-9c1c-26d933ca1a94@app.fastmail.com>
In-Reply-To: <20221019173437.GB41568@darkstar.musicnaut.iki.fi>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-14-arnd@kernel.org>
 <20221019173437.GB41568@darkstar.musicnaut.iki.fi>
Date:   Fri, 21 Oct 2022 09:51:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Paul Walmsley" <paul@pwsan.com>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "Kevin Hilman" <khilman@kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>, "Bin Liu" <b-liu@ti.com>,
        "Helge Deller" <deller@gmx.de>, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/17] ARM: omap1: remove dead code
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022, at 19:34, Aaro Koskinen wrote:
> Hi,
>
> On Wed, Oct 19, 2022 at 05:03:36PM +0200, Arnd Bergmann wrote:
>>  drivers/usb/phy/phy-isp1301-omap.c | 91 +-----------------------------
>
> This driver and config option ISP1301_OMAP can be deleted altogether as
> there are no users after H2/H3 boards are gone.

Good catch! I'll split the driver removal out as a separate patch
then and remove this bit here.

     Arnd
