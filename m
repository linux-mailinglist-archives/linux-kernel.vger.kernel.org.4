Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5D688ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjBBXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBBXaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:30:25 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813662102
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:30:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 15EDA3200923;
        Thu,  2 Feb 2023 18:30:21 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Thu, 02 Feb 2023 18:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1675380620; x=1675467020; bh=RNe+ZN3m88
        q/gbi9cYek38bmWZ4ZT8bAFxV1MLo7x2Q=; b=lhCX/V+STsI1I/PDNuTu1/RJ7d
        edxNfSOlP/IARtbhVhdftK9RgsiulhD9K1SYR51jIGB38j4Q/s0pyMw3EzDSECMO
        0bEqESuHaJMoMU50G7eVXfSGpv8TbumnaYIZbNWgilrC9aEj8AFdEhNsF1xdDMkv
        7WveZfrMLNK5QksWkBybPSatOYD3iwnex1F5ENUExD9x+nb0vuwlzfqwo+LWgy/5
        RTsOpfKy3AV7nbP+dsNqJnP6R/cxpH9LdpG6CqzRGY3aAT1Ys6C5YjQ1Phlh+5Ff
        bO5KBB8/suWGJxY/WImLuwD4GrHfSswNrcKhMMJVBPFXS/6LtXIM6/LdYRew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675380620; x=1675467020; bh=RNe+ZN3m88q/gbi9cYek38bmWZ4Z
        T8bAFxV1MLo7x2Q=; b=fA414KuxfCy0HVAj/U1V4sE7AffEHnSlXIZv9t3aWpnD
        kiCPqDLpE2jPdqjZ+9KAjiefeDLGydds0+2dwzBpFZMAkxmOt/TpgLV7f/q3c1kU
        /FpucB9Ysprd4+U1CCtG2PUGB60DyOFasEG2L4avBD9jto2hS5LFEUcgqTU/d4Ay
        wC/4U9P9N7BlJI7RsF7jbpVbCg4rZknOsqs4klMbvImDW+cTppQWCv+qTVZnunaO
        jFiQttvJw0fPdqk9HpUVqHaKfcoIMvy0NycEfhMM90R+Zf3CsQJV/aFPN6P3f7HE
        rpQcW2O2Q8l1gSjzL744wO9bJLRyF0vcpzwSkZ+k3g==
X-ME-Sender: <xms:jEfcY24BDvteDDWbdOyq872CMaemmob1xjSDWP_QojWjpw0aPVhOSg>
    <xme:jEfcY_6LnXdZYqU64RGd1mwyVrovKj4brmIsK1AnrW5ErK02DBksB6ivw9LkEeegz
    YGaMqqroHQg1jxSaPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdggihhntggvnhhtucffrghgohhnnhgvrghufdcuoehv
    sehvuggrrdhioheqnecuggftrfgrthhtvghrnhepudevleeltdekieeggefhhfdvgffggf
    fgkeevffdtgedvledvfedugeefieffkefhnecuffhomhgrihhnpehophgvnhhgrhhouhhp
    rdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:jEfcY1cnY8M4B2yUDM2WYe6fdBWOdRuVH81aJTt4TFuvLZ7XJlitOA>
    <xmx:jEfcYzJWp0EEL4mT8qc5zmLvRONVU_jB_-MSI4kjayakkaaMe8MNcQ>
    <xmx:jEfcY6JjDFrJf6PsTPwhqM74yYBOhjIe7gPG5hlnxdmhxFBsZcebtg>
    <xmx:jEfcY5kAvLLlse2SyIQ2WJjTE50kljhi_09eeqUMSiIO_V30_dQZtw>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 24CC9BC0078; Thu,  2 Feb 2023 18:30:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <7c7f14f9-7625-4e9e-bc6e-c85bdc32b289@app.fastmail.com>
In-Reply-To: <20230202214657.GA4579@1wt.eu>
References: <20230202201101.43160-1-v@vda.io> <20230202214657.GA4579@1wt.eu>
Date:   Thu, 02 Feb 2023 18:29:59 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Add stdint.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Thank you for the extensive message! I'm already working on a new version including all the feedback you gave.

On Thu, Feb 2, 2023, at 16:46, Willy Tarreau wrote:
> Hi Vincent,
>
> On Thu, Feb 02, 2023 at 03:11:01PM -0500, Vincent Dagonneau wrote:
>> Hi,
>> 
>> This is v2, thank you Thomas for the reply. This version hopefully
>> addresses the comments you made. I also added some rough tests for the
>> limits.
>> 
>> Add stdint.h and moved the relevant definitions from std.h. Also added
>> macros for limits and *_least_* types. Adds tests for the integer
>> limits.
>
> First, thanks for this work. In order to respond your initial question,
> yes there's definitely interest in having something like this to further
> ease portability, even if we all know that programs that can be built
> with nolibc are really tiny and limited.
>
> A few points though:
>   - for your commit message, you'll need to put a description of what
>     it does and the reasons for your choices so that it's easier to
>     figure later when facing the patch during a bisect session or a
>     git blame.
>

Ok, on it.

>   - you'll also need to append your signed-off-by tag for the patch to
>     be merged. Some developers purposely don't put it during reviews
>     to save it from being merged but then it's better to write
>     "PATCH RFC" in the subject to make it more obvious.
>

Ok, I'll had the signed-off-by.

