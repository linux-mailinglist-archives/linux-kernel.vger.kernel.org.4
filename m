Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2866E76F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjAQUJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjAQUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:06:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C0442EC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:57:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b17so26989565pld.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nO2TVNnVOIEJ9cBerRh0wJxo05XQ3/3OZ+JFJTzT4f4=;
        b=Tw6Xp7D6tk8hzI32VYz9Sh4oZnfuZnHqsPMkI862wFRDvLRDkgYIRiWG2SUrB03U5R
         kSRXWoIa6OM7sBGA2XPn0IpcvSAtl79c0VbYh4UiPJcEZbb9YDLc+fE4O25L4H6ucx3b
         l1MnrlA++X2c1GCtCN4KiQ4phthqiXm5RJ3vviCtHTSHZNYjBdNxPUaUEZMZGwTGOALj
         2x4+O5smSfd0PmewOUe80sYtMLFAbU46lkGlCA6NjckPm7q1V9IZTocrP8Ai4OKgEVTC
         bcV5uqogLcSpcr+ZFXX6PO2oaF7HZUvHZtMw2AhcaP6H0+A0BAtmhnlMbv8scDWieuUe
         H/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nO2TVNnVOIEJ9cBerRh0wJxo05XQ3/3OZ+JFJTzT4f4=;
        b=wBIAcAetnwFdcBSPaJJvwNnNxb4H7DOsOgvPk1bzbroTiseyf+Np9ZAsVDd5dxmNnt
         EbuuAfake9udn7RW7JBkJbZ8B7Ui8K1uwoorLahFLAvHFjq3l8lot/ZhOSXFzwK6/Nme
         ytwvPN4rXYViiab+itMkUQd1Zzh9BomW0CMmGqbUnZ+vemPxzWG7WlJEOg2g/QkkSlVU
         b6NLzbyQQpWnAdX9hc/pZhwHS3pyOGFnfkmvtk50+YcB8y70MKRwv5EIkn3dbxR5L4Kx
         un6AZBzL9ZJDPzLcPnmSH7bHdM3ga+7YHngzAEBiQMO8d4nNh0LjtQ8Bjn+5khPD+282
         gK4A==
X-Gm-Message-State: AFqh2koM9cMQUPdJucfkbx3SktXZuuB8R4NYaipAo8CGwVziVyF58BIn
        twffNbI6DL5VmqO8JFepQ03nSoOsZZlBJanh5eE=
X-Google-Smtp-Source: AMrXdXsoJUSjp9vSRwB9qyAzd4ifSmdDjpF2CC1Viyfn6HGg5LWheC0BYaDOAxx2LX2SbhnOxU1jI0M39osXCRMTpkY=
X-Received: by 2002:a17:90a:2807:b0:219:f1a2:b641 with SMTP id
 e7-20020a17090a280700b00219f1a2b641mr364645pjd.97.1673981878643; Tue, 17 Jan
 2023 10:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com> <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
In-Reply-To: <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 17 Jan 2023 10:57:47 -0800
Message-ID: <CAHbLzkrgz3mV=nt_m6b4MV7bWz2-woOjf27sY0+xB9iFunuBsw@mail.gmail.com>
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

On Sun, Jan 15, 2023 at 11:07 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Fri, Jan 13, 2023 at 08:28:59PM +0100, Jann Horn wrote:
> > No, that lockdep assert has to be there. Page table traversal is
> > allowed under any one of the mmap lock, the anon_vma lock (if the VMA
> > is associated with an anon_vma), and the mapping lock (if the VMA is
> > associated with a mapping); and so to be able to remove page tables,
> > we must hold all three of them.
>
> Okay, that's fair. I agree with the patch now. Maybe adjust the commit
> message a bit?

Yeah, the explanation makes sense to me too. Reviewed-by: Yang Shi
<shy828301@gmail.com>

>
> Anyway:
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>
>
> BTW, I've noticied that you recently added tlb_remove_table_sync_one().
> I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
> good enough to serialize against GUP fast?
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
