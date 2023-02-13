Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC677694C21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBMQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjBMQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:13:42 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EBD1ADD4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:13:35 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16a7f5b6882so15683185fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HOydk6f84zeK5t+nIiZ1wDb4AVF47DPeadPPFSHvPJc=;
        b=HC0mIP+w3RPfsCmj0wmS+ImFgNYE3XYFw5PVe53+TRWvZSAjbl9vb9taNnzbmcwhDS
         E8kfabCq1CWjn58/nwd/32SJPsKfMsTNGimZ4rNY/GlTDcIWtcop0Sv9gToNamMaCjUH
         xGkbrGJHMxKP6YGuRNTHdz1IcmHrSROTpmkTDQbyQubc47WJe/TpQ0nBdbdn2sR67obA
         zEuspuxtvx4lcR/6swPWZ/VButDBCRWaUSFSWOZ+zflPgd/kDWXtByjHBf7AzGrIUyCB
         xvQhAjytrT0L7RNKJGk7y9IGq9q5BQWBsBPl55ZOuyw4Cq4sd7u6u6QaYLdmN2Htu8Ag
         Dg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOydk6f84zeK5t+nIiZ1wDb4AVF47DPeadPPFSHvPJc=;
        b=iViP1Dz8aIEhw+CnNxem12zl5f7YFvew6X3wabp4qhOs2fTyNuXf9J3c2gwpsjUv0L
         GtDfDo0u1PPQFI1CzC8qoaA51T4Gvrda7HKfXvZYEm7pJbUqx9LogcR0jBBhqXzkGppW
         8dWcFjGEH5SwGaooC64N0PsecAOvpCU+iWkxkS+BwbW8+/hCE3yU/p9+BuBZgDY4pzB5
         VpfQdvipZtMpQqvrvF+IGITKNzG+kZyf77YvAmKaM6E1lxOR2W7tzR7cP3IaQSmFe3rp
         X/hbfaqovarR3RHsCUQAXyM0EP/qnCGfYU7GwWIkN8Ezv9TlZ8TSv0mBbhZM0+8ivDcm
         sJLg==
X-Gm-Message-State: AO0yUKWMsUh0S91EdhqVrjSjLLpzj3pMiCOCTBYDJS9+fsPL8NATl7dd
        EsYizMFuKuK4HSkcaRsXYcYfVVHImr1U1rmr7o3LweUm
X-Google-Smtp-Source: AK7set/+1BMz88y4VQ6Euwne6f3OxLMLtGXYlj3boy9L2t2Ld3F0bsO6hDBA9bIjQfHtI3wcFCTsVFD8Uf3x7wTeTiw=
X-Received: by 2002:a05:6870:13d1:b0:163:a303:fe2f with SMTP id
 17-20020a05687013d100b00163a303fe2fmr2647166oat.96.1676304814031; Mon, 13 Feb
 2023 08:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20230210005859.397-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230210005859.397-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Feb 2023 11:13:22 -0500
Message-ID: <CADnq5_OCRemgZTS3R7soFcsnUqgf+sewJ4GM42jkTBDyrKXyLg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
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

Applied.  Thanks.

On Thu, Feb 9, 2023 at 7:59 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c:1610:68-73: WARNING: conversion to bool not needed here
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4025
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 24d356ebd7a9..cb38afde3fc8 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1607,7 +1607,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>                         dpcd_data[DP_TRAINING_AUX_RD_INTERVAL];
>
>                 link->dpcd_caps.ext_receiver_cap_field_present =
> -                               aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1 ? true:false;
> +                               aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1;
>
>                 if (aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1) {
>                         uint8_t ext_cap_data[16];
> --
> 2.20.1.7.g153144c
>
