Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9716BF250
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCQUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCQUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:21:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380724BC5;
        Fri, 17 Mar 2023 13:21:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w21-20020a9d6755000000b00698853a52c7so3496764otm.11;
        Fri, 17 Mar 2023 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU/mfsfhNec1aK8PFyfIyYKE8EgQ7PhAvCKKTqQTyQU=;
        b=p7JYB8bhqRMYfjRD2ozKkjzAHTQevhnUGfUTimLWA8bI8MVUYYWpER3Gii4aFi5v29
         Lxwr7+9ZgUmx5eRCE9hnmBerUeOfWr1uzaSC7n0QL9DXgwD+rO90jv40HHNyjhw+Eml1
         UeTFXmSTqEUf5JMMrFF9IJKtQcEMHCKDhyDrBoGdBUGyOn+AQWZqGVSLZeDdr8sDDSZf
         or3jIZBNDQtCgpEdD7UM/NaIP/RaXxBYpfcgkh9XWHWofv7tEC0kFTNYKmxJ4tcY9ZAa
         oMqMQkcWpUrSvABhJRYm3TYVMpJvpiuXnXdwrYJ96N/QrIiB4H09rD3EGyuG0nVL6Ntw
         qygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU/mfsfhNec1aK8PFyfIyYKE8EgQ7PhAvCKKTqQTyQU=;
        b=nbVklu/hRaWS4iubfhlzVpYP4hSRovsTKmLXaxi4wWXFoT7BB+02eac5lLF6uCr+pq
         MbmrsNE7cupcMfGR5/w1/uX3Yi9xT7VizLS2+ylEkVcQ8ZMiGrmq4h9+UO4MlhYjDZ7c
         +hJWODC7dMO+oKalgep7I7hRdVu4KOKJPRa6MfViEbG/RO4+mniqCYuYbVJHYl+nVcgL
         Nnwp1je3YHU/nEFDbwYgPSC/bKXLJ0A7EWYyR4cTwvrLgUuC8ap3h+VVTXKVw23cnMQJ
         OelFq0HxCd4i2tZ41nwdD53pBp0nw1uRT/4nRlHgfpX7ZHExirqLOjQAOLkGbzod4j1Y
         rbDg==
X-Gm-Message-State: AO0yUKV+V5M+56vItCowIuqsQLRzbegNq9HA7eFI+CXGlWDql+2ggBLw
        ZLBzAuc80JgdjAYPzEZJPsts25Z9G5zAx5oVh8k=
X-Google-Smtp-Source: AK7set/FRROjLZxfdn/0MtuhT89/CHr/iks4mIHIqASlz97aojJD2I6VOCkrI8hRGKyEKDzR3I6aFHA0/lRhVr+0fyE=
X-Received: by 2002:a9d:75ca:0:b0:698:311c:a051 with SMTP id
 c10-20020a9d75ca000000b00698311ca051mr313259otl.3.1679084492844; Fri, 17 Mar
 2023 13:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-15-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-15-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:21:21 -0400
Message-ID: <CADnq5_PPRv7FHbfqrwivf7SxmQktyOhg2OL8=1Ep9G2CnJwf4A@mail.gmail.com>
Subject: Re: [PATCH 14/37] drm/amd/amdgpu/amdgpu_vm_pt: Supply description for
 amdgpu_vm_pt_free_dfs()'s unlocked param
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:683: warning: Function paramet=
er or member 'unlocked' not described in 'amdgpu_vm_pt_free_dfs'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index 01e42bdd8e4e8..df63dc3bca18c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -673,6 +673,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
>   * @adev: amdgpu device structure
>   * @vm: amdgpu vm structure
>   * @start: optional cursor where to start freeing PDs/PTs
> + * @unlocked: vm resv unlock status
>   *
>   * Free the page directory or page table level and all sub levels.
>   */
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
