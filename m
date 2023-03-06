Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E905D6ACE45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCFTkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCFTke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:40:34 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723D3E63A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:40:33 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t22so7918757oiw.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678131633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHIUBTY2u5AopsB38CE9K2a5ev5PDlYW/oMVV00Krx8=;
        b=Sj/n8sYF7PCPUd+xoPtqD1wSRWj6/ZcKsrN1rO953xhSu5S3RrB+y6PrX+vbPF3LCD
         PgZkX2TPBzjiuH2nQfOu0w0po6q1yQtLwrE0ZBiV+PceN/fOuS6tQRfBzcS726vZR03G
         ojXgnEWSgw0IusPhtESGWl6F5GtQhqk7jD6fGP4sYvven0QEieYf26XYIsdnz0tdUC9D
         5u9USWr5cqUD79/2dXcTPSux2QmF0Xw3d42iMYYl0mLrcM+PXWzxcvOuxFEyvJGl/8dv
         +SmwrE5M/DJo9B7ms4r6Wvh5o1irgfGRtmwkvu5tyo1JWIwegAaIAfR/ga+YmV00//Q+
         WuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHIUBTY2u5AopsB38CE9K2a5ev5PDlYW/oMVV00Krx8=;
        b=bjJDYNVfc/LUax6Cwh5wIsTD2U+ts5SLGUs+fdCI/bUuROykr5EAQ7ICkmwyuCNPQn
         Vh/b5jsWZ74w4Eh2bQ21ttyRe6v6f/PnucnsRv7h547JfACXF18lwjeNJc8QqM1o7ayf
         yLeyjmioJdWg8E93jdVXoPt0DfVmNTDdTF40qd7B2bI0J4OjyjuGab8iN3hsua+34U5y
         di519wX+8t+sMehCTR5rPU3uSHKdG0rRGFSZWP2iPNBFuIQs91msN1K34L/m972TmuBR
         lDoMMDH1sDPDxaB+JhbqcMktQ+cmStsktXyJLlwjJHryq1lPwdO6rp93SD/xOeFFYGEK
         ykQg==
X-Gm-Message-State: AO0yUKW2PLKFwbfVKN9O65+zddpmK90+39MV7Cv92oi1ij4KfTLNnkH4
        LOKkD2rNDm1ms6vDPShFeh6ICKRWhx2jmv3R3Zg=
X-Google-Smtp-Source: AK7set9uNVotF5Jq+iMVHYtnefIcJeP/VGZw/wrTLwcIWeeBDm3qoQGPbjIzsh9JvWG2ySXzlbCxfrabvyKoAuPIC8U=
X-Received: by 2002:a54:400e:0:b0:384:2018:571c with SMTP id
 x14-20020a54400e000000b003842018571cmr3774286oie.8.1678131632969; Mon, 06 Mar
 2023 11:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20230304162213.1939515-1-trix@redhat.com>
In-Reply-To: <20230304162213.1939515-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Mar 2023 14:40:21 -0500
Message-ID: <CADnq5_P6hD8o+fHTjy3mRkSV1b6rGQcOkz_7YkNqmOt_zudvTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: change several dcn20 variables
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, alvin.lee2@amd.com, javierm@redhat.com,
        hamza.mahfooz@amd.com, eric.bernstein@amd.com, roman.li@amd.com,
        wenjing.liu@amd.com, praful.swarnakar@amd.com, tzimmermann@suse.de,
        jiapeng.chong@linux.alibaba.com, Pavle.Kotarac@amd.com,
        hansen.dsouza@amd.com, Charlene.Liu@amd.com, Josip.Pavic@amd.com,
        Jun.Lei@amd.com, chiahsuan.chung@amd.com,
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

On Sat, Mar 4, 2023 at 11:22 AM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports these similar problems in dcn20
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.c:53:24:
>   warning: symbol 'dcn20_dsc_funcs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb.c:304:25:
>   warning: symbol 'dcn20_dwbc_funcs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mmhubbub.c:300:28:
>   warning: symbol 'dcn20_mmhubbub_funcs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mpc.c:545:24:
>   warning: symbol 'dcn20_mpc_funcs' was not declared. Should it be static?
>
> All of these are only used in their definition file, so they should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c      | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c      | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> index 42344aec60d6..5bd698cd6d20 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> @@ -50,7 +50,7 @@ static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
>  static void dsc2_disable(struct display_stream_compressor *dsc);
>  static void dsc2_disconnect(struct display_stream_compressor *dsc);
>
> -const struct dsc_funcs dcn20_dsc_funcs = {
> +static const struct dsc_funcs dcn20_dsc_funcs = {
>         .dsc_get_enc_caps = dsc2_get_enc_caps,
>         .dsc_read_state = dsc2_read_state,
>         .dsc_validate_stream = dsc2_validate_stream,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
> index f1490e97b6ce..f8667be57046 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
> @@ -301,7 +301,7 @@ void dwb2_set_scaler(struct dwbc *dwbc, struct dc_dwb_params *params)
>
>  }
>
> -const struct dwbc_funcs dcn20_dwbc_funcs = {
> +static const struct dwbc_funcs dcn20_dwbc_funcs = {
>         .get_caps               = dwb2_get_caps,
>         .enable                 = dwb2_enable,
>         .disable                = dwb2_disable,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
> index ccd91792991b..259a98e4ee2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
> @@ -297,7 +297,7 @@ void mcifwb2_dump_frame(struct mcif_wb *mcif_wb,
>         dump_info->size         = dest_height * (mcif_params->luma_pitch + mcif_params->chroma_pitch);
>  }
>
> -const struct mcif_wb_funcs dcn20_mmhubbub_funcs = {
> +static const struct mcif_wb_funcs dcn20_mmhubbub_funcs = {
>         .enable_mcif            = mmhubbub2_enable_mcif,
>         .disable_mcif           = mmhubbub2_disable_mcif,
>         .config_mcif_buf        = mmhubbub2_config_mcif_buf,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> index 116f67a0b989..5da6e44f284a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> @@ -542,7 +542,7 @@ static struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
>         return NULL;
>  }
>
> -const struct mpc_funcs dcn20_mpc_funcs = {
> +static const struct mpc_funcs dcn20_mpc_funcs = {
>         .read_mpcc_state = mpc1_read_mpcc_state,
>         .insert_plane = mpc1_insert_plane,
>         .remove_mpcc = mpc1_remove_mpcc,
> --
> 2.27.0
>
