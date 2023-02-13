Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0F693E93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBMHAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:00:14 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758DDA;
        Sun, 12 Feb 2023 23:00:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C7B495C0113;
        Mon, 13 Feb 2023 02:00:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 02:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676271608; x=1676358008; bh=MYUhSAwp6n
        JgwmtSsWCxNN4aifIdwOQy7DHsVCaQUmc=; b=pwbeMXK2JIaejs3NfA1C33stmx
        bPPtO+OnYD3GWAEolZGQP1vbxQnTIAjBpRRVIal68apAQv9I7qtJj4dcsXEmf7PI
        Uz0hWokK2LQbYL7wy289RlwoMXqMbRhtPIKNGKMLpHRtrQWf8/S/zg7OncATv/Kx
        qOeHiAjiVXmeP4vPdFZzM6GbIq+N5Rvy449MnVtJ+3Dyr2G+1n7/69l0GcoYFLo1
        aS7tTZ7TDrwJrr4ZA1xp/YQ3/K3WCf1VQSm8HUYhYY0765OBgm630+/nPZHzI3SE
        so3tN6hpcDWKTpksOXoCBSzzU1NlJJrqrhlh0JDNx6VGSb/mNTQMka+EAAQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676271608; x=1676358008; bh=MYUhSAwp6nJgwmtSsWCxNN4aifId
        wOQy7DHsVCaQUmc=; b=eJ61mCKGo43fuBwMWnjDdu7AmtpD6lE3eVIddHrwj9AT
        qNWM28a58XeGQzKAyyeoAXvEPhTnCbtwmomnSdQ4KhzMiRh3yMsfik9EPvPgA/+r
        RWOGI/0V2qWKPhEUceMva4u6yJGpBkZUOZyfuEjIl4zsdnrl+2TGXjJx6G/qkGGf
        H8+64MOXPNpOo4ak+3TqyEBTMrWAZiHCU0Tuo52i2TVajplElYszxBURIFh8xoPo
        VOUuZlnrp9bkq4irzAIHLmRVRsHx6DsCB/0HJIURyjZ9gUMjQJpzXUFF7yGKFZHa
        P6BjQFmYCYT2gjdnSHvEeBw7Q+irUzWgI+M6G5XVew==
X-ME-Sender: <xms:-N_pY-5X4QfGElVV0hTziHnVFflBAqO5mWC09xUQqfo2VsNRmPFX-A>
    <xme:-N_pY35gUItem9qO8Y25AfmFSXt50zCib-LN10tdQgPsCjkW53MHIAY8OCmLeWEK-
    uata0IqiLlGXW3B8c0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgu
    segrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhepffehueegteeihfegtefhjefgtd
    eugfegjeelheejueethfefgeeghfektdekteffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-N_pY9ehcreFPvzmx4obytf1EFhs_Gl9UQJcAHa5z7zDpvyEhzqngQ>
    <xmx:-N_pY7J-TQIpWMnsvFFKQwHxbHJIov31wmZ99KVzQRrixvDTDfgYQA>
    <xmx:-N_pYyKiLv_EQ5o_Uzkff_idu82_RkhIh9iUkfDxVt76jx8E7MEJ_A>
    <xmx:-N_pY6-ULIYQDU8DqO4vUCvYaOqPG1NoOE95O6E19m5ekaYGBOtM6w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32E94B60089; Mon, 13 Feb 2023 02:00:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <3f70f54e-206f-438e-9ef4-2cd514d3a690@app.fastmail.com>
In-Reply-To: <CAKEwX=MneVSm49FYxNAP+-uQijOZnNfWjuzF7FPub_rcDFY__A@mail.gmail.com>
References: <20230203190413.2559707-1-nphamcs@gmail.com>
 <20230203190413.2559707-3-nphamcs@gmail.com>
 <834254e6-a9c2-440c-9c67-fc5fa5ca43bc@app.fastmail.com>
 <CAKEwX=MneVSm49FYxNAP+-uQijOZnNfWjuzF7FPub_rcDFY__A@mail.gmail.com>
Date:   Mon, 13 Feb 2023 08:00:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nhat Pham" <nphamcs@gmail.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Matthew Wilcox" <willy@infradead.org>, bfoster@redhat.com,
        kernel-team@meta.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 2/3] cachestat: implement cachestat syscall
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

On Sun, Feb 12, 2023, at 07:58, Nhat Pham wrote:
> On Sun, Feb 5, 2023 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Feb 3, 2023, at 20:04, Nhat Pham wrote:
>> 
>> > +SYSCALL_DEFINE5(cachestat, unsigned int, fd, loff_t, off, size_t, len,
>> > +             struct cachestat __user *, cstat, unsigned int, flags)
>> > +{
>> > +     return ksys_cachestat(fd, off, len, cstat, flags);
>> > +}
>> > +
>> > +#ifdef CONFIG_COMPAT
>> > +COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, 
>> > compat_arg_u64_dual(off),
>> > +             size_t, len, struct cachestat __user *, cstat, unsigned int, flags)
>> > +{
>> > +     return ksys_cachestat(fd, compat_arg_u64_glue(off), len, cstat, 
>> > flags);
>> > +}
>> 
>> This still looks wrong to me, as this compat definition does not match
>> the native variant on architectures that require 64-bit arguments to
>> be passed in aligned register pairs, such as arm, mips or ppc, but
>> not x86, s390 or riscv.
>
> Oh I see - thanks for pointing that out! And the last bit means this
> is a non-issue for x86, s390 or riscv right? 

Right. It still requires the separate compat entry point that we
generally try to avoid for new syscalls, but it's probably still
better than passing the offset through a pointer.


> And iirc from the last thread, this is fixable via a simple reordering
> of the args in order to properly align the 64-bit arguments, for e.g:
>
> SYSCALL_DEFINE5(cachestat, loff_t, off, unsigned int, fd, size_t, len,
>               struct cachestat __user *, cstat, unsigned int, flags)
>
> ...
>
> COMPAT_SYSCALL_DEFINE6(cachestat, compat_arg_u64_dual(off), 
>              unsigned int, fd, size_t, len, struct cachestat __user *, cstat, 
>              unsigned int, flags)
>
>
> It looks a bit odd to me that fd is not the first argument, but perhaps this
> is an acceptable sacrifice to avoid unused arg and keep the flags...
>
> Let me know what you think about this!

Right, this should work. You can also move the offset to the third
or fifth argument in order to keep the fd one first.

I would actually like to change all the syscalls that have loff_t
arguments to have explicit '64-bit' and '32-bit' versions rather
than 'native' and 'compat', to make it more obvious what is going on
even on the architectures that have no 64-bit variant.
That is something to do later though, you should definitely keep
doing this the same way we do for all other syscalls.

    Arnd
