Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D028263ECA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiLAJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLAJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:39:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FF4A9EF;
        Thu,  1 Dec 2022 01:39:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CB6A66025DF;
        Thu,  1 Dec 2022 09:39:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669887576;
        bh=Qw3YH+f30BJdWDMM8bR7CWNumBiXsSr+8uajFsp4ofE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dH+vRtlE/cMz7Oxdz/Y6sfn+HbIxfeb6SKNZnmBTDcl9mOJV2gbBj+FLRIRtbTxQO
         T33xsOtsmBIdDS09W57WesVu9a/lQmH6+nqa9Vw8aN/Qy+EBY/hIi470ezDEXqI71G
         VFZNGHHx7klThHCQSnLgzsOsoipNyPJCV66gHOKCbN0TTV1X74oAPf83QJDmaHfQkO
         mLxXaxUwZyj2ieMDmq5dLnMfYhYZBc0R2PuGMM6R9oSy1FRv++eZw0JIzqf4nNswmI
         c+GLM81oLtuzxY668FrzLyqPDNNbTpXx2brS09qPrUp3zX2pztZUB5SoIqMfh3/69O
         veC4v5UUA+ZQA==
Message-ID: <8ae2a510-abf6-6e1b-9893-293db7d930e7@collabora.com>
Date:   Thu, 1 Dec 2022 10:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
 <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com>
 <CAGXv+5Gg6ozYQcp_NPrAiH1kF-ZkfjVZhQZVhLnbSmjQBwsFwQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gg6ozYQcp_NPrAiH1kF-ZkfjVZhQZVhLnbSmjQBwsFwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/22 10:10, Chen-Yu Tsai ha scritto:
> On Thu, Dec 1, 2022 at 5:07 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 01/12/22 08:33, Allen-KH Cheng ha scritto:
>>> Add adsp power domain controller node for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>> Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
>>>       [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
>>> ---
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
>>>    include/dt-bindings/power/mt8192-power.h | 1 +
>>>    2 files changed, 9 insertions(+)
>>>
>>
>> Allen, thanks for this one, but it's incomplete...
>>
>> First of all, you must add the power domain on the driver itself, specifically,
>> in drivers/soc/mediatek/mt8192-pm-domains.h - otherwise this change will have no
>> effect!
> 
> Actually it's worse. The driver doesn't know about the new power domain,
> and so it will fail to probe. We might need to make the power domain driver
> fail gracefully and skip unknown power domains.
> 

Right. It's worse. I don't know, though, if gracefully skipping unknown power
domains in the driver would be a good decision... as sometimes error messages
go unnoticed.

When the platform "explodes" instead, you're forced to read that log carefully
and get it working again... Anyway, I'm only thinking out loud, nothing less and
nothing more than that :-)

By the way, we can probably expand on that topic a bit later, as it's outside of
the scope of this specific change.

Back to topic, if we get one series containing both changes (devicetree, bindings
and driver) with the right Fixes tags and/or Cc stable, we shouldn't have such
issue on backports so we can probably ignore that potential issue, I think? :-)

Cheers,
Angelo

> ChenYu
> 
>> ...Then, as Chen-Yu said, you should also add the power domain to the scp_adsp
>> clock node as that's solving the lockup issue...
>>
>> .......and last, but not least: we need a Fixes tag to backport this fix, here
>> and on the commit that adds the missing power domain in the driver.
>>
>> Thanks,
>> Angelo
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 424fc89cc6f7..e71afba871fc 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -514,6 +514,14 @@
>>>                                                };
>>>                                        };
>>>                                };
>>> +
>>> +                             power-domain@MT8192_POWER_DOMAIN_ADSP {
>>> +                                     reg = <MT8192_POWER_DOMAIN_ADSP>;
>>> +                                     clocks = <&topckgen CLK_TOP_ADSP_SEL>;
>>> +                                     clock-names = "adsp";
>>> +                                     mediatek,infracfg = <&infracfg>;
>>> +                                     #power-domain-cells = <0>;
>>> +                             };
>>>                        };
>>>                };
>>>
>>> diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
>>> index 4eaa53d7270a..63e81cd0d06d 100644
>>> --- a/include/dt-bindings/power/mt8192-power.h
>>> +++ b/include/dt-bindings/power/mt8192-power.h
>>> @@ -28,5 +28,6 @@
>>>    #define MT8192_POWER_DOMAIN_CAM_RAWA        18
>>>    #define MT8192_POWER_DOMAIN_CAM_RAWB        19
>>>    #define MT8192_POWER_DOMAIN_CAM_RAWC        20
>>> +#define MT8192_POWER_DOMAIN_ADSP     21
>>>
>>>    #endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
>>>
>>


