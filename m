Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE65E63ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIVNn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIVNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:43:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E43FD74CE;
        Thu, 22 Sep 2022 06:43:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t190so9155544pgd.9;
        Thu, 22 Sep 2022 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=A1gPIGPkwtBGNAsou3191eDbQnV5HHWhy5YFxtQ8rL0=;
        b=C0FMWnH4ugLgjQCous99pqe1wPHUAHr4+tONBDxgiuVY2C7QiPNnPy8wa85+aDYArY
         Q9CcWmvTsaW+HVRDsMq8Sp+ZP6KRzG/AUCj5UKIlIj88xHEXOwewDKTrpgu/iG5TBEbI
         IFyLdTZYLN/N51HRjK48hWY9hwA2EN/Px+Fwd6k73RqomjklcD7i16LKcfUQqSIUgNVI
         wetzltHqurERKJWxlNQ+lWdXu6EQ/D4EvDXD/YNTo6gfKbdVBRSUzb0vpEvfWXzH6ehX
         zhXZ+7l7tigtoN3rJZQwXP2cG4mFuQD+yspPrg2NCWkcuLxBXNCuZQ2DFusEgLHkhqg+
         vsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A1gPIGPkwtBGNAsou3191eDbQnV5HHWhy5YFxtQ8rL0=;
        b=ZZpbB1L/D2gloJIpulWCNAzM6aVQiqoB+U42KnMBN+2fFzEce3fFXPGwIsk+FLUtA9
         ci2Sz1ZqveG56jSb+jjxLhyQgzIveA1ebzUtmd0sLU0ff8dB9fDsVOMiYGTTthZ5046F
         vw/9QkOVFYmzS8sy997EHhLw4g4kV3JomsroCebBLzt8JHLBLaarxzaUGFuG3033V1en
         31bafcOTCT9Qt+QFZ1xyWylyfuF2Q+wsX6anyMdTZZsdya3Sk59r02jpZ6ZuU+pByMJ+
         Z4WsYT3WUO+4mbnnr9qfr0S7/Mv8P2YEeZg43dxU+7bmV1bfl1xjErRM5po4fOzAd1R2
         wprg==
X-Gm-Message-State: ACrzQf2HIdvA8PNPhItypnAcmrsqLzCBlDZNjynMzWIhT/WWBZUQdGmM
        0bYxuHxQPD4aQqNcwn6b2fI=
X-Google-Smtp-Source: AMsMyM7AkwO3l8V5ynYvYZueIPngu0PrXh3//n/yokMVdyGKH8unhU1UjYRnlttNuuru0V/uT29V4Q==
X-Received: by 2002:a05:6a00:15d4:b0:544:170c:4f5a with SMTP id o20-20020a056a0015d400b00544170c4f5amr3614064pfu.75.1663854232588;
        Thu, 22 Sep 2022 06:43:52 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x125-20020a628683000000b0053e199aa99bsm4295515pfd.220.2022.09.22.06.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 06:43:52 -0700 (PDT)
Message-ID: <93343c05-f31e-cfbe-6650-8ea8d79e6d55@gmail.com>
Date:   Thu, 22 Sep 2022 22:43:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     David Hildenbrand <david@redhat.com>
Cc:     David.Laight@ACULAB.COM, akpm@linux-foundation.org,
        apw@canonical.com, bhe@redhat.com, christophe.leroy@csgroup.eu,
        corbet@lwn.net, dwaipayanray1@gmail.com, dyoung@redhat.com,
        jani.nikula@linux.intel.com, joe@perches.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mingo@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, torvalds@linux-foundation.org,
        vgoyal@redhat.com, Akira Yokosawa <akiyks@gmail.com>
References: <20220920122302.99195-2-david@redhat.com>
Subject: Re: [PATCH v1 1/3] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220920122302.99195-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Minor nits on section title adornments.
See inline comments below.

