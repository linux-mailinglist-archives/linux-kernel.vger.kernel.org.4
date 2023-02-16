Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9465698923
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBPALf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:11:33 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152D3866F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:11:31 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A7EAD32000EB;
        Wed, 15 Feb 2023 19:11:30 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Wed, 15 Feb 2023 19:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1676506290; x=1676592690; bh=s7RLKYsqmc
        E2ukrTY/nQpIegrVoexFYig+L3rm5LLAY=; b=EXUJIHSeecx7WMOQFqsBl02QJB
        pVQu65u4vZ+Te/iuzsdhBDqoxJ/uCxnGrp6RQsI08ACt8ZemY3660NapPGoiGLOw
        qqhPcdEzIZV7mV5PhZMghIaKVnxOW8mTwuGvieqc2YC0trwZGribsz9QcrVrWhJx
        PPYLc8x3XKOQhscUBtfWODgVdoe1ymHfONguG5BVo0qgIaoOED1G/29y5kw9GOio
        Hhf8L2yt0XdBdIcIIPqXqy4lMrBS8sM0fgKtNpW5iTrq/v/Vin8yMUqJIhYAgH8w
        6TBkcQ4ICf0bC9ZiVoqFwPCvEGLl30/e677CBu9nw2DB50ODvVvbOzRsOLlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676506290; x=1676592690; bh=s7RLKYsqmcE2ukrTY/nQpIegrVoe
        xFYig+L3rm5LLAY=; b=AlAmrDDP/utGqNGWMBonZsF8dmxfrG4yZup114q/TbTo
        fPktcNULaY5V53HfftdDFvl4ldx7tYg6NdWhDKTzY1iOwR827BzhviFuW/5IFMKk
        aqO0CYLzX1SIXDj/sIbp3THwZXXvmmBIovM7zI9zLFVfMCP4uxZ70jNj0n89FpcY
        cOFimMkAkhmUFjuuD7VzaFwxKAN7sqBPlC/AdV79iOcT4hKRSFVjteVr1V9YWofh
        dvKw/36uFRIwkdtdBidowoPNjxyaVn7netPhrBPVMtNsRt9n1KK05xmrTmQHhlHJ
        E7Lfqyaob0MwkJd79WeQAt3BWPjmBznH1CmtBPknSQ==
X-ME-Sender: <xms:sXTtY8uD9RJBWwZPqhul_Hzxo70Cv5_Nq4Q1AQJdq8hqfIx5owEAMw>
    <xme:sXTtY5ebC3iIqSlVF0O29Vrq1NUxgA-zP7DfF_pIeBTOSFh17lyrl6LnRSWOsWMO8
    QnZRsZrru9bV94VUyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdggihhntggvnhhtucffrghgohhnnhgvrghufdcuoehv
    sehvuggrrdhioheqnecuggftrfgrthhtvghrnhephfeugeffgfetiefhieetfeefveevhf
    ffvdduvdetheefgeelfeetgfegueeghfefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:sXTtY3xBT-N92J4_HVrmsUkUnsGmwnVnNvTYXdFFVPZrHXtexjv8ug>
    <xmx:sXTtY_O1xygBBKQ_KDyiSJhYs2yjuiFHqlxQDlNwi2jSrLnav_yUyQ>
    <xmx:sXTtY8-OyHyFXbqtimfDcv-00xnKHuHIJCbCKEkAHS0Of9a0d3iO0g>
    <xmx:snTtY1IKuWQPlQwe1_1m05yrwKjiObXQLo-_7Ufscov3AGv34AJl_Q>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 86551BC0078; Wed, 15 Feb 2023 19:11:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <d89977ec-d8a8-4ffe-8e3e-a77885ff5f96@app.fastmail.com>
In-Reply-To: <Y+kvmy/5oK9trrDH@1wt.eu>
References: <20230209024044.13127-1-v@vda.io> <Y+RrySeoRJn9GbrI@1wt.eu>
 <38f0c544-cc4c-4e21-b9c6-4383ba0b6326@app.fastmail.com>
 <Y+jCSx0RW1zL7Wk5@1wt.eu> <Y+kvmy/5oK9trrDH@1wt.eu>
