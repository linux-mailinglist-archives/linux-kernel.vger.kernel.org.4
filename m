Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033806E6DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjDRVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjDRVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:05:51 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B1C172;
        Tue, 18 Apr 2023 14:05:49 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38e3a1a07c8so574373b6e.0;
        Tue, 18 Apr 2023 14:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851949; x=1684443949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIDYp/2j9X9Mpn+NMTYQeGLVTSLMhfAeiCWuUAQuqdE=;
        b=L2D0sWRHzaKlrGOx93OnJwUvy8I49Jlsye+7qN39NcGFERnIVhaNgaBuZT0RM6roTN
         kzAcl6SjoATgFzv9XtRJpM2Z4MAZs9c1aYsqWNZ+NMdaqcC4ldUjeIASu9PNBPK3iOus
         o8rkyRFVd1T1DP7E0BbWPpO8/MxMnlcbcGUuaPcA+E0ssNNHILrTqq8qBfMgbqleexJH
         tT4ExMj2hY3pSaP+E9idSSM6hn2/eb1Sl/+pac/5mx7XpHry1gafIj/pg0vqLng41ACx
         W1JySVyD4tasYjy0kF+M/vwDsdZh5L+hggit7k4CXsGomy1O3z+7KopzA4a4V0FPpsML
         vvNQ==
X-Gm-Message-State: AAQBX9eoPkzWV02xyWJB49+1XRAahKNEuQ2o4vowJDznrMjhTGMWxc4a
        jYfzkZe9YRzDPNLS4g2L9A==
X-Google-Smtp-Source: AKy350bet3km/yb3giQkK8izKkkQaSFBeZstujhyhN82Nm+RKFFGmGsH37dO5tcBMB2o2VobJD5nKw==
X-Received: by 2002:a05:6808:23d2:b0:38e:3902:6d37 with SMTP id bq18-20020a05680823d200b0038e39026d37mr1582824oib.59.1681851949075;
        Tue, 18 Apr 2023 14:05:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l15-20020a54450f000000b00389898f4c4fsm3142112oil.45.2023.04.18.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:05:48 -0700 (PDT)
Received: (nullmailer pid 2339121 invoked by uid 1000);
        Tue, 18 Apr 2023 21:05:47 -0000
Date:   Tue, 18 Apr 2023 16:05:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Message-ID: <20230418210547.GA2322152-robh@kernel.org>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <20230414102342.23696-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414102342.23696-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:53:42PM +0530, Bharat Bhushan wrote:
> GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
> and del3t traps are not enabled.
> GTI watchdog exception flow is:
>  - 1st timer expiration generates watchdog interrupt.
>  - 2nd timer expiration is ignored
>  - On 3rd timer expiration will trigger a system-wide core reset.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  drivers/watchdog/Kconfig         |   9 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/octeontx2_wdt.c | 238 +++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/watchdog/octeontx2_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..31ff282c62ad 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called keembay_wdt.
>  
> +config OCTEONTX2_WATCHDOG
> +	tristate "OCTEONTX2 Watchdog driver"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> +	help
> +	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog timer are
> +	 programmed in "interrupt + del3t + reset" mode. On first expiry it will
> +	 generate interrupt. Second expiry (del3t) is ignored and system will reset
> +	 on final timer expiry.
> +
>  endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..aa1b813ad1f9 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>  obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> +obj-$(CONFIG_OCTEONTX2_WATCHDOG) += octeontx2_wdt.o
> diff --git a/drivers/watchdog/octeontx2_wdt.c b/drivers/watchdog/octeontx2_wdt.c
> new file mode 100644
> index 000000000000..7b78a092e83f
> --- /dev/null
> +++ b/drivers/watchdog/octeontx2_wdt.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell Octeontx2 Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell International Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>

It's doubtful you need anything from of_platform.h other than implicit 
includes. Use the header(s) you need directly.

Rob
