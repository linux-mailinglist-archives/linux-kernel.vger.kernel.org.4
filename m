Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF55F6F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiJFUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiJFUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:33:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E34C1D9A;
        Thu,  6 Oct 2022 13:33:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o22so1396492qkl.8;
        Thu, 06 Oct 2022 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNBmgmbcEhRVb5/d/O8+b1/IfZcuQKrWWyPpGBHLay8=;
        b=MHw3HdNkCpG1mwSCYrQqnL3L0IrPDqqPAD3ilpwGP90TMXi8pu0W5GlmDVedbtpfcK
         1w/GL1Y3H0SkuA5usd7Xg9wGO/0L+otmqFDHSUU3qLcE7SAaNZSBS2aSpBCIdToIkrU1
         wsJYWhugTQqfCjT+f4uwj0ZeetXJg90ORA+jnI03lh2xZA1UfMa+L5PycWsmNttuFRcc
         AN8FUU5HBr+uWxxbyoW+MevYuOPjs8FDFj0QyzQJVL7mi/tY5nJPHPiI4PS2y+lK+7sC
         zRUjczx4xMFaeTJxt37R4yeEkUUdFkybK+kaseljntR90ohTDbsNdQaH9jw5Ouv/w17y
         b0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNBmgmbcEhRVb5/d/O8+b1/IfZcuQKrWWyPpGBHLay8=;
        b=hP5HXP2zzc3KTP+Bj8CzfawCua3uf9uGXQRB7cuKfvvIEZx4hAYBgXcNqA2vUMRHj8
         VCqBkBSIbwMrPvWBupYUmI8y+iZEqP/jWsce9cjqjRur2POOJxqPm2CE1sHd8IrKyJCF
         su0ElqLJD0wLSCB6J79OEmPRr4Ka6y0VQv5mqsfbf03q+Ii3Dl6NbG154Kh+XzM93JmY
         2VlYVZB6rUu0svBxKlmS1FaDIGtkeEUyD1wfrsVTJOx+deKGygzW2uDvsbiJL2/+/5ys
         O6gX2N9aBa4FJ0BQDOf4pYwZWM21poFE4vsGYXtIUvqKZxcYP7DxwRod72tArXCYk1nZ
         fC5g==
X-Gm-Message-State: ACrzQf1dgGGV+7g731UmeeR2Xr5aoaiYnkaDTM7IKc2+IWyyEGqm6VaM
        ISF69IEaW/EkanhpMVsNlTM=
X-Google-Smtp-Source: AMsMyM6F4qYJwxq1tyY5ek8LBaSHy8ukK0aWx027FmAkx7naPxDDIEYwmkM+GNM1x9oufwbvzWcIAQ==
X-Received: by 2002:ae9:e647:0:b0:6e6:62aa:b8d with SMTP id x7-20020ae9e647000000b006e662aa0b8dmr1536252qkl.669.1665088434395;
        Thu, 06 Oct 2022 13:33:54 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id j24-20020ac84418000000b0034456277e3asm411191qtn.89.2022.10.06.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 13:33:53 -0700 (PDT)
Message-ID: <ed9b8268-0128-0486-04a3-54f343afd38b@gmail.com>
Date:   Thu, 6 Oct 2022 13:33:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] include/uapi/linux/swab: Fix potentially missing
 __always_inline
Content-Language: en-US
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YzTMUpd6HbHmZu8f@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 9/28/2022 3:36 PM, Nathan Chancellor wrote:
> Hi Florian,
> 
> On Tue, Sep 27, 2022 at 02:52:56PM -0700, Florian Fainelli wrote:
>> From: Matt Redfearn <matt.redfearn@mips.com>
>>
>> Commit bc27fb68aaad ("include/uapi/linux/byteorder, swab: force inlining
>> of some byteswap operations") added __always_inline to swab functions
>> and commit 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to
>> userspace headers") added a definition of __always_inline for use in
>> exported headers when the kernel's compiler.h is not available.
>>
>> However, since swab.h does not include stddef.h, if the header soup does
>> not indirectly include it, the definition of __always_inline is missing,
>> resulting in a compilation failure, which was observed compiling the
>> perf tool using exported headers containing this commit:
>>
>> In file included from /usr/include/linux/byteorder/little_endian.h:12:0,
>>                   from /usr/include/asm/byteorder.h:14,
>>                   from tools/include/uapi/linux/perf_event.h:20,
>>                   from perf.h:8,
>>                   from builtin-bench.c:18:
>> /usr/include/linux/swab.h:160:8: error: unknown type name `__always_inline'
>>   static __always_inline __u16 __swab16p(const __u16 *p)
>>
>> Fix this by replacing the inclusion of linux/compiler.h with
>> linux/stddef.h to ensure that we pick up that definition if required,
>> without relying on it's indirect inclusion. compiler.h is then included
>> indirectly, via stddef.h.
>>
>> Fixes: 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to userspace headers")
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> Reviewed-by: Petr Vaněk <arkamar@atlas.cz>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I took this through my kernel build matrix and did not see any new
> issues.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Great thanks! Since this is really useful for kernel-headers in 
toolchains, it would be great to get this picked up. Arnd is this 
something that would go via your tree?
-- 
Florian
