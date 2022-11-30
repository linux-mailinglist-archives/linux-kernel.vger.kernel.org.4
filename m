Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20C63D3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiK3Kw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiK3KwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:52:22 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD573BBC;
        Wed, 30 Nov 2022 02:52:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B170932004E7;
        Wed, 30 Nov 2022 05:52:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 05:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669805539; x=1669891939; bh=LVUWCgBa8D
        QSz0Eyns9wgPpfLDCR/8+BYL2daAtg2dA=; b=SoBM0u1SYcGu1DX//wMHeIVWVS
        Y2TostUqhFvjW66YGqiMK0ZF2cz9LID8GIsxAv7pUwiUsA8qVo5boDfTRv530Wbw
        nbKmBgFCzrxotCO/TDxDsMTQ3G7XKgaZkeXmhToGW+dMuVQAjyZ8Pt8lWv3qyJkS
        GSeCSHjE6rzsvmAXiu/376YPQb1HyuhTyOGlLkD0iiT0HDkdeTQlF1RUs0HefKxQ
        mViBt2Mo9Rmi4E3CJZh1GVA1hnshPccOtwV52R3FygSnQgLhaUGzxlNZQGemeTBj
        mio7tBPE1+B4b7kg/lVx6JSiD0ERF1HvLY09KbVv9ld2+luIB0TH6oHe/x5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669805539; x=1669891939; bh=LVUWCgBa8DQSz0Eyns9wgPpfLDCR
        /8+BYL2daAtg2dA=; b=WwW11BPoOGbbQEtcp3PAQd5e9SAUOQCEn268/7LOTkg3
        q2CrW2GWs5bvodx2qXnq57VhTcKfQ+RXXW/z/3vfg6z/gNEkxB34Cy0M/xEUPq+B
        tWHyyeO1sTvQXBUXHrcwNwa21dTWm8Bz3QT02sqJQfwu1dDKRjuo+payzp177XzJ
        Axdx+bC3RePZ03upAJNxZAAhyiWnXtvS8b+qfUZVGNfM8ii/88ND6oBosX1n3J3S
        FjOZpTaLzXusiBHSPKx3Y8HMeAW8bsP4Oif2aNmc+wTxpymZb+dza6Ki5rRrvldl
        2tavNeg9XXVcQHooc2WuLc17cSpEVi6JOmiqI5ldYA==
X-ME-Sender: <xms:4jWHY_mVQ5MZHA3HIG6vMu6yQHVQkcAQWO-ADzT83TP8qYngKPvLew>
    <xme:4jWHYy2tBuSAe1M2RSRAs-erhvEpLHed_lBLRDwzqWCCXxXjlDkpLIdQfBb0_VDD_
    jnpSYwzaqVKupspObg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4jWHY1qCSrlPmakc9h1yn4Nsj2FFJLqTyJZLuS-ug9dORR8zWdLYbQ>
    <xmx:4jWHY3nIsVEeVhmr1iL23EkOHQUEImPLjKCRGlPUD2jqiNuQOwdvaQ>
    <xmx:4jWHY93VnnwoXYsGKjBzMrV6H7j5D2hi-5zDdXQGhl20ZWRa5Obacw>
    <xmx:4zWHY2uZijqMU7ijNB_fpey8loDwDEwXX30w-ZUH1jVV2X7GKqNMwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CADD0B60086; Wed, 30 Nov 2022 05:52:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <a4dd027b-e36a-4e84-b814-785381fe2817@app.fastmail.com>
In-Reply-To: <Y4crL0dqX7U4wnHH@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-3-Jason@zx2c4.com>
 <CAMuHMdUGkhFu7X8eUMU1qqTOLKC=xsXWG2obPUeTwzyMGD8grw@mail.gmail.com>
 <Y4crL0dqX7U4wnHH@zx2c4.com>
Date:   Wed, 30 Nov 2022 11:51:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v10 2/4] arch: allocate vgetrandom_alloc() syscall number
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022, at 11:06, Jason A. Donenfeld wrote:
> On Wed, Nov 30, 2022 at 09:56:06AM +0100, Geert Uytterhoeven wrote:
>> Hi Jason,
>> 
>> On Tue, Nov 29, 2022 at 10:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > Add vgetrandom_alloc() as syscall 451 (or 561 on alpha) by adding it to
>> > all of the various syscall.tbl and unistd.h files.
>> >
>> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> 
>> Thanks for your patch!
>> 
>> What's the policy regarding adding syscall numbers for VDSO-related
>> syscalls on architectures that do not support VDSOs yet?
>
> I don't know exactly what the /policy/ is, but not wanting to rock the
> boat, the first iterations of this series only added it to x86. But then
> Arnd joined the thread and said I should add it to all of them all at
> once and separate that out into this commit, so that's what we have
> here. I think the idea is to keep syscall numbers synchronized these
> days between archs if possible.

Right, it shouldn't matter if the syscall has anything to do with vdso
or some other feature, the important bit is that this is an optional
syscall that may or may not exist in a kernel.

Adding every new syscall number to all architectures helps avoid
merge conflicts and keeps the numbers synchronized. It's entirely
plausible that this one gets enabled on an architecture that starts
out with the default -ENOSYS implementation, and has that
backported to 6.2 (or even older kernels in principle) for a
distro release, so it also makes sense to have it in the uapi
table as soon as we have fixed the number.

     Arnd
