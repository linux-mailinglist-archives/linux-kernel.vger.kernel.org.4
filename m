Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D136EAD50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjDUOnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjDUOmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:42:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178AD324
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:42:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 960845C00EF;
        Fri, 21 Apr 2023 10:41:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Apr 2023 10:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682088080; x=1682174480; bh=cq
        rMn8PsCijMPIlumhaZUxmJD7Z0ZbjGhB78P+4Vmns=; b=akb4FBXOUltQS9C51W
        CAlL5PsoRAwGkhiHte9fOEElovSGT9cbvRFp3vnXtWH6toqNPKegFa+DL4ae6xc7
        de4ceYIUYA9KoiAOmbC3o87Mh7yalbrMrbL/ZpRjzChbbrowalzd+DNh5OntyEml
        lP/cm4Sk7AlX7jbJPoy8thnkm9qtGaQHxBNWS0CK7vAE76M1y7tLkiCDiX++oOja
        Z4QIq+P1kzvG/BzKVvl+0JtYTL+tJhdnDvrMqS8nynDJMRDhsEpt66sNIDwNClH8
        r1e373iYsd0DdrnLle+5dpGLgR43H3Lk0n1PVj+2KfvFRJEs/zhr3c2ig+Zi5vSh
        0oLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682088080; x=1682174480; bh=cqrMn8PsCijMP
        IlumhaZUxmJD7Z0ZbjGhB78P+4Vmns=; b=G6XCCAdLgtdkZkw7orITZX0IzE9GZ
        WcH8E1cj85JZpv5HyffbFT1ON/uxV6PMvapLE40KV+r/6SB0w9qFMff6V6fVBbqu
        KiXoyWcK/+Fvrisn79tl1/ufzgk5wWE8XR71LCH/5swWZ22IaqLD77BO2HILlb7+
        AMKrz+GuwKUF/ae1doH722b5YaqQmQ14WKKKEoBNFQxlB9Ju8686KTzGH/lkrQfy
        /M3fheBSMdjikXG1FtmlAI/PiEU8gGmE9qGY2w4/DF/H2fm1hZciRnlg3sgRw4l5
        QIk1KGGqowWiyLOmOmhImVI2gCRKTagrDXlprRd8SxllwkgMUyZwkhY5Q==
X-ME-Sender: <xms:j6BCZOsa_vcrg-klHnDAS24LMkOJfstwHLKUZp5Sc_0WnM_v21c1FA>
    <xme:j6BCZDe0-sURzRSMs48FAYJt2IMmBl-YlgX4Im-OI4Ly7y83mjtVjmWa9PUK-a_ct
    NhuS95AYe8cWs87Qi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:j6BCZJx9vFXii8uwxjpIhySx1T1hEPzDeM13BkBZwYOQu-2Nhv0y2w>
    <xmx:j6BCZJMPzzIOwy5n8y9avjpJjDd33ArN_5qThyCmZXTtmAR0mLULnw>
    <xmx:j6BCZO9377vt3-2-ZWeBVDc_O37hp3A3OSEMu6Lu6ZWeu_tEQoiNdg>
    <xmx:kKBCZB14XANXgKyXbeDmBwaEYhqwP0lAxDk4H8OAgRXMzQm8F8PoPQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7BB7B60086; Fri, 21 Apr 2023 10:41:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <e033ac24-0301-4c7f-8928-b940454c0a2b@app.fastmail.com>
In-Reply-To: <CANpmjNMRQiPPqifLbzob6OjOX9O+bWhGrQunZY+TY6gj9HwGug@mail.gmail.com>
References: <20230421082026.2115712-1-arnd@kernel.org>
 <CANpmjNMRQiPPqifLbzob6OjOX9O+bWhGrQunZY+TY6gj9HwGug@mail.gmail.com>
Date:   Fri, 21 Apr 2023 16:40:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marco Elver" <elver@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH] kasan: use internal prototypes matching gcc-13 builtins
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023, at 11:19, Marco Elver wrote:
>
> Does it work with Clang?

I tested successfully with clang-16, but did not try other versions so far.

> I don't mind either way, but the custom kasan_size_t change seems to
> just be needed to workaround the subtle inconsistency in type
> definition, but in reality there should never be a problem. I'd rather
> the KASAN code just uses normal kernel types and we just make the
> compiler be quiet about it.

Let me double-check, I think I may have made a mistake here, and
using the normal ssize_t (but not size_t) just works right. It looks
like I confused the size_t definition with something else, so this
hack may not be needed after all. I've changed it again now and will
give it another overnight test run on the randconfig setup.

> To do that, another option is -Wno-builtin-declaration-mismatch for
> mm/kasan/ which just shuts up the compiler, and allows us to keep the
> code as-is. Does it have any downsides?

I think the warning is useful in principle, at least it makes it
more likely to catch bugs if the prototypes ever change, and to
validate that things like __asan_allocas_unpoison() that I mentioned
are actually intentional.

      Arnd
