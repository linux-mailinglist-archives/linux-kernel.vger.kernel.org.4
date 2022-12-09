Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A906484DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLIPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiLIPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:19:25 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46B8743F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:19:23 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id g14so1255535ljh.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUqxyT1clmDwn9Zro9D+5wDVpGHXxnFJou8ChYK956o=;
        b=yqUAlzbOfp2h1Yly7SCMDl7vy1sjcTlMrzPPb+6GWRQTgEXcGrspmSiRh2H4SLbbG8
         9czrZSSrhqK4PMyPoGfvZc1LPseUaujdwvVZXiyfusWWCiW+20KVIhwIUz/ahQuC6OCQ
         YDPRNPy43NFsyrZkX15D4QFKq66C5PLLN5sCk6dNP0CSk6uZgpmRoUuTcc+0vOrNtkAg
         5Mkt5N3WWwJnM2OS8KqmyWaJACoGGiBsOdzTi/sCQmC+ajR/Lwfu0pQyPjrmFVICmPet
         Cl1G5TvhwcGInk7WtWTX4OARn/hUCEHNOHVWzFPcosYnOsTikoO83MPNVH2Cbmfx11iH
         qrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUqxyT1clmDwn9Zro9D+5wDVpGHXxnFJou8ChYK956o=;
        b=GAwwjQv/9xExK370TFnHKoLQ0RUc5VxAZngVRQG0Yv0UuPn8kO2bSRVXZpIf7PYGiY
         8rupKip87n2PRoO+SvE6d2NxFzYw5MPF3Ezvae0+U+FYOQZJoyYxSnOuOka6GRL85yKQ
         BsjXEY3hVOlFxyW8FIApnyXC7RmDbmSxD30qItOSP1pIpv3WNIsryE/qeHj3Svq2qYoY
         ZU4os2R7SkFwdzeBB3VTqBkTeBfm/DQuE/0Leb+KMepXxxnaWxNDbbHrvcKpFXyBUIg9
         bC/ksJpFaphsk5TYtp5MObBKrrO5g5ul3nR/RZNNFLG/eY6Y/U2Wjq/iQMzgEyU0lgA7
         XAlw==
X-Gm-Message-State: ANoB5pkfKkBPgg7hK0RSEltU0BFX/nUlvFFXaOgFjEBweIti92Og9MsY
        unDA2hTDi06f9SO5CCFDqrnywA==
X-Google-Smtp-Source: AA0mqf5f+iC1ajxI4MGe81943QW3HpslBZxD7S2QCV9T0YkIU4JpfAS0eNCTgGjB9xg7Zn00OIexUA==
X-Received: by 2002:a05:651c:2118:b0:277:4c69:ee28 with SMTP id a24-20020a05651c211800b002774c69ee28mr3382419ljq.50.1670599162296;
        Fri, 09 Dec 2022 07:19:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p20-20020a2eba14000000b002770566d642sm253305lja.17.2022.12.09.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 07:19:21 -0800 (PST)
Message-ID: <a527720e-d4d9-6c90-f991-a5b123c4559b@linaro.org>
Date:   Fri, 9 Dec 2022 16:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <24fa41d2-87d1-be19-af44-337784b0f0a4@linaro.org>
 <COXDTKRPPU1J.373YHYKBQIN38@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <COXDTKRPPU1J.373YHYKBQIN38@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 16:11, Luca Weiss wrote:
> On Fri Dec 9, 2022 at 4:05 PM CET, Krzysztof Kozlowski wrote:
>> On 09/12/2022 15:29, Luca Weiss wrote:
>>> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
>>> in the bindings so the existing dts can validate successfully.
>>>
>>> Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
>>> sm8450: add Inline Crypto Engine registers and clock") so move the
>>> compatible to the correct if.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>> (no cover subject)
>>>
>>> The only remaining validation issues I see is the following on sc8280xp-crd.dtb
>>> and sa8540p-ride.dtb:
>>>
>>>   Unevaluated properties are not allowed ('required-opps', 'dma-coherent' were unexpected)
>>>
>>> Maybe someone who knows something about this can handle this?
>>>
>>> And the patch adding qcom,sm6115-ufshc hasn't been applied yet.
>>> ---
>>>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> index f2d6298d926c..58a2fb2c83c3 100644
>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> @@ -102,7 +102,6 @@ allOf:
>>>                - qcom,sc8280xp-ufshc
>>>                - qcom,sm8250-ufshc
>>>                - qcom,sm8350-ufshc
>>> -              - qcom,sm8450-ufshc
>>>      then:
>>>        properties:
>>>          clocks:
>>> @@ -130,6 +129,7 @@ allOf:
>>>                - qcom,sdm845-ufshc
>>>                - qcom,sm6350-ufshc
>>>                - qcom,sm8150-ufshc
>>> +              - qcom,sm8450-ufshc
>>>      then:
>>>        properties:
>>>          clocks:
>>> @@ -149,6 +149,12 @@ allOf:
>>>          reg:
>>>            minItems: 2
>>>            maxItems: 2
>>> +        reg-names:
>>
>> There are no reg-names in top-level, so it's surprising to see its
>> customized here. It seems no one ever documented that usage...
> 
> From what I can tell, from driver side all devices not using ICE don't
> need reg-names, only the "ice" reg is referenced by name in the driver.
> 
> I didn't add it top-level because with only one reg I think we're not
> supposed to use reg-names, right?

And you still won't need to use. Yet property should be rather described
in top-level which also will unify the items here (so no different
2-item reg-names in variants).

Just add it to top-level with minItems: 1 and per variant customize:
1. maxItems: 1
2. minItems: 2 + required

The "required" is a bit questionable... this was never added by Eric to
the bindings. Driver support and DTS were added completely skipping
bindings...

Best regards,
Krzysztof

