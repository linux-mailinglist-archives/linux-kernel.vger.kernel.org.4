Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E4644308
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiLFMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiLFMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:19:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E728E27;
        Tue,  6 Dec 2022 04:19:56 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91C4A660035D;
        Tue,  6 Dec 2022 12:19:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670329194;
        bh=l310F9lHcGhGvP4PuGtAy05tWbjB4PQoJ3xaWw36ABM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gttCpPDYm0hfTw/9o5b8PCwS0lR+0JzCaoDBMHOUWsCpuY1DQIz6ReUTPcpHKJnCk
         Etv1bSL67CKIoWAbqV8tdl520zDnCNEHZ5MfLI7LPHa2T0TQaVYH3Il3UmKg6PU1Yt
         +SZh2bw1HX+hvWvGjZ8zK6yi1EdGtpYBQI7WTZKzIzh1Q7TrvtZhxBwEFGZbijunJW
         JEfWxF7VXO1BOocXgHM8IjdVpHOdlfy0VdG6s4JcvVwDHs8AmCL2RENS3siV937e8f
         I8xkIxGm/+gcRYMox0bVcOz0FFD02COEr2s6tjgk9HidF8K2iH31MbnisDs5eLVohj
         Mc97lj4nNI3UA==
Message-ID: <9992c9a5-059a-9396-32ce-7ed63cd12a96@collabora.com>
Date:   Tue, 6 Dec 2022 13:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
Content-Language: en-US
To:     =?UTF-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
 <ce449a0c-efcc-0ac1-fb8e-c2b4148a5bc1@collabora.com>
 <a8f706b37f5decf91bfa9a9ac8cf04be4346dd85.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a8f706b37f5decf91bfa9a9ac8cf04be4346dd85.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/12/22 10:04, Xiangsheng Hou (侯祥胜) ha scritto:
> Hi Angelo,
> 
> On Mon, 2022-12-05 at 15:21 +0100, AngeloGioacchino Del Regno wrote:
>> Il 05/12/22 07:57, Xiangsheng Hou ha scritto:
>>> Add mediatek,rx-latch-latency property which adjust read delay in
>>> the
>>> unit of clock cycle.
>>>
>>> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    .../devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml     | 7
>>> +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
>>> mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
>>> mtk-snfi.yaml
>>> index bab23f1b11fd..6e6ff8d73fcd 100644
>>> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-
>>> snfi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-
>>> snfi.yaml
>>> @@ -45,6 +45,13 @@ properties:
>>>        description: device-tree node of the accompanying ECC engine.
>>>        $ref: /schemas/types.yaml#/definitions/phandle
>>>    
>>> +  mediatek,rx-latch-latency:
>>> +    description: Rx delay to sample data with this value, the
>>> value
>>> +                 unit is clock cycle.
>>
>> Can't we use nanoseconds or microseconds as a unit here, instead of
>> clock cycles?
> 
> The clock cycle will be various with MediaTek SPI NAND controller which
> clock frequency can support 26/52/68/81/104MHz...
> It`s may be easy to configure and understand with clock cycle in unit.
> 

Yes, but whatever clock frequency we use, the target is to always wait for
X nanoseconds, right?

Waiting for 5 clock cycles at 104MHz is obviously not the same as waiting
for the same 5 clock cycles at 26MHz: in that case, expressing the value
in nanoseconds or microseconds would make that independent from the
controller's clock frequency as the calculation from `time` to `cycles`
would be performed inside of the driver.

Regards,
Angelo

