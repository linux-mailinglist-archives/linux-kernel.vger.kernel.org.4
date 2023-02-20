Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D469D4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBTU2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:27:58 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0561AF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:27:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C305F3200904;
        Mon, 20 Feb 2023 15:27:56 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 20 Feb 2023 15:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1676924876; x=1677011276; bh=qFuGQt+3FG
        AfOgsxy46AUqg41XAeyOKt7kF61CcfWBQ=; b=XkZh2tl3Zfdq1kdy9x++EOy42w
        iLEW0kOCuERWBp4BZ1/UJH6VxVKkVAHHiYXOfBYOWmt6c0ud/4uuZ0utybGkyeoL
        V7jdq0Qi68lBDuEcSopZFZT92mSZbaymKgNDh2WSQh2sSLQgHRpVogiF+UkVGomS
        axnSyBw4S8jSfxSgqd0gsdjw+6sF/Z5qCj0V9NO9yyk5oqOnarN6VBDh4M8xwfJw
        PSAa6Qsuytjb+KQZDKBg6HJD/YBIscA4gyW5MsmrP0vfWl0AH8uPWksua4iCArOK
        RIzT7XasTsxmnIB07jyA0W2jX7lj0qq4u3shH+tyT3Ht3tmejo/oAm0GVA9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676924876; x=1677011276; bh=qFuGQt+3FGAfOgsxy46AUqg41XAe
        yOKt7kF61CcfWBQ=; b=QqwVPRZCCQMRCAkNLsAzWDi+VQoAQeJdobRD8Iy1f+jC
        RNAVSarhRt3VWyBv4OdPpICpW6ypCUYTsZX1sO4+BVZ9t9xZOw1uEaTSMwsZC0cE
        0upkVAxcSW619VDu/XPFjf5huWKef4mGTVuLSSQDA+9xBP+PoYmjcsEl+LEGpICP
        Btd8mjhW/m4f6g45L5E61faz/2KawEICpths9cvnNC/G5om+/Fw2BafOxFnxcjen
        7zDsuNqmq/PlJNapXhOORSYvBOApIOMpKESkROmHdTqbq+8r0tszkzhrGGYp2ES4
        uCh6z9aAhiTvH5wj2gRVQBu5OjizZ3EDLnC+tu8EUQ==
X-ME-Sender: <xms:y9fzY8KCNTGMY7IjFtFT7BMH0DKakf7lpHEKCpMa7rnMGfkgd8qeWA>
    <xme:y9fzY8IUERZlBQrn19CMrWGgC4FdtEEIZzPi_LpnHe8Ddlsj8x0kBJoOEZAxJpOEk
    4EPKSVrvj-TCmhqDpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdgg
    ihhntggvnhhtucffrghgohhnnhgvrghufdcuoehvsehvuggrrdhioheqnecuggftrfgrth
    htvghrnhephfeugeffgfetiefhieetfeefveevhfffvdduvdetheefgeelfeetgfegueeg
    hfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:y9fzY8t6JBSCSXL0UXJ299uM7tePZ20e5tM1E4H6nkDcSTVR2Ga7UQ>
    <xmx:y9fzY5YW4ttW_RKymTAXmVd5nnmcfQyb8j5pUYMj91FsXYVtOYJhuQ>
    <xmx:y9fzYzYmGuJPo1WarMBY4Zo1_rmBzUorgnptl7-eRCXooHfnGqYKRw>
    <xmx:zNfzY0AGnD0bS7Jf5OYyiQHiotG3mtwugBszPhhgxkr_QH2bNALF-g>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D27D1BC0081; Mon, 20 Feb 2023 15:27:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <1cab0bc1-58b1-471f-97b6-8ff1995281f4@app.fastmail.com>
In-Reply-To: <20230220144732.GA15550@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
 <20230219185133.14576-3-w@1wt.eu>
 <4da90248dbe94c5db1036cd873dfd910@AcuMS.aculab.com>
 <20230220144732.GA15550@1wt.eu>
Date:   Mon, 20 Feb 2023 15:27:35 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>,
        "David Laight" <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tools/nolibc: add integer types and integer limit macros
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Feb 20, 2023, at 09:47, Willy Tarreau wrote:
> Hi David,
>
> On Mon, Feb 20, 2023 at 09:14:04AM +0000, David Laight wrote:
>> From: Willy Tarreau
>> > Sent: 19 February 2023 18:52
>> > 
>> > This commit adds some of the missing integer types to stdint.h and adds
>> > limit macros (e.g. INTN_{MIN,MAX}).
>> > 
>> ...
>> > 
>> > +typedef   int8_t       int_least8_t;
>> > +typedef  uint8_t      uint_least8_t;
>> > +typedef  int16_t      int_least16_t;
>> > +typedef uint16_t     uint_least16_t;
>> > +typedef  int32_t      int_least32_t;
>> > +typedef uint32_t     uint_least32_t;
>> > +typedef  int64_t      int_least64_t;
>> > +typedef uint64_t     uint_least64_t;
>> 
>> The are also the 'fast' variants.
>> Although I'd be tempted to either not define the 'least'
>> or 'fast' types (or maybe define them all as 'long').
>> The only code I've ever seen that used uint_fast32_t
>> got 'confused' when it was 64 bits.
>
> Honestly I've never seen either the "least" nor the "fast" variants
> used and am not at all convinced we need them. But they're not causing
> issues either and I'm fine with Vincent adding them.
>

