Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B25FA78D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJJWJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJJWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:09:54 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5740BC2F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:09:51 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id h29so2192570vsq.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=to0E26B0eTn0BoLxAdeG5AQBNHUdUnEcc0Lu0kThXsE=;
        b=Gc2gJXUM7PqQFT3EpZSgTh3k453br1ZR08P12DPdnARuGUmO86kYnjqOIfMlQYxbjr
         xob1LQGBIBqlSMv2U+jyVZqM1NXSdkCvL1WITUe3UwPi6/xgHyHFRd2XEY4tVX1vOtGN
         qTpI+yUgYMmpxJVab2Wq7HdYGsPWxYVciKBQecmKIO4Dv4vS7xDIbRs13OKBeKAFoZnI
         kpI9v8zlM+4xs3War7HIaCTXvXiSmQBAHoCm7qx2aYcS0Iu/Y6W92LaJJP59pVHw8fvV
         d8nrVgnHU+VCuOrfxLxEiOPC36+nAFQM1J0OQyZC+0S8QbAoUIw4tG554zJB6qNSFH3q
         4UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to0E26B0eTn0BoLxAdeG5AQBNHUdUnEcc0Lu0kThXsE=;
        b=5EZCiVtoIdqQcZpmdPmmOQW2960TKAYOfsPY05J2a4yIpK6AIJ7pBkGOJQ7WdLG/rw
         zmceANDbj+8CjnqC94XYqP49X/7CgoqxITa2lCb+vc5/XeOn5s6toV/A/oeO8fUmHBQ0
         JdqXNI+SacgakY296oGcZaIWIfFNj+hfOu+AkayAPkRHUAhprAxFlts1eWccp/ybKV/y
         4ugtDRtij2oVfrlBdXVv4wyF/XS1fKmNJDlrxfrLgnpCgM8yp+aZma0KjPYZIpu8wQqM
         aJx4XdTAq/KUr2GiE+OyrxwHbiCciH22X1pnlMXrmZlaQnnq1yVojGFwRUrDvfnDHp7S
         Itfw==
X-Gm-Message-State: ACrzQf2zSmOj3+xhz5MlhDdVNqXHseoQAU2PQjvaNKM3ueKDs3SfKNzh
        i4rKRqiGRCzMo5az0Sf2f0HzzsRECZjNYVF/C0FjuQ==
X-Google-Smtp-Source: AMsMyM5jZpmN+RoyV1Xh72dXpXtBbcQJONuTh8MgttO6aBPx0KMJ2/HT//ezZZscw/eTnQEhy8C8PdayGex+oq108eQ=
X-Received: by 2002:a05:6102:3309:b0:39a:e5eb:8508 with SMTP id
 v9-20020a056102330900b0039ae5eb8508mr10379538vsc.65.1665439790785; Mon, 10
 Oct 2022 15:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220824141802.23395-1-mgorman@techsingularity.net>
 <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
 <20221010142208.ctsasloh7hbudupc@techsingularity.net> <a7092c47-63ef-200a-8968-7e3402e19a38@suse.cz>
In-Reply-To: <a7092c47-63ef-200a-8968-7e3402e19a38@suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 10 Oct 2022 16:09:14 -0600
Message-ID: <CAOUHufYck0whrXAYBN9mO6CTairoJ0cG9YyU79pMPvYjrXLrOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page allocations
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Oct 10, 2022 at 2:45 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/10/22 16:22, Mel Gorman wrote:
> > On Wed, Aug 24, 2022 at 10:58:26PM -0600, Yu Zhao wrote:
> >> On Wed, Aug 24, 2022 at 8:18 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >>>
> >>> The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> >>> allocating from the PCP must not re-enter the allocator from IRQ context.
> >>> In each instance where IRQ-reentrancy is possible, the lock is acquired using
> >>> pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> >>> is impossible.
> >>>
> >>> Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> >>> case at the cost of some IRQ allocations taking a slower path. If the PCP
> >>> lists need to be refilled, the zone lock still needs to disable IRQs but
> >>> that will only happen on PCP refill and drain. If an IRQ is raised when
> >>> a PCP allocation is in progress, the trylock will fail and fallback to
> >>> using the buddy lists directly. Note that this may not be a universal win
> >>> if an interrupt-intensive workload also allocates heavily from interrupt
> >>> context and contends heavily on the zone->lock as a result.
> >>
> >> Hi,
> >>
> >> This patch caused the following warning. Please take a look.
> >>
> >> Thanks.
> >>
> >>    WARNING: inconsistent lock state
> >>    6.0.0-dbg-DEV #1 Tainted: G S      W  O
> >>    --------------------------------
> >
> > I finally found time to take a closer look at this and I cannot reproduce
> > it against 6.0. What workload triggered the warning, on what platform and
> > can you post the kernel config used please? It would also help if you
> > can remember what git commit the patch was tested upon.
> >
> > Thanks and sorry for the long delay.
>
> I didn't (try to) reproduce this, but FWIW the report looked legit to
> me, as after the patch, pcp_spin_trylock() has to be used for both
> allocation and freeing to be IRQ safe. free_unref_page() uses it, so
> it's fine. But as the stack trace in the report shows,
> free_unref_page_list() does pcp_spin_lock() and not _trylock, and that's
> IMHO the problem.

If this is not the case, please let me know and I'll try repro again.
