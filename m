Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47C5F72F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJGC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJGC6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:58:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79DFF8DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:58:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 129so3484975pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHqtVs8j+ID4jgqw57yAt3FtHMv/XStpjtf/AugVE1Y=;
        b=FhXOA3SGFnbaWCxieNMDC1nYdp/i+xNk1Qz42dQC7LPITUdJcbeCD8MXgS1lEAl+Ff
         4Q7YoMcKPvYOvGsh593C5ovx3865nXrA4jLf7wZ6cTMZUoq9waJYSMYXPSQEZ+w3HOfW
         SISSGdo5Z4e4aPv8ylbZrhV5D33e1LqZ6TLSZgZCWwGJxqu9Znv9u20bgyXS8gVa0ASs
         6oMiHtBzpvqB4UNYNn2PU4RhiMUmuVPtXdpJnizixXLqZONDEPwtTxWTvvvXE6FfdHDg
         qTnnVa5pvh83sPhZySmfb1IUP1QM5OkEgfI1ZDKgrJT5AWmx6IBhYMpJj9qfGXXUNk4O
         NuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHqtVs8j+ID4jgqw57yAt3FtHMv/XStpjtf/AugVE1Y=;
        b=CMURKYeQEK+NdzyYtwNvayIvMxNKHoVzKa2Oex5u4w9/cVyKiFyBy60MDBSBcX+53X
         TYA1iL/r+V9p/52M93N8nwkcXJQoi2daGBMejxsdjJWX5bpqoaIxEZQO1Lp4ITXPophX
         dYBab1odUn5xBzcFGenmHc2uFzgAdZJeTy3bZxnKOJBMElye0xIaRTd/hnSMhpS8uFsz
         6mmhS4PpBEEPUD2zPg43O6Nyh+nrualXiRb81Epd0pw63C7ODWlkeHUFu6c7DBK+4fr7
         nCgqCzBjEZpMZQQQTFO34+c/cFIS92Ow75MH6rHuaseUYl977P1c73tT48WXZugIXnG8
         hr5Q==
X-Gm-Message-State: ACrzQf1HdtmaQSuUVHb1WE4NQtJW7IsjcgDuAgBjZF1rXbiJqmgoZX++
        q9OHOppVctbyHSmPpqmRPLtyHQ==
X-Google-Smtp-Source: AMsMyM53dmoZUhAeR2ad3+PvCeAPrlnhjAul4X/Pb1ufZcrCsgu+iGRJpvj0OGds7mcXRXSYxl4bQA==
X-Received: by 2002:a05:6a00:14d3:b0:546:e93c:4768 with SMTP id w19-20020a056a0014d300b00546e93c4768mr2621000pfu.36.1665111487824;
        Thu, 06 Oct 2022 19:58:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b00172f4835f60sm333199plg.189.2022.10.06.19.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 19:58:07 -0700 (PDT)
Date:   Thu, 06 Oct 2022 19:58:07 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Oct 2022 19:57:50 PDT (-0700)
Subject:     Re: [PATCH 3/3] EDAC/sifive: use sifive_ccache instead of sifive_l2
In-Reply-To: <20220829062202.3287-4-zong.li@sifive.com>
CC:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-fe7df193-2cac-4022-928d-a18e63f5e1c1@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022 23:22:02 PDT (-0700), zong.li@sifive.com wrote:
> The sifive L2 has been renamed to sifive CCACHE, EDAC driver needs to
> apply the change as well

That means the build would be broken before this patch, which we 
generally try to avoid as it breaks things like bisecting.

>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/edac/Kconfig       |  2 +-
>  drivers/edac/sifive_edac.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 17562cf1fe97..456602d373b7 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -473,7 +473,7 @@ config EDAC_ALTERA_SDMMC
>
>  config EDAC_SIFIVE
>  	bool "Sifive platform EDAC driver"
> -	depends on EDAC=y && SIFIVE_L2
> +	depends on EDAC=y && SIFIVE_CCACHE
>  	help
>  	  Support for error detection and correction on the SiFive SoCs.
>
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> index ee800aec7d47..b844e2626fd5 100644
> --- a/drivers/edac/sifive_edac.c
> +++ b/drivers/edac/sifive_edac.c
> @@ -2,7 +2,7 @@
>  /*
>   * SiFive Platform EDAC Driver
>   *
> - * Copyright (C) 2018-2019 SiFive, Inc.
> + * Copyright (C) 2018-2022 SiFive, Inc.
>   *
>   * This driver is partially based on octeon_edac-pc.c
>   *
> @@ -10,7 +10,7 @@
>  #include <linux/edac.h>
>  #include <linux/platform_device.h>
>  #include "edac_module.h"
> -#include <soc/sifive/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_ccache.h>
>
>  #define DRVNAME "sifive_edac"
>
> @@ -32,9 +32,9 @@ int ecc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
>
>  	p = container_of(this, struct sifive_edac_priv, notifier);
>
> -	if (event == SIFIVE_L2_ERR_TYPE_UE)
> +	if (event == SIFIVE_CCACHE_ERR_TYPE_UE)
>  		edac_device_handle_ue(p->dci, 0, 0, msg);
> -	else if (event == SIFIVE_L2_ERR_TYPE_CE)
> +	else if (event == SIFIVE_CCACHE_ERR_TYPE_CE)
>  		edac_device_handle_ce(p->dci, 0, 0, msg);
>
>  	return NOTIFY_OK;
> @@ -67,7 +67,7 @@ static int ecc_register(struct platform_device *pdev)
>  		goto err;
>  	}
>
> -	register_sifive_l2_error_notifier(&p->notifier);
> +	register_sifive_ccache_error_notifier(&p->notifier);
>
>  	return 0;
>
> @@ -81,7 +81,7 @@ static int ecc_unregister(struct platform_device *pdev)
>  {
>  	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
>
> -	unregister_sifive_l2_error_notifier(&p->notifier);
> +	unregister_sifive_ccache_error_notifier(&p->notifier);
>  	edac_device_del_device(&pdev->dev);
>  	edac_device_free_ctl_info(p->dci);
