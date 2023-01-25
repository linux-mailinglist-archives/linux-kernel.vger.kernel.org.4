Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD667BF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjAYWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjAYWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:09:53 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F7272E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:09:52 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id v17so17589558oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MH+uehTDV7kz/MTGcyymtgii9sBR2MngkUK+puzbRUo=;
        b=bVaFXLYb0tT7c5CIHgg8Nyiv6dvz1JgsjQObGkP4vooWo/wiVUrsFkE8wD3uTVVnkP
         Vcb1Q6/idpM0WM0sCeW2wysod5Rf0L0XeqYD6QUeETKn5i2/K/tAMk9HNxsfX5DS7SOO
         lAXQmL2w+OxWaJnloZIyIV692hrMqy41t+2OsRSzcKpWXnxntTA9YduR2F7/YMRQh1LE
         CdWi0p0GqR1QZF10uZ7EnjG3P2VH3m4nPZ+tSw/1iJvpnryawiP69DJqEC+cLPHesyDR
         d8pCPfRpc6Cz0DDzb9lvpQeuyZogCLVtmapVbFxZ8NNseActPk583Ycom/osOCJvIxDX
         /KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH+uehTDV7kz/MTGcyymtgii9sBR2MngkUK+puzbRUo=;
        b=XrONN/RRcys1yV7+rf3c4jUq8DYZJqx9CgTI/+zbg6g47aeykqnKvEVzjouSV+zhXT
         +/Q9lLJ1JfWhv4nULtd4Lj6AKBPh2hg8PqzwZ3+6E7pWTu4TPXayutsxf7KoBw08llgW
         zElnkB4LSARhkcXqcwGvkQXjA0AnJRkRsYlpHSRlxHBr1N7LUXEfIm3qC0Jo4c1i7KhB
         s3sX2sjyhIx3opmzEgatIAlqkUpuOU4ZBgnmJ62JsEiAGnzAd08F+D8seMA05W5RCrMg
         X7dFsyiNK7EuHHWMDnxh8LF3GfLU1HaaPqxDhN0lbW03QL4hL1rBr4lRA+bqKEKu3Bnz
         8CWA==
X-Gm-Message-State: AO0yUKUqFMegHk6hWXdB5kIziZDSsmokGqmCNMTnXBSYFpJwNst9FgAR
        8m3Vo2rWsxY07AFyU0TPiAFAYw2hrF/aM5VbgwNV7Lfl
X-Google-Smtp-Source: AK7set9hc+RYBpFZVbWsJof+toQKzFpoBhxMc29uic0ru74K/P9h8ToMg0mTgQmo2iqKHbPzbcSOG4IjmisZ2J6DwvE=
X-Received: by 2002:a05:6808:8e7:b0:36f:9df:9343 with SMTP id
 d7-20020a05680808e700b0036f09df9343mr282474oic.112.1674684591554; Wed, 25 Jan
 2023 14:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com> <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
 <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com> <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
In-Reply-To: <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 25 Jan 2023 14:09:40 -0800
Message-ID: <CAOzc2pyV9-wq04NRKVE1vRj7PnRF7g+jSFFj-oKYuZk-t9smBA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 1:29 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.01.23 11:24, David Hildenbrand wrote:
> > On 25.01.23 11:20, David Hildenbrand wrote:
> >> On 24.01.23 02:22, Vishal Moola (Oracle) wrote:
> >>> folio_estimated_mapcount() takes in a folio and calls page_mapcount() on
> >>> the first page of that folio.
> >>>
> >>> This is necessary for folio conversions where we only care about either the
> >>> entire_mapcount of a large folio, or the mapcount of a not large folio.
> >>>
> >>> This is in contrast to folio_mapcount() which calculates the total
> >>> number of the times a folio and its subpages are mapped.
> >>>
> >>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >>> ---
> >>>     include/linux/mm.h | 5 +++++
> >>>     1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index c9db257f09b3..543c360f7ecc 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -875,6 +875,11 @@ static inline int page_mapcount(struct page *page)
> >>>             return mapcount;
> >>>     }
> >>>
> >>> +static inline int folio_estimated_mapcount(struct folio *folio)
> >>> +{
> >>> +   return page_mapcount(folio_page(folio, 0));
> >>> +}
> >>> +
> >>>     int folio_total_mapcount(struct folio *folio);
> >>>
> >>>     /**
> >>
> >> I'm sorry, but "estimated" as absolutely unclear semantics. You could
> >> have a THP mapped into 9999 processes using THP and the estimation would
> >> be "0".
> >
> > ... or would it be 9999 ? What about a PMD-mapped THP? What about a
> > partially unmapped THP?
> >
> > What are we estimating?
>
> Thinking about mapcounts again, might not have been my smartest moment.
>
> What we return here is the precise number of times the first subpage is
> mapped (via the large folio and directly). That's supposed to be an
> estimate for the number of times any subpage part of the folio is mapped.
>
> I really don't know a better name, but folio_estimated_mapcount() does
> not feel completely right to me and triggere dmy confusion in the first
> place ... hm ...

I can understand the confusion, but I can't think of a better name
either myself. I'll go ahead and add a comment to make the purpose
of this function more clear. Looks like I'll have to move it to get rid
of the build warnings/errors anyway.
