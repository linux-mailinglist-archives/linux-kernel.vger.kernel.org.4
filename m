Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703D55BEADA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiITQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiITQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:10:28 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD4E10BB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:10:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r125so4302129oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UXjaeEik90YzXeLDR2W4WjZVnnFwHMwroQ6yWKNSRgA=;
        b=T9cdH6v0/SKVdljrr56ri4Rz6BWh+Z2maSeep3o/Wy4lglPjbxhUnt0+188DQ9W8vR
         FxkLw2KDhxGMqlerWZb+YlQqG7p4wH6RbiXp0ReVW3LYeNVuRf0cc3oLCMhYmfNc5B8O
         /8CacwwkO4KyPMTPRugvNO+wpUlzob6Fz2403wCtYVA89z5iXgnOg5eoXRg1IEjYfX7r
         LG8wrLyzdo38dHCQZtkSEOFXq3zjyHtm4FLKNTpX37miXFWVVdS3e7BJXw7DhK4QbbDq
         iOOavo63+ACY1QhQtaLRznU9URM4gSV29mYw+BT7AkRE41Djj7wHKDqbPoioJPtnKmhj
         yaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UXjaeEik90YzXeLDR2W4WjZVnnFwHMwroQ6yWKNSRgA=;
        b=MUTNPiPTwzM5Ef9EuzXKFd1VZuMOMgkWrGgRvEhMeMz5/QobWvKlx01AXs1h5UV2fD
         ZK2ITpBTXlTNDdkt4/S4TP/lBkoQsYmxbRLF9XyeGGWy+IhRfii/XgvAAT55j0uPggjP
         xQ9kLFSmhplr6c39eymXe5tLcxPdqMhf0qWxA6kPr7blwiJa3SY/ndl3PJG49VWF4Hni
         PxctEjio4HPzyE+iQpF/u3F6ImKcbxLRJTpWmP4KnhVYtxPyA4yVcip4PEdqy7PQrzlH
         Tjqve625t0K9Y4BUlllwP5YjO0BXop5TpZvYWetXtVJWzCLgkJxceE4ByC3JeAGyUZ0W
         t7MQ==
X-Gm-Message-State: ACrzQf2ZGbUKdU8rnt4pN5EU7BoAXljoyeUWDi3IjplyLzGUXai+Q2YR
        9cjcKsuK38islhVGEnmbKF+pTwMaDuEZLMoA9G3hzMJC
X-Google-Smtp-Source: AMsMyM5RRkIjKFuqLc2MRgC2GoMfxwkEDftEddw+q0j18vgSxojkeoXJDTSg8dASbarhqiwRe12QKnFaGiSp7RSy3hw=
X-Received: by 2002:a05:6808:2390:b0:350:5c6b:5ef9 with SMTP id
 bp16-20020a056808239000b003505c6b5ef9mr1985622oib.96.1663690226955; Tue, 20
 Sep 2022 09:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220920063503.215199-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220920063503.215199-1-ye.xingchen@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 20 Sep 2022 12:10:15 -0400
Message-ID: <CADnq5_O8DSAGzbjhz-2XD6tkAQmWMGM1d7YBngzGEmf0w-trdw@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amd/pm: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     alexander.deucher@amd.com, airlied@linux.ie,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, evan.quan@amd.com,
        christian.koenig@amd.com
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

Applied.  Thanks.

On Tue, Sep 20, 2022 at 2:35 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value append_vbios_pptable() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c  | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> index 1e79baab753e..bd54fbd393b9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> @@ -195,7 +195,6 @@ static int init_powerplay_table_information(
>         struct phm_ppt_v3_information *pptable_information =
>                 (struct phm_ppt_v3_information *)hwmgr->pptable;
>         uint32_t disable_power_control = 0;
> -       int result;
>
>         hwmgr->thermal_controller.ucType = powerplay_table->ucThermalControllerType;
>         pptable_information->uc_thermal_controller_type = powerplay_table->ucThermalControllerType;
> @@ -257,9 +256,7 @@ static int init_powerplay_table_information(
>         if (pptable_information->smc_pptable == NULL)
>                 return -ENOMEM;
>
> -       result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
> -
> -       return result;
> +       return append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
>  }
>
>  static int vega12_pp_tables_initialize(struct pp_hwmgr *hwmgr)
> --
> 2.25.1
