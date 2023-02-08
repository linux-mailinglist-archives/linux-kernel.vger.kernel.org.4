Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6730E68F801
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBHT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBHT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:28:15 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28E83E6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:28:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5FFA63200918;
        Wed,  8 Feb 2023 14:28:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 14:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675884490; x=1675970890; bh=WyBBIxA586
        qfgVO4ILEoqSpA2h1Vebgs2QIOv9Zb3Go=; b=qP8CIUu4s5Ww4uaZA2kyUjXLAd
        tXLIQi9PKGDnw3yPKxTlSZkvTGAgwKnrGzGqUB9QIVoubstMCWy60qj6+6E3MFyZ
        iGDq8Hr2qKXEzzmQlbxt95e51bdSVCpEGUjpcZLcos3SpLXhqynWzQpe2S/WpPwL
        qq/pLXfd33gtBukv6OCimqy1KqCtS1ps54GngmoFL1n6M0g3e54LOkhVnX0BlCU+
        x2eV/Ldd9vvFUzDuaBNHmN35fdojBPshiuibgKPXzH8vD7OdDJp5F2MB4cXnYPwG
        ueirlnPqS16BEISngfbz1Lxr9z+nHH/PhM3hAsEiMl37IJwUQGm7Lbz6+o3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675884490; x=1675970890; bh=WyBBIxA586qfgVO4ILEoqSpA2h1V
        ebgs2QIOv9Zb3Go=; b=NuDLXNqnVAij/1RDDrrDZlWQJciVHLzE2LWQKYDHUNQU
        CU2doqHaSc48qnGnmV+EDnoefqahnlzqfLLsae9rZs0BGlQWJyGQUGfpNubSHwzu
        o55EAQouAFouMXZQE0W0IvyuIpmGPj/W1PUnEHuKjooogIOpot71OOjDieSwPOUq
        DooK/Iqe16MVEZiH5LbVLMz8drAVskF0jcIQuQZJiGsL3q9urXg9+i2mWTW+iToz
        4EfCJ8Y3BTNyX/wPAWYN/LMg7I6uMuweWmo9yf6VYUdXr84xdy2f9O7Fwfbm/F1w
        HNuyc+KzLQD5PShaxXBES/p23+afr6lVpzUja3L+8g==
X-ME-Sender: <xms:yvfjY-i0BRFOJFcqnkIWqNP8fZdixU5WvTVbvjI8ZFK6kvRnW34UNQ>
    <xme:yvfjY_CSzJ3ldjW24Rl43KQPUPolm57SGERfqJT1RR22rbH9_8I1ZyKCt53x0zmrD
    bnh4wcvVyTFWR2Mat8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yvfjY2GIvogaw1sNrbMHYmY25SLh27G-g0kS0Y3oih5GB9NcamQ6HQ>
    <xmx:yvfjY3Sj9oPLB-nUhwtr1qJnDQAoMqOAVNBvgKMqhZC-NpKTfpyi8g>
    <xmx:yvfjY7yUEUrrxd0AVldEjkjkteszk95Ug1zL8yjSJgx87ydriULFMQ>
    <xmx:yvfjY-qgDcBLyHh4OoFOpgZsCWmOGv-9bpQhQQCniS_nGvnxyE1Wzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34197B60089; Wed,  8 Feb 2023 14:28:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <7c257b67-eb7c-4395-a710-818ca1c34b48@app.fastmail.com>
In-Reply-To: <Y+PlZi8mrHray92j@hirez.programming.kicks-ass.net>
References: <20230208164011.2287122-1-arnd@kernel.org>
 <20230208164011.2287122-3-arnd@kernel.org>
 <Y+PlZi8mrHray92j@hirez.programming.kicks-ass.net>
Date:   Wed, 08 Feb 2023 20:27:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Josh Poimboeuf" <jpoimboe@kernel.org>, kasan-dev@googlegroups.com,
        "Marco Elver" <elver@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Borislav Petkov" <bp@suse.de>, "Miroslav Benes" <mbenes@suse.cz>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] objdump: add UACCESS exception for more stringops
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023, at 19:09, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 05:39:57PM +0100, Arnd Bergmann wrote:

>
> Hmm, I wanted to go the other way and remove __asan_mem*.
>
>   
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core-robot&id=79cdfdacd5b8d1ac77e24ccbc178bba0294d0d78

Makes sense. I've put your patch into randconfig tree now, I'll let
you know if that causes other problems.

     Arnd
