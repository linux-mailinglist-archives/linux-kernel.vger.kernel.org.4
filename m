Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9C65B562
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbjABQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbjABQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:54:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAC6259
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:54:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so30026496plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3r5FdCxELrIS8yVo8yWuc07nvsdkxohH/mDP56NN6/Y=;
        b=rWv0Urzy2YIIuFuBytAQvsdJEtXTRvtYtXv7uB3quo9mB9ZIJNlmojPdYWe/H5Dw4H
         OpuIgWKueuvWoqxwRRgZFaSbr4dDRMJNMrUeFJz0qOkGsW8pXkCYCh81w8/KoA8zdWuC
         J1PWFrVC5SnOypntUc89A80oP60PiV8xvxjfXDYb4luNRnKyFjrZYYVLAu8O1FPd8wjm
         HIUxBirCekuHxzK3qRsh+jL1TMaRb+pxDWS9++fHou2cwSkt5SQcyWe3Xsa2zYrl9G0z
         Yka6Dw62/N1n8oDFvsIWYRVzYz3NpNnYp6LboDds7Yt0KbqeJI/hvZ9Bp7htt5knaXKn
         lzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r5FdCxELrIS8yVo8yWuc07nvsdkxohH/mDP56NN6/Y=;
        b=n083Hnady/cMO8zUovtxC9WzBIXePXOX44rnlUWgF0uQSfuEVLxTP4IWV668gGDTcj
         zDXtgXFKiHWTAam2rMcfATh7vztjSITAfLUv2XVhPQsg++DwtJlwsWfggMrGrXLFg0V0
         tCCPEdXdPT7FF80jQEJEpY7bzM6VCY9Uhjvv1/91LQE2RF6pSU1twWWAMrZT1jmxxkR6
         j1DEcwveUncqLzMU3dQDo+uw5v53HVEGgekUkI4xQm/u5BFHUIyoxFZe5CM1xduFvoNA
         8D5Jc2Qn3gdWMsQ0KE2N6P9VzjlcUdSbBCCnswLlZxOAdWCRB4jCp02Rw/N/xCmZmZm2
         tPVw==
X-Gm-Message-State: AFqh2komls+MGMmBEs5bZKhFskfWcquMIXk4B/hFzcY0jOGI2iiR3mwS
        izZ/3N+N9Jjw+71J2WwVRA/W3g==
X-Google-Smtp-Source: AMrXdXtbrXMQvOxeVxcXKabHrm7FhB614evDTxSot5mI7CAIbBzDsTt19LaCn32nFAI3oC/oavPY7g==
X-Received: by 2002:a17:90a:4282:b0:223:f131:3604 with SMTP id p2-20020a17090a428200b00223f1313604mr45490827pjg.17.1672678477841;
        Mon, 02 Jan 2023 08:54:37 -0800 (PST)
Received: from ?IPV6:2401:4900:1c5e:e3b5:c341:16de:ce17:b857? ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id px12-20020a17090b270c00b0020dc318a43esm17546260pjb.25.2023.01.02.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:54:37 -0800 (PST)
Message-ID: <016e9b47-35b4-2110-bbef-ddfd0abc6a8d@linaro.org>
Date:   Mon, 2 Jan 2023 22:24:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20221231131945.3286639-1-bhupesh.sharma@linaro.org>
 <514482a4-614c-d6b8-ec7c-0e69fff72295@linaro.org>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <514482a4-614c-d6b8-ec7c-0e69fff72295@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/2/23 4:16 PM, Konrad Dybcio wrote:
> 
> 
> On 31.12.2022 14:19, Bhupesh Sharma wrote:
>> Add the Embedded USB Debugger(EUD) device tree node for
>> SM6115 / SM4250 SoC.
>>
>> The node contains EUD base register region and EUD mode
>> manager register regions along with the interrupt entry.
>>
>> Also add the typec connector node for EUD which is attached to
>> EUD node via port. EUD is also attached to DWC3 node via port.
>>
>> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>> - This patch is based on my earlier sm6115 usb related changes, which can
>>    be seen here:
>>    https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
>> - This patch is also dependent on my sm6115 eud dt-binding and driver changes
>>    sent earlier, which can be seen here:
>>    https://lore.kernel.org/linux-arm-msm/20221231130743.3285664-1-bhupesh.sharma@linaro.org/
>>
>>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 ++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> index 030763187cc3f..c775f7fdb7015 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> @@ -565,6 +565,37 @@ gcc: clock-controller@1400000 {
>>   			#power-domain-cells = <1>;
>>   		};
>>   
>> +		eud: eud@1610000 {
>> +			compatible = "qcom,sm6115-eud","qcom,eud";
> Missing space between entries.
> 
>> +			reg = <0x01610000 0x2000>,
>> +			      <0x01612000 0x1000>,
>> +			      <0x003e5018 0x4>;
>> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
>> +			ports {
> Newline before ports {}.
> 
> Not sure if debugging hardware should be enabled by default..
>> +				port@0 {
>> +					eud_ep: endpoint {
>> +						remote-endpoint = <&usb2_role_switch>;
>> +					};
>> +				};
> Newline between subsequent nodes.
> 
>> +				port@1 {
>> +					eud_con: endpoint {
>> +						remote-endpoint = <&con_eud>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		eud_typec: connector {
> Non-MMIO nodes don't belong under /soc.
> 
>> +			compatible = "usb-c-connector";
> Newline between properties and subnode.
> 
> 
>> +			ports {
>> +				port@0 {
>> +					con_eud: endpoint {
>> +						remote-endpoint = <&eud_con>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>>   		usb_hsphy: phy@1613000 {
>>   			compatible = "qcom,sm6115-qusb2-phy";
>>   			reg = <0x01613000 0x180>;
>> @@ -1064,6 +1095,12 @@ usb_dwc3: usb@4e00000 {
>>   				snps,has-lpm-erratum;
>>   				snps,hird-threshold = /bits/ 8 <0x10>;
>>   				snps,usb3_lpm_capable;
>> +				usb-role-switch;
> Same here.

For all the above points, the format is same as suggested in [1] and 
already used in existing dts [2].

[1]. 
https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/qcom/qcom%2Ceud.yaml
[2]. 
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sc7280.dtsi#L3587

> On a note, this commit + driver-side changes give me a:
> 
> 1610000.eud     qcom_eud: failed to get role switch

You need to set dr_mode = "otg", for 'usb_dwc3' to make the role switch 
work.

Thanks,
Bhupesh

>> +				port {
>> +					usb2_role_switch: endpoint {
>> +						remote-endpoint = <&eud_ep>;
>> +					};
>> +				};
>>   			};
>>   		};
>>   
