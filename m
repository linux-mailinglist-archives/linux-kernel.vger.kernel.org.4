Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995B76ADA7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCGJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:38:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59262E0FE;
        Tue,  7 Mar 2023 01:38:20 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 750CF6602FE5;
        Tue,  7 Mar 2023 09:38:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678181899;
        bh=icWoP6hzgm6VUKbZn+U7oihEmJNV0OORJP3vHZ2iFKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ofSt+lN3GCLZcEABdTws9WAHxf1t3aqh+oxk226stQwhkTWKxveBxHfjodG9Vkp0U
         ZbwhmQlkxAs/Q8K8FAPPsbr1oXQ0AOk0DItuNK/KZRybAN+TBnJXKNV/IAWXY8/m52
         QQm9mAOtb8ZtdBBZRxXOH2W7rNETbMgIS1CLQfVkvkqCeh98582+Uu3vTFPpCfTUcu
         Rge60Uvw6jhLesI5JO/McMT8NBODxKXf1WVUP4PrvVNZc4Hr3nj8iPXUNGPb6n3NIE
         sC9ShjYUpAGG2/rMYc2JrMtPjjR1fRzuu1d778p6LnJGvlWmGnB64Gekgl0F7ANeQB
         1D4VX+mWin95Q==
Message-ID: <50ce7c9b-bef1-d570-c8b3-74914fbb43d6@collabora.com>
Date:   Tue, 7 Mar 2023 10:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/7] clk: mediatek: mt8195: Add support for frequency
 hopping through FHCTL
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, jose.exposito89@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
 <20230206100105.861720-8-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Ey02hzNQA2O2ussAt9sXxxy9mOjze2GH90Ko9HeoETXQ@mail.gmail.com>
 <a890fd4c-f15e-480a-64e3-c42c73584417@collabora.com>
 <CAGXv+5E_2iKH625PTRwo-qJONc2HqgHY5_+QJcuCmdZuEf7csw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E_2iKH625PTRwo-qJONc2HqgHY5_+QJcuCmdZuEf7csw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 10:29, Chen-Yu Tsai ha scritto:
