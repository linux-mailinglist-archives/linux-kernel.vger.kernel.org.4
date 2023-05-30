Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99203715D24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjE3L0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjE3L0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:26:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84BBF0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:25:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96fd3a658eeso624127866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685445958; x=1688037958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yh8k+8Mg0f8oFwAT69U0IqHzyWcrLwSDiNojC7iPZXQ=;
        b=LEma82aW/l8N0SmfPHbX/QLW0R3p0hkoV4nIeGyB+5YVZAlj74jznYQm2BEOV1RJJj
         rgxvsy+LB+xa8IvaSHV0w+z4Iz8unG4TCGFH+a2Lis32aHnmwd8ToBRZAKPYpLHn6oxp
         Q2Q1JqDuNfLXDCuOHzKC2m9s9Ud4QIajuLDtH6HH93maX0E+K7WD3my9Miup9Nwbd2x1
         bNoyh8PXA9TByjCKiToByU3f+D5BeX3tumNsf39p/xDR7VDs37fqerDwxajZjjlUaC/k
         HPu3bDWuCtQQZ3oCRh8/H4DwWqziCzD4zGPv9fRtjH10L8fc2Tm21ITApuxBBPp2WaHN
         7d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445958; x=1688037958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yh8k+8Mg0f8oFwAT69U0IqHzyWcrLwSDiNojC7iPZXQ=;
        b=BRP6Hu6k1HM8RxOgTmOa0a6JYg+n2xr5uoKUt//X8/i2wVmQYSOq8XzLFXtxJpvK4n
         f9hHOd/dXlx6FtpUKdqeHFWy9CQlm7mpQNDItoIFa2nkMsvlFlFZNU66HE3xcd3VxDHf
         /QTG1NVwR1FFt3wH4A7Fu6SPzVKXMvgLusYAaBsd0TFLrBRz3bJkNJ6mPnfSkm+QUw/G
         TzwljWJ/CU3BXQXBfGIB905N5BpNtboSJqCpVfrZ4yWXoGcbL7l2I1+nM7p1wzTr3Lxq
         mt+Q1GZ2Nza3EIPV1JNMnX9RUiGbaKtUgQJZQxPshWNuSkNusBD+xuKf0GHsx/F5/+99
         qylg==
X-Gm-Message-State: AC+VfDxKOXM3dofcg0oc26nSH3B9+Yy+SB/ClNsuQztXV8l1pri/VAl2
        LnA+bldGUeKnVa61LgVPhLVIVA==
X-Google-Smtp-Source: ACHHUZ7O7+k0Cn3sF+q3JHVWscMw9ErYLsHc1zaXS47yHrfBrPVt49G8v5yG2yI7zg8xP97bXZXBKQ==
X-Received: by 2002:a17:907:9805:b0:96f:5902:8c4d with SMTP id ji5-20020a170907980500b0096f59028c4dmr2243915ejc.27.1685445958165;
        Tue, 30 May 2023 04:25:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id pg27-20020a170907205b00b009662d0e637esm7120846ejb.155.2023.05.30.04.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:25:57 -0700 (PDT)
Message-ID: <186d6df5-7982-5725-1f66-bef71b504df8@linaro.org>
Date:   Tue, 30 May 2023 13:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
 <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
 <20230518090503.GA9173@varda-linux.qualcomm.com>
 <24b60ca3-b6b9-662f-03c8-df1536b52bc9@linaro.org>
 <20230523101903.GA31656@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230523101903.GA31656@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 12:19, Varadarajan Narayanan wrote:
