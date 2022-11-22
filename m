Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C60A63419B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiKVQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiKVQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:33:47 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F0E70A19;
        Tue, 22 Nov 2022 08:33:42 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E2685C00E8;
        Tue, 22 Nov 2022 11:33:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 22 Nov 2022 11:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669134821; x=1669221221; bh=pc4NDY6xTk
        HaxDLkLDsVXDo3MteEDUFdw1xpmzDYbfM=; b=ekjInMMw830aiISwkYkDlomkxv
        LwgcHF5IhLwOJsRoKEzeSJNscc3ql1pD4JCGrH2gqoPQs6shjkndoin4WNLpkCBb
        YnwL9iW5PMzdZxClFe0lxdB/WqGEXE+4loTAa/dby3XMsR04qkYM3oUMs3IJR+Fq
        lDqXV/3HXieuXAYGzLWCd66I7gNbTjehxb3IMxUfEMGM8daLgFMxVKoagyMHSilI
        eNHX5GEgYpWyaFV0GyAyOkFrV1ItLTJW3qqobxCB2A/JHi7mb5RLA4pFprhptC4U
        VIu9C5JJxRLv+YXdZOSaQpbc8V2XyC9nTC4UC3XGDl0Mf4Ts+SzS4uF/XhSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669134821; x=1669221221; bh=pc4NDY6xTkHaxDLkLDsVXDo3MteE
        DUFdw1xpmzDYbfM=; b=bd6pg2ol1IGfgetol9wblKdazAm8W6HmdfLKdOeFl3Bd
        BjPosdt5y8G4WMhjCe2sGd1RlptZdCefxQaOoWA1FP+xNL5aKsycMFwa2yTpTCqv
        4PF50VRBFXgqVlp33HRW73ZgNTs55OEzowTUOuYvPmL14HZyQsHnW9skqQf7kvXn
        kapl4//CRWRhlSBm21Hd3xXcMHSJO1F1cVV475CeCT8cxuDKdeqxxxc0iljGAUml
        nOZUuEjIoDo7bmtn4KGDv64EY9xYYTWu/j7x1ZaVZdzI+5dfWBDLAwPYyjE5j29P
        NIyflEp+UIys0iXyvXjgCeGhTfmw0iZRR/IoAUgzUQ==
X-ME-Sender: <xms:4vl8Y_pLQVQzdE6H4H1Svn2eDRQy_THKfXiXCSd8CsDtsu4_t5Av1g>
    <xme:4vl8Y5oRfqgeBLb_j2HVEFjLh4XW3zerZ2ypsAUcqlnZWe5bXGUVuy26OgFBovhwR
    YzEo3QGomuqoen8qA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheelgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffjeetveeifeduffdugeehvdelffdtjedvgfejueffkeejkeetveettddvgfev
    heenucffohhmrghinhepohhpvghnfihrthdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4vl8Y8My1r5V5Qkxpj0mWJ_SAu0Zix0p-GE51K8dOVlRqvX3a2tVEA>
    <xmx:4vl8Yy47dt1lkH-fmTdZFa18nmqMwbfZzQo1ZZBizmS_NuBGRcYlpA>
    <xmx:4vl8Y-5KLjMghj1CJTBQHlc2yQX89QA8NznX0_8g3KqjXSnN3Moxkw>
    <xmx:5fl8Y6FTiMkZcP97GUrQgryNI972sQJiGkaL95Se1jLwgtZXLH4LAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66842B60086; Tue, 22 Nov 2022 11:33:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <bc2f3ca9-e49a-4ca1-8b63-cbc7773d23d5@app.fastmail.com>
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
Date:   Tue, 22 Nov 2022 17:33:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Vlastimil Babka" <vbabka@suse.cz>,
        "Christoph Lameter" <cl@linux.com>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Pekka Enberg" <penberg@kernel.org>
Cc:     "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Conor Dooley" <conor@kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Jonas Bonn" <jonas@southpole.se>,
        "Josh Triplett" <josh@joshtriplett.org>,
        "Kees Cook" <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        openrisc@lists.librecores.org, "Rich Felker" <dalias@libc.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Stafford Horne" <shorne@gmail.com>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        "Tony Lindgren" <tony@atomide.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 00/12] Introduce CONFIG_SLUB_TINY and deprecate SLOB
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

On Mon, Nov 21, 2022, at 18:11, Vlastimil Babka wrote:
>
> this continues the discussion from [1]. Reasons to remove SLOB are
> outlined there and no-one has objected so far. The last patch of this
> series therefore deprecates CONFIG_SLOB and updates all the defconfigs
> using CONFIG_SLOB=y in the tree.
>
> There is a k210 board with 8MB RAM where switching to SLUB caused issues
> [2] and the lkp bot wasn't also happy about code bloat [3]. To address
> both, this series introduces CONFIG_SLUB_TINY to perform some rather
> low-hanging fruit modifications to SLUB to reduce its memory overhead.
> This seems to have been successful at least in the k210 case [4]. I
> consider this as an acceptable tradeoff for getting rid of SLOB.

I agree that this is a great success for replacing SLOB on the
smallest machines that have 32MB or less and have to run a
a highly customized kernel, and this is probably enough to
have a drop-in replacement without making any currently working
system worse.

On the other hand, I have the feeling that we may want something
a bit less aggressive than this for machines that are slightly
less constrained, in particular when a single kernel needs to
scale from 64MB to 512MB, which can happen e.g. on OpenWRT.
I have seen a number of reports over the years that suggest
that new kernels handle fragmentation and low memory worse than
old ones, and it would be great to improve that again.

I can imagine those machines wanting to use sysfs in general
but not for the slab caches, so having a separate knob to
configure out the sysfs stuff could be useful without having
to go all the way to SLUB_TINY.

For the options that trade off performance against lower
fragmentation (MIN/MAX_PARTIAL, KMALLOC_RECLAIM, percpu
slabs), I wonder if it's possible to have a boot time
default based on the amount of RAM per CPU to have a better
tuned system on most cases, rather than having to go
to one extreme or the other at compile time.

    Arnd

https://openwrt.org/toh/views/toh_standard_all?datasrt=target&dataflt%5B0%5D=availability_%3DAvailable%202021
