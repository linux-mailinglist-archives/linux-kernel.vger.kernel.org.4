Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16D167966C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjAXLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjAXLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:16:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03DC42DC7;
        Tue, 24 Jan 2023 03:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC63B81150;
        Tue, 24 Jan 2023 11:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF644C433D2;
        Tue, 24 Jan 2023 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674558994;
        bh=VFgWKUXRmBeqnN9+X5YE4oCai3W5xNvHzLxb1SYdmas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2qDdHWYOcHoqzldk1nQ6njv+/5dbLTBti8PUnsfqt7NKFZFbfOJuQpaktg7jf7bS
         aBROW63NBfleI9miL4mP/ezn/PAd5yUQbpyWy5A7bBGjrNSTSho3+ZSJbZBATppiyg
         UsCu7Ao34SWwdBdmtjD77S/odfWOEh6WgcEIIs6kp+NjGS4fFZyicOFKevJDsyP+lg
         jbcyXumk/o9/g9Wp8FsfJWu43GtO4XjnK3z+UweDuLMjICfveJQj2R6kZef7LU2bCI
         3vHxaYd0KBzfEzRCarhI8iaWOfRxrzDmnLACN27E1aWhzjcroZNQJfqE972iSaIGHp
         QIlOoVkD10uuQ==
Date:   Tue, 24 Jan 2023 13:16:20 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v4 1/1] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y8++BJcHgfzuoURl@kernel.org>
References: <20230115184212.996298-1-rppt@kernel.org>
 <20230115184212.996298-2-rppt@kernel.org>
 <bea284c3-fe7c-f55a-449d-07f47a364c1c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea284c3-fe7c-f55a-449d-07f47a364c1c@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:00:07PM +0100, Vlastimil Babka wrote:
> On 1/15/23 19:42, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Add structure, introduction and Nodes section to Physical Memory
> > chapter.
> > 
> > As the new documentation references core-api/dma-api and mm/page_reclaim,
> > add page labels to those documents.
> > 
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> A small bug to fix below?
> 
> <snip>
> 
> > +
> > +Along with the node structures, kernel maintains an array of ``nodemask_t``
> > +bitmasks called ``node_states``. Each bitmask in this array represents a set of
> > +nodes with particular properties as defined by ``enum node_states``:
> > +
> > +``N_POSSIBLE``
> > +  The node could become online at some point.
> > +``N_ONLINE``
> > +  The node is online.
> > +``N_NORMAL_MEMORY``
> > +  The node has regular memory.
> > +``N_HIGH_MEMORY``
> > +  The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
> > +  aliased to ``N_NORMAL_MEMORY``.
> 
> Noted.
> 
> > +``N_MEMORY``
> > +  The node has memory(regular, high, movable)
> > +``N_CPU``
> > +  The node has one or more CPUs
> > +
> > +For each node that has a property described above, the bit corresponding to the
> > +node ID in the ``node_states[<property>]`` bitmask is set.
> > +
> > +For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
> > +
> > +  node_states[N_POSSIBLE]
> > +  node_states[N_ONLINE]
> > +  node_states[N_NORMAL_MEMORY]
> > +  node_states[N_MEMORY]
> > +  node_states[N_CPU]
> 
> Should it be set also in node_states[N_HIGH_MEMORY]?
 
You mean because of the aliasing of N_NORMAL_MEMORY and N_HIGH_MEMORY?
