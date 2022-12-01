Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD063EE5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiLAKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiLAKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:48:18 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CAA06E1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:46:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so1302899pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6jwZZ22v6VgjNwNsN5/RPhF3k+QJnNn75TOznSm9Ko=;
        b=MR/YWUlXQ+WQLNW+qzlvV8edNDljw+t18L+sJQFNsJVYJ+y72rK30YA2YfHCty205+
         0HUJE7YNNdbF2btb1xv0zVIGoJ/8/dbklNKA1i2uLDGSCWQy6SMIr61wNhUDXvNvutVh
         866pl8a+NqwP4kYk9CKDnGzqHcgK55c843vY6o0xw3S0TfbBwDCUEHVf2k/J7Shkxj3H
         KoCOEyYHHVXeIQzdlsJIYMYlzz04FNXjyLI9wBsqGQnm8f63liRCPLXtK3BmBrLZ/dTy
         pBcVpclhnB+/uTNOjn00ZChaQSmHia9WLXeqjrfb+6Whn/pMn5PnttC5+wWuw0H1cJRN
         zeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6jwZZ22v6VgjNwNsN5/RPhF3k+QJnNn75TOznSm9Ko=;
        b=6YBbapxj6PCdqeDV6Y6kkcpDh37xeedWVWK8/6Q0M2nG0ebFB+nvEu1Wlr92BJyPRa
         GRjKnpiTDGpgTsMQGr/3NICC0vQF3ml55AkHMy+dInJwMzcAU7jXAF/oJydZ3BsZ0mBw
         fT8uGB/yy3ex4kMSKhCmFN4BCfPzx0tQx4wk1vIQ9MvB64z8wFWCoUAHuCI8TulJoo16
         Autg1KlcrlJs2CudPke16prXDbAA509VDjbqmQk/iTz4rYXeJ0rKWwnpjdwvxt23oBA2
         LGvscL7vSUwsa0JaIdvkI+fCfebNGN4AJ6fNdNFwJJiNusk6+Xr/L5xNgDzFuFg8CENj
         CoMw==
X-Gm-Message-State: ANoB5pksb6eApue+XClmfyCN/ozGT/F42svh/v4OwoHBI8WiyL2q9OIf
        Fzmqf1hAaH613ybvLCQzcF9eXu80K9myrA4YW6KtNA==
X-Google-Smtp-Source: AA0mqf4foylhYdJfuCXchn159KTlnNvnmUOJ40C/LHBs5OgMlVbSw9jlycgDuF6ZmyOTvgRjJDLoTkFvh4FJH1xfWUk=
X-Received: by 2002:aa7:87da:0:b0:575:2f34:29d4 with SMTP id
 i26-20020aa787da000000b005752f3429d4mr19425069pfo.40.1669891600690; Thu, 01
 Dec 2022 02:46:40 -0800 (PST)
MIME-Version: 1.0
References: <202212010926422966197@zte.com.cn>
In-Reply-To: <202212010926422966197@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Dec 2022 11:46:04 +0100
Message-ID: <CAPDyKFp0joh5Hqj_iS5UPmXFUrs2Ws9an=-kfv5Yc+wvGq7L_A@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: sdhci: Remove unneeded semicolon
To:     zhang.songyi@zte.com.cn
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 02:26, <zhang.songyi@zte.com.cn> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> The semicolon after the "}" is unneeded.
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Please run checkpatch (./scripts/checkpatch.pl) to make sure there are
no obvious formatting problems with your patch. This time it gives the
below warning, please fix it and resubmit a new version.

WARNING: please, no spaces at the start of a line
#79: FILE: drivers/mmc/host/sdhci.c:2292:
+       }$

total: 0 errors, 1 warnings, 8 lines checked

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42aaeabcad22..8413180a1039 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2289,7 +2289,7 @@ static bool sdhci_timing_has_preset(unsigned char timing)
>         case MMC_TIMING_UHS_DDR50:
>         case MMC_TIMING_MMC_DDR52:
>                 return true;
> -       };
> +       }
>         return false;
>  }
>
> --
> 2.15.2
