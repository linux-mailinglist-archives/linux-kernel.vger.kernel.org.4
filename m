Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B855764F25E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiLPU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiLPU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:27:42 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D893EAC6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:27:39 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NYgdP2Fkwz1S5Cn
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:27:37 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :content-language:references:to:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671222456; x=1672086457; bh=IpJmud+
        XEx9PKkU79dSSMg1CiFu7r9OxFpEYtS1E59w=; b=Ss0S5+ylltwEkcNqxY2Cfqi
        6J0812qCLEG90MJ/5Q3Bm5u/BFPyFSGWVVDR+92Mj9o0lf/Hkjpvp0vYp9uPIoWW
        xwY4BKkjIHUM6Tc9bHL6RZ3IQRs5o1iwMG9gSxsFBPIysleYVbsS4ROnNLpxsexV
        mEgD9p3RGAmgfjYM8qpVE4v251JdtxRGCAqSLUzhbDWTy/zYi7vb1/5alK8s7PM/
        Eof75PcH+zaSKqra0RGo8E523fI6ThaaBqNA/4shHXJHnmMa8GvewaY+XP89a1ut
        g5RctfmztiyBvw+n0GlqbGpUeI/R1Srs9u8LpkyeWXpWp4Z66UFLd+yJPeML5hQ=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vP55OA_FqP1E for <linux-kernel@vger.kernel.org>;
        Fri, 16 Dec 2022 15:27:36 -0500 (EST)
Received: from [192.168.1.96] (unknown [186.105.44.155])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NYgd50Bw7z1S52q;
        Fri, 16 Dec 2022 15:27:20 -0500 (EST)
Message-ID: <d0157452-307b-37a5-890a-b479a880ab95@mint.lgbt>
Date:   Fri, 16 Dec 2022 17:27:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-4-they@mint.lgbt>
 <afcb9378-f331-df8c-ced5-1c10999f5fb8@linaro.org>
Content-Language: en-US
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <afcb9378-f331-df8c-ced5-1c10999f5fb8@linaro.org>
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


On 16/12/2022 08:32, Konrad Dybcio wrote:
>
> On 15.12.2022 20:04, Lux Aliaga wrote:
>> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
>> summary on what's working.
>>
>> - dmesg output to bootloader preconfigured display
>> - USB
>> - UFS
>> - SMD RPM regulators
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>   .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 254 ++++++++++++++++++
>>   2 files changed, 255 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 3e79496292e7..2b2a0170db14 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>> new file mode 100644
>> index 000000000000..86e1ec47bf5e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>> @@ -0,0 +1,254 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/input/gpio-keys.h>
>> +#include "sm6125.dtsi"
>> +
>> +/ {
>> +	model = "Xiaomi Mi A3";
>> +	compatible = "xiaomi,laurel-sprout", "qcom,sm6125";
>> +	chassis-type = "handset";
>> +
>> +	/* required for bootloader to select correct board */
>> +	qcom,msm-id = <394 0>; /* sm6125 v0 */
> Unless you have a prototype device, this is not correct.
>
> Please run `cat /sys/bus/soc/devices/soc0/revision` and confirm
> which revision is used on your phone.
This segment has already been cross-referenced from downstream, and the 
device boots up successfully when using this ID, unless you're referring 
to the comment next to it, in which case I can recheck later, since 
currently I'm away from my device.

-- 
Lux Aliaga
https://nixgoat.me/

