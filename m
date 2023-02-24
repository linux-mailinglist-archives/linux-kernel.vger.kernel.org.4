Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3973F6A1C97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjBXNCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:02:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348E5E843;
        Fri, 24 Feb 2023 05:02:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80A406602FB6;
        Fri, 24 Feb 2023 13:02:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677243746;
        bh=v09nEiPPrKyyZ5dnBNTGSJ/5jA/WVigVy6zfFwa7DEU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gUHDoki01EnQxD1f5QnXwVHKZs8QUfYzYPjD3m/a6F8vOYJ98XrwY1axIFFBz0966
         vy1IgyZK+YkQctwONolbD6b8BEMpXFD2Q3FR7K+VfILJUJ/CTRsJ9iJNig0vcwuFtg
         rM+jUY3OGYKoC3//BAncdrtS8ZR09KBLoT3bOxPvjsMMWz5s1JkqcVaMMmjUTPlBA3
         rCxoRNhekOPa+us26y3IFOTdgjLGtruOgTRpxHyO6qfVnTjxy0wdbbRh/K/iw5ikZv
         9Nwyt9aNWZgA5Do/GYd+jrulhFSn6e/0VcRvVtEvxRrqHoE0H4/vIttwCib3X7AFte
         s+Uiuc/12/rJg==
Message-ID: <fa6c2d63-0341-b5d6-059e-d44b1f2e9d02@collabora.com>
Date:   Fri, 24 Feb 2023 14:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/16] arm64: dts: mediatek: mt8183-kukui: Override
 vgpu/vsram_gpu constraints
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
 <20230223134345.82625-3-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FUzeB1SPDt+Ys8ALA_y5ZAPQGnz43NnLCPorvurF3eYg@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FUzeB1SPDt+Ys8ALA_y5ZAPQGnz43NnLCPorvurF3eYg@mail.gmail.com>
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

Il 24/02/23 10:50, Chen-Yu Tsai ha scritto:
> On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Override the PMIC-default voltage constraints for VGPU and VSRAM_GPU
>> with the platform specific vmin/vmax for the highest possible SoC
>> binning.
> 
> The maximum voltage numbers don't match the existing OPP table though.

The OPP table that we've got in mt8183.dtsi does not declare frequencies for the
highest binning for this SoC, I guess because there was no way to check fuses to
restrict the table to bin XYZ.

These maximum voltages are - true - higher compared to the highest voltage in
the GPU OPP table, but they're still in spec (check datasheets!).

Should I reword the commit description?

Regards,
Angelo

> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> index de9778c85b94..63952c1251df 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> @@ -401,6 +401,9 @@ &mt6358codec {
>>   };
>>
>>   &mt6358_vgpu_reg {
>> +       regulator-min-microvolt = <625000>;
>> +       regulator-max-microvolt = <900000>;
>> +
>>          regulator-coupled-with = <&mt6358_vsram_gpu_reg>;
>>          regulator-coupled-max-spread = <100000>;
>>   };
>> @@ -416,6 +419,9 @@ &mt6358_vsim2_reg {
>>   };
>>
>>   &mt6358_vsram_gpu_reg {
>> +       regulator-min-microvolt = <850000>;
>> +       regulator-max-microvolt = <1000000>;
>> +
>>          regulator-coupled-with = <&mt6358_vgpu_reg>;
>>          regulator-coupled-max-spread = <100000>;
>>   };
>> --
>> 2.39.2
>>

