Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB96CB2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC0Xu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0Xuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:50:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F7A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:50:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f4-20020a9d0384000000b0069fab3f4cafso5484489otf.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679961054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvfG/sJDNh6x3AiUliOCMknfI21NvjU25RdQJEzyP8A=;
        b=MYPGNBP4nTAo5fxXA952/OQc20MLsrdRQS+oVbKlpL8MXIzT//V+W+PQti/X4qdkRU
         L55z4DuS3jfvnLK5B2bMk6Mrp0MlImpXNpi4ChvyPUpjv4cpqvrhkollkk3ikFIuiGCp
         5hh3w+dJnAPmnN6clXxs8qqZQvMOisaQhBBl36MgWkiVPUvP7Hyq8a29C5V9UwbzpaR/
         kOfHQf2ZhghR8VnQxFzeGtgofd5U/Hl0k4GE6WcVm3iN0k1KhqrkUc/iqj1ogOxsmeh6
         IHnSsjUijQOEY6B2Kk9tKpWYh9CFHLJ/TNA5eUW6JD918eZ7wV3YtPBr0VSWbIoUwBC1
         gWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679961054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvfG/sJDNh6x3AiUliOCMknfI21NvjU25RdQJEzyP8A=;
        b=HcI7ArC0TUh2CdCGW/+SUds+gVPYp9obatcl9OtyI9wg98BAafSjbD8pFciJhoKz3v
         cePDASRGT7tRrz68xlg9oq1nT0w9xHUEtlq2i71eRCd38Hb++iSyf5fnVdyPA2VN6kZI
         DRMicSFkq8ssJAV4ZIcVFTvTgiOVIMStyMinFJGR/+yMwVcBz85zfUfZ4ORPS+2TsLBk
         M5S9E2Rm2CCMI9gPGeGbtj0wnWL1poXGUTyNQw+zIi+FxhrYkBah9hVHpWW2aaVktSln
         ABXHh+MQd2Nmzu7llI6+X2CIUdI75UZKK1tdM5VR/5HfFLKz5zBDjrRuD2kr9Yn453ZS
         VTFg==
X-Gm-Message-State: AO0yUKVOYcTQdIPyQbguxJEKQRX9aJceE3PGhgJUwpDnL8X8FieiUEff
        KKWFA9WYqpWHhSCsxEG8zJwpKOlBXaBg0TMr36U=
X-Google-Smtp-Source: AK7set8vlo2JtEdyyb9yAJJ2d4fuWIbGs0om/nfLvfJMDypdAnLGqmQ6i1q/6huaoW4F/UosjmJiH0ARt67sMN/O/Y8=
X-Received: by 2002:a9d:65d1:0:b0:68b:d3f1:aa1b with SMTP id
 z17-20020a9d65d1000000b0068bd3f1aa1bmr4636093oth.3.1679961054024; Mon, 27 Mar
 2023 16:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230327233353.64081-1-caionovais@usp.br> <20230327233353.64081-10-caionovais@usp.br>
In-Reply-To: <20230327233353.64081-10-caionovais@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Mar 2023 19:50:42 -0400
Message-ID: <CADnq5_OhYPi3DVVuZmHM-ghiatEyjzpMviQEJdX_uQFgQY9yUg@mail.gmail.com>
Subject: Re: [PATCH 09/12] drm/amd/display: Remove two unused variables
 'is_pipe_split_expected' and 'state'
To:     Caio Novais <caionovais@usp.br>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Felipe Clark <felipe.clark@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Taimur Hassan <Syed.Hassan@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        George Shen <George.Shen@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Chaitanya Dhere <chaitanya.dhere@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Jingwen Zhu <Jingwen.Zhu@amd.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Leo Li <sunpeng.li@amd.com>, Melissa Wen <mwen@igalia.com>,
        Le Ma <le.ma@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Martin Leung <Martin.Leung@amd.com>,
        Ryan Lin <tsung-hua.lin@amd.com>,
        Brian Chang <Brian.Chang@amd.com>,
        Sung Joon Kim <sungjoon.kim@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Zhan Liu <zhan.liu@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Wayne Lin <wayne.lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Joshua Ashton <joshua@froggi.es>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 7:35=E2=80=AFPM Caio Novais <caionovais@usp.br> wro=
te:
>
> Compiling AMD GPU drivers displays two warnings:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In funct=
ion =E2=80=98dcn32_acquire_post_bldn_3dlut=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1614:31: =
warning: variable =E2=80=98state=E2=80=99 set but not used [-Wunused-but-se=
t-variable]
> and
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In funct=
ion =E2=80=98dcn32_populate_dml_pipes_from_context=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1916:17: =
warning: variable =E2=80=98is_pipe_split_expected=E2=80=99 set but not used=
 [-Wunused-but-set-variable]
>
> Get rid of them by removing the variables.
>
> Signed-off-by: Caio Novais <caionovais@usp.br>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 74e50c09bb62..3435d3294e0b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -1611,7 +1611,6 @@ bool dcn32_acquire_post_bldn_3dlut(
>                 struct dc_transfer_func **shaper)
>  {
>         bool ret =3D false;
> -       union dc_3dlut_state *state;
>
>         ASSERT(*lut =3D=3D NULL && *shaper =3D=3D NULL);
>         *lut =3D NULL;
> @@ -1620,7 +1619,6 @@ bool dcn32_acquire_post_bldn_3dlut(
>         if (!res_ctx->is_mpc_3dlut_acquired[mpcc_id]) {
>                 *lut =3D pool->mpc_lut[mpcc_id];
>                 *shaper =3D pool->mpc_shaper[mpcc_id];
> -               state =3D &pool->mpc_lut[mpcc_id]->state;
>                 res_ctx->is_mpc_3dlut_acquired[mpcc_id] =3D true;
>                 ret =3D true;
>         }
> @@ -1913,7 +1911,6 @@ int dcn32_populate_dml_pipes_from_context(
>         struct resource_context *res_ctx =3D &context->res_ctx;
>         struct pipe_ctx *pipe;
>         bool subvp_in_use =3D false;
> -       uint8_t is_pipe_split_expected[MAX_PIPES] =3D {0};
>         struct dc_crtc_timing *timing;
>
>         dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_va=
lidate);
> @@ -2002,7 +1999,6 @@ int dcn32_populate_dml_pipes_from_context(
>                 }
>
>                 DC_FP_START();
> -               is_pipe_split_expected[i] =3D dcn32_predict_pipe_split(co=
ntext, &pipes[pipe_cnt]);
>                 DC_FP_END();

You can drop the DC_FP macros as well if you drop the function call.

Alex

>
>                 pipe_cnt++;
> --
> 2.40.0
>
