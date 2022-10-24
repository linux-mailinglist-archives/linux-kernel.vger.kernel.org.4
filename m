Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B494060B8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJXUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiJXT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:59:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4EE2920F5;
        Mon, 24 Oct 2022 11:21:48 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g11so6128941qts.1;
        Mon, 24 Oct 2022 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e5bcd0fb6c5RJaPgWruO5Vk2zsN7icPcp93djWHt/s=;
        b=F5nJ/Bc+bRFj9LwhKX1gk5ThOebVMr12gFf+CjNAVy/5LlZCtkzLRc/CdHxVnwbKsy
         13fiSRWGBeYwgC2Nu0RIytUMxha/lHYG6umKqf8un9okKzbCmMD0mcXnSNhQM0m4PYCh
         YFE0yu1r55s58fSkyiZBJ4MsWFtSgG+lCoXUZ+1oo+IRC/9Q54xk0z5h+9ZfKxlKmgWM
         2BCZImF8NS2fL0VuEttvE5oQ2Xf8ChwtSypIcMcoA/lOMvL/ZjGVLC/47akKKY/Utz+h
         iPJcP06mJnUhTrlbLwnBteO0cKiULJiZm8isLlWqPBWS3nun03LbkFVDpx5kLcbMHhkc
         BhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e5bcd0fb6c5RJaPgWruO5Vk2zsN7icPcp93djWHt/s=;
        b=xKoz47cvjavX6ZzenAfwfaX0TUOHo7ekVriYQDGpvTecGTsN6+IUbzmJ0mMkBmtlmM
         iBKc2rYGpBowKCQx3WapXxJSAc4rYH+Y/w9V3KkKa+OQMtGaiJ3yWw14pOVaSqOaBsB2
         iV/H0NNPLYPa/2QKMKvpGDgdjGaqBDXmgTYsmHdqW/fqf6kzwBQrdN3ttDAag+Nt22dX
         eS5jfkrzQ3MVvV3aAj1bzk+tAMuf1dJ9R44Hf5l6g0xoSTjvn47pVJkgoplho2LshT7I
         AFY6QsYZNUZUdLH6/feW+HYxuJoSt2uwajo835BozbrJt3O6uoQYF3IFGam+/wOv1cES
         JLeQ==
X-Gm-Message-State: ACrzQf02btBgolEgi3NIDPMbvLuE9Clb8c+5z+qR0K8d6ThoY5lBtxxe
        rEKLsAivHW3xPRDe9gw8l2o=
X-Google-Smtp-Source: AMsMyM7e65kEVnIeUYCrfmvWNo9dZ+ObUX4E4SNnQ+nehPwZRGWFzRSiGcGOC1G+tPc5sgfC/s5SwQ==
X-Received: by 2002:ac8:5783:0:b0:39c:f52f:ab41 with SMTP id v3-20020ac85783000000b0039cf52fab41mr28510433qta.343.1666635658979;
        Mon, 24 Oct 2022 11:20:58 -0700 (PDT)
Received: from [192.168.0.24] (bras-base-toroon3514w-grc-28-142-114-225-85.dsl.bell.ca. [142.114.225.85])
        by smtp.gmail.com with ESMTPSA id gb12-20020a05622a598c00b0039a55f78792sm284511qtb.89.2022.10.24.11.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:20:58 -0700 (PDT)
Message-ID: <11616e14-f8a6-e0fe-3e11-9b884fe4ce33@gmail.com>
Date:   Mon, 24 Oct 2022 15:20:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
 <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
 <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
 <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
From:   Gareth Poole <girpoole@gmail.com>
In-Reply-To: <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
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

As someone who still regularly uses hardware from this era, and often 
runs Linux on it, this would definitely be a blow to which machines I 
can actively use. Linux support is a big part of how I use these 
machines, since DOS and Windows 95 really can’t keep up with modern 
networking standards.

I would be very disappointed, and impacted, if Linux dropped 486 support.

On 10/20/22 23:10, Linus Torvalds wrote:
> On Thu, Oct 20, 2022 at 11:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Thu, Oct 20, 2022 at 10:35:28AM -0700, Linus Torvalds wrote:
>>> That said, I reacted to that cmpxchg loop:
>>>
>>>          } while (cmpxchg64(&pmdp->pmd, old.pmd, 0ULL) != old.pmd);
>>>
>>> is this series just so old (but rebased) that it doesn't use "try_cmpxchg64()"?
>> Yep -- it's *that* old :-/ You're not in fact the first to point that
>> out.
>>
>> I'll make time tomorrow to fix it up and respin and send out. This is as
>> good a time as any to get rid of carrying these patches myself.
> Hmm. Thinking some more about it, even if you do it as a
> try_cmpxchg64() loop, it ends up being duplicated twice.
>
> Maybe we should just bite the bullet, and say that we only support
> x86-32 with 'cmpxchg8b' (ie Pentium and later).
>
> Get rid of all the "emulate 64-bit atomics with cli/sti, knowing that
> nobody has SMP on those CPU's anyway", and implement a generic x86-32
> xchg() setup using that try_cmpxchg64 loop.
>
> I think most (all?) distros already enable X86_PAE anyway, which makes
> that X86_CMPXCHG64 be part of the base requirement.
>
> Not that I'm convinced most distros even do 32-bit development anyway
> these days.
>
> (Of course, if we require X86_CMPXCHG64, we'll also hit some of the
> odd clone CPU's that actually *do* support the instruction, but do not
> report it in cpuid due to an odd old Windows NT bug. IOW, things like
> the Cyrix and Transmeta CPU's did support the instruction, but had the
> CX8 bit clear because otherwise NT wouldn't boot. We may or may not
> get those cases right, but I doubt anybody really has any of those old
> CPUs).
>
> We got rid of i386 support back in 2012. Maybe it's time to get rid of
> i486 support in 2022?
>
> That way we could finally get rid of CONFIG_MATH_EMULATION too.
>
>                 Linus
>
