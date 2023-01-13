Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FAF66A28F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAMTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjAMTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:04:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8C149F2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:04:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay40so15892561wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aefGi5CKGy06ur/H5iSM581vFB667NHkUkls7C28CE=;
        b=j9qoVvx95Q0G36LS1hv+G2OpMCR2LhxmdwjfhJHjsyCRxa8bYtxVohJ+LJDFCXplLV
         +SwCoWGqeA6f3HQEgFLU2wPUYUOK8zVztitg1auEWbBxvkdTP3PtkjtmEHbG8kV4C5lv
         tnGkHAdPyAB06LDrz5QvrEasIKThaSjI4T9V31OiPuIqGuu4OrzajPrZX05Oz/ECRkGe
         Dobw7YQhAQKY5sV3SMEEdops7utCVobD3fyfciqhbRH2FlmT/IiYb0B45dJSSjf1zCnB
         zPjJ2Nqy1HVCUF8BM5cKjj3T009B9gNwI6ljkcCe1OgiV2gXdNkXxQWcDojwVCtk8Dv7
         JqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aefGi5CKGy06ur/H5iSM581vFB667NHkUkls7C28CE=;
        b=LIFHJ38oqqjuSzs+uEFAqTf3opcbW2Ji/hCNgSMFctegmramceTEI/bFilnm6d/WmW
         9a7HfNUfMYrsuv55RG2+eDpI9JzkalHbuTb9BGK8rCEPmySN8s85pwyLhPVEPo+V+pqb
         UiBxnTqJMdh33ZwH+RmGHEVNNZGV3aDaM9Es9Clqerd4DhF6CSYrb+A3xlpFb3rBIrdh
         WyJsLsKr3UdxMT2gYcPJDPT0C+64MItyhEBh/CV5BnIyoCQ7Z3AJIBamxZz+qbgv4YRp
         xyLrSpXSRDNJFzor2x/PJuZ8yDK+6aHtoiZ6OMsbyj5CSWjTmClEtpac/euNYFkpbq54
         W/2Q==
X-Gm-Message-State: AFqh2kq2gXQkar51eQvpyXU3vlHqgAHPpvEFVP7fHAk/yNm0ZSCSemDX
        3WyEepUJZCB82TOM7HUaLM8=
X-Google-Smtp-Source: AMrXdXu3FnusR99msMIPAcEj3fbLlYpfns2KUFm0YaRH5hnGqbEIy/d9e0hvLJumhmDiWfWg+9PUrw==
X-Received: by 2002:a1c:7417:0:b0:3da:fcd:7dfe with SMTP id p23-20020a1c7417000000b003da0fcd7dfemr656015wmc.10.1673636656691;
        Fri, 13 Jan 2023 11:04:16 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm28095048wmq.25.2023.01.13.11.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:04:15 -0800 (PST)
Date:   Fri, 13 Jan 2023 19:04:14 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use
 folios
Message-ID: <Y8GrLtwBYSAoxhQl@lucifer>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-6-wangkefeng.wang@huawei.com>
 <CGME20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb@eucas1p1.samsung.com>
 <32fefce6-e25d-106d-12ec-8fc612843cfb@samsung.com>
 <8bbc5629-b89a-83f3-41a4-0083ea2468c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbc5629-b89a-83f3-41a4-0083ea2468c1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:08:36PM +0100, David Hildenbrand wrote:
> On 13.01.23 14:01, Marek Szyprowski wrote:
> > Hi
> >
> > On 12.01.2023 09:30, Kefeng Wang wrote:
> > > The old_page/new_page are converted to old_folio/new_folio in
> > > wp_page_copy(), then replaced related page functions to folio
> > > functions.
> > >
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >
> > This patch, merged into today's linux-next as commit 9ebae00c8e30 ("mm:
> > memory: convert wp_page_copy() to use folios"), causes serious stability
> > issues on my ARM based test boards. Here is the example of such crash:
>
> syzbot is also not happy:
>
> https://lkml.kernel.org/r/000000000000807c7805f2205df1@google.com
>
> --
> Thanks,
>
> David / dhildenb
>

This also completely broke my qemu environment.

In that thread Willy points out that the issue stems from blindly assigning
page_folio(old_page) to old_folio without checking whether it is NULL first,
therefore triggering a NULL pointer deref.

A quick fix would be to put in a check (as shown below) which fixes the issue,
but as Willy said, I think we should drop this until it can be fixed in a
respin.

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3044,7 +3044,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
        struct vm_area_struct *vma = vmf->vma;
        struct mm_struct *mm = vma->vm_mm;
        struct page *old_page = vmf->page;
-       struct folio *old_folio = page_folio(old_page);
+       struct folio *old_folio = old_page ? page_folio(old_page) : NULL;