Date:   Wed, 15 Feb 2023 19:11:09 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023, at 13:27, Willy Tarreau wrote:
> Hi again Vincent,
>
> On Sun, Feb 12, 2023 at 11:41:15AM +0100, Willy Tarreau wrote:
>> Hi Vincent,
>> 
>> On Fri, Feb 10, 2023 at 08:03:02AM -0500, Vincent Dagonneau wrote:
>> > > Thanks Vincent. At first glance it looks good. I'll give it a try on
>> > > all supported archs to make sure we didn't overlook anything and we'll
>> > > merge it. One tiny comment though, look below:
>> > >
>> > >> Vincent Dagonneau (4):
>> > >>   tools/nolibc: Adding stdint.h
>> > >>   tools/nolibc: Adding integer types and integer limit macros
>> > >>   tools/nolibc: Enlarging column width of tests
>> > >>   tools/nolibc: Adds tests for the integer limits in stdint.h
>> > >
>> > > I mentioned in the first review that it's generally preferred to use
>> > > the imperative form rather than present participle on subject lines.
>> > > This would give:
>> > >
>> > >     tools/nolibc: Add stdint.h
>> > >     tools/nolibc: Add integer types and integer limit macros
>> > >     tools/nolibc: Enlarge column width of tests
>> > >     tools/nolibc: Add tests for the integer limits in stdint.h
>> > >
>> > > I can perform this trivial change locally before merging without asking
>> > > you to respin a series just for this if that's OK for you. Just let me
>> > > know.
>> > >
>> > > Thanks!
>> > > Willy
>> > 
>> > Yep, go ahead!
>> 
>> Done, however I'm seeing the following failures on aarch64/riscv64/s390x:
>> 
>>   $ grep -B 200 limit.*FAIL stdint.out |  grep '\(limit.*FAIL\|gcc-11.3.0-nolibc.*-O0\)' 
>>   /f/tc/nolibc/gcc-11.3.0-nolibc/aarch64*/bin/aarch64*-gcc -g  -O0 -g -o nolibc-test \
>>   100 limit_intptr_min = -2147483648                              [FAIL]
>>   103 limit_ptrdiff_min = -2147483648                             [FAIL]
>>   105 limit_ptrdiff_min = -2147483648                             [FAIL]
>>   /f/tc/nolibc/gcc-11.3.0-nolibc/riscv64*/bin/riscv64*-gcc -g  -O0 -g -o nolibc-test \
>>   100 limit_intptr_min = -2147483648                              [FAIL]
>>   103 limit_ptrdiff_min = -2147483648                             [FAIL]
>>   105 limit_ptrdiff_min = -2147483648                             [FAIL]
>>   /f/tc/nolibc/gcc-11.3.0-nolibc/s390*/bin/s390*-gcc -g -march=z10 -m64 -O0 -g -o nolibc-test \
>>   100 limit_intptr_min = -2147483648                              [FAIL]
>>   103 limit_ptrdiff_min = -2147483648                             [FAIL]
>>   105 limit_ptrdiff_min = -2147483648                             [FAIL]
>> 
>> It makes me think that the __WORDSIZE==64 condition didn't match there,
>> I'm investigating. However while looking at this I noticed a mistake in
>> your patch: in the 32-bit part, limit_ptrdiff_{min,max} were repeated,
>> and no least64_{min,max} tests were placed, so I sense a copy-paste
>> mistake though I'm uncertain about the initial intent. If you just want
>> me to drop the duplicate lines I can easily do it, just let me know. I'll
>> be back with more info once I figure the reason for these archs not using
>> __WORDSIZE==64.
>> 
>> #if __WORDSIZE == 64
>>                 CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
>>                 CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
>>                 CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
>>                 CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
>>                 CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
>>                 CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
>>                 CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
>>                 CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
>>                 CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffffffffffULL); break;
>> #else
>>                 CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
>>                 CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
>>                 CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
>>                 CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
>>                 CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
>>                 CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
>>                 CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
>>                 CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffU); break;
>> #endif /* __WORDSIZE == 64 */
>
> So after investigation, __WORDSIZE is not defined, hence the failures!
> It proves the importance of the tests you've added ;-)
>
> However we have the size of these types defined by the compiler itself
> at least since gcc-4.4 and clang-3.8 which are the oldest I could test:
>
>   $ mips-gcc44_glibc214-linux-gnu-gcc -xc -dM -E - </dev/null |grep SIZE
>   #define __SIZEOF_POINTER__ 4
>   #define __SIZEOF_LONG__ 4
>   #define __SIZEOF_LONG_DOUBLE__ 8
>   #define __SIZEOF_SIZE_T__ 4
>   #define __SIZEOF_WINT_T__ 4
>   #define __SIZE_TYPE__ unsigned int
>   #define __SIZEOF_PTRDIFF_T__ 4
>   #define __SIZEOF_INT__ 4
>   #define __SIZEOF_FLOAT__ 4
>   #define __SIZEOF_SHORT__ 2
>   #define __SIZEOF_WCHAR_T__ 4
>   #define __SIZEOF_DOUBLE__ 8
>   #define __SIZEOF_LONG_LONG__ 8
>
> In addition both provide __SIZE_TYPE__ which is defined either as
> unsigned int or long unsigned int, so that can simplify quite some
> parts (and other types are defined for other types in more recent
> versions). Both also define __LONG_MAX__ that you could possibly
> use to conveniently create INTPTR_MAX, INTPTR_MIN, UINTPTR_MAX and
> so on.
>

