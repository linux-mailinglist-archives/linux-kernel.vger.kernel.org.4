Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4018B5B6DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiIMNBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiIMNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:01:37 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB42228C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:01:36 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-12b542cb1d3so22091599fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Egq3TEXftTCJHVvcDfROaTHHjIMkOHhmY4MYJgUqpWQ=;
        b=IkYoOc4wWT22pJ9fC+4oRYo0mk+0Jkg6ujt7YjIOFF1VBj7HNkFGvXg2n19hopxdH1
         ioQg9GrPo1NMvYUVtbvmYyF9uDwDFCkxzZHiaXDuGszuvGbwCpPu/blKETycs3jTEjY3
         NZu1aPRoNYlrkJ0E48Kglav5q3KbstekWQtfjLv5JL4F1a1Y93yMsy7fXYoH0umdQv+R
         +CP2Biq3F6XRW3mog4/A1qA1bcd96tQuwWJM0laeT+s9BjSeGLVozIAQZbm/ifctH7H0
         fJ31YaMEpT+XuFsJQM4TkVYZy0dzT+5+RKn1Ia/Oa+cIoecUP3MsurqMRNbLAgwKQl+7
         0q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Egq3TEXftTCJHVvcDfROaTHHjIMkOHhmY4MYJgUqpWQ=;
        b=ZjEO981rWZCG1st5kFRiQCJ/uW0PvH/9cpe/dT/8N5JdruijqakxUqR4VDed20UjRX
         kgfHVxYt2I867q7XE9s5kzeH2eLBb3Ggj8m3U+DrBYKbteKrLh89lBmSf+nLpzvYbRHO
         OAplbL/5FdznXvTNtY07b3y3/vwRUI+c7mKfGBKSCzPWYAkswX8bv79ZLwMdhFyYdhvi
         n7AftFHITFd8YPFfB40m73PDdcBqBRRum/P6vqJY/JdLr8Fiw4nFB5jeaf8XG6R0Bfgp
         rIYWIiclFZDrys67WPg6Zp0szic0Tn/4D/Avur3eY8V2BiWLyN3B3vYbgC41/wg5OlVT
         Clgg==
X-Gm-Message-State: ACgBeo2K3n6Dv9eA2YE4azfu92n/igwu2ljQ1LYOGLjVESg3Il/Zad96
        wYsbjL/NZXfBryK5WHDCEQ9RCaTa4MSIxSZkUks=
X-Google-Smtp-Source: AA6agR4FjusHCwayFdOlxCIojR/3f7ct8RZVroGn3bNBezA+eIWEwxbO0vSF7MMqn8xxiXfkohKS+WVlyhevJEMQg3g=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr1711917oam.96.1663074094492; Tue, 13
 Sep 2022 06:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com> <20220913083805.22549-5-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220913083805.22549-5-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Sep 2022 09:01:23 -0400
Message-ID: <CADnq5_OGB6jVp34oWRxRHJneK-+UZo-oRm=ydO2Rtv3=ekHgdA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amd/display: Remove the unused function copy_stream_update_to_stream()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, airlied@linux.ie, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Tue, Sep 13, 2022 at 4:39 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function copy_stream_update_to_stream() is defined in the notif.c
> file, but not called elsewhere, so delete this unused function.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2852:6: warning: no pr=
evious prototype for =E2=80=98dc_reset_state=E2=80=99.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2113
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 9860bf38c547..2ee0b5a2ce62 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2849,16 +2849,6 @@ static void copy_stream_update_to_stream(struct dc=
 *dc,
>         }
>  }
>
> -void dc_reset_state(struct dc *dc, struct dc_state *context)
> -{
> -       dc_resource_state_destruct(context);
> -
> -       /* clear the structure, but don't reset the reference count */
> -       memset(context, 0, offsetof(struct dc_state, refcount));
> -
> -       init_state(dc, context);
> -}
> -
>  static bool update_planes_and_stream_state(struct dc *dc,
>                 struct dc_surface_update *srf_updates, int surface_count,
>                 struct dc_stream_state *stream,
> --
> 2.20.1.7.g153144c
>
