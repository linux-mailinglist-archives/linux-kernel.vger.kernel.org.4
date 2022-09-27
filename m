Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3B5EC235
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiI0MOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiI0MO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:14:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6568AFAD9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:14:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so14735212wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JEiHz/34anv+sw3YKePZRjvV+9euJIIIAjKXG/xyX1c=;
        b=t/+7n69a4OmAhKy+ZWE+4OQ2hMUftmYmgtIOEk57+qqwu7JzJRaIUREi2L/JQ1n/9S
         eyky4GOl6B2rnoZizxF4MKwqzMG6xe5aFTDTpPislQe3Gx9iVHcKxAlYJ5HMNJTVphlE
         ZIBhYwxeJWARxeNBjVFt4SE3GomnHqbJ42peP0Iaohmk0b7UPb2VsbfKAbi/Ds17WnJV
         Le0JoDm0L9loO6d83+AB1yIlqETsZVeqc3Fpztiac1aDbQ4kcYpPJm7ybECGTtwvKQ8H
         V9V8+OFSfOqxZ94RB8Oc7e2GuZdekCldDWtFIecz+Ot8SVW86Id31SEXQs9MBBN4y/0A
         A85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JEiHz/34anv+sw3YKePZRjvV+9euJIIIAjKXG/xyX1c=;
        b=ktLO4GFVrhsYXbwkx0E1n7KsQ6/myXS5dv8yWbrh6hE9XrZgTYjdL8FJ2DZV9h3do8
         IKAuMoCnZUMpqNZ86zrqPMnerwYDq8vEMkHDCKpEuyBE6gIx7CZVB8RU94y0vyMbxRcG
         CF/dNTFZpfuRN2tDhK0nipk+6a6yQXhH0HDVCJRptOSgRirAOuc4sV5McNEmy2Vv0QHa
         2D6D5tg0hHQKPmvY9n1UhlgAGrhcnNqu3SwKREW3lLAWshrJsTq6rVT2+3T5bRBYef31
         P2exi/3fAASm61mGjm3/2RzsbKFDcxG6w4OZ3ZnC0VZSquTsPd1QEknxhhtb+SVWfS1t
         0U6g==
X-Gm-Message-State: ACrzQf2OG34iQmc3JHdyugWUhK/OQHimEyJDAafuRjz0mHWilZAWId7y
        BJdjoYHw3QkyVkx0pwnjKa5eDqJTy1O3tE8dQ+KbS/Ji1s8=
X-Google-Smtp-Source: AMsMyM79n3MIxjAoajTxuCPqGzixd4TjlcvHFd3QhhkoLQkaGt20dlcjC/18m/goKhSip4RrtZLqjN+0za+VfNrY78M=
X-Received: by 2002:a5d:6d8e:0:b0:22a:4831:e0e with SMTP id
 l14-20020a5d6d8e000000b0022a48310e0emr15723503wrs.442.1664280864867; Tue, 27
 Sep 2022 05:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220923065005.20062-1-kishon@ti.com>
In-Reply-To: <20220923065005.20062-1-kishon@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:48 +0200
Message-ID: <CAPDyKFqxAaoC0+PQFdWN_ovgsn-ti2HkWH+2g056EVVwm7gJ-g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Vignesh as maintainer of TI SDHCI OMAP DRIVER
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sept 2022 at 08:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Add Vignesh Raghavendra as maintainer of TI SDHCI OMAP DRIVER.
>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Kishon, thanks for your contributions during the years! Vignesh,
thanks for stepping in and helping out!

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c368f5aa7429..ffad3f1dfe9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18302,7 +18302,7 @@ S:      Maintained
>  F:     drivers/mmc/host/sdhci-spear.c
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) TI OMAP DRIVER
> -M:     Kishon Vijay Abraham I <kishon@ti.com>
> +M:     Vignesh Raghavendra <vigneshr@ti.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci-omap.c
> --
> 2.17.1
>
