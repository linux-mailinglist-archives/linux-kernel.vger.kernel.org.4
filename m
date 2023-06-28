Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFC741908
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjF1TvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1TvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:51:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F01BE9;
        Wed, 28 Jun 2023 12:51:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31297125334so333649f8f.0;
        Wed, 28 Jun 2023 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687981860; x=1690573860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XagGNUSMlZ2YxfStu7vBidTnF8doQVt9/OwIdHD5PeU=;
        b=aI19TtPB0HZxkWtcmWaWHVpCLB2ui/jaTO3L9MOtOyVG6Qhk0SzhtPqrxD9beEfE9Q
         AJmZou1t7QgXMX9u4ZxwxXvVmqf6DTmJt1RHqw9tdJGJ0BiPRzGgV1/jmPAHRiqJlZAO
         rM/kT8pWmG2Okog9HqI1CYcjIjlT/M+q37PCQZe9rz8xYiJFZXAJJHBhEmwQclksggCX
         2T/DJ6Y8UANk3pplycwDea+IddP34eCtjLKGW3kyB4tURv8xyWQLFygi3tK/td7AYHoc
         4bLsqDKBLVrf6zxsNUTCqm/GOK2pKUgfmX0/SF2IHNZsq2optTA7QjeMvoWJVMXjSp0j
         0SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687981860; x=1690573860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XagGNUSMlZ2YxfStu7vBidTnF8doQVt9/OwIdHD5PeU=;
        b=fhKIZ9ZVGDTHNV+UN9itkJ+Aqn4ufiLissY0H86kJ5ijDodDgZ+WFqnsbgcNcuTbuK
         YMwxZbKj1aEkqvDYD0S2LKPWcvYFC2qBhtCMs56t34LTQG5kiV/WtdgVSFNKL0NBDTzi
         7dSHkvhqA9evLx3IQ/zszk+44KvhVKOv9n1Dp1ra3cbdZtXdQOJr/bdy2SLJdoeQWpzd
         6BRdVvq4/pmiHSLorM+cK6xRFZ6/S7eofO7tujM0pjSPT4Dse+LQSIAcuJzn0KvwWBCN
         ilaflQlqoobiXkpH7Du7e4+ibn+ysVcpvKj7zTa7FEJjURxwaESddZFxEavQdpu3jcjl
         Lcgw==
X-Gm-Message-State: AC+VfDxSyM7RczwJWp8SpEsVuIFDuTMDuEF5gSnvPJjcG5yefSDvRNjs
        1U2VzVbNtoumeqtb145xifSGjHN1x3M=
X-Google-Smtp-Source: ACHHUZ4DkdsPnRN96+9fvZ1oe5acppJA1dzDhm0/IZ4Fuc3oQjqtcRtv+UM0Wd74boHlX13ESVfnmQ==
X-Received: by 2002:a5d:49c1:0:b0:314:c16:56a2 with SMTP id t1-20020a5d49c1000000b003140c1656a2mr2592622wrs.14.1687981860200;
        Wed, 28 Jun 2023 12:51:00 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00313de682eb3sm14057138wrp.65.2023.06.28.12.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:50:59 -0700 (PDT)
Date:   Wed, 28 Jun 2023 20:50:58 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
Message-ID: <986f48a6-5ec2-4f69-b1dc-72fe5b7ada77@lucifer.local>
References: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
 <CAHk-=whppqqPdjVOx0mONDFx+JjewZPacionbWCUUFdrfOon-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whppqqPdjVOx0mONDFx+JjewZPacionbWCUUFdrfOon-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:19:42PM -0700, Linus Torvalds wrote:
> On Mon, 26 Jun 2023 at 08:50, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Linus, please merge the MM updates for the 6.5-rc cycle.
>
> Hmm. I have merged this, as pr-tracker-bot already noticed, but I
> found a bug after merging it.
>
> mm/memory.c: __access_remote_vm() is entirely broken for the
> HAVE_IOREMAP_PROT case (ie all normal architectures), because it does
> (skipping the non-HAVE_IOREMAP_PROT case):
>
>         struct vm_area_struct *vma = NULL;
>         struct page *page = get_user_page_vma_remote(mm, addr,
>                                                      gup_flags, &vma);
>
>         if (IS_ERR_OR_NULL(page)) {
>                 [ ... ]
>                 if (!vma)
>                         break;
>                 if (vma->vm_ops && vma->vm_ops->access)
>                         res = vma->vm_ops->access(vma, addr, buf, ...
>
> but get_user_page_vma_remote() doesn't even set vma if it fails!
>
> So that "if (!vma)" case will always trigger, and the whole ->access()
> thing is never done.

Ugh yeah...

This came about because the helper function handles the vma_lookup() case
but obviously we now only bother with the vma_lookup() if the gup_remote()
succeeds.

It's made a little trickier by the fact we warn on !vma if the gup
succeeded, so probably special casing this one makes sense for now.

There's been discussion about eliminating this weirdo thing gup returning 0
but being treated as a not-failure, I will probably try to patch this soon
for the one usecase where it matters (uprobes) and maybe also look at this
whole odd 'special mappings are ok in this one place' thing here.

>
> So that __access_remote_vm() conversion in commit ca5e863233e8
> ("mm/gup: remove vmas parameter from get_user_pages_remote()") is
> entirely broken.
>
> Now, I don't disagree with removing the vmas parameter. I just
> disagree with the get_user_page_vma_remote() helper use here.
>
> I think the minimal fix is to just put the vma_lookup() back in the error case:
>
>     --- a/mm/memory.c
>     +++ b/mm/memory.c
>     @@ -5592,6 +5592,7 @@ int __access_remote_vm(struct mm_struct *mm,
>                  * Check if this is a VM_IO | VM_PFNMAP VMA, which
>                  * we can access using slightly different code.
>                  */
>     +           vma = vma_lookup(mm, addr);
>                 if (!vma)
>                         break;
>                 if (vma->vm_ops && vma->vm_ops->access)
>
> and I'll commit that fix for now. Anybody who disagrees, please holler.
>
>                  Linus

Yeah I think this is the best fix in this case, we're not doing any
additional work since this wouldn't have run in the helper.
