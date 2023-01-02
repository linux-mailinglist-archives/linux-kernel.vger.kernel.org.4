Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04E65B59C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjABRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjABRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:09:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8F865B1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:09:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so42354931lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb/p8xP5QAYoPGxqZhooKZWT8wTdW18VCAdSIuIWK1E=;
        b=XiLVsW1/qn0vNY9c6lTDNxzF0WOymzfx2go+yHyJUQE3BrIfL2aGFsSJiqV6uMRFRS
         9AAWp3anbJXe2gMD1MyhjN3vPDLDVMN4U+DjA83kllDQXRTNNe9LEHihmOYsRkq3yxGQ
         now26u2cd6IYr5YD+ID87JM9K7F5afcrVEGJpIX+T9U9BiaEwBfTHcafgZyPFopUkfaA
         8XRtKggj3j2A8usIJtTye/iVppJtkHYQS5N5U+szWqfvRIROA+lzplaOAlX/ZiZICkFs
         YVHaokRykbQyMQUYxlUZeFFHj4bSOSt6Il9poejdZXivFKiXrdteCTe8ycOKlYScbXIv
         Xbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb/p8xP5QAYoPGxqZhooKZWT8wTdW18VCAdSIuIWK1E=;
        b=JSfw8ZUnRR1R1Mtn2SYyaFmTjTzoBrkULTJZC/MSyPKkoFdWXH4y2cqjBD/wckS4eL
         6mGHCFht/GKVxzuHFU7OWrm25FVH1b4Fr6dpfjItoGdIRd62+tasSuQlh+KZbp3K0yyD
         Qc1LvoyKfSsXMR5V4Nd9U1HMc3jIQSoHCsPbi6xMpyzyGjC+3Ixu/n8liazAgIvxKm0V
         QfGVITjutoQ2mc4anl10qcTRFrCBR2thGXswDoafakU/0ehhqlopCEFt49FJStOsX9HZ
         EKVj8cUO6FYtLu3QPVrOFSBhXUFeODeoFGzMn9KNAIkdEDhRZxKPwPwwl72nUI21ZSf1
         Wc0Q==
X-Gm-Message-State: AFqh2kpAxwo/b9jPheM4KeKgb4hVQY51etK50kbP0Yf7OGYhkXl+prMo
        dyH3Cev2j8ChI1FFQPeA2dgFOA==
X-Google-Smtp-Source: AMrXdXs5Q/ulPOWZ5ja+a57DKa+lkoUm/1MP59tJYo3hTUMqXcAhTZ1Rd3dC3CTx9vMDaqO554nF+w==
X-Received: by 2002:a05:6512:340a:b0:4b5:8fee:1d71 with SMTP id i10-20020a056512340a00b004b58fee1d71mr11864924lfr.64.1672679392324;
        Mon, 02 Jan 2023 09:09:52 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id v25-20020a056512049900b0049e9122bd0esm4531318lfq.114.2023.01.02.09.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 09:09:51 -0800 (PST)
Message-ID: <ff80c4fb-687c-b149-d374-a85ac9f53f30@linaro.org>
Date:   Mon, 2 Jan 2023 18:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20221231131945.3286639-1-bhupesh.sharma@linaro.org>
 <514482a4-614c-d6b8-ec7c-0e69fff72295@linaro.org>
 <016e9b47-35b4-2110-bbef-ddfd0abc6a8d@linaro.org>
 <abbaa799-c7a9-e4cd-cd81-3cf3f0d83110@linaro.org>
