Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747E6DCDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDJWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDJWn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:43:56 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E81BDB;
        Mon, 10 Apr 2023 15:43:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0692D7DA;
        Mon, 10 Apr 2023 22:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0692D7DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681166635; bh=gkS9KbPedImrDMUJIjGSTAwqfmBYe3xmj/ydYeKdk84=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oRQ6FM1D+yM7FQ719X7cgQHRefviYSxMcx6qVsMEYbrNC6vN3ZiZ5vbMFR1DiulaF
         ipfgFP0NhohanjWdS4S2Abd8KEj+CwZXRKLNzsra4aYNQTLO2hi1l25azBvvlY9VBx
         J2lhycmMOxztPL20yE59FO3VAj0JiNhUKWbb19ZNpkjJVNcVfdga0cHD1cyojKLxcM
         6WTCHki4rXMg1or3e/VGbPeWUb+G1sAhe0pfyEmsYLtu5R2k7DLTnGnCcNdHPip+oW
         IOaajIP0qdpOMLwuzDBqJOAbXQbvNCh6akh/vmaiNdQ4Eb2YTVlnIsXrJxyevK0Ohd
         HADXnSjvVFMCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kim Phillips <kim.phillips@amd.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] docs/mm: Physical Memory: Fix grammar
In-Reply-To: <20230331165254.207526-1-kim.phillips@amd.com>
References: <20230331165254.207526-1-kim.phillips@amd.com>
Date:   Mon, 10 Apr 2023 16:43:54 -0600
Message-ID: <87ttxncq8l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Phillips <kim.phillips@amd.com> writes:

> it's -> its
> referenced to by -> referenced by
>
> Fixes: 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introduction and nodes description")
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  Documentation/mm/physical_memory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 1bc888d36ea1..df2ed81e3639 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -19,7 +19,7 @@ a bank of memory very suitable for DMA near peripheral devices.
>  
>  Each bank is called a node and the concept is represented under Linux by a
>  ``struct pglist_data`` even if the architecture is UMA. This structure is
> -always referenced to by it's typedef ``pg_data_t``. ``A pg_data_t`` structure
> +always referenced by its typedef ``pg_data_t``. A ``pg_data_t`` structure
>  for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
>  ``nid`` is the ID of that node.

Applied, thanks.

jon
