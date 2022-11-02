Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3623961670C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKBQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiKBQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:04:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4242C667
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:04:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v3so1672443pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s6CR/sjOWMRgzZ2grqNLMmJh27PcLr1rVenOrVjKLFk=;
        b=jemZxvyvf6Hy8poVBywoCuYJdkyvs3DbR9PozWskbZZR0FdUcCzblKNolC9tQrBTvK
         1UCFV/LlYmanlyzmTigaOR0IwPj8W/kPXnvC8HKTnJt8naVgVgOmdxnOhk45yPkTxwEg
         3Tsr8VK74cL9bdHMv+JuOnkZsUk8ufH7jJMwFeXhIgeKy3LT+myb5ckzOljiIfXsABB2
         Mbyg0Pg43rrHDx7fAvxIlah4XrvDjMsG+BUTWELZv/Cbg607X++Uh3Y5US4gBXP+YIHV
         n+t2P7AdNAX1Loy7xfcOA2bFRO9iGXr1+cI5DQIIOebCore817eYCm/g3t3jxHDrxpVG
         qCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6CR/sjOWMRgzZ2grqNLMmJh27PcLr1rVenOrVjKLFk=;
        b=nyp8aiARHyZfQtp0hdOyHir0KHh56u8j1hBuHlpu7POd/rE74gX2HmIamLtm+DCJ9h
         1ZNFXGL65DbbYdO/jslQZdcC1ABUv5eW3iMBcEW/rTAkUAnAKNi6ktu2tnZBkF0S/XWB
         8CHivFWjWN32l3iz0XqRsN9ittPO3nBobjQA73URbkVCmN72zMGmpAfG3UiM8jnIXd41
         /6ro1tMbcr5LtGhjnCBfrF907gg1e8g6XM1tTXkTjF/vzwbgt67WjqLJEurqrQ9D5IHo
         2Jm/8ETT/MXjVaZVdFGmAHQtRIrXe8QdCvHNS7pItzTnnvO5zcXsckJ6coCqP3+CN9qT
         kPoQ==
X-Gm-Message-State: ACrzQf1q44BRZeBhaE4sfBXbTIWY/ojKm2yjc2pcgTzh79Kgkqn2uVJd
        +/DLcS56I9wvlndLFa25NKx16MSazqY0O22WF7h5PONm
X-Google-Smtp-Source: AMsMyM7XhH+J62TdZda/bJg3FeFTAHLIfYwBScje++5AZDGRRsBuCGHZXHUgJUSvYvyHrCGEx0wOuiBzXVgHAwKGCOk=
X-Received: by 2002:a63:6d8a:0:b0:46f:57e9:f933 with SMTP id
 i132-20020a636d8a000000b0046f57e9f933mr22489046pgc.195.1667405049612; Wed, 02
 Nov 2022 09:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com> <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
In-Reply-To: <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Nov 2022 09:03:57 -0700
Message-ID: <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> [...]
> > This is slightly tangential - but I don't want to send a new mail
> > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > explicit node vs having hpage_collapse_find_target_node() set a
> > nodemask. We could then provide fallback nodes for ties, or if some
> > node contained > some threshold number of pages.
>
> I would simply go with something like this (not even compile tested):

Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
not sure whether it is worth making the code more complicated for such
micro optimization or not. Removing __GFP_THISNODE or even removing
the node balance code should be fine too IMHO. TBH I doubt there would
be any noticeable difference.

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4734315f7940..947a5158fe11 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -96,9 +96,6 @@ struct collapse_control {
>
>         /* Num pages scanned per node */
>         u32 node_load[MAX_NUMNODES];
> -
> -       /* Last target selected in hpage_collapse_find_target_node() */
> -       int last_target_node;
>  };
>
>  /**
> @@ -734,7 +731,6 @@ static void khugepaged_alloc_sleep(void)
>
>  struct collapse_control khugepaged_collapse_control = {
>         .is_khugepaged = true,
> -       .last_target_node = NUMA_NO_NODE,
>  };
>
>  static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
> @@ -772,7 +768,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
>  }
>
>  #ifdef CONFIG_NUMA
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int hpage_collapse_find_target_node(struct collapse_control *cc, nodemask_t *alloc_mask)
>  {
>         int nid, target_node = 0, max_value = 0;
>
> @@ -783,28 +779,25 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
>                         target_node = nid;
>                 }
>
> +       nodes_clear(&alloc_mask);
>         /* do some balance if several nodes have the same hit record */
> -       if (target_node <= cc->last_target_node)
> -               for (nid = cc->last_target_node + 1; nid < MAX_NUMNODES;
> -                    nid++)
> -                       if (max_value == cc->node_load[nid]) {
> -                               target_node = nid;
> -                               break;
> -                       }
> +       for_each_online_node(nid) {_
> +               if (max_value == cc->node_load[nid])
> +                       node_set(nid, &alloc_mask)
> +       }
>
> -       cc->last_target_node = target_node;
>         return target_node;
>  }
>  #else
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int hpage_collapse_find_target_node(struct collapse_control *cc, nodemask_t *alloc_mask)
>  {
>         return 0;
>  }
>  #endif
>
> -static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node)
> +static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node, nodemask_t *nmask)
>  {
> -       *hpage = __alloc_pages_node(node, gfp, HPAGE_PMD_ORDER);
> +       *hpage = __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
>         if (unlikely(!*hpage)) {
>                 count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>                 return false;
> @@ -958,9 +951,18 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
>         /* Only allocate from the target node */
>         gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>                      GFP_TRANSHUGE) | __GFP_THISNODE;
> -       int node = hpage_collapse_find_target_node(cc);
> +       NODEMASK_ALLOC(nodemask_t, nmask, GFP_KERNEL);
> +       int node;
> +       int ret;
> +
> +       if (!nmaks)
> +               return SCAN_ALLOC_HUGE_PAGE_FAIL;
> +
> +       node = hpage_collapse_find_target_node(cc, nmask);
> +       ret = hpage_collapse_alloc_page(hpage, gfp, node, nmask);
> +       NODEMASK_FREE(nmask);
>
> -       if (!hpage_collapse_alloc_page(hpage, gfp, node))
> +       if (!ret)
>                 return SCAN_ALLOC_HUGE_PAGE_FAIL;
>         if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
>                 return SCAN_CGROUP_CHARGE_FAIL;
> @@ -2576,7 +2578,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>         if (!cc)
>                 return -ENOMEM;
>         cc->is_khugepaged = false;
> -       cc->last_target_node = NUMA_NO_NODE;
>
>         mmgrab(mm);
>         lru_add_drain_all();
> --
> Michal Hocko
> SUSE Labs
