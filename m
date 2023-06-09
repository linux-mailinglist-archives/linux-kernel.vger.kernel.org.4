Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38F729927
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjFIMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbjFIMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:10:34 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EBA3AAD;
        Fri,  9 Jun 2023 05:10:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0A17E5FD8E;
        Fri,  9 Jun 2023 15:10:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686312617;
        bh=ub+fulo7iW/neBWoaW5ppJg+bJ5K5cJ0kpCRCQIV+58=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=bGf8obVJxAgMRZCiOz2F+Ze/a7xIAQF3UFRnjwDDzkegdLuRmDj9i7BPiStEukv9v
         EjmT3/dbeB7NT5Mnic80UM7CzAm//xD8CYGAnkiEgM4KY6knJGytArllmZWuK0Vudt
         EhMXXd2gV9w+nrKxV9eHQIXHlOmUt4hvlRtHSRvhgDT1dXVRGgxsV0bMgyQDYFzLbZ
         8f2onmR9vhHxoy1s7K5x2ftHf9UgoaTb97NbhlEDsbQu/WXRBkLl2VmmAe/7xbd5MJ
         gIfhd9KD7bsWOUklzGCKwnN9t9d0Kiud1J+aqtqJB6h3Frtg66GE+ef3RqiJvoTXYs
         UYwZPrH4VgJwA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  9 Jun 2023 15:10:16 +0300 (MSK)
Date:   Fri, 9 Jun 2023 15:10:16 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 12/18] dt-bindings: clk: amlogic,a1-pll-clkc: expose all
 clock ids
Message-ID: <20230609121016.4njwpst3mu57fehv@CAB-WSD-L081021>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-12-9676afa6b22c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-12-9676afa6b22c@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/09 07:08:00 #21465535
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:56:23PM +0200, Neil Armstrong wrote:
> Due to a policy change in clock ID bindings handling, expose
> all the "private" clock IDs to the public clock dt-bindings
> to move out of the previous maintenance scheme.
> 
> This refers to a discussion at [1] & [2] with Krzysztof about
> the issue with the current maintenance.
> 
> It was decided to move every A1 pll ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.
> 
> [1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
> [2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/a1-pll.h                      | 15 ---------------
>  include/dt-bindings/clock/amlogic,a1-pll-clkc.h |  5 +++++
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> index 82570759e6a2..0add1c7ea9f5 100644
> --- a/drivers/clk/meson/a1-pll.h
> +++ b/drivers/clk/meson/a1-pll.h
> @@ -28,19 +28,4 @@
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
>  
> -/*
> - * CLKID index values for internal clocks
> - *
> - * These indices are entirely contrived and do not map onto the hardware.
> - * It has now been decided to expose everything by default in the DT header:
> - * include/dt-bindings/clock/a1-pll-clkc.h. Only the clocks ids we don't want
> - * to expose, such as the internal muxes and dividers of composite clocks,
> - * will remain defined here.
> - */
> -#define CLKID_FIXED_PLL_DCO	0
> -#define CLKID_FCLK_DIV2_DIV	2
> -#define CLKID_FCLK_DIV3_DIV	3
> -#define CLKID_FCLK_DIV5_DIV	4
> -#define CLKID_FCLK_DIV7_DIV	5
> -
>  #endif /* __A1_PLL_H */
> diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> index 01fb8164ac29..2b660c0f2c9f 100644
> --- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> @@ -10,7 +10,12 @@
>  #ifndef __A1_PLL_CLKC_H
>  #define __A1_PLL_CLKC_H
>  
> +#define CLKID_FIXED_PLL_DCO	0
>  #define CLKID_FIXED_PLL		1
> +#define CLKID_FCLK_DIV2_DIV	2
> +#define CLKID_FCLK_DIV3_DIV	3
> +#define CLKID_FCLK_DIV5_DIV	4
> +#define CLKID_FCLK_DIV7_DIV	5
>  #define CLKID_FCLK_DIV2		6
>  #define CLKID_FCLK_DIV3		7
>  #define CLKID_FCLK_DIV5		8
> 
> -- 
> 2.34.1
> 

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

-- 
Thank you,
Dmitry
