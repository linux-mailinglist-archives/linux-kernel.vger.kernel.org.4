Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E846747F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjATAVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATAVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:21:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317009F38E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:21:02 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 36so2919324pgp.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QyhsRn5OPstDd8tOopiUECeAKD2qFv3oS+wtxEl1Qw=;
        b=iSDvWSA5rlBU7hsDYZ2sJL2EwYssyRlC/LewAV1ffm1T686pJ2LTtUq+NiKA0sjI17
         hz6T1psf7ed69X932TEhFFdJ0iePUhfZVV6vcZIj3cGj0SOyACbSpOGIpPba5pX4LOUt
         lV2CXp9GEVZBQyh+KbdjavIlNAEXBByvqJyxHLx5HA/i+8f/njc2az/QhlRUIMcgM52I
         Q2s7e+V2UtCQMcQD1RVYnzj9xWvAj81wB03ANBKXDUqsCPQyITghZXPjFCOp9TK8FccS
         KOQU5NsJQZmQnUT2y8Vp2vZBjGIyvaw+za7JRZRgPKTa9WOBzsmswqG5+dhUrIRftcW2
         SN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QyhsRn5OPstDd8tOopiUECeAKD2qFv3oS+wtxEl1Qw=;
        b=iOsqUMmy2m8nrUMB5DHJCuhN7NIBN1W0W16gk2KNYUyz9RpAHOfTXgT0m6s2h2rXNz
         ws9X3UohkoW2Nc9zunbEghlrU5LmvI0ovfHDKGfDtbu9OU0aTJHxBU7WQnrsY3MufUkZ
         zqg7PEyxiRBsp1XGFN5bJ15E/GkBUakXsSMU7TyNf/BuPKcUiOihFvNSQSEndZ4+jLxW
         T6WMOLKoHizHM6A2sfZYuqmX1yj6vh5d4PeWJ8BrBj//UNwoSt54KgRmGX/pCTE1LX1a
         KyxkTBJQY+vhDW7O0PdNFhDruaUL1PJSOMHS7sLORrN1HugHgaSPa4kOZjSOcRSmFh5M
         KYug==
X-Gm-Message-State: AFqh2krVjv8TQ+M7qUZoNnMfSlqR7buWYWgzt154ciJcmdp4a23oZE9B
        2eBLyB6ljNBFR03Dcs5Z/hmXcw==
X-Google-Smtp-Source: AMrXdXvfMAk2TbpKh3xyvFhXLjdqCJ0E+tq3u6ok0HR1zHtXrR8ifCiqUX+fx2d0WT/n2ROp+SiIdQ==
X-Received: by 2002:a62:2783:0:b0:581:bfac:7a52 with SMTP id n125-20020a622783000000b00581bfac7a52mr37335pfn.1.1674174061385;
        Thu, 19 Jan 2023 16:21:01 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:6cb1:c443:b416:7d4d])
        by smtp.gmail.com with ESMTPSA id z4-20020aa79484000000b005823b7da05asm9308122pfk.122.2023.01.19.16.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:21:00 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:20:56 -0800
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y8neaPB2y689WKOf@google.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
 <Y8gpfgEXtialPVLk@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gpfgEXtialPVLk@arm.com>
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

On Wed, Jan 18, 2023 at 05:16:46PM +0000, Catalin Marinas wrote:
> Hi Isaac,
> 
> Please cc me on kmemleak patches. I only noticed when Andrew picket them
> up.
Will do, sorry about that.
> 
> What I don't understand is why kmemleak scans such CMA regions. The only
> reason for a kmemleak_ignore_phys() call in cma_declare_contiguous_nid()
> is because the kmemleak_alloc_phys() hook was called on the
> memblock_alloc_range_nid() path, so we don't want this scanned.
The reason is because kmemleak_ignore_phys() is only called within
cma_declare_contiguous_nid(), which is not called for every CMA region.

For instance, CMA regions which are specified through the devicetree
and not constrained to a fixed address are allocated through
early_init_dt_alloc_reserved_memory_arch(), which eventually calls
kmemleak_alloc_phys() through memblock_phys_alloc_range().

When the CMA region is constrained to a particular address, it is allocated
through early_init_dt_reserve_memory(), which is followed up by a call to
kmemleak_alloc_phys() due to this commit:
https://lore.kernel.org/all/20211123090641.3654006-1-calvinzhang.cool@gmail.com/T/#u

I'm not sure if that commit is appropriate, given that reserved regions
that still have their direct mappings intact may be used for DMA, which
isn't appropriate for kmemleak scanning.

In any one of these cases, the kmemleak object is never removed, nor is
kmemleak told to ignore it, so it ends up scanning it later.

> Do you have a backtrace?
Yes:

[   61.155981][   T97] Unable to handle kernel paging request at virtual address ...
[   61.156241][   T97] Hardware name: Oriole EVT 1.1 (DT)
[   61.156243][   T97] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   61.156246][   T97] pc : scan_block+0xbc/0x3c8
[   61.156253][   T97] lr : scan_block+0xac/0x3c8
[   61.156291][   T97] Call trace:
[   61.156293][   T97]  scan_block+0xbc/0x3c8
[   61.156296][   T97]  scan_gray_list+0x130/0x23c
[   61.156299][   T97]  kmemleak_scan+0x408/0x71c
[   61.156302][   T97]  kmemleak_scan_thread+0xc0/0xf0
[   61.156306][   T97]  kthread+0x114/0x15c
[   61.156311][   T97]  ret_from_fork+0x10/0x20

when I looked at the PTE from the page table walk, I saw that the virtual
address mapped to the physical address within a CMA region, and that the
page was unmapped (because of CONFIG_DEBUG_PAGEALLOC).

> kmemleak would only scan such objects if it knows about them. So I think
> it's only the case where CMA does a memblock allocation. The
> kmemleak_ignore_phys() should tell kmemleak not to touch this region but
> it's probably better to just free it altogether (i.e. replace the ignore
> with the free kmemleak callback). Would this be sufficient for your
> scenario?
I agree that freeing the kmemleak object is a better strategy. However,
replacing the call to kmemleak_ignore_phys() wouldn't be sufficient,
as there are other scenarios that would still leave behind kmemleak
objects to be scanned. That's why I ended up freeing the kmemleak object
in a path that is common for all CMA areas.

> I may be missing something but I don't get why kmemleak needs to be
> informed only to tell kmemleak shortly after to remove them from its
> list of objects.
That's a good point, and I agree that it's pointless; ideally whatever
way the CMA region is allocated would not inform kmemleak, and we
wouldn't have to deal with kmemleak.

We could use a flag like MEMBLOCK_ALLOC_NOLEAKTRACE to tell
memblock to skip the call to kmemleak_alloc_phys(), but that wouldn't
work as is, since MEMBLOCK_ALLOC_NOLEAKTRACE is meant to be used as the
"end" parameter for memblock_alloc() and friends. For CMA regions "end"
can be used (e.g. the case where the CMA region is supposed to be
within a certain range).

Perhaps we should change memblock to take MEMBLOCK_ALLOC_NOLEAKTRACE as
a flag under a "flags" argument instead?

--Isaac
