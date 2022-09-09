Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098F5B40CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIIUly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIIUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:41:52 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BD103010
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:41:50 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1278624b7c4so6992912fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Aiun8CusNgh/PUTHR9vRms66+k6qtenVsahGU6Eq63U=;
        b=U3vXka7eQa25N8VZDHmT2KsIz/3SRsNUo+WH1qlg5ulr1RjX7VaO57gV+TWUuBeqxX
         y2A3oJsm7Zs8Uo6IZHsUBsgdEgR6BMgCrCYZKvRbJ/svLnYEIU4OXJu9g9GNmcoiePMp
         XzfOHxcoPYqyAmjrYu8BauNhmC7zmG+HHQjOgaJ1+NKTTBd3TvDk7O2M2icxWRIBMTiA
         h07E0BUIb2YJt1DqWrr8QuaxWic+ae2kGr5mFYkeTKPi4l3C5z8gE53mRl+l73FbMfgv
         7oYCLHffsHYpS2TatLwoMEt8mWo+Jq6JxGeM90kilnsA3Wh+iJUXY9XZ79Eyb7XzJPaC
         Yhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Aiun8CusNgh/PUTHR9vRms66+k6qtenVsahGU6Eq63U=;
        b=n9xonB4Cj4FzBt/XhD627YRoXII0wa5P6RigPIqki9v/+NNe+D3jaOiWpgiYG+XYiG
         AGelEgzI+eL2UHNiR2xqiyFUy6O8VgtnLLcXQTNU8685/z6FpPWK9ZSebkGBABrkiMcY
         Kb3LZz5dbY0lvDy9NGwDM+kAskG0zINaPZfd7pTd0NfTJ3fjfi1Eg0WDFdAjd3M2GYl3
         L76WRkfSGEDv9iQo1MJi2ZIjqu/RZPGvj/5/0wvEkRQHRyyH64n8TGawWSRVkxvUS9jN
         4lR2+xyZSW8es1QzyHQqxFSXMg6GODTpqC6/P4LvN4pW8RJ+0fXTVtYJmKBzzIgnSLjm
         U7CQ==
X-Gm-Message-State: ACgBeo3XeaV49UU5YFFiMN1MeCGh3dsAiGqY21G4sXKqGvNrKOHCxEcl
        Z2guv0RvpJNOnnL/xXyere9iT9vnfuNpO990O7N2fWsN
X-Google-Smtp-Source: AA6agR52Zp70u5YUKPMxE2dP1G33FINV9iw1YeREdDxeoQMi1BG1aPSMAgRE0quDLePMj29oK37xQPmS63XdBPnY3sY=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr4797981oib.46.1662756109694; Fri, 09
 Sep 2022 13:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220901075655.57494-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220901075655.57494-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:41:38 -0400
Message-ID: <CADnq5_MuAXcCZ6aeRSzuCjsw12C0eYR0_2FWYynMOdx4ppvcgA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Sep 1, 2022 at 3:57 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> This if statement is the content of the for statement above it. It
> should be indented.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2026
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 9dd705b985b9..0139e98a0aa1 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -417,8 +417,8 @@ void get_subvp_visual_confirm_color(
>         for (i = 0; i < dc->res_pool->pipe_count; i++) {
>                 struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
>
> -       if (pipe->stream && pipe->stream->mall_stream_config.paired_stream &&
> -                               pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
> +               if (pipe->stream && pipe->stream->mall_stream_config.paired_stream &&
> +                       pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
>                         /* SubVP enable - red */
>                         color->color_r_cr = color_value;
>                         enable_subvp = true;
> --
> 2.20.1.7.g153144c
>
