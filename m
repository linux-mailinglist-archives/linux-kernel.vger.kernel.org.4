Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BEF6D2EEB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjDAHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjDAHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 03:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF211A442;
        Sat,  1 Apr 2023 00:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B3860B27;
        Sat,  1 Apr 2023 07:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A2EC433EF;
        Sat,  1 Apr 2023 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680334716;
        bh=K3jsq7d7yI0aBSxu4a3vZPycD2Aw4HuThVUcruzSGvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOapJj24TwSpj1O4a/K1z07Kv6lgVXVRGXrU77hLqiRtHXe+uAEMtxxOHNqV7aukZ
         mueLWP6gjh9VpzoL7fbK788HZB/s6kHbOVFlhieBWb9Cc56d8L/hlcJVKHphYj23q9
         eQh9spAnGAp4vhk7RrBItRj4hYLyRDFcrUas5V5hhUya/GGsW3zPc/cFro4QhQNyv4
         pvKGoGrxiai1/N+rcLSi1jb3y90XXdfVjh6bcJDVgYkSLKDIrJJKtzC5K9E+S6wOme
         uaKxwVCiWeHRq0YlSwEWnPp7ej9y77BYlqUP2zoA/A8fJHSMpr95CzFBNLmYQWdeDw
         2KseV7YgUCu8w==
Date:   Sat, 1 Apr 2023 10:38:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: Physical Memory: Fix grammar
Message-ID: <ZCffcADScYNZM/7Y@kernel.org>
References: <20230331165254.207526-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331165254.207526-1-kim.phillips@amd.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:52:54AM -0500, Kim Phillips wrote:
> it's -> its
> referenced to by -> referenced by
> 
> Fixes: 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introduction and nodes description")
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
>  
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
