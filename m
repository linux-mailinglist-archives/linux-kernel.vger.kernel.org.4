Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B6731104
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbjFOHlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbjFOHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:39:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108902961;
        Thu, 15 Jun 2023 00:39:29 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F6C46606F5A;
        Thu, 15 Jun 2023 08:38:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686814727;
        bh=D8b9wEVkgMUHSTkiQNASkpLChgF1KeGetcBYupmfoxM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VtUmslzgCZFv/y2YwVwnFtUCGPOaLYr0/VX+uzWHuVHvf84rc5WnEZ7toQeW/1o8t
         q0YQTLrkHCP//nOSgwGLzXBmGeaKsKY7ZYGki/+cJVlPDp0Ghd0xGJjEOMVdD8S0Il
         Wy6OkAkWhUDUVkmNDbx4M0E8EzmCPiBRGaC0qldY4JjyzNzthfewYOtZ/v0AMTTth+
         5oJusFBKYZuSEmYzk6wCDLWBa8lHBPbSpurnUSgzAhX7g1B26lKwaKkvW/3l//FTGS
         HBBz1hAnXE1014rqnKYXUyaL3x5itTWeLPQgXkQFoFqZUey0RwZjIFIlJhWvhSRGeU
         zDIEOI3ePeT1w==
Message-ID: <a793cc17-574a-68d3-f2cb-3117c8d892f1@collabora.com>
Date:   Thu, 15 Jun 2023 09:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/15] soc: mediatek: Support MT8188 VDOSYS1 in
 mtk-mmsys
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-9-shawn.sung@mediatek.com>
 <c2127bcd-f990-1c83-45b2-d3a19f66e5bc@collabora.com>
 <aa4d0857ca6d00371eecbc8440d339587526fb9d.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <aa4d0857ca6d00371eecbc8440d339587526fb9d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/23 08:10, Shawn Sung (宋孝謙) ha scritto:
> Thank you for saying that. Will do more in the future.
>   
> I found two typos in the description.
> Will fix them in the next version as well.
> (ETDHR -> ETHDR, VSNYC -> VSYNC)
> 

I honestly didn't immediately notice the typos. Yes please fix them.

Keep up the good work!

Regards,
Angelo

