Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27136ACE3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCFTjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCFTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:39:38 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E87737B50
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:39:37 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1767a208b30so10698517fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678131577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8UKcsGK4YA8tUGiI5rhlN30+v4TxO/+/gIicnl7ZbKI=;
        b=kTtSgvNFQkoBezxUpXnpu3468cf7a+VJYxUzp7jHm57XFc0iEzcXOfQzSMnLwTGER+
         n01JABy8op3LgYihhpAtNSiO7q4y3bpciyw+zKA0zw+9wTWj52M0tJicov/mzRirXUWZ
         OmAcR0JZNVwxyqK1yoSSnBl3N8/m42FxA0LGbYwPChrkAkk6OHY5C9NDxs+3vZUrxXUC
         91rNzzTHCk906T8AWGeMvChdmMBdSKg890ByfDHEeLoywjQgPn94+LGA2XcCfu5vAktV
         0RBTFqcmHTsOF90tWirK7WsHff1m5o9cXm9/Nkdx/eRMG8l/oatmJMLtndfjyIf0QlIm
         PM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UKcsGK4YA8tUGiI5rhlN30+v4TxO/+/gIicnl7ZbKI=;
        b=rP0J5SiFugEsK7lBOB51se3DKn34TFUfTZaiQTcxcn4FMzEdZ3ZmFjD1EIzXd+BFN2
         V2hOMEYMCYPD9/283DS5gBpLFky4EKuVhNp/J+I/LQpt1h/oSA4WgphVlyZm0jqsimuM
         HgRfcZunUolaxPk/lulxl9+rCX0JjkEQZt7JR7Yc7i2+XGB6qMGM4Ykim5P1QBS0isAW
         4LJ7Mq3q9E0y7LEVgmfca87HtSVEkQPVC4hbj9xBvAYLfPOB+fAWFlEeuxw9WsDfPGj8
         X1p4GsQ+/V7m87yqlDTEkB9SQ1zmb9hQBXogC6vayC9XUtvCzs7wU6oE+T//v2uC5cVR
         qe0A==
X-Gm-Message-State: AO0yUKV8V0luVJpi8Kb5kOzcmfcz5fFf8KBJFDdjxqGViWR8hCU5EauX
        N8GhQBRMn6BFWyxjV7Py9x/24hqfnE6weHNZN4c=
X-Google-Smtp-Source: AK7set/Wbv1XVNevt3mhbnrT3z+cEoK0+kLQa42RpYremoZlwgfB2S9076dsjmIt1KuCTNzIq4+iY6UFH5HZps6LhXA=
X-Received: by 2002:a05:6870:5b01:b0:176:4416:eeff with SMTP id
 ds1-20020a0568705b0100b001764416eeffmr3281095oab.8.1678131576842; Mon, 06 Mar
 2023 11:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20230304152640.1938302-1-trix@redhat.com>
In-Reply-To: <20230304152640.1938302-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Mar 2023 14:39:25 -0500
Message-ID: <CADnq5_O0=5sv9HMH6zHtggZ9+BgLu2t_UezzLjd60Jvse0yZWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: change several dcn201 variables
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        Pavle.Kotarac@amd.com, oliver.logush@amd.com, alex.hung@amd.com,
        aurabindo.pillai@amd.com, HaoPing.Liu@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
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

On Sat, Mar 4, 2023 at 10:26 AM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports these similar problems in dcn201
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:165:22:
>   warning: symbol 'dcn201_funcs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:77:30:
>   warning: symbol 'dcn201_ip' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:139:37:
>   warning: symbol 'dcn201_soc' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_mpc.c:79:24:
>   warning: symbol 'dcn201_mpc_funcs' was not declared. Should it be static?
>
> All of these are only used in their definition file, so they should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c            | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c       | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index f0577dcd1af6..811720749faf 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -162,7 +162,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>         }
>  }
>
> -struct clk_mgr_funcs dcn201_funcs = {
> +static struct clk_mgr_funcs dcn201_funcs = {
>         .get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
>         .update_clocks = dcn201_update_clocks,
>         .init_clocks = dcn201_init_clocks,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
> index 95c4c55f067c..1af03a86ec9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
> @@ -76,7 +76,7 @@ static void mpc201_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
>         mpcc->shared_bottom = false;
>  }
>
> -const struct mpc_funcs dcn201_mpc_funcs = {
> +static const struct mpc_funcs dcn201_mpc_funcs = {
>         .read_mpcc_state = mpc1_read_mpcc_state,
>         .insert_plane = mpc1_insert_plane,
>         .remove_mpcc = mpc1_remove_mpcc,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> index 407d995bfa99..cd46701398d9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> @@ -74,7 +74,7 @@
>  #define MIN_DISP_CLK_KHZ 100000
>  #define MIN_DPP_CLK_KHZ 100000
>
> -struct _vcs_dpi_ip_params_st dcn201_ip = {
> +static struct _vcs_dpi_ip_params_st dcn201_ip = {
>         .gpuvm_enable = 0,
>         .hostvm_enable = 0,
>         .gpuvm_max_page_table_levels = 4,
> @@ -136,7 +136,7 @@ struct _vcs_dpi_ip_params_st dcn201_ip = {
>         .number_of_cursors = 1,
>  };
>
> -struct _vcs_dpi_soc_bounding_box_st dcn201_soc = {
> +static struct _vcs_dpi_soc_bounding_box_st dcn201_soc = {
>         .clock_limits = {
>                         {
>                                 .state = 0,
> --
> 2.27.0
>
