Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77A6EA1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjDUC1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjDUC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E1212D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED5B63C15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8479AC433D2;
        Fri, 21 Apr 2023 02:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682044063;
        bh=4JEobs9Do9ZCkbJdX/Ov15UlPaXoUmhwg2v+lomPIJo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gXW8xqMdV47iMCXEZz+YfCuUmAFLSbLmryBulhPqWwkmSauttA/Ih38W/tkOOBEHF
         AVyJeHl0/fPywnEa5i52bmm6L0XYm6zFtrTmq23pFZ2B189fzXr33YZfVVCElga4lO
         TPnFIyRhfa+LTsQ+3pZ7yx4ySmdHV+OQgQKyQagm1jLCTGwURxijfih18dFbo8MS8t
         OFcmGj8nFJ/+3ko4YUadov8QK/rpSVd1eeQxMvXDJEgsgzeAom8oWYRFR7xhOK5yNm
         E/gJzTegvZIGmJKvuf6jKciPuhmhl83QGJ8XexGTxC+YgGgzIlxY4p+NQZfMdiH59z
         qBreWDc5otN/g==
Message-ID: <b031f528-f3dd-44ed-5370-2133a74f9332@kernel.org>
Date:   Fri, 21 Apr 2023 10:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: remove unnessary comment in __may_age_extent_tree
Content-Language: en-US
To:     Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230418060954.67585-1-hanqi@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230418060954.67585-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/18 14:09, Qi Han wrote:
> This comment make no sense and is in the wrong place, so let's
> remove it.
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/extent_cache.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 28b12553f2b3..1f6d7de35794 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -86,7 +86,6 @@ static bool __may_age_extent_tree(struct inode *inode)
>   
>   	if (!test_opt(sbi, AGE_EXTENT_CACHE))
>   		return false;
> -	/* don't cache block age info for cold file */
>   	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
>   		return false;

Should move it here instead of removal?

/* don't cache block age info for cold file */

>   	if (file_is_cold(inode))
