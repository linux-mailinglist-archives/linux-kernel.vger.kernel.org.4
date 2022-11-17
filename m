Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8CA62D5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiKQJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKQJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:02:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B559176
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:02:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v1so2558628wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DqXNcJKGEk90R2legdFOv2JapBqj5ImP7hXsUpdTZn8=;
        b=B3w1xVlut+g3cx+uKRyaiDgM6Uy0uLwMy0yLt6VPJeXSsUuIHeBFk2Lj0xKmfi1E6X
         UpUwbS87bUj4ncJzDWQEIUObm0ToRVGioICxTdMqg90wyQNksB0V+ndD3yxDu6OGTi6X
         V5DKkZiG+qLNGHLsB3F44BjDnl6VxvRV/LqWh5wLfCKQHU2rKrLbRBkB1RNUFsa1PNuK
         PboecoBTuu/0GjI6/k+RC7AG49vT7BSjotEUAR2GFMvSPy2lOHiSLdseNrewTB/NFFaD
         fYqXa+ePNELNoPY3l7izU6e76j7hHTDiDy1hhhv+rusgkoDbwmYAJiEzvP1VaRqKlLMS
         Y6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqXNcJKGEk90R2legdFOv2JapBqj5ImP7hXsUpdTZn8=;
        b=VElwWhNIieAC8YFNwKuMaPFGEF/oWLiNEjVRwEyohDGnvpLmBrBTF7cHGKKXP9XyIx
         v7Cp95isaNw1IF3XbvKqAEO7e+2mBNoqVsYOqKfAGODQt9w6kFn5In16rtOfKBNMe2BV
         jDw//ufh4Ip6vfrp483UnaNAYSlpnA97hF0aoWOrgwznSwAiSUORpuqbBQt9Oe9wu0vh
         QHSNBco+JY+RrOMDHY4Uy47LUBX2B4l+cLAkE6z0Uz741Odg5MXBJrugTszqkChXFbIf
         UIkxWf7zhgC9rzv28vGfpxWyCUUqKMfppeZkM59tzQX2T4O027O4oOhuDjbr5ngvL+Gz
         daEA==
X-Gm-Message-State: ANoB5pnqgPWHDqU9DzSLFgNBKTqJF2bZzhWB6mZF7dQDuRa+3x2whtLp
        MNe9A6SeCSAt30lYP1yEk6MhSQ==
X-Google-Smtp-Source: AA0mqf6SP7JQdGyyqDOZ6gBL0qEJ+oVzm11ooMlDI/kxn7uldpXQH3s82B0YuJjy2P6KVsdar0/6qg==
X-Received: by 2002:adf:db81:0:b0:236:5144:f8ce with SMTP id u1-20020adfdb81000000b002365144f8cemr830227wri.657.1668675743980;
        Thu, 17 Nov 2022 01:02:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b? ([2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c465100b003cf483ee8e0sm4364699wmo.24.2022.11.17.01.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:02:23 -0800 (PST)
Message-ID: <befebc6e-dfd2-9a54-bf60-9dfd098e842d@linaro.org>
Date:   Thu, 17 Nov 2022 10:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: adsp: document sm8550
 adsp, cdsp & mpss compatible
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v1-1-104c34cb3b91@linaro.org>
 <b6eac577-f3a7-d1a4-f492-74782c2e5ff1@linaro.org>
 <20221116233907.GA1227164-robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20221116233907.GA1227164-robh@kernel.org>
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

On 17/11/2022 00:39, Rob Herring wrote:
> On Wed, Nov 16, 2022 at 01:28:11PM +0100, Krzysztof Kozlowski wrote:
>> On 16/11/2022 11:20, Neil Armstrong wrote:
>>> This documents the compatible for the component used to boot the
>>> aDSP, cDSP and MPSS on the SM8550 SoC.
>>>
>>> The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
>>> firmware to be passed along the main Firmware, and the cDSP a new power
>>> domain named "NSP".
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 60 +++++++++++++++++++++-
>>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>>> index db9e0f0c2bea..678cb73f10de 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>>> @@ -55,6 +55,9 @@ properties:
>>>         - qcom,sm8450-cdsp-pas
>>>         - qcom,sm8450-mpss-pas
>>>         - qcom,sm8450-slpi-pas
>>> +      - qcom,sm8550-adsp-pas
>>> +      - qcom,sm8550-cdsp-pas
>>> +      - qcom,sm8550-mpss-pas
>>>   
>>>     reg:
>>>       maxItems: 1
>>> @@ -116,8 +119,13 @@ properties:
>>>       $ref: /schemas/types.yaml#/definitions/string
>>>       description: Firmware name for the Hexagon core
>>>   
>>> +  qcom,dtb-firmware-name:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: Devicetree Firmware name for the Hexagon core
>>
>> Not sure about this one.
>>
>> Rob,
>> Don't we want rather to have multiple items in firmware-name?
> 
> Yes, I think we already have that for some users. Should have been
> 'firmware-names' I guess but I don't think it's worth dealing with
> another case of handling both (forever).

I'll be happy to switch to a single property but yeah, firmware-name isn't right
for multiple names...

Anyway, will follow qcom,sc7180-mss-pil.yaml since they already use 2 entries there.

Neil

> 
> Rob