Mmmh, interesting, I hadn't thought about verifying what defined the __WORDSIZE. I assumed wrongly that it was set by standard but it seems not. 

I replicated your example on my machine to see the intersection of what is defined by both GCC and clang. Do you know if we would need to check any other compilers?

> And finally we should set the __WORDSIZE ourselves as 8*__SIZEOF_LONG__
> and that would do the job.
>
> I tested the following patch which passes all the tests successfully
> on all supported archs. Let me know if you agree with such a change
> and how you want us to proceed. It would require a small change in the
> commit message though, to explain that our pointers are the size of a
> long on supported platforms.
>

I can integrate the changes and write an explanation as a commit message and submit a new version tomorrow, would that work for you?

> Regards,
> Willy
>
> ---
>
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> index 6a7683de09ec..7da0d35c481c 100644
> --- a/tools/include/nolibc/stdint.h
> +++ b/tools/include/nolibc/stdint.h
> @@ -65,20 +65,12 @@ typedef uint64_t          uintmax_t;
>  #define UINT_LEAST32_MAX UINT32_MAX
>  #define UINT_LEAST64_MAX UINT64_MAX
> 
> -#if __WORDSIZE == 64
> -  #define         SIZE_MAX  UINT64_MAX
> -  #define       INTPTR_MIN  INT64_MIN
> -  #define       INTPTR_MAX  INT64_MAX
> -  #define      UINTPTR_MAX  UINT64_MAX
> -  #define      PTRDIFF_MIN  INT64_MIN
> -  #define      PTRDIFF_MAX  INT64_MAX
> -#else
> -  #define         SIZE_MAX  UINT32_MAX
> -  #define       INTPTR_MIN  INT32_MIN
> -  #define       INTPTR_MAX  INT32_MAX
> -  #define      UINTPTR_MAX  UINT32_MAX
> -  #define      PTRDIFF_MIN  INT32_MIN
> -  #define      PTRDIFF_MAX  INT32_MAX
> -#endif /* __WORDSIZE == 64 */
> +#define SIZE_MAX         ((__SIZE_TYPE__)(__LONG_MAX__) * 2 + 1)
> +#define INTPTR_MIN       (-__LONG_MAX__ - 1)
> +#define INTPTR_MAX       __LONG_MAX__
> +#define UINTPTR_MAX      (SIZE_MAX)
> +#define PTRDIFF_MIN      INTPTR_MIN
> +#define PTRDIFF_MAX      INTPTR_MAX
> +#define __WORDSIZE       (__SIZEOF_LONG__ * 8)
> 
>  #endif /* _NOLIBC_STDINT_H */
