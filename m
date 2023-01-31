Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8268263D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjAaITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:19:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA4EB64
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:19:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so9979301wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UUiUGWz3vdmMVfqN3pDTPr4s3ToqNVUTL21KmoaR0tk=;
        b=Z0UcAZl+eVWrnNncHbrK177R9cMz4F1U+QPq2jD5JfMgySeiDc/bxgmEnJoIyvSaFZ
         zNnKqdprw6h1n5r/gxqsAhrhqllnZNspIlRNcp8Q922GD3MwAL7DTSU/TXpF7xMjV0JK
         pYH87oIjrVCqYUKT5qRf1vxpghS+y/ZkwZnzr5jK5YZkMlfRS+1zL6N61SZAsUpqgeZL
         4iwvu8DPwJ4X/M1yjVFwtyVNsUe+O9CcEYCF+b/KO6qXkuXB6YX7tg0cUukS2cXZql1R
         TbQ1bUkF3ZrGrKtwZVNVnWaKv0X9BIVAQLL3L7mwF55PEPinCN5pGmfaO/91T4sL8C3M
         IxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUiUGWz3vdmMVfqN3pDTPr4s3ToqNVUTL21KmoaR0tk=;
        b=xqtQnlkNXHKeMphk2z84SA/nyk1eFmE8FE39deAhEHPDm3X7F7Qtpxftiir1CsLygJ
         fxolqJNzffBG5Hya9pHmyJ9PgVnFb6QGwT4TkpXkVcd+IjAIHXj2dDlLy/NvTYET9XIT
         iYFrwvc/t08BQ0plGFULaTfLl2X7YRKpc5QiNMdsNZBY7hbkjFDD+tt3CbGREfuoYPu/
         fxrwKd6tX8r2FsiNw37cjGg2xPNOIoX5t9yV8/SQJXlpmuL4uczm/5D9J9JbJ0ahxLnz
         P2Aolkq0CN0B2B0YNs3tgFSc4CuV3IHZzodneuChmVGPRM4uRD99QYjf5FlJDiClniM8
         woKw==
X-Gm-Message-State: AFqh2kqc2FyhUMnWJSG58ba2bvFRprk/BOckJG2sgwOzrybXowCLMrMg
        HwnhqsQDtITJwq/Lh6Pc8+2RS5Oc83ODuAYoOcssImsgbAv3rw==
X-Google-Smtp-Source: AMrXdXtI8boFUmkUmNIjAyODsh9cKED29xKXJ+/yUQhRIasCQrsOg445qvkS2lznT9LG183QyeC/uYNcSYDj/W1zwQ0=
X-Received: by 2002:a05:600c:2e42:b0:3da:f648:9ea7 with SMTP id
 q2-20020a05600c2e4200b003daf6489ea7mr3045488wmf.27.1675153159142; Tue, 31 Jan
 2023 00:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-4-jeeheng.sia@starfivetech.com> <Y9g9XGzF/X3OwXdP@spud>
In-Reply-To: <Y9g9XGzF/X3OwXdP@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 31 Jan 2023 09:19:08 +0100
Message-ID: <CAHVXubh2P5TxdMsbW2TY7NxemSFX81UuvgO9schnTEBvzuAn2Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
To:     Conor Dooley <conor@kernel.org>
Cc:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 30, 2023 at 10:57 PM Conor Dooley <conor@kernel.org> wrote:
>
> +CC Alex
>
> On Fri, Jan 27, 2023 at 05:10:50PM +0800, Sia Jee Heng wrote:
> > Currently kernel_page_present() function doesn't support huge page
> > detection causes the function to mistakenly return false to the
> > hibernation core.
>
> This sounds like a bug & should have a fixes tag, no? I assume for
> whatever commit enabled huge page support...
> We don't support set_memory, which by the looks of things is the other
> usecase for this function, so probably doesn't need backporting.

Maybe add this patch in the Fixes tag: commit 9e953cda5cdf ("riscv:
Introduce huge page support for 32/64bit kernel").

>
> Alex, does this change look good to you?

Yes, just one thing though: what about a pgd_leaf() test? Even if very
unlikely (I see x86 does not even test it), the privileged spec states
it is possible to have a 256TB page.

Thanks,

Alex

>
> > Add huge page detection to the function to solve the problem.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  arch/riscv/mm/pageattr.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > index 86c56616e5de..792b8d10cdfc 100644
> > --- a/arch/riscv/mm/pageattr.c
> > +++ b/arch/riscv/mm/pageattr.c
> > @@ -221,14 +221,20 @@ bool kernel_page_present(struct page *page)
> >       p4d = p4d_offset(pgd, addr);
> >       if (!p4d_present(*p4d))
> >               return false;
> > +     if (p4d_leaf(*p4d))
> > +             return true;
> >
> >       pud = pud_offset(p4d, addr);
> >       if (!pud_present(*pud))
> >               return false;
> > +     if (pud_leaf(*pud))
> > +             return true;
> >
> >       pmd = pmd_offset(pud, addr);
> >       if (!pmd_present(*pmd))
> >               return false;
> > +     if (pmd_leaf(*pmd))
> > +             return true;
> >
> >       pte = pte_offset_kernel(pmd, addr);
> >       return pte_present(*pte);
> > --
> > 2.34.1
> >
