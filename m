Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABE65381A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiLUVLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLUVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:11:42 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E392
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:11:41 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1447c7aa004so251194fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmpu7AL+fAIuY/tlwJdP/dq9eTvyl96yltPRV9LiAiA=;
        b=nOAnXdGXwbMk/4KnLPJ4VLWAHS+8OUfWRF1Tt/ignb3vMBtHwESucSAgaBvgDBp/Y4
         ihUu67reNu4J6tQzlUps60JAnqU5HVRj5z42r8aNqXkbH2ZFE443t/mU9HKRvFUleQbq
         Y9yGESrQwOQZYeIsfZAOTjuwgXruOPVSyFcrZpa9xn9WhA6K7F7u0GGtQAVAztuBJrs5
         TGuzGjwtWvOcr/86Jm8IbsVemolSB13a/r/D4b070t4I87ReOzCuONRvyoiQz5QNfJfk
         +vuwY/aGJiKoMEPy0uW/ncdAc6SgvardnoxUEpB1CjUkuPZxP4WPynLjxtqw9h+UkOfK
         XNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmpu7AL+fAIuY/tlwJdP/dq9eTvyl96yltPRV9LiAiA=;
        b=W2Nxq8RYb8KfxQxpt/jFCA0VSK86BbMcchyP/nCKHwfEy1qmRQnQtXnY5hAPict+mH
         a82CiVXMUecgzejrgmW7l7PtUVUbx2kuLXOsfmG3DwJplHWn1yMB+RCp4uEwf5WG0ct4
         WaDWOnZ43T+EjnZdIdbsUvyf7Sdlf5GhiztvI4zN9dPVMiUpbaSKeS5mUacku+erdCtp
         ZNIW08x8uRqqVq9CsWK0IhMs5wf1XvAusSPnW8OnoJSeV25shsJo+Pl6iKAKxKKv63cL
         jhAH6o2ZpDMzRRx8fEAPxL52x4nV5VjarKlzKXtmHpsNXCPFwhdarOt9SyA97rL4Uw/G
         Xcrw==
X-Gm-Message-State: AFqh2kohbLyj53bi/14IdiTST83Mbk2FnX492IvGpHg+NVXL+nAKcuqi
        wzuyNLLUdr/uWpJpFMbgFYc5DKQNYABJyers0Xg=
X-Google-Smtp-Source: AMrXdXv8Xtywvi0EhEnkpNM8pHFNJ//rBoeCPI3qTpCw7dSEPWqPuPld4BVlRh0w1T6haQh3h+88ASugTxJbzCG3nGE=
X-Received: by 2002:a05:6871:4410:b0:14c:6b59:b014 with SMTP id
 nd16-20020a056871441000b0014c6b59b014mr256289oab.96.1671657100512; Wed, 21
 Dec 2022 13:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20221219142150.56654-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221219142150.56654-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Dec 2022 16:11:29 -0500
Message-ID: <CADnq5_Ms_hzDKPUm8a8tU5bFEy0PyBFdQiU1z0dsWgJOTjGmAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove the unused function dmub_outbox_irq_info_funcs
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

On Mon, Dec 19, 2022 at 9:22 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function dmub_outbox_irq_info_funcs is defined in the
> irq_service_dcn201.c file, but not called elsewhere, so remove this
> unused function.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:139:43: warning: unused variable 'dmub_outbox_irq_info_funcs'.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3520
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c   | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> index 5f4f6dd79511..27dc8c9955f4 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> @@ -136,11 +136,6 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
>         .ack = NULL
>  };
>
> -static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
> -       .set = NULL,
> -       .ack = NULL
> -};
> -
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
>
> --
> 2.20.1.7.g153144c
>
