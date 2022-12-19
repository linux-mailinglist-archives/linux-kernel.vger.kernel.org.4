Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B14651587
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiLSWYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiLSWYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:24:44 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0239FB1D2;
        Mon, 19 Dec 2022 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671488684; x=1703024684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CC15qpHIZONMZVHnmpQsB1kPNrbndvlbtCIm8JdO5n4=;
  b=Wwmb2XXmOMQ5RdrUlAUWjARRewI6LG/i0f439ifoZdIvsOOrYK/WC9XT
   kKrFf69/4uJSyUHNJ9Zwe7rZlLnUCVucBRTwnV4EAiKGplVS/ZrIAH7AR
   FgogvQaiTed/lKKBs5f6FchLLUvXyupYSKpjXXpPmYEPR0F73ayspDLLS
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Dec 2022 14:24:43 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 14:24:43 -0800
Received: from [10.110.23.17] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 14:24:42 -0800
Message-ID: <383225a2-0430-03d7-4e6b-e2bfb2d76fe5@quicinc.com>
Date:   Mon, 19 Dec 2022 16:24:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for
 generic nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221216231349.22835-1-quic_molvera@quicinc.com>
 <3ca81685-fb8f-fa31-3ae8-ef72f3aca7f2@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <3ca81685-fb8f-fa31-3ae8-ef72f3aca7f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/2022 8:29 AM, Konrad Dybcio wrote:
>
> On 17.12.2022 00:13, Melody Olvera wrote:
>> Update the bindings to allow for generic regulator nodes instead of
>> device-specific node names.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>
>> Changes from v4:
>> * updated regulator pattern to accommodate more regulators
>>
>> This patch comes from discussions on [1] and is separated out. It also
>> has updated pattern matching to match the comments left from [1].
>>
>> [1] https://lore.kernel.org/all/20221026200429.162212-2-quic_molvera@quicinc.com/
>>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
>> index b246500d3d5d..5bb624f62edc 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
>> @@ -112,8 +112,9 @@ properties:
>>      $ref: /schemas/power/qcom,rpmpd.yaml#
>>  
>>  patternProperties:
>> -  '-regulators$':
>> +  '^regulators(-[09])?$':
> Wouldn't this only allow regulators-0 and regulators-9?

Yup; my bad. Will update regex here.

Thanks,
Melody

>
> Konrad
>>      $ref: /schemas/regulator/qcom,rpmh-regulator.yaml#
>> +    unevaluatedProperties: false
>>  
>>  required:
>>    - compatible
>>
>> base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291

