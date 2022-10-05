Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9405F51C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJEJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJEJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:32:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F353C20F65;
        Wed,  5 Oct 2022 02:32:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so1098216pjs.4;
        Wed, 05 Oct 2022 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFZOsSDMe9wHpf/WB3nFd5N02lf7I387XsFoFJlnTns=;
        b=klGF7pv1XRZVgFwOmBv+ahBiXI1LTGHclx5jplkLeTjSxOHbqEdINsHuhhklLX2rCB
         S8ab0ifTW/sGYC34/+c2o6fDUb2hniG+I9+u7YgIvtBp9LEYwt3MbjHABc8aXiPpxtd5
         yzN2sURtlRuP8/UJ0KtmJ6VygaJsErCjM2L4IYyWI+yONRwhRu9DUbfw7qE2t5MPAl0Q
         eNzfmFuMRwH08yqSNBBXwyzAarfUJALi2lDFwMqq4dn0MJs1XiHkPVfz34KZHr56dWlV
         zrzM/A64AUqFMociLg6uHDlFInsduh+zhzBohJKBd85Ti9Qr3hfOOM8VS9PAtVXHof5J
         C4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFZOsSDMe9wHpf/WB3nFd5N02lf7I387XsFoFJlnTns=;
        b=glmi+zoZWi01AnH9rjVqFmYCihWi8xtTMl7QPvhdLeR6GMGlZ8Ur4LFEhoGOydsppL
         Fm+RdpAvwfXWA8z2LzZgF8FDpMMVykhm5iYqEA57O3Ox1wUkpJtlMdvhqvrIEX75md6T
         EJn+U37/iMcri3NlecMyUrhdNhtsN+dEpd7VkV1TZ8zllwvOGkyCXkU/gZy/bfdT1QcS
         Wj1Ir3vM+HiYpF6eAq52MusF9T0KXJB2pGB0wsY3R79hMWO/RVDq98hA2S/wZC/Bm1io
         czdYeQDJ5OYjymYb6f0VoPPNRSO6d7yik9elj4ZaKl1PPzmd+T5AC8W9/EQhf/R7TAzV
         y1HA==
X-Gm-Message-State: ACrzQf0LprNzo1oKXSUmwT+jgPmtm8gLsYPmi7VyBoDrx4Q16HLp16yR
        QtaMsqf/ugFXDoMU4m/DN40j0OkL300xBw==
X-Google-Smtp-Source: AMsMyM7M6ocj2ZoxY+cro+bRw2jL0ELYSY53RCK6jy0sBZZrPet3k3NLv00w4N3LcVc1hvbBI3igMA==
X-Received: by 2002:a17:90a:d48b:b0:20a:97fb:3eb with SMTP id s11-20020a17090ad48b00b0020a97fb03ebmr4041147pju.189.1664962348409;
        Wed, 05 Oct 2022 02:32:28 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-92.three.co.id. [180.214.232.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a626304000000b00562019b961asm1206936pfb.188.2022.10.05.02.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 02:32:27 -0700 (PDT)
Message-ID: <89aed08f-1e0b-258c-516d-97a30fd02840@gmail.com>
Date:   Wed, 5 Oct 2022 16:32:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] Documentation/mm/page_owner.rst: delete frequently
 changing experimental data
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, rppt@kernel.org
Cc:     akiyks@gmail.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, yejiajian2018@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn
References: <YwhJDJQkymdN0E2N@kernel.org>
 <20221005091052.6631-1-caoyixuan2019@email.szu.edu.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221005091052.6631-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 16:10, Yixuan Cao wrote:
> Thanks for Jonathan Corbet, Bagas Sanjaya and Mike Rapoport's
> constructive suggestions. Notice that the size(1) output is
> changing frequently, I remove the two tables and describe them
> in a general way. Doing so avoids having to repeatedly maintain
> the two tables due to kernel changes.
> 

For the patch description, better write:

"The kernel size changes due to many factors, such as compiler
 version, configuration, and the build environment. This makes
 size comparison figures irrelevant to reader's setup.

 Remove these figures and describe the effects of page owner
 to the kernel size in general instead."

> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  Documentation/mm/page_owner.rst | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
> index f18fd8907049..1b661ad85647 100644
> --- a/Documentation/mm/page_owner.rst
> +++ b/Documentation/mm/page_owner.rst
> @@ -38,22 +38,10 @@ not affect to allocation performance, especially if the static keys jump
>  label patching functionality is available. Following is the kernel's code
>  size change due to this facility.
>  
> -- Without page owner::
> -
> -   text    data     bss     dec     hex filename
> -   48392   2333     644   51369    c8a9 mm/page_alloc.o
> -
> -- With page owner::
> -
> -   text    data     bss     dec     hex filename
> -   48800   2445     644   51889    cab1 mm/page_alloc.o
> -   6662     108      29    6799    1a8f mm/page_owner.o
> -   1025       8       8    1041     411 mm/page_ext.o
> -
> -Although, roughly, 8 KB code is added in total, page_alloc.o increase by
> -520 bytes and less than half of it is in hotpath. Building the kernel with
> -page owner and turning it on if needed would be great option to debug
> -kernel memory problem.
> +Although, enabling page owner increases kernel size by several kilobytes,
> +most of this code is outside page allocator and its hot path. Building 
> +the kernel with page owner and turning it on if needed would be great
> +option to debug kernel memory problem.
>  

s/Although,/Although/

Thanks for reviewing.

-- 
An old man doll... just what I always wanted! - Clara
