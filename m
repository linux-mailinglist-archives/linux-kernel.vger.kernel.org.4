Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EE692226
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjBJP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjBJP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:27:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDAE21A22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:27:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a2so5425844wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=50MoIhCEIkq2smH2by5xf6qHzOKdP64t5+k86HeXIRI=;
        b=xd5Rmfc5lR/A0yqaZCoE9Hwq9xvFwo7XdGp/8YqMcZOQl1QkLda9/1cL/MWhOewLR/
         +/U1hrkTUH2YywHjQXFjJiqNwc10ywr4EfIDI463dXGcPgCcwGcxnIayE+CuMu9EHT8I
         91QCdT6Ehgkc08ZRAA85mj4pJTHzavCaLsaARtleFszR9zZdkcHiJ9Jxia5r4iluX7GL
         uUNk/DpQGQ5sraBobpM7JuplXP4r/mm3tu1D3dUHZjWU5ETbK7+IXnCXPDDTil9Mb2GF
         4jCleadiUAmbddU9hinmGtPk+mwb6bLuPnk7iQqdSD2r4CV/NCmkt5JIoSbrxZZrpX7g
         X9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50MoIhCEIkq2smH2by5xf6qHzOKdP64t5+k86HeXIRI=;
        b=qGzkZLoTmCY4GhtNslg0Vl56EaJePfAO0yNVaqq1UOLdkeNmDcOcrlXhw7MSDzcLcN
         Mbj8sN4A+riOSRJTrflVi9D1YyjKkMik3lj+dtpyXkIYSxm1akSULQ9RZH7A4XbDrqQV
         g8wV0+iq07NtEboSVGmXckMQWoIjHiO26Vvr1QKMrj+Oh7vMwcWiPaCVmUyDk7XtCMbm
         W1YxlSqDN0+kfhQO2Za1hHU8b+P/Xk3uD0dgF0qWvW4Vo/5mfqN2QETDG876SJWWYxLB
         dO+V3jIHOZxgEsDVYNaz8ityRkapz6fwRfXLN7TuQJT4NAIZ3jFYFWoC4cKH2LQam540
         GPew==
X-Gm-Message-State: AO0yUKVlIX+VsrAEL0PJca3Hb1Xe1KBosTDaiREx6EmBrkHpQnRPTzP5
        ppju+VAlNepDDfsvKuTVe4mg1w==
X-Google-Smtp-Source: AK7set+norwJvbZgKBFypu0GJjZ6+0i5N3o+RTz0XEcSsqTNaZmzGM7hocDlyfhhARaZjaSD3Rtn3Q==
X-Received: by 2002:a5d:5604:0:b0:2bf:ae11:c40c with SMTP id l4-20020a5d5604000000b002bfae11c40cmr15529986wrv.32.1676042851235;
        Fri, 10 Feb 2023 07:27:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a65:5553:55cf:3027? ([2a01:e0a:982:cbb0:5a65:5553:55cf:3027])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b002bfc0558ecdsm3811406wrp.113.2023.02.10.07.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:27:30 -0800 (PST)
Message-ID: <b16921bb-409e-3591-d5fb-69212ef4e192@linaro.org>
Date:   Fri, 10 Feb 2023 16:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v3-1-636ef9e99932@linaro.org>
 <226aeac5-d1b1-2a99-5c17-c26a8458c5ea@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <226aeac5-d1b1-2a99-5c17-c26a8458c5ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:16, Dmitry Baryshkov wrote:
> On 10/02/2023 16:44, Neil Armstrong wrote:
>> The SM8450 & SM350 shares the same DT TX IP version, use the
>> SM8350 compatible as fallback for SM8450.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++++---------
>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 0e8d8df686dc..f0c2237d5f82 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -15,16 +15,21 @@ description: |
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,sc7180-dp
>> -      - qcom,sc7280-dp
>> -      - qcom,sc7280-edp
>> -      - qcom,sc8180x-dp
>> -      - qcom,sc8180x-edp
>> -      - qcom,sc8280xp-dp
>> -      - qcom,sc8280xp-edp
>> -      - qcom,sdm845-dp
>> -      - qcom,sm8350-dp
>> +    oneOf:
>> +      - enum:
>> +          - qcom,sc7180-dp
>> +          - qcom,sc7280-dp
>> +          - qcom,sc7280-edp
>> +          - qcom,sc8180x-dp
>> +          - qcom,sc8180x-edp
>> +          - qcom,sc8280xp-dp
>> +          - qcom,sc8280xp-edp
>> +          - qcom,sdm845-dp
>> +          - qcom,sm8350-dp
>> +      - items:
>> +          - enum:
>> +              - qcom,sm8450-dp
>> +          - const: qcom,sm8350-dp
> 
> Neil, Krzysztof, I'm not convinced that this is worth all the troubles. I think it would be easier to have a flat list of compatibles and handle all the differences inside the driver. For example, for sdm845 we simply reused sc7180 config internally, while keeping separate compatible strings.

Sure, but the doc reports the SM8350, SM8450 and SM550 has the exact same IP version, isn't fallback for that cat ?

> 
>>     reg:
>>       minItems: 4
>>
> 

