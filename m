Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16EC5EC494
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiI0Nfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiI0NfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:35:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027BB4B2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:34:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w2so9742825pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=5KO5UAD2T7DgoYPQgFD91UfqIRE232yyISaSFCJ9s3Q=;
        b=SoU+eGuksQQhlnS7N57Z73aJoRcn1Yf2NhRhsCodkYOiV7LO9opJ5E2VCYREe5jIix
         Oek/U1yUHENSgLff5LPnC8g96rDkpkyHkyN8K4ng0t6VFbZFhaiBdfyEbni+0RGn8Bvq
         Xr0f0Eoqt6tUwJZdRxqQtkBIbO01YSyEzs/YfPOplLElabdw79du1/QP496W/K521tAO
         KKfJLi1VzArX+CrDYSiZD5o0f3yZ/lI0HMD3tk0S9NVt07KumdMGtpOn2kdj3DfJ9Blo
         P1h+q5XNmMceyQpXed0kBCLxxC8hoyH9lz/GILiJzcJK3VEBQWlBG8Gm4O571ponUsdt
         IIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5KO5UAD2T7DgoYPQgFD91UfqIRE232yyISaSFCJ9s3Q=;
        b=1+9BDexbxbbePMWRtVOPTFD6GSm0w1ZwBpwHAU7RAKPKWhCl7vmYKCX3c5ZVws7gTo
         15ZldFeJq6Q/qTMQXc0ofWT/XuL+2IEA2Dqg1o5W6BWj66uXDG3GvtI5kJEAarG460kd
         A39p9ELGoqiyMeSsniULoFxjfrpMWFmzT4ZCs/KgoVgodD0aJI8UJCO1EDT6m2kpMMrL
         Aj0+oKwfVX8X+x40vjwuwXCEYc52vQTldPtOt5Pc1ahpcDrEXKC61755Fb+By20BOkos
         ZY8zUQSnkylz1kRC1eOz6WskxhH532EtXHUGicBmx17pPaGNMMv14LAOgTNcSrdS+EEN
         nVVw==
X-Gm-Message-State: ACrzQf2CpaLUSejpzuOomH7/RooUPD6RbV9BGuJiNWmRD5IY7GRgveRi
        kzxxXmDZ9GNP5F5G3myFlVueqOM4s89GV58XxziEGQ==
X-Google-Smtp-Source: AMsMyM4YIhFYJqfTMqQFxzcbSAJDenFpMeYijY6ikC/aRvNNUlM8pp9LqLPwxTZew8CdZonFZQtK3Mf4GpGS1w183Kg=
X-Received: by 2002:a63:b55d:0:b0:439:7a97:b89 with SMTP id
 u29-20020a63b55d000000b004397a970b89mr24899166pgo.70.1664285675305; Tue, 27
 Sep 2022 06:34:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Sep 2022 06:34:34 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-16-4844816c9808@baylibre.com>
 <812a5de2-dbe3-2f0d-492c-16ea004c996a@collabora.com>
In-Reply-To: <812a5de2-dbe3-2f0d-492c-16ea004c996a@collabora.com>
MIME-Version: 1.0
Date:   Tue, 27 Sep 2022 06:34:34 -0700
Message-ID: <CABnWg9sSbtXYLpcCoEts73CAsciKMEeMMRwfcfGng8H-rGYvkA@mail.gmail.com>
Subject: Re: [PATCH v1 16/17] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 14:22, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
>> Add the DPI1 hdmi path support in mtk dpi driver
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> index 630a4e301ef6..91212b7610e8 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> @@ -15,7 +15,10 @@
>>   #include <linux/of_graph.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/reset.h>
>>   #include <linux/types.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>>
>>   #include <video/videomode.h>
>>
>> @@ -66,10 +69,14 @@ struct mtk_dpi {
>>   	struct drm_bridge *next_bridge;
>>   	struct drm_connector *connector;
>>   	void __iomem *regs;
>> +	struct reset_control *reset_ctl;
>>   	struct device *dev;
>>   	struct clk *engine_clk;
>> +	struct clk *dpi_ck_cg;
>>   	struct clk *pixel_clk;
>> +	struct clk *dpi_sel_clk;
>>   	struct clk *tvd_clk;
>> +	struct clk *hdmi_cg;
>
>
>You're adding new clocks and then you're making *all clocks*, including the
>already existing ones... optional.
>
>That looks seriously odd.... can you please give a devicetree example for
>MT8195 in the next version, perhaps in the cover letter?
>
>Would also make it easier to test this entire big series.
>
>Regards,
>Angelo
>

The clock names are different for MT8195 HDMI than for the legacy DP.
Making everything optional might not have been a smart move.
I'll try to think of something else to make it look less odd.

The device tree I'm using to test things is rather "hackish" and has a bunch of
changes from what is found on linux-next.
I think Jason and Nancy are due to upstream those patches.

I'll try to include something minimal for you to test.
Otherwise would a public branch containing everything work for you?

Thx,
Guillaume.
