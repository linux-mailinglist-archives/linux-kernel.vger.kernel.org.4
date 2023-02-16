Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6069A2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBPXxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjBPXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:53:17 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5223B211F2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:52:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id b22so2276683pgw.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676591569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQQttzFDRF1k4K8Lrrl35IKonA1RDweLLR+nTYZXoZo=;
        b=AZwUiVgv6L1VRiwCkkgGm0FdffD39p58AAM7b3WBm7WMtV8qgOpJ4ygj0PXdRtvxxv
         dI8sn/vFALEo4qIahSgeKWlQvl3V7/pABfItlo45RyvkTwKix/zYDsQTTSyypKHWFR6U
         Na58oaNpMHG/d0a/+gqiHGTKxjfmLHrviiVujOpcQzMmeJ7yTzeY2Tf9yeZEwV/fdDEj
         4loH5MdFbcqh9BnvaA1fJqc8PH/kO81xTuw4ZoyQLQ4QfjNkIoSvrKZHQzSsAQ5R08Vg
         SXkN+qpERH3lQDZQF6fT4RCUp8+tfwQ4KiciMUVxYlTkwSpmVjxJi/zG2SA9DgBJyqhV
         wOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676591569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQQttzFDRF1k4K8Lrrl35IKonA1RDweLLR+nTYZXoZo=;
        b=yZjk/ueupNdCmGQlRtzcuqZbE/OGPP+822gWKdewL8YmIy/+1vfaTSNsY4ViIwHV1f
         hoqOL3uKrO7xU2DSp8Z+jXjWySXwGf+XiMO4SdqO/FvuwkWu2OuHEqa+yuwGucz36Ipi
         kFUXP/XmKv1uu0SdeyKBL8s13V3ONR2+dasK7KBePwSFJjXQoEfJToKbb4Y6ueoct8vO
         qkpk4Km7S12Eox0MkLDLNSkWX9ApMm8KR3u5LgV+8kQipGZtLTVItYBa5xLST0Q72RiW
         58OYOrM3fwJnpz6W6z9LOpR5TPyoKigQKagpKVZIVJtCJpxr4uwx/8gyAGJwjhWFJ8bB
         +YNw==
X-Gm-Message-State: AO0yUKWU67UbdfLfpNkfmQmu8HD7LskJVmtVUrLDDoAv89khwgjxLhkc
        AeiuJM8mQ531MomOwP73xV9F1ph+wHNPWDu/NSE=
X-Google-Smtp-Source: AK7set/XxDEp84qJkQ2ZGaZgeYodfzB/yLWkoCQb3R4uSy4sCDEm86zWbXqWAmfoU1Mlv/me9SR+M158K3SJvt1XlDo=
X-Received: by 2002:aa7:9510:0:b0:5a8:b987:b71f with SMTP id
 b16-20020aa79510000000b005a8b987b71fmr1325317pfp.20.1676591569455; Thu, 16
 Feb 2023 15:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20230214075710.2401855-1-stevensd@google.com> <20230214075710.2401855-2-stevensd@google.com>
 <Y+1hMsm4eQIUtag5@x1n> <CAD=HUj69L2e-Z4TB19qFt8h1cn0r1oGbWovJGMOjjyvfDcQ7NA@mail.gmail.com>
 <Y+5Akpz4CvGywt6R@x1n> <CAHbLzkqUF8Y759ZBVGXWdKwDS4f+ZJakUhoqf8Dqvx0Jam4c1g@mail.gmail.com>
 <Y+63LQo49CCyXRQn@x1n>
In-Reply-To: <Y+63LQo49CCyXRQn@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Feb 2023 15:52:37 -0800
Message-ID: <CAHbLzkokih0j=niLuWJLBDfTS8biiDTjC6gudw+qcDCBpMneAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 3:07 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Yang,
>
> On Thu, Feb 16, 2023 at 01:58:55PM -0800, Yang Shi wrote:
> > > IIUC we released it before copying the pages:
> >
> > The huge page is locked until the copy is done. It should be fine
> > unless the users inspect the page content without acquiring page lock.
>
> The current patch from David has replaced "insert hpage into holes" with
> "insert RETRY entries into holes", so IMHO the hpage is not visible at all
> when releasing page cache lock here.

IIRC his patch (just this patch, don't include patch #1) conceptually does:

acquire xa lock

fill the holes with retry entry
if (nr_none == nr_none_check && uffd missing pass) /* no hole is
filled since holding xa_lock and no uffd missing */
    install huge page in page cache <-- huge page is visible here
else {
    set error code
    replace retry entry back to NULL
}

release xa_lock

if (succeed) {
    copy content to huge page
    unlock huge page
} else
    restore the small pages


Am I missing something?

>
> All the accessors (including RCU protected ones to access page cache; those
> may not need to take the page lock) should be spinning on the RETRY entry,
> which it seems fine to me.  But my question was whether it's legal to keep
> them spinning even after releasing the page cache lock.

After releasing the page cache lock, they should see NULL entry or
huge page IIUC.

>
> Thanks,
>
> >
> > >
> > > xa_locked:
> > >         xas_unlock_irq(&xas);  <-------------------------------- here
> > > xa_unlocked:
> > >
> > >         /*
> > >          * If collapse is successful, flush must be done now before copying.
> > >          * If collapse is unsuccessful, does flush actually need to be done?
> > >          * Do it anyway, to clear the state.
> > >          */
> > >         try_to_unmap_flush();
> > >
> > > Before insertion of the multi-index:
> > >
> > >         /* Join all the small entries into a single multi-index entry. */
> > >         xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> > >         xas_store(&xas, hpage);
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>
