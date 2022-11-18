Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58D062F8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiKRPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiKRPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:01:43 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A36A7C30
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:58:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j15so8966428wrq.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw23Nf2ywm0G6Jdy8jtkPxH6JRwBmcWd0JpF48UwDnA=;
        b=EfbDeo6h2MKp54ozSgIaeVTNnyv1UmDOJvMSjDWuUlhiM1DGNEcXVI5Py3MrQm/mTB
         EPOgxoTUuHZYEn5QzkIboSMSVIRx//32C3hmhPLM6XxeUI2CpG9kzHoaEg0AyWpHoQSU
         tkZilxvZKh/9BQImtaalXAX5rv1QFRpcaDPk2waLrk0dFvM04sAXXDJMtgT0c/nFgm0J
         4qU4JPPc8eobijy13xR3EZfDU7fjGvniswS3wWOXkY0SmQH5x/yM6Kwe2Hvh6jyb4NHZ
         eZa4DBCbRiuKCexlah52t3UT1w1leBDFv9X/3u0kjRMeke4zPKKzaiyr16cEFZ4GK/dB
         PkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw23Nf2ywm0G6Jdy8jtkPxH6JRwBmcWd0JpF48UwDnA=;
        b=Zp4RpdkB5sjo4xxYjb156AnB+1hudLKSHsyh3zdTfByEtB5bQkLF//2ZPbeMzC+EJn
         l4rlALepdNZI87rsolSukVo3XOa8gntNCSezq9hyGFD4lC/C8zgZmM3UgiI/IOs6SvRb
         2XBlMMARuAyWt/xO8KncXMiBpqcbGxkvxPCCv2NLSxqwfueZISauDCuD66+9yMrDmydw
         Y0tQBeHAV19yDPNDu5nVMLtvTalQg9deQ+v6eobotAiQjkZKTLviHm6mkovlsABvkUaQ
         TgN7heQdHdM2m8gusAAPxWiwydc0nMyh43NRheL4GVCTbEELgA4sQhAsrSyWcKpYfhH4
         w3/w==
X-Gm-Message-State: ANoB5pkuur1I7eNEKzfcjJQDUArFquFDT1LhIXOwTxNm0rHrO/GQRqhE
        5+3mbja5dOGz2D98d6YbPF9xLA==
X-Google-Smtp-Source: AA0mqf4+t3xWJIqhJSWh3vn3rZsaF4mL/rObMjJPqCSIHYtK1YNzB8OFep9EeMGw+ZKrtpe+MXV3ow==
X-Received: by 2002:a5d:4ac4:0:b0:22c:f296:1120 with SMTP id y4-20020a5d4ac4000000b0022cf2961120mr4322781wrs.369.1668783499360;
        Fri, 18 Nov 2022 06:58:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f7cc:460c:56ae:45a? ([2a01:e0a:982:cbb0:f7cc:460c:56ae:45a])
        by smtp.gmail.com with ESMTPSA id o9-20020a056000010900b00228692033dcsm3676836wrx.91.2022.11.18.06.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:58:19 -0800 (PST)
Message-ID: <15ac1d06-5da7-ebd2-92ff-764c8df803a1@linaro.org>
Date:   Fri, 18 Nov 2022 15:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-4-abel.vesa@linaro.org>
 <76560659-7c90-3846-c250-24bfb072ec0e@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <76560659-7c90-3846-c250-24bfb072ec0e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 13:51, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:31, Abel Vesa wrote:
>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Add nodes for pm8010 in separate dtsi file.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/pm8010.dtsi | 84 ++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm8010.dtsi b/arch/arm64/boot/dts/qcom/pm8010.dtsi
>> new file mode 100644
>> index 000000000000..0ea641e12209
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/pm8010.dtsi
>> @@ -0,0 +1,84 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
> 
> Any reason why this is licensed BSD-3 clause? It's not a recommended
> license (2 clause is). Same for other patches.

Probably a bad copy-paste from other existing files.

While checking, the majority of arch/arm64/boot/dts/qcom/pm*.dtsi uses BSD-3-Clause
so it seems this was done for quite a while now.

> 
>> +/*
>> + * Copyright (c) 2022, Linaro Limited
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/spmi/spmi.h>
>> +
>> +/ {
>> +	thermal-zones {
>> +		pm8010-m-thermal {
>> +			polling-delay-passive = <100>;
>> +			polling-delay = <0>;
>> +
>> +			thermal-sensors = <&pm8010_m_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		pm8010-n-thermal {
>> +			polling-delay-passive = <100>;
>> +			polling-delay = <0>;
>> +
>> +			thermal-sensors = <&pm8010_n_temp_alarm>;
>> +
>> +			trips {
>> +				trip0 {
>> +					temperature = <95000>;
>> +					hysteresis = <0>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip1 {
>> +					temperature = <115000>;
>> +					hysteresis = <0>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +
> 
> Just one blank line.
> 
> 
> Best regards,
> Krzysztof
> 

