Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9207123E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbjEZJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbjEZJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:39:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D351170F
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:38:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3063433fa66so296860f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685093935; x=1687685935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9FbcJ8ok/dJicjZGixTx1rLY7WoaIvuxCHaDotirU4=;
        b=JL9AIH+1JLjqI1bMy4zyAC7GHDy/nihvR99pjHry6l2XVXgzqeSd/O9B6T2oGdIPvA
         VkgZBzOgUU608sykszofbkMZecWAa0HoGE9t5egEInksaJ2dQoLSSbMUQWNa5bwOV1rx
         ohf/QuYu7rZKisOi0K2vsLSoVlPGCAscrZLaxrq3if7gialce24YicNKzQ2ugRFFnmV2
         jbxy7WDzGnpwoxmZmZvtFkTQa2PwwcuXAHHrU9gpVzAaDI2ry12Jwe4qqtx5CeILc0O4
         MSzVeVif0r/3wOiSpEkLOskM81rNKfB4zCaZUeRdYCujEGGmUNjWaRbZrf28KaMAzkc0
         5P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093935; x=1687685935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9FbcJ8ok/dJicjZGixTx1rLY7WoaIvuxCHaDotirU4=;
        b=B6KAAtAa+uXGwirLzynxUDbj4hg69xj7YBvDK2udOWwCS88fUkdS3HwvsrVAZ3ekoM
         ausAVVtRY/GnNLy7xEvPBltU4g17hS5+n7kyejUr2JK6n79m/DJ+Dfw+LI+QafWf6AJ+
         zUSBlV/YIAEIxtmd8qbBHiP8yvUmdDP/rmbi7YOWyZIP6t6rGtQBQ1raWcKq1W9CP2So
         3RL0koXJL7dcFfOC0kwonG9/OIzBc145DNg3uUfAkZ/sLQa32HV1LS8Su8EJ/BP4MiRE
         GFMcaQfdeOqfqPK+FZJroCRrmBdtlK69iY6sbxnZ7OdT7rNTQ2298Ze1VXc8fia7cA8X
         yieg==
X-Gm-Message-State: AC+VfDytDlGyOUAd9R0QB+NYa5kuit9xfP1ovhSEEk5Lk+i1cv8xpoOX
        7Ofepu2Hd+wYVWIc0ZlKK1ijVA==
X-Google-Smtp-Source: ACHHUZ5Z/uuwFU/rDxZADcj66dYaAGt7iBmpqRVcOw6fAUTz20CCVBeanIlci2qhrpcJchgxcIz/3A==
X-Received: by 2002:a5d:640c:0:b0:30a:6958:456 with SMTP id z12-20020a5d640c000000b0030a69580456mr1091222wru.4.1685093935490;
        Fri, 26 May 2023 02:38:55 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b00306299be5a2sm4489937wrs.72.2023.05.26.02.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:38:55 -0700 (PDT)
Message-ID: <d2ed4cce-108f-c861-5f84-0c7ac5954346@baylibre.com>
Date:   Fri, 26 May 2023 11:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] clk: mediatek: mt8365: Fix index issue
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
 <20230517-fix-clk-index-v2-2-1b686cefcb7e@baylibre.com>
 <2a60740f-782d-08d5-f62f-dcc67aaf4d32@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <2a60740f-782d-08d5-f62f-dcc67aaf4d32@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/05/2023 10:33, AngeloGioacchino Del Regno wrote:
> Il 25/05/23 16:50, Alexandre Mergnat ha scritto:
>> Before the patch [1], the clock probe was done directly in the
>> clk-mt8365 driver. In this probe function, the array which stores the
>> data clocks is sized using the higher defined numbers (*_NR_CLOCK) in
>> the clock lists [2]. Currently, with the patch [1], the specific
>> clk-mt8365 probe function is replaced by the mtk generic one [3], which
>> size the clock data array by adding all the clock descriptor array size
>> provided by the clk-mt8365 driver.
>>
>> Actually, all clock indexes come from the header file [2], that mean, if
>> there are more clock (then more index) in the header file [2] than the
>> number of clock declared in the clock descriptor arrays (which is the
>> case currently), the clock data array will be undersized and then the
>> generic probe function will overflow when it will try to write in
>> "clk_data[CLK_INDEX]". Actually, instead of crashing at boot, the probe
>> function returns an error in the log which looks like:
>> "of_clk_hw_onecell_get: invalid index 135", then this clock isn't
>> enabled.
>>
>> Solve this issue by adding in the driver the missing clocks declared in
>> the header clock file [2].
>>
>> [1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
>>       mtk_clk_simple_{probe,remove}()")
>> [2]: include/dt-bindings/clock/mediatek,mt8365-clk.h
>> [3]: drivers/clk/mediatek/clk-mtk.c
>>
>> Fixes: ffe91cb28f6a ("clk: mediatek: mt8365: Convert to 
>> mtk_clk_simple_{probe,remove}()")
>
> This is not fixing the conversion, but the clock driver, as it 
> originally missed
> clock entries and hence was not compliant with its binding (header).
> It worked before, probably, but this doesn't mean that this driver 
> didn't contain
> a logic mistake from the beginning :-)
>
> So, add (or replace the current one with) the relevant Fixes tag...
>

Briefly and factually, the mt8365 clk probe mechanism was different

compared to the mtk clk driver. Even if it was an issue or not, it was

working (for sure). When [1] improved the mt8365 clk driver by using

the mtk clk generic probe, some clocks (USB here) no longer worked.

So, IMHO, it still a functional regression introduced by [1], because it

come from the switch of the probe function.


I'm not blaming & shaming the author of [1], as you said, it originally

missed clock entries and hence was not compliant with its binding

(whereas other MTK SoC was I guess). This commit is pointed thanks

to the bisect + test.


-- 
Regards,
Alexandre

