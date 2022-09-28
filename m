Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609565EDD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiI1NJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiI1NJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:09:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D81C9C222;
        Wed, 28 Sep 2022 06:09:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F250C6602292;
        Wed, 28 Sep 2022 14:09:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664370544;
        bh=Vf5x3tIxF1eH3jjuAIiQnki4BcokgilYkSxBESVxK/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kT6WY2mznangZxCUy/BmfaTldXwdJgzvbVFsk9ylrGn9e4Gh96hhrrvCnbqvU5rVs
         oEMJsW7WhWyeNogyyqSpMaX1czDdmmLimDgmnPThszm8rXEpGKBYEUQdH5QdO6E/6G
         Y1xUk4/tDYpPxShkVQH0jVShB2O6j08d42mkpPazOCaDCe23grG2q5XTv+znFBpq7p
         M2YNsc04BZePUE4ywDfhEGH6WZEiGfYEhlvtNjh2rXz3hNdUWdJCnc8K0WdJpeBDK5
         4IY4lWnmzpaVgpBQ16mYqDFJQy5l8H5XqetGhEIY30PcLNAqPScTgojv4eAfQvStKd
         d25y2Gl2ezH8Q==
Message-ID: <eae3cb46-d665-a8c9-f0f6-505680470e50@collabora.com>
Date:   Wed, 28 Sep 2022 15:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 16/17] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
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
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-16-4844816c9808@baylibre.com>
 <812a5de2-dbe3-2f0d-492c-16ea004c996a@collabora.com>
 <CABnWg9sSbtXYLpcCoEts73CAsciKMEeMMRwfcfGng8H-rGYvkA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CABnWg9sSbtXYLpcCoEts73CAsciKMEeMMRwfcfGng8H-rGYvkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/22 15:34, Guillaume Ranquet ha scritto:
> On Tue, 20 Sep 2022 14:22, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
>>> Add the DPI1 hdmi path support in mtk dpi driver
>>>
>>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>>> index 630a4e301ef6..91212b7610e8 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>>> @@ -15,7 +15,10 @@
>>>    #include <linux/of_graph.h>
>>>    #include <linux/pinctrl/consumer.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/reset.h>
>>>    #include <linux/types.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/mfd/syscon.h>
>>>
>>>    #include <video/videomode.h>
>>>
>>> @@ -66,10 +69,14 @@ struct mtk_dpi {
>>>    	struct drm_bridge *next_bridge;
>>>    	struct drm_connector *connector;
>>>    	void __iomem *regs;
>>> +	struct reset_control *reset_ctl;
>>>    	struct device *dev;
>>>    	struct clk *engine_clk;
>>> +	struct clk *dpi_ck_cg;
>>>    	struct clk *pixel_clk;
>>> +	struct clk *dpi_sel_clk;
>>>    	struct clk *tvd_clk;
>>> +	struct clk *hdmi_cg;
>>
>>
>> You're adding new clocks and then you're making *all clocks*, including the
>> already existing ones... optional.
>>
>> That looks seriously odd.... can you please give a devicetree example for
>> MT8195 in the next version, perhaps in the cover letter?
>>
>> Would also make it easier to test this entire big series.
>>
>> Regards,
>> Angelo
>>
> 
> The clock names are different for MT8195 HDMI than for the legacy DP.
> Making everything optional might not have been a smart move.
> I'll try to think of something else to make it look less odd.
> 
> The device tree I'm using to test things is rather "hackish" and has a bunch of
> changes from what is found on linux-next.
> I think Jason and Nancy are due to upstream those patches.
> 
> I'll try to include something minimal for you to test.
> Otherwise would a public branch containing everything work for you?
> 

Any reference would work for me, "something minimal" or a public branch, it
doesn't really matter.

Thanks!
Angelo


