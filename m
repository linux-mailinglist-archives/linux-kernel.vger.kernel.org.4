Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD236B340E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCJCLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJCLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:11:49 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFEA10338F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:11:48 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id s23so2568506uae.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 18:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678414307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1ZsUGvFonlvfiaKRCYmvwX8nStrpniuXEAne8WWDIM=;
        b=O3xAfPERsyzsNSvO01xPE65zentXGd2nG7NUqhE0yBIRYNcaGFZSkgW3QxM29rECZA
         OoMTpIwEAsxqA36+6avufnu6Gd6Gj9KzzLYc5ghpEfcNKhfcFCxIsvSU7TZB3tlLDZlV
         odT/bZWIRVsao5k1sX9JzDL+QqdCG5briNn5ouMY/SAcRHVQ4k2+WCz3TJ2Bpf3z0oNc
         iBk9gvf5rvlHYs5mpZWFhY51cDg4+kBTPXcGhfKI63U31sycVQZ0GS+vgznShoXquuXH
         hvUnBqj8NqRngpWNfhaZPCkxOtj0zYjr5Y3ysw1NXSrOzxjlMbyMHbWsbhwDp0fur8os
         75mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1ZsUGvFonlvfiaKRCYmvwX8nStrpniuXEAne8WWDIM=;
        b=WJmxLhS5hSDKie8GNLCdo276Z7Eb7ZUs270pabZa69/VOjVKsJ1lYSUPyX7JEe9vwf
         1i2VINhPpT4yfmGoSQLizY7XEK4FS0YrZsJprgahJGMonWR2fzSudC9jdGC++VWZUa2R
         SRYqu/bzH4dOPpqPaBTG6ZHjvgK7OC096DwZyU46l/7ShVO9ikqM7ZUF30qNxSLweYPZ
         Rob6swoF9XxzkJXx+XeqFiiWtnMH/GSkeKJO1h5G1WW1CExXQIj0aWjsoWtwNW+DwIXW
         tEHJthiydrg4tyuRDLf+zOd9Twl1yIfuksEFIxlv/vjnfkGCxPHfda29fB46iBa3t7JA
         C4oQ==
X-Gm-Message-State: AO0yUKW04RrpBGd6vS01O0baEBsbH5iKRmgHHSCu+FkWVj4sHllLvhpm
        cw5c/cU3HmB2sDpvpnJvR8GSxT7fbi51DAeTNBKaj4Jiwf4=
X-Google-Smtp-Source: AK7set8TqLUo956ZgPJDxKn7zpXxM6OoLfeyEV9el2lMME8YonUJpyAVx/FV+jx1YF+vPKIcOm/498ZnFK2IsZQjk6M=
X-Received: by 2002:ab0:14c5:0:b0:67a:2833:5ceb with SMTP id
 f5-20020ab014c5000000b0067a28335cebmr241041uae.0.1678414307110; Thu, 09 Mar
 2023 18:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
 <af90fea4-5fa1-de7b-b80e-02fa8753b0fb@arm.com> <05fb17c7-397b-5b33-fbfa-df3bf48b0de8@linux.intel.com>
 <9a88b12e-7169-7c7f-09a1-eef86f75891c@arm.com>
In-Reply-To: <9a88b12e-7169-7c7f-09a1-eef86f75891c@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 10 Mar 2023 10:11:10 +0800
Message-ID: <CAAfSe-vS0RatEQmDXutYjOMC50j1jo3s5r8QyrFCQqc_Ok1M6Q@mail.gmail.com>
Subject: Re: [PATCH V2] iommu: sprd: release dma buffer to avoid memory leak
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, 9 Mar 2023 at 19:23, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2023-03-09 02:50, Baolu Lu wrote:
> > On 3/8/23 8:37 PM, Robin Murphy wrote:
> >> On 2023-03-08 03:41, Chunyan Zhang wrote:
> >>> Release page table DMA buffer when the IOMMU domain is not used:
> >>>
> >>> - Domain freed.
> >>>
> >>> - IOMMU is attaching to a new domain.
> >>>    Since one sprd IOMMU servers only one client device, if the IOMMU has
> >>>    been attached to other domain, it has to be detached first, that's
> >>>    saying the DMA buffer should be released, otherwise that would
> >>>    cause memory leak issue.
> >>
> >> This is clearly wrong; domain resources should only be freed when the
> >> domain is freed.
> >
> > Agreed. Perhaps, in the attach path:
> >
> >      if (!dom->pgt_va)
> >          dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size,
> >                  &dom->pgt_pa, GFP_KERNEL);
> > ?
>
> Why? dom->pgt_va will always be NULL if dom->sdev is NULL, and once

Yes, I also found this. I'm going to remove the check of dom->sdev
that will make reattching being allowed, like you mentioned below, in
the next version.

Thanks for your comments,
Chunyan

> dom->sdev is set then that allocation is not reachable (of course this
> means the driver also has a separate bug where reattaching to a
> previously-used domain will erroneously fail, but that's not a memory
> leak as such). The only thing to recognise here is that the allocation
> is logically not part of the .attach_dev operation, but really a one-off
> deferred part of .domain_alloc, and thus it should be balanced in .free,
> not anywhere else.
>
> Thanks,
> Robin.
