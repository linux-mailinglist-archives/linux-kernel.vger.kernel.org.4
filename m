Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324FE6D33FA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDAUwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDAUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:52:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DB2B0C2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 13:52:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so17479311wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680382342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aMiCXujIGmUVuB4Z9vXOtvJHa7Wx4/lUo7wVgjnPeg=;
        b=vkuiN9rvjWBpooAyCLyDu+pjg0gt4cQLzaQb6t8Lx2ghlnL1XUcUlNlQioyiBt4CFw
         c9dnPmYQpp0ZZKZpdqml0vE/NrIwn9/G9HN+nSfzXg0Aepd4laDCrsQrhD9XVG3ae+tu
         wOJ1jwlr9c4zSpX6j6xp6GIb6iFq5v2Fz/8KuVYuE6rhKeH1CSiAFjFSKkOqJSe+3+4D
         p6DoeVJNisJrNKXPXCpsaen7XhiV4tP0OI98w80iwSha9b8qyWlPbMPXQxt62gZ87sVs
         wvotEHObh3upaIs7GWjOvzINb47RR27Jg56v/x+X4x9OEtuUbvC/NXHMk8VBw51vEF/z
         o/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aMiCXujIGmUVuB4Z9vXOtvJHa7Wx4/lUo7wVgjnPeg=;
        b=xxkXcQEgg7K628xmAo/TNbgqpwkqnGB6ioIJQA+3mXrh2TQMeZuzcCImyjsO86fq+9
         S3qEqRgmDENLKvOaj4akmn/IRE8C9d6012vP8WxsR3n30OPODoCwXsL72/X6lOkqFHZ6
         DgUShXUy4rc2YWxspOyirF0/6B2Niw4uXTjsYgMGPnczdezmvmIFDInVEDTpIK6p9kYL
         WhiPdcp+76nbCqj8ZoQdG8UGV9Yh0Jhcqj7QViy/Ga1PHrSa9DP8dhWRxDvOOsBwX2QU
         OR4l6mfACwa34MUU83PRfrQv9R2hEAgJgEGWKKVUnvasyLa0Dc3IXt4TE+vzUTX1zqn3
         CZ7g==
X-Gm-Message-State: AO0yUKU1XF+tOERNVUFFPV9i1NZzFKahzD4tKtsXF1N7a+KaGhv+u312
        ECzaRKifscn/cvZFdHOo/gn0Sw==
X-Google-Smtp-Source: AK7set8fNgOTJJlP0UI0D+ubIU86sAui89uX/69r3P64DFMyWqZcOx1w0KXFIYt4ZdZw4qR7lGMNPg==
X-Received: by 2002:a7b:cd97:0:b0:3ed:ce50:435a with SMTP id y23-20020a7bcd97000000b003edce50435amr23171291wmj.10.1680382342508;
        Sat, 01 Apr 2023 13:52:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id c3-20020a05600c0ac300b003edf2dc7ca3sm7116174wmr.34.2023.04.01.13.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:52:22 -0700 (PDT)
Message-ID: <32ff359d-ebdb-cacd-9237-e33eb9d9cdb0@linaro.org>
Date:   Sat, 1 Apr 2023 22:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307154524.118541-1-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 16:45, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add AP thermal domain support to LVTS Driver for MediaTek MT8195 SoC.
> 
> This series is a continuation of the original series "Add LVTS Thermal Architecture" v14 :
>      https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.50294-1-bchihi@baylibre.com/
> 
> Based on top of thermal/linux-next :
>      base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
> 
> Depends on these patches as they are not yet applyied to thermal/linux-next branch :
>      [v14,3/6] arm64: dts: mt8195: Add efuse node to mt8195 (already included in linux master branch)
>      https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50294-4-bchihi@baylibre.com/
>      [v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
>      https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50294-6-bchihi@baylibre.com/
>      [v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation threshold
>      https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50294-7-bchihi@baylibre.com/
> 
> Balsam CHIHI (4):
>    dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal
>      controllers for mt8195
>    thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
>    arm64: dts: mediatek: mt8195: Add AP domain thermal zones
>    arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds
> 
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 180 ++++++++++++++++++
>   drivers/thermal/mediatek/lvts_thermal.c       |  94 +++++++--
>   .../thermal/mediatek,lvts-thermal.h           |  10 +
>   3 files changed, 264 insertions(+), 20 deletions(-)
> 

Applied, patch 1 & 2

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

