Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587C69F110
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjBVJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjBVJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:13:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D851B56B;
        Wed, 22 Feb 2023 01:13:49 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9623A66021CF;
        Wed, 22 Feb 2023 09:13:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677057228;
        bh=EQcPbGfJMfRIei4Am5Ga2lgUV4SqL9FM6hrNSYWP81M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ci/5xPZofV2WGWkOXFeQ2oVFhVnJmStDnJ+1lB2glB7h3NKKb0bfohtHXtJKXc2yX
         JWVnuiF69Z+OHcCJRhnNa2ACiMYCzBSOy8zvnn6pooaRWfMSZnpSOazVeZdqClc+0G
         y25SprcuQ75Uh659VUCmWtbl16GzOd1vQwSZ126q0a97ymt/Bno/rmABd5HTPjHFej
         tiNgim+asQkJ4eXmwVfXy9ow8OgyZX/OAWJw2eQd1I8sHZf5MJcjSXa4wxJT8r7mqb
         PXbcpQlG+VbDWbC6B4pSwrVwbVGuk1hsDT0ukfvwzMBfUkrryQJxDBqZx/qx7uR7HC
         Bzqd0ggFXVjHg==
Message-ID: <88a3fa09-60cb-bb3c-c392-286efd983627@collabora.com>
Date:   Wed, 22 Feb 2023 10:13:45 +0100
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Ed-5Nq0zNzCGzez3fnW2yxW7zFx9B6k58Y4yb8P+hvpw@mail.gmail.com>
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

Il 22/02/23 09:37, Chen-Yu Tsai ha scritto:
> On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Get GPU support on MT8186 by adding its compatible.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>> index be18b161959b..43a841d4e94d 100644
>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>> @@ -15,6 +15,11 @@ properties:
>>
>>     compatible:
>>       oneOf:
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt8186-mali
>> +          - const: mediatek,mt8183b-mali
>> +          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> 
> The MT8186 has Mali-G52 MC2 2EE, while the MT8183 has Mali-G72 MP3.

Keeping in mind the obvious - which is that G52 and G72 are both Bifrost....

> So we actually need a new entry with two power domains.
> 

...This is my node for MT8186:

		gpu: gpu@13040000 {
			compatible = "mediatek,mt8186-mali",
				     "mediatek,mt8183b-mali",
				     "arm,mali-bifrost";
			reg = <0 0x13040000 0 0x4000>;

			clocks = <&mfgsys CLK_MFG_BG3D>;
			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>,
				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
			interrupt-names = "job", "mmu", "gpu";
			power-domains = <&spm MT8186_POWER_DOMAIN_MFG1>,
					<&spm MT8186_POWER_DOMAIN_MFG2>,
					<&spm MT8186_POWER_DOMAIN_MFG3>;
			power-domain-names = "core0", "core1", "core2";

			/* Please ignore speedbin, that's for another time :-) */
			nvmem-cells = <&gpu_volt_bin>;
			nvmem-cell-names = "speed-bin";
			#cooling-cells = <2>;
		};

There are three MFG power domains... MFG2 and MFG3 are parents of MFG1, on that
I agree, but we can avoid adding a new entry just for MT8186 and use the MT8183-b
one while still being technically correct.

Besides, Mali G52 and Mali G72 are both Bifrost... so I don't think that this
commit is incorrect. For the sake of simplicity, I would push on getting this
one picked.

Unless there are any real-strong opinions against...

Regards,
Angelo

> Our downstream Mali driver & DT use just that.
> 
> ChenYu


