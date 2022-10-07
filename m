Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC05F7E54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJGTxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJGTxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19374108DC9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9ADB61DD6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED060C433C1;
        Fri,  7 Oct 2022 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665172387;
        bh=PENtVLSLbiMvy0AAtehW1kggCRKgDaYMKZHZoM9+Vdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltORIGbljggxbdAPNQySO1DRrywvHVu7yxodCVDsxWzswzGUZ3xX+2Hn5cEAXTSX8
         qPcqXjS9SO4oWMC4+wBwYelb0QikSeg6vfDTmjQh302+58Mx+igIbQcu7NIBUH7A2R
         gR1ZrvJwne54pxwYe6gQ/+E55y4NDPMG7KiO12svM0QJXBdcVwzA4AeMiWbX9rpXJ/
         wu4Mh6XJzrkrU27B7oNTuFnV0KsYQ5EaaO2t7LMuYvdAl+LGDS/elYYUN7WZiduvL8
         pkderRzlTEwM8MYa91grPf+1roiDsobHXecQBlNF7c7PEcqUpHtEi47QHVdDHS/pX4
         zQp7azdleOmPg==
Date:   Fri, 7 Oct 2022 12:53:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix compile warning
Message-ID: <Y0CDoWiaGKHkmnzQ@google.com>
References: <20221006151428.57561-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006151428.57561-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merged into the original patch.

On 10/06, Chao Yu wrote:
> fs/f2fs/super.c:3886:6: warning: no previous prototype for 'f2fs_record_stop_reason' [-Wmissing-prototypes]
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fad333881ea2..2908d41ed462 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3884,7 +3884,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
>  	spin_unlock(&sbi->error_lock);
>  }
>  
> -void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
> +static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>  	int err;
> -- 
> 2.36.1