> On Thu, May 18, 2023 at 01:06:49PM +0200, Krzysztof Kozlowski wrote:
>> On 18/05/2023 11:05, Varadarajan Narayanan wrote:
>>> On Thu, May 18, 2023 at 09:09:12AM +0200, Krzysztof Kozlowski wrote:
>>>> On 18/05/2023 07:40, Varadarajan Narayanan wrote:
>>>>> On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
>>>>>>> Part-1 is adding the 'const' entries at the beginning i.e.
>>>>>>>
>>>>>>> 	+      - const: qcom,tsens-v0_1
>>>>>>> 	+      - const: qcom,tsens-v1
>>>>>>> 	+      - const: qcom,tsens-v2
>>>>>>> 	+      - const: qcom,ipq8074-tsens
>>>>>>>
>>>>>>> Part-2 is changing from one valid syntax to another i.e.
>>>>>>>
>>>>>>> 	+        items:
>>>>>>> 	+          - enum:
>>>>>>> 	+              - qcom,ipq9574-tsens
>>>>>>> 	+          - const: qcom,ipq8074-tsens
>>>>>>>
>>>>>>> Without both of the above changes, either or both of dtbs_check
>>>>>>> & dt_binding_check fails. So, it is not possible to just add the
>>>>>>> "valid hunk" (part-2) alone.
>>>>>>
>>>>>> Of course it is. All schema files work like that...
>>>>>>>
>>>>>>> If having both part-1 and part-2 in the same patch is not
>>>>>>> acceptable, shall I split them into two patches? Please let me know.
>>>>>>
>>>>>> No, hunk one is not justified.
>>>>>
>>>>> For the other compatibles, the enum entries and const/fallback
>>>>> entries are different. For the 9574 & 8074 case, we want to have
>>>>> qcom,ipq8074-tsens as both enum and const/fallback entry. Hence,
>>>>> if we don't have the first hunk, dtbs_check fails for 8074
>>>>> related dtbs
>>>>>
>>>>> 	ipq8074-hk01.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
>>>>> 		['qcom,ipq8074-tsens'] is too short
>>>>
>>>> Why? It is already there. Open the file and you will see that this is
>>>> already covered.
>>>
>>> I guess dtbs_check doesn't like the same value being a const and
>>> a oneof entry.
>>
>> I don't understand.
> 
>       - description: v2 of TSENS with combined interrupt
>         items:
>           - enum:
>               - qcom,ipq9574-tsens	<--- one of the compatible entries
>           - const: qcom,ipq8074-tsens	<--- fallback entry
> 
> In this patch, we want 8074 to act as a compatible entry for
> ipq8074*.dts and fallback entry for ipq9574.dtsi. That is why I
> believe we are not able to just add 9574 and get it to pass
> dtbs_check and dt_binding_check.

Nope, no other bindings have any problems with that. Fix your syntax as
I said.

> 
>>>  Have attached the file, please see if something is
>>> not in order.
>>
>> I don't know what changed there. Please work on patches.
>>
>>>
>>>> If you remove it, then yes, you will see errors and the answer is: do
>>>> not remove it.
>>>
>>> I haven't removed it.
>>
>> You did. Look:
>>
>>        - description: v2 of TSENS with combined interrupt
>> -        enum:
>> -          - qcom,ipq8074-tsens
>>
>> The first character in the diff (-) means removal.
> 
> It changed from 'enum' to 'const', that is why I said it is not
> removed.

You removed that hunk. Diff hunk. It does not matter that you added
similar one in different place. You removed this one. Don't.

> 
>>> For this patch, ipq8074-tsens changed from
>>> being an oneof enum entry to a const entry. Probably, that is why
>>> dtbs_check is giving these errors.
>>
>> You removed the entry which you should not have touched.
>>
>>>
>>>>> 	ipq8074-hk10-c2.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
>>>>> 		['qcom,ipq8074-tsens'] is too short
>>>>>
>>>>> 	ipq8074-hk10-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
>>>>> 		['qcom,ipq8074-tsens'] is too short
>>>>>
>>>>> I'm not sure of the correct solution. Having the first hunk
>>>>> solves the above dtbs_check errors, so went with it. I'm able to
>>>>> avoid dtbs_check errors with just one entry in the first hunk.
>>>>
>>>> You made multiple changes in one patch which is not correct. Your goal
>>>> is to add only one change - ipq9574 followed by ipq8074. Add this one.
>>>> Don't touch others.
>>>
>>> But that breaks dtbs_check.
>>
>> All other cases, hundreds of other binding files, do not have problem.
>> Only this one "breaks dtbs_check". No, it does not.
>>
>> Whatever is broken is result of your removal of unrelated pieces.
> 
> Not sure about other binding files. Probably they don't have the
> same value for fallback and normal compatible. If there is such
> an example binding file, will replicate that syntax/structure for
> ipq9574 too.

No. There are many examples of other bindings which do not have any
problems with it and what we talk here is common pattern. You created
some fake problem of wrong syntax and then fixed it with different
approach...

