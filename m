Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DA666862
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjALB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjALB1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:27:02 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C732D3C731
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:26:59 -0800 (PST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F1CC83F5E0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673486817;
        bh=VOXBN8i5kfRuwJ8+ArnIDmvhNdf0EfdOOSVNON7rux8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jmlZvyBf2We86IP2xPZB0vYu8ME5dij6uv0kc7D9N7sEII0mdNhNwF7yi7340nnhR
         259TddpMZLE7lJB1ULgBycazIAMnITCXVCSFt6Dlitnd1TXjtGf7Qu+8QL5WGJ8RKc
         89lZfWqYB2Yh7uIxTtWInu4xSh0cnSF/usee1gRnjPWuDgKFKOOE0eJXuxhA1nMFwK
         C1os8m9Qf3aSRAEIUNEcWaPs62DEKRgTr9TZV/WWzWByzDMq9OuXz5wXBACMSPoXDq
         Th8COuQYzDKuf/5X33V8gCMCQUvEiOL6WuZG/N42H21uP5RWjUDKLiRCVUuhKsTmE+
         6ktFU0ZwE6Ptg==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-4c1456d608cso178562797b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOXBN8i5kfRuwJ8+ArnIDmvhNdf0EfdOOSVNON7rux8=;
        b=ymQySmF3xk5LMbix371evFpYUHOtYX1gUY5OxRmSPH9bJt9oNQOkCGLGJ8N83Iv9HE
         myN3RBzpAE8YVHcy+FeiaHCROEm9D4fK2ikUzh0p5A52qSVEG70fBrWwT3qhQO8zynjp
         QfHtNTeyRvoe34IksoDEWU6LPV3Z5box0k3jX1wUThwnNxdQEHkkf6dTKUMpXjE58/q4
         gycRxRyugRF6yTuroZkwc7NO5hqrU4vS26INqROIuYvmHzo1PoePSMMwIuTOpQri9Pxv
         R1E0HP5JoHp2lTKkMc+5yIgkJm5jcB+sOOwUKFhT4zszsrtaoGVJFI7bo53jKogP+p3y
         jmdQ==
X-Gm-Message-State: AFqh2korXQKP2MTjNve1ekv+8GEw+SHq1bIj+Hh6BpKCPb65oyzxu0v/
        iUrT1+3Iyzgs1Whm7CCJGlM/d/4NkqIDNj2NOxq61KZz+4C+inruqgN81IBfaX8J2MDNgTlLgNC
        fd98wE5pLq1DwnE7f4BKsAzJ1aE97hnQh0qVvWe5A/bPUbEdD8luyQwrVvg==
X-Received: by 2002:a0d:c0c2:0:b0:39f:ddab:af27 with SMTP id b185-20020a0dc0c2000000b0039fddabaf27mr1885854ywd.17.1673486816731;
        Wed, 11 Jan 2023 17:26:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsfLuXF28oK7oO5scTXSCkw3oe9fpEjD4HaRq1y34DoYnT+YgNIPTLiiXHdcTvgnLV5aJPDcTfhPRIWYiQZFG8=
X-Received: by 2002:a0d:c0c2:0:b0:39f:ddab:af27 with SMTP id
 b185-20020a0dc0c2000000b0039fddabaf27mr1885849ywd.17.1673486816456; Wed, 11
 Jan 2023 17:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20221230030432.38908-1-chengen.du@canonical.com>
In-Reply-To: <20221230030432.38908-1-chengen.du@canonical.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Thu, 12 Jan 2023 09:26:45 +0800
Message-ID: <CAPza5qc03KLCWJ5u=yFZ3wtKBDHBNvSM44xOTt2AGd9PoRs0Ow@mail.gmail.com>
Subject: Re: [PATCH] NFS: Judge the file access cache's timestamp in rcu path
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch follows the commit 0eb43812c027 but handles the stale cache
in rcu path.
The stale cache will remain in the list's tail if no other users
operate on that inode.
May I ask if this patch has any other concerns or drawbacks that need
to be considered?

Best regards,
Chengen Du

On Fri, Dec 30, 2022 at 11:05 AM Chengen Du <chengen.du@canonical.com> wrote:
>
> If the user's login time is newer than the cache's timestamp,
> we expect the cache may be stale and need to clear.
> The stale cache will remain in the list's tail if no other
> users operate on that inode.
> Once the user accesses the inode, the stale cache will be
> returned in rcu path.
>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  fs/nfs/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index ea1ceffa1d3a..d490d64a9ebd 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -3023,6 +3023,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>          * but do it without locking.
>          */
>         struct nfs_inode *nfsi = NFS_I(inode);
> +       u64 login_time = nfs_access_login_time(current, cred);
>         struct nfs_access_entry *cache;
>         int err = -ECHILD;
>         struct list_head *lh;
> @@ -3037,6 +3038,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>                 cache = NULL;
>         if (cache == NULL)
>                 goto out;
> +       if ((s64)(login_time - cache->timestamp) > 0)
> +               goto out;
>         if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
>                 goto out;
>         *mask = cache->mask;
> --
> 2.37.2
>
