Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33A607284
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJUIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJUIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:37:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040221187A0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:36:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so5394491eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWlggewwQ2CX40hUS4GSRzTQWdVPxQZUeJIdfD+dQpQ=;
        b=LM5zc1Q+qfjdx6E4WnvpByRQACYeR/byOzm7yHhAaReRav7UR15c0zyhwYYND9kkbs
         TQafY1htznkzikqS55d5KyqB8oRR6sQDGWZCGuHI3mqeV6p7oyf8nnvad3/5BdnCr8G4
         I7hO7DvrnbLfDWFTK7dGjKWESGu3cNR1PBHvCkrXQV79/L5X5GTWuXPI8RUz1CLL3oH4
         uXj8fvZOYw1EY4OKEzOGtWMZ46V6hVkTUtpdKrm09BYsa6acK05k34oAMuDhwVyyHY3N
         mjz4F9Xbjd90HNdQwuNhiO4l1DBUiI3Jlmb4kFepvVmLsDHgicRPk1j6QP7iBKIdfHul
         tkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWlggewwQ2CX40hUS4GSRzTQWdVPxQZUeJIdfD+dQpQ=;
        b=1Skavhag8JDLgz+yUAIkrL/AdZRLxiNZySLq7mgE3qdoeceo/jeJNsr8++mbWacB9q
         V6gZMW2Sxd8j1q/GQ9n7+R+wq+DjJ0UhNT8oGFcox48tMBdwAVBUgqnrFZPBZfTre16w
         YB+mE7p+YcSgXMYhtIywsly2xuJx+oBf7IHjxT+kUHVT1fxAkW2wU50Wyoqtyb2jyOu2
         4Vlr+ztJBwICB9y5LYDfkqUjcUGMMgCe8Z0rvhC0QQY3CcwkSSj5148FotqcUnR6bga/
         koo6XYDQs9RngTGiIiWlP/kBgTdQlN6RvBGqt3rVq/oO+Xu7NvV4BkD80FhAoX7j3liY
         GjJw==
X-Gm-Message-State: ACrzQf1YA/OFyi99yn4dhY5qMPeuXJsbgmJVtJA0w235q3tHh7sNfLC0
        ZHqyQ6b9FAqixnhn1sHiRsw=
X-Google-Smtp-Source: AMsMyM559GL9KMPxBwSGFGSi8fj7Y7iF48EDnyiNRRD5154qdFlvaUXoONBbSIUPtqAi5iUkVEqFHw==
X-Received: by 2002:a17:907:3ea7:b0:78d:cb74:3d1f with SMTP id hs39-20020a1709073ea700b0078dcb743d1fmr14781477ejc.483.1666341400762;
        Fri, 21 Oct 2022 01:36:40 -0700 (PDT)
Received: from andrea ([77.89.52.45])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b0078ddb518a90sm11220650ejt.223.2022.10.21.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:36:40 -0700 (PDT)
Date:   Fri, 21 Oct 2022 10:36:35 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
Message-ID: <Y1JaE/ot91Z0KXuC@andrea>
References: <20221019154727.2395-1-jszhang@kernel.org>
 <Y1HZFcBo21SQzXVj@andrea>
 <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +     atomic_set_release(&spin_shadow_stack, 0);
> >
> > Have not really looked the details: should there be a matching acquire?
> 
> I use atomic_set_release here, because I need earlier memory
> operations finished to make sure the sp is ready then set the spin
> flag.
> 
> The following memory operations order is not important, because we
> just care about sp value.
> 
> Also, we use relax amoswap before, because sp has naturelly
> dependency. But giving them RCsc is okay here, because we don't care
> about performance here.

Thanks for the clarification.

I'm not really suggesting to add unneeded synchronization, even more
so in local/private constructs as in this case.  It just felt odd to
see the release without a pairing acquire, so I asked.  ;-)

Thanks,
  Andrea


> eg:
>  handle_kernel_stack_overflow:
> +1:     la sp, spin_shadow_stack
> +       amoswap.w.aqrl sp, sp, (sp)
> +       bnez sp, 1b
> +
> ....
> +     smp_store_release(&spin_shadow_stack, 0);
> +     smp_mb();
