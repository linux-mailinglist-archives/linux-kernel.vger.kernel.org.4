Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76A75F3CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJDGdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDGdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:33:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12A45F56
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:33:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x59so7500077ede.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=40EB989ap/jlDrQk+YofbZyu1M7dTC7R64ohBxLyxpA=;
        b=RsOkXObDHsS5M9vMEVhzww+3TyKqx/fSVGCDzwn8bE2SJ4XBfVjA6DBOfQGzk0vOfm
         HQ+0qf53Nmq469fDycnwgk4jTQzRJLL5TYP40dK1aY0vN/boSw4BspGnC7YpJ/gQzsHX
         R+MCAdiH+c2Cj9/T3yhm3Nd7lZ4mFoLUtPBTV5ckEmHd9HHaE1UGT1ZeZl62hEAIhxf2
         UduvSiya4dHsNzouqM7tTp/5ntrnoxPXgyXa4+Oi/4J8UuPs8OcgkeXox2r34MHV49Sj
         HpZMnq5sB6EM7R3xPyIC62FnKACmCkcjwwcRijsVYyulHdF2dTAiY5tdzCT2oxDOKCgu
         iVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=40EB989ap/jlDrQk+YofbZyu1M7dTC7R64ohBxLyxpA=;
        b=wKAs9ByEXP+2PHVD5tWxqYSzZi35maKJgn2jY8s3G09oNGdfGw04DEmXc8UF4Gw9o/
         QoKUYe9ctSEN7iC2S64hFsaCXU93akNPENKrrabFvB8GactY2GUyEoY9NqcZskahls8v
         KHYcq8QbvsnyvQ4dFk/2Om635IqPjNpUlAGIv9tY0EDK6ngY9Pnn/GUM8J3pgcpb80dR
         BzglJIs/U638oLvjQFFN365REFScC+9uTyCGSBGMkaUs+VDvH9w6C8NcBoAzxY857niX
         uO1bl4GGxUPbgTIC7KH1l4MV7wRJCFE9KN/7fpYXg/IUNUH6q9dxH+eZ8IkyfnHbCiyG
         IO6Q==
X-Gm-Message-State: ACrzQf10TnF5bmAcMCF02uCp7+jPiJDF5HdNTLjkWx21x1RLHsS5MvDt
        ErBPQkX8mJBgiP/tl3DUun4sw3K9QG7ToFIlNVi2hs2a02M=
X-Google-Smtp-Source: AMsMyM7qjXZ5GzHL7UurLoeux8UK9R11Y82SEjMtHPQA+OfQuE9PKKLQuLtlXNFMbrPx6PHtjBbzYpOEOOOG+Qr6WK4=
X-Received: by 2002:a05:6402:11cc:b0:458:f610:8404 with SMTP id
 j12-20020a05640211cc00b00458f6108404mr8166538edw.75.1664865186870; Mon, 03
 Oct 2022 23:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <CAFA6WYN+3inY6MYrMFY0qhmifCYtj_immFMFN6jC1BamQCYGWQ@mail.gmail.com>
 <Yzr+IU2IMkvJQqbu@iweiny-mobl>
In-Reply-To: <Yzr+IU2IMkvJQqbu@iweiny-mobl>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 4 Oct 2022 12:02:55 +0530
Message-ID: <CAFA6WYO3+Mvah+caBkcVkyVtEcTU4vFb=zpWmwbZGWonT+XmhA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Remove get_kernel_pages()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 at 20:52, Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Oct 03, 2022 at 02:55:02PM +0530, Sumit Garg wrote:
> > Hi Ira,
> >
> > On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > get_kernel_pages() only had one caller [shm_get_kernel_pages()] which did not
> > > need the functionality it provided.  Furthermore, it called kmap_to_page()
> > > which we are looking to removed.
> > >
> > > Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
> > > get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
> > > does not have any need to support vmalloc'ed addresses either.  Remove that
> > > functionality to clean up the logic.
> > >
> > > This series also fixes and uses is_kmap_addr().
> >
> > From the above description, I am failing to see the motivation behind
> > this change. Can you elaborate here?
>
> Al Viro found[1] that kmap_to_page() is broken.  But not only was it broken but
> it presents confusion over how highmem should be used because kmap() and
> friends should not be used for 'long term' mappings.
>
> [1] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3@ZenIV
>

Thanks for the background info. This should be part of the cover letter.

> >
> > Also, since you are targeting to remove kmap_to_page(), is there any
> > alternative way to support highmem for future TEE bus drivers?  As I
> > can see higmem being enabled for multiple Arm defconfigs [1] which can
> > also support TEE (an example which already does it:
> > arch/arm/configs/imx_v6_v7_defconfig).
>
> With TEE how are the highmem pages used?  Right now the code does not seem to
> use any user pages.  So I can't really say how this should work.  Why does the
> kernel need a mapping of those pages?

Fair enough, I don't have a real kernel driver use-case for highmem
which is required to be registered with TEE.

-Sumit

>
> Ira
>
> >
> > [1] git grep CONFIG_HIGHMEM arch/arm/
> >
> > -Sumit
> >
> > >
> > > Ira Weiny (4):
> > >   highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
> > >   tee: Remove vmalloc page support
> > >   tee: Remove call to get_kernel_pages()
> > >   mm: Remove get_kernel_pages()
> > >
> > >  drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
> > >  include/linux/highmem-internal.h |  5 +++-
> > >  include/linux/mm.h               |  2 --
> > >  mm/swap.c                        | 30 -----------------------
> > >  4 files changed, 19 insertions(+), 59 deletions(-)
> > >
> > >
> > > base-commit: 274d7803837da78dfc911bcda0d593412676fc20
> > > --
> > > 2.37.2
> > >
