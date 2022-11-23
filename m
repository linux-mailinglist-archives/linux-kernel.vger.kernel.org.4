Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD0636736
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiKWRam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiKWRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:30:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB88E295;
        Wed, 23 Nov 2022 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669224612; x=1700760612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZT9WVned9qGMAlH0r6W65dY8aAfAq0l2ES0Gvi1OpwI=;
  b=nnHKdSPTYo47b6DAIhIVApHTAOdpOozQLnW/MQPB27rGarHhpDtCREnX
   j3g4oBm2h17QBYN0wTEwgqKUVrS+LEUlbJ0TjHzXB7xvgXYJsa0jsqgft
   mM6mF5HQOqHdycX5VTNVISbT2Tj0lfW98FMXb6DdYemAk9EQM5jFaxpjP
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2022 09:30:12 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:30:11 -0800
Received: from [10.110.94.74] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 09:30:10 -0800
Message-ID: <85a0af2c-5f79-3d84-c946-a4960aee2958@quicinc.com>
Date:   Wed, 23 Nov 2022 11:30:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-2-quic_molvera@quicinc.com>
 <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
 <faf2d137-efab-93ab-f325-1fa507f166a7@quicinc.com>
 <03174a04-440d-a840-1e54-fbdbdfe296c3@linaro.org>
 <2a50b68f-d2dd-bae5-29b3-f608813d5a3f@quicinc.com>
 <1d13e913-d425-8cb0-d954-d1d7bc340f38@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <1d13e913-d425-8cb0-d954-d1d7bc340f38@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2022 2:06 AM, Krzysztof Kozlowski wrote:
> On 22/11/2022 16:23, Melody Olvera wrote:
>>
>> On 11/22/2022 1:48 AM, Krzysztof Kozlowski wrote:
>>> On 21/11/2022 21:38, Melody Olvera wrote:
>>>> On 11/20/2022 4:58 AM, Krzysztof Kozlowski wrote:
>>>>> On 18/11/2022 19:20, Melody Olvera wrote:
>>>>>> Add device tree bindings for QDU1000 and QRU1000 TLMM devices.
>>>>>>
>>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>>> ---
>>>>>>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
>>>>>>  1 file changed, 134 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..cb0c496d8666
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
>>>>>> @@ -0,0 +1,134 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Melody Olvera <quic_molvera@quicinc.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
>>>>>> +  QRU1000 platforms.
>>>>> It's better to keep consistent style which allows to do easy
>>>>> search/replace, than to have new files using their own sentences. So
>>>>> keep it the same as was unified in few recent commits.
>>>> Ok... Just making sure that's what you want. Last PS you gave comments to change
>>>> the wording of this description to remove "This binding describes..." as we've done
>>>> in all the other qcom pinctrl/tlmm bindings. I can change the wording back to the
>>>> original, just want to be clear here.
>>> I propose to have the same wording as other Qualcomm TLMM bindings,
>>> however you changed it to something not the same. Therefore I wonder -
>>> why having here different wording than all other bindings?
>>>
>>> By going back to original - what do you mean? If it matches all others,
>>> then yes, but I doubt it.
>>>
>>> Just to be sure - are you working on proper (recent) trees or something old?
>> Original matched how it was done on other Qualcomm TLMM bindings. Feedback
>> was to drop "This binding describes..." from [1], but all the Qualcomm TLMM
>> bindings start with "This binding describes...". I'm looking at qcom tree for-next
>> branch; should be recent, no?
> No. It's not recent for anything else than managed by Bjorn. You need to
> base the patches on maintainer's trees, which is usually the easiest to
> achieve via linux-next (especially that these changes were in my tree
> for some time before I sent them to Linus).

Ah ok; looking at linux-next looks like it should be "Top Level Mode Multiplexer pin
controller in Qualcomm QDU1000 and QRU1000 SoCs."

Thanks,
Melody

>
> Your all other patches might have similar issues - wrong base or not
> good example/starting point.
>
> Best regards,
> Krzysztof
>

