Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B16B9F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCNSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCNSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:54:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B1241EA;
        Tue, 14 Mar 2023 11:54:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A9BC823;
        Tue, 14 Mar 2023 18:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A9BC823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678820059; bh=9Hfev68TIRE+irGbGmkJIGO/7nqwRrb/dbXlbnlfSvc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JPAGm/5ViD4jwhgPTWL//C1WiqyvJ+feaSQojHr8YO8sQo/Fyt5jsZ7+fFliyVB1y
         UZlVHX8+mVlTBCc1htWkn6X1oiC5Zo9AIFeHno4htVKHonAKT76eK6HOyfmV7vj8/U
         SWqIwnPuu5NrPG3cP81QkkNhSOeGGKClDln+wLZgwSaFjrkWOjvcDZ41pszuU5Y8Q2
         j6Tp3MUS47PvSEUfg9QhvZNS8IFoKIqEYOtU3Daiw0gZtYrCmQS5vzDaWQf267CQeO
         RyFrEH0CERe8GWe1A8pY8rX7+bs5TwiBKc5AsWgh+gsGlBu9NJHEM84PXXhBDH4hOJ
         HuVOyIEnelZhA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] docs/mm: Physical Memory: add example of
 interleaving nodes
In-Reply-To: <20230213154447.1631847-1-rppt@kernel.org>
References: <20230213154447.1631847-1-rppt@kernel.org>
Date:   Tue, 14 Mar 2023 12:54:18 -0600
Message-ID: <87o7ovqi3p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Add an example of memory layout with interleaving nodes where even memory
> banks belong to node 0 and odd memory banks belong to node 1
>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>
> v3:
> * Fix typos and wording (Matthew) 
>
> v2: https://lore.kernel.org/all/20230212095445.1311627-1-rppt@kernel.org
> * Wording update (Bagas)
> * Add forgotten Suggested-by
>
> v1: https://lore.kernel.org/all/20230211102207.1267058-1-rppt@kernel.org
>  Documentation/mm/physical_memory.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied (finally).  Thanks and apologies for the delay,

jon
