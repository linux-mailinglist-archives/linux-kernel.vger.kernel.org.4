Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9920C6F423C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjEBLDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjEBLDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:03:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEA4686
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:03:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8b766322bso34674261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683025397; x=1685617397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOMeaRlGtpfULcYehJpxEcz/nKFZB433u9YWi4JwQ/o=;
        b=H7fMVfvhOULgMPLou1ZksP++qlsfBH6XG4uakQ8oE751XNKbvGG/oS6fR6VVAgQPHt
         MKrNt/jAk40/jIGhf0m+mXSyaucMh9rHw9V/o69PY/NOgVLyg/b2R+j+idB3NC0uE2fD
         eqMz1LoQcVJcQDr3MMgpIMD1CPgpD0OOQzmsUrlhSnaPIt1Y//WtQGu9P5rgNN1h13H1
         ZVlQ8Ymlz2vmdnigNodctJ0BH4RhIfjy/CwQ8c+V+i6culX5WD5Ga83ga9E6Tr2mpX+n
         5toTMF5crif/hE0SDscvLofw36LM8aDqq10pOTjUcj3Ji8QURfIxJTfrgxz3cL1H2Kkb
         KFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025397; x=1685617397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOMeaRlGtpfULcYehJpxEcz/nKFZB433u9YWi4JwQ/o=;
        b=jN/LM6UIi2pw7mKjfHQMoPozIKOVNBOUXPkue+Lm9X3YdBnkS871UNQf0QHkj/wn3w
         m8JNW64cNjUDydy4MGtCxfpKjdXqsLtJwYjsxwFefHc6G8lYXI/iTLvkXuSks6NAYVWL
         3pOkQP1XMgmH86s79LIZxddOTS51UWSe4VStH7ReEngB6rSw2TpSA0kYSlJWX9/2+2BD
         604ogn66ZzA29I1BXItYZEm7zCnVHFvQ6qD68kJ/VkJgDRj7yxv6LCZCXdc2yCxt5S9N
         auWsHJJYa40dMQis9oGwVYQfz/DXhcsZFjgLoq4aKFM38U+Bhu74eW5YEOlDLfXzykn4
         yY0A==
X-Gm-Message-State: AC+VfDzMcVoLMy1QxvALOIXOsZ0QgcEWtgwvT271ky6797QpA0FDZsKq
        Whe0/oOO0tu3Ks6DJ1/9SSZv3g==
X-Google-Smtp-Source: ACHHUZ5X7eDWy14NTZbF9EtgBIP0VGUzvRw4HoYZ/V+FI6FndOFiCgP9uc8M6yOxoK8bS7GWTVe59A==
X-Received: by 2002:a2e:8756:0:b0:2a8:d39b:1496 with SMTP id q22-20020a2e8756000000b002a8d39b1496mr4405957ljj.24.1683025396788;
        Tue, 02 May 2023 04:03:16 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9f43000000b002a8d01905f7sm581783ljk.101.2023.05.02.04.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:03:16 -0700 (PDT)
Message-ID: <543cdf95-754f-2f7c-9c5c-b901eedb441a@linaro.org>
Date:   Tue, 2 May 2023 13:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed
 graph
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-7-quic_bjorande@quicinc.com>
 <aa94b488-cb6e-bd74-0711-b7c4c7589f7a@linaro.org>
 <fc414f61-34a8-acb0-29d4-971a873562e5@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fc414f61-34a8-acb0-29d4-971a873562e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.04.2023 15:27, Neil Armstrong wrote:
