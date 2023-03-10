Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491076B3D13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCJK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCJK7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:59:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B36B974;
        Fri, 10 Mar 2023 02:58:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C11B82260;
        Fri, 10 Mar 2023 10:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B94C433D2;
        Fri, 10 Mar 2023 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678445935;
        bh=nyY232ZY2Q5K4pNyA+3/TkUKEbZ7ZEFY5fxylZaIKmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzWjuZYlOZitfbd5zPN6eEJbLRnrEK1rsoZrJNy0xQFPxqOAHgAbZZoHg7mgWkjp8
         1QnG96QPhW1u8FEGaMRpmVNRT/iaf4TNXjvyW85L68ie1bdwIFMv/ZTsyA7tGtR5X0
         /fuHXtGw+Dnw82NpyEFFK/WHCcSCSIsR0K0oI0CskJx2KFv7G7VYgitXKPsryprHZG
         Xsmj+bTcm9T5a9zPpKsFdQ/rfIXz5m2XgSVT5bOfIomyEC1bg1czJP73BWvvtUk0X+
         7Gsl46aEDJY0jNSwlWte5S0W2RmwTL7kqZ//rbMlrjW5cynr1nZe3/gp0PSxV8rhET
         o7r7KoyFuj6Uw==
Date:   Fri, 10 Mar 2023 11:58:50 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     dchinner@redhat.com, willy@infradead.org, viro@zeniv.linux.org.uk,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fsdevel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: remove duplicate include header in xattr.c
Message-ID: <20230310105850.gomiydgm22eoxmxw@wittgenstein>
References: <202303071517050653678@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202303071517050653678@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:17:05PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> linux/xattr.h is included more than once.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---

I mean, yeah, it's included in the local xattr.h file but honestly
reiserfs is marked deprecated and I just don't think that we should
bother with cleaning up things that are _that_ minor. If it was the
compiler complaining about some unused variable then for sure but this
just seems pointless imho at this terminal stage...

>  fs/reiserfs/xattr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
> index 651027967159..ed1984775a4f 100644
> --- a/fs/reiserfs/xattr.c
> +++ b/fs/reiserfs/xattr.c
> @@ -43,7 +43,6 @@
>  #include <linux/fs.h>
>  #include <linux/file.h>
>  #include <linux/pagemap.h>
> -#include <linux/xattr.h>
>  #include "xattr.h"
>  #include "acl.h"
>  #include <linux/uaccess.h>
> -- 
> 2.25.1
