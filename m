Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C06CB29D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjC0Xqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC0Xqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:46:38 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3951AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:46:37 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso11065523fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679960797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HHSCdFOMcHm/qTnYSefeJOCZD07oxZlsWhVPH8z90I=;
        b=XkhgxyTZd9kUR7Mla+hglqBL+D9/RgpyDpo01akjHC4VAuLumOJrjNLjak/QXPcNrc
         oRYEgpTBzmdQzsXmFXudNZDRN9xrMJ7ZUVOEt3QpMP1FF1owquMp/AEIobLlDc/dM8k1
         2YWN/qLuTmP4VZMnIcAbRydw5hR6BxqRGi+009qYQTkX9Y59f4DfxlSWD4rng7LpLXhD
         lbF/ujVpRDWHyIrh8a8IoNHZxzuflZmFVejEjezfku+2NDz8HvcrkYHXuPgvYaqE5B1N
         f/ctHuRye3Y3ZVa9sdtg+pMuAHkV+HlyGGOIH6H91wlrnVahQEYrXOD1wO4WgefG4zNy
         uSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HHSCdFOMcHm/qTnYSefeJOCZD07oxZlsWhVPH8z90I=;
        b=52YyWiqSkA6YceQ+kdHLaYdNZMhPPXos+GEz/35NItGtwDFuQ+WfAFxUMftUc3p43P
         fjzcVE5+8n5kUIOxzNQZ3sCnWrmLOFJf4rZzk/WFvhvzNTgmSj4FNKhCOeE5w0zTZAx3
         CGnPjfC/Ybw1dlBIp6utxvLPYzR89PA/Cb1tmiElUPmm+OPNgwjwNUIne0VPwoU1ZyB+
         iuDRzdRSx+AX5OOhNEKzzQ1S5K9u7lX6P1OnqAcb1AM2jmR1fMlkwcqjcvMmJzfYdaWG
         tidAKkbfr3K5s99SagVXX9TPGkaM3AO5KJLhxu+JadyzZgfsstStdkanRfERpGsJ7KCA
         a+dg==
X-Gm-Message-State: AAQBX9cGGYzhWaWuTFfHnqJPLZ8CvF0SSoMBBboTb4LYU4sH2EsoqA3X
        LM9WCjp6yE3tHkNt1vODfKQ52nbOLWbj5ujL8YM=
X-Google-Smtp-Source: AKy350ajECs9vlAxp9Zc/RgZFmI0my5+POzp/1L6Jpd0DTDvqtD1z4/8o71AriXo3dXx3BrhelIhPxq8nhB7VZYcmwo=
X-Received: by 2002:a05:6870:7f84:b0:177:b05f:c5f with SMTP id
 aw4-20020a0568707f8400b00177b05f0c5fmr2712997oac.3.1679960796796; Mon, 27 Mar
 2023 16:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230327233353.64081-1-caionovais@usp.br> <20230327233353.64081-2-caionovais@usp.br>
In-Reply-To: <20230327233353.64081-2-caionovais@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Mar 2023 19:46:25 -0400
Message-ID: <CADnq5_M6LEBPVfAXPcVyR-C2qKYrTk=Nyb1cOjGz_Zo6LX9rxA@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amd: Remove unused variable 'r'
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

On Mon, Mar 27, 2023 at 7:34=E2=80=AFPM Caio Novais <caionovais@usp.br> wro=
te:
>
> Compiling AMD GPU drivers displays a warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function =E2=80=98amdgpu_mes_=
ctx_alloc_meta_data=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1099:13: warning: variable =E2=80=
=98r=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Get rid of it by removing the variable.
>
> Signed-off-by: Caio Novais <caionovais@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 82e27bd4f038..e0130536f778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1096,14 +1096,6 @@ uint32_t amdgpu_mes_get_aggregated_doorbell_index(=
struct amdgpu_device *adev,
>  int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
>                                    struct amdgpu_mes_ctx_data *ctx_data)
>  {
> -       int r;
> -
> -       r =3D amdgpu_bo_create_kernel(adev,
> -                           sizeof(struct amdgpu_mes_ctx_meta_data),
> -                           PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> -                           &ctx_data->meta_data_obj,
> -                           &ctx_data->meta_data_mc_addr,
> -                           &ctx_data->meta_data_ptr);

You can't just remove the buffer allocation here.  If you want to fix
this then do something like
if (r)
    return r;

Alex

>         if (!ctx_data->meta_data_obj)
>                 return -ENOMEM;
>
> --
> 2.40.0
>
