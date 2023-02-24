Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4906A1CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBXNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBXNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:05:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78FF959;
        Fri, 24 Feb 2023 05:05:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8EE386602FB6;
        Fri, 24 Feb 2023 13:05:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677243928;
        bh=aVfAm+nqbHeECjn7WiittCHTPKqgPS/pUH3qciDBBc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c9nU2MjQbPZi2nc6yF9Aamrh8ompl8InKd/kvjIlJKM0IpQoh8tF1GSEr3IBRATpb
         SasUgJJS4JsSuFGRl5Fx5jALhtvW5H5ODPQZydwYyU7MiwTtb0Qwnfwb1wYwsJP8WD
         kHnR8EmFK1htn974GrQMziuFYrkMzrabEx4Nb4wvSqqz6BStoeoVDqEXF33GilUL/G
         MUY7+08FDC1dbUQL7FL8eXAMPOSWbRW6u5k0wp2QLJ2DYV1eS+mHf8C+Bi8bN2CdAJ
         E/up31yxCNi2dAZSEK73kS+xxicGSCoxlGWDHXcXq1SixncMx5sJU3B7rGJU0i1bO0
         vLHpeXrwv/tdA==
Message-ID: <7a4653f6-c074-1bd7-718a-7754f56c5105@collabora.com>
Date:   Fri, 24 Feb 2023 14:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 11/16] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
 <20230223134345.82625-12-angelogioacchino.delregno@collabora.com>
 <CAGXv+5ER-Z9WiRAKEbfKV3hzNQu0Xru-z5QUJA85wzrwzY7hcw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5ER-Z9WiRAKEbfKV3hzNQu0Xru-z5QUJA85wzrwzY7hcw@mail.gmail.com>
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

Il 24/02/23 10:58, Chen-Yu Tsai ha scritto:
> On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add coupling for these regulators, as VSRAM_OTHER is used to power the
>> GPU SRAM, and they have a strict voltage output relation to satisfy in
>> order to ensure GPU stable operation.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> index df477eb89f21..c8b6e1a9605b 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>>          regulator-always-on;
>>   };
>>
>> +&mt6359_vsram_others_ldo_reg {
>> +       regulator-min-microvolt = <750000>;
>> +       regulator-max-microvolt = <850000>;
>> +       regulator-coupled-with = <&mt6315_7_vbuck1>;
>> +       regulator-coupled-max-spread = <10000>;
>> +};
>> +
>>   &mt6359_vufs_ldo_reg {
>>          regulator-always-on;
>>   };
>> @@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
>>                                  regulator-max-microvolt = <1193750>;
>>                                  regulator-enable-ramp-delay = <256>;
>>                                  regulator-allowed-modes = <0 1 2>;
>> +                               regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
>> +                               regulator-coupled-max-spread = <10000>;
> 
> Also fix the constraints here? And overriding the constraints should be
> mentioned in the commit log.
> 

There's no constraint to fix, though. The current ones are just fine.

I'll mention the constraints override for vsram_others in v3!

Regards,
Angelo

>>                          };
>>                  };
>>          };
>> --
>> 2.39.2
>>


