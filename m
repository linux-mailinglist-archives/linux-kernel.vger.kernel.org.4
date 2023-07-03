Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE71F7455EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGCHYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGCHYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:24:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E0CC;
        Mon,  3 Jul 2023 00:24:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so4581268a12.0;
        Mon, 03 Jul 2023 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688369058; x=1690961058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YMYA768Yuc+e863XYjfb4koFTu7nhhp3H7iOM5oxBd8=;
        b=AWfclo1YRw8mHr1mBcQa6Al7/lD8qj8v4Tgi6fnK89pioGVIlQ60ccHh5jMJNntOCA
         NnpGoMFZc6MXgHx1tehi4WvvVHBzemLSIUxOxdugmro6IaW4e3LFOZx3cQ4orgtunyJc
         efY5RcAWN0ig2r7V4K4SjstqTNR5Kr9fa/JUxBz19Vo21EYXqKwmmFUtHMbcZi6UKJM4
         eHWRfftpFaCbQiYIrvSezQkFtpB/Y2Q59+cpkRUI4grdA1RrMNt9gzOqBy7tOEdM2vlP
         dO15+StPxy3lyKdjQc3vSBfsvvwmpA2iD2KnSmwoGU0IzT+Co2/GD+XPoKB0RQE8Q8Sn
         GJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369058; x=1690961058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMYA768Yuc+e863XYjfb4koFTu7nhhp3H7iOM5oxBd8=;
        b=CtDPcQQWJ6dIxE9vOWjZy/Gi0lpWy1LXQewk7LuJLUJpk0nAcbqauouWg1ppnvXTJ6
         VpF+tWoGDdIy1znAIv+w/5PH9s8bKYd3z65yXS2s2YUW1CYCUAlP07JaVF3fVrqlnVT7
         tny5slzTK6HNyhlHcmZl3hkI7puujidZlcYhNzNo9vy8Tewidl8Ars5DvRGBoP+ESbsx
         rH0wfHssttl52e0YTbD8gyoDGnzj7Z2IRs5XalImMpejF6A3t3T7H3nknJx7W6PhDrAs
         utJq/wh/MmsOFEvCB7ohMJTmpOpatVsczf3rH5W7TAcrJcRhf2ybtrMISg5GrogWe9RG
         hxuw==
X-Gm-Message-State: ABy/qLaC470NMCr8v9ka4yAaqCiNFJGPtBLSNpKF30Qr7gf8CpIFihtq
        uxLfqGd8nrA7HBpCfQLsSUlbps1eitcBWDMLxMg=
X-Google-Smtp-Source: APBJJlHDxu4653ZbuqiolCCAbs5HQRJeGVyhSAZ7vj84ypDu66Lq3AzthAyfxRrPKN2IAwfrFPOLHG/gBI/eS/a5Cf0=
X-Received: by 2002:a05:6402:14cb:b0:51d:d16f:7e52 with SMTP id
 f11-20020a05640214cb00b0051dd16f7e52mr6090296edx.29.1688369057919; Mon, 03
 Jul 2023 00:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230702133113.3438049-1-trix@redhat.com>
In-Reply-To: <20230702133113.3438049-1-trix@redhat.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 3 Jul 2023 15:24:01 +0800
Message-ID: <CAJhJPsVWQLD_OeL9E0i0e6hdt5i_TPMkvh5u_+u4e9xUbHxFcQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/loongson1: set variable
 ls1x_timer_lock storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
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

> smatch reports
> drivers/clocksource/timer-loongson1-pwm.c:31:1: warning: symbol
>   'ls1x_timer_lock' was not declared. Should it be static?
>
> This variable is only used in its defining file, so it should be static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Keguang Zhang <keguang.zhang@gmail.com>

> ---
>  drivers/clocksource/timer-loongson1-pwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-loongson1-pwm.c b/drivers/clocksource/timer-loongson1-pwm.c
> index 6335fee03017..244d66835508 100644
> --- a/drivers/clocksource/timer-loongson1-pwm.c
> +++ b/drivers/clocksource/timer-loongson1-pwm.c
> @@ -28,7 +28,7 @@
>
>  #define CNTR_WIDTH             24
>
> -DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
> +static DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
>
>  struct ls1x_clocksource {
>         void __iomem *reg_base;
> --
> 2.27.0
>


--
Best regards,

Keguang Zhang
