Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C47310F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbjFOHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjFOHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:38:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66372736;
        Thu, 15 Jun 2023 00:37:49 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 431FD6606F59;
        Thu, 15 Jun 2023 08:37:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686814657;
        bh=R3fJvUlj/ctk9RC181p+elqsFdm6HvFFRA2Jl14ju8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DWG1cx/ySoxjCKORzCNexzZ/sg6wIhoQr4v5AsrUDOHjVl8+Zt3LsPrkGU9dN6Kcz
         ffouyVFkWcRV3kSC64bkKm7iATOBIVPNdbhVz3eLYO2aqmNq47D75RgA2Ip5uoTfBb
         rO+pT7JFEAsaT5/kIRasoml7ogyrgxlq9h9hfWrcR0tINbgJ4m3qnNh11xEGxvJbg8
         rUw/aSjeWsCU9GwuP/x0MHQSnEvDB42nOcSIMErMSom4ROf9jNdoOsGkanRvo67FTs
         KvWGRqIzuE5SZhYCpOoh8noyMoC6HUeQH50Wbd5qBAPdZeIQGIita2BO1HZeBcA2ud
         rcHneyYNJQQ2Q==
Message-ID: <d8dbb374-b34a-a69a-289d-d051a757bbf3@collabora.com>
Date:   Thu, 15 Jun 2023 09:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 12/15] soc: mediatek: Add MT8188 VDO1 reset bit map
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
 <20230614073125.17958-13-shawn.sung@mediatek.com>
 <e4f98dc5-0fa6-14aa-f8d0-e4bf30ecca5c@collabora.com>
 <4dca96de37b4e6e3321bc304df8bad678edfebc3.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4dca96de37b4e6e3321bc304df8bad678edfebc3.camel@mediatek.com>
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

Il 15/06/23 08:01, Shawn Sung (宋孝謙) ha scritto:
> Hi Angelo,
> 
> Got it. Will fix this in the next version.
> 
> Added a new define in mtk-mmsys.h:
> #define MMSYS_RST_NR(bank, bit) ((bank * 32) + bit)
> 
> And define the reset table as:
> static const u8 mmsys_mt8188_vdo1_rst_tb[] = {
>          [MT8188_VDO1_RST_SMI_LARB2]           = MMSYS_RST_NR(0, 0),
>          ...
>          [MT8188_VDO1_RST_VPP_MERGE2]          = MMSYS_RST_NR(0, 11),
>          [MT8188_VDO1_RST_VPP_MERGE3]          = MMSYS_RST_NR(1, 0),
>          ...
>          [MT8188_VDO1_RST_DISP_RSZ3]           = MMSYS_RST_NR(1, 31),
>          [MT8188_VDO1_RST_HDR_VDO_FE0]         = MMSYS_RST_NR(2, 0),
>      
> ...
>          [MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC] = MMSYS_RST_NR(2, 23),
> };
> 

Okay, that's also good. Go on!

Regards,
Angelo

> Thanks,
> Hsiao Chien Sung
> 
> On Wed, 2023-06-14 at 13:35 +0200, AngeloGioacchino Del Regno wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
>>> Add MT8188 VDO1 reset bit map.
>>>
>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>> ---
>>>    drivers/soc/mediatek/mt8188-mmsys.h | 57
>> +++++++++++++++++++++++++++++
>>>    drivers/soc/mediatek/mtk-mmsys.c    |  3 +-
>>>    2 files changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mt8188-mmsys.h
>> b/drivers/soc/mediatek/mt8188-mmsys.h
>>> index c3e3c5cfe931..208d4dfedc1a 100644
>>> --- a/drivers/soc/mediatek/mt8188-mmsys.h
>>> +++ b/drivers/soc/mediatek/mt8188-mmsys.h
>>> @@ -144,6 +144,63 @@ static const u8 mmsys_mt8188_vdo0_rst_tb[] = {
>>>    [MT8188_VDO0_RST_DISP_RSZ0]= 31,
>>>    };
>>>
>>> +static const u8 mmsys_mt8188_vdo1_rst_tb[] = {
>>> +[MT8188_VDO1_RST_SMI_LARB2]= 0,
>>> +[MT8188_VDO1_RST_SMI_LARB3]= 1,
>>> +[MT8188_VDO1_RST_GALS]= 2,
>>> +[MT8188_VDO1_RST_FAKE_ENG0]= 3,
>>> +[MT8188_VDO1_RST_FAKE_ENG1]= 4,
>>> +[MT8188_VDO1_RST_MDP_RDMA0]= 5,
>>> +[MT8188_VDO1_RST_MDP_RDMA1]= 6,
>>> +[MT8188_VDO1_RST_MDP_RDMA2]= 7,
>>> +[MT8188_VDO1_RST_MDP_RDMA3]= 8,
>>> +[MT8188_VDO1_RST_VPP_MERGE0]= 9,
>>> +[MT8188_VDO1_RST_VPP_MERGE1]= 10,
>>> +[MT8188_VDO1_RST_VPP_MERGE2]= 11,
>>> +[MT8188_VDO1_RST_VPP_MERGE3]= 32 + 0,
>>
>> Works, but there's a better way.
>>
>> 32 + 0 means that you're using reset SW1 register, so you can do
>>
>> #define MT8188_MMSYS_RST_NR_PER_BANK32
>> #define MT8188_RST_SW1_OFFSETMT8188_MMSYS_RST_NR_PER_BANK
>> #define MT8188_RST_SW2_OFFSETMT8188_MMSYS_RST_NR_PER_BANK * 2
>>
>> [MT8188_VDO1_RST_VPP_MERGE3] = MT8188_RST_SW1_OFFSET + 0
>> [MT8188_VDO1_RST_VPP_MERGE4] = MT8188_RST_SW1_OFFSET + 0
>> .......
>> [MT8188_VDO1_RST_HDR_VDO_FE0] = MT8188_RST_SW2_OFFSET + 0
>> ...etc
>>
>> Reading this will make it clear that a certain reset bit is in a
>> different
>> (sequential or not) register.
>>
>> P.S.: If the RST_NR_PER_BANK is *not* MT8188 specific (as in, all
>> reset registers
>> for all SoCs are always 32 bits, which I believe is true), you could
>> move that
>> definition to mtk-mmsys.h as
>>         #define MMSYS_RST_NR_PER_BANK32
>> and then define the offsets in mt8188-mmsys.h as
>>         #define MT8188_RST_SW1_OFFSET MMSYS_RST_NR_PER_BANK
>>         .... etc
>>
>> Thanks,
>> Angelo
>>
>>