> 
> In the 'nvidia,tegra210-ope' example (https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L25)
> too 'nvidia,tegra210-ope' is listed twice
> 
>       - const: nvidia,tegra210-ope	<===
>       - items:
>           - enum:
>               - nvidia,tegra234-ope
>               - nvidia,tegra194-ope
>               - nvidia,tegra186-ope
>           - const: nvidia,tegra210-ope	<===
> 
>>>>>  	+      - const: qcom,ipq8074-tsens
>>>>>
>>>>> Please let me know if there is a better way to resolve this or we
>>>>> can have just the 8074 entry in the first hunk.
>>>>
>>>> You only need to add new item on the oneOf list:
>>>>  - enum
>>>>      - ipq9574
>>>>  - const: ipq8074
>>>
>>> The "['qcom,ipq8074-tsens'] is too short" errors were generated
>>> with the above snippet only. Please see the attachment
>>
>> It's not true. The error you see is result because you removed something
>> you should not. I did not ask you to remove anything. So repeating -
>> "add new item". Adding is not "removal and adding". Adding is just "adding".
> 
> See below for the changes that were tried and the corresponding errors.
> 
> (1) No lines removed
> 
> 	@@ -66,6 +66,7 @@
> 	       - description: v2 of TSENS with combined interrupt
> 		 enum:
> 		   - qcom,ipq8074-tsens
> 	+          - qcom,ipq9574-tsens

This does not make sense, right? Let's not discuss solutions which do
not make sense...

> 
> 	   reg:
> 	     items:
> 
> 	dt_binding_check: No errors
> 
> 	dtbs_check	:
> 		arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	        ['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long
> 
> (2) No lines removed
> 
> 	@@ -66,6 +66,8 @@
> 	       - description: v2 of TSENS with combined interrupt
> 		 enum:
> 		   - qcom,ipq8074-tsens
> 	+          - qcom,ipq9574-tsens
> 	+        - const: qcom,ipq8074-tsens

You change existing entry, which breaks it. Don't.

> 
> 	   reg:
> 	     items:
> 
> 	dt_binding_check: No errors
> 
> 	dtbs_check	: Gives errors for all the DTS files that have tsens-v0_1, tsens-v2, tsens-v1. Copy pasted a sample for each one of them
> 		arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8916-tsens', 'qcom,tsens-v0_1']
> 		arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8953-tsens', 'qcom,tsens-v2']
> 		arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8956-tsens', 'qcom,tsens-v1']
> 
> 
> (3) No lines removed
> 	@@ -19,6 +19,7 @@
> 	 properties:
> 	   compatible:
> 	     oneOf:
> 	+      - const: qcom,ipq8074-tsens
> 	       - description: msm8960 TSENS based
> 		 items:
> 		   - enum:
> 	@@ -66,6 +67,8 @@
> 	       - description: v2 of TSENS with combined interrupt
> 		 enum:
> 		   - qcom,ipq8074-tsens
> 	+          - qcom,ipq9574-tsens
> 	+        - const: qcom,ipq8074-tsens

Don't change existing entry.

> 
> 	   reg:
> 	     items:
> 
> 	dt_binding_check: Same as above
> 
> 	dtbs_check	: Same as above
> 
> (4) Change 8074 from enum to const
> 	@@ -19,6 +19,7 @@
> 	 properties:
> 	   compatible:
> 	     oneOf:
> 	+      - const: qcom,ipq8074-tsens
> 	       - description: msm8960 TSENS based
> 		 items:
> 		   - enum:
> 	@@ -64,8 +65,10 @@
> 		   - const: qcom,tsens-v2
> 
> 	       - description: v2 of TSENS with combined interrupt
> 	-        enum:
> 	-          - qcom,ipq8074-tsens
> 	+        items:
> 	+          - enum:
> 	+              - qcom,ipq9574-tsens
> 	+          - const: qcom,ipq8074-tsens

Don't touch existing entry. Third time.

> 
> 	   reg:
> 	     items:
> 
> 	dt_binding_check: No errors
> 
> 	dtbs_check	: No errors
> 
> But (4) doesn't seem acceptable. Any other alternative to resolve this?

Don't touch existing entry. Fourth time. Add a new one matching your
combination.


Best regards,
Krzysztof

