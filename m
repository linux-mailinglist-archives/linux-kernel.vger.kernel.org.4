Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7FC5BB1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIPRiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:38:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20684ABD79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:38:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11eab59db71so53053436fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+tOYOkayPE4pw1wpaTs3OyuvsxQN/lMZTTuwRcuB/UM=;
        b=dUNEW4All3BK3BtFtJJXok1xM0KU4WHsTRTiUFxe1BmKBGzW5E82wFpfsIBqSg9kBY
         WDQtTmoy9BXGPxNUzhY9z3DevrMrSBNl95fNjxNPziFl+2/GS+6jdo2Rceh53ppbETOK
         c0sWewfiir5HIA4t4ZoaiNC3p4GVj5uo42P/34BTLJwv5HlvzezbQQKLwf0OFkoTBlvY
         bH/7l0m+VoWqBUaaKZoVG7gg2/fR55T3N+qim3QrhZB+qt/aoGaBNgIp7ZWAGTkwuyK4
         DFRdUkA9iuTKlRCH/2KVBA4OwsyT6koD8dx6FudsY6ztBy4rpqvyZ8fkaUBXZ+zYH4Zc
         9APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+tOYOkayPE4pw1wpaTs3OyuvsxQN/lMZTTuwRcuB/UM=;
        b=wk5vEJNEzchALVtBOo7kJ4gG4BLH8F0NOlaaezoW4bn4Pfw0PgVuc2nkFBy0kEycXT
         QEDwaAnuvlllxuOUhJqBzcoOyIBluwToHzKh0atCd75fQm2wJ90PU6RbB3G3q/eW/dAk
         rXWK0QmQCb5VMBLYzsjnUJR3KKEzIqyprdrwE+Ibes7eqSW336aHxHpwIILaaKEmpZdx
         njOErywcCuGTR62AqKtzRiGICJzf7jLt5HEDvgFUzZBd53nKK9BH//OFB0P/sWDc710p
         pU80Zl0+2oYM+vAYbbnzC6Rs6+gMu6PLh1wthNeGRuTnspev/XEmZkPDHl+gkSSLyHJr
         j1Kw==
X-Gm-Message-State: ACgBeo1Fm4Mi66dK6qd0K0+5akOkP8dMDTf5N2u8J9VuWdncmuRQrb+O
        Btr3cRUq7t8T3A4j5CPi3cTCjy0R42soA51SYIQ=
X-Google-Smtp-Source: AA6agR4XZ+diowcGzmlPTzRkgMo5c6tMGbE9Ldj4j+lFCVh+86EkjMWDMfDFz6T/5HIOj2IeSnAMF1+HIosI4ZRwgNA=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr9725833oae.46.1663349886474; Fri, 16 Sep
 2022 10:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220915015802.59967-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220915015802.59967-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Sep 2022 13:37:55 -0400
Message-ID: <CADnq5_MrYpHO406KstV1CPq1HfQOLaV9bEZ=AtOq=i+0RNx0Tg@mail.gmail.com>
Subject: Re: [PATCH -next 1/6] drm/amd/display: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, airlied@linux.ie,
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

Applied the series.

Thanks,

Alex

On Wed, Sep 14, 2022 at 9:58 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> clean up some inconsistent indentings
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2177
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> index 4e3356d12147..8dfe639b6508 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> @@ -1051,10 +1051,10 @@ static bool CalculatePrefetchSchedule(
>                 bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
>         /*rev 99*/
>         prefetch_bw_pr = dml_min(1, bytes_pp * myPipe->PixelClock / (double) myPipe->DPPPerPlane);
> -    max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
> +       max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
>         prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
>         prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerPlane, prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
> -    prefetch_bw_oto = dml_max(prefetch_bw_pr, prefetch_sw_bytes / max_Tsw);
> +       prefetch_bw_oto = dml_max(prefetch_bw_pr, prefetch_sw_bytes / max_Tsw);
>
>         min_Lsw = dml_max(1, dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre);
>         Lsw_oto = dml_ceil(4 * dml_max(prefetch_sw_bytes / prefetch_bw_oto / LineTime, min_Lsw), 1) / 4;
> --
> 2.20.1.7.g153144c
>
