Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86F36EB233
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjDUTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjDUTUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB191BDB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA9B2652A0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 19:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCA5C433D2;
        Fri, 21 Apr 2023 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682104844;
        bh=wWIVV152heDSTzGxHtKa1x8+4IzsoyUehlTc8SPXpR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQdgmTqgPqnhOS0oj1RMYI3mGHcsg1Hx5B4RzKQHRComC2VLxhZUhMgCuxAADdNrW
         0T3S3dnz+rl77xP8U5SAGNgmOUkrzp0JtTZdjmbbRlh+zANXO2PNAADL4nuQN/4hSP
         UxuzdPBkFJdFDhNmGR9VEY5+RJz8Hg6VboOP9dtfXrheKVWpR51liALk1XG332pQ8l
         UoCow/DGF/WES57XGj9YoOBrmDfNIv4p1F7fxFDiidQ5Z4ADpGdl8Co30sZVxXUtoZ
         TAIGuhx9NkRM+WeM88PRcKHy/ZR3gJpGccEAcQ4B8kROiX6+GgOsP+95FRcv2N+1dQ
         EB52MWCrG4+Bg==
Date:   Fri, 21 Apr 2023 12:20:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: remove unnessary comment in __may_age_extent_tree
Message-ID: <ZELiCve2x31uJFhM@google.com>
References: <20230418060954.67585-1-hanqi@vivo.com>
 <b031f528-f3dd-44ed-5370-2133a74f9332@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b031f528-f3dd-44ed-5370-2133a74f9332@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Chao Yu wrote:
> On 2023/4/18 14:09, Qi Han wrote:
> > This comment make no sense and is in the wrong place, so let's
> > remove it.
> > 
> > Signed-off-by: Qi Han <hanqi@vivo.com>
> > ---
> >   fs/f2fs/extent_cache.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 28b12553f2b3..1f6d7de35794 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -86,7 +86,6 @@ static bool __may_age_extent_tree(struct inode *inode)
> >   	if (!test_opt(sbi, AGE_EXTENT_CACHE))
> >   		return false;
> > -	/* don't cache block age info for cold file */
> >   	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
> >   		return false;
> 
> Should move it here instead of removal?
> 
> /* don't cache block age info for cold file */

Not worth to comment this, as the code is exactly saying that.

> 
> >   	if (file_is_cold(inode))
