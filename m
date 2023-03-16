Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D144F6BD266
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCPOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCPOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:30:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26356C889A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:30:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x1so1862696qtr.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678977009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tJ4I9ZiOnVv27V/2pSQJ0BPsYXHXaREO6k8Y5ACwnI=;
        b=C+GP8LpvlQRSMcbmjE1Y6jbjYNh1r7qtieyvqkJoRE2fZrv4fxBngweL8yB8gOs1Ci
         zRvDHr/tRnfo2MmcZ9KsA4EWcAuIA6KNIJ46jeumdomZhqO+JPBYDuGsJImNbLmHQ+YO
         R1J82Py99kVbPp7Q3s544BRgJzU+pcTLtEbbSBeY3LHM76IwbWGd/o4Bj5/tYfhjs9XJ
         xR/jnaagQFIlM+2tN7TbpuWfhCVv8YSiTG2WdWNtqFpYxyEYK25387s0OgpG3b1ygloP
         wcBWHm1rKSTh1Blq0AzNp7H4oW5r19VmC3AQARxVycJOuFkNnXXc1ITEaUIexiqy2Ymc
         VVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tJ4I9ZiOnVv27V/2pSQJ0BPsYXHXaREO6k8Y5ACwnI=;
        b=ESBaTVmwjlBM5q+vU2jLckgUlAU8vlWjTddQo70DuOf299ooH5vfrniVsh6i4dC4rU
         JE++Psh4tLIzok0mU0mdz15Y3f5TaSk6p5+KpTkWYFlBKuO1SV8IyeFclywY9Mn+VDEm
         FMYxH+GmDYNxldOlvMpoPmSEmVgB+T9NA4V40rCcn5R85f2HYilZDpInpPfrVzy3cniC
         lZMYR2HLDeOKFBX34yYFHSUv9bwKMP/wfiMdf2sqIYWPtYO/M/Rku2vsIIvQ9/Q32Qoe
         Yi70z9AtOrNtHedyJIfuoOJBVGnBf9OcFf7kiLptexD+ofMHqD72AdvGqrZma0bo/gGX
         pjDw==
X-Gm-Message-State: AO0yUKU7HeSWINeFBcDe7OJyd/gpKnKC8F0TPhpjcAPWCZ0HSSSV94dp
        iSoDpbwRl63mwYdeNRp156hmDA==
X-Google-Smtp-Source: AK7set8SZHeDkSTpgT1aKVMpmUum/pCP5ZIxkPGNliu26fh7kkQe3PBQ/sCZGqX8TPWJpRG9Bd+6IA==
X-Received: by 2002:ac8:4e92:0:b0:3bf:c423:c384 with SMTP id 18-20020ac84e92000000b003bfc423c384mr6287097qtp.15.1678977008742;
        Thu, 16 Mar 2023 07:30:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id l19-20020a37f913000000b0073b3316bbd0sm6023764qkj.29.2023.03.16.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:30:08 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:30:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iamjoonsoo.kim@lge.com, willy@infradead.org
Subject: Re: =?iso-8859-1?Q?=A0=5BPATCH_linux-next?=
 =?iso-8859-1?Q?=5D_mm=3A_workingset=3A_simplify_the=A0calculatio?=
 =?iso-8859-1?Q?n?= of workingset size
Message-ID: <20230316143007.GC116016@cmpxchg.org>
References: <202303161723055514455@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303161723055514455@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:23:05PM +0800, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> After we implemented workingset detection for anonymous LRU[1],
> the calculation of workingset size is a little complex. Actually there is
> no need to call mem_cgroup_get_nr_swap_pages() if refault page is
> anonymous page, since we are doing swapping then should always
> give pressure to NR_ACTIVE_ANON.

This is false.

(mem_cgroup_)get_nr_swap_pages() returns the *free swap slots*. There
might be swap, but if it's full, reclaim stops scanning anonymous
pages altogether. That means that refaults of either type can no
longer displace existing anonymous pages, only cache.

So yes, all refaults need to check free swap to determine how to act
on the reuse frequency.

> @@ -466,22 +466,23 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	/*
>  	 * Compare the distance to the existing workingset size. We
>  	 * don't activate pages that couldn't stay resident even if
> -	 * all the memory was available to the workingset. Whether
> -	 * workingset competition needs to consider anon or not depends
> -	 * on having swap.
> +	 * all the memory was available to the workingset. For page
> +	 * cache whether workingset competition needs to consider
> +	 * anon or not depends on having swap.

No, it applies to all refaults, not just cache.

What could help is changing the comment to "having free swap space".
