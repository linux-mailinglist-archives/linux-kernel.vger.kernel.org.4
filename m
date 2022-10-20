Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4D60614D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJTNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJTNQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:16:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57461AFAB7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:16:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso11366747otb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsXsFIYvDAodNYz1Nmy2Vi1Se+P9Lqr7f28wYKZlDiY=;
        b=lSihJaVhGaXXm3ksHFi4XF5VCkViNanV/8bL/Bs++PXHQEbGsfv+rELLlTNr8aRmbg
         HaP8NWHwNzxVyhPma74QoZk5yy23QJ95JrRropTyptHwUXs3Qot7RmYT53oegQwFDnJU
         Uh9Tjquo7WlN0mbi41L00eftSPkGf1UGo1aBZHgdZfsXoe0QV1ZbW5JxPPgzh7H+BmNO
         6AIUC7ZidonTB/mFxlYQ+AR2BW8jW7hvHXWmwzV6dIPCyml1lxT56kvAWJqYTaFyMTQo
         p5IfARYl/dHeFOIgdFdc2R8wRVbWKX6aPQ4ybbxiyQHuASoAO2EnrwWE6SklqtZAGjBA
         vtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsXsFIYvDAodNYz1Nmy2Vi1Se+P9Lqr7f28wYKZlDiY=;
        b=GX37JcMzHP3k0fyxpipy1gbZu7slk6z9iwlYrdCx7ZoLsNC2IfYoTcklKxYxsOLXKg
         BsJjI7Ln2KBqf1jFVURX2qnQ1hbYLLk0ybjnjQvkvV638wKGQnb4I4PQ/zjb0ydxBzQX
         iHsbFPcohKVVs9curOm7wcADyUkTBKh0iQrkZOLz6Opo3Fn+eqYnICb8Qe+6v0jb+Bgt
         qF5HlJaI3fEMUfXwetLZ90J/+cIV3VbSO+iAYeROI4RwVnl9CNHJNb8z1OmHVO5eGMPl
         5UvNxuJHf82oGGZyMbB2FOdNEdegBgQC7c7xeuk00SrAQFxDbsSgdGkJuTdnCKFGqYGc
         iPrA==
X-Gm-Message-State: ACrzQf25vavLZGqewae39ZDCy/144VOqY2V2CQTEun5glAMzFM+9erR7
        NJ92X57M7yRp7a/XdckaoaK9NdfrL+AK5PV1D+I=
X-Google-Smtp-Source: AMsMyM5nap6y4lQsKGO8rHdv7F2gC+h5H59qOgQ0THliBfMad+ldikYvgxoOHtjNJHBe1CJMu6wOnF1QRZo4bEWF6Mc=
X-Received: by 2002:a9d:6645:0:b0:661:b778:41b8 with SMTP id
 q5-20020a9d6645000000b00661b77841b8mr6970619otm.233.1666271568082; Thu, 20
 Oct 2022 06:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221019062347.3756071-1-ruanjinjie@huawei.com> <8eb93fb6-a1c4-5ef4-f549-8649bb36e59a@amd.com>
In-Reply-To: <8eb93fb6-a1c4-5ef4-f549-8649bb36e59a@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Oct 2022 09:12:36 -0400
Message-ID: <CADnq5_Phr_g-LZtqc2sojEqxyoqWLuo7RhFHHyC2wQsEVRBEiQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: make dcn32_mpc_funcs static
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     ruanjinjie <ruanjinjie@huawei.com>, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        hanyihao@vivo.com, aurabindo.pillai@amd.com, Martin.Leung@amd.com,
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

On Wed, Oct 19, 2022 at 9:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-10-19 02:23, ruanjinjie wrote:
> > The symbol is not used outside of the file, so mark it static.
> >
> > Fixes the following warning:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:985:24: warning:
> > symbol 'dcn32_mpc_funcs' was not declared. Should it be static?
> >
> > Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
> > index 4edd0655965b..206a5ddbaf6d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
> > @@ -982,7 +982,7 @@ static bool mpc32_program_3dlut(
> >       return true;
> >  }
> >
> > -const struct mpc_funcs dcn32_mpc_funcs = {
> > +static const struct mpc_funcs dcn32_mpc_funcs = {
> >       .read_mpcc_state = mpc1_read_mpcc_state,
> >       .insert_plane = mpc1_insert_plane,
> >       .remove_mpcc = mpc1_remove_mpcc,
>
