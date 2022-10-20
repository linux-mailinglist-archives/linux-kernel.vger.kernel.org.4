Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196C260612F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJTNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJTNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:12:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1CE1CC3D7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:11:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y72so22795125oia.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cemyxy4dpeRq0uuKNf5JWwjxkCluzhqG4ofmZbWFcZE=;
        b=pIWWgwwDx0olKcKRAZURt9rk1dtYhXUpYLbqxX1PSAukl6Fajs7B35qn889P8hl02V
         U7SmfroLVgIGpKqH4+EXDNZHvW8gKaTlIT5RpMLibSRVeQ/V4Ymbi7kWsLspGlYVezUC
         rpz7NXnMiLECXuUpuAYjb/dKj/ydija5LzzQRW0fXst7pp43qqUW1m+lQY5givglzBzP
         S+/HGdQxOzuhAs8v+l0okIbdmOvWQL7COFjYs//DD5L5CSpDrGEm0nEjL0uyrYLPnJaw
         vWT8eKakqCBLO9UEDQAohlSOohzztQMCdIQF8BQaImnYLM/Y8hboha61zJNwZy7Lmgnl
         2t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cemyxy4dpeRq0uuKNf5JWwjxkCluzhqG4ofmZbWFcZE=;
        b=HazRR+JS/X30lznFFPein3xmYIlRLPAKKmEtBGl+4Ll0jkWIuuZdo1X0LgAV0kKSqX
         5FWQy1bMF+aeiMytdZvd30nGbJTcferWkuL//7F4hF05q0usf+dDoAmiXXO4qN3JwR45
         FrC96Rp0EN4Ot/nj845Gc7NdGPjv5KHhgNMmoif6sWyXcipaxo9R/Ss+BqNMwP6Tv8Rx
         NRDgA1vcFfMhlY0DPiTc2OV1uSu/k41Pu10i/IwP4vPQ63AOZ5j+/A/R2Gw6sD4fmrod
         G6sI8ZDOPKvcAbRduvMT3Xy+5JKmr+ARVhzNmv3syqUtRM2Tyg/7gMCgbKHiBhQXGSJI
         1mtA==
X-Gm-Message-State: ACrzQf1Oa78aPMs7oFjEPbyWf+ngNZvWzOGUjBmpWIx05SExDRopx5an
        BkTcIo0Yg0WQjnuUdp2K2OQD4LrW/miUsSn2BIs=
X-Google-Smtp-Source: AMsMyM4E8YbN2RSOu/jza6/DlhbYG1PvAv4swjyW6nf6REHYcBLavUnlzsdHrN7tRScCH/dzh53QEXmGgLCrdZTe3cs=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr7176564oiw.96.1666271445001; Thu, 20
 Oct 2022 06:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019074502.4048521-1-ruanjinjie@huawei.com>
