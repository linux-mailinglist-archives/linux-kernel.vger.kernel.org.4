Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60CC653FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiLVLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiLVLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:48:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037372A278
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:48:22 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g13so2352568lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVCRdiTbSjX2av+xZv+BZhudvMB52xvAnvKnjqYLwtI=;
        b=neyzDcMzrRlme9nTb9aFRxmG4XH6Wq/HLlBwDfyliA3EUnc71x6JEkiVUvxjvz9xva
         PSeeOI/d5nT/oJxic1y7j66cOCI51cEjFZGnvCE19Bv26qY0oZQOMOR6CkE2v5/0K+K0
         81ncLH3XAZ377wX4RbVT9KZNbP38anzoVC0zRkiq7DVxRJzcK/GQLYXe6If//wK4vKGn
         KauB/VLKTs4DSoLx+dx5VlAg7EnT+F3hqL3G+9J4ITpxlj4kiUytma0+mPRMlUJQSGFa
         zECgZAZfxc0RStMP8sbzA+Or+hfM4Xf4OTi+aqcX6aA9JlqSbG9hj4vEBW+fRNyUZ1P/
         KOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVCRdiTbSjX2av+xZv+BZhudvMB52xvAnvKnjqYLwtI=;
        b=ohrqzp2Z5FNBK5/mhlHXrZX8qqC+rrVdv454iXLO+nqiD2nmfhLN1IrWEJjvqJy8VD
         mOFUSn+pUsFUptalfwpGLAs3jr3b/IEu8rNuGMVPr20s21B1M2U4WwuKq1/dhdjvmZ3L
         wOSBCNrm0ITe1VmLyUt7hST+NYpb8KVkt8Fya6amDi9xCcU7nlncz3I3tYMeUZwLInJc
         OiLli2wNiTgS63J8d7j6pR0q1O5TD8ZMrR8cq2jQ7aDlbGFDj0Tll6zPh8Lp+44vMDnk
         aKOhQo3AS+YKhVQrT1+9PDnXTqkNH6hc3FLZeoNLSLUnwycBrD1siKoZB/e49sCy7KQ4
         iBRA==
X-Gm-Message-State: AFqh2kpGpVexWX3RiE1n8e6++/APCHuTcZdI+K4F4Ptzii0sTfTLQECt
        rJopac7v3yU+ihQZsglGb8m3eA==
X-Google-Smtp-Source: AMrXdXtX5DD1vsG47Vq+ym2gFuOKPYuvtXbBe41PUSZX9Q2fU9J9oRs2DwUEp7aURJKPeUocqleA2A==
X-Received: by 2002:ac2:4d87:0:b0:4c0:2d9e:f9d9 with SMTP id g7-20020ac24d87000000b004c02d9ef9d9mr1684900lfe.22.1671709700360;
        Thu, 22 Dec 2022 03:48:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c14-20020ac25f6e000000b004b5821219fbsm47643lfc.60.2022.12.22.03.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:48:19 -0800 (PST)
Message-ID: <00bcc651-3540-04b1-e0c0-d80335bf1bff@linaro.org>
Date:   Thu, 22 Dec 2022 12:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 04/21] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-5-bryan.odonoghue@linaro.org>
 <51770a1c-45f6-9f5a-871d-022cd78a0d4b@linaro.org>
In-Reply-To: <51770a1c-45f6-9f5a-871d-022cd78a0d4b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 12:47, Krzysztof Kozlowski wrote:
> On 20/12/2022 13:36, Bryan O'Donoghue wrote:
>> Currently we do not differentiate between the various users of the
>> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
>> compatible string but, the hardware does have some significant differences
>> in the number of clocks.
>>
>> To facilitate documenting the clocks add the following compatible strings
>>
>> - qcom,apq8064-dsi-ctrl
>> - qcom,msm8916-dsi-ctrl
>> - qcom,msm8953-dsi-ctrl
>> - qcom,msm8974-dsi-ctrl
>> - qcom,msm8996-dsi-ctrl
>> - qcom,msm8998-dsi-ctrl
>> - qcom,sc7180-dsi-ctrl
>> - qcom,sc7280-dsi-ctrl
>> - qcom,sdm660-dsi-ctrl
>> - qcom,sdm845-dsi-ctrl
>> - qcom,sm8250-dsi-ctrl
>>
>> Each SoC dtsi should declare "qcom,socname-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>  .../display/msm/dsi-controller-main.yaml      | 20 +++++++++++++++----
>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>> index 6e2fd6e9fa7f0..01afa9e9c4b3c 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>> @@ -14,9 +14,21 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - qcom,mdss-dsi-ctrl
>> -      - qcom,dsi-ctrl-6g-qcm2290
>> +    items:
>> +      - enum:
>> +          - qcom,apq8064-dsi-ctrl
>> +          - qcom,msm8916-dsi-ctrl
>> +          - qcom,msm8953-dsi-ctrl
>> +          - qcom,msm8974-dsi-ctrl
>> +          - qcom,msm8996-dsi-ctrl
>> +          - qcom,msm8998-dsi-ctrl
>> +          - qcom,dsi-ctrl-6g-qcm2290
>> +          - qcom,sc7180-dsi-ctrl
>> +          - qcom,sc7280-dsi-ctrl
>> +          - qcom,sdm660-dsi-ctrl
>> +          - qcom,sdm845-dsi-ctrl
>> +          - qcom,sm8250-dsi-ctrl
> 
> Usual comment: can we keep the list sorted?

Actually it is sorted, except the qcom,dsi-ctrl-6g-qcm2290. Please move
it after apq.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

