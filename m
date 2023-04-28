Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC46F1AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjD1Oyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjD1Oyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342302701
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rDGoa8Biv9isXhriSwC1S7TUpqxCvLwKlp0BiYRMNS0=; b=SMjjx3/koTUwqv/nIpRbiJB0kX
        PKY/HPbpyCGm5ETIGfLpA9Ej0T1vEWE9Ph9Vz8gTX7oK8SJKl9Xm6ku5WWdGA88+OACM1jIAqCxQp
        c3y2I++soKbZmmsPwsTLJDWsbnAS8SEpMRV0OQ8HKQTdzn+87IJqMlBZa08QgLY9pQIxSS3OfL3NX
        MbvwGwUp4p4UGITpqxZIob2nKfd0pYY66t0Y+OSfTUHPkh/I8lSrbIkblM/DN55mh4iWa7lJ5h8uZ
        7armVqJJZFkKBc8SDCqoxwpG/YHC9q/Sms6QBbf2MESN0ER8RvI+XHOh74ONCa3HdXbJnv5CJCD7B
        EFGPkk0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psPUV-004h2B-Dc; Fri, 28 Apr 2023 14:54:31 +0000
Date:   Fri, 28 Apr 2023 15:54:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frank van der Linden <fvdl@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Lsf-pc] Fwd: [LSF/MM/BPF TOPIC] userspace control of memory
 management
Message-ID: <ZEveJ3OmysVDVZ8m@casper.infradead.org>
References: <CAPTztWYAiroY3E8pwB+rnPGA1K9HLhkpQp1Gy9C1dEuS1FhWGg@mail.gmail.com>
 <CAPTztWY49XP-7GDHuvV2fNDCeJzd0vAac6n+rJ9KfWr6cyZ5ww@mail.gmail.com>
 <ZEvVqMtnU142GMEU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEvVqMtnU142GMEU@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 04:18:16PM +0200, Michal Hocko wrote:
> For some reason I cannot find this email in my linux-mm inbox and I
> cannot find it in any archives so let me add linux-mm and lkml again for
> future reference.

Hm, I found it by searching for 'lsf' on lore.kernel.org in the linux-mm
archive.

https://lore.kernel.org/linux-mm/CAPTztWYAiroY3E8pwB+rnPGA1K9HLhkpQp1Gy9C1dEuS1FhWGg@mail.gmail.com/

Here are the other topics I found:

Eliminate vmap/vmalloc lock contention
Reducing direct map fragmentation
Stable process
Phyrs discussion
Live migration over CXL
SMDK MM changes for CXL
Sunsetting buffer_heads
HGM for hugetlbfs
Reducing zombie memcgs
Swap abstraction / native zswap
SLOB/SLAB allocator removal + future SLUB improvements
Session for CXL memory
Memory profiling using code tagging
Cloud storage optimizations
Flexible orders for anonymous folios
VM Memory Overcommit
State of The Page
Userspace control of memory management
IOMAP conversion status update
DAMON Updates and Future Plans
Make BPF memory allocator more robust
Virtual Machine Memory Passthrough
Scalable Pagefaults
Single Owner Memory
CXL Fabric Manager Architecture
Using hardware counters to determine hot/cold pages
Sframe: An orc like stack unwinder
Mm docs
Tracing mapped pages for quicker boot performance

(not all of these are the exact titles used by the authors)