In-Reply-To: <20221019074502.4048521-1-ruanjinjie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Oct 2022 09:10:33 -0400
Message-ID: <CADnq5_MTnK22v+NNB0iqY84ZGBP4eBV_w5QMN_2XuCHpSzxPiw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Make some symbols static
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, qingqing.zhuo@amd.com, agustin.gutierrez@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 19, 2022 at 3:48 AM ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> These symbols qp_table_422_10bpc_min, qp_table_444_8bpc_max,
> qp_table_420_12bpc_max, qp_table_444_10bpc_min, qp_table_420_8bpc_max,
> qp_table_444_8bpc_min, qp_table_444_12bpc_min, qp_table_420_12bpc_min,
> qp_table_422_12bpc_min, qp_table_422_12bpc_max, qp_table_444_12bpc_max,
> qp_table_420_8bpc_min, qp_table_422_8bpc_min, qp_table_422_10bpc_max,
> qp_table_420_10bpc_max, qp_table_420_10bpc_min, qp_table_444_10bpc_max,
> qp_table_422_8bpc_max are not used outside of the file,
> so mark them static.
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:28:18: warning:
> symbol 'qp_table_422_10bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:61:18: warning:
> symbol 'qp_table_444_8bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:102:18: warning:
> symbol 'qp_table_420_12bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:135:18: warning:
> symbol 'qp_table_444_10bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:188:18: warning:
> symbol 'qp_table_420_8bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:209:18: warning:
> symbol 'qp_table_444_8bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:250:18: warning:
> symbol 'qp_table_444_12bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:315:18: warning:
> symbol 'qp_table_420_12bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:348:18: warning:
> symbol 'qp_table_422_12bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:389:18: warning:
> symbol 'qp_table_422_12bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:430:18: warning:
> symbol 'qp_table_444_12bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:495:18: warning:
> symbol 'qp_table_420_8bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:516:18: warning:
> symbol 'qp_table_422_8bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:541:18: warning:
> symbol 'qp_table_422_10bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:574:16: warning:
> symbol 'qp_table_420_10bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:601:18: warning:
> symbol 'qp_table_420_10bpc_min' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:628:18: warning:
> symbol 'qp_table_444_10bpc_max' was not declared. Should it be static?
>
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:681:18: warning:
> symbol 'qp_table_422_8bpc_max' was not declared. Should it be static?
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  .../drm/amd/display/dc/dml/dsc/qp_tables.h    | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> index e5fac9f4181d..dcff0dd2b6a1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> @@ -25,7 +25,7 @@
>   */
>
>
> -const qp_table   qp_table_422_10bpc_min = {
> +static const qp_table   qp_table_422_10bpc_min = {
>         {   6, { 0, 4, 5, 6, 6, 6, 6, 7, 7, 8, 9, 9, 9, 12, 16} },
>         { 6.5, { 0, 4, 5, 6, 6, 6, 6, 7, 7, 8, 9, 9, 9, 12, 16} },
>         {   7, { 0, 4, 5, 6, 6, 6, 6, 7, 7, 7, 9, 9, 9, 11, 15} },
> @@ -58,7 +58,7 @@ const qp_table   qp_table_422_10bpc_min = {
>  };
>
>
> -const qp_table   qp_table_444_8bpc_max = {
> +static const qp_table   qp_table_444_8bpc_max = {
>         {   6, { 4, 6, 8, 8, 9, 9, 9, 10, 11, 12, 12, 12, 12, 13, 15} },
>         { 6.5, { 4, 6, 7, 8, 8, 8, 9, 10, 11, 11, 12, 12, 12, 13, 15} },
>         {   7, { 4, 5, 7, 7, 8, 8, 8, 9, 10, 11, 11, 12, 12, 13, 14} },
> @@ -99,7 +99,7 @@ const qp_table   qp_table_444_8bpc_max = {
>  };
>
>
> -const qp_table   qp_table_420_12bpc_max = {
> +static const qp_table   qp_table_420_12bpc_max = {
>         {   4, {11, 12, 13, 14, 15, 15, 15, 16, 17, 18, 18, 19, 19, 21, 22} },
>         { 4.5, {10, 11, 12, 13, 14, 15, 15, 16, 17, 18, 18, 19, 19, 20, 21} },
>         {   5, { 9, 11, 12, 13, 14, 15, 15, 16, 17, 17, 18, 18, 19, 20, 21} },
> @@ -132,7 +132,7 @@ const qp_table   qp_table_420_12bpc_max = {
>  };
>
>
> -const qp_table   qp_table_444_10bpc_min = {
> +static const qp_table   qp_table_444_10bpc_min = {
>         {   6, { 0, 4, 7, 7, 9, 9, 9, 9, 9, 10, 10, 10, 10, 12, 18} },
>         { 6.5, { 0, 4, 6, 7, 8, 8, 9, 9, 9, 9, 10, 10, 10, 12, 18} },
>         {   7, { 0, 4, 6, 6, 8, 8, 8, 8, 8, 9, 9, 10, 10, 12, 17} },
> @@ -185,7 +185,7 @@ const qp_table   qp_table_444_10bpc_min = {
>  };
>
>
> -const qp_table   qp_table_420_8bpc_max = {
> +static const qp_table   qp_table_420_8bpc_max = {
>         {   4, { 4, 4, 5, 6, 7, 7, 7, 8, 9, 10, 10, 11, 11, 13, 14} },
>         { 4.5, { 4, 4, 5, 6, 7, 7, 7, 8, 9, 10, 10, 11, 11, 12, 13} },
>         {   5, { 3, 4, 5, 6, 7, 7, 7, 8, 9, 9, 10, 10, 11, 12, 13} },
> @@ -206,7 +206,7 @@ const qp_table   qp_table_420_8bpc_max = {
>  };
>
>
> -const qp_table   qp_table_444_8bpc_min = {
> +static const qp_table   qp_table_444_8bpc_min = {
>         {   6, { 0, 1, 3, 3, 5, 5, 5, 5, 5, 6, 6, 6, 6, 9, 14} },
>         { 6.5, { 0, 1, 2, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 9, 14} },
>         {   7, { 0, 0, 2, 2, 4, 4, 4, 4, 4, 5, 5, 6, 6, 9, 13} },
> @@ -247,7 +247,7 @@ const qp_table   qp_table_444_8bpc_min = {
>  };
>
>
> -const qp_table   qp_table_444_12bpc_min = {
> +static const qp_table   qp_table_444_12bpc_min = {
>         {   6, { 0, 5, 11, 11, 13, 13, 13, 13, 13, 14, 14, 14, 14, 17, 22} },
>         { 6.5, { 0, 5, 10, 11, 12, 12, 13, 13, 13, 13, 14, 14, 14, 17, 22} },
>         {   7, { 0, 5, 10, 10, 12, 12, 12, 12, 12, 13, 13, 14, 14, 17, 21} },
> @@ -312,7 +312,7 @@ const qp_table   qp_table_444_12bpc_min = {
>  };
>
>
> -const qp_table   qp_table_420_12bpc_min = {
> +static const qp_table   qp_table_420_12bpc_min = {
>         {   4, { 0, 4, 9, 10, 11, 11, 11, 11, 11, 11, 13, 13, 13, 15, 21} },
>         { 4.5, { 0, 4, 8, 9, 10, 11, 11, 11, 11, 11, 13, 13, 13, 15, 20} },
>         {   5, { 0, 4, 8, 9, 10, 11, 11, 11, 11, 11, 13, 13, 13, 15, 20} },
> @@ -345,7 +345,7 @@ const qp_table   qp_table_420_12bpc_min = {
>  };
>
>
> -const qp_table   qp_table_422_12bpc_min = {
> +static const qp_table   qp_table_422_12bpc_min = {
>         {   6, { 0, 4, 9, 10, 11, 11, 11, 11, 11, 11, 13, 13, 13, 16, 20} },
>         { 6.5, { 0, 4, 9, 10, 11, 11, 11, 11, 11, 11, 13, 13, 13, 16, 20} },
>         {   7, { 0, 4, 9, 10, 11, 11, 11, 11, 11, 11, 13, 13, 13, 15, 19} },
> @@ -386,7 +386,7 @@ const qp_table   qp_table_422_12bpc_min = {
>  };
>
>
> -const qp_table   qp_table_422_12bpc_max = {
> +static const qp_table   qp_table_422_12bpc_max = {
>         {   6, {12, 12, 13, 14, 15, 15, 15, 16, 17, 18, 18, 19, 19, 20, 21} },
>         { 6.5, {12, 12, 13, 14, 15, 15, 15, 16, 17, 18, 18, 19, 19, 20, 21} },
>         {   7, {11, 12, 13, 14, 15, 15, 15, 16, 17, 17, 18, 18, 19, 19, 20} },
> @@ -427,7 +427,7 @@ const qp_table   qp_table_422_12bpc_max = {
>  };
>
>
> -const qp_table   qp_table_444_12bpc_max = {
> +static const qp_table   qp_table_444_12bpc_max = {
>         {   6, {12, 14, 16, 16, 17, 17, 17, 18, 19, 20, 20, 20, 20, 21, 23} },
>         { 6.5, {12, 14, 15, 16, 16, 16, 17, 18, 19, 19, 20, 20, 20, 21, 23} },
>         {   7, {12, 13, 15, 15, 16, 16, 16, 17, 18, 19, 19, 20, 20, 21, 22} },
> @@ -492,7 +492,7 @@ const qp_table   qp_table_444_12bpc_max = {
>  };
>
>
> -const qp_table   qp_table_420_8bpc_min = {
> +static const qp_table   qp_table_420_8bpc_min = {
>         {   4, { 0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 9, 13} },
>         { 4.5, { 0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 8, 12} },
>         {   5, { 0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 8, 12} },
> @@ -513,7 +513,7 @@ const qp_table   qp_table_420_8bpc_min = {
>  };
>
>
> -const qp_table   qp_table_422_8bpc_min = {
> +static const qp_table   qp_table_422_8bpc_min = {
>         {   6, { 0, 0, 1, 2, 3, 3, 3, 3, 3, 3, 5, 5, 5, 8, 12} },
>         { 6.5, { 0, 0, 1, 2, 3, 3, 3, 3, 3, 3, 5, 5, 5, 8, 12} },
>         {   7, { 0, 0, 1, 2, 3, 3, 3, 3, 3, 3, 5, 5, 5, 7, 11} },
> @@ -538,7 +538,7 @@ const qp_table   qp_table_422_8bpc_min = {
>  };
>
>
> -const qp_table   qp_table_422_10bpc_max = {
> +static const qp_table   qp_table_422_10bpc_max = {
>         {   6, { 8, 8, 9, 10, 11, 11, 11, 12, 13, 14, 14, 15, 15, 16, 17} },
>         { 6.5, { 8, 8, 9, 10, 11, 11, 11, 12, 13, 14, 14, 15, 15, 16, 17} },
>         {   7, { 7, 8, 9, 10, 11, 11, 11, 12, 13, 13, 14, 14, 15, 15, 16} },
> @@ -571,7 +571,7 @@ const qp_table   qp_table_422_10bpc_max = {
>  };
>
>
> -const qp_table qp_table_420_10bpc_max = {
> +static const qp_table qp_table_420_10bpc_max = {
>         {   4, { 8, 8, 9, 10, 11, 11, 11, 12, 13, 14, 14, 15, 15, 17, 18} },
>         { 4.5, { 8, 8, 9, 10, 11, 11, 11, 12, 13, 14, 14, 15, 15, 16, 17} },
>         {   5, { 7, 8, 9, 10, 11, 11, 11, 12, 13, 13, 14, 14, 15, 16, 17} },
> @@ -598,7 +598,7 @@ const qp_table qp_table_420_10bpc_max = {
>  };
>
>
> -const qp_table   qp_table_420_10bpc_min = {
> +static const qp_table   qp_table_420_10bpc_min = {
>         {   4, { 0, 4, 4, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 13, 17} },
>         { 4.5, { 0, 4, 4, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 12, 16} },
>         {   5, { 0, 4, 4, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 12, 16} },
> @@ -625,7 +625,7 @@ const qp_table   qp_table_420_10bpc_min = {
>  };
>
>
> -const qp_table   qp_table_444_10bpc_max = {
> +static const qp_table   qp_table_444_10bpc_max = {
>         {   6, { 8, 10, 12, 12, 13, 13, 13, 14, 15, 16, 16, 16, 16, 17, 19} },
>         { 6.5, { 8, 10, 11, 12, 12, 12, 13, 14, 15, 15, 16, 16, 16, 17, 19} },
>         {   7, { 8, 9, 11, 11, 12, 12, 12, 13, 14, 15, 15, 16, 16, 17, 18} },
> @@ -678,7 +678,7 @@ const qp_table   qp_table_444_10bpc_max = {
>  };
>
>
> -const qp_table   qp_table_422_8bpc_max = {
> +static const qp_table   qp_table_422_8bpc_max = {
>         {   6, { 4, 4, 5, 6, 7, 7, 7, 8, 9, 10, 10, 11, 11, 12, 13} },
>         { 6.5, { 4, 4, 5, 6, 7, 7, 7, 8, 9, 10, 10, 11, 11, 12, 13} },
>         {   7, { 3, 4, 5, 6, 7, 7, 7, 8, 9, 9, 10, 10, 11, 11, 12} },
> --
> 2.25.1
>
