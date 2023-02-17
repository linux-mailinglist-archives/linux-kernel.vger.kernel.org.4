Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39CD69B03C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBQQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBQQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:10:49 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF246A051
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:10:48 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-535a11239faso31681787b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PFNFpEQr/wV6J8ecu6kCjandJU8AZ1ItdrwAe6ofQEU=;
        b=BIBUTCtLGNgOeX/rJadBXrsOuJ2/WIKkC9LptUd9hTOMhrKGH223slhsaq0Tguv3Cz
         Dd/6NKwGbYiRd+Lsr7BWUqZMAVGTQndQiWRAjnZF/CVl/ouXTLLw4PAn6FQRq6iBv0tU
         Kq59V4SeBS77l3W8l+gCWEg6Thq32NdPyKYnxl/rggkX+eYdPw8uq/aICJQNdY1boKhQ
         tzoZZDlP6n6A1LERdgtiGjkEDNOJKXNN5pckjdMSabAlEFdNEb8P3sHqoWVlKwIvn9rI
         N7YHPIENcTPC+/lTUav4KcsUPXwypDmjOCi0dSgGJm4xjhpMDAqGbNQ64lDOBZ4AcKXm
         HHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFNFpEQr/wV6J8ecu6kCjandJU8AZ1ItdrwAe6ofQEU=;
        b=iMMHXGD2SkWONoS82MYgCRm2cnBuwtAO8GQDQ46KJrBjsw0pB0lv1XfQqByoZTGAs4
         Ha6rJPUxza1t3VPeKwPMJ2ADCU4BaDj/ozLPU75SZrZ7xtjzH7cgw0JSnhiwdTytRPg6
         uNRorsx4cI/PMD5sSS2JhlOXI+zv9r9tUZ0sgDK390B6Ep5tOB1CtX+/gSTeZ0yMcWcU
         0gXiG3DnplloKfDw1k4l0H3qT7kBglEzck0xG2RQzVVmBTFBib3Hz1/gmVoQ/RLyZzKb
         ht38eyaIJgGeBgt/UVdLKfDrT2BchkZg4nxpej4SZdgPgpQcCW9Uk64KZdXchFcPf3HZ
         Rm/A==
X-Gm-Message-State: AO0yUKWtXJpA5J35eqkunfOiTY2FpVloOrKZUK3KgUWBAoRMc6zvJTxI
        g6MDo9wDkbUMyRPUI5bjzihCuM/UulgDNBKa0sf1zA==
X-Google-Smtp-Source: AK7set/f5GlkwKOfyDUfvguLjocwuuJ59RkVrqxPVxVbH90lYV8iKuA6tb3DgP9li1jq/Fv1wdtVUPHDZTSi27WK5tw=
X-Received: by 2002:a0d:d54b:0:b0:534:c230:ff14 with SMTP id
 x72-20020a0dd54b000000b00534c230ff14mr316390ywd.7.1676650247072; Fri, 17 Feb
 2023 08:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org> <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
 <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com> <Y++l181MMw+T70yt@casper.infradead.org>
In-Reply-To: <Y++l181MMw+T70yt@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Feb 2023 08:10:35 -0800
Message-ID: <CAJuCfpG_ZWJs3mZkL0z7m-bBe1SmeoTZydfFocZaRbHob_89Hg@mail.gmail.com>
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Fri, Feb 17, 2023 at 8:05 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 16, 2023 at 06:14:59PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > > > When vma->anon_vma is not set, page fault handler will set it by either
> > > > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > > > to be stable but also the tree structure and other VMAs inside that tree.
> > > > > Therefore locking just the faulting VMA is not enough for this search.
> > > > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > > > situation happens only on the first page fault and should not affect
> > > > > overall performance.
> > > >
> > > > I think I asked this before, but don't remember getting an aswer.
> > > > Why do we defer setting anon_vma to the first fault?  Why don't we
> > > > set it up at mmap time?
> > >
> > > Yeah, I remember that conversation Matthew and I could not find the
> > > definitive answer at the time. I'll look into that again or maybe
> > > someone can answer it here.
> >
> > After looking into it again I'm still under the impression that
> > vma->anon_vma is populated lazily (during the first page fault rather
> > than at mmap time) to avoid doing extra work for areas which are never
> > faulted. Though I might be missing some important detail here.
>
> How often does userspace call mmap() and then _never_ fault on it?
> I appreciate that userspace might mmap() gigabytes of address space and
> then only end up using a small amount of it, so populating it lazily
> makes sense.  But creating a region and never faulting on it?  The only
> use-case I can think of is loading shared libraries:
>
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> (...)
> mmap(NULL, 1970000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f0ce612e000
> mmap(0x7f0ce6154000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x26000) = 0x7f0ce6154000
> mmap(0x7f0ce62a9000, 339968, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17b000) = 0x7f0ce62a9000
> mmap(0x7f0ce62fc000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ce000) = 0x7f0ce62fc000
> mmap(0x7f0ce6302000, 53072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f0ce6302000
>
> but that's a file-backed VMA, not an anon VMA.

Might the case of dup_mmap() while forking be the reason why a VMA in
the child process might be never used while parent uses it (or visa
versa)? Again, I'm not sure this is the reason but I can find no other
good explanation.
