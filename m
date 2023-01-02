Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC665B5A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjABRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbjABRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:10:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54064BC19
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:10:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ge16so26840868pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9oz15QNNm81zokVTxgMCrGaFEQ0wDDWXatzQ1zjom0=;
        b=oS1/FN4NZ+sjYZAo7wURUFJYZDgkDpAtxxwoN6oEMhdFdT7/aNZ/A5BAfE50EexvKH
         KQuW6dCNo/SwfYqNlLHRHw4YzraEYwUlcJ2K+NAC32evuUig6RANl2prDDcuQMrNXpF4
         8VBcOkvAqjld8+R0gWnpICAo0cGEpbmV9rTU7MGc+mcKAHKIYoJsmv4m62ksUCsk3i6Y
         nSLIR5Y3vkub9XD4Tdu7/uBghJrMMCoqgS8r+9bc8Qz24+PIkY8hojdWlTp/xBTlr6d4
         SOYNPRdsudruoBo9ld7piEmNUymoVAHMV0RbQF5RAB5GKGQoEruxDsMq+x3cMosgUg6X
         4THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9oz15QNNm81zokVTxgMCrGaFEQ0wDDWXatzQ1zjom0=;
        b=ZQq9SWH+KKsTGjBCw/BsJPL69pdJJmkrVElZ5PFOU6hikRFFaXYK3w5yafeMuqH1fP
         NhwVv6JNszHXQ+F5bKIHM2+ONBhQRuk9cvs53ERb3ykPiK1bBGgjBup4URQeUwu8LPXB
         oR/gPm3XOZclqtrzBxs52oPH5Ea/HJl7PZesz04iA/wbzXkGMtrrRq4P3vZpcGXiYX79
         fCPmiuZRjGlSOm0Kz9q6kdbskSOQsuWzHWs3jv9SB2heBVOvGHs3mPlK4OkKgQt8HWKI
         XsYV8/I2lElQ7UNphEUVpPvHIUYgv64m1JWw2NQaCWOLXuA4KOWsfYYLPaEUSdDZbogF
         tOzg==
X-Gm-Message-State: AFqh2krU/6jN9A+UkplKl9DOb7ln7GqPfwxO/5c7e6nNFZgBzEmw6ii1
        9o2E3zJefZR10Mf9XkJ9pp4vQQ==
X-Google-Smtp-Source: AMrXdXsyGQdA4ODoCF4RIBgtXj/wtPu77paoDFpGnXa8kMpf0OLyu42uDilhg3RA6/pxgTBf72a1UA==
X-Received: by 2002:a17:903:451:b0:192:820d:d1 with SMTP id iw17-20020a170903045100b00192820d00d1mr30338778plb.25.1672679421704;
        Mon, 02 Jan 2023 09:10:21 -0800 (PST)
Received: from ?IPV6:2401:4900:1c5e:e3b5:c341:16de:ce17:b857? ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b001811a197797sm20545505plr.194.2023.01.02.09.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 09:10:21 -0800 (PST)
Message-ID: <cc8c5677-f2ea-c134-6539-0412ccff6bc7@linaro.org>
Date:   Mon, 2 Jan 2023 22:40:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20221231131945.3286639-1-bhupesh.sharma@linaro.org>
 <514482a4-614c-d6b8-ec7c-0e69fff72295@linaro.org>
 <016e9b47-35b4-2110-bbef-ddfd0abc6a8d@linaro.org>
 <abbaa799-c7a9-e4cd-cd81-3cf3f0d83110@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <abbaa799-c7a9-e4cd-cd81-3cf3f0d83110@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/23 10:33 PM, Konrad Dybcio wrote:
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
>>>>     be seen here:
>>>>     https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
>>>> - This patch is also dependent on my sm6115 eud dt-binding and driver changes
>>>>     sent earlier, which can be seen here:
>>>>     https://lore.kernel.org/linux-arm-msm/20221231130743.3285664-1-bhupesh.sharma@linaro.org/
>>>>
>>>>    arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 ++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> index 030763187cc3f..c775f7fdb7015 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> @@ -565,6 +565,37 @@ gcc: clock-controller@1400000 {
>>>>                #power-domain-cells = <1>;
>>>>            };
>>>>    +        eud: eud@1610000 {
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
>>>>            usb_hsphy: phy@1613000 {
>>>>                compatible = "qcom,sm6115-qusb2-phy";
>>>>                reg = <0x01613000 0x180>;
>>>> @@ -1064,6 +1095,12 @@ usb_dwc3: usb@4e00000 {
>>>>                    snps,has-lpm-erratum;
>>>>                    snps,hird-threshold = /bits/ 8 <0x10>;
>>>>                    snps,usb3_lpm_capable;
>>>> +                usb-role-switch;
>>> Same here.
>>
>> For all the above points, the format is same as suggested in [1] and already used in existing dts [2].
>>
>> [1]. https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/qcom/qcom%2Ceud.yaml
>> [2]. https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sc7280.dtsi#L3587
> The fact that it's landed does not necessarily imply it's 100% correct..
> That one seems to have slipped through review and could use some fixing up.

Fair enough. I will send a v2 with fixes for existing yaml documentation 
and dts files.

>>> On a note, this commit + driver-side changes give me a:
>>>
>>> 1610000.eud     qcom_eud: failed to get role switch
>>
>> You need to set dr_mode = "otg", for 'usb_dwc3' to make the role switch work.
> Thanks, couldn't find that anywhere. This however kicks me into EDL,
> so that's one more reason to disable it by default.

Ok. BTW it works fine on my sm6115 based board, but I agree it can be 
left as disabled by default for now.

Thanks.
>>>> +                port {
>>>> +                    usb2_role_switch: endpoint {
>>>> +                        remote-endpoint = <&eud_ep>;
>>>> +                    };
>>>> +                };
>>>>                };
>>>>            };
>>>>    