On Tue, 20 Sep 2022 14:23:00 +0200, David Hildenbrand wrote:
> Linus notes [1] that the introduction of new code that uses VM_BUG_ON()
> is just as bad as BUG_ON(), because it will crash the kernel on
> distributions that enable CONFIG_DEBUG_VM (like Fedora):
> 
>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>     no different, the only difference is "we can make the code smaller
>     because these are less important". [2]
> 
> This resulted in a more generic discussion about usage of BUG() and
> friends. While there might be corner cases that still deserve a BUG_ON(),
> most BUG_ON() cases should simply use WARN_ON_ONCE() and implement a
> recovery path if reasonable:
> 
>     The only possible case where BUG_ON can validly be used is "I have
>     some fundamental data corruption and cannot possibly return an
>     error". [2]
> 
> As a very good approximation is the general rule:
> 
>     "absolutely no new BUG_ON() calls _ever_" [2]
> 
> ... not even if something really shouldn't ever happen and is merely for
> documenting that an invariant always has to hold. However, there are sill
> exceptions where BUG_ON() may be used:
> 
>     If you have a "this is major internal corruption, there's no way we can
>     continue", then BUG_ON() is appropriate. [3]
> 
> There is only one good BUG_ON():
> 
>     Now, that said, there is one very valid sub-form of BUG_ON():
>     BUILD_BUG_ON() is absolutely 100% fine. [2]
> 
> While WARN will also crash the machine with panic_on_warn set, that's
> exactly to be expected:
> 
>     So we have two very different cases: the "virtual machine with good
>     logging where a dead machine is fine" - use 'panic_on_warn'. And
>     the actual real hardware with real drivers, running real loads by
>     users. [4]
> 
> The basic idea is that warnings will similarly get reported by users
> and be found during testing. However, in contrast to a BUG(), there is a
> way to actually influence the expected behavior (e.g., panic_on_warn)
> and to eventually keep the machine alive to extract some debug info.
> 
> Ingo notes that not all WARN_ON_ONCE cases need recovery. If we don't ever
> expect this code to trigger in any case, recovery code is not really
> helpful.
> 
>     I'd prefer to keep all these warnings 'simple' - i.e. no attempted
>     recovery & control flow, unless we ever expect these to trigger.
>     [5]
> 
> There have been different rules floating around that were never properly
> documented. Let's try to clarify.
> 
> [1] https://lkml.kernel.org/r/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com
> [2] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com
> [2] https://lkml.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com
> [4] https://lore.kernel.org/r/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com
> [5] https://lore.kernel.org/r/YwIW+mVeZoTOxn%2F4@gmail.com
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/process/coding-style.rst | 61 ++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 03eb53fd029a..e05899cbfd49 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1186,6 +1186,67 @@ expression used.  For instance:
>  	#endif /* CONFIG_SOMETHING */
>  
>  
> +22) Do not crash the kernel
> +---------------------------
> +
> +In general, it is not the kernel developer's decision to crash the kernel.
> +
> +Avoid panic()
> +=============
This looks to me like a subsection-level title.  The adornment symbol
needs to be:

   *************

> +
> +panic() should be used with care and primarily only during system boot.
> +panic() is, for example, acceptable when running out of memory during boot and
> +not being able to continue.
> +
> +Use WARN() rather than BUG()
> +============================
Ditto.

> +
> +Do not add new code that uses any of the BUG() variants, such as BUG(),
> +BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
> +WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not
> +required if there is no reasonable way to at least partially recover.
> +
> +"I'm too lazy to do error handling" is not an excuse for using BUG(). Major
> +internal corruptions with no way of continuing may still use BUG(), but need
> +good justification.
> +
> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> +**************************************************
These wrong adornment symbol confuse ReST parser of Sphinx and results in
the build error from "make htmldocs" at this title (long message folded):

    Sphinx parallel build error:

    docutils.utils.SystemMessage: /xxx/Documentation/process/coding-style.rst:1213:
     (SEVERE/4) Title level inconsistent:



Please fix in v2.

        Thanks, Akira

> +
> +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it
> +is common for a given warning condition, if it occurs at all, to occur
> +multiple times. This can fill up and wrap the kernel log, and can even slow
> +the system enough that the excessive logging turns into its own, additional
> +problem.
> +
[...]