I have never seen them used in the wild either but I included them in the v5.

>> ...
>> > +/* limits of integral types */
>> > +
>> > +#define        INT8_MIN  (-128)
>> > +#define       INT16_MIN  (-32767-1)
>> > +#define       INT32_MIN  (-2147483647-1)
>> > +#define       INT64_MIN  (-9223372036854775807LL-1)
>> 
>> Those big decimal numbers are difficult to check!
>> A typo would be unfortunate!
>
> That's also the purpose of the test!
>

My rationale for writing the full decimal in the header file is that we have a check for that in the tests. Furthermore, I wrote the number in decimal there but in hexadecimal in the test. Hopefully, at least one of them is right and catches any mistake.

>> Maybe (eg):
>> #define	INT64_MIN	(-INT64_MAX - 1)
>
> Some would argue that it's less easy to check when you're grepping for
> a value. How often have you found yourself bouncing between glibc
> include files looking for a definition for example ? I'm not sold on
> either choice, it's indeed just a matter of taste in the end.
>
>> > +#define        INT8_MAX  (127)
>> > +#define       INT16_MAX  (32767)
>> > +#define       INT32_MAX  (2147483647)
>> > +#define       INT64_MAX  (9223372036854775807LL)
>> > +
>> > +#define       UINT8_MAX  (255)
>> > +#define      UINT16_MAX  (65535)
>> > +#define      UINT32_MAX  (4294967295U)
>> > +#define      UINT64_MAX  (18446744073709551615ULL)
>> 
>> None of those need brackets.
>
> Most likely it was done to be more uniform with the rest above.
>

It is mostly comestic, yes.

>> Defining in hex would be more readable.
>
> Sure they would but it's not the same. Hex numbers are usually
> considered as neither positive nor negative probably because they're
> more commonly used to manipulate bits rather than quantities, and often
> they will not trigger warnings on overflows. Look for example:
>
>   $ cat yy.c 
>   int a = 0x80000000;
>   int b = -0x80000000;
>   int c = 2147483648;
>   int d = -2147483648;
>
>   int e =  0x80000000 + 1;
>   int f =  0x80000000 - 1;
>   int g =  2147483648 + 1;
>   int h = -2147483648 - 1;
>  
>   $ clang  -W -Wall -Wextra -c yy.c
>   yy.c:3:9: warning: implicit conversion from 'long' to 'int' changes 
> value from 2147483648 to -2147483648 [-Wconstant-conversion]
>   int c = 2147483648;
>       ~   ^~~~~~~~~~
>   yy.c:8:21: warning: implicit conversion from 'long' to 'int' changes 
> value from 2147483649 to -2147483647 [-Wconstant-conversion]
>   int g =  2147483648 + 1;
>       ~    ~~~~~~~~~~~^~~
>   yy.c:9:21: warning: implicit conversion from 'long' to 'int' changes 
> value from -2147483649 to 2147483647 [-Wconstant-conversion]
>   int h = -2147483648 - 1;
>       ~   ~~~~~~~~~~~~^~~
>
> Notice how the hex ones didn't complain. Just for this I would
> rather keep the decimal ones, even if less readable.
>

Additionally, like previously mentioned, the tests are based on the hex representation as it is indeed easier to read.

>> Although all the 'f' get hard to count as well.
>> Given that the types are defined in the same file, why
>> not use ~0u and ~0ull for UINT32_MAX and UINT64_MAX.
>
> That's what I usually do but here I think it's mostly to stay
> consistent across the whole file.
>

Indeed, it is also mostly cosmetic.

>> Should UINT8_MAX and UINT16_MAX be unsigned constants?
>> (Or even be cast to the corresponding type?)
>
> Same, better not if we want to keep the compiler's warnings in case
> of wrong assignment. Just compare the outputs of:
>
>    char c = UINT8_MAX;
>
> when UINT8_MAX is defined as 255 and 255U. Only the former gives me:
>
>   yy.c:11:11: warning: implicit conversion from 'int' to 'char' changes 
> value from 255 to -1 [-Wconstant-conversion]
>   char cc = 255;
>        ~~   ^~~
>
> Thus it gives one extra opportunity to spot a typo.
>
> Thanks!
> Willy

Thank you for the review!
