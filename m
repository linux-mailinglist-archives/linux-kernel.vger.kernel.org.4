Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF76A0AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjBWNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjBWNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:37:39 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A24DBE5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:37:01 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id u6so5197883ilk.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sP7OO7pY75acB3j8P2/QK5gFH3RzazXAttowMP569Uc=;
        b=B0wEgD1OktVXylPcjRbi2nRQHBVhpToHa9Bs7dtRBLVtufrGjxxvz645NbsDMVbw6W
         eeb7ylEzAaptkvUpmha7xX4qP7n+5d+skBXS5g0HN7ikUjDE+YZRZtW7s0OfIPXpN1+g
         FdgoDBJp4S9TSdxJs7yNO3KVmb8bTDPdjYKDiHbgSeoHOqbXn4soJni7MIC+ZT8pRWC/
         m4bGNyk3jL8QQYL3J1klGLbUjZfaauQNsSjr5lzbw0pcre8IXpOmCh8x682cnrtaYitG
         MVeatK0sAVwWiV4ZiO346DNslIlpgywLwZxguNiylMUtoLHSF6q5lmoBM7zIRhaObwBS
         jXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP7OO7pY75acB3j8P2/QK5gFH3RzazXAttowMP569Uc=;
        b=nXsHSAsw91BuHIDjoUUUvOk80X/ABqOMo7rKYrlob6EZYWQelXVag2pypb1x2f3O4o
         C9MGR+52IWhOuEzCnHs+sCP8RwQejnjtJ7wxwOHs3QnC5E7ic8iR/hAiWi10KQGWcQ+M
         zjfpKZa1m3Q8qqiaotdFVPqo8DZEaeZCZkvK9qnHluOR/UrAC83bMoYIy1aC41GNyj9U
         6duML1hG0Zl8Jlr+FbTDRw92P1RQc7cDqjxPS5PZSB6qYfzp+XBx8kU8ZW+uyfX0jW5q
         9U/rgb4EdXPichjS/5dQC38rSD8Ty6c19oapW8M8UMEbPt4Xim4l9J47bs+21xepg07U
         IHBw==
X-Gm-Message-State: AO0yUKVDmWAmFcoVmUrNN4xbKh0lEL18F/sFm6VzbYRWnoLDHBGe5Gf2
        iPcrEb7ZruUixOVpQSuyIbtcrQ==
X-Google-Smtp-Source: AK7set8z948GTlC8szDcOc8/WvlQxm1HwvJ/L6g9lQOWBvpyyqSSClk3PfhXNX0GkRjSC03LuFlClA==
X-Received: by 2002:a05:6e02:198a:b0:315:4a48:aaf with SMTP id g10-20020a056e02198a00b003154a480aafmr8322244ilf.14.1677159411062;
        Thu, 23 Feb 2023 05:36:51 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id p12-20020a0566380e8c00b003a2a167e7d9sm3547827jas.96.2023.02.23.05.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:36:50 -0800 (PST)
Message-ID: <380c88ef-eb19-e73e-0ec9-805b8b90e957@landley.net>
Date:   Thu, 23 Feb 2023 07:50:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] try generic compiler name "cc" before falling back to
 "gcc".
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <63c2936e-6bc7-67e3-eaf3-0123333381f8@landley.net>
 <CAK7LNASA+Dpe9nv4afnueFeRj4BZDUccOFGJRPr7_rZQ7ZZKaA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAK7LNASA+Dpe9nv4afnueFeRj4BZDUccOFGJRPr7_rZQ7ZZKaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 23:31, Masahiro Yamada wrote:
> On Wed, Feb 22, 2023 at 5:41 AM Rob Landley <rob@landley.net> wrote:
>>
>> Distros like debian install the generic "cc" name for both gcc and clang,
>> and the plumbing already does CC_VERSION_TEXT to include Makefile.clang.
>>
>> Previously: https://lkml.iu.edu/hypermail/linux/kernel/2202.0/01505.html
>> Signed-off-by: Rob Landley <rob@landley.net>
>> ---
>>  Makefile | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 3f6628780eb2..0ac57ae3b45f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -456,7 +456,7 @@ endif
>>  HOSTCC = $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
>>  HOSTCXX        = $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
>>  else
>> -HOSTCC = gcc
>> +HOSTCC := $(shell cc --version >/dev/null 2>&1 && echo cc || echo gcc)
> 
> 'cc' only makes sense for the host compiler,

It was the generic posix name for "C compiler" until posix decided to put an
expiration date in the command name, which seems as widely honored as the
tar->pax switch or the removal of cpio.

The name "gcc" was like "gmake" and "gawk". (On macos homebrew there's "gsed".)

> which is configured by 'update-alternative'.

Hexagon only has llvm support, not gcc, so I had to add an llvm cross compiler
to my cross compiler set, prefixed hexagon-unknown-linux-musl-*, but the linux
kernel wants to call it as hexagon-unknown-linux-musl-gcc.

The kernel builds find with a "gcc" symlink to clang, but there _is_ a generic
name, which is widely installed.

> I tried it before, but LLVM folks preferred
> using $(LLVM) to choose clang/gcc.

So if we want generic behavior without having to specify, we should create a
"gcc" symlink to clang?

>>  HOSTCXX        = g++
>>  endif
>>  HOSTRUSTC = rustc
>> @@ -503,7 +503,8 @@ OBJDUMP             = $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
>>  READELF                = $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>>  STRIP          = $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>>  else
>> -CC             = $(CROSS_COMPILE)gcc
>> +CC             := $(CROSS_COMPILE)$(shell $(CROSS_COMPILE)cc --version \
>> +                       >/dev/null 2>&1 && echo cc || echo gcc)
> 
> This hunk sets up GCC/binutils.

This is the codepath that's taken when you don't explicitly specify "LLVM=1".
The test there is falling back to (appropriately prefixed) gcc when it can't
find a working (appropriately prefixed) cc.

> So, cc does not make sense.  NACK.

Do you explicitly specify the "gold" linker vs the previous gnu one vs
lld.llvm.org on the kernel build command line?

Rob
