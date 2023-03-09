Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E946B282C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjCIPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjCIPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:04:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E40EDB73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:02:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a9so2242266plh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E0MGjWLn721cR0/harYeOWKmg3qu9859QyP9lXa8P48=;
        b=fW8UhdrAs6zmD+ojpuZV9cNu2p4OyIJSJhf0R667Puj/tTkA5IR8jalbiAG36DKONb
         +zh9NRZX0UBY/1BALE3P1l3864IlmHRVKQVmR7maNgZAZNf1RyYwnsAPXrCCsQyuRJv3
         Au5ZKaPp0TdP9jC9EFhALrIQripT7qAI5WmT9OVIG/3vl24SWsL00o/fDDy6XlCTKuE8
         JI8jbgJ7h7H7CPaqNabm8+LikKl93afkp6vVQ9nX/qMIabv7FT4Iq8NSdDZi+6WlnqHy
         Pibdr08h1+Q5Y2GN3tV80a0EdqNXBSHgKSg+ATLx1MrCDfnEjMEdwy7/aUViH6upSvge
         8O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0MGjWLn721cR0/harYeOWKmg3qu9859QyP9lXa8P48=;
        b=05POwJpfYsyhSfzwAeRLA6ck7PwZPlG0V5OCleBR9EhOgU4x7S5xB1xc8D02x9s/lL
         JjRSX2L1BQ8FDEmQwGzcYyBpm8bUsK8TKpgZy0kjZtdL2A7xHADiqDfjvb9TzxsjUuDi
         d8YFL1r7w0g+jkBfw7+uQqGHBBPMGLpjk79mGzlCZGvOkZzB1+jn7CluB5k7CZIrxV5x
         Df2q3DixbgDfXn3Na4B9IgMqKJzSdLWvAhKzaM9DDqeBR2VWU5pNB+e8gpZqrBuRaxfK
         HgGjgcyepEIDCTZW0Nr6pJitftH+0JXg4r8I3/dxaAwKEFossMywm15ZMtEoxgGbNJJu
         hXRg==
X-Gm-Message-State: AO0yUKWeEdHF0RrKZfd1ShHknLN7Z+Q9JF6e8DDwC4a16PoAv2985eNu
        egUkNlWF8UmJKpfLhBZ1Y6K3zHzdCd8CdG6qw7HueQ==
X-Google-Smtp-Source: AK7set99c7Udgrej4EaTX/HYULDaeOqHfU37Ral93TMAuQrmAqDNDrqYLCZY3LceB9nfTniKnnByXLlgV6KVQrHSwoE=
X-Received: by 2002:a17:90b:e8d:b0:236:826e:4c88 with SMTP id
 fv13-20020a17090b0e8d00b00236826e4c88mr8185787pjb.4.1678374167189; Thu, 09
 Mar 2023 07:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20230306162751.163369-1-francesco@dolcini.it>
In-Reply-To: <20230306162751.163369-1-francesco@dolcini.it>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:11 +0100
Message-ID: <CAPDyKFpSsVrW+95JLF_Am0_Zja2iUe_Ooh68E7oKvB006t0GLw@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci_am654: lower power-on failed message severity
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-mmc@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 17:27, Francesco Dolcini <francesco@dolcini.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Lower the power-on failed message severity from warn to info when the
> controller does not power-up. It's normal to have this situation when
> the SD card slot is empty, therefore we should not warn the user about
> it.
>
> Fixes: 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect debounce timer")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 7ef828942df3..89953093e20c 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -369,7 +369,7 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>                                         MAX_POWER_ON_TIMEOUT, false, host, val,
>                                         reg);
>                 if (ret)
> -                       dev_warn(mmc_dev(host->mmc), "Power on failed\n");
> +                       dev_info(mmc_dev(host->mmc), "Power on failed\n");
>         }
>  }
>
> --
> 2.25.1
>
