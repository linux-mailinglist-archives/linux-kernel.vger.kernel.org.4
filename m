Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4065B40FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIIUqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiIIUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:45:32 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94941F0293
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:45:28 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11eab59db71so6943553fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tOdRgYvMFlVvpQnahbCAQyXuE1jXNRZy6YTJYdfO8bM=;
        b=evoakfqiZyhcmJuEoRga7NxRItRPui2yzHJFAgO6t0gIs26+wvDsrsmxfHii3ADjhJ
         eu/BBpJRNtexNYvHhsFHMxVJt91BpNrHsRJV3v9BDjPII7ZgEteYwmxhYlI0nZ5uYCy5
         +s53CNK93XBwAGlqzL5oX+K8QrkVXNvvszxXoJQ4lEXY0B6PvRE7YtvlqUPLBi78XNva
         QjdryoLOTSjVV7EVda/9ok2xCqh5gm2JOrs07z050ycG2LL7s+xB6Z5mXuFU0w8aEbXO
         XudeVFtkSXXF2y7n9RuWglet2Vmaa9Sg/vSpDzJXQbgI+zVaGhqfSF0/XlaXefDROPoN
         dDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tOdRgYvMFlVvpQnahbCAQyXuE1jXNRZy6YTJYdfO8bM=;
        b=bq3Bo/M6lK3AQqbg620QPDW21cxn2AAE+1LjkKpKrOicJngLsqznWlhwa8/3mJupWT
         2RPLe+WC6k01sYW3tf5fcJoRbCW+QYeTm6eOgC74tcwE5209bXx4W799eVZGMNqdV0KD
         5l06cG8R0U/UYlotsXq2jgigcRvm2bgVqvKw0DRAw2V6iMfYAYciIASGFMXTqVzSbJVq
         Jy76enJMq4rDQ1CebVvrM0Mpw53m5k5yG9WnJpKkmmOWhCarZJUHaR1AWIvbLlYsUZop
         jjg/01/y434mWTyOVMbPS6F9R/lNzS2y3nVC9+Bu+5Yh3opaNe4fuSFEpusyHgjfcNT9
         3m9g==
X-Gm-Message-State: ACgBeo3rfeIjjPa6plNXVV23TdpGGRQYuL0ohPJOYTylmIzHdv+rSwf7
        Cm6KIIATfJaISCFBNKceWktXt896VL1Sb5lohd5jzy2c
X-Google-Smtp-Source: AA6agR4yYTNYn71J0gE6HKkRJgbKG9w/kkqFkg60ldADXtpcZU9V7FQ9hBdiCXoc9DXJOhTCF47K6xTBcZGB8mX/yPI=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr6007604oam.96.1662756327135; Fri, 09
 Sep 2022 13:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220902073148.319536-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220902073148.319536-1-ye.xingchen@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:45:15 -0400
Message-ID: <CADnq5_PocuJB0s+mg8sMgRK7pdzVQR_N0hsajYMgihuZ3fMGFw@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/radeon/ci_dpm: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     alexander.deucher@amd.com, airlied@linux.ie,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

On Fri, Sep 2, 2022 at 3:32 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value ci_load_smc_ucode() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index ac006bed4743..8ef25ab305ae 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -2056,7 +2056,7 @@ static void ci_clear_vc(struct radeon_device *rdev)
>  static int ci_upload_firmware(struct radeon_device *rdev)
>  {
>         struct ci_power_info *pi = ci_get_pi(rdev);
> -       int i, ret;
> +       int i;
>
>         for (i = 0; i < rdev->usec_timeout; i++) {
>                 if (RREG32_SMC(RCU_UC_EVENTS) & BOOT_SEQ_DONE)
> @@ -2067,9 +2067,7 @@ static int ci_upload_firmware(struct radeon_device *rdev)
>         ci_stop_smc_clock(rdev);
>         ci_reset_smc(rdev);
>
> -       ret = ci_load_smc_ucode(rdev, pi->sram_end);
> -
> -       return ret;
> +       return ci_load_smc_ucode(rdev, pi->sram_end);
>
>  }
>
> --
> 2.25.1
