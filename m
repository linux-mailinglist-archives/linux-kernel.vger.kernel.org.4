Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C620F66E6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjAQTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjAQTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:12:45 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D59637B7E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:26:44 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v19so29278839ybv.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4j3tl0DYASqrjkqUxwz46bG4ROPSgLPddwJUIyGPfX8=;
        b=hBh7iHpA0qfvzb6NYfBFfodVZoJZG89lkfXRit37mYAmeC5nBFxn8EQS0LUAe3jcVo
         C5FRsaxj+EKLI2jWmHfjp8neugrXB9pI/nKBzQoYA1YpgFoWtnyOa5v24hYecpIUquUN
         KSNNz94C5dAuBzIbNy+BM3HlLgWGdJfq88KPVCdqr5XOURSiVIt8NC83fhsqzZZfL4An
         QFEI0BAISvqo9iX+zoQ1BM4zTAWiTj/t7PqnS+AcCO7l4eOGIMMkEF+giJ7BJLV4QoxO
         D/AunpSl6jrX3m5nr8I4wWYNarHbEt/jf3IwcNd/YSKXxcntJzTg/UwFDPfUl4301hBU
         s7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j3tl0DYASqrjkqUxwz46bG4ROPSgLPddwJUIyGPfX8=;
        b=0kmhzCyV4vOJvL8Igcw4u3VgQOB9EGGbsl+HHZ2dBLZ+NNZE81qxnOlS1AaK9Dwg65
         IEiR9Lf9ei9uCQhuotdLJ9Dg5HNc8VPni0qqRwqcFDI646Ckfjz0wXdvoBpUDBCRo4Tp
         AdMSK0vrWo/F4rBtePNyFBTdvWbbvpkdOhl3zHj5/UU7iumrZD1e80usi4t8IVcPTUVU
         iuP++V0oYu7ervp7fd+DkbwT/hukap/lOtLj6ALKGOTIucfhgAcsdPG4JU8myrC+ygMU
         BfEIld18ItAXzFuROyrVVczvE9GiI8jpbg4HY09KsD98w+Uu9mI6k7KYl17Ie2edPu8o
         KAAA==
X-Gm-Message-State: AFqh2kp1hgn2FD98/cb30hsjybIYCX9iITYiVQhZDzi2yYt/D5AFO45I
        qQ4l3PHEs9UgOF4Ciy8Xlhb5e+YnD8KcigvLc5vrpA==
X-Google-Smtp-Source: AMrXdXs7BogT7SdoZ360ei40N37ZNOM5XxWUzxAMlDXlaXiTGADLynxjLDtiuGW4hqoQrK26rMYv0lMAFrNqu+/4diM=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr537549ybe.316.1673980003301; Tue, 17
 Jan 2023 10:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
In-Reply-To: <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:26:32 -0800
Message-ID: <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
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

On Tue, Jan 17, 2023 at 10:12 AM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > rw_semaphore is a sizable structure of 40 bytes and consumes
> > considerable space for each vm_area_struct. However vma_lock has
> > two important specifics which can be used to replace rw_semaphore
> > with a simpler structure:
> [...]
> >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> >  {
> > -       up_read(&vma->vm_lock->lock);
> > +       if (atomic_dec_and_test(&vma->vm_lock->count))
> > +               wake_up(&vma->vm_mm->vma_writer_wait);
> >  }
>
> I haven't properly reviewed this, but this bit looks like a
> use-after-free because you're accessing the vma after dropping your
> reference on it. You'd have to first look up the vma->vm_mm, then do
> the atomic_dec_and_test(), and afterwards do the wake_up() without
> touching the vma. Or alternatively wrap the whole thing in an RCU
> read-side critical section if the VMA is freed with RCU delay.

vm_lock->count does not control the lifetime of the VMA, it's a
counter of how many readers took the lock or it's negative if the lock
is write-locked.
