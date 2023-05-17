Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8BE70631E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjEQIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEQIkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:40:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2265598
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:40:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510b154559fso811700a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684312813; x=1686904813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=757JBJxgRWVinuPZFHNhDwrpQbzagkxwUnhVEdJlotA=;
        b=Sm26zdi4yXWmd/d5jNfPI+ohb2rArHlvywdRT2QtSF9RdznkTFYFLJw5eixE0xpD2D
         3DIuKF8aZGLtDWaN5Vz2s32vbMTLk+1rsQrL9DDe+rueBVKOJtq1bqPMHy3QU4u381wM
         GX3cAIMXuyEG1WuPyAENLUJZeywDLLOz5bSJiti645EOHFNTKKf6WToE7UamrRM56gJT
         DtypxiEf9FwRmPmnInm6WVJMLs+9k/FXppKdCoZckAWIZSgCIzIiBTrwBwB1D5dMlm12
         ptVtQo+A6X5qP+n29tfqHa6cUyTbPPD4eCJqlDUm1AAQlvGc8z9vwAD2qqMYWYN/veje
         ZknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312813; x=1686904813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=757JBJxgRWVinuPZFHNhDwrpQbzagkxwUnhVEdJlotA=;
        b=aYkxrjTEabkQULcwqL5PcMcYo5HQTa1RijJC8F8/5XBLdpPVGCmPnMlIPvW+tRqw3+
         MbywV/10ZJxDvqH9aGGI2gQJOcuvDy4u21M824z7mjwWGgeXY2O5J29mwUNB9xX1yjYC
         wPqMJYs5DVOeha3IolA8U0u36mCcJXk2718b3Jyx03NXHYJtRy4SSC82pAQ/uevHrZBS
         ANThGvJkldmCAf7XYmDsbsPtbMRzybHH2PAHe6dDr7H8bt8Pe1AB625WwJSuPfMcC0x0
         MfCnpzi5clcygEk0Z9gUTjQduAqnLJTSXd/AMsS6oFdGylDT0TT6WWEjjIxRzubJoFSX
         +TAw==
X-Gm-Message-State: AC+VfDxwhZMzuyHN9ORZZnaeRQ30fKwna8PaWv5/sYa1GbcxepntPMMI
        RWpjxVmHc4h6uwev9eLloyo/yA==
X-Google-Smtp-Source: ACHHUZ6MmcsQD6x7J6FNqyzT+Zg/rDHY0Azqiv9uIV7gCqHJk7KqXU7NawbLmhXBHUzQBiHfFpn3Lg==
X-Received: by 2002:aa7:d1c6:0:b0:50d:975f:3729 with SMTP id g6-20020aa7d1c6000000b0050d975f3729mr1577173edp.11.1684312813416;
        Wed, 17 May 2023 01:40:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id o22-20020aa7d3d6000000b0050696c2d2f6sm8771234edr.88.2023.05.17.01.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:40:12 -0700 (PDT)
Message-ID: <9c7ff0f1-3d2c-b83a-a47d-544c76f29663@linaro.org>
Date:   Wed, 17 May 2023 10:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] clk: mediatek: mt8365: fix the clock indexes
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com>
 <20230517-fix-clk-index-v1-1-142077a1732b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517-fix-clk-index-v1-1-142077a1732b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 10:28, Alexandre Mergnat wrote:
> Before the patch [1], the clock probe was done directly in the
> clk-mt8365 driver. In this probe function, the array which stores the
> data clocks is sized using the higher defined numbers (*_NR_CLOCK) in
> the clock lists [2]. Currently, with the patch [1], the specific
> clk-mt8365 probe function is replaced by the mtk generic one [3], which
> size the clock data array by adding all the clock descriptor array size
> provided by the clk-mt8365 driver.
> 
> Actually, all clock indexes come from the header file [2], that mean, if
> there are more clock (then more index) in the header file [2] than the
> number of clock declared in the clock descriptor arrays (which is the
> case currently), the clock data array will be undersized and then the
> generic probe function will overflow when it will try to write in
> "clk_data[CLK_INDEX]". Actually, instead of crashing at boot, the probe
> function returns an error in the log which looks like:
> "of_clk_hw_onecell_get: invalid index 135", then this clock isn't
> enabled.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

This is huge ABI break and I don't understand why it is needed. Entire
description above did not explain me that.

> 
> The simplest way to fix the regression is to remove from the header file
> [2] the unused clocks.

??? The simples is to revert the patch, so you won't break the ABI.

> 
> [1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
>      mtk_clk_simple_{probe,remove}()")
> [2]: include/dt-bindings/clock/mediatek,mt8365-clk.h
> [3]: drivers/clk/mediatek/clk-mtk.c
> 
> Fixes: ffe91cb28f6a ("clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()")
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  include/dt-bindings/clock/mediatek,mt8365-clk.h | 361 ++++++++++++------------
>  1 file changed, 177 insertions(+), 184 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt-bindings/clock/mediatek,mt8365-clk.h
> index f9aff1775810..fd59c8bdeb24 100644
> --- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
> +++ b/include/dt-bindings/clock/mediatek,mt8365-clk.h
> @@ -7,147 +7,142 @@
>  #define _DT_BINDINGS_CLK_MT8365_H
>  
>  /* TOPCKGEN */
> -#define CLK_TOP_CLK_NULL		0> -#define CLK_TOP_I2S0_BCK		1

...

> +#define CLK_TOP_I2S0_BCK		0

Why? This is really broken. You can remove the defines, but re-shuffling
everything?!?

Best regards,
Krzysztof

