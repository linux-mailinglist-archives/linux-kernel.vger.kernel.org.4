Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7B6A9B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCCQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCCQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:14:52 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7008D12F26
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:14:49 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i6so2424413ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677860088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+HigpCH+Z2DmMB8BhdGZnkGJxtK6UAghULTuYAvBYII=;
        b=DBUjHTuC6OLAOEFQL/9SnCUwEjvU7+kYaOKx7lUZ2rsDkdc7y/weciI+YncXMe6yPq
         6v7NyE0keu/sVTwXjsJ4KB5s6vKWaOGP/EGn2Ts18q4AM6xKHTTAs+FzN7P89jEGoSXx
         Rn4xQV9h2vkZ7UOsVGBeGNj5DXmqTpDFn5+Gz2eRhQI6AJYkNZmXOzKQfRNBCpuBXRbB
         POdcu+EOJT60kluX5CyxfEYIr7GmvmSf36YIDXysgZHS203zORKBRmpggPYflvsN1n8+
         9lgiQHv8LJxYXWINdHGrRhDw3uhYq9n1+bTj6MIZ0yhPAuvCWKEBstJYeMFnHvnJVk+B
         rlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677860088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HigpCH+Z2DmMB8BhdGZnkGJxtK6UAghULTuYAvBYII=;
        b=sSay4gT958HHvv6Ao9n//Q212Y11e5PCHvuVb4mVOczPO1uL8OoRNcGtS576ubnUfZ
         5+7ImUEyBBrAMFRmZ1mVkGH4KAEuGNoWj7oxun5p7fbUPhcbrbbL0wwTyOvwOHvGFQ7s
         B4Ek0T2v0amY0/b5i65+FaK3pC2tJD8MsDXtOrHZzzTzXEYG+DwRi7TkiuX2bhXZ35lO
         /nQHUqpo5aCD6U+YEcSvxjRGSGDIyLBkPzvE2uQU5yfTQpOuLynnju9D0vuN1sSlbD4l
         Nrk6mHqYITtuyJSY7jpqKES6uxMBawwHzC3TLnWR88RaN8L9d7xAcEssR+DEhxYqgWQS
         KP5w==
X-Gm-Message-State: AO0yUKVYxE6jo3OB+RJx4a+M8E4phXpqHFhBy84gtqWeOqHTjrvSAWbK
        RMo1HXPljNiED2gfKXAEKd8G8E5OIRCTmpnFLwfSiA==
X-Google-Smtp-Source: AK7set8tjuuaCGJxS2xjbV3oET8sl7sgczITsPDeROrOkb0RgwsUNDHjDBMroxTBST8vYw0SK0MsoSZi2W21t2t+4Gw=
X-Received: by 2002:a05:6902:524:b0:ab8:1ed9:cfc5 with SMTP id
 y4-20020a056902052400b00ab81ed9cfc5mr1287342ybs.6.1677860088329; Fri, 03 Mar
 2023 08:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20230301190457.1498985-1-surenb@google.com> <31a88065-063a-727e-52fd-9fbc7d17fb5c@redhat.com>
 <CAJuCfpGKK5SwxQr_BKrqnn0ZeaLVtX=n31MbKUwdnSSd4umB3A@mail.gmail.com> <787e7d9a-fcf4-ad5f-97f1-c0e1c1553c2d@redhat.com>
In-Reply-To: <787e7d9a-fcf4-ad5f-97f1-c0e1c1553c2d@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 3 Mar 2023 08:14:37 -0800
Message-ID: <CAJuCfpH83Wq7RK2Xv9ipZFTv4epNJPfhsqzZCXOLJ1D83ih3zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/nommu: remove unnecessary VMA locking
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
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
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Fri, Mar 3, 2023 at 1:05 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >> Just a general comment: usually, if review of the original series is
> >> still going on, it makes a lot more sense to raise such things in the
> >> original series so the author can fixup while things are still in
> >> mm-unstable. Once the series is in mm-stable, it's a different story. In
> >> that case, it is usually good to have the mail subjects be something
> >> like  "[PATCH mm-stable 1/1] ...".
> >
> > Ok... For my education, do you mean the title of this patch should
> > somehow reflect that it should be folded into the original patch? Just
> > trying to understand the actionable item here. How would you change
> > this patch when posting for mm-unstable and for mm-stable?
>
> For patches that fixup something in mm-stable (stable commit ID but not
> yet master -> we cannot squash anymore so we need separate commits),
> it's good to include "mm-stable". The main difference to patches that
> target master is that by indicating "mm-stable", everyone knows that
> this is not broken in some upstream/production kernel.
>
>
> For patches that fixup something that is in mm-unstable (no stable
> commit ID -> still under review and fixup easily possible), IMHO we
> distinguish between two cases:
>
> (1) You fixup your own patches: simply send the fixup as reply to the
> original patch. Andrew will pick it up and squash it before including it
> in mm-stable. Sometimes a complete resend of a series makes sense instead.
>
> (2) You fixup patches from someone else: simply raise it as a review
> comment in reply to the original patch. It might make sense to send a
> patch, but usually you just raise the issue to the patch author as a
> review comment and the author will address that. Again, Andrew will pick
> it up and squash it before moving it to mm-stable.
>
>
> That way, it's clearer when stumbling over patches on the mailing list
> if they fix a real issue in upstream, fix a issue in
> soon-to-be-upstream, or are simply part of a WIP series that is still
> under review.

Thanks for the detailed explanation, David. I'll post fixups to
mm-unstable patches by replying to the original ones from now on.
Interestingly enough, I have another fix today (internal syzcaller
found a potential deadlock) which might be interesting enough to be in
a separate patch. So, I'll post it as a separate patch and we can
discuss whether it should be squashed or kept apart.
Thanks,
Suren.

>
> --
> Thanks,
>
> David / dhildenb
>