>   - the history between your changes, if any, should rather be placed
>     after the "---" that ends the commit message: it will not appear
>     in the commit message but still passes the info to the reviewers.
>

Ok.

>   - I'm seeing some preparatory changes in nolibc-test.c that are not
>     directly caused by the patch itself but by its impact (essentially
>     the width changes), and these ones should be separate so that they
>     do not pollute the patch and allow reviewers to focus on the
>     important part of your changes. I even think that you could proceed
>     in three steps:
>       - introduce stdint with the new types and values
>       - enlarge all fields in the selftest to preserve alignment when
>         dealing with large return values
>       - add the integer tests to the suite.
>

I'm thinking of four steps:
  - move the existing types to stdint.h, it should compile just fine and would not be adding anything
  - add the new stuff to stdint.h (*_least_* types + limit macros)
  - enlarge the fields in the test file
  - add the tests themselves

Would it work for you?

> That would give you 3 patches. In the last one it would be appreciated
> if you at least mention roughly in which condition you've tested it
> (native local test, or qemu for arch x/y or real hardware of what arch).
> That will help other testers gauge if it's worth running extra tests on
> other platforms or not.
>
> This aside, I'm having a few concerns below:
>
> (...)
>> +typedef unsigned long        size_t;
>> +#define       INT64_MIN  (-9223372036854775807-1)
>
> This one shoul have "LL" appended, otherwise in some operations it will
> be considered as an integer and some values can be truncated.
>
>> +#define       INT64_MAX  (9223372036854775807)
>
> Same for this one.
>
>> +#define       UINT8_MAX  (255)
>> +#define      UINT16_MAX  (65535)
>> +#define      UINT32_MAX  (4294967295U)
>> +#define      UINT64_MAX  (18446744073709551615)
>
> This one is missing ULL for the same reasons. Look for example at the
> nasty impacts on a 32-bit system:
>
>   $ gcc-5.5.0 -xc -Os -fomit-frame-pointer -o /dev/stdout -S - <<< 
> "unsigned x() { return ((18446744073709551615) << 1) >> 40; }" | grep 
> movl
> <stdin>: In function 'x':
> <stdin>:1:25: warning: integer constant is so large that it is unsigned
>         movl    $33554431, %eax
>
>   $ gcc-5.5.0 -xc -Os -fomit-frame-pointer -o /dev/stdout -S - <<< 
> "unsigned x() { return ((18446744073709551615ULL) << 1) >> 40; }" | 
> grep movl
>         movl    $16777215, %eax
>
> See ? When there's no variable around to help figure the type, the default
> type will be "int" for the intermediary operations and some calculations
> will be wrong without the proper suffix.
>

Thank you for the detailed explanation, it's fixed!

>> +#define         SIZE_MAX UINT64_MAX
>
> This one is not correct, it must follow the word size since it's defined
> as an unsigned long (i.e. same as UINTPTR_MAX later).
>

This one is a trick one I think. I've been using https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html as a reference for this patch and it says SIZE_MAX > 65535 (implementation defined). I guess in this case I should follow include/uapi/asm-generic/posix_types.h ?

> And below please also add the LL/ULL as needed to the hex values you're
> testing to match the expected signedness and size:
>
>> @@ -531,6 +531,35 @@ int run_syscall(int min, int max)
>>  		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
>>  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
>>  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
>> +		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (int8_t)   0x7f); break;
>> +		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (int8_t)   0x80); break;
>> +		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (uint8_t)  0xff); break;
>> +		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (int16_t)  0x7fff); break;
>> +		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (int16_t)  0x8000); break;
>> +		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (uint16_t) 0xffff); break;
>> +		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (int32_t)  0x7fffffff); break;
>> +		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (int32_t)  0x80000000); break;
>> +		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (uint32_t) 0xffffffff); break;
>> +		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (int64_t)  0x7fffffffffffffff); break;
>> +		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (int64_t)  0x8000000000000000); break;
>> +		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (uint64_t) 0xffffffffffffffff); break;
>> +		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
>> +		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
>> +		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
>> +		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
>> +		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
>> +		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
>> +		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
>> +		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
>> +		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffff); break;
>> +		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffff); break;
>> +		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000); break;
>> +		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffff); break;
>> +		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (void*) 0x8000000000000000); break;
>> +		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX, (void*) 0x7fffffffffffffff); break;
>> +		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (void*) 0xffffffffffffffff); break;
>> +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,  (void*) 0x8000000000000000); break;
>> +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (void*) 0x7fffffffffffffff); break;
>

Thanks, done!

> Other than that it looks correct.
>
> If you're having doubts, please run it in i386 mode. For this, please have
> a look at the thread surrounding this message, as we had a very similar
> discussion recently:
>
>    
> https://lore.kernel.org/lkml/Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org/
>
> It will show how to run the test for other architectures under qemu
> without having to rebuild a whole kernel. For what you're doing it's
> a perfect example where it makes sense.
>
> I would also suggest always trying arm (has unsigned chars, could
> possibly catch a mistake) and mips (big endian though should not
> be affected by your changes, but it's a good habit to develop).
>

Yes, as soon as I have some workable patch I'll test it on other arch. Most of it will be on qemu though, I might be able to test on x86_64 and arm64 hardware but that is all I have.

> Thanks!
> Willy

Thank you for the review, I do appreciate the time you've spent on the response. I'll get a new version out soon.

Vincent.
