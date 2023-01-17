Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7766D8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjAQI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjAQI4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:56:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049F525D;
        Tue, 17 Jan 2023 00:56:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BB276602DEA;
        Tue, 17 Jan 2023 08:55:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673945758;
        bh=1l8bRtve9AuPClri5xPXP0TG5XKpU9LVLc3BXtynT2A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TydjTD6Rj/FCxeBP/vVDTukf3FoK86aZv3JisYKUf+jzXnsGdqSRz2OqzPRF8EuJT
         SWOlkcXU4EzKuuWy6429rVrpRC98rTsuNzsvjTZCCmBIaBRyTwJdB/gCj7+POLRrHi
         shLx/I+Gxr37qOy9bzpHOHpb+cKbEv3D+89NdEGZ3KRy79Fx1VsfXwUaF21z90kEqY
         xLus8/u6Sx63dh/5tBJPSJDuBc8ORn6IM3WgC+eJ5F56+8wnsQQe9av5HT3sS+s+v1
         DYwQuMUSvDkbCw2rtdDN739bkHny8za/Nm7dH6NImgNgTuFk3uAE2EKWV5ZdBAB71R
         4hBoLxlsD0Zqw==
Message-ID: <a2fd85fd-c325-043b-a6d5-10969c4eb34b@collabora.com>
Date:   Tue, 17 Jan 2023 09:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 03/11] arm64: dts: mt8195: Add SCP core 1 node
To:     =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
Cc:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-4-tinghan.shen@mediatek.com>
 <cbed65b6-bd7c-b750-ac8e-504fe143a804@collabora.com>
 <52e3bf53a6197f5b42724d7c5e706781ae8a6e56.camel@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <52e3bf53a6197f5b42724d7c5e706781ae8a6e56.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/01/23 09:19, TingHan Shen (沈廷翰) ha scritto:
> On Tue, 2022-09-27 at 13:01 +0200, AngeloGioacchino Del Regno wrote:
>> Il 27/09/22 04:55, Tinghan Shen ha scritto:
>>> Add the 2nd core(core 1) of MT8195 dual-core SCP to devicetree file.
>>> Reserve some SRAM spaces for the core 1 image.
>>>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 +++++++++++++-
>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> index 905d1a90b406..48d457bd39b8 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> @@ -760,12 +760,24 @@
>>>    
>>>    		scp: scp@10500000 {
>>>    			compatible = "mediatek,mt8195-scp";
>>> -			reg = <0 0x10500000 0 0x100000>,
>>> +			reg = <0 0x10500000 0 0xa0000>,
>>>    			      <0 0x10720000 0 0xe0000>,
>>>    			      <0 0x10700000 0 0x8000>;
>>>    			reg-names = "sram", "cfg", "l1tcm";
>>>    			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
>>>    			status = "disabled";
>>> +
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges = <0x105a0000 0 0x105a0000 0x20000>;
>>> +
>>> +			scp_c1: scp-c1@105a0000 {
>>> +				compatible = "mediatek,mt8195-scp-core";
>>> +				reg = <0x105a0000 0x20000>;
>>> +				reg-names = "sram";
>>> +				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +				status = "disabled";
>>> +			};
>>
>> I think that the best way of describing a dual-core SCP in devicetree would
>> be either something like:
>>
>> scp: scp@10500000 {
>> 	compatible = "mediatek,mt8195-scp";
>> 	reg = <0 0x10500000 0 0xa0000>, <0 0x105a0000 0 0x20000>,
>> 	      <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
>> 	reg-names = "sram", "sram-c1", "cfg", "l1tcm";
>> 	interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>,
>> 		     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
>> 	status = "disabled";
>> };
>>
>> ...but that may pose an issue when trying to assign different (or more instances
>> of the same) subnode(s) to each core... for which, I'd be more for something like:
>>
>> scp: scp@10500000 {
>> 	compatible = "mediatek,mt8195-scp";
>> 	reg = <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
>> 	reg-names = "cfg", "l1tcm";
>> 	#address-cells = <1>;
>> 	#size-cells = <1>;
>> 	ranges = <0 0 0x10500000 0x100000>;
>> 	status = "disabled";
>>
>> 	scp_c0: scp-core@0 {
>> 		compatible = "mediatek,mt8195-scp-core";
>> 		reg = <0x0 0xa0000>;
>> 		reg-names = "sram";
>> 		interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
>> 	};
>>
>> 	scp_c1: scp-core@a0000 {
>> 		compatible = "mediatek,mt8195-scp-core";
>> 		reg = <0xa0000 0x20000>;
>> 		reg-names = "sram";
>> 		interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
>> 	};
>> };
>>
>> Regards,
>> Angelo
>>
>>
> Hi Angelo,
> 
> I'm thinking about identifying the cores by the order of the sub nodes,
> i.e. core 0 must be the first sub node and core 1 must be the second sub node,
> because the scp cores in the example have the same compatible name.
> 
> I'm hesitant to make the sub nodes appear in a certain order. Is it appropriate?
> Or, would it be more readable to create a new core id property? Or utilizing
> different compatble strings for cores? I would appreciat it if you could share your opinion.
> 
> 

Assuming that in a future >2 cores architecture only the first core, which I will
call "core 0" for commodity, will have "special treatment" and core 1, 2, 3...N
will always be "interchangeable", I think that something like `mediatek,scp-leader`
would work to identify the first core.

Cheers!
Angelo
