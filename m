Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45F6DF71A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDLNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDLNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1617EC1;
        Wed, 12 Apr 2023 06:24:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 681776603102;
        Wed, 12 Apr 2023 14:23:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305836;
        bh=C+NuJI3gJQOvg2W2Jt6ytwX+Z1SaqR9sW/KQiI2QbiI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mbo9WZ5dvorklyrGK5QC93j7iWln5Nb1/0dZiovAp8HYc7dmf9gr1K3T6vJUTMDWF
         KBjARKXpwJsIkz1QJ6vDHsZNtV8kVU8Jj0BV/XrzMCX1c1zsD2DUMe4viOORDcm+52
         D80e6axsE5IlRNwR26L7uf7pl+V6gFyzIck6f29rFY9zvzhCBp1KiKmTBlTC9kQ/9M
         nyf4m+rOp2OB3OrxR2uLA6qWo7Ku1L2tyeEtuX5E/XpQrCrk7x6GAIxCwcOCbvoPUc
         8UrR0BepUKP3t0nKCa3Is6oXrI8kWwrNKpeDT69WR3iL8uathgheIz0FQheBvmzc8w
         wAERQg2FZvT8g==
Message-ID: <c66642f5-470f-9d39-19d8-e76f8b6288b3@collabora.com>
Date:   Wed, 12 Apr 2023 15:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 22/27] arm64: dts: mediatek: mt6795: Copyright header
 additions
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-23-angelogioacchino.delregno@collabora.com>
 <7466cf12-9411-cb35-8e8b-fa50f5efe492@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7466cf12-9411-cb35-8e8b-fa50f5efe492@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 14:41, Matthias Brugger ha scritto:
> 
> 
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>> I have added more than 800 lines to this devicetree: adding myself to
>> the copyright header.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> index 29ca9a7bf0b3..a4c950b65006 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> @@ -2,6 +2,9 @@
>>   /*
>>    * Copyright (c) 2015 MediaTek Inc.
>>    * Author: Mars.C <mars.cheng@mediatek.com>
>> + *
>> + * Copyright (C) 2023 Collabora Ltd.
>> + *                    AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
> 
> Indentation?
> 
> BTW from what I understand the copyright will be by your employer, Collabora not 
> you, but I'm not an legal expert :)
> 

The copyright *is* by my employer ... but at the same time I'm adding my name,
because it's me performing the work.

I didn't write (c) myname, but (c) employer, myname - that's ok :-)

Or was the comment about the commit description? Should that be reworded?

Cheers,
Angelo

