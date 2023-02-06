Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9243968BD08
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBFMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBFMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:37:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44F20054
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:36:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2337634wmp.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e1/W4vRspGFqPKyfZ9iLWstpJUiKCT/PotldFbMIbXE=;
        b=YpnQj+Qewd739lMDk8Qj0AGFdVsu+mcPOF7zxKNf5Mu0W1wJpDEhdV70krq140dGs8
         xQAEq02J6OJvKh1zfvqxZCcstAdsb2OS+mwZTj9gjpQ0OBY8+j+7Bz3fjnw7vj7iCc3K
         sSv1ESPOhOTx1A4ixr3Mj3GvfYbJTiiSXv+STuEfl5qfC1D792LBeleX+IsdT5A+WarZ
         rMviQdHyMMd58wSkcdRXurpJVAwF4HUu3+s+X+hC8so7QFqHaISxIUxw/HEsUA43BEqE
         h33LFR+MtNGlHwoEJhanuEP+2jy1LhiO/8St7QXD3TrppBL+vz2AYtUZguhrDKkL1ovn
         JAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1/W4vRspGFqPKyfZ9iLWstpJUiKCT/PotldFbMIbXE=;
        b=u4gmjEOoR7EIN9a48Upt2DQ7WyI5/ivnTOyCrq2bpQiVdVR4GPM08kv+7DDoIzi6yH
         L1vJdkQukE4NhzQGLeiUfwnenxOuMtFD54mPKiYSJ8GhFjCPx7hFeUwsEaBGlM2Ghyni
         Gjg0c0+tWeGNa2IGswf24yiSSw7Esl72SPYY18kKZ474/OQ7grgPC4NR5fIoi08xYKGM
         ZjOIOETRPTwO43GP6UtjV8GndXTghaEjQPpS2h1dVtieguIzImTUq6lZdy6yQqjok8Xt
         CuRuaTey5QpDBrJI0iNvEamKy/FhqlF4410fV5rtE2huJyMycpyRmZ6zZDNX1H/M8jqP
         k1cQ==
X-Gm-Message-State: AO0yUKUotaR4TgZMJ83NCOS67xQ7wAoJEulO7oCjxFFJEtW/41VkXvyV
        sCOc55+Yk6p2q0kdp6woWU3+/g==
X-Google-Smtp-Source: AK7set9fB0Ww3UvqTSLoPFgsNKMOmP1EKVTidKJRXRsxAwbBRtkjfrHPrMf9DpUSFF3AM0gXH+e+TQ==
X-Received: by 2002:a05:600c:1e89:b0:3dc:5b48:ee5 with SMTP id be9-20020a05600c1e8900b003dc5b480ee5mr19017077wmb.2.1675687017918;
        Mon, 06 Feb 2023 04:36:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f03f:3ced:a369:d884? ([2a01:e0a:982:cbb0:f03f:3ced:a369:d884])
        by smtp.gmail.com with ESMTPSA id bj24-20020a0560001e1800b002bded7da2b8sm8864067wrb.102.2023.02.06.04.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:36:57 -0800 (PST)
Message-ID: <56e3816e-c317-1772-1ef3-aeaa9ef0c890@linaro.org>
Date:   Mon, 6 Feb 2023 13:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v1-1-f1345872ed19@linaro.org>
 <f1665a8f-5b5b-7d98-a94e-d1b1df04afdf@linaro.org>
 <a2ad7b78-d848-df9d-2646-476cb306c505@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <a2ad7b78-d848-df9d-2646-476cb306c505@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 12:20, Dmitry Baryshkov wrote:
> On 06/02/2023 12:33, Krzysztof Kozlowski wrote:
>> On 06/02/2023 11:17, Neil Armstrong wrote:
>>> The SM8450 & SM350 shares the same DT TX IP version, use the
>>> SM8350 compatible as fallback for SM8450.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> index 0e8d8df686dc..98bae326e655 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> @@ -25,6 +25,10 @@ properties:
>>>         - qcom,sc8280xp-edp
>>>         - qcom,sdm845-dp
>>>         - qcom,sm8350-dp
>>> +      - items:
>>> +          - enum:
>>> +            - qcom,sm8450-dp
>>
>> Indentation looks wrong here. Testing should fail, did you test it?
> 
> Moreover it also breaks dt-schema, see https://github.com/devicetree-org/dt-schema/issues/98

Yep the change totally broke on rebase, will fix it

Sorry for the noise.

Neil

> 
>>
>> Best regards,
>> Krzysztof
>>
> 

