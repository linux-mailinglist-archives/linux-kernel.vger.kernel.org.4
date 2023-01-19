Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545DE673190
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjASGMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:11:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6505470A9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:11:57 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 141so744734pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOu1nZ7Vb+XrPTzOIOsWj6MjBG+iutvcyGQ0UjoYk08=;
        b=jZAX2T7HzZq42/E+WVQXTx3gKT02vV8VQueUmJwm0LQlcMi5B5FDWTBHCygATKO14J
         7jtHt3l4eTYb1gHB5M+t7l4BzYi/DZiuhi1voR61nt/eCFQr0AdyZgRaE9fXuHlqlbMD
         jUmWv1Y8qaeK9iCC43AfkUc+83hqDebVD1956XW37moCgV6+E+CLdH61+4Admp83I/Zi
         qgll4nEGcmhE0Si0EPXTEJu2j1kr6FKC33daZ/dOylLtaJEcAxdkOXDkNCQG+iSi5VQm
         oL1V0CRVRppHoc1EuhKk7HRfOvm+37eDcsnSfQGGx7yTm+g4NXlU8tW9H5AQpihcruKQ
         APIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOu1nZ7Vb+XrPTzOIOsWj6MjBG+iutvcyGQ0UjoYk08=;
        b=ZKrTTFtgvp7D5U+NxeYV5CuqcrGgF8udNnuwRvObTCkEVkYBHSdgORcDNvvhNu0C+P
         +T3MQf08JYAdr2meRbWuiNjkYw2ALnPudP6ut2IeT0nTpLK7olz7y9Yd75zeuj5WWyxa
         u3Fz1zr4lwgne3Q6+smEgCN1g3dsE8gPRBEfqQ5NxF5HS6zbWPwE17Mzz8cFNrvizDBQ
         AK+bvVS6OV1VvJ+hidhGEwbzPQhyEiPbm9GyiiiLUi65vSwT4NUOXoWl47T1RZSCsHsN
         B9d5agoOFPnWfP8bcWD4MYlE+GsYT6NwowQiD7CM7rQMPjqxNW8yN/xF00gkrkfF56Mg
         Mi2g==
X-Gm-Message-State: AFqh2kp/AIv1Xq+v5gYvqpZj4pTddYyWnAc3rjEt0sKWBCtVRFkxxABU
        XkJ4B4r9yFOY3Gs6rmxtOoVZDQ==
X-Google-Smtp-Source: AMrXdXvrAp+SUB9kwNMFXcmw3oswczov7KB+PbZ9/GtKAubV3KNv6O5ASJ1g20NlSSAhpB6e+QJmWg==
X-Received: by 2002:aa7:8c09:0:b0:58d:b8f1:62df with SMTP id c9-20020aa78c09000000b0058db8f162dfmr9396214pfd.16.1674108717076;
        Wed, 18 Jan 2023 22:11:57 -0800 (PST)
Received: from ?IPV6:2401:4900:1c60:63d3:2d69:9f71:187e:f085? ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id y17-20020aa793d1000000b0058da56167b7sm6977943pff.127.2023.01.18.22.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 22:11:56 -0800 (PST)
Message-ID: <75c9bb87-92df-79c8-bcf9-e1077fef0a86@linaro.org>
Date:   Thu, 19 Jan 2023 11:41:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add interconnect nodes
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org,
        a39.skl@gmail.com
References: <20221130104519.2266918-1-bhupesh.sharma@linaro.org>
 <20230118234042.ds4hqdgqjrt7ukpg@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230118234042.ds4hqdgqjrt7ukpg@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/23 5:10 AM, Bjorn Andersson wrote:
> On Wed, Nov 30, 2022 at 04:15:19PM +0530, Bhupesh Sharma wrote:
>> Add the interconnect nodes inside SM6115 dtsi.
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> 
> Seems the driver series is waiting for a v2.
> 
> I'll drop this from my queue for now, please resubmit once the DT
> binding has landed.

Sure Bjorn. I will send a v2 shortly.

Thanks,
Bhupesh

>> ---
>> - Based on linux-next/master
>> - Depends on the SM6115 dt-binding and driver patchset, which can be
>>    seen here: https://lore.kernel.org/linux-arm-msm/20221130103841.2266464-1-bhupesh.sharma@linaro.org/
>>
>>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 51 ++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> index e4a2440ce544..dad5ab3edf0e 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> @@ -485,6 +485,57 @@ usb_1_hsphy: phy@1613000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		snoc: interconnect@1880000 {
>> +			compatible = "qcom,sm6115-snoc";
>> +			reg = <0x01880000 0x60200>;
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus", "bus_a";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +
>> +			clk_virt: interconnect-clk {
>> +				compatible = "qcom,sm6115-clk-virt";
>> +				#interconnect-cells = <1>;
>> +				clock-names = "bus", "bus_a";
>> +				clocks = <&rpmcc RPM_SMD_QUP_CLK>,
>> +					 <&rpmcc RPM_SMD_QUP_A_CLK>;
>> +			};
>> +
>> +			mmnrt_virt: interconnect-mmnrt {
>> +				compatible = "qcom,sm6115-mmnrt-virt";
>> +				#interconnect-cells = <1>;
>> +				clock-names = "bus", "bus_a";
>> +				clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
>> +					 <&rpmcc RPM_SMD_MMNRT_A_CLK>;
>> +			};
>> +
>> +			mmrt_virt: interconnect-mmrt {
>> +				compatible = "qcom,sm6115-mmrt-virt";
>> +				#interconnect-cells = <1>;
>> +				clock-names = "bus", "bus_a";
>> +				clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
>> +					 <&rpmcc RPM_SMD_MMRT_A_CLK>;
>> +			};
>> +		};
>> +
>> +		cnoc: interconnect@1900000 {
>> +			compatible = "qcom,sm6115-cnoc";
>> +			reg = <0x01900000 0x8200>;
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus", "bus_a";
>> +			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
>> +		};
>> +
>> +		bimc: interconnect@4480000 {
>> +			compatible = "qcom,sm6115-bimc";
>> +			reg = <0x04480000 0x80000>;
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus", "bus_a";
>> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +		};
>> +
>>   		qfprom@1b40000 {
>>   			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>>   			reg = <0x01b40000 0x7000>;
>> -- 
>> 2.38.1
>>
