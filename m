Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6A707A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjERHJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjERHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:09:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20E9E66
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:09:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96aa0cab88dso268504466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684393754; x=1686985754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaDmiGsy9nFlZUj/9Pg4tvEnC4K0/WQOgXIhBgkiyU0=;
        b=R72HReIgiYADEeYmxfpQFpCU1UTit0oYnH6DFPeGVTPKxzAYdwvbmqgv0xCa6T4nOU
         mLblWKNsTicxJPfQq3w5ZcaJ7CGRFf2DnBU0db3+G4S38gzMmiOggM0TV9og8nJTuqXK
         yAO/0OgfaYNgbufKucg2K4hQ+uyH5969msY/sV0QEvF+67eIcJuTDuHl8w+lAZzTCdjA
         0ZQFsiAj+H5vp0HaUgb8eyPj3gVyz+9wYK2k+PmPA44sajiREUyA2bdmJJpOClW3POIP
         2P0BmIvSijO19a5xgErUe6S68mH57R9+8KFOF7rMcEBRXkXl9Jd3ce/VOobYrHwAHEP3
         ybdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684393754; x=1686985754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaDmiGsy9nFlZUj/9Pg4tvEnC4K0/WQOgXIhBgkiyU0=;
        b=dpM9o5PFKybPD/tOvnJhgVLs0OOTEh+H4ZqzMZVhlDViH4Noim5Y8jQ/H+zkCQVZKB
         ZbaEuse+34ATsjDc5m+ziwX6WTYbU31rXd9j9futyLKI1cHPYW1FaeTSknh9NX1IC8yq
         0uwV61axyhxIgZG6Zcz5RaIdxtnB9m64tDtQM/tNFmlx3rQGbI5L9wme+FO+2cpU7hD6
         8kDSibjtQimar5zs1cuPCx/jN21RzxQkSNlyZecD3rcJ2ZfheWQMlAVIJZUfftp/LjRR
         jb7si/oRTVYDStnVc8o8RV6hC5I/EAWhzMZV9akJA03OWl4A3qqrwGWq3OCvKdvUgv4X
         DsPg==
X-Gm-Message-State: AC+VfDymwyT1bZBYn/ImMaGCV19ZCMZqpTDOwRssJUzGQTL3y1JMMgEM
        qIwkOBi7KVQtYIfVRGOoTMLMzA==
X-Google-Smtp-Source: ACHHUZ5Lw12WrXqhgxKK+FvUFNZ0gO6pcYiS1IjQ6lp/KSs9CGPZregunjo7am5TsJVwvzCCZC6hJQ==
X-Received: by 2002:a17:906:fd8c:b0:94f:3cf5:6d7f with SMTP id xa12-20020a170906fd8c00b0094f3cf56d7fmr37246503ejb.46.1684393754126;
        Thu, 18 May 2023 00:09:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id m14-20020a170906258e00b0096f272206b3sm560992ejb.125.2023.05.18.00.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 00:09:13 -0700 (PDT)
Message-ID: <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
Date:   Thu, 18 May 2023 09:09:12 +0200
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
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230518054054.GA998@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 07:40, Varadarajan Narayanan wrote:
> On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
>> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
>>> Part-1 is adding the 'const' entries at the beginning i.e.
>>>
>>> 	+      - const: qcom,tsens-v0_1
>>> 	+      - const: qcom,tsens-v1
>>> 	+      - const: qcom,tsens-v2
>>> 	+      - const: qcom,ipq8074-tsens
>>>
>>> Part-2 is changing from one valid syntax to another i.e.
>>>
>>> 	+        items:
>>> 	+          - enum:
>>> 	+              - qcom,ipq9574-tsens
>>> 	+          - const: qcom,ipq8074-tsens
>>>
>>> Without both of the above changes, either or both of dtbs_check
>>> & dt_binding_check fails. So, it is not possible to just add the
>>> "valid hunk" (part-2) alone.
>>
>> Of course it is. All schema files work like that...
>>>
>>> If having both part-1 and part-2 in the same patch is not
>>> acceptable, shall I split them into two patches? Please let me know.
>>
>> No, hunk one is not justified.
> 
> For the other compatibles, the enum entries and const/fallback
> entries are different. For the 9574 & 8074 case, we want to have
> qcom,ipq8074-tsens as both enum and const/fallback entry. Hence,
> if we don't have the first hunk, dtbs_check fails for 8074
> related dtbs
> 
> 	ipq8074-hk01.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> 		['qcom,ipq8074-tsens'] is too short

Why? It is already there. Open the file and you will see that this is
already covered.

If you remove it, then yes, you will see errors and the answer is: do
not remove it.

> 
> 	ipq8074-hk10-c2.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> 		['qcom,ipq8074-tsens'] is too short
> 
> 	ipq8074-hk10-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> 		['qcom,ipq8074-tsens'] is too short
> 
> I'm not sure of the correct solution. Having the first hunk
> solves the above dtbs_check errors, so went with it. I'm able to
> avoid dtbs_check errors with just one entry in the first hunk.

You made multiple changes in one patch which is not correct. Your goal
is to add only one change - ipq9574 followed by ipq8074. Add this one.
Don't touch others.

> 
>  	+      - const: qcom,ipq8074-tsens
> 
> Please let me know if there is a better way to resolve this or we
> can have just the 8074 entry in the first hunk.

You only need to add new item on the oneOf list:
 - enum
     - ipq9574
 - const: ipq8074

Best regards,
Krzysztof

