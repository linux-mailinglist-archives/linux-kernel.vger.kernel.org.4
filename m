Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9626E7DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjDSPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjDSPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30EC6E8A;
        Wed, 19 Apr 2023 08:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 500CB64006;
        Wed, 19 Apr 2023 15:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D6CC433EF;
        Wed, 19 Apr 2023 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681917336;
        bh=44/RLJgBhHOZGIwLNoEJUmann7+cQNh1BW8DCRhpiVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fpvULUDTcguLhzUwAICULq59GIWWlMInlwCFViRFt2x9PLa+OwvIAlS3hESi54gCQ
         jqsglTd8Y3sDnQgsARYtoAB0OJIb2krRW7I0ye1NP+GPorsD+EpE53nheb61j1WEBX
         aBg7FeUghgkj2ZYzvbFU2C8TydV4cUmvOomHOn8wcgv5H5u9TTAJA9vYPr2obDgkdN
         L7zMLeivzdLX11F1DUeCYvmzCIbCnQVp8UtlZhKE067oo58OtxUq5csm7TzEqP2Rbe
         0mkk1vVkAj1mhEqZnMDz38yGtWI/kCVjSSFWBWVZyPMapwrZiozCRFfBgtkGTDBHVR
         VstuiRYTwi9OQ==
Date:   Wed, 19 Apr 2023 08:15:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Linux XFS Development <linux-xfs@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: xfs: Extend table marker on deprecated
 mount options table
Message-ID: <20230419151536.GM360895@frogsfrogsfrogs>
References: <20230419094921.27279-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419094921.27279-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 04:49:21PM +0700, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warning on deprecated mount options table:
> 
> /home/bagas/repo/linux-kernel/Documentation/admin-guide/xfs.rst:243: WARNING: Malformed table.
> Text in column margin in table line 5.
> 
> ===========================     ================
>   Name                          Removal Schedule
> ===========================     ================
> Mounting with V4 filesystem     September 2030
> Mounting ascii-ci filesystem    September 2030
> ikeep/noikeep                   September 2025
> attr2/noattr2                   September 2025
> ===========================     ================
> 
> Extend the table markers to take account of the second name entry
> ("Mounting ascii-ci filesystem"), which is now the widest and
> to fix the above warning.
> 
> Fixes: 7ba83850ca2691 ("xfs: deprecate the ascii-ci feature")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Looks good.  Dave, could you take this through the xfs tree whenever you
push the duplicate #include fixes, please?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  This patch is targeted for next merge window (6.4-rc1).
> 
>  Documentation/admin-guide/xfs.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
> index e85a9404d5c082..3a9c041d7f6c31 100644
> --- a/Documentation/admin-guide/xfs.rst
> +++ b/Documentation/admin-guide/xfs.rst
> @@ -236,14 +236,14 @@ the dates listed above.
>  Deprecated Mount Options
>  ========================
>  
> -===========================     ================
> +============================    ================
>    Name				Removal Schedule
> -===========================     ================
> +============================    ================
>  Mounting with V4 filesystem     September 2030
>  Mounting ascii-ci filesystem    September 2030
>  ikeep/noikeep			September 2025
>  attr2/noattr2			September 2025
> -===========================     ================
> +============================    ================
>  
>  
>  Removed Mount Options
> 
> base-commit: 798352cb25d2c27affbb5c733ed28430057228ca
> -- 
> An old man doll... just what I always wanted! - Clara
> 
