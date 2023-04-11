Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDF6DCE66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDKANz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDKANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437971FF3;
        Mon, 10 Apr 2023 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GY9ABpgWynxNjhU1lLhJVk+AzfLMtcrMxKPhxZiWpFg=; b=bSpSMsIQQrUOiqQrUhzq7wcT9D
        pOhKxkKQJmfvdNEYpzFSTq0p1aizrJEavDyRhmEigqI26Vrci0m6EOtJzWUmQcp4aVP4WXPzcQYMz
        dU184bwZW1hnyKXc249ZOjH1jkHclnUUs+1WDBSO4dXApfBQHYW2W2Bze7Dmkyog9qXKWvoeE2rfv
        x0kj0GiyoXkcbzwgFR71sBtECFmY1BkygEf5mXyi1zSbd6l0CWuWleVPKa2P5Nbh4rQEK0IeU2Du5
        yfk9rj4QbHOTqohtpdNruf4e3gXV5S9f/LOtSdsAOoYdnWO2yJE+pPS88pYM0YoH1UHmx7SZ3QQ9m
        MAllYgHg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pm1dn-00G8e4-2D;
        Tue, 11 Apr 2023 00:13:43 +0000
Message-ID: <bc86a2c3-7562-9d98-5ab0-f875ca9dbfff@infradead.org>
Date:   Mon, 10 Apr 2023 17:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] sparc: allow sparc32 alias for archhelp
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230410011316.26564-1-rdunlap@infradead.org>
 <CAK7LNAQGqF-9Tw1ZQQUTcn23P8AKy8YQwVy1BJtc5eX-WEZkUw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAQGqF-9Tw1ZQQUTcn23P8AKy8YQwVy1BJtc5eX-WEZkUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/23 16:45, Masahiro Yamada wrote:
> On Mon, Apr 10, 2023 at 10:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Currently, entering
>> $ make ARCH=sparc32 help
>> prints the archhelp text for sparc64.
>>
>> Since "sparc32" is documented (Documentation/kbuild/kbuild.rst)
>> to be a recognized alias for 32-bit sparc, also support that
>> string in sparc's archhelp by allowing either ARCH=sparc or
>> ARCH=sparc32 for sparc32 archhelp.
>>
>> Fixes: 5e53879008b9 ("sparc,sparc64: unify Makefile")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>> v2: rebase/resend; add Masahiro to Cc: list
>>
>>  arch/sparc/Makefile |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff -- a/arch/sparc/Makefile b/arch/sparc/Makefile
>> --- a/arch/sparc/Makefile
>> +++ b/arch/sparc/Makefile
>> @@ -83,7 +83,7 @@ vdso_install:
>>  KBUILD_IMAGE := $(boot)/zImage
>>
>>  # Don't use tabs in echo arguments.
>> -ifeq ($(ARCH),sparc)
>> +ifeq ($(ARCH),$(filter $(ARCH),sparc sparc32))
>>  define archhelp
>>    echo  '* image        - kernel image ($(boot)/image)'
> 
> 
> BTW, this is strange.
> 
> 
> The asterisk means it is built by 'all'.
> 
> 
> But, I only see the following in this Makefile.
> 
> 
> # Default target
> all: zImage
> 
> 
> 
> 
> 
> Seeing arch/sparc/boot/Makefile,
> it is true $(boot)/image is generated
> as a side-effect of zImage, but it it true for
> both 32-bit and 64-bit.
> 
> I think it is even better to rewrite archhelp
> to unify the 32/64 bits.
> 

Yeah, I had thought of that also. I'll do that and resend it.

Thanks.

> 
> 
> 
> 
>>    echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
> 
> 
> 

-- 
~Randy
