Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF55B410D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIIUwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIIUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:52:41 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA314739A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:52:40 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11eab59db71so6988438fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=auTdx0ufon/JFw//ZNUMeBnNVMPTikmUwRLNyCwLhpU=;
        b=SJkHXuVd9goGm1zd4i9WhAGT1g0Zy2AKdDf0GPFcAbHCov3BndcvhuUauQZhMFRcMX
         alqvHPrT4MIH2xIL7HGk3BF0zm5aZsm8eajaq9PvCe7rQ9YkGbzBoXPI7PcUf+K1oLva
         9lv7Gpc4il9uXSRLobO/DChwj/Kt8XXVY9rmqpMsxSFKwEjKAOubguW+aYFjdxDFI0H2
         9GVRy6xkUavjj2VFF2BH677C69+6qcStEKWKFbljkhn/ss5VXIWL/KHJKzk/eiQAa3Mv
         qMm83dnbWh64C+xOy2TmpFY1rFWJVRIV88bmL7WhNC5vqXjw/jL4nh91gOKdklcFH8Gb
         Y3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=auTdx0ufon/JFw//ZNUMeBnNVMPTikmUwRLNyCwLhpU=;
        b=ZlJToSUpmZrfEyCjyGtXVn8Ccki6zKP7svdZsbCsEUrBsoIfgE43QxJtYN9rX0Nxp3
         d9eLiOF5yBuPq1YHbZRo4G6vvrt/FZPqkj+lvEHGzIx/Qq3+6dgj3MjwsrccKFY9AEde
         y4TgWYo41cWc2N+azfIC8nOfoJIyeGgQjA3EVPb0OJq5LdC+8gbWZyp3zoc/ruP8zB0V
         kku8x+R4B0WT9QbzrHfZ1ahPgZQsVTIT1rgR8tXnX2Vjod/SEjhOj+0xdjtHaFaRG8IJ
         BqxHm5vBANFHXL6b+GxqZpu++QGivDxAlrDOmKX5VUK9Bj8L+9VN8VceGEND86dWiWDm
         oDzg==
X-Gm-Message-State: ACgBeo0/XEYhXh3+bQWQXAkMqR3GX0MJGsMDr0bOmH07/ohaIK9oOgXW
        RKMGXU9fH6ONQNSAxPgQu197HniAfqrPbcnQCvc=
X-Google-Smtp-Source: AA6agR5I6Ldv3MIUY+iIA3U5//fxJC666jQR7VxjwrS9FgbbXxBYox+wQkCo795/fGd9GkuMcDlk0vPS+veH5/osdS0=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr4719371oae.46.1662756760178; Fri, 09 Sep
 2022 13:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220904183307.14550-1-jingyuwang_vip@163.com>
In-Reply-To: <20220904183307.14550-1-jingyuwang_vip@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:52:29 -0400
Message-ID: <CADnq5_OGdH17hhYh4=f70UJyqxgA2Od=_AkiLDo0wMSYSJ_Urg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_sync.c file
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Sep 5, 2022 at 2:29 AM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> This is a patch to the amdgpu_sync.c file that fixes some warnings found by the checkpatch.pl tool
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index 504af1b93bfa..090e66a1b284 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  /*
>   * Copyright 2014 Advanced Micro Devices, Inc.
>   * All Rights Reserved.
> @@ -315,6 +316,7 @@ struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync)
>         struct hlist_node *tmp;
>         struct dma_fence *f;
>         int i;
> +
>         hash_for_each_safe(sync->fences, i, tmp, e, node) {
>
>                 f = e->fence;
> @@ -392,7 +394,7 @@ void amdgpu_sync_free(struct amdgpu_sync *sync)
>  {
>         struct amdgpu_sync_entry *e;
>         struct hlist_node *tmp;
> -       unsigned i;
> +       unsigned int i;
>
>         hash_for_each_safe(sync->fences, i, tmp, e, node) {
>                 hash_del(&e->node);
>
> base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
> prerequisite-patch-id: fefd0009b468430bb223fc92e4abe9710518b1ea
> --
> 2.34.1
>
