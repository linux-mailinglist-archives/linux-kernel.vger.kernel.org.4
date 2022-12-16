Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119FE64E9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLPKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLPKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:46:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E01A7;
        Fri, 16 Dec 2022 02:46:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w15so2054001wrl.9;
        Fri, 16 Dec 2022 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sO4cl5xjhBVd3+iJHoMx+vhvACtxqzk7PC5Y+IYSlGo=;
        b=U+wbUqs6y5Ha3t9PLfeWlC2Tn5Exdl4K5spuYibUc5x4Tako5sn+lV2bE7eNBDrXHY
         TphwwB5MfnzepvG/hWZZBVC2+59pd3VSdorV4S1rQRJpujtVaPon1fkyvAv35JO63SpW
         DMAvbbLO8MAPK05sKTQWD/lsr6eZ1zmwpB0dM0PlrTWBFwMoso37SLjeIlIGak0TFaMq
         Idfn+zrcnNvR7XcyxkzF1B65JRBzk+MjX6RVkutgYUJ8l1mDq5K6ze7/FVgvuow77c0q
         7NioshZexPrE9jJ/SWXfGZFbNm65oL75dnovVmi1hDXz/AMqAdPaF3HezRiydofhTUcx
         nJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sO4cl5xjhBVd3+iJHoMx+vhvACtxqzk7PC5Y+IYSlGo=;
        b=43W0/Q68SrbIgUOKt9UmTPqmsa/bCgHgxRrSHgdWbot/Mt6OiPDV4YnEk4heLS8Jcv
         1eaIS8LfzQkMOEsP3K0ECby1Nole1rxbHgRPLNjaw8yIJYhD8MD7CfXV6If7IB6hfBPf
         nrLhuhQLWYTvrxFjz4H+7bbmmz2D2uqd3AGCyPRTXuvlh6x0lB6e239Mn/qIPzIFVG9o
         FwPUHMZGLvKeQgdBWzPcaTFHVlwvopKSnQmq/dJ3tVkrR+ewzHSEvXnH6+8A1jJau22q
         ewYs1cxEUjIxFccIHlLFIVFxbKmbmrHpOpAiffnj8HwXyk5U07fuNh5ZcGOJN8yIpwOF
         GqQw==
X-Gm-Message-State: ANoB5pkGMVK/QsEgdMUE7y9kYVfXtBdNELBSNfKyAyM0plq5fr2UUsMX
        ZIjwL0QyjmE7/xiGrknrEVY=
X-Google-Smtp-Source: AA0mqf4HOHiYTqq0kp7OdkUCzJ8BQs4DBeNan81nRQTiiI1Wk2/CM9cRgA6TnfWggcAf6dckKY2Xsg==
X-Received: by 2002:adf:a44f:0:b0:242:63e5:2449 with SMTP id e15-20020adfa44f000000b0024263e52449mr22819655wra.69.1671187575593;
        Fri, 16 Dec 2022 02:46:15 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r4-20020adfa144000000b002367ad808a9sm1974295wrr.30.2022.12.16.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:46:14 -0800 (PST)
Message-ID: <ebc435fd-0acb-6588-8acd-c8d504ad4289@gmail.com>
Date:   Fri, 16 Dec 2022 11:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 01/10] arm64: dts: mt8183: Fix Mali GPU clock
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        chun-jie.chen@mediatek.com, jose.exposito89@gmail.com,
        drinkcat@chromium.org, weiyi.lu@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
 <20220927101128.44758-2-angelogioacchino.delregno@collabora.com>
 <20221206183037.3jnssar4yxcx5hpb@notapiano>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221206183037.3jnssar4yxcx5hpb@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2022 19:30, Nícolas F. R. A. Prado wrote:
> On Tue, Sep 27, 2022 at 12:11:19PM +0200, AngeloGioacchino Del Regno wrote:
>> From: Chen-Yu Tsai <wenst@chromium.org>
>>
>> The actual clock feeding into the Mali GPU on the MT8183 is from the
>> clock gate in the MFGCFG block, not CLK_TOP_MFGPLL_CK from the TOPCKGEN
>> block, which itself is simply a pass-through placeholder for the MFGPLL
>> in the APMIXEDSYS block.
>>
>> Fix the hardware description with the correct clock reference.
>>
>> Fixes: a8168cebf1bc ("arm64: dts: mt8183: Add node for the Mali GPU")
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Hi,
> 
> it seems that while all other patches on this series were applied by Chen-Yu
> through the clk tree, this commit never made it to the mediatek tree.
> 
> As a result, MT8183-based machines (or at least mt8183-kukui-jacuzzi, where I
> tested on) currently hang during boot not only on next, but also on mainline,
> v6.1-rc8. With this commit applied I've confirmed that the machine boots fine
> again.
> 
> Matthias, could you please apply this commit and make sure it makes its way to
> v6.1? Given the Fixes tag it should eventually make its way there anyway, but if
> still possible would be good to have it fixed right from v6.1.
> 
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Applied now.

Sorry for the late reply.
Matthias

> 
> Thanks,
> Nícolas
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index a70b669c49ba..402136bfd535 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -1678,7 +1678,7 @@ gpu: gpu@13040000 {
>>   				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
>>   			interrupt-names = "job", "mmu", "gpu";
>>   
>> -			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
>> +			clocks = <&mfgcfg CLK_MFG_BG3D>;
>>   
>>   			power-domains =
>>   				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
>> -- 
>> 2.37.2
>>
>>
>>
