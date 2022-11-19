Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8751D630F83
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiKSQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKSQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:36:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B2776E9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:36:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j15so13144014wrq.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsF1LllxCvYInTJDLzaY1L4qmjh8Dh5bLeAqC9UmmJU=;
        b=Rs9KaMeRUDxYSULhajJZA0shQ7tuA70Z49WzjMut57gB5PaX6ZN899kh+EKBXNCZTR
         TO5W8/jxCH/IXjgugqWemm5lQpglUScoG/nJ9wUQ4fJh6ecUtPlBT+WzLllS0h4RLmtW
         BMD8M/EgTU8qP9f4lBIsYy5pQtyvk1ElahVcwIuYOYsjS81zkSkFm4lRp4a4TwGmuw4x
         ovyAb0wS3wejNbDmjPej+5P3GD2G7huBfdRPsHKoshGgekxXLZphoCGNaY/YciCEtUfM
         RdigjPm/WEVseUDDV6CNrpQzGT87CPzoYSIssQOh0di0QEL0adItDlou8uplaJCuEgUN
         gQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsF1LllxCvYInTJDLzaY1L4qmjh8Dh5bLeAqC9UmmJU=;
        b=YyZgRiW2oogHsLHunF4iYqumz3McSdEufquPWt3o6Mb4BLlXteA2nB+qIv3hjeOlXZ
         pldhsbeklGaO+OVx3ynTa6PLlQQzzJ6aXLV3OdG0fKTmdpg/ez73WES2ab/iF/VOFq4d
         veLwnQPO/P5Lsc6tkVTkQ8h0XFUBEs2G7uW4itgC911CmLe9GXtZlkOHrVBLapGlrn48
         s6p43/XKth2AOciUa3hRYwd+Zr5FJ6h0GWxx+pvp8/lpegKHs/oiildmG8YuQ6eNVk3l
         8IRoFB/HjSNh1Q/IiftlNFcrm3AhvZeg9nvSm2Qp9fbuuPqvAnuj3KQzneiJHlBhRR6X
         xVag==
X-Gm-Message-State: ANoB5pltYGrq6XivQ5zEnd908IATV33pKU0x2piQBW2vdQvWT4dPArTd
        NhEXcTMe47HXFRoppLjewp5jzA==
X-Google-Smtp-Source: AA0mqf5xVZ5/9Nb9T0p5NKPI+07pyDsrJhSPPmNxzN25wIciuILiY/0TxmVK28YvKbLwZgMcpDkm2Q==
X-Received: by 2002:a5d:668b:0:b0:22f:bf9b:b6b3 with SMTP id l11-20020a5d668b000000b0022fbf9bb6b3mr6878259wru.108.1668875792890;
        Sat, 19 Nov 2022 08:36:32 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm19811646wms.3.2022.11.19.08.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 08:36:31 -0800 (PST)
Message-ID: <76b8941a-8fad-71b2-b67f-92120db5f089@linaro.org>
Date:   Sat, 19 Nov 2022 16:36:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-2-srinivas.kandagatla@linaro.org>
 <9055fbf4-3bc3-bd44-6081-f422c75f11f1@linaro.org>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <9055fbf4-3bc3-bd44-6081-f422c75f11f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 08:06, Krzysztof Kozlowski wrote:
> On 15/11/2022 18:02, Srinivas Kandagatla wrote:
>> Add GPR node along with APM(Audio Process Manager) and PRM(Proxy
>> resource Manager) audio services.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 40 ++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index c32bcded2aef..e3cdd8bccb0c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -12,6 +12,7 @@
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> +#include <dt-bindings/soc/qcom,gpr.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -1152,6 +1153,45 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>>   
>>   				label = "lpass";
>>   				qcom,remote-pid = <2>;
>> +
>> +				gpr {
>> +					compatible = "qcom,gpr";
>> +					qcom,glink-channels = "adsp_apps";
>> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +					qcom,intents = <512 20>;
>> +
>> +					q6apm: q6apm {
>> +						reg = <GPR_APM_MODULE_IID>;
>> +						compatible = "qcom,q6apm";
>> +						#sound-dai-cells = <0>;
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +						q6apmdai: dais {
>> +							compatible = "qcom,q6apm-dais";
>> +							#sound-dai-cells = <1>;
> 
> DAI cells are not allowed by binding, so either drop it or update binding.

Thanks Krzystof, Konrad and Johan for reviewing.

I agree with all of the comments and they are fixed now.
it will be part of v2.

--srini

> 
>> +							iommus = <&apps_smmu 0x0c01 0x0>;
>> +						};
>> +
>> +						q6apmbedai: bedais {
>> +							compatible = "qcom,q6apm-lpass-dais";
>> +							#sound-dai-cells = <1>;
>> +						};
>> +					};
>> +
>> +					q6prm: q6prm {
>> +						reg = <GPR_PRM_MODULE_IID>;
>> +						compatible = "qcom,q6prm";
>> +						#clock-cells = <2>;
> 
> Not allowed by binding.
> 
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +						q6prmcc: cc {
> 
> This should be "clock-controller".
> 
>> +							compatible = "qcom,q6prm-lpass-clocks";
>> +							#clock-cells = <2>;
>> +						};
>> +					};
>> +
> 
> Drop empty line
> 
>> +				};
>> +
> 
> Ditto
> 
>>   			};
>>   		};
>>   
> 
> Best regards,
> Krzysztof
> 
