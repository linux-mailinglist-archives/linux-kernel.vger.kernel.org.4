Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399576CB2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjC0XsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0XsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:48:19 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F35C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:48:17 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r40-20020a05683044a800b006a14270bc7eso2152094otv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679960897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uOJzLF5++wuNkGYdTRIM5Imo+cCIkOUu91mcxK3VoM=;
        b=BEXIiX+2N7jyn0zT6SrIbqb3pyq9kKoUg0pavRgLNSD2dNuJP0SnsvDojBtp9m4nga
         n7buh4tfRiFKpjX3AUMrJMlPdV5kTiTXG+WT1XYIDbls/IPVeZhYgyoa5h6iCSlSDFxo
         jenQcOfc/sHV1+0oTgeK6lHYkvyvmb30b0vlwXYOtBybKY+NluOMxPG9WAOYtzqAVy7W
         u1JM0nhEng/1nn1y1MyVcl1gqXBPCVkZQYJlqSdVzzMREJiWNdItKvmW/Ljw06fdzUH4
         vD1rgzKaRyDYElynqN41T1Bhebs9x8qUTJIfpiD1D9bW4VVIIzjmFuAxtar2qOoFHdhZ
         m62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uOJzLF5++wuNkGYdTRIM5Imo+cCIkOUu91mcxK3VoM=;
        b=3NAe4b8TE4NgjhUrcLcJFZWSnnu0jyLHOOIK6FntohJEeozGAjeAnHDb8bsZKL9Zrg
         UOum7Ax9zDuvQHr6WPyebArWfkg9Uhyksqc7Nae8EuOQ2nxtc7e4xPbZrO6zcNJqH/gX
         QE8BApk1Yk4yseTmosnVcXXCXtzwNcQ4DsdmBD5eTibftzLy8tzFCp21aBH7qC0VJFKy
         YmKGSC/HbikdhSNjokLUkMRDgAApUcZQpitpSehKTk8Zmw9M3FlYM+y8lH1xDn1AwBOl
         ltuXh4Tr5ya+EnZuFT5XIlQYM3/Xx3hKAajjF/g0LhjdH69uMczLYYDEJpYozuvHSkDG
         ULwA==
X-Gm-Message-State: AO0yUKWoiSK6UxLeikVYPucD/NccKY56d8BzqMi+3D+L6LQnlyTqtdd1
        fYXbPyvg0+kWDZyTxznMjAIbAa0r7tudVXtZX44=
X-Google-Smtp-Source: AKy350adTHg4TU7FBkltvQF9jydEMHuQrJG7Gz7uoTUxJXaHA05ZgeroITIoceYc0rQL7sJ/+wsdu/CJOHU3MzjOMMU=
X-Received: by 2002:a05:6830:1bed:b0:69f:882:cdb2 with SMTP id
 k13-20020a0568301bed00b0069f0882cdb2mr4519086otb.3.1679960897109; Mon, 27 Mar
 2023 16:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230327233353.64081-1-caionovais@usp.br> <20230327233353.64081-3-caionovais@usp.br>
In-Reply-To: <20230327233353.64081-3-caionovais@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Mar 2023 19:48:06 -0400
Message-ID: <CADnq5_MpPB-V2ZUr7AQDyczuSyJ4=sMCnRSdqEFG9sfBdn1eLQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] drm/amd: Remove unused variable 'value0'
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
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c: In f=
unction =E2=80=98dcn10_link_encoder_update_mst_stream_allocation_table=E2=
=80=99:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1222:=
18: warning: variable =E2=80=98value0=E2=80=99 set but not used [-Wunused-b=
ut-set-variable]
>
> Get rid of it by removing the variable.
>
> Signed-off-by: Caio Novais <caionovais@usp.br>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> index c4287147b853..81aa1631945a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> @@ -1219,7 +1219,6 @@ void dcn10_link_encoder_update_mst_stream_allocatio=
n_table(
>         const struct link_mst_stream_allocation_table *table)
>  {
>         struct dcn10_link_encoder *enc10 =3D TO_DCN10_LINK_ENC(enc);
> -       uint32_t value0 =3D 0;
>         uint32_t value1 =3D 0;
>         uint32_t value2 =3D 0;
>         uint32_t slots =3D 0;
> @@ -1321,8 +1320,6 @@ void dcn10_link_encoder_update_mst_stream_allocatio=
n_table(
>         do {
>                 udelay(10);
>
> -               value0 =3D REG_READ(DP_MSE_SAT_UPDATE);

This reads a register.  Removing it may adversely affect the
programming sequence.  If you want to avoid the set but unused
warning, just drop the assignment, but leave the REG_READ.

Alex

> -
>                 REG_GET(DP_MSE_SAT_UPDATE,
>                                 DP_MSE_SAT_UPDATE, &value1);
>
> --
> 2.40.0
>
