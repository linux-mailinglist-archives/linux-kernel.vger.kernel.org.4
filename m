Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332A86A1CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBXNES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjBXNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:04:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF911E92;
        Fri, 24 Feb 2023 05:04:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE0D66602FB6;
        Fri, 24 Feb 2023 13:04:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677243847;
        bh=j9jFm1nHK/oKgT7WlUa0gWzVpaq6L9A6Ups6fsKZ0a8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Im5jkG954u6hEdUskb5DGFgP9MtFjiSXh2kZkiP4Kee9WB656xCqUre8yMvX76j2b
         x3mOx/W9NYtBvD2dyQUuE3JN+hZfY72ZByIJ/x+9+a0XjjhySPLUlOnctkNfiIHcJ+
         ifPBn4EbHY2w6H1u+rAD2V9iHxQfRnNMLwrLE4PQ+ZSWgK6zKqambcRqAX/71BjlAv
         0tWzZTYr84oKtfu91GjamAurUX3FRT7J5s2uxNnbh1ouu6sybCst5o5GjKYhNqY24m
         +f7/bq9WVbNARTxMAhAak8UcuEPZW9Fp3LIHL199da5Kb7rKcsABs0sSR8NO6BM1mF
         iegyDmPKBJYWQ==
Message-ID: <b195aa1d-c88e-5a20-de64-e4de9406a656@collabora.com>
Date:   Fri, 24 Feb 2023 14:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 07/16] arm64: dts: mediatek: mt8192: Add GPU nodes
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
 <20230223134345.82625-8-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H4a686nZPWjd7yFXSDCjttg0OPz1VD_8ppGASKgTWc7g@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H4a686nZPWjd7yFXSDCjttg0OPz1VD_8ppGASKgTWc7g@mail.gmail.com>
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

Il 24/02/23 10:55, Chen-Yu Tsai ha scritto:
> On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>>
>> The MediaTek MT8192 includes a Mali-G57 GPU supported in Panfrost. Add
>> the GPU node to the device tree to enable 3D acceleration.
>>
>> The GPU node is disabled by default. It should be enabled by board with
>> its power supplies correctly assigned.
>>
>> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>> [nfraprado: removed sram supply, tweaked opp node name, adjusted commit message]
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> [wenst@: disable GPU by default; adjusted prefix; split out board change]
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 109 +++++++++++++++++++++++
>>   1 file changed, 109 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> index 87b91c8feaf9..2a3606f68ae4 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> @@ -312,6 +312,91 @@ timer: timer {
>>                  clock-frequency = <13000000>;
>>          };
>>
>> +       gpu_opp_table: opp-table-0 {
>> +               compatible = "operating-points-v2";
>> +               opp-shared;
>> +
>> +               opp-358000000 {
>> +                       opp-hz = /bits/ 64 <358000000>;
>> +                       opp-microvolt = <606250>;
>> +               };
>> +
>> +               opp-399000000 {
>> +                       opp-hz = /bits/ 64 <399000000>;
>> +                       opp-microvolt = <618750>;
>> +               };
>> +
>> +               opp-440000000 {
>> +                       opp-hz = /bits/ 64 <440000000>;
>> +                       opp-microvolt = <631250>;
>> +               };
>> +
>> +               opp-482000000 {
>> +                       opp-hz = /bits/ 64 <482000000>;
>> +                       opp-microvolt = <643750>;
>> +               };
>> +
>> +               opp-523000000 {
>> +                       opp-hz = /bits/ 64 <523000000>;
>> +                       opp-microvolt = <656250>;
>> +               };
>> +
>> +               opp-564000000 {
>> +                       opp-hz = /bits/ 64 <564000000>;
>> +                       opp-microvolt = <668750>;
>> +               };
>> +
>> +               opp-605000000 {
>> +                       opp-hz = /bits/ 64 <605000000>;
>> +                       opp-microvolt = <681250>;
>> +               };
>> +
>> +               opp-647000000 {
>> +                       opp-hz = /bits/ 64 <647000000>;
>> +                       opp-microvolt = <693750>;
>> +               };
>> +
>> +               opp-688000000 {
>> +                       opp-hz = /bits/ 64 <688000000>;
>> +                       opp-microvolt = <706250>;
>> +               };
>> +
>> +               opp-724000000 {
>> +                       opp-hz = /bits/ 64 <724000000>;
>> +                       opp-microvolt = <725000>;
>> +               };
>> +
>> +               opp-748000000 {
>> +                       opp-hz = /bits/ 64 <748000000>;
>> +                       opp-microvolt = <737500>;
>> +               };
>> +
>> +               opp-772000000 {
>> +                       opp-hz = /bits/ 64 <772000000>;
>> +                       opp-microvolt = <750000>;
>> +               };
>> +
>> +               opp-795000000 {
>> +                       opp-hz = /bits/ 64 <795000000>;
>> +                       opp-microvolt = <762500>;
>> +               };
>> +
>> +               opp-819000000 {
>> +                       opp-hz = /bits/ 64 <819000000>;
>> +                       opp-microvolt = <775000>;
>> +               };
>> +
>> +               opp-843000000 {
>> +                       opp-hz = /bits/ 64 <843000000>;
>> +                       opp-microvolt = <787500>;
>> +               };
>> +
>> +               opp-866000000 {
>> +                       opp-hz = /bits/ 64 <866000000>;
>> +                       opp-microvolt = <800000>;
>> +               };
>> +       };
>> +
>>          soc {
>>                  #address-cells = <2>;
>>                  #size-cells = <2>;
>> @@ -1266,6 +1351,30 @@ mmc1: mmc@11f70000 {
>>                          status = "disabled";
>>                  };
>>
>> +               gpu: gpu@13000000 {
>> +                       compatible = "mediatek,mt8192-mali", "arm,mali-valhall-jm";
>> +                       reg = <0 0x13000000 0 0x4000>;
>> +                       interrupts =
>> +                               <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                               <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                               <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>;
> 
> Nit: Move the first entry to the same line as the property, and align
> the following lines' angle brackets?
>  > Same for the power-domains.
> 

Makes sense, yes, I should've paid more attention to that.

Regards,
Angelo

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
>> +                       interrupt-names = "job", "mmu", "gpu";
>> +
>> +                       clocks = <&apmixedsys CLK_APMIXED_MFGPLL>;
>> +
>> +                       power-domains =
>> +                               <&spm MT8192_POWER_DOMAIN_MFG2>,
>> +                               <&spm MT8192_POWER_DOMAIN_MFG3>,
>> +                               <&spm MT8192_POWER_DOMAIN_MFG4>,
>> +                               <&spm MT8192_POWER_DOMAIN_MFG5>,
>> +                               <&spm MT8192_POWER_DOMAIN_MFG6>;
>> +                       power-domain-names = "core0", "core1", "core2", "core3", "core4";
>> +
>> +                       operating-points-v2 = <&gpu_opp_table>;
>> +
>> +                       status = "disabled";
>> +               };
>> +
>>                  mfgcfg: clock-controller@13fbf000 {
>>                          compatible = "mediatek,mt8192-mfgcfg";
>>                          reg = <0 0x13fbf000 0 0x1000>;
>> --
>> 2.39.2
>>

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

