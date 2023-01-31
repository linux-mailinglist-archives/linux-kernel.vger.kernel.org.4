Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBDB6833C5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjAaRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:22:55 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308549021
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:22:31 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-163adf0cfc4so8987238fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ4ivKCSSjC/nsEprnt+8Zq1TU7NBjHqzheuppe5Hlc=;
        b=aubPHj9Bqdk7dreN5BitMQndcJvpdoL/53VtmiC4laWRWmkd1Yb7Bnxfw+uMEMJhJh
         9ADBdMjJKGhCV6HuPnQID9W4steAnGR8UVEq6U7ewy3gSnAvSAeUWACXvwI4oV2rJ5to
         S5sxFbTMLLw2ASIQDFRgwEi3pS1QZA0z9+yjp7KNZNURvy4lJGBxChLjLYRbl2StshA9
         tnVZplvBEGTSjJ7DglZc+sOkeAcwkMlULANmxMZzWjlWRdtW68WHxGcaQ2TCErxxwonX
         AE5m1o71AkIr47TRynvJ7W7KU91zvit13a6YYwB6L92aBzYyBu9arVX1mn8+MtjYtq4e
         qEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJ4ivKCSSjC/nsEprnt+8Zq1TU7NBjHqzheuppe5Hlc=;
        b=ZSHNl8gDtuambSCYGJZNA37VI2zC5wK8Uh1FczczupERfmYbxvdByq52SdhcFyB64Y
         +nY2BldTELCF17Ke7TeoTipJHloMQ7ZwBbbXXyaV2A/h8XDePosT4W9vpUNva7bKhVpy
         oYaiTRoO8sxSt9AZ7r3Vm2Gq2T/Fyxg1lRWl2jyUFyXpAqJK5DwkkLQecfWurGigmgGH
         v8O0e2PG8gbz0IpWkpnIKPneRQf7315kY+r1JpRAjRSr8ecoX4wyyAMXFksi/EqUxQ1K
         m190RGJ4OH+qUX4rcZwtgDwVu2kkAkh/G4fM88SBXaHztY3pII/L5AO42qaPU0XJrR81
         U+Xw==
X-Gm-Message-State: AO0yUKU8PjFQRmwDMkhdFJJTfOpHEwnhsZfoPyVZ68yN2I/vWkyEeI2e
        HgebzOxbykj5mEw5vMkQq54lFCP7LqVgZEvWLms=
X-Google-Smtp-Source: AK7set/L5JhayGONTYLQxHrTfP9o0V2pHohgI/C0z5ya1GYvsguIk4c3xqh5rQSPnSuia4QPomH3wrYxML1a5IHYTQo=
X-Received: by 2002:a05:6870:b522:b0:163:8cc6:86a with SMTP id
 v34-20020a056870b52200b001638cc6086amr1618651oap.46.1675185750411; Tue, 31
 Jan 2023 09:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20230126204935.819030-1-trix@redhat.com>
In-Reply-To: <20230126204935.819030-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Jan 2023 12:22:18 -0500
Message-ID: <CADnq5_NKPO3gEST2oqp9bB77y2iFHtvnNzKnnT8dSVTAEzY=bw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: reduce else-if to else in dcn32_calculate_dlg_params()
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jun.lei@amd.com, Alvin.Lee2@amd.com,
        Nevenko.Stupar@amd.com, Dillon.Varone@amd.com, george.shen@amd.com,
        rdunlap@infradead.org, David.Galiffi@amd.com,
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

On Thu, Jan 26, 2023 at 3:50 PM Tom Rix <trix@redhat.com> wrote:
>
> cppcheck reports
> drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1403:76: style:
>   Expression is always true because 'else if' condition is opposite to previous condition at line 1396. [multiCondition]
>    } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
>                                                                            ^
> drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1396:69: note: first condition
>    if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type != SUBVP_PHANTOM) {
>                                                                     ^
> drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1403:76: note: else if condition is opposite to first condition
>    } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
>
> It is not necessary to explicitly the check != condition, an else is simplier.
>
> Fixes: 238debcaebe4 ("drm/amd/display: Use DML for MALL SS and Subvp allocation calculations")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 0dc1a03999b6..c96cbd88e20d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -1400,7 +1400,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
>                                         /* SS PSR On: all active surfaces part of streams not supporting PSR stored in MALL */
>                                         context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
>                                 }
> -                       } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
> +                       } else {
>                                 /* SUBVP: phantom surfaces only stored in MALL */
>                                 context->bw_ctx.bw.dcn.mall_subvp_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
>                         }
> --
> 2.26.3
>
