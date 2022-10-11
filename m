Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B975FAB00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJKDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:10:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FCD5FA3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:09:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l5so14599124oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6DsjwogNmSPjPt8D1cDMMNd+hmG1wgnnRURxWJjtnQ=;
        b=ne8XpRIIag8YcPUwg6VURtpuU0P7g+qGFyWHmGjwv8zf1l6xNIz3xf6FFLCkCN93HM
         vBuCiYK2N7wF3oGhrcgH8DMSOHHOuvYJSwuS3OoxzwApCjUUbdMPL4vp4AhUzTA0QKDL
         sO0LME3IVipX1yamNB9kVFO3GchqUMawBsPSWB0oNm9NphF1inXD3TJKXlRPGy3iyU00
         4RLaxaEn2ucrM/mjSiCcOSbud6WRgU5u6MuGU23HZfftSSB0HZPUDtP4SfN4qxegLaFQ
         U2AbFlyj1e8XKqeeV2Zl/G0TZLbigcBzsUm1k7waa9hjH+UyGVmypEk65uIM7DfY9kF2
         c1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6DsjwogNmSPjPt8D1cDMMNd+hmG1wgnnRURxWJjtnQ=;
        b=0OpJIH46zGGeKb0NPkRvOFp/NLIJQsHNxyT7Mo2cqWNdYSCYXoKSm3wvuMzksLAqgC
         TxL+nhV0At5QrI3bL3bFxqMFP22HJenjaICcuoG7iiK3o3Q2RJB86DV0JKgLk1DmQ+xW
         fZom1CAYlXRQLByL4gVbRpgzp2CmbRtwQxVmWyiErx3YdMwXFQpxyDPqQLal8IP4cAEi
         0893JJZC0ErpOSudh9WWVabdQwb4nRYBds+bWM+w6UUFkpIdV+4eiRRwTCz6lDVjtuvB
         9RWNfq5H7zxbIMK0YXKE5l23hrHGJzWQJwDsZSG868LtYYkaTR0rsed9ort0kbl0xw23
         1ifQ==
X-Gm-Message-State: ACrzQf25x+8bNj1y/2FZ+N/OMYkEnn1rfC7lMi8XwlgrN1uvho5qDa2l
        ONlWzWMLkAZml5C6o/8Bdyk=
X-Google-Smtp-Source: AMsMyM6xAklmRxGMWg1O3VFTCPdvecAiAVKEunuhr2zor4QHQ4R91p5TQKls16x6f4c09M2Fjcac3A==
X-Received: by 2002:aca:1a0a:0:b0:354:b28b:4079 with SMTP id a10-20020aca1a0a000000b00354b28b4079mr2071655oia.101.1665457795601;
        Mon, 10 Oct 2022 20:09:55 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r15-20020a056830120f00b00661ac688285sm441180otp.0.2022.10.10.20.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 20:09:55 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:07:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [GIT PULL] bitmap changes for v6.0-rc1
Message-ID: <Y0TeAGLngwVbgtuK@yury-laptop>
References: <YzpC+uJlYq1nbcIw@yury-laptop>
 <CAHk-=wgO5YjyPRz9dfP8AyZ8kKZPSQ78xyEbi8WmuHe09R36Hg@mail.gmail.com>
 <CAHk-=whf2zgBzGMse-y-yD_oTfofRHQQV-gy3O-iQBE7oOiSGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf2zgBzGMse-y-yD_oTfofRHQQV-gy3O-iQBE7oOiSGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 02:18:46PM -0700, Linus Torvalds wrote:
> On Mon, Oct 10, 2022 at 2:12 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Oct 2, 2022 at 7:03 PM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > >       lib/cpumask: add FORCE_NR_CPUS config option
> >
> > Side note: I think we should make this option depend on EXPERT.

OK. I'll send a patch.
 
> Oh, and if a constant 'nr_cpu_ids' is such an important thing from a
> code generation standpoint, maybe we'd be better off saying 'for small
> NR_CPUS, just make nr_cpu_ids be that small constant".

From what I see, 'FORCE' effects on size 3x more for bigger NR_CPU_IDS.
For x86_64 allmodconfig build (w/o MAXSMP) on top of today's master:

NR_CPUS            Diff    	          Absolute values
                        	  FORCE=n         FORCE=y
8192            -222429 	373299266       373076837
256             -221799 	363679392       363457593
4                -88922 	363387049       363298127

> Rather than confusing people with a question that is a bit strange.
> Afaik, all our kernel code has to work with "nr_cpu_id's doesn't match
> the number of CPU's we actually have", because of cpu hotplug (and
> suspend/resume) issues anyway.

nr_cpu_ids is a number of possible cpus. Once set, it's never changed.
What system has now is online cpus. FORCE_NR_CPU_IDS doesn't break
hotplug because it only controls when we set nr_cpu_ids - at boot time
or compile time.

> So I _think_ all the nr_cpu_id's games are mainly because we don't
> want to allocate huge arrays when  you can't actually have that many
> CPU's - but for a small NR_CPUS situation that just isn't an issue
> anyway.
> 
> Yes? No?

You're talking about .data section. FORCE_NR_CPUS is about .text and
code generation.

Compile-time allocations for cpumasks, per-cpu variables etc. shouldn't
change when we build kernel with FORCE_NR_CPUS on and off against the
same NR_CPUS, right?

I originally expected that 'FORCE' will improve code generation for
NR_CPUS < BITS_PER_LONG because it allows small_const_nbits()
optimization in cpumasks. But with big NR_CPUS it works even better.
I don't know exactly why. nr_cpu_ids is used widely beyond cpumasks,
after all.

Thanks,
Yury
