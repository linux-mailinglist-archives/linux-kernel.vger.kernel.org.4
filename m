Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC867A85A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjAYBVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjAYBVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:21:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40D45F6B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:21:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so11579937wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeC8Lz3v3hJMYsusmsRkMr4xYB6Ha27L69duAHb9mKM=;
        b=Ud6P8OCrFe0z/+QdXBd1mKo/ZqaN044vpJLqVlc/fnaOzxre8MMmrAKX7QCUmS8Pb9
         ZMU5U/WzDQXQjMUeQ4ioSzJHpNZ38ynGq4X/4MIVT/GdmrNtTRNhGqnaNdGrLGM+8Tjq
         yQ1zTadj1BBqYGGaUMBtonsiyBy6lGtcd1FkWdM3kSqFoJbjiRwmTNPjb4pix5WS7t+7
         pLcljzO9snzVueS7VAjnO+jOWdsLUDeHoYoTwE5/YknzBesQWPiQAJbkuYaJk+Foa769
         u9BijpZmxtz6ofE42ft6rv+GSXDc1i+bHBhuo1w7XROtzGj0a7CLGtHCGPf9Pqbf+uyg
         8+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeC8Lz3v3hJMYsusmsRkMr4xYB6Ha27L69duAHb9mKM=;
        b=I1ttrd+lk/57n/Y6K4x+bFWZHHZQL79d4kHXJsapga6/3D4pZXlIMzYyHsIS3txvJJ
         WUXkzR574K2+SqMD4C5lUJ1k2ouB9VKduMYk/fQ//Zl35mb94usWvPX+fSonqhY+/+zz
         XdiE7k8j9Q6aNftA2/CWMJ1xh0GLyKLsD4VKXyXdaMa3MqjufWzsyExJ6fJN1+BlKxlv
         Z3v0TBSiFhLAAqfZrJw1Aysh2qYnYrj9iU4m6k81cC9t5dIaignEg1z3CkZYjRcJC+R1
         EAEM2YlycNQdUDcQx1eilH5LyhFVHRONJU0VTidLEt/Eoj+obX87yCxB+8cvgikH65R4
         uV7w==
X-Gm-Message-State: AFqh2kqtbA7iIQ9L9xXlHQmOehp2w/TOQEzYEQPRs/3w/pQAd58nffZ4
        VteSYHlWoKs/QKrS4LY/Mur0Qg==
X-Google-Smtp-Source: AMrXdXttekA4Amb/EkylKkuARPrERkYzjGISbzec8dpr9PJvLO3PHENv/Iu2Pa+xe6WMjfkdn1PB5A==
X-Received: by 2002:adf:f10b:0:b0:2bd:e215:4372 with SMTP id r11-20020adff10b000000b002bde2154372mr22444176wro.20.1674609677425;
        Tue, 24 Jan 2023 17:21:17 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b002bfb29d19e4sm2184275wrp.88.2023.01.24.17.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 17:21:16 -0800 (PST)
Message-ID: <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
Date:   Wed, 25 Jan 2023 01:21:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-6-bryan.odonoghue@linaro.org>
 <e80b98bc-54e8-f7ab-b9a9-dd888108a0cd@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e80b98bc-54e8-f7ab-b9a9-dd888108a0cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 16:29, Krzysztof Kozlowski wrote:
> On 23/01/2023 03:31, Bryan O'Donoghue wrote:
>> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
>> chipset.
>>
>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Co-developed-by: Jun Nie <jun.nie@linaro.org>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> Co-developed-by: Benjamin Li <benl@squareup.com>
>> Signed-off-by: Benjamin Li <benl@squareup.com>
>> Co-developed-by: James Willcox <jwillcox@squareup.com>
>> Signed-off-by: James Willcox <jwillcox@squareup.com>
>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Co-developed-by: Joseph Gates <jgates@squareup.com>
>> Signed-off-by: Joseph Gates <jgates@squareup.com>
>> Co-developed-by: Max Chen <mchen@squareup.com>
>> Signed-off-by: Max Chen <mchen@squareup.com>
>> Co-developed-by: Zac Crosby <zac@squareup.com>
>> Signed-off-by: Zac Crosby <zac@squareup.com>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>   arch/arm64/boot/dts/qcom/apq8039-t2.dts | 545 ++++++++++++++++++++++++
>>   2 files changed, 546 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index b0423ca3e79fd..73ff8d3213d99 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>> new file mode 100644
>> index 0000000000000..734b4d6054132
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>> @@ -0,0 +1,545 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020-2023, Linaro Ltd.
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "msm8939.dtsi"
>> +#include "msm8939-pm8916.dtsi"
>> +#include <dt-bindings/arm/qcom,ids.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +#include <dt-bindings/sound/apq8016-lpass.h>
>> +
>> +/ {
>> +	model = "Square, Inc. T2 Devkit";
>> +	compatible = "square,apq8039-t2", "qcom,msm8939";
> 
> There is no square vendor prefix.

commit d3e2262cd0d1105bb3a71012693876d01e8de203
Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Tue Jan 17 02:48:39 2023 +0000

     dt-bindings: arm: qcom: Document MSM8939 SoC binding

+      - items:
+          - enum:
+              - sony,kanuti-tulip
+              - square,apq8039-t2
+          - const: qcom,msm8939


>> +
>> +	qcom,board-id = <0x53 0x54>;
>> +	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>, <QCOM_ID_APQ8039 0x30000>;
>> +

>> +
>> +	lcd_avdd_reg: lcd-avdd-regulator {
> 
> Since we try to have nodes ordered, how about naming them
> "regulator-xxx", so whatever is added later will not spread them all over?

Point taken.

vreg_ looks like a more common prefix

arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts: 
vreg_edp_3p3: regulator-edp-3p3 {
vreg_edp_bl: regulator-edp-bl {
vreg_misc_3p3: regulator-misc-3p3 {
vreg_nvme: regulator-nvme {
vreg_vph_pwr: regulator-vph-pwr {
vreg_wlan: regulator-wlan {
vreg_wwan: regulator-wwan {

>> +	status = "okay";
>> +
>> +	typec: tps6598x@38 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

None of those fit really

typec_pd is upstream for the same IC, I'll reuse that.

arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi

---
bod
