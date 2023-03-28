Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07666CC828
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1QiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1QiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:38:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B03C29
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:37:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c9so6183337lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680021478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjEXwKhaB5uFl3dZxEPaq/b2jJkwiE7Oa0Zac9PN6Gg=;
        b=WqYLaRzed+nRGClW0gY75crY0szDDbGCu0MxN1Js7sqmbP1wHFFUH+F6kjWp9PSyyE
         ayyoqfT1PTylOohJYnFkD8LwDnxGZvwqNm2re+Dh4GP29Q00kFR0zjXpB6TrW3rV3dL7
         //3LBNR/eKLjw2gIa0wrGsJiSrq1LuU+qd5nMOWJHya6dFzA09vGW6p9imlbDRWjFSCH
         d1IvN+euHAASweS0L5e2Ml4gn7c6p6/IkKHNVtgeo0sZEwCbwRgXJESlmoZUfsW+33VJ
         asvz0M8hQeGJLPRCMr6Wgyi9+j1gcBLbFLrbq43vPJ0t8BoWrgWlKjLZ+o1OUHdS/T/Y
         /4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjEXwKhaB5uFl3dZxEPaq/b2jJkwiE7Oa0Zac9PN6Gg=;
        b=yLLgSxHtv1XheQgda9iyrti8tXGwQfSfjBMF+c2EhtFtl+cqFHML/PAVS3hENRzek0
         vDQfoGsoJ4NoEGu5jm09HwQ2yDE0eWb0yutzM3PA8M82robEsldL+77tfthMKoT99WQv
         pw4dNuSj/gPvZ1qCC28hX2TQ5gkmxX1whCmNJQyb4tQzRMf2lHEeTbDB9lxQOnEYG4PV
         LNkS0jiSkGjlqXRrIE9VpVd5G9xN6qBvVkwljm5JBuaKj8ru92z6k9Wfn6683zUJkgcN
         /RQG+pEQ3EoN1qnBmY/GJ79F14nvGE8Q6Wa1hcAcQNFICnSNZ4Q5qnDf3w+o2li0KoUZ
         m/Jg==
X-Gm-Message-State: AAQBX9egqXzCq2oG0xBis4Z1DPE6sqjQG5fDXj5y3jWuZAonxhzBU6VA
        pQXp/s2bsvE1mU5z/spUxXA=
X-Google-Smtp-Source: AKy350ZUW0Z5/3nIfPHhop5lh2NbfUHDBYgNFzm0v995LUfM87WsfU6K6Z0IcTtowV3lO+tgDBAdJQ==
X-Received: by 2002:ac2:5ec6:0:b0:4eb:20e:6aec with SMTP id d6-20020ac25ec6000000b004eb020e6aecmr4743236lfq.40.1680021477918;
        Tue, 28 Mar 2023 09:37:57 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b004db2ac3a522sm5159100lfp.62.2023.03.28.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:37:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 Mar 2023 18:37:55 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCMX45FZgkLR7dBT@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132e2d5c-0c1f-4fff-850c-b3fb084455bb@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  /*
> > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > - * in the free path. Could get rid of this if we change the API to return a
> > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > + * In order to fast access to any "vmap_block" associated with a
> > + * specific address, we store them into a per-cpu xarray. A hash
> > + * function is addr_to_vbq() whereas a key is a vb->va->va_start
> > + * value.
> > + *
> > + * Please note, a vmap_block_queue, which is a per-cpu, is not
> > + * serialized by a raw_smp_processor_id() current CPU, instead
> > + * it is chosen based on a CPU-index it belongs to, i.e. it is
> > + * a hash-table.
> > + *
> > + * An example:
> > + *
> > + *  CPU_1  CPU_2  CPU_0
> > + *    |      |      |
> > + *    V      V      V
> > + * 0     10     20     30     40     50     60
> > + * |------|------|------|------|------|------|...<vmap address space>
> > + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> > + *
> > + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> > + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> > + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> > + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> >   */
> 
> OK so if I understand this correctly, you're overloading the per-CPU
> vmap_block_queue array to use as a simple hash based on the address and
> relying on the xa_lock() in xa_insert() to serialise in case of contention?
> 
Sorry i missed your question. You correctly understood what i am doing.

Basically, we can associate any address with an index in per-cpu-array.
Since a CPU pre-allocates a fixed block size, which is a VMAP_BLOCK_SIZE, 
we can map any address within this block to a certain index or i call
it a specific CPU zone it belongs to.

If we want fully serialize it we have to allocate a new vmap block in
CPU owner zone. According to ASCII picture, for CPU0 it is 0-20, 30-40
addresses. In fact, even though it would be "fully" serialized, in practise
id does not give a visible performance. So this is not needed and it
has extra drawbacks.

--
Uladzislau Rezki
