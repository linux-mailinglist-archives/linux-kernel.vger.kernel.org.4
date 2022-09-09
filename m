Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729475B30D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiIIHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiIIHrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:47:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61CF22F5;
        Fri,  9 Sep 2022 00:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2AFAB82375;
        Fri,  9 Sep 2022 07:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E339C433C1;
        Fri,  9 Sep 2022 07:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662709381;
        bh=N+Axj+FjbVzd8ErtqnN4mfMXKL0B/2BjdxLqt3zHLTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SN0Jwq78I3I8iq3BfZwMEvPce7e04BeP5WPjSG+yXLIKprJVCk7RA3eYoYfR6ofq8
         YGicLSd7xe70CzfYhlg4ZuCOZs+9niWpJ68EouTeeGUMVl8QiRFSVi7PgnHdrhaRgB
         LArPGZUO0WwCuicrriA7mzNv0gjXn5usP4GIhrJRRPMaQISqqx8iFms6LqFruA060Z
         48Y+cSn7k6gucOH2lGkn74cVdnmIUU3lWDRy+4fXKYTq5RuSG2N8svTUWpSD+sgVE5
         iqlZZMXj0m50LvEalbsD4VS+k6LNlLCf/Z3i8xcdPUcX8fXXCb00PJiskqqlUKg6z7
         6QkBP2JG3d+pg==
Date:   Fri, 9 Sep 2022 09:42:56 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: remove xfs_setattr_time() declaration
Message-ID: <20220909074256.wbmqgvohmkxefvmb@andromeda>
Mail-Followup-To: Carlos Maiolino <cem@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>, djwong@kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5ULHhpqphBoOnMKjmfB_koRPr8gBCbu0c-YxXp0hWk_bW7qfDW1s_UDSEf9DgGb6e44nKcEmuQyZiD5rLWiKOQ==@protonmail.internalid>
 <20220909065654.1156896-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909065654.1156896-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:56:54PM +0800, Gaosheng Cui wrote:
> xfs_setattr_time() has been removed since
> commit e014f37db1a2 ("xfs: use setattr_copy to set vfs inode
> attributes"), so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  fs/xfs/xfs_iops.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
> index cb5fc68c9ea0..e570dcb5df8d 100644
> --- a/fs/xfs/xfs_iops.h
> +++ b/fs/xfs/xfs_iops.h
> @@ -13,7 +13,6 @@ extern const struct file_operations xfs_dir_file_operations;
> 
>  extern ssize_t xfs_vn_listxattr(struct dentry *, char *data, size_t size);
> 
> -extern void xfs_setattr_time(struct xfs_inode *ip, struct iattr *iattr);
>  int xfs_vn_setattr_size(struct user_namespace *mnt_userns,
>  		struct dentry *dentry, struct iattr *vap);
> 
> --
> 2.25.1
> 

-- 
Carlos Maiolino
