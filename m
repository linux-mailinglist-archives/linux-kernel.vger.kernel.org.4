Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23536668A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAMDXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjAMDXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:23:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487E12AD8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:22:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so22146174plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ngcKWrseeZ8ieZPGSI5yc+wVw014s4M+dXDq0q+e1NU=;
        b=QBMGIKjbibfFvRwjHnJUvzsJVAiF6/D1N5uqA1Pj5fjEJk36si6HBmv2tTear2QweW
         d8v9XV2vNpqIh33PTM+6jJ2ew/Ak2uyCCqqWdZ7We16+W5KS2OUUUjGkzOQensxeh/NQ
         cngqa6M3fXB/AZYmObdmpwdkkynWic/URqqm9v1QP6FMVutWZCzjqUKb0rxXg2opiRmK
         08zEGPtM4BHLM/AuJJAoKhsoaJBziEgYkrrCCs9ofoihmDya4tfJrpKPledEMW0juDvX
         WVkisPYvunyFIb05dfp/YIfcTi0HZyBLXhwcUGhaKcqkhQF7fAphtQvufWKUChPcWSLQ
         Q8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngcKWrseeZ8ieZPGSI5yc+wVw014s4M+dXDq0q+e1NU=;
        b=gZHK01xXEXXStvosCvafn5LNgGIRPZL9CgskiHWAlXzMxTft7ViM4YOgssrh7XdA+h
         RYwwl1E8qvKe2ZEBqwQiYCGUcwrky0LGUOUEonTIlKb57kn8awK4MajTf+/ZEq60Skf5
         UYIzNi0zDfKNVdZXh5zN1M2G/JQ3w6EyKnnwOzpcOGRo1rN68hQKhviTgMqK67PmYUB1
         Vx6KE0Ebg7LDpXNx0keqeeCDC41WvyL0J6MQ3mzMb7wR5NDhPY3y3ypINo6lS1j79Jt6
         STJZ9tsVf+hVdgXAswv2+AwyXrHkFlKSywxKbZK7cxeYIpBupo6YnVOIhRuUYZF1mK/g
         /9lA==
X-Gm-Message-State: AFqh2kpawu5lcVMtszUTKQM3aWn+NX+DFDCFux3BR9sCR6cdilAlSTPA
        k2In11hk+G3CtzOsWax1FIzJD6pq603aOchcbxE=
X-Google-Smtp-Source: AMrXdXu7Fo6SB+QZDsRM8LUO9ntRQpbuABte9Tb1DsogzdE78uq3Ite3GqtNxBYYbTFV/gc6Rr9XLmq/iXoIDDiNqwg=
X-Received: by 2002:a17:90a:aa17:b0:228:e2f3:5e9a with SMTP id
 k23-20020a17090aaa1700b00228e2f35e9amr711910pjq.164.1673580177861; Thu, 12
 Jan 2023 19:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAHbLzkpAVTys9dBSodHBB3ovKhwP8imUsyXy=aPqY5SyXCT7ww@mail.gmail.com> <20230113001037.adqha6lxj7lh75at@box.shutemov.name>
In-Reply-To: <20230113001037.adqha6lxj7lh75at@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 12 Jan 2023 19:22:46 -0800
Message-ID: <CAHbLzkpM3mpOfo_NcH2roJf_WCJZno6CqLvM+FtjLG8d0_fGkA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
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

On Thu, Jan 12, 2023 at 4:10 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Jan 12, 2023 at 10:12:53AM -0800, Yang Shi wrote:
> > > This is totally wrong direction. Or I don't understand the race.
> > >
> > > At this point we already paid nearly all price of of pagetable retraction.
> > > I don't see any correctness reason to stop here, except for the assert.
> >
> > Isn't it possible that collapse_and_free_pmd() clear the pmd which may
> > point to a PTE which maps the COW'ed anon page if this race happens?
>
> No. At this point we have huge page in the place in the page cache and it
> is locked. COW fault would serialize on the page lock.

Aha, yeah, I missed the page lock. So IIUC even though anon_vma is set
there should be not any COW'ed anon pages since cow fault would be
blocked by the page lock. If so I tend to agree with you the lockdep
assert seems unnecessary.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
