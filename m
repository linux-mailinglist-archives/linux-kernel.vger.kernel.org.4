Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170E569F0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjBVJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjBVJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:05:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A654E37B62;
        Wed, 22 Feb 2023 01:05:46 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 465A9660215E;
        Wed, 22 Feb 2023 09:05:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677056745;
        bh=zSRq4dEwuKW8nbx0nGY4kiZd4ygu6loLn9qrQqhjK1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q8n9TNEao1QzWy8XNYJDyqpjHmpQg15INEmMs5cEbR3Ort6Ee4puYfk4YrBgvCdRg
         OosK5dSlV0u+jNe3fahwPV7jgG/FhCE8+vEG4upzXy3BH0yMQC6CNNEQLoOhLq3Kc3
         eLFknQG5p5rF9M0jqHpNEelhMa9ViQqcEIq7N08gL9+R+oOs/e1jbiT4wSF1pGinIA
         qQYho581r95EBWh4UwPT/v/HXq398g6i5CQ0tqmTnwZjml+LFqB6wUWwIv9FIVWdPZ
         6uBIcZxttpPdYdcDu1/U2zdoOTV/EUDAC5An+j86XJV32rMGQl2BtIk9gHQ6HpO/ba
         zDmnj9tZTfOxQ==
Message-ID: <5274b05e-194f-131c-bedd-6b879a8ff946@collabora.com>
Date:   Wed, 22 Feb 2023 10:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 49/54] clk: mediatek: Add MODULE_DEVICE_TABLE() where
 appropriate
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     chen.zhong@mediatek.com, chun-jie.chen@mediatek.com,
        daniel@makrotopia.org, edward-jw.yang@mediatek.com,
        fparent@baylibre.com, granquet@baylibre.com,
        johnson.wang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        msp@baylibre.com, mturquette@baylibre.com, nfraprado@collabora.com,
        pablo.sun@mediatek.com, rex-bc.chen@mediatek.com,
        sam.shih@mediatek.com, sboyd@kernel.org, sean.wang@mediatek.com,
        wenst@chromium.org, yangyingliang@huawei.com, zhaojh329@gmail.com
References: <20230221115549.360132-50-angelogioacchino.delregno@collabora.com>
 <20230222041422.4429-1-miles.chen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230222041422.4429-1-miles.chen@mediatek.com>
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

Il 22/02/23 05:14, Miles Chen ha scritto:
> Hi,
> 
>> static struct platform_driver clk_mt8195_venc_drv = {
>> 	.probe = mtk_clk_simple_probe,
>> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
>> index 84805a114387..3d1ad92b663e 100644
>> --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
>> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
>> @@ -95,6 +95,7 @@ static const struct platform_device_id clk_mt8195_vpp0_id_table[] = {
>> 	{ .name = "clk-mt8195-vpp0", .driver_data = (kernel_ulong_t)&vpp0_desc },
>> 	{ /* sentinel */ }
>> };
>> +MODULE_DEVICE_TABLE(platform, of_match_clk_mt8195_vpp0);
>>
>> static struct platform_driver clk_mt8195_vpp0_drv = {
>> 	.probe = mtk_clk_pdev_probe,
>> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
>> index 3e91dfed2996..b463f8e197c6 100644
>> --- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
>> +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
>> @@ -93,6 +93,7 @@ static const struct platform_device_id clk_mt8195_vpp1_id_table[] = {
>> 	{ .name = "clk-mt8195-vpp1", .driver_data = (kernel_ulong_t)&vpp1_desc },
>> 	{ /* sentinel */ }
>> };
>> +MODULE_DEVICE_TABLE(platform, of_match_clk_mt8195_vpp1);
> 
> I got the following build break with ARCH=arm64 allmodconfig:
> Do I miss something?
> 
> linux-next/drivers/clk/mediatek/clk-mt8195-vpp0.c:98:31: error: 'of_match_clk_mt8195_vpp0' undeclared here (not in a function)
> linux-next/drivers/clk/mediatek/clk-mt8195-vpp1.c:96:31: error: 'of_match_clk_mt8195_vpp1' undeclared here (not in a function)
> 
> ARCH=arm64 allyesconfig, defconfig: passed
> 
> thanks,
> Miles

Sorry, this one was meant to be `clk_mt8195_vpp1_id_table` instead of
`of_match_clk_mt8195_vpp1`.... something went wrong with the rebase.

I'll fix that asap.

Thanks,
Angelo