> On Tue, Mar 7, 2023 at 5:27 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 07/03/23 05:43, Chen-Yu Tsai ha scritto:
>>> On Mon, Feb 6, 2023 at 6:01 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Add FHCTL parameters and register PLLs through FHCTL to add support
>>>> for frequency hopping and SSC. FHCTL will be enabled only on PLLs
>>>> specified in devicetree.
>>>>
>>>> This commit brings functional changes only upon addition of
>>>> devicetree configuration.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 69 +++++++++++++++++++-
>>>>    1 file changed, 66 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
>>>> index 1bc917f2667e..c0db31ce0741 100644
>>>> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
>>>> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
>>>> @@ -3,9 +3,11 @@
>>>>    // Copyright (c) 2021 MediaTek Inc.
>>>>    // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>>>
>>>> +#include "clk-fhctl.h"
>>>>    #include "clk-gate.h"
>>>>    #include "clk-mtk.h"
>>>>    #include "clk-pll.h"
>>>> +#include "clk-pllfh.h"
>>>>
>>>>    #include <dt-bindings/clock/mt8195-clk.h>
>>>>    #include <linux/of_device.h>
>>>> @@ -105,6 +107,61 @@ static const struct mtk_pll_data plls[] = {
>>>>               0, 0, 22, 0x0158, 24, 0, 0, 0, 0x0158, 0, 0x0158, 0, 9),
>>>>    };
>>>>
>>>> +enum fh_pll_id {
>>>> +       FH_ARMPLL_LL,
>>>> +       FH_ARMPLL_BL,
>>>> +       FH_MEMPLL,
>>>> +       FH_ADSPPLL,
>>>> +       FH_NNAPLL,
>>>> +       FH_CCIPLL,
>>>> +       FH_MFGPLL,
>>>> +       FH_TVDPLL2,
>>>> +       FH_MPLL,
>>>> +       FH_MMPLL,
>>>> +       FH_MAINPLL,
>>>> +       FH_MSDCPLL,
>>>> +       FH_IMGPLL,
>>>> +       FH_VDECPLL,
>>>> +       FH_TVDPLL1,
>>>> +       FH_NR_FH,
>>>> +};
>>>> +
>>>> +#define FH(_pllid, _fhid, _offset) {                                   \
>>>> +               .data = {                                               \
>>>> +                       .pll_id = _pllid,                               \
>>>> +                       .fh_id = _fhid,                                 \
>>>> +                       .fh_ver = FHCTL_PLLFH_V2,                       \
>>>> +                       .fhx_offset = _offset,                          \
>>>> +                       .dds_mask = GENMASK(21, 0),                     \
>>>
>>>> +                       .slope0_value = 0x6003c97,                      \
>>>> +                       .slope1_value = 0x6003c97,                      \
>>>
>>> Are these
>>>
>>>> +                       .sfstrx_en = BIT(2),                            \
>>>> +                       .frddsx_en = BIT(1),                            \
>>>> +                       .fhctlx_en = BIT(0),                            \
>>>> +                       .tgl_org = BIT(31),                             \
>>>> +                       .dvfs_tri = BIT(31),                            \
>>>> +                       .pcwchg = BIT(31),                              \
>>>
>>>> +                       .dt_val = 0x0,                                  \
>>>> +                       .df_val = 0x9,                                  \
>>>
>>> and these just copied from MT8186?
>>
>> Yes, and that's because they're really the same.
> 
> Just to be safe, I asked MediaTek to take a look at the parameters.
> 

Cool. Let's see what they say then!

>>>
>>>> +                       .updnlmt_shft = 16,                             \
>>>> +                       .msk_frddsx_dys = GENMASK(23, 20),              \
>>>> +                       .msk_frddsx_dts = GENMASK(19, 16),              \
>>>> +               },                                                      \
>>>> +       }
>>>> +
>>>> +static struct mtk_pllfh_data pllfhs[] = {
>>>> +       FH(CLK_APMIXED_ADSPPLL, FH_ADSPPLL, 0x78),
>>>> +       FH(CLK_APMIXED_NNAPLL, FH_NNAPLL, 0x8c),
>>>> +       FH(CLK_APMIXED_MFGPLL, FH_MFGPLL, 0xb4),
>>>> +       FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL2, 0xc8),
>>>> +       FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0xf0),
>>>> +       FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x104),
>>>> +       FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x118),
>>>> +       FH(CLK_APMIXED_IMGPLL, FH_IMGPLL, 0x12c),
>>>> +       FH(CLK_APMIXED_VDECPLL, FH_VDECPLL, 0x140),
>>>> +       FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL1, 0x154),
>>>> +};
>>>> +
>>>>    static const struct of_device_id of_match_clk_mt8195_apmixed[] = {
>>>>           { .compatible = "mediatek,mt8195-apmixedsys", },
>>>>           {}
>>>> @@ -114,13 +171,17 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
>>>>    {
>>>>           struct clk_hw_onecell_data *clk_data;
>>>>           struct device_node *node = pdev->dev.of_node;
>>>> +       const u8 *fhctl_node = "mediatek,mt8195-fhctl";
>>>>           int r;
>>>>
>>>>           clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
>>>>           if (!clk_data)
>>>>                   return -ENOMEM;
>>>>
>>>> -       r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>>>> +       fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
>>>> +
>>>> +       r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
>>>> +                                   pllfhs, ARRAY_SIZE(pllfhs), clk_data);
>>>>           if (r)
>>>>                   goto free_apmixed_data;
>>>>
>>>> @@ -140,7 +201,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
>>>>    unregister_gates:
>>>>           mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
>>>>    unregister_plls:
>>>> -       mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
>>>> +       mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
>>>> +                                 ARRAY_SIZE(pllfhs), clk_data);
>>>
>>> Nit: I think this could be squeezed into one line.
>>>
>>>>    free_apmixed_data:
>>>>           mtk_free_clk_data(clk_data);
>>>>           return r;
>>>> @@ -153,7 +215,8 @@ static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
>>>>
>>>>           of_clk_del_provider(node);
>>>>           mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
>>>> -       mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
>>>> +       mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
>>>> +                                 ARRAY_SIZE(pllfhs), clk_data);
>>>
>>> Same here.
>>>
>>
>> That's the same on the others as well, but if I compress those lines I will have
>> to rebase the clocks cleanup series again and send the 54 patches again.. I'd like
>> to avoid that noise.
>>
>> If you really want though, I can do that... what should I do?
> 
> I see. Let's keep it the way it is then.
> 

Great. We can always do a small cleanup later, if needed.

Angelo
