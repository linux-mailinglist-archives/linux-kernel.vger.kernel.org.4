Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441D8681B35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjA3USI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjA3USD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:03 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131CD559F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:17:56 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5063029246dso175794067b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GMl2uDka93AVr35MrY5ApUxMb/Mjb9nhfbhz7Ci6uO0=;
        b=Mj7GeLUuZjmld70jBpFL5X14Q68dtG8rNGZ/iKa6/aeBcWzYiIvx38+aZ/+Ll45vT5
         eRbo+LtcqsbchdHs4FyN3nur6dYNPtb3hR4xx6sgfaWkdEx+O3FXdhwolhi1Er2yAOZP
         EyQauuEfLqsYsejFIg2DVr4gotGyL9Hw4MK+J0Z52d3EmteN9gdO/4pzsesCi6sfs7R/
         VuH6xbzRLCNkzt1aYY8FKnPrK3/sQ41sejaUXq2dIOdwjXFCRTtDGlXDFiLwtbhXV4xS
         mXFaamCIsPbi4f0zrqJJ3ATbbzsEZ2NZmly4XBcg+LYon0Ca//LwjEE5Vee0BQC268Lg
         M3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMl2uDka93AVr35MrY5ApUxMb/Mjb9nhfbhz7Ci6uO0=;
        b=gWJdQkOrqY5Rp+ZwYVjxARxPQZDjsglzuRyNNGnxHTvY7mIFBWk4YFUmRGxgZ+WQ1L
         mQ/Vs1zQZDZ4JW/2tEtR0n1hmBukpKz9BDCMPCfz0Ia7JCyTpLe5GJG7d8f8tip3uDAu
         6IDPWEq+HkShSjhH/FdaQxd/+52axg+0YaWWt4fRt4Ij4+E+BvkTWFXD4d1Qf6Nh9Zh4
         MmiU8CT69wXyNRCi7UQqvh6ZHxku02gVfpV+ug9qHTKtZ7SR+FsKNySE6AxkvApXPfnj
         LsCEaHWnlDiQhLsY0qZdjGQJlEeNdimNN+UlSeuXnZpkSaIaGV5cdZmxR2JnU99gyVtw
         pjFg==
X-Gm-Message-State: AO0yUKXkP+fU+NC1Wvss0tuI0ESyBA3MnS5Ky6Bwb4tXA01ihmP0gCIY
        GZRXY/zTQUlUQZK8WYgtfHb2y8thVXgJ5D0LMieNAg==
X-Google-Smtp-Source: AK7set+jhh7mnDf1Wrk5aldDrTRUvvuoIOWjxl7rz+ln/Bjf7v2mBtMHV/ESgdJzLr7c5zLS/hcPEwvcvq9hmnKNWfk=
X-Received: by 2002:a0d:f301:0:b0:51b:b7cc:5fc1 with SMTP id
 c1-20020a0df301000000b0051bb7cc5fc1mr13174ywf.120.1675109875715; Mon, 30 Jan
 2023 12:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20230125213857.824959-1-vipinsh@google.com> <Y9GmiyRQ6sULCjEG@google.com>
 <CANgfPd9T7jdh1Cjjo4y6DcxC2poTaGhQ7wNLf6OgGtStg-yKJg@mail.gmail.com>
 <Y9HcHRBShQgjxsQb@google.com> <CAHVum0cd=YKvEKi7xZZHCTBn9XAxiax92JHV_W47R8rYvvnF-g@mail.gmail.com>
 <Y9gH3OHA4ftegU7X@google.com>
In-Reply-To: <Y9gH3OHA4ftegU7X@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 30 Jan 2023 12:17:19 -0800
Message-ID: <CAHVum0eReWgo_3yWxdtbyFGxeTnWUiEn9uVu0W5XX3KfHAgikw@mail.gmail.com>
Subject: Re: [Patch] KVM: x86/mmu: Make optimized __handle_changed_spte() for
 clear dirty log
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jan 30, 2023 at 10:09 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sat, Jan 28, 2023, Vipin Sharma wrote:
> > On Wed, Jan 25, 2023 at 5:49 PM Sean Christopherson <seanjc@google.com> wrote:
> > > -static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
> > > -                               u64 old_spte, u64 new_spte, int level,
> > > -                               bool shared)
> > > -{
> > > -       __handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level,
> > > -                             shared);
> > >         handle_changed_spte_acc_track(old_spte, new_spte, level);
> > > -       handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
> > > -                                     new_spte, level);
> > > +
> > > +       /* COMMENT GOES HERE. */
> >
> > Current "shared" callers are not making a page dirty. If a new
> > "shared" caller makes a page dirty then make sure
> > handle_changed_spte_dirty_log is called.
> >
> > How is this?
>
> I was hoping for a more definitive "rule" than "KVM doesn't currently do XYZ".
>
> > > +       if (!shared)
> > > +               handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
> > > +                                             new_spte, level);
> > >  }
> > >

What if implementation is changed a little more? I can think of two options:

Option 1:
Remove handle_changed_spte_dirty_log() and let the callers handle
mark_page_dirty_in_slot(). Similar to how fast page faults do this.
This will get rid of the "shared" variable and defining its rules for
the shared and nonshared flow.

Option 2:
Changing meaning of this variable from "shared" to something like
"handle_dirty_log"
Callers will know if they want dirty log to be handled or not.

I am preferring option 1.
