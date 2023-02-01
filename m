Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043F2683AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBAAEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBAAED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:04:03 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDA3C22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:04:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c124so20272352ybb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUycsi7Qy1G+kA/BDKEqAynjD+S1ub0yGcBr2S1csDg=;
        b=kjgH2CMPcbJUL89I13duLHr/x00EFsX3fEJyRMjgA3lmo+3BlhNvsXihc340eh4Mo2
         xJLlakMeru4DhNc2LQ7VdXDjksVjD8J95ylIlceJjZjmLcziSrIGjflqo01hf0aIuPRr
         /Tm7tSWg1BzuIO5SMCXWDrfUCKN94wOyzFfYw06eAp4JwvSUDIkxnWZVGG8jazLCRLQ4
         fy9jQY5nCrkr6ftTyn2XwMB2wYenW9lk/kPwLomUt2hRm3TEP3rTyKcgDtcfIeERobCm
         uThPnsvu8qu2+2UDFWG+LRF+g46vJaxVjEr6TrfgDRaIL6R7vK5wPEjDj7fJztXMnUO3
         CX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUycsi7Qy1G+kA/BDKEqAynjD+S1ub0yGcBr2S1csDg=;
        b=2MCE8D9tdviY3JzIsl7BTkmNiT42tkV50gpvvAuQgjqdm12axUh/nnev0NEyLDuGSj
         0zcr7MIJOorbnx+igHReuZecRjfFrFqC23G+/GVLk5GV39NVHq+pCC2XqDZc4VR/MUFp
         OR3tYxXrQ53kwZRfwJxB1/hQ4fIN8+hsp8mAN+nvtZMhKjLYel/3kdyEAib1j7QneBHY
         qBpmsbOd5gNvqCXULn6pi01aQTJGH7JACrmznL/ZYx32n0hDSZnO2l28O/VTxV5hTLWD
         wyWcqSRH9ZbD3w0xo7Vvwhzfr9VY7e5Qn49Xm8rHZj/AT4Iw4Fbdun3sKDdbLBzBu90Z
         vtdg==
X-Gm-Message-State: AO0yUKV53uQ4XqTVMOqrWrJcQA2/j92f9n4nCIXTn5GM34qGOVBjiywg
        KFCW2DRQFVtlzsrxm94DPuQ8xB4l5hEbUGlumL/uzg==
X-Google-Smtp-Source: AK7set8i/R4jubc4/eBLZr1C2uot2lhviGeGxjdH9LtwH5rX8BcQ29iFG2gEY6poGbAAfxlHLKG4eGpFSJTOl8lO5k0=
X-Received: by 2002:a25:2441:0:b0:80b:5988:2045 with SMTP id
 k62-20020a252441000000b0080b59882045mr107656ybk.59.1675209840310; Tue, 31 Jan
 2023 16:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com> <20230126193752.297968-5-surenb@google.com>
 <Y9jSFFeHYZE1/yFg@hyeyoo> <CAJuCfpEzaVkgQt=C-33jAh1vLVJAjoyM8X5AD9CzyDUJnPDCkw@mail.gmail.com>
 <20230131125355.f07f42af56b23bfa28b2a58c@linux-foundation.org>
 <CAJuCfpHmtkzrKx45SQQ0gXLoybtgHxHmTP5J4L74ChTqSfFA-g@mail.gmail.com> <20230131151209.d53ba65c3c065979808d9912@linux-foundation.org>
In-Reply-To: <20230131151209.d53ba65c3c065979808d9912@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 31 Jan 2023 16:03:49 -0800
Message-ID: <CAJuCfpF-Lu2fX6azVzmpJn75qDgwjpWjKT85=CEbwo2YAnx-Qw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
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

On Tue, Jan 31, 2023 at 3:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 31 Jan 2023 13:08:19 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Tue, Jan 31, 2023 at 12:54 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 31 Jan 2023 10:54:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > > > -             vma->vm_flags &= ~VM_MAYWRITE;
> > > > > > +             vm_flags_clear(vma, VM_MAYSHARE);
> > > > > >       }
> > > > >
> > > > > I think it should be:
> > > > >         s/VM_MAYSHARE/VM_MAYWRITE/
> > > >
> > >
> > > I added the fixup.  Much better than resending a seven patch series for a
> > > single line change.  Unless you have substantial other changes pending.
> >
> > Thanks! That sounds reasonable.
> >
> > I'll also need to introduce vm_flags_reset_once() to use in
> > replacement of WRITE_ONCE(vma->vm_flags, newflags) case. Should I send
> > a separate short patch for that?
>
> That depends on what the patch looks like.  How about you send it
> and we'll see?

Here it is: https://lore.kernel.org/all/20230201000116.1333160-1-surenb@google.com/

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
