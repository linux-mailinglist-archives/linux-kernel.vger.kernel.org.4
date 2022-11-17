Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A562D4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiKQIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiKQIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:07:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1571F12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:06:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l14so2405216wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LbRTiKNw92Ee+1b4C3YYFV4rUTYbBfHXEQTVRGxB8K0=;
        b=YEUxhIvwNLSEyaevRqAqDbLFOcHB+hlOkXbIq4aS1RVO0zI5RZ3HWM+tUclgOH9JZ7
         kaS+ynCCLgCLoZec1AarloUM8RxUzaaGax3abu8IfAP/47NjR2qJJ6UYYMJ+3FvG4xNJ
         fsr2DBW3tJ7D2djf5OPf394Hi/EQHsHY265NMN17TwgrJ/6Zsv5ijivwz6mb2zp9iqVr
         GoMzcpxJCto9b3/qGFm27wcd2qXKbBHzMGAN/WGyUy11pOySgTVqKPIMfjzb6v3Ig86K
         rJ5OC5KrxD/P+c/5fSxhi/UOFdbeOZF9FmQLxT82EoL8gChlRCu6P5CgyAx8Tt7mMQBL
         49ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbRTiKNw92Ee+1b4C3YYFV4rUTYbBfHXEQTVRGxB8K0=;
        b=Yp9fUlae125RIgNqrWPZmV1CUyc5Npy091pIukdJG/IV1Of54JWKj0VnOcvDC32cFa
         oIpewnSde45fFid9b8DvtavmlxuqxV0tYbvnIxRWJnvb1rHcDNnnnKtCOUteOIuQkPBC
         mapPUOusP5TyJTjUDB/XkuR9vPbmW8a8AxS5pC99GT1yUeQrZExbI7UjpST+efFP96+V
         RM9rGytsRy5Y/04PXcHIzQWa7eHD9vWm1ul3EUhZFyYeubiUEr8yIW6Dxf6hTObE8ZWV
         PwkGbdUAoyVANoxkoyX9pRk1givaFUe7ZSgyfH5uepWf2YhyFYb7bGLyKV0HlnTImsw/
         eLpg==
X-Gm-Message-State: ANoB5pkCAN9gYiUb9v3OuwldIdX+J3GdZmX7i9cs34mOyCDy0gwOQIDd
        VgJOMui7jkgxXoldi+eWQZT/kA==
X-Google-Smtp-Source: AA0mqf4ZeAm5v63sFB1ue0O1rCuSr9Ker30/XMjXG0JEU1vGy71om73E8lAPBoWdhIOxA0I08OHCcw==
X-Received: by 2002:a5d:68c1:0:b0:236:8a38:4deb with SMTP id p1-20020a5d68c1000000b002368a384debmr694397wrw.487.1668672417764;
        Thu, 17 Nov 2022 00:06:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b? ([2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003cf774c31a0sm4414524wmh.16.2022.11.17.00.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:06:57 -0800 (PST)
Message-ID: <cb94a2f5-6521-19b5-ca30-c68ffd2068a4@linaro.org>
Date:   Thu, 17 Nov 2022 09:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Add compatible for
 sm8550
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
 <4dd96db7-b667-7b8f-f80d-a250ac63f223@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <4dd96db7-b667-7b8f-f80d-a250ac63f223@linaro.org>
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

Hi,

On 16/11/2022 12:26, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:09, Neil Armstrong wrote:
>> The Qualcomm SM8550 platform has three instances of the tsens block,
>> add a compatible for these instances.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> To: Andy Gross <agross@kernel.org>
>> To: Bjorn Andersson <andersson@kernel.org>
>> To: Konrad Dybcio <konrad.dybcio@somainline.org>
>> To: Amit Kucheria <amitk@kernel.org>
>> To: Thara Gopinath <thara.gopinath@gmail.com>
>> To: "Rafael J. Wysocki" <rafael@kernel.org>
>> To: Daniel Lezcano <daniel.lezcano@linaro.org>
>> To: Zhang Rui <rui.zhang@intel.com>
>> To: Rob Herring <robh+dt@kernel.org>
>> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-pm@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index f0bd4b979e28..09dbd96d380e 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -58,6 +58,7 @@ properties:
>>                 - qcom,sm8250-tsens
>>                 - qcom,sm8350-tsens
>>                 - qcom,sm8450-tsens
>> +              - qcom,sm8550-tsens
> 
> alOf:if:then should be updated.

I thought the -v2 fallback would be enough since 8450 isn't present either in the alOf:if:then either.

Anyway, will fix this.

Thanks,
Neil

> 
> Best regards,
> Krzysztof
> 

