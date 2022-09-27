Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A475EBF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiI0KRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI0KRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:17:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43E1145;
        Tue, 27 Sep 2022 03:17:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24306660205F;
        Tue, 27 Sep 2022 11:17:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664273864;
        bh=7wR4aKFBkGMCvGamAc8HpHgnpBEoOFulzIiiRlcUJk0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ECbaEJmsym739P2zjraRuvwhHYHrEbx0C87wEcCgFWlUXFFFTf06BTHk0EuEd+3YR
         sXMNhuXS0mKiSAemPTxBlWuXHfqNtzT7bXGXouAk8nXazsleff4pEhtjRNxuE7ZDEq
         UILb/v7ZIBRNKvZsS8SHbU2eWOvU1gtMt76fHekd2WzOPv2hz4NeT+AqxGSdnrI11+
         7vX8LDqKgqMoALFIYTh9oB/vIUHy4qd2WfPbSLm2nqSB+bxP+gtTd6ArVA5HiEKd4b
         aiSz6iUoaEYRw95pCYDBbFUWJjwIDOeI5IS0qRHRjDRU/45WmqGlh2FS0nrbDdmner
         bGmBrp0yEBtsg==
Message-ID: <05ed341b-2db3-620f-7a70-dcebfaa66f1a@collabora.com>
Date:   Tue, 27 Sep 2022 12:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
To:     =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220926105047.19419-1-allen-kh.cheng@mediatek.com>
 <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
 <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/22 04:19, Allen-KH Cheng (程冠勳) ha scritto:
> Hi Angelo,
> 
> On Mon, 2022-09-26 at 17:29 +0200, AngeloGioacchino Del Regno wrote:
>> Il 26/09/22 12:50, Allen-KH Cheng ha scritto:
>>> Add vcodec lat and core nodes for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Change in v1:
>>>     * Replace node names with video-codec
>>>       [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
>>> ---
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60
>>> ++++++++++++++++++++++++
>>>    1 file changed, 60 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 6b20376191a7..214dfc6b0ed1 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -1449,6 +1449,66 @@
>>>    			power-domains = <&spm
>>> MT8192_POWER_DOMAIN_ISP2>;
>>>    		};
>>>    
>>> +		vcodec_dec: video-codec@16000000 {
>>> +			compatible = "mediatek,mt8192-vcodec-dec";
>>> +			reg = <0 0x16000000 0 0x1000>;
>>> +			mediatek,scp = <&scp>;
>>> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
>>> +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0
>>> 0xfff00000>;
>>> +			#address-cells = <2>;
>>> +			#size-cells = <2>;
>>> +			ranges = <0 0 0 0x16000000 0 0x26000>;
>>> +
>>> +			vcodec_lat: video-codec@10000 {
>>
>> Allen, this won't work :-(
>> Check Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-
>> decoder.yaml
>> ...the schema requires vcodec-lat@[0-9a-f] and vcodec-core@[0-9a-f].
>>
>> If you want to call them all video-codec@addr, you have to also fix
>> the schema.
>>
>> P.S.: Did you try to run `make dtbs_check`?
>>
>> Regards,
>> Angelo
>>
> 
> Sorry, my bad. I alsways run `make dtbs_check` to confirm dtb with
> bindings. I just think we didn't limit node names in mtk-vodec
> bindings. I will pay attention next time.
> 
> 
> Since currently the vcodec lat and core nodes are absent from the mtk
> dts, do you think the child node name should be changed to something
> more general (ex: video-codec) in mediatek,vcodec-subdev-decoder
> bindings?

The video codec is mt8192-vcodec-dec, while the other nodes are describing
the VPU instances (and/or vpu cores)... I'm not sure.

Krzysztof, please, can you give your opinion on that?

Regards,
Angelo

> 
> Thanks,
> Allen
> 
> 
> 
> 
> 

