Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A775BEAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiITQLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiITQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:11:34 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113F6B155
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2049405otu.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CFL7aF0Lpx3sGV7EQnRPGBaKXb71NBZ9UzzFCX2PLnU=;
        b=XgAcGjAHKfLFS16nM9iiM7B7UtPyyObCuRf2WBRt4DIn/J2kHABErMfKUJgNiIeXz6
         eDPxZJDOPXYul99wfO/V2nUPQKvXAPgXoGYPv7/AGh0ROPmaMjiXVYfPM2frgs6BkKuo
         FSjHDZiJLqr3Cli4CqqDraHHCGAXsEJLbNNtsjVMzCaDI86E9DY1DUvGfpss8cZY2jro
         uDm1n8IDF0IATWb5OCNv0aZRNYuXwuCKXVXXmFu3e0sg7q3Tpq0BDZN7ux80nJOcYimZ
         yYAoWhQHR+uot/VYBVOnXHDfP7GEoXWYmKSuVWja34oYzBb2uqy8Zs32MxNaWCPe7tCT
         IvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CFL7aF0Lpx3sGV7EQnRPGBaKXb71NBZ9UzzFCX2PLnU=;
        b=M3U3MSixlMmOa2p6MNKehNqXJaLiOc3GXjBRoINnbImkzyDo1xSV93caCzT6nVSwNa
         D9hLAcRUTveolIrbwYgir2TwxGKkQGhX5ZyOcckaZQyou5Vo66AplDpCS8h+azTCTqwh
         24XjqsDwaV/u5txDgU40nsaTh70/k4NnZp7W9+Q9cy9O0tS9Iqk9ahyaCj3GKsn2niuM
         +GxQWgfrxFFasbL/JThr/4/vEbm5laThWKZStqDYuiyRSFwS9k2e1xKc99RswO2T+zfX
         T6oZdQ5VCih0cQFkXvVq7N+Jwr6plGEXm/CK7MeQy2dErNEVJbX8VucbrAplazaRX0pw
         BjBA==
X-Gm-Message-State: ACrzQf0yeOYSSKlYW3C/RE8ByyzwH1FY6+2LPFwMZbImqooBw0moA4Zw
        0NzoHDFRT9q+bla0Ie/V11BcXVh9Yt6MU0io8/s=
X-Google-Smtp-Source: AMsMyM6A0fKosrNPb6aIaCncIrF3lfn+IGCf3YGllsL/BcIc5fpjbW3Yq75JpmRUqIFBJu7g3jiYBKlN9DtGV3Ccrag=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr10670481otv.233.1663690290428; Tue, 20
 Sep 2022 09:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220920063600.215257-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220920063600.215257-1-ye.xingchen@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 20 Sep 2022 12:11:19 -0400
Message-ID: <CADnq5_PB=z9JeVV4c1YC6hbAXXvHPLbD=kZvOyS1QxR-WMU9Gw@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amd/pm: Remove unneeded result variable
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

Applied.  Thanks!

On Tue, Sep 20, 2022 at 2:36 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value atomctrl_initialize_mc_reg_table_v2_2() directly instead
> of storing it in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> index 45214a364baa..e7ed2a7adf8f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> @@ -2567,15 +2567,13 @@ static uint8_t polaris10_get_memory_modile_index(struct pp_hwmgr *hwmgr)
>
>  static int polaris10_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>  {
> -       int result;
>         struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
>         pp_atomctrl_mc_reg_table *mc_reg_table = &smu_data->mc_reg_table;
>         uint8_t module_index = polaris10_get_memory_modile_index(hwmgr);
>
>         memset(mc_reg_table, 0, sizeof(pp_atomctrl_mc_reg_table));
> -       result = atomctrl_initialize_mc_reg_table_v2_2(hwmgr, module_index, mc_reg_table);
>
> -       return result;
> +       return atomctrl_initialize_mc_reg_table_v2_2(hwmgr, module_index, mc_reg_table);
>  }
>
>  static bool polaris10_is_dpm_running(struct pp_hwmgr *hwmgr)
> --
> 2.25.1
