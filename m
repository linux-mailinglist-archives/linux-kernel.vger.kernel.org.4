Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044D69F383
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjBVLiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjBVLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:38:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E9D2597E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:38:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id pt11so9187352pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bB79wAdHOhccgIgKxHO3ngiWb2aGeXlrThCcLMtoIgs=;
        b=lqo8nWk0lOD/+QurxV1b6RQCKg8CoGSWEYqkmaptqTJYyXGZt2JFfCmY+WuwrZg1jc
         xQRnN8/7249VeaSVUsJog6fHrVlhh1vD7RkljWnGNoXLb3jo3LS4Pfx0SHN4GV7mY4CC
         4NlmE+SF0HpUg7wiVj5uqu8ZpeuenI/dfunQsQG02ucWOVn4K2iJ6THBNw0cInrfCkUZ
         53xCRRDFPJpok9RS2yphhnUyuSts9/ICey/nQbXu+0nitYTQdYcT05G14Qxd+SwNJ3Px
         6EqrZRW9dhxSWIU2XLeaElkWcaNLCmIFj6BI0XC1131qr6CG5RRZ8+5mDTirut+HjnEe
         Ep5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB79wAdHOhccgIgKxHO3ngiWb2aGeXlrThCcLMtoIgs=;
        b=5SZ275CY6C2QCmD0N2UzVApWGq3uxKRpkfvZ9OYOoXUA7R1RNMd0vKPeS0S8fM7CVG
         4MlFS/SyQDERMgYpaoqDlOapt1EcWDc3ChDZKpgZaaX6kKdCVCK4m18YThb1hgrKE/mQ
         bkR2NaUoahGmIP9sZ/nt0uEfR4HlHkIqiKNZM5OGIsy1Pc3K0TXdVF4npXUyqleAZ+C2
         U8IPOVgfkN1xwkHnkprrPlO28ktpvjHIOsCgOYFvv238x/z1XCsFWTf3/jLqDXNaqrAy
         UqAX6eiQcPLOSbgqRsBevuOFBuPpMnWQ8uobOXJiTmQGtV6HbtjHZaxyceJ3HYNvr1H0
         dFpw==
X-Gm-Message-State: AO0yUKUQ6hJ4fuXm6yXTlJCMRUDBEaTWwWr67UHlZ/gyc12EEP9mZvCZ
        EcvtAQ9Lb9Obk0s1FVdRPBk=
X-Google-Smtp-Source: AK7set/Qydw0Y+XJumLAea4LHGyqfuuOtp+JieG87R+0HETyteEwAWgHm46CbxzjVMbFiVaPBaLaJQ==
X-Received: by 2002:a17:903:1c9:b0:19a:b683:e11f with SMTP id e9-20020a17090301c900b0019ab683e11fmr10226016plh.27.1677065923435;
        Wed, 22 Feb 2023 03:38:43 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b0019a6cce205bsm398031plq.154.2023.02.22.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:38:42 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:38:37 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y/X+vS6YbFIUNuEw@localhost>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
 <Y7LIPOc/ESmhRzYk@hyeyoo>
 <Y7LsDgMxHh8NHzDY@casper.infradead.org>
 <Y/ODKQFj446+KBSy@localhost>
 <Y/OHC33YLedMXTlD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/OHC33YLedMXTlD@casper.infradead.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:43:23PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 20, 2023 at 02:26:49PM +0000, Hyeonggon Yoo wrote:
> > On Mon, Jan 02, 2023 at 02:37:02PM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 02, 2023 at 09:04:12PM +0900, Hyeonggon Yoo wrote:
> > > > > https://www.infradead.org/~willy/linux/store-free-page-faults.html
> > > > > outlines how I intend to proceed from Suren's current scheme (where
> > > > > RCU is only used to protect the tree walk) to using RCU for the
> > > > > entire page fault.
> > > > 
> > > > Thank you for sharing this your outlines.
> > > > Okay, so the planned scheme is:
> > > > 
> > > > 	1. Try to process entire page fault under RCU protection
> > > > 		- if failed, goto 2. if succeeded, goto 4.
> > > > 
> > > > 	2. Fall back to Suren's scheme (try to take VMA rwsem)
> > > > 		- if failed, goto 3. if succeeded, goto 4.
> > > 
> > > Right.  The question is whether to restart the page fault under Suren's
> > > scheme, or just grab the VMA rwsem and continue.  Experimentation
> > > needed.
> > > 
> > > It's also worth noting that Michel has an alternative proposal, which
> > > is to drop out of RCU protection before trying to allocate memory, then
> > > re-enter RCU mode and check the sequence count hasn't changed on the
> > > entire MM.  His proposal has the advantage of not trying to allocate
> > > memory while holding the RCU read lock, but the disadvantage of having
> > > to retry the page fault if anyone has called mmap() or munmap().  Which
> > > alternative is better is going to depend on the workload; do we see more
> > > calls to mmap()/munmap(), or do we need to enter page reclaim more often?
> > > I think they're largely equivalent performance-wise in the fast path.
> > > Another metric to consider is code complexity; he thinks his method
> > > is easier to understand and I think mine is easier.  To be expected,
> > > I suppose ;-)
> > 
> > I'm planning to suggest a cooperative project to my colleagues
> > that would involve making __p?d_alloc() take gfp flags.
> > 
> > Wondering if there was any progress or conclusion made on which
> > approach is better for full RCU page faults, or was there another
> > solution proposed?
> > 
> > Asking this because I don't want to waste my time if the approach
> > has been abandoned.
> 
> Thanks for checking, but nobody's made any progress on this, that I know
> of.

Thanks for confirmation. then I think it's still worth trying.

> (The __p?d_alloc() approach may also be useful to support vmalloc()
> with flags that aren't GFP_KERNEL compatible)

Is there any possible users of that,
sounds like someone tries to call __vmalloc() in interrupt context or
RCU read-side critical section?
