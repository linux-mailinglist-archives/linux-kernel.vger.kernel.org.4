Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FF670C00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAQWqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjAQWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:44:52 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BA45EFB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:46:03 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r71so6598273iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+bqBsZZ4RgN9jlgw+b1dC/NMypzjYzjrdfCfcedPWDQ=;
        b=oKiIXHz6hYZTnFSg8CyeAh1iOmXE+x2JTvTp7n/ELKxH9/S/8QqLxW5rxrlAIA0pY9
         FGTxfNB6FzBp2L1EQVFE0jq7nSlA/MyzEeFPLmHGwMM5qm7MDAy0PYZpOdEpveGC0Azy
         m7KF7D5TB3OeS6KxmOWgIJg3mNa70PP07eTN/QyWeX4JmtTKK0EXfC8wPXsA4aeOtGaA
         51aWJni3yr+WysiWx8JjxtUqnmzU+G4umBm6d27THEG3JhNZWzZ5rZtbU1Ya3nIlZuyR
         yYhzv1oAYEDalxwkXlfg1KcUXcWMaGXL1NwQ6aG+GfDIfRgoOXnIz83APIiCyu6bR5gq
         BH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bqBsZZ4RgN9jlgw+b1dC/NMypzjYzjrdfCfcedPWDQ=;
        b=GM7mS+PxZ7gWObSsb4R4sJnBnuOVvbh1pL3lccDTJS49epkNu1hTfh/fExlMq1HKBZ
         qot63menmbdfLoG3iLZYUxFe15ccyF5QoT58086T0g/nWbTYOPZydNRfsrlZsT7I4dpD
         NVRwtHYxNwwqsivYw4EZ8B0e389rz4kPmJiT+a3XjeylKg7I3r3UG+teaNGP7kg3dyee
         XV3uTHgQqUIwNpPpYyGnRjzFZUCjRnahPpVHgB4el4Xs+fGlCEdUko2ECB5QeAWBOUl0
         EBedoYLQSheV0N0vJpMvBfoF1Qb1Exy7iSLTvko5QwBciF6IoYxFhwNK1oP0UC9Q8Uee
         +jJA==
X-Gm-Message-State: AFqh2kp6BT1gSrHRclumNqMzGJCFykS/nX+sTvuHE/jBT5BZeRCN9hjv
        BaSOsi7xVZnfsbC0uBJDWZKCJOqLhk4pIyRUac6eDQ==
X-Google-Smtp-Source: AMrXdXvjzRa+kyqV5cDYZnYOJiY7YjAiK71oj/DKwnEZqpEByYHd/G13EWU8vxfkIQDeuwmQ9WfEcwYbls/tg1JyPyE=
X-Received: by 2002:a02:c884:0:b0:39e:9d33:a47 with SMTP id
 m4-20020a02c884000000b0039e9d330a47mr328254jao.58.1673991962307; Tue, 17 Jan
 2023 13:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com> <CAJuCfpHawn-hj3yK6MEMHsvnH9xgO87h7Sj3_g0FA7rgut_mVg@mail.gmail.com>
In-Reply-To: <CAJuCfpHawn-hj3yK6MEMHsvnH9xgO87h7Sj3_g0FA7rgut_mVg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 22:45:25 +0100
Message-ID: <CAG48ez3sCwasFzKD5CsqMFA2W57-2fazd75g7r0NaA_BVNTLow@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Tue, Jan 17, 2023 at 10:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> On Tue, Jan 17, 2023 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> >
> > +locking maintainers
>
> Thanks! I'll CC the locking maintainers in the next posting.
>
> >
> > On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > to be exclusively locked during VMA tree modifications, instead of the
> > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > locked.
> > [...]
> > > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > +{
> > > +       up_read(&vma->lock);
> > > +}
> >
> > One thing that might be gnarly here is that I think you might not be
> > allowed to use up_read() to fully release ownership of an object -
> > from what I remember, I think that up_read() (unlike something like
> > spin_unlock()) can access the lock object after it's already been
> > acquired by someone else. So if you want to protect against concurrent
> > deletion, this might have to be something like:
> >
> > rcu_read_lock(); /* keeps vma alive */
> > up_read(&vma->lock);
> > rcu_read_unlock();
>
> But for deleting VMA one would need to write-lock the vma->lock first,
> which I assume can't happen until this up_read() is complete. Is that
> assumption wrong?

__up_read() does:

rwsem_clear_reader_owned(sem);
tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
      RWSEM_FLAG_WAITERS)) {
  clear_nonspinnable(sem);
  rwsem_wake(sem);
}

The atomic_long_add_return_release() is the point where we are doing
the main lock-releasing.

So if a reader dropped the read-lock while someone else was waiting on
the lock (RWSEM_FLAG_WAITERS) and no other readers were holding the
lock together with it, the reader also does clear_nonspinnable() and
rwsem_wake() afterwards.
But in rwsem_down_write_slowpath(), after we've set
RWSEM_FLAG_WAITERS, we can return successfully immediately once
rwsem_try_write_lock() sees that there are no active readers or
writers anymore (if RWSEM_LOCK_MASK is unset and the cmpxchg
succeeds). We're not necessarily waiting for the "nonspinnable" bit or
the wake.

So yeah, I think down_write() can return successfully before up_read()
is done with its memory accesses.

(Spinlocks are different - the kernel relies on being able to drop
references via spin_unlock() in some places.)
