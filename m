Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE51678146
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAWQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjAWQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:23:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9E25288
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:23:05 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p141so12747253ybg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMnbgf/RHQ3ZAFZtL86FFLpdOpXvUOvzb7OmVGfvdng=;
        b=GT9CtnzFDJgzUI5mydXp8vMCy8KjDM1ZqtBPYM0kcgx0FRmyl+E9TT47+NJLVc9OqG
         5B3xB6XB0xC505sdjlph/P3bNWUs+gwAY1bJeex4c5AXqMOiJ4kjsB70LJKHU1jq0S1p
         hpeWHMoy7IOoUmJEKiUYEepireN9i7kkgjXe4rrGmSrAN1Teoju59/CEYvPmeHmEYidF
         p6NVvwPXwkThYpdM/Zr6S2ip9BawZ0L6I9IbGk4vDo34NVL1snNIbnQPkwhHHAoedn6L
         IAMXqS1Abqo4chqx/pUJclhMWVSXP4nbkA+vi+eRWwhfst2RSj0RmxvR/EUi0HREO6Zi
         Qa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMnbgf/RHQ3ZAFZtL86FFLpdOpXvUOvzb7OmVGfvdng=;
        b=Jd8Lle0cgyqrXvAJwmg1LlmB58J/YPJfdrYttTax4E2UfbA3rw5m52D2H5Taz6zMgz
         dtAHUEz2T6xUiDhWsAu3ANuCsEGBdACfpuxSstWfhtZt4CI5rpaLm1WdCI2dBK9tJg3H
         6X01BzRD2hkdt16ZDTicjPIHMB/01TYqiCXogzj3wbtkyjgS4d3bkxrn4Beu79gpWkdR
         z8QcjEoQZn6j1dELgzVCy2bxwHuVzrJy6AFJ2gR0AEvvRPHCgoC3zNMjIENkS4IgMsjY
         wQN2azr2seHlMnEwvTf4WXkc/TTuo4+iiOzy4alZqcb1YHvQf9xx1FF/ZqDMtsMUk+q6
         Qojg==
X-Gm-Message-State: AFqh2kpRk6YEh92NciltKkTzUPoeUt8DGNV78SI7DJk2cLosYXNx5ZEu
        fWH/PHcnGf70caUmIQnGkN39zUKNBuJVrNt9uLpOoA==
X-Google-Smtp-Source: AMrXdXtgthJLROeIi9Kdf1aWHb5lhJLB0d8xJETJsdksQhtsxXC8/QdbWj0HkxC0Jssb10n37A0eaFm+06xsm+/I2B0=
X-Received: by 2002:a5b:cc8:0:b0:7ba:78b1:9fcc with SMTP id
 e8-20020a5b0cc8000000b007ba78b19fccmr2576165ybr.593.1674490984902; Mon, 23
 Jan 2023 08:23:04 -0800 (PST)
MIME-Version: 1.0
References: <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz> <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
 <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org> <20230120170815.yuylbs27r6xcjpq5@revolver>
 <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
 <Y8rQNj5dVyuxRBOf@casper.infradead.org> <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz>
In-Reply-To: <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 08:22:53 -0800
Message-ID: <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
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

On Mon, Jan 23, 2023 at 1:56 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-01-23 09:50:01, Suren Baghdasaryan wrote:
> > On Fri, Jan 20, 2023 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
> [...]
> > > The page fault handler (or whatever other reader -- ptrace, proc, etc)
> > > should have a refcount on the mm_struct, so we can't be in this path
> > > trying to free VMAs.  Right?
> >
> > Hmm. That sounds right. I checked process_mrelease() as well, which
> > operated on mm with only mmgrab()+mmap_read_lock() but it only unmaps
> > VMAs without freeing them, so we are still good. Michal, do you agree
> > this is ok?
>
> Don't we need RCU procetions for the vma life time assurance? Jann has
> already shown how rwsem is not safe wrt to unlock and free without RCU.

Jann's case requires a thread freeing the VMA to be blocked on vma
write lock waiting for the vma real lock to be released by a page
fault handler. However exit_mmap() means mm->mm_users==0, which in
turn suggests that there are no racing page fault handlers and no new
page fault handlers will appear. Is that a correct assumption? If so,
then races with page fault handlers can't happen while in exit_mmap().
Any other path (other than page fault handlers), accesses vma->lock
under protection of mmap_lock (for read or write, does not matter).
One exception is when we operate on an isolated VMA, then we don't
need mmap_lock protection, but exit_mmap() does not deal with isolated
VMAs, so out of scope here. exit_mmap() frees vm_area_structs under
protection of mmap_lock in write mode, so races with anything other
than page fault handler should be safe as they are today.

That said, the future possible users of lock_vma_under_rcu() using VMA
without mmap_lock protection will have to ensure mm's stability while
they are using the obtained VMA. IOW they should elevate mm's refcount
and keep it elevated as long as they are using that VMA and not before
vma->lock is released. I guess it would be a good idea to document
that requirement in lock_vma_under_rcu() comments if we decide to take
this route.

>
> --
> Michal Hocko
> SUSE Labs
