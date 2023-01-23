Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD2678379
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjAWRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjAWRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:41:30 -0500
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C2F9EFB9;
        Mon, 23 Jan 2023 09:41:28 -0800 (PST)
Received: from [192.168.1.134] (2-248-191-197-no36.tbcn.telia.com [2.248.191.197])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 2D70B140428;
        Mon, 23 Jan 2023 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1674495686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHq6DB8MPeTL9CD1+RatQ6WKZTorJezP7W2joIZr5/8=;
        b=yaIpWvQzf6RHclGGr/C1Ida+Mrd/Qg0zUpyJjpjuGSoxRC2Pnwl41cfJuje2zCBgZZfsqy
        TiuPvkjG+hSHXtajCt2kLAowon99gUJQMLZ97XAKUIqoIKuPgRAaZ9OVeGrOdgI9zNUQgJ
        uW2gJQ3ObWBlqPZrQCmzx0XoRpbMYR0=
Message-ID: <7c69e654-fe57-ad5c-9b41-15aaeaa73102@postmarketos.org>
Date:   Mon, 23 Jan 2023 18:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add MSM8926 and Samsung
 Galaxy Tab 4 10.1 LTE
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        matti.lehtimaki@gmail.com
References: <20230122144749.87597-1-newbyte@postmarketos.org>
 <20230122144749.87597-3-newbyte@postmarketos.org>
 <f67b23e8-a476-7f8c-b692-e85ebbe669f5@linaro.org>
 <1481d44d-f84c-db12-d95d-75f367e973de@linaro.org>
From:   Stefan Hansson <newbyte@postmarketos.org>
In-Reply-To: <1481d44d-f84c-db12-d95d-75f367e973de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-23 18:11, Krzysztof Kozlowski wrote:
> On 23/01/2023 18:10, Krzysztof Kozlowski wrote:
>> On 22/01/2023 15:47, Stefan Hansson wrote:
>>> MSM8926 (also known as Snapdragon 400) is very similar to MSM8226 and
>>> APQ8026 with the primary difference being that it features an LTE modem
>>> unlike the former two which feature a 3G modem and a GPS-only modem,
>>> respectively.
>>>
>>> This also documents Samsung Galaxy Tab 4 10.1 LTE (samsung,matisselte)
>>> which is a tablet by Samsung based on the MSM8926 SoC.
>>>
>>> Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
>>> ---
>>>   Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 47913a8e3eea..7a0b2088ead9 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -35,6 +35,7 @@ description: |
>>>           mdm9615
>>>           msm8226
>>>           msm8916
>>> +        msm8926
>>>           msm8953
>>>           msm8956
>>>           msm8974
>>> @@ -219,6 +220,11 @@ properties:
>>>             - const: qcom,msm8916-v1-qrd/9-v1
>>>             - const: qcom,msm8916
>>>   
>>> +      - items:
>>> +          - enum:
>>> +              - samsung,matisselte
>>
>> 1. matisse is the code name, lte is version/suffix. I don't think they
>> should be together, because then it looks like "matisselte" is a name.
>> It actually sounds like one word.
> 
> Update: there is already matisse-wifi, so please follow the same naming
> convention. Version suffix should be separated with hyphen.
> 

I'm aware, and I've been in contact with the matisse-wifi dts author who 
told me that he went with this name because you suggested it (he had 
originally sent it in as matissewifi). However I don't think diverging 
from how the rest of the community refers to it is a good idea. 
Codenames often sound nonsensical, but they have effectively become the 
de-facto universal identifier for devices in the community and so I 
think retaining that consistency is more beneficial than making it sound 
nice.

Additionally, while matisse-wifi has the hyphen added before the suffix, 
many other Samsung devices do not (klte, jackpotlte, s3ve3g). As such, I 
think the name matisse-wifi is the outlier here rather than matisselte 
(but yes, I do understand that they are more related to each other than 
the other devices mentioned).

Does that sound sensible?

>>
>> 2. You base on other SoC but you do not include its compatibles. Why? Is
>> it intended? None of the properties applicable to other SoC will match
>> here, thus I actually wonder if you run dtbs_check...

Sorry, I forgot about running dtbs_check. However, I'm not sure I 
understand the question. What do you mean by that I don't include its 
compatibles?

I ran `$ make dtbs_check DT_SCHEMA_FILES=qcom.yaml` locally just now, 
and it only gave me errors from the qcom-msm8974pro-oneplus-bacon dtb. 
Maybe I'm running it wrong?

> 
> Best regards,
> Krzysztof
> 

Thanks for the review,
Stefan Hansson
