Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A9D72BE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjFLKNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjFLKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16DE10CC;
        Mon, 12 Jun 2023 02:53:56 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5AE1E6605907;
        Mon, 12 Jun 2023 10:53:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686563635;
        bh=12+M92ejc+eDkMrCoA63t6hfzspIbG8XPxdjeW+mgqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IEjF90KqrXkK2WXSoPZpydyHRiHNiisuQv0m/SM8Icg68gW/oWxAhG7JpoS2bPH3A
         ECZs3viXyqx83QNASlzbfaP4XcIDuAPijapONC6WRlhIwLUioYvHXt5AHXZRsqUtpb
         dHcoHLn1oGJSTJCBqN6IvGwgGRqNY4SijA993M+HuKivXnM5LER+zRSQclNA+zjqcJ
         si8uTlazy6ukbUAP2RFAmCTMc9PLqXcVXrqRAgkn6uPk6QNskA+Z9PFlao54EZy7rL
         0zX9P8xaaMNp75bQoZWzzR/vkKe+zFz7je2tA0Kf7Bb37Z92qltgyLsewoTbvQdPWY
         oKQ1uWqcd2C9A==
Message-ID: <fda4f196-8466-8290-9072-d80fff367720@collabora.com>
Date:   Mon, 12 Jun 2023 11:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/5] Enable decoder for mt8183
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <380c6489-7a3c-778b-5b81-6339b6964b90@xs4all.nl>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <380c6489-7a3c-778b-5b81-6339b6964b90@xs4all.nl>
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

Il 12/06/23 09:02, Hans Verkuil ha scritto:
> Hi Nicolas,
> 
> On 07/06/2023 22:53, Nícolas F. R. A. Prado wrote:
>>
>> This series enables the hardware decoder present on mt8183. At first
>> glance, the only missing piece is the devicetree node for it, however,
>> simply adding it as is would cause an address collision between the
>> first register iospace and the clock-controller node, so a rework of the
>> dt-binding and driver, as well as addition of a clock, were needed
>> first.
>>
>> Tested that H264 decoding works with the hardware decoder on
>> mt8183-kukui-jacuzzi-juniper-sku16, giving a fluster score of 98/135 on
>> the JVT-AVC_V1 test suite. And ensured other SoCs (MT8192 and MT8195)
>> still work as usual.
>>
>> Changes in v2:
>> - Merged commit 1 (media: dt-bindings: mediatek,vcodec: Allow single
>>    clock for mt8183) into commit 3 (media: dt-bindings: mediatek,vcodec:
>>    Remove VDEC_SYS for mt8183)
>> - Further constrained properties in dt-binding
>> - Added CLK_IGNORE_UNUSED flag to active clock
>> - Reformatted reg-names in DT node
>>
>> Nícolas F. R. A. Prado (4):
>>    media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
>>    media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
>>    media: mediatek: vcodec: Read HW active status from clock
>>    clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec
> 
> Is the clk patch independent from the others? It's not clear to me.
> 
> If the clk patch has to go in together with the media patches, then
> please let me know and post a v3 where the clk patch is also CC-ed to
> the linux-media mailinglist to ensure it ends up in our patchwork system.
> 
> And in that case I need a Acked-by from the clk maintainer as well.
> 
> If it is independent, then there is no need for a v3 (at least, not
> for this).
> 

The clock patch is not independent, as in the devicetree changes will not
work without the addition of that clock (and of course even fail building),
so that series needs a v3.

Nícolas, please go on and send a v3 as requested.

Cheers,
Angelo

> Regards,
> 
> 	Hans
> 
>>
>> Yunfei Dong (1):
>>    arm64: dts: mediatek: mt8183: Add decoder
>>
>>   .../media/mediatek,vcodec-decoder.yaml        | 65 +++++++++++++++----
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 30 +++++++++
>>   drivers/clk/mediatek/clk-mt8183-vdec.c        |  5 ++
>>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++----
>>   .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 ++++--
>>   .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
>>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
>>   include/dt-bindings/clock/mt8183-clk.h        |  3 +-
>>   8 files changed, 165 insertions(+), 30 deletions(-)
>>
> 
> 


