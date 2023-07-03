Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40D745448
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGCDuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906F12A;
        Sun,  2 Jul 2023 20:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA8F60C89;
        Mon,  3 Jul 2023 03:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB4BC433C8;
        Mon,  3 Jul 2023 03:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688356218;
        bh=qEj62ncmZfQTP482Z1C0r9ym+1Qs+aStxxpgNF4Gc1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1TdrpRzPcDhKHfBKnr24KBKfKB0jMbYfGuDA58L8R6ZYlFNYThe8vbVAt3wbgm6q
         2/zsxLyOJXTmt7l0GrSL36SisC+R6dZM8vG8bPcJ3tmebupJ8ESnf2aPw2RdVyNfeq
         omWvuYL6lAknSeJ863s9ZjKK3fIKv0JRNg6lYvOpFTKgpRZBWyPnB/a2sCPfFEFA1Y
         To+txTBLqdpaGZVrHQncc/+ASMLA0LXy1v75E/MncLJZHpZB5BYALwE6Kmwf1HThX0
         pY5WZhq/F8RR742VW/DQ+E3Y4BPEVK3Z2CZrKwe88vWIamXN4XNevBFuDoPbtZvSlR
         O2IBDHxU/tb8w==
Date:   Sun, 2 Jul 2023 20:50:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] xfs: Remove unneeded semicolon
Message-ID: <20230703035017.GM11441@frogsfrogsfrogs>
References: <20230703012131.47677-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703012131.47677-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:21:31AM +0800, Yang Li wrote:
> ./fs/xfs/xfs_extfree_item.c:723:3-4: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5728
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/xfs/xfs_extfree_item.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
> index cdd8ebb6e7cb..f1a5ecf099aa 100644
> --- a/fs/xfs/xfs_extfree_item.c
> +++ b/fs/xfs/xfs_extfree_item.c
> @@ -720,7 +720,7 @@ xfs_efi_item_recover(
>  				requeue_only = true;
>  				continue;
>  			}
> -		};
> +		}

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  		if (error == -EFSCORRUPTED)
>  			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
> -- 
> 2.20.1.7.g153144c
> 
