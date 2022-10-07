Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C624F5F755B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJGIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGIfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:35:08 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF932FC0A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:35:07 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id e22so1463573uar.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QB2YstNNdejbNNlPhcJ29xpu8+gZThb0NwnVVXxC6U=;
        b=YPZ1qIrBHo9fjBezphasUP69bwDiWN6ZZzw1vN3PyKqbzbqOPuMSEbe/UzCYj52WSs
         ivZB00IK8H6A7WFzZkgZzRFaUkAivxeTzNsP4ncpZsXVQ35GXZUBzR6MjxbP1NWbdwwk
         N6mtQ5R7gC2PUEX+88FhjXTpwDDscmxUdp0IDFo5zKWf6IDBbTsN6UT0TsfC0noX43r5
         MoZRFyX6D4zjdeKOlt5U0pcnuVTGDR4If0dgodFPC/rM90v3YFWKvMoZVIL6VjiaEj3v
         HnW7zk1RrRmTDeQTv3KZRdn3FbNtCN/pNiPVzXuF283SSdU24nd01N40VFqXf2E5vZrQ
         C/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QB2YstNNdejbNNlPhcJ29xpu8+gZThb0NwnVVXxC6U=;
        b=KVkQ62AWRXA585cJFDXMLRqo7ysPIK1VAZVXGosvYMGUkHIJrnBsyJSGvz5A2r7dU0
         PIRPWWc4HcvqMEDkcMozsJXscPFtMCfxtIr4mB7h3F8pOEiV5Oe+5Aq9nhPJMVOUHt/F
         XxOSCboeB+fvyROT6pgF9864OzyXc9jsKqu+ZP8QI7xqkIqNILgaqUCruWcu2vEH3UUU
         bdkpLI6OEomnCtYnXGIt7KsAfMrGkMYB4YxUmU043A9uUf4gC/H4gW/UEdira37WbWxz
         Ibpu6+6y2kq0yKxDScuNHcx3bRjxvSrPqgyCBtCh+KF1A7GW8wdXidTuB47NEvCcO7Fr
         m/KA==
X-Gm-Message-State: ACrzQf3cOcvXc1XPbU67EL6knbWLL8EGkGx2Ms3MR4jVBNZmxLouYyeu
        udH2bsTupkAfvE3mcJT0S2eXfDqZ7SuhHmD57DepMQ==
X-Google-Smtp-Source: AMsMyM6lpQHSMjRsZY7R+ighTikm5q4FVbFhvg5dv0S9qUtRz7KWoOcqtkEy7w2qmRiDQkiCzKhKjS+EhtnLTTTnxZA=
X-Received: by 2002:ab0:6f94:0:b0:3d1:d6e5:5de6 with SMTP id
 f20-20020ab06f94000000b003d1d6e55de6mr2184326uav.51.1665131707002; Fri, 07
 Oct 2022 01:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <202210052318.5ad10912-oliver.sang@intel.com> <CAOUHufaUFd9umLvR2P11m7o=RsWWAOsKoCPOk=YZ0TggTpiB4g@mail.gmail.com>
In-Reply-To: <CAOUHufaUFd9umLvR2P11m7o=RsWWAOsKoCPOk=YZ0TggTpiB4g@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Oct 2022 02:34:30 -0600
Message-ID: <CAOUHufZsXJ4ixqpQEEuifFT_h5Ht6R685QU-At8M-r7ic2tEzQ@mail.gmail.com>
Subject: Re: [mm] 763ecb0350: kernel_BUG_at_mm/mmap.c
To:     "Liam R. Howlett" <liam.howlett@oracle.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 6:47 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 9:30 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-11):
> >
> > commit: 763ecb035029f500d7e6dc99acd1ad299b7726a1 ("mm: remove the vma linked list")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: trinity
> > version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
> > with following parameters:
> >
> >         runtime: 300s
> >         group: group-03
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Link: https://lore.kernel.org/r/202210052318.5ad10912-oliver.sang@intel.com
> >
> >
> > [   63.390267][ T5018] ------------[ cut here ]------------
> > [   63.391875][ T5018] kernel BUG at mm/mmap.c:3167!
> > [   63.393264][ T5018] invalid opcode: 0000 [#1] SMP PTI
> > [   63.394501][ T5018] CPU: 1 PID: 5018 Comm: trinity-c1 Not tainted 6.0.0-rc3-00284-g763ecb035029 #1
> > [   63.396050][ T5018] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > [ 63.397726][ T5018] RIP: 0010:exit_mmap (mm/mmap.c:3167 (discriminator 1))
>
> Thanks, Oliver.
>
> The attached dmesg doesn't say much. My guess is the oom reaper jumped
> in between
>
>         mmap_read_unlock(mm);
>
>         /*
>          * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
>          * because the memory has been already freed.
>          */
>         set_bit(MMF_OOM_SKIP, &mm->flags);
>         mmap_write_lock(mm);
>
> It seems to me we need to hold the lock for write all the time. But
> there is probably a reason we didn't do it in the first place.

Apparently this is safe: I checked all places that change VMAs and
none of them can race with the above (oom reaper was a red herring).
