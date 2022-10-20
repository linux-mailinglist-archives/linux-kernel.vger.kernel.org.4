Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969CB60670A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJTRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJTRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:30:08 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89097F265
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:30:05 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id i16so72650uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/3I182d8OS7x64S+BRqz8kKKkjGoMeVc6W9/b71l3sw=;
        b=bhSI7PYNE96zmlTK54HcXVXMKa4MpE9a0d4dT9ZRpfu7bAo4nZ0dY8odSDsuC0n4qb
         A0NFcoTa7mQMvE/GIp2fGxlNaTyc1xC+mJpWpkZHWApIZlZJ3laViyURgnGhUU5MCAVQ
         R3aA1LAKm6EK2SR5YSOJpLv5cUBKXKHSdX9JwmOWekAiv9N1om5ege3SRcktdGKMdNHh
         yQxvjQIOk/8YjZxrQSoJxslmTSutFc7m1L57zkygsaoPAhvYWKzOjOUDMOzSKj1eBDTZ
         3L9UfmjsSMrcHEGhKK7d6tV0FEY6U+aSuevH+4xHLmsKF38KDErViXZa+bXzVBaq/OfH
         BBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3I182d8OS7x64S+BRqz8kKKkjGoMeVc6W9/b71l3sw=;
        b=AomUwV51dzlK4laRNnuyRQSFhRKg9b2dbRGdfdu1yp+Ks/6XcafbJlhOL8rTNvtrId
         Ymdl/UiPxehkAIY1I4gwnC55F2ESMsOk/OykJsmCtOX0hQVJ60xLm7BPUZNVH9Ai5/ld
         vJh0614gnwxCi1B9rh52iyiEQVvibHoMJMVn1n3HafKvFfaEHvVSs3DkSm7RTdvy77BY
         VZWW3H8k6MYnTWAp+tYTwreXxS3NAdPmq8MAJPLR7CX5Xl3QWxwvjtYBC5WR7KDq+FaI
         zAxS7/g+wBR2Yff1hS0XWyqG0ywBDPdimhwNjrqbgntscqx2/65MaioIo8aAslsQ//0f
         hNKw==
X-Gm-Message-State: ACrzQf32C5glrG4yCozgTm+s6hIZ1PdalrVcFXXhTfwbjtTe7zFT1KV0
        HwoWjNS4job1ycnf7uAaMCPCEANlfO5IssjKqn+ONQ==
X-Google-Smtp-Source: AMsMyM7ZtK1yZD880885vt34ACfB0CnhggaIUmZIRNZa/OsjpdJn+CuCLZLquEgbn0ZGbfEfVGjcWZp2RLOvSEDhDfQ=
X-Received: by 2002:ab0:6f94:0:b0:3d1:d6e5:5de6 with SMTP id
 f20-20020ab06f94000000b003d1d6e55de6mr7915486uav.51.1666287004714; Thu, 20
 Oct 2022 10:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com> <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 20 Oct 2022 11:29:28 -0600
Message-ID: <CAOUHufaEMt6oiaw7pj+eGLTK4y7CaiYO0BSf13vrE27JqQiAzw@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 8:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 19, 2022 at 10:40:40AM -0700, Linus Torvalds wrote:
>
> > Because as you say, the function is already called "read_atomic", and
> > it should damn well *act* that way then.
>
> So I've been sitting on these here patches (and never having time to
> repost them), which is how I noticed in the first place:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/mm.pae

This looks good to me. It'll help get rid of all those open-coded
barrier()s and fix a couple of missing barrier()s.
