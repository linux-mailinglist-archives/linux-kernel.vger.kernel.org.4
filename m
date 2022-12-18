Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3C64FED5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLRMMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 07:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 07:12:46 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D350A6174;
        Sun, 18 Dec 2022 04:12:41 -0800 (PST)
X-QQ-mid: bizesmtp70t1671365528ty2do9ap
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Dec 2022 20:12:06 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: ILHsT53NKPgCay+doqSjgGYDcvmOKqmjpjYEJiGb0MHrDMNATU/mizb2BeNtV
        dz35PUxh6RnVFkkJo6gWp4xYAhpMUnD9QgHopfv/dlK2NcNrjik/IiCYllIhhySxxCnkefn
        ZvAFVawg0VXM7YdDfEvENB7B10dYgTc+luTaUULnKc0/QV7h6+CiVxWv1D+TYV8hBCdmYA+
        CfUu+gy66DEsNQ0aNWqgGcOx79b72l1q4fYlOBCj8iB+PSMJ8+62Y36/vfk/o5qaCtpA4op
        Yf2e+zaDDMd3iYuTot3fNUlMKMwdP7doGKWaY5QrighKW45Nyc+HVKfv8T6uQzVB/+xqhUD
        krbdCoLz6otPeeh+ggcSwlHSONbDd/uzgt/OSQcS4XvLBYbT3oCVa/je4nJzg==
X-QQ-GoodBg: 2
From:   gouhao@uniontech.com
To:     42.hyeyoo@gmail.com
Cc:     akpm@linux-foundation.org, cl@linux.com, gouhao@uniontech.com,
        gouhaojake@163.com, iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@elte.hu, penberg@kernel.org,
        rientjes@google.com, roman.gushchin@linux.dev, vbabka@suse.cz
Subject: Re: [PATCH] mm/slab: remove unused slab_early_init
Date:   Sun, 18 Dec 2022 20:12:04 +0800
Message-Id: <20221218121204.27720-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <Y551tFBVcYxPlFlH@hyeyoo>
References: <Y551tFBVcYxPlFlH@hyeyoo>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review, i will fix it in next version patch. :)


Thanks,
Gou Hao
> 
> > so early during bootup.
> > 
> > The only user of 'slab_early_init' was removed in commit
> > '3217fd9bdf00 ("mm/slab: make criteria for off slab
> > determination robust and simple")'.
> > 
> > Signed-off-by: Gou Hao <gouhao@uniontech.com>
> > ---
> >  mm/slab.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 7a269db050ee..ede1f29fd81c 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -220,7 +220,6 @@ static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
> >  static inline void fixup_slab_list(struct kmem_cache *cachep,
> >  				struct kmem_cache_node *n, struct slab *slab,
> >  				void **list);
> > -static int slab_early_init = 1;
> >  
> >  #define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
> >  
> > @@ -1249,8 +1248,6 @@ void __init kmem_cache_init(void)
> >  	slab_state = PARTIAL_NODE;
> >  	setup_kmalloc_cache_index_table();
> >  
> > -	slab_early_init = 0;
> > -
> >  	/* 5) Replace the bootstrap kmem_cache_node */
> >  	{
> >  		int nid;
> > -- 
> > 2.20.1
> 
> Nice cleanup, thanks!
> 
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
