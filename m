Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57E6A0A50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjBWNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjBWNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:16:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C92B297;
        Thu, 23 Feb 2023 05:15:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1E136602206;
        Thu, 23 Feb 2023 13:15:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677158149;
        bh=Us76hl3M67F4tYLgk1qrZB7e6/ZLVJuaAxtfQ+sOh5s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G3BhFgpPjGQDWxS0SJIystijE1dRfuglShVLZeqng66gOtNFf/usYwCEfXh+9eCjc
         K8E6jEmeA15GBbYMN9fexcAQa+pFXp6P+Ec4x889/Y9c9jRX3OSixJLXLdXmY7lOtR
         jBzbYMiIigDLLGaGy0GmibUcTJY0tFtCw9agV/sXNSWVS58w2yxv7DAZpCpTfWTC9E
         ufGps3myqqJrEdhvd635IFaVhI2mBT1pTzRIuxoYVrFycvxlVr/Gd8mvj9m3vqGYo4
         Oq53Dhn7u6Z0G9DoC0AEe/Hu3rzsrlu8qk5099ZOYF5LM4hmjqxotVrBP3bPSThPkq
         R5neIsJYFn+Wg==
Message-ID: <68a91707-78e7-7a39-900f-18ade966befc@collabora.com>
Date:   Thu, 23 Feb 2023 14:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 06/10] dt-bindings: gpu: mali-bifrost: Add a compatible
 for MediaTek MT8186
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
 <20230221153740.1620529-7-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Ed-5Nq0zNzCGzez3fnW2yxW7zFx9B6k58Y4yb8P+hvpw@mail.gmail.com>
 <88a3fa09-60cb-bb3c-c392-286efd983627@collabora.com>
 <CAGXv+5H3XMF7ov_WfNFA=HC0frD003MRdVuBOFiBvu8zxE_rwg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H3XMF7ov_WfNFA=HC0frD003MRdVuBOFiBvu8zxE_rwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/02/23 03:43, Chen-Yu Tsai ha scritto:
> On Wed, Feb 22, 2023 at 5:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 22/02/23 09:37, Chen-Yu Tsai ha scritto:
>>> On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Get GPU support on MT8186 by adding its compatible.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>>>> index be18b161959b..43a841d4e94d 100644
>>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>>>> @@ -15,6 +15,11 @@ properties:
>>>>
>>>>      compatible:
>>>>        oneOf:
>>>> +      - items:
>>>> +          - enum:
>>>> +              - mediatek,mt8186-mali
>>>> +          - const: mediatek,mt8183b-mali
>>>> +          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
>>>
>>> The MT8186 has Mali-G52 MC2 2EE, while the MT8183 has Mali-G72 MP3.
>>
>> Keeping in mind the obvious - which is that G52 and G72 are both Bifrost....
>>
>>> So we actually need a new entry with two power domains.
>>>
>>
>> ...This is my node for MT8186:
>>
>>                  gpu: gpu@13040000 {
>>                          compatible = "mediatek,mt8186-mali",
>>                                       "mediatek,mt8183b-mali",
>>                                       "arm,mali-bifrost";
>>                          reg = <0 0x13040000 0 0x4000>;
>>
>>                          clocks = <&mfgsys CLK_MFG_BG3D>;
>>                          interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>,
>>                                       <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
>>                                       <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
>>                          interrupt-names = "job", "mmu", "gpu";
>>                          power-domains = <&spm MT8186_POWER_DOMAIN_MFG1>,
>>                                          <&spm MT8186_POWER_DOMAIN_MFG2>,
>>                                          <&spm MT8186_POWER_DOMAIN_MFG3>;
>>                          power-domain-names = "core0", "core1", "core2";
>>
>>                          /* Please ignore speedbin, that's for another time :-) */
>>                          nvmem-cells = <&gpu_volt_bin>;
>>                          nvmem-cell-names = "speed-bin";
>>                          #cooling-cells = <2>;
>>                  };
>>
>> There are three MFG power domains... MFG2 and MFG3 are parents of MFG1, on that
>> I agree, but we can avoid adding a new entry just for MT8186 and use the MT8183-b
>> one while still being technically correct.
>>
>> Besides, Mali G52 and Mali G72 are both Bifrost... so I don't think that this
>> commit is incorrect. For the sake of simplicity, I would push on getting this
>> one picked.
> 
> I'm aware. In case it wasn't obvious, Mali-G52 MC2 2EE has 2 cores, while
> Mali-G72 MP3 has 3 cores. I think that is reason enough to do a new entry.
> Otherwise you are describing power domains for 3 cores for a GPU that only
> has two.
> 
>> Unless there are any real-strong opinions against...
> 
> Yes.
> 

Ok, I will do that for v3!

Cheers,
Angelo

> ChenYu


