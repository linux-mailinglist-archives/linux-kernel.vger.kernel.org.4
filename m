Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49EC6D3955
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDBRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDBRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:02:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038598690
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:02:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so18366916wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680454938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XOcFenNFYRM2N6pSiUZEbD6uIJrjdKx1WKwhR0xs50=;
        b=ANvfbaiKo3Ki0oNGRBd1f4nF1CdD94/r/tSNwSH2W84rQPO7CvX91q1a6VO6WIsAY7
         OmvFaKwmqKmzraHyhi/OmKWXeD32PilzRPQm6rv/ZL9ZrmHGgFm9kWcfR29khOPVERMq
         UACKwxqDUcMdeo+6bLN4uhNW4Wi0VCBqZCJyX9ugYLr3ZLUKVpOplzCTQlyuztXM02hy
         gSZ3Q5Kqiu8SwMU7+vbjUZgyiwIb/Pt+Mlqkj1Gc9tPct7O3pPNuYSAHXJkdQDWKAuz0
         rt8t6s2cP8EcYkwUEvCmHwogU/6aqPHBwko98v9KS6CxRwftRn6vc8jJQt4MSbXXyKa3
         5Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680454938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XOcFenNFYRM2N6pSiUZEbD6uIJrjdKx1WKwhR0xs50=;
        b=FdtiS+wIE5k2/Y5UihXLtdbEmyLb4yyEQgw+8nIJba4S2XwdaYdF47UoSCFbTuuzcd
         dB11ye6H9JfsWQ2y035/ZEJ2uFRsQ+4UmxFLnhE6yO3uFrpmOC1wrsFZuxBuoPpvLT6T
         yIbjQ4t/y5DsxPKmZrK+vXfsWgPUi96UsU00PUAYdn5aqgSBDrTTdKvB1hp/pzHI0h0E
         5b5l98Mi1STDcrfHig8MHTk7SVCf2rjJCl5BpX6iqBwbTe4zDCvhf7WvO+p5WysyFZUS
         YAnqnOzqLzIyfMetws+kVwQu1Nr3G6RRA6b2hHT32ttR3x4HXTmYzi2sQFeJCzKJQs1T
         54qg==
X-Gm-Message-State: AAQBX9fU8rj3rie1IqXhx97wT0XIpQvzPXiMMFIoLASKNbYLtWLC4VPB
        cOIUOtQC/kxHTJV0Dz/YrBY=
X-Google-Smtp-Source: AKy350ZtNnms3pkR6oY30xJO9bNT2YpcPIXQrGO9yFnNaFcPLTQCJs5SU35WATc1Hlmkrsg5F9bxqw==
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id u5-20020a7bc045000000b003ef6fee8057mr17170245wmc.25.1680454938275;
        Sun, 02 Apr 2023 10:02:18 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c029800b003ed246c1d28sm9463189wmk.44.2023.04.02.10.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 10:02:17 -0700 (PDT)
Message-ID: <00fb6b73-5327-13f6-8df8-6f1f4d1aa671@gmail.com>
Date:   Sun, 2 Apr 2023 19:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] MediaTek MMSYS: Split out MT8173 and add MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 11:26, AngeloGioacchino Del Regno wrote:
> This series migrates MT8173 to use its own mmsys DDP routing table
> and introduces support for the MediaTek Helio X10 MT6795 using the
> same routing table as MT8173.
> 
> Broader explanation goes to that MT6795 addition:
> 
> Both MT6795 and MT8173 can support more usecases than the ones in
> the current routing tables and the ones that are actually supported
> in mediatek-drm!
> This is mostly about MERGE, dual-DSI, WDMA (for command mode panels)
> and others, but, again, right now, these are not supported.
> 
> I could have created a mt6795-mmsys.h, but that would've been a 1:1
> clone of mt8173-mmsys.h, creating unnecessary code duplication hence
> raising code (and kernel) size for no practical reason.
> 
> As a side note, if more MTK Smartphone SoCs land upstream, I expect
> to see more re-using of MTK Chromebook SoCs mmsys routing tables.
> 
> P.S.: MT6795 dt-bindings are already upstream in v6.1 [1].
> 
> This series was tested on:
>   - MT8173 Acer Chromebook R13 (Elm)
>   - MT6795 Sony Xperia M5 (Holly)
> 

Applied, thanks!

> Also, this series depends on [2]
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml?h=v6.1.15#n28
> [2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=724014
> 
> AngeloGioacchino Del Regno (3):
>    soc: mediatek: mtk-mmsys: Split out MT8173 mmsys DDP routing table
>    soc: mediatek: mtk-mmsys: Change MT8173 num_resets to 64
>    soc: mediatek: mtk-mmsys: Add support for MT6795 Helio X10
> 
>   drivers/soc/mediatek/mt8173-mmsys.h | 95 +++++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c    | 16 ++++-
>   drivers/soc/mediatek/mtk-mmsys.h    |  2 +-
>   3 files changed, 109 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mt8173-mmsys.h
> 
