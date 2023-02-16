Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B37698DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPHbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBPHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:31:32 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB538EBD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:31:29 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k6so1057994vsk.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HUSv71/IGUnLZD3B7OqwypzfXMZ43qFnSxJzO/o+ZQY=;
        b=lAuAzQBc6RPfyQw1RL4QShGpRtE4xcMHq/2n0N2BFrMRgDJcfz6frJyd1Dwq+5oJga
         jEseA9/wlXPnu85ei+RhL3vdgtyuNftxH1PEJEjPP9ZeiI/4VmcexikDTe2M11f+pLp6
         09dy0cr/Hn2x+iSW5BoOJ6J6SeutIiZkPajig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUSv71/IGUnLZD3B7OqwypzfXMZ43qFnSxJzO/o+ZQY=;
        b=Oo04HZb7dFRcLboJs4Emj7uk5L84gca4KI3D9RCyJBJugnETfs8eLMS2vgspQNxqP1
         4HXT21tEHtav6+d2E+T4ivTrVPWuIh6g49mT9xqJHGXntP98YvKf821EeslouDEYjzr3
         epd5XIdyG+RzASip04DYoHEGN43WwG/Jztl4Bot9KdQcwG3MYAd0cy9t1nXpvYUkuCUq
         77GpvcG3Evn38DOr3ZYsu7+AX4F+/ve9VZpRGQs1qkyr5rhNspnAIXBlHJTHNbUORuoX
         iXY0v3cr1L21u7aFaFpaeuZR7+mnVt8ND9SL9FG079MArJLjLj398NKyw5WaA9ddCP5N
         j6PQ==
X-Gm-Message-State: AO0yUKU3XZ7LYblvGxS6C2NJqk3RJjb61ZzesuwES0BUVDdE5Gz9+MA4
        RjSj+vzNPOtng6RdgEpL0bGzhp3j9vU34pNu7QAO3A==
X-Google-Smtp-Source: AK7set+rAe3Uideghnpky0Dpb6VVBSz9U/PEGIpuRQLl1kaAID4ZC3fanb6bymAJ5g+9JkkTYRedPB+bRUySXN1J9m8=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr931762vso.60.1676532688934; Wed, 15 Feb
 2023 23:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 15:31:18 +0800
Message-ID: <CAGXv+5E7Ht4CJkGSK18Fc0Hwc4wbJx6m8Fyyg5KkLsEgfKYSug@mail.gmail.com>
Subject: Re: [PATCH v2 09/47] clk: mediatek: mt2712: Change to use
 module_platform_driver macro
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Now that all of the clocks in clk-mt2712.c are using the common
> mtk_clk_simple_{probe,remove}() callbacks we can safely migrate
> to module_platform_driver.
> While at it, also drop all references to `simple` in the specific
> context of mt2712 as that was used in the past only to allow us
> to have two platform_driver(s) in one file.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
