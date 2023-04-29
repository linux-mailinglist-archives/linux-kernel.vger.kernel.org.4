Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1345D6F26F9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjD2WEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2WEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:04:04 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7649E1727
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:04:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1AF34320046F;
        Sat, 29 Apr 2023 18:03:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Apr 2023 18:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682805838; x=1682892238; bh=Gr
        mqce6ZIJAbv3KbdF0ct03pH7DdnZSbJCu9rKvBOnM=; b=kHHb4rtp+yPy3s7m38
        B1j1tuD1k6ByyxZ48YbM3uYxhOiB2y899vyLR+fOzWEHV77iur6WNXrBKoRaIT36
        P5OaNf8QEQ/mYhbM/yrYmJtomxrewagdh+6E76raNIZFeGMzHLYAQxMPiw1qMRSo
        me/Y40ouP15vZgGXB7WrvLYxc84dO4zFkZ5gmoy1ONiQKF7PTwBTGl18vjHxsms1
        Kc0vClOvskb95oZRMoec7LL8eg2FfHngoy51PwRdDGZNrjN9Un+LTadGEoE9ZawW
        uglrLWgR61xyg4w1lZmUn233Hztxz5qR9932hxUhrVSzeoKrCg8SZAGQfYtYQX8z
        xpaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682805838; x=1682892238; bh=Grmqce6ZIJAbv
        3KbdF0ct03pH7DdnZSbJCu9rKvBOnM=; b=MMrZtAZHNU7EYXbvuOQsbH6mV0Wwm
        VXZL0ZC7WkD7kjqW2N7IyVI/0hR//uPY3IuwYmhxPkNB393vb5QGvRoWL6sISBsU
        nDVJFqLNdru0cs76bICTBBOfOtHA7ul9r+6/FANJ/xbzzB5P/BQvdtOKu7JTaIKj
        G/Jxn/De0I5VSRfMKWsD7n5zJbTwhudzbHje3xAMBPsHP+ajKNyHHuqKa6aXna6c
        ib1i/R5IZAyGJf8e4M0BBuxrMasz/OOZqDDJ3+FOmKCjH1rH8Ds15yf3kbNcJ5ZW
        gVmVQU2j3758GdoLjI3fgHUNEuudJnXMbC77stGf/lcFielwYwPHhgc4Q==
X-ME-Sender: <xms:TZRNZFT2EXwN5UO-Xsjt7zE3LpHYELtdMtboXri5YxR34JSR8iLGCw>
    <xme:TZRNZOx1Wyz-iYney1On1BMyu62bu2sZn9fPturHm7prYAERpSpOckml2qbRG4nNa
    HBsxanEWoXEl2B6vmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TZRNZK2V02OQohtQCwSYMF-4RxAH31CJgrR2Dg4Dep5Ac0UIQRuJlw>
    <xmx:TZRNZNCU79_mZRfF0LcTxh3YJR9iqagKTdU6yxR2CZehTNkmts571Q>
    <xmx:TZRNZOgAuWRaPoHxUQK_9i8ZaW-MPqwI-q1gIWl6W30FuuaE6tIEuA>
    <xmx:TpRNZFTHVIieBfzEbvTBy3D7ZYqGvvzwSxBtAzppY5SJUHdIuNEkUA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7107B60086; Sat, 29 Apr 2023 18:03:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <96947fdc-835f-4bfa-b112-4ba9991cfe5f@app.fastmail.com>
In-Reply-To: <b6341f73-3ad2-4fcf-8612-e026751019b5@app.fastmail.com>
References: <20230421130111.4041641-1-tudor.ambarus@linaro.org>
 <5d13e927-3713-4b9e-b007-6be5671d46f2@app.fastmail.com>
 <e46dd2bb-16d1-0c99-56f0-f8c2c4bbc79b@linaro.org>
 <b6341f73-3ad2-4fcf-8612-e026751019b5@app.fastmail.com>
Date:   Sun, 30 Apr 2023 00:03:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tudor Ambarus" <tudor.ambarus@linaro.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     joneslee@google.com, "Peter Zijlstra" <peterz@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>, zhaoyang.huang@unisoc.com,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Mark Brown" <broonie@kernel.org>,
        "Dmitry Vyukov" <dvyukov@google.com>, nogikh@google.com,
        "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH] Kconfig.debug: disable CONFIG_FRAME_WARN for KASAN_STACK &&
 CC_IS_CLANG by default
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023, at 17:28, Arnd Bergmann wrote:
> On Fri, Apr 21, 2023, at 17:10, Tudor Ambarus wrote:
>> On 4/21/23 15:30, Arnd Bergmann wrote:
>
> The main problem with stack frame usage is that the compiler cannot know
> during compile time what the other functions are going to use, so it's
> always a bit of guesswork, and we just try to make the limit as small
> as possible without causing too much work addressing the warnings.

Hi Tudor,

One follow-up here regarding the risk of actually overflowing the
stack on production systems: There is a possible feature that I've
discussed with Ard in the past, if we add a user-configurable stack offset
for syscall entry, it becomes possible to test kernels with an
artificially low stack size to find out the most critical call chain
that one can hit from user space.

You mentioned elsewhere that you are using syzkaller for testing for bugs,
and this would be the perfect way to exercise the modified kernels as
well, since it can hit all kinds of unusual call chains.

We already call add_random_kstack_offset() on four architectures (arm64,
powerpc, s390 and x86), and the same location could add a fixed offset
that is configurable e.g. system-wide using sysctl() or per task using
prctl(), depending on what makes this more useful for testing.

When CONFIG_VMAP_STACK is set, the result should be a process crash
with a full call chain printed to see how it got this bad, similar to
what you get with a KASAN violation. This probably makes most sense
with KASAN_STACK disabled to see which functions are the most critical
in real systems, though testing with KASAN_STACK enabled could also
give some hints at which of the warnings you see are worth fixing first.

If you would like to run tests with this, I might be able to come
up with a prototype patch for it.

       Arnd
