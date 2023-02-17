Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56E69AA84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBQLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBQLgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:36:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C13D0BB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:35:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v11so11852655edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gfzQNE//Aw16MMqvtyQfrzfyKuHmI2QnVNvYOB30K8=;
        b=Ks+DrvObHAy8xBoileh20VTLy9/tujYL5yZ32b2r4cA/Wz7wyIWKpyAdEBJdAdTElq
         30zz7uJvyeWphLMa7fakX2E0YuLJsgbkHAb59+DeZypbsM1ePFibx0crC7TtSZ0PzTbc
         uwyloIk6kXATLe+RxqexrEj4nQxdmXFt8iNduSuJ+z01z5CFtph9gjIxwCrAOz1cPqjI
         J7KeRpkAKRQdgeyuNJ+InQ40qS7LqSNaB/ejLsOiUcOFS4V/oiJk9uWbAOFo3+8uYT9K
         YNh0wd2wAHwjLI3jlqM6gsAbjXJMZAES0xC78C0oJjaICE38JHBKF49XiPplkuDFbULl
         k7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gfzQNE//Aw16MMqvtyQfrzfyKuHmI2QnVNvYOB30K8=;
        b=OWelxOZHnB0JpO/Er5ohGTrb1VMEmyLXFTSEzHGtU2XSF/UG71tLhjRy61H4PNKdhT
         WLeIXTF9l2b2pMrciOCOogTufEiZTDcozXlYfBKL1dGNCkNQ/3M1vznkyRnfu4Eiu9Ad
         GObjJ3I758TSfD7tDm1Pevn31AJvNwXgD3oiZJ2uLbblki0Zzp6gKs/QAsH8x33idpoI
         gdJ4/ZopGYlSuKemkvE+mohHjtqQ6vcV/e+7pnVH1Tq5gdapXOyxN8sIwwqMTf1YBrsD
         9UPVt/WjYhoePC6O5ncRUxSz0dw09DtEktEyU9or2Jcx7mLVZ8mXGd1fiGFIJnHUuf67
         CN0A==
X-Gm-Message-State: AO0yUKUoRdnlPk8ftDB+IiPobDSrNFJuXF941HvUDkwy0u4Pq3JS4Asf
        AXtOruNH94hcVZTeJ8OgtAYuwQ==
X-Google-Smtp-Source: AK7set/4gwWb+v2vMog72T1d8PFebKKhautfOWYnzVlOkHVf1+Fofuclt6aH2IIjB0OwptFOhuFXlg==
X-Received: by 2002:a17:906:e253:b0:8a9:e031:c4ae with SMTP id gq19-20020a170906e25300b008a9e031c4aemr9890960ejb.2.1676633757121;
        Fri, 17 Feb 2023 03:35:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ke20-20020a17090798f400b008b13f6d4fe4sm2005543ejc.81.2023.02.17.03.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:35:56 -0800 (PST)
Message-ID: <a158bca2-78bf-5b38-60fe-88118e8b4ad7@linaro.org>
Date:   Fri, 17 Feb 2023 12:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111316.306241-1-konrad.dybcio@linaro.org>
 <c49904be-d842-fc12-a443-17f229d53166@linaro.org>
 <a4eaccfd-34ba-15f3-033f-165b46c43317@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a4eaccfd-34ba-15f3-033f-165b46c43317@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 12:32, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 12:30, Krzysztof Kozlowski wrote:
>> On 17/02/2023 12:13, Konrad Dybcio wrote:
>>> SM6115 previously erroneously added just "qcom,dsi-ctrl-6g-qcm2290",
>>> without the generic fallback. Fix the deprecated binding to reflect
>>> that.
>>>
>>> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> Depends on (and should have been a part of):
>>>
>>> https://lore.kernel.org/linux-arm-msm/20230213121012.1768296-1-konrad.dybcio@linaro.org/
>>>
>>> v1 -> v2:
>>> New patch
>>>
>>>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml     | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>>> index 41cdb631d305..ee19d780dea8 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>>> @@ -37,7 +37,6 @@ properties:
>>>        - items:
>>
>> If this way stays, drop the items as it is just an enum.
>>
>>>            - enum:
>>>                - qcom,dsi-ctrl-6g-qcm2290
>>> -          - const: qcom,mdss-dsi-ctrl
>>
>> Wasn't then intention to deprecate both - qcm2290 and mdss - when used
>> alone?
> "qcom,dsi-ctrl-6g-qcm2290", "qcom,mdss-dsi-ctrl"
> 
> was never used. The only upstream usage of the 2290 compat
> is in sm6115.dtsi:
> 
> compatible = "qcom,dsi-ctrl-6g-qcm2290";
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/sm6115.dtsi?h=next-20230217#n1221

I meant, that original commit wanted to deprecate:
compatible="qcom,dsi-ctrl-6g-qcm2290";
compatible="qcom,mdss-dsi-ctrl";

Best regards,
Krzysztof

