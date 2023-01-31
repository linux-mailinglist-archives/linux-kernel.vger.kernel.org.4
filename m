Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DAB6833B8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjAaRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjAaRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:21:18 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D01E281
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:20:50 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-16332831ed0so20218984fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a5eYX76zIAVB8c95dz15j8MnE/5jf22tihPTxYs5fCU=;
        b=O3ngQ/VkcLAuKvEdievGcuURl+oH+4IPZ4bQrAQgxM1UYmBKySfahajHio8W7xevPb
         QzufZQQgW5xc/4zNiljJWzk52yK/qtS93CQvcHe8RsgllYZLkjqjkJkZ78Me+kjCDY5n
         u9b3LjbzkpywoJT4kWqY3t7n1aJpcONUlFEzO1aYJPQJ6ny5m/uMVaxStOB/Ldd118I+
         jSQ02FuU/njJlsSoWBtEJ8HJcWTbGgsgTkNOyAUPJf8at53k8HeB2dLcdRkByuz42ePv
         nfKsUCMeu2VPnrPjmYYm78EqM8D41CtujqXkzXlxx0I/V/t6v7pa/NmgYRfnvpwsj/S0
         r1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5eYX76zIAVB8c95dz15j8MnE/5jf22tihPTxYs5fCU=;
        b=EXOwwiQhPG4eSwNCHAeDZVwHXdgX18JbEhx48hJ4uOQByEhEmXcquUn2BQJrChHvM1
         +tFTeeQ6G92zyFjgrX158Z4qf+JQDEnAP/tXKCvTSPXexKscNUt8tvXR4JqZN2q8YWnr
         Gvsnmd2lH+HN8cKsggBbQkDdN21ejkvMTTWAHun5UhC4e7MNAGVHm7zPfsKUifq1Zif2
         Tj1+L3JTdCioUVcSTlYSgUJ8gaDhZRBumE4sXFsXQciJMJm1RXtH9zVm723IjK71tbUX
         sp0QUco19svffwFzW95MexF9drIkRkUe2oljBrHQqdApztffo4kzEM/UYDcX1rci6BKi
         Jytw==
X-Gm-Message-State: AO0yUKUvtmQWDY1pF8LahKLJelKd85oeOkEvfU5gTOU1wlTwxKSIPqDf
        AjtBjDk9FawfsN4TygoREmYwj0V3QE2OK2/S4fU=
X-Google-Smtp-Source: AK7set8grw5QUR1EUF7PjRLznxHD6+NW/n6GZEOFxILkd06E+DRdVlXMEF8HTULGdTUDD717b+hnU+ZJQJx1cOiy1rA=
X-Received: by 2002:a05:6870:b522:b0:163:8cc6:86a with SMTP id
 v34-20020a056870b52200b001638cc6086amr1617905oap.46.1675185642695; Tue, 31
 Jan 2023 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20230127013823.832698-1-trix@redhat.com>
In-Reply-To: <20230127013823.832698-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Jan 2023 12:20:31 -0500
Message-ID: <CADnq5_NpjoaU5+HThA5s5-KANfoYSgwr2Vj6pYuqWKqJrdXRkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: reduce else-if to else in dcn10_blank_pixel_data()
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Anthony.Koo@amd.com, alex.hung@amd.com,
        aurabindo.pillai@amd.com, Roman.Li@amd.com, wenjing.liu@amd.com,
        Dillon.Varone@amd.com, mwen@igalia.com, dingchen.zhang@amd.com,
        martin.tsai@amd.com, aric.cyr@amd.com, Wesley.Chalmers@amd.com,
        Max.Tseng@amd.com, sivapiriyan.kumarasamy@amd.com,
        Tony.Cheng@amd.com, dri-devel@lists.freedesktop.org,
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

On Thu, Jan 26, 2023 at 8:38 PM Tom Rix <trix@redhat.com> wrote:
>
> checkpatch reports
> drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2902:13: style:
>   Expression is always true because 'else if' condition is opposite to previous condition at line 2895. [multiCondition]
>  } else if (blank) {
>             ^
> drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2895:6: note: first condition
>  if (!blank) {
>      ^
> drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2902:13: note: else if condition is opposite to first condition
>  } else if (blank) {
>
> It is not necessary to explicitly the check != condition, an else is simplier.
>
> Fixes: aa5a57773042 ("drm/amd/display: Vari-bright looks disabled near end of MM14")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index bb155734ac93..f735ae5e045f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2899,7 +2899,7 @@ void dcn10_blank_pixel_data(
>                         dc->hwss.set_pipe(pipe_ctx);
>                         stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
>                 }
> -       } else if (blank) {
> +       } else {
>                 dc->hwss.set_abm_immediate_disable(pipe_ctx);
>                 if (stream_res->tg->funcs->set_blank) {
>                         stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
> --
> 2.26.3
>
