Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81B620BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiKHJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiKHJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:06:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423281D665;
        Tue,  8 Nov 2022 01:06:50 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A4366602339;
        Tue,  8 Nov 2022 09:06:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667898408;
        bh=ueI+2JlJ8usQR2qw2C5uUQ8cXmpDFvzCuDuDhHJLK6k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cdl0yXa75sc5uC9OZZNK8dJnq9kBEwkNsoj/Xag2CA0BWHRCUKt4WkSQMHUQ845GQ
         saCu/BmwHKUDjX7dn4NleewUVVhHWtTsR8WSm5WXIfxx2xOUoxwp70wTprD5nYUmo5
         5BJ0TWZqFPHIn4b3mG5h7SGb4ECS+0OMpVq+TJ1cLXqEdgshDQgaYE2P5ALSeD4xP5
         zTaVLgDl2apypZen3F4dFpFNCUUGqR8WlZeAO95Iv3UDSAUsP0xnf/SuKzkYV6SACG
         sHlvSzh5tLzdSkKXc6tSR6WEabp5Rkoh+6NZf6Qa82pTabMR+oE+Zz59tLNSjjBH4N
         8aZJaOk6t1UcA==
Message-ID: <b99a3071-0982-a1bd-f3b9-14e2a8fdd904@collabora.com>
Date:   Tue, 8 Nov 2022 10:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 8/9] arm64: dts: qcom: Add DTS for MSM8976 and MSM8956
 SoCs
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-9-angelogioacchino.delregno@collabora.com>
 <20221108045508.hnnwt22m6ceg5u4y@builder.lan>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221108045508.hnnwt22m6ceg5u4y@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/11/22 05:55, Bjorn Andersson ha scritto:
> On Fri, Nov 04, 2022 at 06:21:21PM +0100, AngeloGioacchino Del Regno wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> This commit adds device trees for MSM8956 and MSM8976 SoCs.
>> They are *almost* identical, with minor differences, such as
>> MSM8956 having two A72 cores less.
>>
>> However, there is a bug in Sony Loire bootloader that requires presence
>> of all 8 cores in the cpu{} node, so these will not be deleted.
>>
>> Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hello,

Thanks to everyone for the feedback!
I'll send a new version this Friday, according to the received reviews.

In the meanwhile, a few answers will follow, check below.

>> ---
>>   arch/arm64/boot/dts/qcom/msm8956.dtsi |   18 +
>>   arch/arm64/boot/dts/qcom/msm8976.dtsi | 1208 +++++++++++++++++++++++++
>>   2 files changed, 1226 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/msm8956.dtsi
>>   create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
>>

..snip..

>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&CPU0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU3>;
>> +				};
>> +			};
>> +
>> +			cluster1 {
> 
> Are you sure that the two clusters should be expressed separately in the
> cpu-map?
> 

This SoC has two clusters with split L2 cache, can shutdown one cluster CPU, or
the L2 cache for one cluster, or one entire cluster, hence can also manage idle
states on a per-cluster basis.

Also, as per bindings/cpu/cpu-topology.txt - I am here describing the hierarchy
of CPUs in MSM8976, containing one "little" cluster, composed of four slower CPU
cores and its own L2 cache slice, and one "big" cluster, composed of four (8976)
or two (8956) faster CPU cores and its own L2 cache slice.

That said, I am sure that the two clusters shall be expressed separately.

Am I underestimating and/or ignoring anything?

>> +				core0 {
>> +					cpu = <&CPU4>;
>> +				};
>> +

..snip..

>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		cont_splash_mem: memory@83000000 {
> 
> memory is "reserved", please use specific node names for these regions.
> 

Agreed.

>> +			reg = <0x0 0x83000000 0x0 0x2800000>;
>> +		};
> [..]
>> +		apcs: syscon@b011000 {
>> +			compatible = "syscon";
> 
> Why not use qcom,msm8976-apcs-kpss-global here?
> 

There's no reason not to use the suggested compatible. I'm sorry for the miss.

>> +			reg = <0x0b011000 0x1000>;
>> +		};
> [..]
>> +
>> +		imem: imem@8600000 {
>> +			compatible = "simple-mfd";
> 
> sram/qcom,imem.yaml please.
> 

Will do on v2.

Regards,
Angelo
