Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160D46A211E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBXSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBXSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:05:49 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00575D452
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:05:48 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id a3so695247vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyhopY4pefshENiUdAPb0DtVuLSFSl8zazR2QNJ67YA=;
        b=m7oQ2Itj+NP4lfSKYKGIJzhhuBkFAkLe2Ip1el5PQYt17EL2tgA059/1/MORPpVBoa
         AjF9CVwGZ5v5e3NO4+FeftcMQ5goSgVzJGRstdUfDvnsWexGhC+OuCygI1qL7fW7g54Q
         KECpjBxs2ilz1hGlpbnsW6oOetU1PiHP3t3HOBMXOaipYSihJMzvRXCpdwy78tX0svfa
         I6ir0ho/YBOqWcUFisC3kQKDtHk2vtz8LtEkxhybJJzxImfDa6UP0clgH9K8NNATLRu+
         wYHidFaVtV6eU/OmxfLq4Frbld4m2sSqH2h6Hc14EiQtVjHrEEpFWvFKCU8rST4qyL7U
         PUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyhopY4pefshENiUdAPb0DtVuLSFSl8zazR2QNJ67YA=;
        b=XPkfD3sKLqVBjcA0U8aoyYjAfReg8o4uHusyw7+LibzEwboXwyrxrH6sT6/9IQI43R
         tzWcn3a41L5XRXIeOhGFG3482KDq1Ae4nhuAMMr6Kirfx3LHK2Z78T844WzuRSBIy+B/
         B88N2aHYghn2JkP4QA3ZBvRz7WGasRtLE5gsAF3q2cIj11MJHcym8tty6rMpGyBlWhgc
         5/wIDf/t/SgcJv7BOso7vJuBApY4YvZEud0k5lgR6j684vd4r6blkhZ+BUav9F8l3Jfh
         zBX9CZBuUdOPNJ2rxYiF3Fp/bhMEbAvoeFriKZWcvskGlqCntdrg83JhVi/2+YtREcCX
         vfLA==
X-Gm-Message-State: AO0yUKUiIcG3s8/7BwRIIgnbmwy9W/xt0XGKJrzPCjmWZe4yeB77dgLu
        +YGNLytQZ4QADMYq9qvY8pxOxInyKqfR1O5bj6th8w==
X-Google-Smtp-Source: AK7set+ir8tH9lQ1a+ZRXdWK3+wx2JsLbDl8NNiXiG7xT/YirHvIn0MJwbvUNpPRewNl+24J4UCttpm0kujABuFmhOI=
X-Received: by 2002:ab0:6ed3:0:b0:68b:716e:ed8a with SMTP id
 c19-20020ab06ed3000000b0068b716eed8amr533401uav.0.1677261947753; Fri, 24 Feb
 2023 10:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-36-jthoughton@google.com> <CADrL8HUNO83XtYKxnrm_iWXweP4Wthy2TiodBZ3Tp=FOVa=ZPA@mail.gmail.com>
In-Reply-To: <CADrL8HUNO83XtYKxnrm_iWXweP4Wthy2TiodBZ3Tp=FOVa=ZPA@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 24 Feb 2023 10:05:11 -0800
Message-ID: <CADrL8HVGFT+pwg1YmJHsADXrUQzYhRiAhQRybTHqW2CjYH0XWA@mail.gmail.com>
Subject: Re: [PATCH v2 35/46] hugetlb: add check to prevent refcount overflow
 via HGM
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Feb 24, 2023 at 9:42 AM James Houghton <jthoughton@google.com> wrote:
>
> > @@ -5397,7 +5397,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >                 } else {
> >                         ptepage = pte_page(entry);
> >                         hpage = compound_head(ptepage);
> > -                       get_page(hpage);
> > +                       if (try_get_page(hpage)) {
> > +                               ret = -EFAULT;
> > +                               break;
>
> spin_unlock(src_ptl) and spin_unlock(dst_ptl) is required here.
>
> I'll make sure there's a selftest that actually makes sure that
> refcount overflowing is handled gracefully for v3.

And this should be !try_get_page(). This hunk was a last-minute
addition to this commit; apparently I hadn't retested fork() after I
made this change. Sorry! The hugetlb-hgm selftest immediately catches
this problem.

- James
