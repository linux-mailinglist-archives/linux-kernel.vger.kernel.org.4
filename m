Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242B5FE9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJNHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJNHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:35:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106558C006;
        Fri, 14 Oct 2022 00:35:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84E7B6602331;
        Fri, 14 Oct 2022 08:35:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665732932;
        bh=tSXD9lC4lmzBzTd508v0re7W/dlGI2rWfX0PdDrA9IQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UpiHRazV8w0iYoVneXWhaonVxxKK5QquHlp8rFS1PKQ8p2sejYC1S4/cs6DzyWXqg
         LEL4nbzGj5mhRzN9snpvfZqOpDUNOv2hCLJK98MeqNj8EZJMHDechSiVKHlrj+5A7i
         3J2D7gwfrSs6MwtQKsvHz4LXuV+f6KYrpDPhbBUnovqsQHkaAB0pX4HhE63w24xqes
         AGqM37qQuoifrrTq5JcSvbxH1WEnTuawBtr9Yy29yZ43KloJ8bt0Pb8Wq1ySf5AYvm
         6hFqfYI58WYMZeAW6s1kqZm9VPoHjevaBY9rO0r2KTiJd4j8L/X5zygqwHNVRpyi59
         ITmXcLAcHX23g==
Message-ID: <96ab6836-4650-ee53-a0c9-54b8328b8667@collabora.com>
Date:   Fri, 14 Oct 2022 09:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 6/8] arm64: dts: mt2712-evb: Fix usb vbus regulators unit
 names
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sam.shih@mediatek.com, hanks.chen@mediatek.com,
        weiyi.lu@mediatek.com, zhiyong.tao@mediatek.com,
        andrew-sh.cheng@mediatek.com, viresh.kumar@linaro.org,
        fparent@baylibre.com, mars.cheng@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
 <20221013152212.416661-7-angelogioacchino.delregno@collabora.com>
 <3b7fc7414f282ca044c24dae280f9bc9533a5b7b.camel@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <3b7fc7414f282ca044c24dae280f9bc9533a5b7b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/10/22 04:43, Chunfeng Yun ha scritto:
> On Thu, 2022-10-13 at 17:22 +0200, AngeloGioacchino Del Regno wrote:
>> Update the names to regulator-usb-p{0-3}-vbus to fix
>> unit_address_vs_reg
>> warnings for those.
>>
>> Fixes: 1724f4cc5133 ("arm64: dts: Add USB3 related nodes for MT2712")
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> index 638908773706..d31a194124c9 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> @@ -50,7 +50,7 @@ extcon_usb1: extcon_iddig1 {
>>   		id-gpio = <&pio 14 GPIO_ACTIVE_HIGH>;
>>   	};
>>   
>> -	usb_p0_vbus: regulator@2 {
>> +	usb_p0_vbus: regulator-usb-p0-vbus {
> Can we modify dt-binding of fixed regulator instead of changing the
> node name,
> since all nodes using fixed regulator may need be changed.
> 

These regulators have no MMIO, nor need any index, so it would be simply
wrong to change the binding and leave them as they are here in the devicetree.

Regards,
Angelo