In-Reply-To: <abbaa799-c7a9-e4cd-cd81-3cf3f0d83110@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.01.2023 18:03, Konrad Dybcio wrote:
> 
> 
> On 2.01.2023 17:54, Bhupesh Sharma wrote:
>>
>> On 1/2/23 4:16 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 31.12.2022 14:19, Bhupesh Sharma wrote:
>>>> Add the Embedded USB Debugger(EUD) device tree node for
>>>> SM6115 / SM4250 SoC.
>>>>
>>>> The node contains EUD base register region and EUD mode
>>>> manager register regions along with the interrupt entry.
>>>>
>>>> Also add the typec connector node for EUD which is attached to
>>>> EUD node via port. EUD is also attached to DWC3 node via port.
>>>>
>>>> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>> ---
>>>> - This patch is based on my earlier sm6115 usb related changes, which can
>>>>    be seen here:
>>>>    https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
>>>> - This patch is also dependent on my sm6115 eud dt-binding and driver changes
>>>>    sent earlier, which can be seen here:
>>>>    https://lore.kernel.org/linux-arm-msm/20221231130743.3285664-1-bhupesh.sharma@linaro.org/
>>>>
>>>>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 ++++++++++++++++++++++++++++
>>>>   1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> index 030763187cc3f..c775f7fdb7015 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> @@ -565,6 +565,37 @@ gcc: clock-controller@1400000 {
>>>>               #power-domain-cells = <1>;
>>>>           };
>>>>   +        eud: eud@1610000 {
>>>> +            compatible = "qcom,sm6115-eud","qcom,eud";
>>> Missing space between entries.
>>>
>>>> +            reg = <0x01610000 0x2000>,
>>>> +                  <0x01612000 0x1000>,
>>>> +                  <0x003e5018 0x4>;
>>>> +            interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            ports {
>>> Newline before ports {}.
>>>
>>> Not sure if debugging hardware should be enabled by default..
>>>> +                port@0 {
>>>> +                    eud_ep: endpoint {
>>>> +                        remote-endpoint = <&usb2_role_switch>;
>>>> +                    };
>>>> +                };
>>> Newline between subsequent nodes.
>>>
>>>> +                port@1 {
>>>> +                    eud_con: endpoint {
>>>> +                        remote-endpoint = <&con_eud>;
>>>> +                    };
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>> +        eud_typec: connector {
>>> Non-MMIO nodes don't belong under /soc.
>>>
>>>> +            compatible = "usb-c-connector";
>>> Newline between properties and subnode.
>>>
>>>
>>>> +            ports {
>>>> +                port@0 {
>>>> +                    con_eud: endpoint {
>>>> +                        remote-endpoint = <&eud_con>;
>>>> +                    };
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>>           usb_hsphy: phy@1613000 {
>>>>               compatible = "qcom,sm6115-qusb2-phy";
>>>>               reg = <0x01613000 0x180>;
>>>> @@ -1064,6 +1095,12 @@ usb_dwc3: usb@4e00000 {
>>>>                   snps,has-lpm-erratum;
>>>>                   snps,hird-threshold = /bits/ 8 <0x10>;
>>>>                   snps,usb3_lpm_capable;
>>>> +                usb-role-switch;
>>> Same here.
>>
>> For all the above points, the format is same as suggested in [1] and already used in existing dts [2].
>>
>> [1]. https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/qcom/qcom%2Ceud.yaml
>> [2]. https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sc7280.dtsi#L3587
> The fact that it's landed does not necessarily imply it's 100% correct..
> That one seems to have slipped through review and could use some fixing up.
> 
>>
>>> On a note, this commit + driver-side changes give me a:
>>>
>>> 1610000.eud     qcom_eud: failed to get role switch
>>
>> You need to set dr_mode = "otg", for 'usb_dwc3' to make the role switch work.
> Thanks, couldn't find that anywhere. This however kicks me into EDL,
> so that's one more reason to disable it by default.
> 
> Konrad> 
Update: it would probably help if I flashed the correct kernel :P
Enabling EUD does in it self kick me into EDL, but the secure call
responsible for setting it up returns EINVAL (just like on sony
devices), so it's not gonna be much useful.

Konrad
>> Thanks,
>> Bhupesh
>>
>>>> +                port {
>>>> +                    usb2_role_switch: endpoint {
>>>> +                        remote-endpoint = <&eud_ep>;
>>>> +                    };
>>>> +                };
>>>>               };
>>>>           };
>>>>   
