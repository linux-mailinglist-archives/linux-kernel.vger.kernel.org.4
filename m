Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156B67D3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjAZSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAZSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:19:18 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6585E504;
        Thu, 26 Jan 2023 10:19:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 08A16381;
        Thu, 26 Jan 2023 18:19:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 08A16381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674757157; bh=uUHe/yXy7xcAjN0XD1xm8zwwZxvs4eNmBcGRwrOYI7k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PJSOhdl9GjEzPANxW9cqfUMkasqCiYKqU1VML76NpJnTyTkQSGNNPVWbWOxzHlqh5
         cdfigy3J/rDz484djEK7R7xxLkYpN2HTkN+Pk8sF4iTCSkq/dHZC5EA/8KyxiZSlXQ
         8sT25q7ILoaGAvu5Gwt5pNNR8DJSrfkSESumwXPHrxwgtLbl5yXf+AEJIGEVN0Yxez
         rpGwBuzsxg+pPeaN1NbCKMZTYR81vPS0IM2nXn6hsoeo8VEE/5X3UchdLpjsEso6wI
         ag5362TC3K3hIORUpUBgbWzEV9ADPJv8nZZFGvR2z4DdnLc6Hj/Odp6pIDlp5pjrxF
         YWrQ3lTAkHHiA==
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 1/1] docs/mm: Physical Memory: add structure,
 introduction and nodes description
In-Reply-To: <20230125192841.25342-2-rppt@kernel.org>
References: <20230125192841.25342-1-rppt@kernel.org>
 <20230125192841.25342-2-rppt@kernel.org>
Date:   Thu, 26 Jan 2023 11:19:16 -0700
Message-ID: <87r0vh9n17.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Add structure, introduction and Nodes section to Physical Memory
> chapter.
>
> As the new documentation references core-api/dma-api and mm/page_reclaim,
> add page labels to those documents.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

I've gone ahead and applied this, but I do have one little gripe...

>  Documentation/core-api/dma-api.rst   |   2 +
>  Documentation/mm/page_reclaim.rst    |   2 +
>  Documentation/mm/physical_memory.rst | 347 +++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)
>
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 829f20a193ca..c847a5b0a0d3 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -1,3 +1,5 @@
> +.. _dma_api:
> +

Top-of-file labels like this one...

>  ============================================
>  Dynamic DMA mapping using the generic device
>  ============================================
> diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
> index 50a30b7f8ac3..3fccde066436 100644
> --- a/Documentation/mm/page_reclaim.rst
> +++ b/Documentation/mm/page_reclaim.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. _page_reclaim:

...and this one really just add noise without bringing any value.
Something like:

> +Reclaim control
> +~~~~~~~~~~~~~~~
> +
> +See also :ref:`Page Reclaim <page_reclaim>`.

Can also just be "See also Documentation/mm/page_reclaim.rst".  The
right things will happen in the HTML output, readers of the plain-text
will know immediately where to go, and we don't have to add the label
clutter.

</gripe> :)

Thanks,

jon