> On Wed, 2023-06-14 at 13:21 +0200, AngeloGioacchino Del Regno wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
>>> - Add register definitions for MT8188
>>> - Add VDOSYS1 routing table
>>> - Update MUTEX definitions accordingly
>>> - Set VSYNC length from 0x40 (default) to 1 since ETHDR is bypassed
>>>
>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>
>> I love that you added documentation to struct mtk_mmsys_driver_data.
>> Good job!
>>
>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>
>>> ---
>>>    drivers/soc/mediatek/mt8188-mmsys.h | 127
>> ++++++++++++++++++++++++++++
>>>    drivers/soc/mediatek/mtk-mmsys.c    |  13 +++
>>>    drivers/soc/mediatek/mtk-mmsys.h    |  29 +++++++
>>>    drivers/soc/mediatek/mtk-mutex.c    |  35 ++++++++
>>>    4 files changed, 204 insertions(+)
>>>
>>> diff --git a/drivers/soc/mediatek/mt8188-mmsys.h
>> b/drivers/soc/mediatek/mt8188-mmsys.h
>>> index 448cc3761b43..447afb72d95f 100644
>>> --- a/drivers/soc/mediatek/mt8188-mmsys.h
>>> +++ b/drivers/soc/mediatek/mt8188-mmsys.h
>>> @@ -67,6 +67,57 @@
>>>    #define MT8188_SOUT_DSC_WRAP0_OUT_TO_VPP_MERGEBIT(18)
>>>    #define MT8188_SOUT_DSC_WRAP0_OUT_TO_DISP_WDMA0BIT(19)
>>>
>>> +#define MT8188_VDO1_SW0_RST_B0x1d0
>>> +#define MT8188_VDO1_HDR_TOP_CFG0xd00
>>> +#define MT8188_VDO1_MIXER_IN1_ALPHA0xd30
>>> +#define MT8188_VDO1_MIXER_IN1_PAD0xd40
>>> +#define MT8188_VDO1_MERGE0_ASYNC_CFG_WD0xe30
>>> +#define MT8188_VDO1_HDRBE_ASYNC_CFG_WD0xe70
>>> +#define MT8188_VDO1_VPP_MERGE0_P0_SEL_IN0xf04
>>> +#define MT8188_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA01
>>> +#define MT8188_VDO1_VPP_MERGE0_P1_SEL_IN0xf08
>>> +#define MT8188_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA11
>>> +#define MT8188_VDO1_DISP_DPI1_SEL_IN0xf10
>>> +#define MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT0
>>> +#define MT8188_VDO1_DISP_DP_INTF0_SEL_IN0xf14
>>> +#define MT8188_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT0
>>> +#define MT8188_VDO1_MERGE4_SOUT_SEL0xf18
>>> +#define MT8188_MERGE4_SOUT_TO_DPI1_SELBIT(2)
>>> +#define MT8188_MERGE4_SOUT_TO_DP_INTF0_SELBIT(3)
>>> +#define MT8188_VDO1_MIXER_IN1_SEL_IN0xf24
>>> +#define MT8188_MIXER_IN1_SEL_IN_FROM_MERGE0_ASYNC_SOUT1
>>> +#define MT8188_VDO1_MIXER_IN2_SEL_IN0xf28
>>> +#define MT8188_MIXER_IN2_SEL_IN_FROM_MERGE1_ASYNC_SOUT1
>>> +#define MT8188_VDO1_MIXER_IN3_SEL_IN0xf2c
>>> +#define MT8188_MIXER_IN3_SEL_IN_FROM_MERGE2_ASYNC_SOUT1
>>> +#define MT8188_VDO1_MIXER_IN4_SEL_IN0xf30
>>> +#define MT8188_MIXER_IN4_SEL_IN_FROM_MERGE3_ASYNC_SOUT1
>>> +#define MT8188_VDO1_MIXER_OUT_SOUT_SEL0xf34
>>> +#define MT8188_MIXER_SOUT_TO_MERGE4_ASYNC_SEL1
>>> +#define MT8188_VDO1_VPP_MERGE1_P0_SEL_IN0xf3c
>>> +#define MT8188_VPP_MERGE1_P0_SEL_IN_FROM_MDP_RDMA21
>>> +#define MT8188_VDO1_MERGE0_ASYNC_SOUT_SEL0xf40
>>> +#define MT8188_SOUT_TO_MIXER_IN1_SEL1
>>> +#define MT8188_VDO1_MERGE1_ASYNC_SOUT_SEL0xf44
>>> +#define MT8188_SOUT_TO_MIXER_IN2_SEL1
>>> +#define MT8188_VDO1_MERGE2_ASYNC_SOUT_SEL0xf48
>>> +#define MT8188_SOUT_TO_MIXER_IN3_SEL1
>>> +#define MT8188_VDO1_MERGE3_ASYNC_SOUT_SEL0xf4c
>>> +#define MT8188_SOUT_TO_MIXER_IN4_SEL1
>>> +#define MT8188_VDO1_MERGE4_ASYNC_SEL_IN0xf50
>>> +#define MT8188_MERGE4_ASYNC_SEL_IN_FROM_MIXER_OUT_SOUT1
>>> +#define MT8188_VDO1_MIXER_IN1_SOUT_SEL0xf58
>>> +#define MT8188_MIXER_IN1_SOUT_TO_DISP_MIXER0
>>> +#define MT8188_VDO1_MIXER_IN2_SOUT_SEL0xf5c
>>> +#define MT8188_MIXER_IN2_SOUT_TO_DISP_MIXER0
>>> +#define MT8188_VDO1_MIXER_IN3_SOUT_SEL0xf60
>>> +#define MT8188_MIXER_IN3_SOUT_TO_DISP_MIXER0
>>> +#define MT8188_VDO1_MIXER_IN4_SOUT_SEL0xf64
>>> +#define MT8188_MIXER_IN4_SOUT_TO_DISP_MIXER0
>>> +#define MT8188_VDO1_MIXER_SOUT_SEL_IN0xf68
>>> +#define MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER0
>>> +#define MT8188_VDO1_MIXER_VSYNC_LEN0xd5c
>>> +
>>>    static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[]
>> = {
>>>    {
>>>    DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
>>> @@ -146,4 +197,80 @@ static const struct mtk_mmsys_routes
>> mmsys_mt8188_routing_table[] = {
>>>    },
>>>    };
>>>
>>> +static const struct mtk_mmsys_routes
>> mmsys_mt8188_vdo1_routing_table[] = {
>>> +{
>>> +DDP_COMPONENT_MDP_RDMA0, DDP_COMPONENT_MERGE1,
>>> +MT8188_VDO1_VPP_MERGE0_P0_SEL_IN, GENMASK(0, 0),
>>> +MT8188_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA0
>>> +}, {
>>> +DDP_COMPONENT_MDP_RDMA1, DDP_COMPONENT_MERGE1,
>>> +MT8188_VDO1_VPP_MERGE0_P1_SEL_IN, GENMASK(0, 0),
>>> +MT8188_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA1
>>> +}, {
>>> +DDP_COMPONENT_MDP_RDMA2, DDP_COMPONENT_MERGE2,
>>> +MT8188_VDO1_VPP_MERGE1_P0_SEL_IN, GENMASK(0, 0),
>>> +MT8188_VPP_MERGE1_P0_SEL_IN_FROM_MDP_RDMA2
>>> +}, {
>>> +DDP_COMPONENT_MERGE1, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MERGE0_ASYNC_SOUT_SEL, GENMASK(1, 0),
>>> +MT8188_SOUT_TO_MIXER_IN1_SEL
>>> +}, {
>>> +DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MERGE1_ASYNC_SOUT_SEL, GENMASK(1, 0),
>>> +MT8188_SOUT_TO_MIXER_IN2_SEL
>>> +}, {
>>> +DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MERGE2_ASYNC_SOUT_SEL, GENMASK(1, 0),
>>> +MT8188_SOUT_TO_MIXER_IN3_SEL
>>> +}, {
>>> +DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MERGE3_ASYNC_SOUT_SEL, GENMASK(1, 0),
>>> +MT8188_SOUT_TO_MIXER_IN4_SEL
>>> +}, {
>>> +DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
>>> +MT8188_VDO1_MIXER_OUT_SOUT_SEL, GENMASK(0, 0),
>>> +MT8188_MIXER_SOUT_TO_MERGE4_ASYNC_SEL
>>> +}, {
>>> +DDP_COMPONENT_MERGE1, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MIXER_IN1_SEL_IN, GENMASK(0, 0),
>>> +MT8188_MIXER_IN1_SEL_IN_FROM_MERGE0_ASYNC_SOUT
>>> +}, {
>>> +DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MIXER_IN2_SEL_IN, GENMASK(0, 0),
>>> +MT8188_MIXER_IN2_SEL_IN_FROM_MERGE1_ASYNC_SOUT
>>> +}, {
>>> +DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MIXER_IN3_SEL_IN, GENMASK(0, 0),
>>> +MT8188_MIXER_IN3_SEL_IN_FROM_MERGE2_ASYNC_SOUT
>>> +}, {
>>> +DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER,
>>> +MT8188_VDO1_MIXER_IN4_SEL_IN, GENMASK(0, 0),
>>> +MT8188_MIXER_IN4_SEL_IN_FROM_MERGE3_ASYNC_SOUT
>>> +}, {
>>> +DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
>>> +MT8188_VDO1_MIXER_SOUT_SEL_IN, GENMASK(2, 0),
>>> +MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER
>>> +}, {
>>> +DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
>>> +MT8188_VDO1_MERGE4_ASYNC_SEL_IN, GENMASK(2, 0),
>>> +MT8188_MERGE4_ASYNC_SEL_IN_FROM_MIXER_OUT_SOUT
>>> +}, {
>>> +DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
>>> +MT8188_VDO1_DISP_DPI1_SEL_IN, GENMASK(1, 0),
>>> +MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT
>>> +}, {
>>> +DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
>>> +MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(1, 0),
>>> +MT8188_MERGE4_SOUT_TO_DPI1_SEL
>>> +}, {
>>> +DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
>>> +MT8188_VDO1_DISP_DP_INTF0_SEL_IN, GENMASK(1, 0),
>>> +MT8188_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT
>>> +}, {
>>> +DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
>>> +MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(3, 0),
>>> +MT8188_MERGE4_SOUT_TO_DP_INTF0_SEL
>>> +}
>>> +};
>>> +
>>>    #endif /* __SOC_MEDIATEK_MT8188_MMSYS_H */
>>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
>> b/drivers/soc/mediatek/mtk-mmsys.c
>>> index 9619faa796e8..3a81ef2bcc3c 100644
>>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>>> @@ -89,6 +89,15 @@ static const struct mtk_mmsys_driver_data
>> mt8188_vdosys0_driver_data = {
>>>    .num_routes = ARRAY_SIZE(mmsys_mt8188_routing_table),
>>>    };
>>>
>>> +static const struct mtk_mmsys_driver_data
>> mt8188_vdosys1_driver_data = {
>>> +.clk_driver = "clk-mt8188-vdo1",
>>> +.routes = mmsys_mt8188_vdo1_routing_table,
>>> +.num_routes = ARRAY_SIZE(mmsys_mt8188_vdo1_routing_table),
>>> +.sw0_rst_offset = MT8188_VDO1_SW0_RST_B,
>>> +.num_resets = 96,
>>> +.vsync_len = 1,
>>> +};
>>> +
>>>    static const struct mtk_mmsys_driver_data
>> mt8192_mmsys_driver_data = {
>>>    .clk_driver = "clk-mt8192-mm",
>>>    .routes = mmsys_mt8192_routing_table,
>>> @@ -213,6 +222,9 @@ void mtk_mmsys_mixer_in_config(struct device
>> *dev, int idx, bool alpha_sel, u16
>>>          alpha_sel << (19 + idx), cmdq_pkt);
>>>    mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_PAD + (idx -
>> 1) * 4,
>>>          GENMASK(31, 16) | GENMASK(1, 0), biwidth << 16 | mode,
>> cmdq_pkt);
>>> +if (mmsys->data->vsync_len)
>>> +mtk_mmsys_update_bits(mmsys, MT8188_VDO1_MIXER_VSYNC_LEN, ~0,
>>> +      mmsys->data->vsync_len, cmdq_pkt);
>>>    }
>>>    EXPORT_SYMBOL_GPL(mtk_mmsys_mixer_in_config);
>>>
>>> @@ -431,6 +443,7 @@ static const struct of_device_id
>> of_match_mtk_mmsys[] = {
>>>    { .compatible = "mediatek,mt8183-mmsys", .data =
>> &mt8183_mmsys_driver_data },
>>>    { .compatible = "mediatek,mt8186-mmsys", .data =
>> &mt8186_mmsys_driver_data },
>>>    { .compatible = "mediatek,mt8188-vdosys0", .data =
>> &mt8188_vdosys0_driver_data },
>>> +{ .compatible = "mediatek,mt8188-vdosys1", .data =
>> &mt8188_vdosys1_driver_data },
>>>    { .compatible = "mediatek,mt8192-mmsys", .data =
>> &mt8192_mmsys_driver_data },
>>>    /* "mediatek,mt8195-mmsys" compatible is deprecated */
>>>    { .compatible = "mediatek,mt8195-mmsys", .data =
>> &mt8195_vdosys0_driver_data },
>>> diff --git a/drivers/soc/mediatek/mtk-mmsys.h
>> b/drivers/soc/mediatek/mtk-mmsys.h
>>> index 6725403d2e3a..e4ab46017430 100644
>>> --- a/drivers/soc/mediatek/mtk-mmsys.h
>>> +++ b/drivers/soc/mediatek/mtk-mmsys.h
>>> @@ -86,6 +86,34 @@ struct mtk_mmsys_routes {
>>>    u32 val;
>>>    };
>>>
>>> +/**
>>> + * struct mtk_mmsys_driver_data - settings for the mmsys
>>> + * @clk_driver: Clock driver name that the mmsys is using
>>> + *              (defined in drivers/clk/mediatek/clk-*.c).
>>> + * @routes: Routing table of the mmsys.
>>> + *          It provides mux settings from one module to another.
>>> + * @num_routes: Array size of the routes.
>>> + * @sw0_rst_offset: Register offset for the reset control.
>>> + * @num_resets: Number of reset bits that are defined
>>> + * @is_vppsys: Whether the mmsys is VPPSYS (Video Processing Pipe)
>>> + *             or VDOSYS (Video). Only VDOSYS needs to be added to
>> drm driver.
>>> + * @vsync_len: VSYNC length of the MIXER.
>>> + *             VSYNC is usually triggered by the connector, so its
>> length is
>>> + *             a fixed value as long as the frame rate is decided,
>> but ETDHR and
>>> + *             MIXER generate their own VSYNC due to hardware
>> design, therefore
>>> + *             MIXER has to sync with ETHDR by adjusting VSYNC
>> length.
>>> + *             On MT8195, there is no such setting so we use the
>> gap between
>>> + *             falling edge and rising edge of SOF (Start of
>> Frame) signal to
>>> + *             do the job, but since MT8188, VSNYC_LEN setting is
>> introduced to
>>> + *             solve the problem and is given 0x40 (ticks) as the
>> default value.
>>> + *             Please notice that this value has to be set to 1
>> (minimum) if
>>> + *             ETHDR is bypassed, otherwise MIXER could wait too
>> long and causing
>>> + *             underflow.
>>> + *
>>> + * Each MMSYS (multi-media system) may have different settings,
>> they may use
>>> + * different clock sources, mux settings, reset control ...etc.,
>> and these
>>> + * differences are all stored here.
>>> + */
>>>    struct mtk_mmsys_driver_data {
>>>    const char *clk_driver;
>>>    const struct mtk_mmsys_routes *routes;
>>> @@ -93,6 +121,7 @@ struct mtk_mmsys_driver_data {
>>>    const u16 sw0_rst_offset;
>>>    const u32 num_resets;
>>>    const bool is_vppsys;
>>> +const u8 vsync_len;
>>>    };
>>>
>>>    /*
>>> diff --git a/drivers/soc/mediatek/mtk-mutex.c
>> b/drivers/soc/mediatek/mtk-mutex.c
>>> index 26f3d9a41496..11dda20eb462 100644
>>> --- a/drivers/soc/mediatek/mtk-mutex.c
>>> +++ b/drivers/soc/mediatek/mtk-mutex.c
>>> @@ -134,6 +134,22 @@
>>>    #define MT8188_MUTEX_MOD_DISP_POSTMASK024
>>>    #define MT8188_MUTEX_MOD2_DISP_PWM033
>>>
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA00
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA11
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA22
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA33
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA44
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA55
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA66
>>> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA77
>>> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE020
>>> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE121
>>> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE222
>>> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE323
>>> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE424
>>> +#define MT8188_MUTEX_MOD_DISP1_DISP_MIXER30
>>> +#define MT8188_MUTEX_MOD_DISP1_DP_INTF139
>>> +
>>>    #define MT8195_MUTEX_MOD_DISP_OVL00
>>>    #define MT8195_MUTEX_MOD_DISP_WDMA01
>>>    #define MT8195_MUTEX_MOD_DISP_RDMA02
>>> @@ -265,6 +281,7 @@
>>>    #define MT8183_MUTEX_SOF_DPI02
>>>    #define MT8188_MUTEX_SOF_DSI01
>>>    #define MT8188_MUTEX_SOF_DP_INTF03
>>> +#define MT8188_MUTEX_SOF_DP_INTF14
>>>    #define MT8195_MUTEX_SOF_DSI01
>>>    #define MT8195_MUTEX_SOF_DSI12
>>>    #define MT8195_MUTEX_SOF_DP_INTF03
>>> @@ -276,6 +293,7 @@
>>>    #define MT8183_MUTEX_EOF_DPI0(MT8183_MUTEX_SOF_DPI0 << 6)
>>>    #define MT8188_MUTEX_EOF_DSI0(MT8188_MUTEX_SOF_DSI0 << 7)
>>>    #define MT8188_MUTEX_EOF_DP_INTF0(MT8188_MUTEX_SOF_DP_INTF0 << 7)
>>> +#define MT8188_MUTEX_EOF_DP_INTF1(MT8188_MUTEX_SOF_DP_INTF1 << 7)
>>>    #define MT8195_MUTEX_EOF_DSI0(MT8195_MUTEX_SOF_DSI0 << 7)
>>>    #define MT8195_MUTEX_EOF_DSI1(MT8195_MUTEX_SOF_DSI1 << 7)
>>>    #define MT8195_MUTEX_EOF_DP_INTF0(MT8195_MUTEX_SOF_DP_INTF0 << 7)
>>> @@ -446,6 +464,21 @@ static const unsigned int
>> mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>>>    [DDP_COMPONENT_DSI0] = MT8188_MUTEX_MOD_DISP_DSI0,
>>>    [DDP_COMPONENT_PWM0] = MT8188_MUTEX_MOD2_DISP_PWM0,
>>>    [DDP_COMPONENT_DP_INTF0] = MT8188_MUTEX_MOD_DISP_DP_INTF0,
>>> +[DDP_COMPONENT_MDP_RDMA0] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA0,
>>> +[DDP_COMPONENT_MDP_RDMA1] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA1,
>>> +[DDP_COMPONENT_MDP_RDMA2] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA2,
>>> +[DDP_COMPONENT_MDP_RDMA3] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA3,
>>> +[DDP_COMPONENT_MDP_RDMA4] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA4,
>>> +[DDP_COMPONENT_MDP_RDMA5] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA5,
>>> +[DDP_COMPONENT_MDP_RDMA6] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA6,
>>> +[DDP_COMPONENT_MDP_RDMA7] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA7,
>>> +[DDP_COMPONENT_MERGE1] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE0,
>>> +[DDP_COMPONENT_MERGE2] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE1,
>>> +[DDP_COMPONENT_MERGE3] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE2,
>>> +[DDP_COMPONENT_MERGE4] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE3,
>>> +[DDP_COMPONENT_ETHDR_MIXER] = MT8188_MUTEX_MOD_DISP1_DISP_MIXER,
>>> +[DDP_COMPONENT_MERGE5] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE4,
>>> +[DDP_COMPONENT_DP_INTF1] = MT8188_MUTEX_MOD_DISP1_DP_INTF1,
>>>    };
>>>
>>>    static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX]
>> = {
>>> @@ -606,6 +639,8 @@ static const unsigned int
>> mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
>>>    MT8188_MUTEX_SOF_DSI0 | MT8188_MUTEX_EOF_DSI0,
>>>    [MUTEX_SOF_DP_INTF0] =
>>>    MT8188_MUTEX_SOF_DP_INTF0 | MT8188_MUTEX_EOF_DP_INTF0,
>>> +[MUTEX_SOF_DP_INTF1] =
>>> +MT8188_MUTEX_SOF_DP_INTF1 | MT8188_MUTEX_EOF_DP_INTF1,
>>>    };
>>>
>>>    static const unsigned int mt8195_mutex_sof[DDP_MUTEX_SOF_MAX] = {
>>> --
>>> 2.18.0
>>>
>>

