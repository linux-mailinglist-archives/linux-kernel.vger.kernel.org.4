Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39AF63AA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiK1NzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiK1NzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:55:02 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DC8D66;
        Mon, 28 Nov 2022 05:55:00 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A65B5C0175;
        Mon, 28 Nov 2022 08:55:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 28 Nov 2022 08:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669643700; x=1669730100; bh=KQcpOA4V11
        EXNrxS5nHlKDVdF9XDuHnhnKU0CEb1Oes=; b=oNyCR4OtmVBeFtiRZAUp6Ly3/0
        49eqo8kBIYTm2G+DA9S3a8t4rYeBnPTT9iIt1PxJRxFBawR8+gxdAFoAHOvdV2ND
        XCnuyUeyF7NFRNrZ08IQMxpORXpj8riuU4L5+6JuJ0Q7Hbu3kV84f/qxKOw+4j2+
        xA6dxBtvnBh6CUbrTCwJJ58tvFPTAkJ64Waai18zwdR3tfJAQyh05yFVH9T7kLLh
        oere6Le73Xul6vmrQa+3mPGLm52v0yAsj+hdKl30hixpraIPFIV8Q2lV8O94OKn1
        nOJ/c78VTk1jAskPuMVK2jhot4LmkuRCLBN48W4sucerhQDc2IU4AO2DU+bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669643700; x=1669730100; bh=KQcpOA4V11EXNrxS5nHlKDVdF9XD
        uHnhnKU0CEb1Oes=; b=C4PCw4tt5+3rl7gaf8IhBxTQbzecepZ6NfbPkZAPOpvC
        GBQfrNUx3aFGt+rAZzSbDT0FY6rT+Ph5jmvwBpls67HlpT0Bq28cU8zxRlY9CkIg
        YrHIIqbtOcyFlyMyhsCHCYdcRB8p4n5BIrYqYgOILtoLYiafj3i8ltiSQ8hFWcwT
        smn+Ovwts0DjhE2Yq8tm43G/re3vIIWpI1BZaJDtuIkwsploYqemH4WRTUN1tEMN
        wRVeZo8inTu3tYsjRR8dPZcChJu4JJPLPsptgRtILfPSl1xrhCqExAjrTdfGqRau
        6TopQ5m3Gopf6Dnm5C9v5KGbWwbDabKobsVUxxdo3A==
X-ME-Sender: <xms:tL2EY8rtAfRYnl5O2c2v3hbhBzYmybGlrv7NESXuMgRX2YEIK4gUHw>
    <xme:tL2EYyrXo0oc2JV8G5JfLySzxLsSAxmccOrb0U1pG38D4fthuh63R4rgyh5ETacYy
    LvzzfrU3FiKCSKXc7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tL2EYxOxKrkP4qp07A8tuse86yXGL7QqpEcogYU_e3ripiDmUIrnCQ>
    <xmx:tL2EYz7jqy4ACOKdgJRVWFB8crdOrLdYpi3dnjiHAbl-huQcYRI3ng>
    <xmx:tL2EY745xcqCM79pfK40PtjTvPgOaFdR2nQntjZnfkcuYWE9CremXA>
    <xmx:tL2EY4FPmIZPVvlRoFF1KWz1MGHZjRNkcD59bJFtKo9N_G1KyIjl5Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0A1FAB60086; Mon, 28 Nov 2022 08:54:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <8f25aa1e-cb42-4ef0-a1ff-93dcf8651213@app.fastmail.com>
In-Reply-To: <Y4PF+pBlNZGfZ0sr@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-2-Jason@zx2c4.com> <87bkouyd90.ffs@tglx>
 <Y4PF+pBlNZGfZ0sr@zx2c4.com>
Date:   Mon, 28 Nov 2022 14:54:39 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v7 1/3] random: add vgetrandom_alloc() syscall
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

On Sun, Nov 27, 2022, at 21:18, Jason A. Donenfeld wrote:
>> 
>> config GENERIC_VDSO_RANDOM_WHATEVER
>>        bool
>>        select VGETRANDOM_ALLOC
>> 
>> This gives a clear Kconfig dependency instead of the random
>> ADVISE_SYSCALLS select.
>
> That's much better indeed. I was trying to straddle the two conventions
> of `#define __ARCH_...` for syscalls and a Kconfig for vDSO functions,
> but doing it all together as you've suggested is nicer.
>
> I'll try to figure this out, though so far futzing around suggests there
> might have to be both, because of unistd.h being a userspace header.
> That is, include/uapi/asm-generic/unistd.h typically needs a `#if
> __ARCH_WANT..., #define ...` in it. I'll give it a spin and you'll see
> for v8. At the very least it should get rid of the more awkward
> `select ADVISE_SYSCALLS if X86_64` part, and will better separate the
> arch code from non-arch code.

I think you should not need an __ARCH_WANT_SYS_* symbol for this,
the only place we actually need them for is the asm-generic/unistd.h
header which is still used on a couple of architectures (I have
an experimental series for replacing it with a generic syscall.tbl
file, but it's not ready for 6.2). In most cases, the __ARCH_WANT_SYS_*
symbols are only used for syscalls that are part of the table for
old architectures but get skipped on newer targets that always had
a replacement syscalls (e.g. getrlimit getting replaced by prlimit64)

I think we should just reserve the syscall number for all architectures
right away and #define the __NR_* macro. libc will generally need
a runtime check anyway, and defining it now avoids the problem of
the tables getting out of sync.

The Kconfig symbol is fine in this case.

      Arnd
