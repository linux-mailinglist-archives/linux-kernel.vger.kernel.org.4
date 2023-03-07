Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF646ADA02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCGJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCGJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:16:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A25292B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:16:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s11so49509335edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yV24tnK9cnyPzbacWjSliZZMed6YdF4OudMR8kk8ppo=;
        b=yH9a2qzDZBDhJ0CfTaJ9KXbqMMM4/wOMfUo1FqnskAtuzQZSlvl1kudZ497aYuNam/
         QvjK0cT0tFlr8BDWjQEhfmhc1iCxTDrz0WB9R+tliWK8IQmp7g1xOKMMCwezidS2Mk1o
         g4w3cAAPNM3X3tuM5hdGORLZFuzoPLUN8MJJkAtfpMu4qYiCN89YuajEVKIx8ZWU8MtU
         0gYZKYJyu/PWN5SxkxJtpqmvA+YCN6P3M9zhj3Vntqdw6YaBlMRCrdJRVVHkvFj/t2Dt
         g7NC8sLTSANitWx+tNWC5gUyK7lzC1gv3O90yKsq1gGQaztL771BALmjGztArMt0xaEQ
         wdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV24tnK9cnyPzbacWjSliZZMed6YdF4OudMR8kk8ppo=;
        b=7wQbw04lCr012mCO8CPGoqXqQnMrXrzNVES2D/nRHrelB21JFkSLEGnwQFjMKcYKo6
         fBJLEpOrCzmUE1ZpJqLhAT/XVxYQ0iWcqOAxC2FACXwSV+b9c9p+NuTQ0XhhsCMb7Pqn
         rkzXzS4L1oKvmXMnzjgHXJTTW9YZ72FVPO0ip5b3RJk6FnA9yfGZPkolgiQLkoKQQODi
         d4KDLt0lra5CLpn6J3g+L/cVdNlln2qSIwJLJMLecdgGf1k1pVvzrM/rkgHVZ5XNshaE
         /zgMu/GOr9ajPgpMisxlXMlmXS/UdmQjIhlKZuopScXS9Q78qhFwaH3F2ETPVF8hlKxQ
         b44w==
X-Gm-Message-State: AO0yUKVVBx6QiixBplob+3Bi2b1G8ntNplK9diCPSosTwQpytROLaVgG
        WllWo5pFwlUrCB6tuUlpx18CfQ==
X-Google-Smtp-Source: AK7set/5IpkbYD1GA2/KmDTDjFB7vnpSTjf66uNF56xzvLTuwRLzp+tFB9oszzAXMniobHQSWmu+6Q==
X-Received: by 2002:a17:907:cc1c:b0:8b1:781d:f9a8 with SMTP id uo28-20020a170907cc1c00b008b1781df9a8mr11869787ejc.72.1678180562499;
        Tue, 07 Mar 2023 01:16:02 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id my22-20020a1709065a5600b008eabe71429bsm5794543ejc.63.2023.03.07.01.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:16:02 -0800 (PST)
Message-ID: <145066db-5723-6baa-237d-7c2b8fd476d9@linaro.org>
Date:   Tue, 7 Mar 2023 10:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] dt-bindings: display: msm: sm6115-mdss: Fix DSI
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
 <20230304-topic-dsi_fixup-v3-2-b8565944d0e6@linaro.org>
 <e105eff0-816e-b9e8-b47a-5c85731c9ba0@linaro.org>
 <4b8745d8-144f-fb82-3e54-5ce6bd3162e6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4b8745d8-144f-fb82-3e54-5ce6bd3162e6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 11:06, Konrad Dybcio wrote:
> 
> 
> On 6.03.2023 09:57, Krzysztof Kozlowski wrote:
>> On 04/03/2023 16:55, Konrad Dybcio wrote:
>>> Since the DSI autodetection is bound to work correctly on 6115 now,
>>> switch to using the correct per-SoC + generic fallback compatible
>>> combo.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>>> index 2491cb100b33..605b1f654d78 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
>>> @@ -40,7 +40,13 @@ patternProperties:
>>>      type: object
>>>      properties:
>>>        compatible:
>>> -        const: qcom,dsi-ctrl-6g-qcm2290
>>> +        oneOf:
>>> +          - items:
>>> +              - const: qcom,sm6115-dsi-ctrl
>>> +              - const: qcom,mdss-dsi-ctrl
>>
>> Does it actually work? You did not define qcom,sm6115-dsi-ctrl in
>> dsi-controller-main?
> Check the "Depends on" in the cover letter.
> 

Then it looks like it should be squashed with that patch. Why adding new
compatible in multiple steps?

Best regards,
Krzysztof