> On 27/04/2023 01:33, Konrad Dybcio wrote:
>>
>> On 4/25/23 04:40, Bjorn Andersson wrote:
>>> With support for the QMP combo phy to react to USB Type-C switch events,
>>> introduce it as the next hop for the SuperSpeed lanes of the two USB
>>> Type-C connectors, and connect the output of the DisplayPort controller
>>> to the QMP combo phy.
>>>
>>> This allows the TCPM to perform orientation switching of both USB and
>>> DisplayPort signals.
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 28 ++++++++++++++++---
>>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 34 +++++++++++++++++++++++
>>>   2 files changed, 58 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> index 547277924ea3..33c973661fa5 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> @@ -64,7 +64,7 @@ port@1 {
>>>                       reg = <1>;
>>>                       pmic_glink_con0_ss: endpoint {
>>> -                        remote-endpoint = <&mdss0_dp0_out>;
>>> +                        remote-endpoint = <&usb_0_qmpphy_out>;
>>>                       };
>>>                   };
>>> @@ -99,7 +99,7 @@ port@1 {
>>>                       reg = <1>;
>>>                       pmic_glink_con1_ss: endpoint {
>>> -                        remote-endpoint = <&mdss0_dp1_out>;
>>> +                        remote-endpoint = <&usb_1_qmpphy_out>;
>>>                       };
>>>                   };
>>> @@ -412,7 +412,7 @@ &mdss0_dp0 {
>>>   &mdss0_dp0_out {
>>>       data-lanes = <0 1>;
>>> -    remote-endpoint = <&pmic_glink_con0_ss>;
>>> +    remote-endpoint = <&usb_0_qmpphy_dp_in>;
>>>   };
>>>   &mdss0_dp1 {
>>> @@ -421,7 +421,7 @@ &mdss0_dp1 {
>>>   &mdss0_dp1_out {
>>>       data-lanes = <0 1>;
>>> -    remote-endpoint = <&pmic_glink_con1_ss>;
>>> +    remote-endpoint = <&usb_1_qmpphy_dp_in>;
>>>   };
>>>   &mdss0_dp3 {
>>> @@ -670,9 +670,19 @@ &usb_0_qmpphy {
>>>       vdda-phy-supply = <&vreg_l9d>;
>>>       vdda-pll-supply = <&vreg_l4d>;
>>> +    orientation-switch;
>>
>> I believe this belongs in the SoC DTSI, as it's supported by
>> the PHY block itself
>>
>>
>> The rest seems to lgtm..
>>
>>
>> On a note, why did we end up placing pmic_glink in device
>> DTs? It's already assumed that we're using the full Qualcomm
>> stack as we use PAS for remoteprocs so I *think* we can always
>> assume pmic_glink would be there!
> 
> As we did on other board, I think because having pmic_glink depends
> on the board firmware capabilities ? Boards without USB-C won't need/have
> pmic_link right ?
PMIC_GLINK takes care of USB-C, but also enables battmgr and friends

Konrad
> 
> Neil
> 
>>
>> Konrad
>>
>>> +
>>>       status = "okay";
>>>   };
>>> +&usb_0_qmpphy_dp_in {
>>> +    remote-endpoint = <&mdss0_dp0_out>;
>>> +};
>>> +
>>> +&usb_0_qmpphy_out {
>>> +    remote-endpoint = <&pmic_glink_con0_ss>;
>>> +};
>>> +
>>>   &usb_0_role_switch {
>>>       remote-endpoint = <&pmic_glink_con0_hs>;
>>>   };
>>> @@ -697,9 +707,19 @@ &usb_1_qmpphy {
>>>       vdda-phy-supply = <&vreg_l4b>;
>>>       vdda-pll-supply = <&vreg_l3b>;
>>> +    orientation-switch;
>>> +
>>>       status = "okay";
>>>   };
>>> +&usb_1_qmpphy_dp_in {
>>> +    remote-endpoint = <&mdss0_dp1_out>;
>>> +};
>>> +
>>> +&usb_1_qmpphy_out {
>>> +    remote-endpoint = <&pmic_glink_con1_ss>;
>>> +};
>>> +
>>>   &usb_1_role_switch {
>>>       remote-endpoint = <&pmic_glink_con1_hs>;
>>>   };
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index 0e691bb0120c..1eb3a295e8fa 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -3006,6 +3006,23 @@ usb_0_qmpphy: phy@88eb000 {
>>>               #phy-cells = <1>;
>>>               status = "disabled";
>>> +
>>> +            ports {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                port@0 {
>>> +                    reg = <0>;
>>> +
>>> +                    usb_0_qmpphy_out: endpoint {};
>>> +                };
>>> +
>>> +                port@1 {
>>> +                    reg = <1>;
>>> +
>>> +                    usb_0_qmpphy_dp_in: endpoint {};
>>> +                };
>>> +            };
>>>           };
>>>           usb_1_hsphy: phy@8902000 {
>>> @@ -3042,6 +3059,23 @@ usb_1_qmpphy: phy@8903000 {
>>>               #phy-cells = <1>;
>>>               status = "disabled";
>>> +
>>> +            ports {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                port@0 {
>>> +                    reg = <0>;
>>> +
>>> +                    usb_1_qmpphy_out: endpoint {};
>>> +                };
>>> +
>>> +                port@1 {
>>> +                    reg = <1>;
>>> +
>>> +                    usb_1_qmpphy_dp_in: endpoint {};
>>> +                };
>>> +            };
>>>           };
>>>           mdss1_dp0_phy: phy@8909a00 {
> 
