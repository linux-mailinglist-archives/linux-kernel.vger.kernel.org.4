Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7A611AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ1TUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1TUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:20:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F6C07;
        Fri, 28 Oct 2022 12:20:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o28so1440018qkl.4;
        Fri, 28 Oct 2022 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFtzDp1GmCsTv7CuMlTyHutAb+I5WP7vletAv2HWDNc=;
        b=EpEDr6Ey6WfAXuzpa4OZrcb2T5JyYMgqDvYRgnKe5QjROwWYyUDbl5XL7UlTlCcDOT
         ubcIGNK3xYa5pgURVJ2ur1lrulnFssCwYhEdSCD19ATc3tTjyVlXvDYpvhfLkuTiUfn5
         adqbdblIMRG+vdv/YyDzV2QQ8HztVP+GivJX74mcUgy+x7QuCIgdQoijWes81oaDJvBZ
         PubF0EXcWPu1FMzYm4uMb+niofLQ4VX/er0acUiMZjhmQLktTYPxaIVpZU9R4HEyo//T
         4wMU9Q3XB/w5dIpMiFGjy2w4NL0412VmuQIsNhapKJSh1Vyci7MkT5F5aJ7ghGZ78bFq
         wJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFtzDp1GmCsTv7CuMlTyHutAb+I5WP7vletAv2HWDNc=;
        b=KYIjNDk+D+gwcVjP+tDoZ2NH3xbGLL4UKp1A7kQdYlHlOLa7RI+nBpCDwOHy3JD8fP
         vPWWX+ECoYdWr0tMNJWnBebXdFxvhjkxctaNRmlveiFlFuMw+vNaZjbjeByiN8CQZBpw
         5GC2pIaGUM2OoTlwwPf/cuWfy4pyd4tjzqCx3PSpMrc5OAfR3Vw0IAVpB/Pt39WYiIY1
         yp5WwIGk2WSqUm4a/UGywlQZCg4OF+4qV6txq6WxSBiw0uwCq/ZXx5+NGbYMa7FbHzzQ
         AVpYrjw1OwTBzCVhvY1s0eRXi+o9RYgwinITIdqjQ2qfGujUShc5oEzQLI2cLTh/GizR
         cr3w==
X-Gm-Message-State: ACrzQf0jSaHqwSa/O0Q5VhIdF+JdN9Hi1sv12nR5PQMqyAhNKNL+bLVr
        aj4KK3denjpjQVaXInFBeZB7cHVC/r4dmw==
X-Google-Smtp-Source: AMsMyM5oZr8OPAlWj4c3h/ga6550MUS6ZhwfBdY9Ty3fAWElG5gkSSJGyXnHzommGtawZMqllL7utw==
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr665970qko.416.1666984801430;
        Fri, 28 Oct 2022 12:20:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d20-20020ac851d4000000b00399fe4aac3esm2783285qtn.50.2022.10.28.12.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:20:00 -0700 (PDT)
Message-ID: <28a8fccb-508c-7a49-a79a-5167da8fba81@gmail.com>
Date:   Fri, 28 Oct 2022 12:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] include/uapi/linux/swab: Fix potentially missing
 __always_inline
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Petr_Van=c4=9bk?= <arkamar@atlas.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, mmayer@broadcom.com,
        Khem Raj <raj.khem@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220927215256.528619-1-f.fainelli@gmail.com>
 <YzTMUpd6HbHmZu8f@dev-arch.thelio-3990X>
 <ed9b8268-0128-0486-04a3-54f343afd38b@gmail.com>
In-Reply-To: <ed9b8268-0128-0486-04a3-54f343afd38b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 13:33, Florian Fainelli wrote:
> Hi Nathan,
> 
> On 9/28/2022 3:36 PM, Nathan Chancellor wrote:
>> Hi Florian,
>>
>> On Tue, Sep 27, 2022 at 02:52:56PM -0700, Florian Fainelli wrote:
>>> From: Matt Redfearn <matt.redfearn@mips.com>
>>>
>>> Commit bc27fb68aaad ("include/uapi/linux/byteorder, swab: force inlining
>>> of some byteswap operations") added __always_inline to swab functions
>>> and commit 283d75737837 ("uapi/linux/stddef.h: Provide 
>>> __always_inline to
>>> userspace headers") added a definition of __always_inline for use in
>>> exported headers when the kernel's compiler.h is not available.
>>>
>>> However, since swab.h does not include stddef.h, if the header soup does
>>> not indirectly include it, the definition of __always_inline is missing,
>>> resulting in a compilation failure, which was observed compiling the
>>> perf tool using exported headers containing this commit:
>>>
>>> In file included from /usr/include/linux/byteorder/little_endian.h:12:0,
>>>                   from /usr/include/asm/byteorder.h:14,
>>>                   from tools/include/uapi/linux/perf_event.h:20,
>>>                   from perf.h:8,
>>>                   from builtin-bench.c:18:
>>> /usr/include/linux/swab.h:160:8: error: unknown type name 
>>> `__always_inline'
>>>   static __always_inline __u16 __swab16p(const __u16 *p)
>>>
>>> Fix this by replacing the inclusion of linux/compiler.h with
>>> linux/stddef.h to ensure that we pick up that definition if required,
>>> without relying on it's indirect inclusion. compiler.h is then included
>>> indirectly, via stddef.h.
>>>
>>> Fixes: 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to 
>>> userspace headers")
>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>> Reviewed-by: Petr Vaněk <arkamar@atlas.cz>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> I took this through my kernel build matrix and did not see any new
>> issues.
>>
>> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Great thanks! Since this is really useful for kernel-headers in 
> toolchains, it would be great to get this picked up. Arnd is this 
> something that would go via your tree?

Arnd, is this a patch you can merge? Thanks
-- 
Florian

