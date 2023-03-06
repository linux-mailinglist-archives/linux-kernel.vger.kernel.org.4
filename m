Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEA6ACE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCFTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCFToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:44:08 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF7C10A84
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:43:53 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id b10-20020a4aba0a000000b005200c0d4a2aso1701745oop.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678131832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+V0EwO6G1+NsdivbbBORAc/NjBVd2whnpDLZ9uwuBOk=;
        b=juILeSvhI3iZefJOGuCghopgkpsqHTNjDpBpW6JVxi7WAJO9X8Oj4gLL7cJyR44plp
         y1JS3glWd1n7a4QTfeAtmJZLrQywzHkCsHHTrZJl6SWA5UYBIz5+S2wskKCt6cYzMf/+
         f4FbrkGQNsJMfD9ORGRRij4MiKH7JDmwE/OUBj1IJZYFBVN8cOCMuWpR+S53Mi8hpxJp
         yoFCtZRDSyPQCPGHbXHGLvgj89XexGfCt3PvRbFwORx9QZ6GQ5uMZ4njSQQAJBJB5UTd
         n0i2HJMBILwzcZAkwLzWCvnUxW9FwVjIZBoc/k1VhnWxLQI2FeF0o6jCT/MvENm2P1lO
         VfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+V0EwO6G1+NsdivbbBORAc/NjBVd2whnpDLZ9uwuBOk=;
        b=Sy+PCNh68W+5H/0EOj9tHPQYVK3Fug2HIqMO2uqU4YETSieYvK/spQyIoEC3RpSyHm
         TL9e9AKqbRqlkb7zm+649eXER+Op2+7LGV1ZcOFkVcbeRcqXZu2RbNokNdn5SDc8IdBh
         mPzLp6lWWhVwq1ysmtVKSikRT1vW2gjoc44Q2wMzaDirFofy/yAS1+ZrSdi6V7OdEWnn
         0kZvjDkTnN6/aYBep+7yDMaOVce+CpBg0LRwikx+cQ4gv9UGykr7m42YvbwdqqpVtqoz
         jSqblD5ZHFTHH1undKP388fPW3P07wbUdXIcRrAxlIsGZnWhpIlEn0b5z96tTIxxDTUk
         rbbQ==
X-Gm-Message-State: AO0yUKVWTIr7YksY8K2UkD/DKRMQc6208KizNlzmRR3RsQEmqjlI5T9/
        0M0/PfilYDv3NPGemx33YbtLtHh4oT4ubd48gl3wzCoh
X-Google-Smtp-Source: AK7set+F1eBn2tH3xXCaADaUGLCEOerW5DQ8sfH/ykuSI5jUceMP5bufdOfeyBYPtE74msssSZw48JCEClvCBVRq6as=
X-Received: by 2002:a4a:3c1c:0:b0:525:2f4d:54a3 with SMTP id
 d28-20020a4a3c1c000000b005252f4d54a3mr4767571ooa.0.1678131832162; Mon, 06 Mar
 2023 11:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20230305125226.1953574-1-trix@redhat.com>
In-Reply-To: <20230305125226.1953574-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Mar 2023 14:43:41 -0500
Message-ID: <CADnq5_MYjVbNA5yJ2mOCgGut6d1kEaNA_U0ZvjEqD=adjn9hPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: change several dcn30 variables
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        aurabindo.pillai@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sun, Mar 5, 2023 at 7:52 AM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports these similar problems in dcn30
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dwb.c:223:25:
>   warning: symbol 'dcn30_dwbc_funcs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_mmhubbub.c:214:28:
>   warning: symbol 'dcn30_mmhubbub_funcs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_mpc.c:1402:24:
>   warning: symbol 'dcn30_mpc_funcs' was not declared. Should it be static?
>
> All of these are only used in their definition file, so they should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c      | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
> index f14f69616692..0d98918bf0fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
> @@ -220,7 +220,7 @@ void dwb3_set_denorm(struct dwbc *dwbc, struct dc_dwb_params *params)
>  }
>
>
> -const struct dwbc_funcs dcn30_dwbc_funcs = {
> +static const struct dwbc_funcs dcn30_dwbc_funcs = {
>         .get_caps               = dwb3_get_caps,
>         .enable                 = dwb3_enable,
>         .disable                = dwb3_disable,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
> index 7a93eff183d9..6f2a0d5d963b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
> @@ -211,7 +211,7 @@ static void mmhubbub3_config_mcif_arb(struct mcif_wb *mcif_wb,
>         REG_UPDATE(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB_CLIENT_ARBITRATION_SLICE,  params->arbitration_slice);
>  }
>
> -const struct mcif_wb_funcs dcn30_mmhubbub_funcs = {
> +static const struct mcif_wb_funcs dcn30_mmhubbub_funcs = {
>         .warmup_mcif            = mmhubbub3_warmup_mcif,
>         .enable_mcif            = mmhubbub2_enable_mcif,
>         .disable_mcif           = mmhubbub2_disable_mcif,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> index ad1c1b703874..6cf40c1332bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> @@ -1399,7 +1399,7 @@ static void mpc3_set_mpc_mem_lp_mode(struct mpc *mpc)
>         }
>  }
>
> -const struct mpc_funcs dcn30_mpc_funcs = {
> +static const struct mpc_funcs dcn30_mpc_funcs = {
>         .read_mpcc_state = mpc1_read_mpcc_state,
>         .insert_plane = mpc1_insert_plane,
>         .remove_mpcc = mpc1_remove_mpcc,
> --
> 2.27.0
>
