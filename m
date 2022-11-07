Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25A661F722
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiKGPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiKGPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:06:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1205B1B9E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:06:13 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g7so17158917lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=msJlygCwztcKRCpl1OXcVZ463IWdf/JAulr8vPXr8uc=;
        b=kw/1CVr1CvRVBN7ppDzHuBwXNvTpjmdU+210GrNG3Nc4b7E6jprzvZIHSr8pmgM/I3
         Ooumonhq2AA5Z/bDkgOMmb2uuM0HYdIO4QfNzuv00lDToNyHDOw36qPCZqLGXo4Ny3Rv
         8GkkhYRZVPrpYZIyCy0c/BpWEycFDPgrnqVXz0/oGqCFsBGaXEqVwjB2ectF8uoWJPDw
         cqsZOPBXQ8MKkKJ4OYLi5exG/8EufN0ybQVFN2TtQD6A6dL7rQVdsIKxIZG1aTs5d6oI
         3O2K+mIJ1o8KaZwC8/MgU6kRcp+hsoW+as5mFzAkuL6pYASSSpWkf57h2MlRn8yzVn5+
         jiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msJlygCwztcKRCpl1OXcVZ463IWdf/JAulr8vPXr8uc=;
        b=bLLRxrerB0XiDfYY5xriHbc3bIAHEtW48ExmPRrpiVtEl202vJM2firfwvAQKrFadn
         fUSDkwnVqg6N7UIKbJvWc9LoF1TKsHnvWG3EqJ/5yTNvzf8nftPAuOzws3QKoF0f6ama
         nETD+CHcWUJcewi2FYk9jpKE1UXhC2BCGv0wv+V6804vPUgvt/nQq6onsxbnLBYGnMBU
         ZbeIfqEXzwYvXSzZx9na4DKEVPwlrq4J41p0WdrsUX5I3x3SLVkjCkInH5bafWraBFeG
         GAdaDOWl3ZbeaMNJwqCXsPZL2bs7Yj9950/vtnA5826zXfhN/H+R4MEhvGip8Trzb2ii
         i/gw==
X-Gm-Message-State: ACrzQf3ixImDCZTLrCCqxaZJEltAAVBjJs2MRI0FjUdW4nusb2ZJZxgN
        ftFgMIs2vHLoFnieroGzfM06jvpGv0zfJ3MHsAjwnA==
X-Google-Smtp-Source: AMsMyM4/hRdV6PUceQjYTAr5VlJwQq0PJWF/plhX/TikjJfOvo1/P9XLmwGDedaShVJ1ltmLlfA5kP20+nvh1Rr9HWY=
X-Received: by 2002:a05:6512:a93:b0:4a2:a5b3:fbb4 with SMTP id
 m19-20020a0565120a9300b004a2a5b3fbb4mr17334447lfu.346.1667833571328; Mon, 07
 Nov 2022 07:06:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Nov 2022 15:06:10 +0000
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v3-0-a803f2660127@baylibre.com> <20220919-v3-12-a803f2660127@baylibre.com>
 <988b0a7a-69bb-34e4-e777-1d9516221077@collabora.com>
In-Reply-To: <988b0a7a-69bb-34e4-e777-1d9516221077@collabora.com>
MIME-Version: 1.0
Date:   Mon, 7 Nov 2022 15:06:10 +0000
Message-ID: <CABnWg9t0KznQG1Mix=jSchk99Xj-h3Bf28WTaP9gc8AC6yLr7Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Nov 2022 12:20, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 04/11/22 15:09, Guillaume Ranquet ha scritto:
>> Add the DPI1 hdmi path support in mtk dpi driver
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dpi.c      | 143 ++++++++++++++++++++++++++++++--
>>   drivers/gpu/drm/mediatek/mtk_dpi_regs.h |   5 ++
>>   2 files changed, 141 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> index 508a6d994e83..8052b47042b8 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> @@ -14,7 +14,10 @@
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
>> @@ -65,10 +68,14 @@ struct mtk_dpi {
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
>I admit that I didn't really check these clocks, but judging by the names,
>it is highly possible that one (or more) of them are supposed to be parents
>of some others.
>
>The first suspicious ones are dpi_ck_cg and dpi_sel_clk: please check.
>
>I'm also not sure about the hdmi_cg, shouldn't the DPI have a HDMI port in
>the graph that you'd declare in devicetree?
>
>Besides... you're doing a lot of work to check if (is_internal_hdmi) for
>power up/down paths, but seeing that you're introducing this change after
>adding the HDMI driver makes me mostly sure that the internal hdmi that we're
>talking about here is the one that is managed by the HDMIV2 driver... and
>this means that you should really, really, really rely on connecting inputs
>and outputs the right way in the devicetree, as that will most probably make
>you able to write practically 0 code to manage power for the DPI... and may
>also remove the need of adding the hdmi_cg clock here...
>
>Regards,
>Angelo
>
>

I don't have access to a clock tree documentation or anything that permits
me to answer those questions with confidence. I'll ask mediatek for some input
and I'll also check how those clocks are declared in the clock framework.

You are right in assuming that the "is_internal_hdmi" is in fact the V2 IP.
I like the idea of removing code, I'll try to make sense of your suggestion
and see if there's anything I can do better for v4.

Thx,
Guillaume.
