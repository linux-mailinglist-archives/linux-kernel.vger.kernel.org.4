Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738D0679FED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjAXRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjAXRQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:16:08 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96341298E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:16:06 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k14so277682ybt.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SB09lLGRGIMFrYYKfJZPIdG/5osP14MZrW2FUGghSBk=;
        b=k/mBrYMkl7HW/QMTyhTOwhYfTPv20DbvoMy7/jnPRMNNTFDIfIuPWtckad7bfhUEAa
         mvNAmEZ0E//z0z5QVr0ea1izXcOY609jgQtDn3iD5Vbte42TKhP4A+tl+Ofcl6kX90pm
         HHzxU4hw+Z/GjMJzaHzwgmw4c/X2s3aIDG9es8kDGn7+GM4hCj69wt5bEzvgMUZTGwBw
         8Yg1ZsMWcvLLW5KdhkvjT/rBfEyQkFrv8kUfT4ysBv/tZSKGLDz2Jz3rMDVFNZUvH7kc
         2ERsLF0RBKO1wXF5by0OpPbSUlB1PZzrLIxE9RvtTUc57QGT94kL6a194LfKj8BCmvgL
         x7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB09lLGRGIMFrYYKfJZPIdG/5osP14MZrW2FUGghSBk=;
        b=yHIHNI85H7rgjS9w3tW7UPMV8EnVDK3QurebYnuBs8p81QBPa7swwRyiube5kypOoz
         yHCp9dOZbB9h625zDu1xUGrl1wCK+f9khgheH26XA0hLqA1Nr9MlIZv6tmtSlvvBjHmQ
         Mc7nV1nuj+axSC9xDqxoVrgc/vYtXXhtLyfxfJOM/N09DBmLW4/QchVRP3HZavtEJPtQ
         0NrYiN30tJMUml/jsjOSObhXVNUdN3eeTPPUYvWE7LKid7sXdkhFOLv3azZgEFmautlN
         zjIYxiF/Jx7TMjoSjg3S3a8lizYM7WLtu4KUxe1+glRvT9Q9J6ORjAGrJpE+zZmKqvbH
         4wQQ==
X-Gm-Message-State: AFqh2ko3JGcE9VU4534pxha3V+RU87FId2Agg6NAKRxOSO1tqlW3/Vvq
        hKTu1yy798FLOCguXYNscumGpp2OIMuoOplPhkCMlw==
X-Google-Smtp-Source: AMrXdXtbY1NTeRdg02HGeRz8yvSmmdeILyVfa0WUl64oywG5rltAxavdZBHDfYp1xGmawbNnPXsSQWe6WQo+leez2kU=
X-Received: by 2002:a25:8002:0:b0:723:96ad:6761 with SMTP id
 m2-20020a258002000000b0072396ad6761mr3476678ybk.326.1674580565671; Tue, 24
 Jan 2023 09:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20230119212510.3938454-1-bgardon@google.com> <20230119212510.3938454-3-bgardon@google.com>
 <Y8nKerX9tDRHkFq+@google.com> <CANgfPd8B_0w39d7V+c4GnUxdqrc8qN78r8Pq0Con3Mx9WO0hkQ@mail.gmail.com>
 <Y8qj1QS1VadgaX7A@google.com> <CAOHnOrzKBh2Cq7ZQece+6f6P5wS6gZ1R2vjEQ5=QLTy7BmUvFQ@mail.gmail.com>
 <CANgfPd_B0q6uU1Be7A-QOj5_YoWi8z9g9LO63mc+=136hO5K4Q@mail.gmail.com>
 <Y87UzmpCg9hXO2NI@google.com> <Y8//SKBTT2h2m8Cz@google.com>
In-Reply-To: <Y8//SKBTT2h2m8Cz@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 24 Jan 2023 09:15:39 -0800
Message-ID: <CALzav=e0hiTK5xX+9vrpf_unK274NYxKGUVQ43tSpO_ad0MSPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: KVM: Add page splitting test
To:     Ricardo Koller <ricarkol@google.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
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

On Tue, Jan 24, 2023 at 7:54 AM Ricardo Koller <ricarkol@google.com> wrote:
>
> On Mon, Jan 23, 2023 at 10:41:18AM -0800, David Matlack wrote:
> >
> > Ricardo, if you're interested in adding page size stats to KVM/ARM ahead
> > of the Common MMU, e.g. to test eager page splitting, let me know.
>
> Sure, I can do that. Sounds pretty useful too.
>
> > I
> > want to make sure we align on the userspace-visible stat names to avoid
> > churn down the road. Specifically, do we want to expose neutral names
> > like pages_{pte,pmd,pud} or expand the KVM/x86 list to include all of
> > ARM's possible pages sizes like pages_{4k,16k,64k,...} (or both)?
>
> I would prefer the latter, mainly to match the x86 names:
>
>         +       stats->pages_4k = vm_get_stat(vm, "pages_4k");
>         +       stats->pages_2m = vm_get_stat(vm, "pages_2m");
>         +       stats->pages_1g = vm_get_stat(vm, "pages_1g");
>         (from this patch)

We can always add pages_{pte,pmd,pud} to x86 as aliases of the
existing stats. The series I recently sent out to allow custom names
for stats [1] would make adding the aliases trivial actually.

[1] https://lore.kernel.org/kvm/20230118175300.790835-1-dmatlack@google.com/

>
> but pages_{pte,pmd,pud} would certainly make this test simpler
> as it would handle all guest page sizes:
>
>         +       stats->pages_pte = vm_get_stat(vm, "pages_pte");
>

Yeah pages_{pte,pmd,pud} would certainly make the test simpler.

At this point I'm leaning toward pages_{pte,pmd,pud} to unblock this
testing in an architecture neutral way, and we can add
pages_{4k,16k,...} to ARM in the future using aliases.
