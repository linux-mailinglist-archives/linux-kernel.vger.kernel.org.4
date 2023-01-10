Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6849D6639A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAJG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJG7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:59:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9851C916
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:59:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so9044815wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 22:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYD5MyerxPHDgEFU7gYGQqySbkICvj5ul/SHrnuhJgk=;
        b=Npp8rbeuvo8Jz2ry2WSzGJAwmgUsb848J0cnSMQGSOAnAPrqdR4FHDtT32iZtLeGDH
         I/flTR3XtLmfzMgcZJXz8e1DNk996TJxDJKF3312O9JQLrLaESTUoCV1S2u+IyAXsc3Y
         NQlsPt28SQDlnkKZ944o3ubjgg+IwHBzPPnUN9AxZX4MXZ/utiecgpEWMM0YV2fKfY02
         vgij2mNTWxXwEXoBVJMAkMVYpE3wiJ+mS0KeZVhtIwWEusGtkbbP/aWTTt3EPNOdeSDW
         rTRnicWROe7CwpaeHyzzT3zzyNbtxULpEliSar/nEtakfcnbOzaM9Z0icIeA8Ph3Wvlm
         ekMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYD5MyerxPHDgEFU7gYGQqySbkICvj5ul/SHrnuhJgk=;
        b=DG6R7zEZpbhmlZUYu4ryiPb+/rVUR8DkpXzTNuczr5by4tSyN9gX47G3cwwMW4cZTO
         MoJ5w0ajJdmiWE7O3PM/Q4foHNuADYE3BLYR94gxUTsbHbpuTLksZfSViVTozDyt2e9N
         4nn7G8wkD9rTrnKYMjfel0FbQiWScBaFzj+GgNDJpvhHGVfYHBRCmUm+QgHmYCHnvUnT
         5gEoAvx34dIcwRYOVH08n/MgHfh2Ipn65GTbBcm+Lm5VYoHcz3umYE5uL0H4SssmJIrr
         UMGhRREvwSphtv37i6CNRg79gzYGmorPA8qZ50uFKLph/HM7HK6xEnW30IlsvnbPQycW
         gYFg==
X-Gm-Message-State: AFqh2krkY9zUaRNGKd0i3nUhNyUvcYRYlE1d1tELAROeAso0Chtf1vzq
        cyhCxInq+ojc2i+6DNI7hbcggw==
X-Google-Smtp-Source: AMrXdXtPb0KvBQPoN/dxU9m6L2RZsntp6ZmPfrxTFkBPCo2I0aTWvX5XQ2xMI3oFobo0w+Bz6YbzWA==
X-Received: by 2002:a05:600c:4fd4:b0:3d3:4877:e556 with SMTP id o20-20020a05600c4fd400b003d34877e556mr51013210wmq.29.1673333989079;
        Mon, 09 Jan 2023 22:59:49 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm985695wrr.26.2023.01.09.22.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:59:48 -0800 (PST)
Date:   Tue, 10 Jan 2023 07:59:47 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v2 2/3] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Message-ID: <20230110065947.iieuscadlb6veygf@orel>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-3-jeeheng.sia@starfivetech.com>
 <20230109144525.4xgnpeb6zcyyvx4j@orel>
 <62163664add9493db394c8ca45b73ce2@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62163664add9493db394c8ca45b73ce2@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 06:45:19AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Monday, 9 January, 2023 10:45 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>;
> > Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v2 2/3] RISC-V: mm: Enable huge page support to
> > kernel_page_present() function
> > 
> > On Mon, Jan 09, 2023 at 02:24:06PM +0800, Sia Jee Heng wrote:
> > > Currently kernel_page_present() function doesn't support huge page
> > > detection causes the function to mistakenly return false to the
> > > hibernation core.
> > >
> > > Add huge page detection to the function to solve the problem.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > > ---
> > >  arch/riscv/mm/pageattr.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > > index 86c56616e5de..73fdec8c0a72 100644
> > > --- a/arch/riscv/mm/pageattr.c
> > > +++ b/arch/riscv/mm/pageattr.c
> > > @@ -221,14 +221,20 @@ bool kernel_page_present(struct page *page)
> > >  	p4d = p4d_offset(pgd, addr);
> > >  	if (!p4d_present(*p4d))
> > >  		return false;
> > > +	if (p4d_leaf(*pud))
> >                       ^ p4d
> > 
> > I guess you got lucky with the stack garbage in your testing.
> You are right. But the reason it is added here is because kernel page table walk is checking for the p4d_leaf as well. 
> For example: walk_p4d_range() in the mm/pagewalk.c. So, I just trying to make it consistent to the Kernel page table walk mechanism.
> Should I remove it?

The only thing I see wrong with it is the use of the uninitialized
pointer. Just change 'pud' to 'p4d'.

Thanks,
drew

> > 
> > > +		return true;
> > >
> > >  	pud = pud_offset(p4d, addr);
> > >  	if (!pud_present(*pud))
> > >  		return false;
> > > +	if (pud_leaf(*pud))
> > > +		return true;
> > >
> > >  	pmd = pmd_offset(pud, addr);
> > >  	if (!pmd_present(*pmd))
> > >  		return false;
> > > +	if (pmd_leaf(*pmd))
> > > +		return true;
> > >
> > >  	pte = pte_offset_kernel(pmd, addr);
> > >  	return pte_present(*pte);
> > > --
> > > 2.34.1
> > >
> > 
> > Thanks,
> > drew
