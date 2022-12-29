Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E15658DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiL2OWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiL2OWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:22:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81B1277B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:22:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso23101224pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAZjrTEycnkrvx/nvtQaXpsT4YZfiiYq97FiKf73vmU=;
        b=PnR3c9s3SziqlQAoe6sq7da0dTiUqeWZbvtDIfl0O5cUKM35WNKo0RBDqVgqM/acUT
         FloGbpl5hiu5JyNBjeHuXlTtT0bGarkzFeoIrGkiJos1DA1O648oi1F3zAnwYsBNkicY
         cKb2pWuLWWBPMnVLKjJjuSLt+L8l+nuxo3TDplA4r3WZmkFfRsB75dIg8MgC//yak2F3
         oSgBVTnkqbIOXrfrd0ZEbSH6xyx15rr+EgqOCDiR2yjRrqmTn8kA6f4BPHzJ3AM5t/Jn
         ibPiY78F/VyWwQnOM0sMCF5aAuZcs2ELVwgaaQPwipWDmSKxdJwvPZSwzmnSrAfDp/tM
         8Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAZjrTEycnkrvx/nvtQaXpsT4YZfiiYq97FiKf73vmU=;
        b=AsUFzNdNXqcQz0DeTHRspwQGxUDr96tK5kKHTguE+VAK8iiME7F2jqsJvwUe33aDZj
         +b9QM7Q8Dcev+kG06SXDYWaLh9LkX03k12wa1yXbE48rL1uWv0at91p6/+NY9XkWiGBA
         Mnc2e/0Kg5QjpW8XfOIZgoeA2I5J3Cwr7I06VGIAHqX+Vk8mbceHZN0LwH/Cho8andzl
         IkpF31ulpCtQiZRrJQGpbMpiNi337hSQfBZ6pNt7WzWdkXzmpBKbTajwNeZGsa2jThuD
         CnqkX0qh+6VM6eFJ1aT/E1IKMzu+8g8Tx89WPLup3H8lrbIoukiYbioxyl2x4FVITBi0
         q1lA==
X-Gm-Message-State: AFqh2koUU0njo3M/E06VMKiLZsuBf1WlMeUbmaIcgf5M48ZMMLMBWiwC
        DKRHUo1UDPjvqTqvxmpnpHI=
X-Google-Smtp-Source: AMrXdXvewYOsHvJSxyOsd1Sb9F2ZuDNon7RPE5qX2tZ93c3HkySt+cQA2/dAK/IKEMBd5xxZydMztg==
X-Received: by 2002:a17:902:9f87:b0:189:b0ff:e319 with SMTP id g7-20020a1709029f8700b00189b0ffe319mr29567730plq.58.1672323754752;
        Thu, 29 Dec 2022 06:22:34 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b00183c67844aesm12976733plg.22.2022.12.29.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:22:33 -0800 (PST)
Date:   Thu, 29 Dec 2022 23:22:28 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y62ipKlWGEbJZKXv@hyeyoo>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6ysHNPvKayTfeq8@casper.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 08:50:36PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 28, 2022 at 09:48:51PM +0900, Hyeonggon Yoo wrote:
> > Hello mm folks,
> > 
> > I have a few questions about the current status of mmap_lock scalability.
> > 
> > =============================================================
> > What is currently causing the kernel to use mmap_lock to protect the maple tree?
> > =============================================================
> > 
> > I understand that the long-term goal is to remove the need for mmap_lock in readers
> > while traversing the maple tree, using techniques such as RCU or SPF.
> > What is the biggest obstacle preventing this from being achieved at this time?
> 
> The long term goal is even larger than this.  Ideally, the VMA tree
> would be protected by a spinlock rather than a mutex. 

You mean replacing mmap_lock rwsem with a spinlock?
How is that possible if readers can take it for page fault?

> That turned out
> to be too large a change for the moment (and isn't all that important
> compared to enabling RCU readers)

Yeah, better to take one step at a time.

> 
> > ==================================================
> > How does the maple tree provide RCU-safe manipulation of VMAs?
> > ==================================================
> > 
> > Is it similar to the approach suggested in the RCUVM paper (replacing the original
> > root node with a new root node that shares most of its nodes and deferring
> > the freeing of stale nodes using RCU)?
> > 
> > I'm having difficulty understanding the design of the maple tree in this regard.
> > 
> > [RCUVM paper] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf
> 
> While I've read the RCUVM paper, I wouldn't say it was particularly an
> inspiration.  The Maple Tree is independent of the VM; it's a general
> purpose B-tree.

My intention was to ask how to synchronize with other VMA operations
after the tree traversal with RCU. (Because it's unreasonable to handle
page fault in RCU read-side critical section)

Per-VMA lock seem to solve it by taking the VMA lock in read mode within
RCU read-side critical section.

> As with any B-tree, when modifying a node, we don't
> touch nodes that we don't need to touch.  As with any RCU data structure,
> we defer freeing things while RCU readers might still have a reference
> to them.
> 
> We don't necessarily go all the way to the root node when modifying a
> leaf node.  For example, if we have this structure:
> 
> Root: Node A, 4000, Node B
> Node A: p1, 50, p2, 100, p3, 150, p4, 200, NULL, 250, p6, 1000, p7
> Node B: p8, 4050, p9, 4100, p10, 4150, p11, 4200, NULL, 4250, p13
> 
> and we replace p4 with a NULL over the whole range from 150-199,
> we construct a new Node A2 that contains:
> 
> Node A2: p1, 50, p2, 100, p3, 150, NULL, 250, p6, 1000, p7
> 
> and we simply write A2 over the entry in Root.  Then we mark Node A as
> dead and RCU-free Node A.  There's no need to replace Root as stores
> to a pointer are atomic.

Thank you for explaining things in an easy and intuitive way.
Okay, I get it's not a big problem to update the value(s) in a
B-tree in RCU-safe way.

> If we need to rebalance between Node A and
> Node B, we will need to create a new Root (as well as both A and B),
> mark all of them as dead and RCU-free them.

-- 
Thanks,
Hyeonggon
