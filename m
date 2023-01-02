Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49F65AD0D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 05:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjABE7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 23:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjABE64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 23:58:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB049F22
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 20:58:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i15so38697338edf.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 20:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BD2MyA5Fl5hXV25Dz22JtwLdth8U0yqaUY4dAKEj/zo=;
        b=F7dgrvNT0HZeN/kd5R1fXwTJw4dpgidwfbkS86UL6xe3Km7UCjkd3n788jnpTPhdj9
         6aV+nLY3QmnE6ufzPQDZMkwkOtEY5OohWbsjfAG17wVAFhODoZ67i1ZJoTWnuRkHOsAU
         DvOeu2TsEKDJDvs5ibvLmWVQmRWuHXwd4RUzPi36F7BvUa0lbhPLeWd/ekARQFaHcnwC
         T634ZWuqicRQNBiJGpRLtRTS3Rke6JoPB5kg+fIexHPVjbIIzZ/6MNbzG6/4G4mSkVSM
         KUI6ZnJdjyGaoDB7Ai3ZQXZ/v5CS5KLCemyRjCPiScYKSX7aN6io2ETTRxM+STM5/9tt
         Ji3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD2MyA5Fl5hXV25Dz22JtwLdth8U0yqaUY4dAKEj/zo=;
        b=Qanupxckg1GGTt0P3cxkggJaS31iXcAbCOFIWjLy8fuplEAS1c6gB9ywuauLl+MXm5
         ZXZZ0WWHhaW94HpDF2SWT3yCpChPQUZyjUhueo3mj01fKuWfXJBZVS6+rRzR6UJh23gu
         WOrX/+1CDmiEtwbsMIc9A7NienxohGA1BKQxnWQCsYZd6JY2kAyexiGOb1S7B7JOm8AK
         xeAvK2b0POpyfnt7P6cFH8WK96lFe92yerO07JxB8QY7zqi7qbqdtFhEPtZRnsau4cx4
         +1tebpjybFyoxq5bDd9DMxIkmUwzl/Syq6CBlVm55gIC7jeWluAWu9WJ3nlOsaQcdk31
         80LA==
X-Gm-Message-State: AFqh2krTRxbkKxJvkt84n3ZJ8uTOi0+rW1WtzwMb9rTGp67Lr0GeKznK
        j3rvmSOOI7zOVtlEoI93oGIrpPJx+xXqMC3JEoY3Zw==
X-Google-Smtp-Source: AMrXdXtf10HVx31LtO2q9oRMszreTLdQ6uQ4qjQQGfRqKsHGgnl5gH5spnh46VTHSPgl0n4Orcy0tnZCQbn4bwQ26gw=
X-Received: by 2002:a05:6402:5505:b0:481:3f8:b45 with SMTP id
 fi5-20020a056402550500b0048103f80b45mr2740555edb.5.1672635533536; Sun, 01 Jan
 2023 20:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20221231142721.338643-1-abel.vesa@linaro.org>
In-Reply-To: <20221231142721.338643-1-abel.vesa@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Sun, 1 Jan 2023 22:58:42 -0600
Message-ID: <CAKXuJqjiEpxnX_E=HGqEaX91YA7XUmUoaK0NQqXHJCUkcqUPoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 8:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The actual name is R133NW4K-R0.
>
> Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>
> Assuming the information from here is correct:
> https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md
>
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 5cb8dc2ebe18..ef70928c3ccb 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1891,7 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
>
>         EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
> -       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
> +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
>
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
> --
> 2.34.1
>

Thanks for this - when I was looking for the panel, I simply went with
what I found on panel-look.

Tested-by: Steev Klimaszewski <steev@kali.org>

--steev
