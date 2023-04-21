Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF56EAE09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjDUP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjDUP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:28:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6005B88
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:28:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F4545C018B;
        Fri, 21 Apr 2023 11:28:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Apr 2023 11:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682090930; x=1682177330; bh=UP
        cMqJZ0P9N+7xzCJQfPEeFFIsp8Kyk+UricifK8t2M=; b=PwhfxD33msHwYZJhDN
        Rz3H93n7oYbGH29nQ5i3Y9zMhXdnVAKKdyKoe821jOdNHpG9t8KUJeBWIoj7L7q0
        KD9zR6QeVKbnWsdeLiMT74fDjp6dT+aQMTWBgWmLp1ldTvq7ZB5S9QYhUif8hjOH
        hnVeoHwGH8ZVQiPw5/xEylPtFKn9a5fqpdz6ibR1JIw/T1kSm/7j1/jEqsmoYPWK
        PnEgDBkjSIsYH5BuurkMKLjvZDicXGZ5CyF0Cy8u1PQdFXdnDRgeezZ3XEvDOGh+
        nhM23ND9kaXc1YsyBdZ1hRGeG7XvlfxGvvBscIbPbN9HbGNLd2RJE1miJVZP1L+W
        xYZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682090930; x=1682177330; bh=UPcMqJZ0P9N+7
        xzCJQfPEeFFIsp8Kyk+UricifK8t2M=; b=Mbr3ig5z+4n15DHhycir6p6rXWfj+
        KX3nMEPlRPSskGmsfxecBJraYmNC0kPsGVUiYj2Yqg7LgRX79+MSTh5rkp9jI6yw
        wQx9qXKy7f7f9gsTOcaVPuOiGO3TO5YS1u+2Aai2gU1eyj44cS4PjTCOkiqzjMiT
        D6ghS8FO5mFcFFNCPDskOLBHhUg51+2hhd4gxdCOk/4p7DRmmIOzmuCwp/ksUkdt
        cwNv35ExmmzK7zOJQVTqjhWnCi8DBvncMxwIx2LdnHwtUMCMgTFzaFtFTgb/sEFT
        QODbcwNlTSUdZKn3BR1X0fwKBVAHnu6gZVxeNwIlGPfiGzyWDbmfAK0cQ==
X-ME-Sender: <xms:satCZC-PAl_5IPWHgULW-vJYi7vunjFCpEQ34ZbXln_3xYf9-6Lhrw>
    <xme:satCZCtNBcqu15tStIO2k-4qvYRpP8sc47FpRJNdg9VvJjo2TJxoa6AzswXvLUAm-
    CfJ7lQ8AhFDctX0npo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:satCZIDVmixRZmwRC70Aq7NTc94FvFBva2dGrQS6fdRPL76oLowrMg>
    <xmx:satCZKdToTB_YWvKWHoh7sVjYMXGZ9p7SHXC69Ik2Z2j59D1fyuzeA>
    <xmx:satCZHNsENL4-RPodlmEqnLZRB0JrTJadW9QIK3SmjKySqeVr0AI0g>
    <xmx:sqtCZAvCCGzDpKRIpEeencUGlI2HAcO3GXxxCF6s5oYiKqRTuebNlQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 39A5BB60086; Fri, 21 Apr 2023 11:28:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <b6341f73-3ad2-4fcf-8612-e026751019b5@app.fastmail.com>
In-Reply-To: <e46dd2bb-16d1-0c99-56f0-f8c2c4bbc79b@linaro.org>
References: <20230421130111.4041641-1-tudor.ambarus@linaro.org>
 <5d13e927-3713-4b9e-b007-6be5671d46f2@app.fastmail.com>
 <e46dd2bb-16d1-0c99-56f0-f8c2c4bbc79b@linaro.org>
Date:   Fri, 21 Apr 2023 17:28:28 +0200
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
        "Dmitry Vyukov" <dvyukov@google.com>, nogikh@google.com
Subject: Re: [PATCH] Kconfig.debug: disable CONFIG_FRAME_WARN for KASAN_STACK &&
 CC_IS_CLANG by default
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

On Fri, Apr 21, 2023, at 17:10, Tudor Ambarus wrote:
> On 4/21/23 15:30, Arnd Bergmann wrote:
>> On Fri, Apr 21, 2023, at 15:01, Tudor Ambarus wrote:
>> 
>>> The conclusion is that when KASAN is enabled the stack usage increases a
>>> bit, but nothing unmanageable ~30-70 bytes, whereas when enabling
>>> KASAN_STACK the stack usage is excessive, from ~1.7K to ~5.8K for these
>>> cases.
>>>
>>> Disable CONFIG_FRAME_WARN for KASAN_STACK && CC_IS_CLANG by default.
>>> Adventurers can still override the default value by input prompt or
>>> explicit values in defconfigs in case they feel that some real warnings
>>> are missed.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> 
>> I think we are still better off with the warning enabled. When someone
>> really wants to run a kernel with KASAN_STACK enabled, they should have
>> a chance to see what they are getting into and not report any runtime
>> bugs that come from stack overflow. 
>> 
>
> Are such stack overflows warnings reliable when we know that stack
> instrumentation causes excessive stack usage? Until clang is fixed one
> shall hunt frame-larger-than warnings with KASAN_STACK disabled.

The main problem with stack frame usage is that the compiler cannot know
during compile time what the other functions are going to use, so it's
always a bit of guesswork, and we just try to make the limit as small
as possible without causing too much work addressing the warnings.

Only if the frame usage grows beyond the actual available stack size,
it's guaranteed to crash (I've seen 80KB for a single function, clearly
larger than 16kb of total stack size), but the larger it gets, the
more problems you'll run into.

We already discussed years ago how clang can improve a lot of the
cases here by reworking the amount of padding between variables
similar to how gcc does it. This won't work for all files, but for
a lot of them, and once clang gets fixed, we can address the
remaining ones by working around them in the kernel.

     Arnd
