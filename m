Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642BC6DF97A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDLPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDLPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:14:09 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5361AB;
        Wed, 12 Apr 2023 08:14:07 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id ec6so1216399oib.8;
        Wed, 12 Apr 2023 08:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312446; x=1683904446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLO2+mslMgJt7oEF3zMGiAxK8M13LsE3IAK5PmmHYrE=;
        b=REdxege8GbEImPRAQkS0OO5WEFvoRRMAky64e292PwPk1rOkhZrx1h7GRC7ACLZfeV
         JexmRqJTXAy1jugUzqRm1r8p8yrKRbKic6v8m95X0i2yk4o6bUV/OiMEH7dpf51WAFUU
         gib6EQIRjIcDS/bBq0nX+wM8U1RzNwTM5ZLDEQwVgs3WcHC/Eo4bdNEmySGc0dBPZDIk
         3VQP1IYyGiELonJTv+Hn8nwHR2abIVPPrj5pzG6lrzfwBTRtz32LqQWsSB+S3NRY7NSE
         lPKNsAVr/0zFthKXhfDbHWls+VOuCT07PA0tQn8s7CgmF4errynLx8Twf8NDNKv/lDCD
         WLfA==
X-Gm-Message-State: AAQBX9fzxcqPx6I+5mmvtdVI82PhBiTAhewC6k1q/fnngy24heuWSPS0
        LpZzPANnly3N3gNiVf8BVg==
X-Google-Smtp-Source: AKy350Z/1Wya1b06p9v1jxp3a5/8Dsk/0yLxaZGXg6Xk+G947KmvJd2M/mU6HaijGWztsLvxUWZp1w==
X-Received: by 2002:aca:d743:0:b0:386:9720:77da with SMTP id o64-20020acad743000000b00386972077damr6060729oig.26.1681312445919;
        Wed, 12 Apr 2023 08:14:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id en12-20020a056808394c00b003898ebb8be0sm6699276oib.48.2023.04.12.08.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:14:05 -0700 (PDT)
Received: (nullmailer pid 2446977 invoked by uid 1000);
        Wed, 12 Apr 2023 15:14:04 -0000
Date:   Wed, 12 Apr 2023 10:14:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        gabriel.fernandez@st.com, gabriel.fernandez@foss.st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: rcc: stm32: Fix STM32MP13 include file
Message-ID: <20230412151404.GA2372294-robh@kernel.org>
References: <20230407201526.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407201526.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 08:15:33PM +0200, Patrick Delaunay wrote:
> Minor cosmetic change, aligned with files in U-Boot:
> - change obsolete SPDX id : GPL-2.0+
> - use correct address gabriel.fernandez@foss.st.com
> - remove extra space

Make the subject reflect the purpose: 'Sync with u-boot copy'

> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  include/dt-bindings/clock/stm32mp13-clks.h   | 6 +++---
>  include/dt-bindings/reset/stm32mp13-resets.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/stm32mp13-clks.h b/include/dt-bindings/clock/stm32mp13-clks.h
> index 02befd25edce..da4cb7567430 100644
> --- a/include/dt-bindings/clock/stm32mp13-clks.h
> +++ b/include/dt-bindings/clock/stm32mp13-clks.h
> @@ -1,7 +1,7 @@
> -/* SPDX-License-Identifier: GPL-2.0+ or BSD-3-Clause */
> +/* SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause */
>  /*
>   * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
> - * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>   */
>  
>  #ifndef _DT_BINDINGS_STM32MP13_CLKS_H_
> @@ -64,7 +64,7 @@
>  #define CK_MCO1		38
>  #define CK_MCO2		39
>  
> -/*  IP clocks */
> +/* IP clocks */
>  #define SYSCFG		40
>  #define VREF		41
>  #define DTS		42
> diff --git a/include/dt-bindings/reset/stm32mp13-resets.h b/include/dt-bindings/reset/stm32mp13-resets.h
> index 934864e90da6..1b83a01de8f0 100644
> --- a/include/dt-bindings/reset/stm32mp13-resets.h
> +++ b/include/dt-bindings/reset/stm32mp13-resets.h
> @@ -1,7 +1,7 @@
> -/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> +/* SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause */

Really, the Linux copy came first, so you should use its license. Your 
company's lawyers are good with GPLv3 and then v4?

>  /*
>   * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> - * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>   */
>  
>  #ifndef _DT_BINDINGS_STM32MP13_RESET_H_
> -- 
> 2.25.1
> 
