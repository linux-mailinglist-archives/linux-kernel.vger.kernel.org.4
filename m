Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E365C5B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjACSHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjACSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:07:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949AFCE9;
        Tue,  3 Jan 2023 10:07:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66406B8104D;
        Tue,  3 Jan 2023 18:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B02C433F0;
        Tue,  3 Jan 2023 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769264;
        bh=hc462o+l9XpW/Q/bFPST6QDkeqeth8pIAYp1w1HJQZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FP5AbZrEOtmHBHdANpGNCQZKFkyicUUXDoC8ttFDGXEQZsbjbbw5lZDtCGbEJQtty
         AzfSq9qdwxDi0TTM0WTseOGf8Hr6SgGzxztjyRERB4f+MxvN4ZAKWnrlRTcNAMgNPu
         tFCzNN7G1lMXbtKBwYKLmN0Uhhl/XMY0I3WGnDemVSxyJtAjNqDjzoD0B2fzm/BtGl
         d+XycUhOianWlKhN34E5KYZC0A2g8/D0QPLXe/rm5cRUaoaxOEhePVvP2LV0DVCgCf
         f8em16RlUp815HtBBycs5RgH0kTdRshl/dL+Fiso8+xkF0h9wCMN424Km5IyOmbpe9
         LwVm4XHje+pzw==
Date:   Tue, 3 Jan 2023 10:07:43 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: xfs_qm: =?utf-8?Q?remove_?=
 =?utf-8?B?dW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from error
Message-ID: <Y7Ru73JbumMnTEqc@magnolia>
References: <20221223081114.3959-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223081114.3959-1-zeming@nfschina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 04:11:14PM +0800, Li zeming wrote:
> error is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Looks fine to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_qm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index ff53d40a2dae..e2c542f6dcd4 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -68,7 +68,7 @@ xfs_qm_dquot_walk(
>  
>  	while (1) {
>  		struct xfs_dquot *batch[XFS_DQ_LOOKUP_BATCH];
> -		int		error = 0;
> +		int		error;
>  		int		i;
>  
>  		mutex_lock(&qi->qi_tree_lock);
> -- 
> 2.18.2
> 
