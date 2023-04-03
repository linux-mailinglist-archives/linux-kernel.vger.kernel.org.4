Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E326D4279
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjDCKsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjDCKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:48:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF1C83D7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:48:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s20so9539494ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680518909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4n9yhzm1Rmk8D25FTiH0wOJ+GO4nCT0aVo2ehKd/0bI=;
        b=c0uJzu1LiPBut0N7W8zNzlAV9wmMrZZZpbLe/3ycBlOFIuMn0P5nX3QLN31VNxOVps
         ppMd6IWf3/FQ99ALwIPjufG53hlW0NOaO9kfCdzuagDp3o5/4+wANyp0vWasLbujmCmA
         PUvisxJBeLuctt5Y/FnhZ1VbuudXDFYUEwRKj0D1wkz/T09+BkHogFOcvQ7ErrrcDrY2
         v4SjUKlP9XTkcXhdPM1OlC6kXUqiP4jNSbb+TP4rZOeqN9z12ks8VP3Wa80F83Hbe3zC
         cTXQhrN5dRWJ7ox445WJftUWLlFDLHPraL+HlIrf9bVUvCGKNGbsMqUOPa6fhkHCjLSM
         f3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680518909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4n9yhzm1Rmk8D25FTiH0wOJ+GO4nCT0aVo2ehKd/0bI=;
        b=QfBK5Lsl3sEyPjWNeNEqp+jSaekYu8zOd04IltgapbIZTVWydBouEtwssnhXyLgL3+
         l1kRLTHWtg55/DGtQLxuK7+Ldv7xGMFgh3w6vEmwqZpCZ+A9VeIqIUep4qk841bgGAXU
         urd3Ovwqrze8darORQuA95wcaCApYsmUihR1iDWXnz4HqjRmZW0e/C9pQpwem7P1x5oq
         L2MSNYe7/aMPKnApvIBEbv3XvskYmkFM1MZ1wA4qyezDtkGTwnp3wIZ2amYQzFRLjpbf
         RJ4amoQ4GOf2tacLvrJTy4XFyE9AFtv/db2e6xvlbYmSSKqADi7MqbJksmnZyI8DW11W
         WjPA==
X-Gm-Message-State: AAQBX9esSvsQ8//dc/OsIGRtTSt4gqwvgk7OySOUa39ODX4R+nd4MPwg
        ywO4E5OUM5DN3PSSNOGa4BP6dw==
X-Google-Smtp-Source: AKy350b9py/sij6PkWPceiL0IU5yAJ5hg6zA+et/1jOZ9VZhnEZINtiQQwxVTa7ptGeT1rQVEva9GQ==
X-Received: by 2002:a2e:b043:0:b0:295:c491:3b16 with SMTP id d3-20020a2eb043000000b00295c4913b16mr4737035ljl.7.1680518909142;
        Mon, 03 Apr 2023 03:48:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id g25-20020a2e9cd9000000b00298a8527806sm1688302ljj.93.2023.04.03.03.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:48:28 -0700 (PDT)
Message-ID: <463a9885-741e-a44a-c6c2-7cf5b0560d2d@linaro.org>
Date:   Mon, 3 Apr 2023 12:48:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 05/11] dt-bindings: qcom-qce: Fix compatible
 combinations for SM8150 and IPQ4019 SoCs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
 <20230402100509.1154220-6-bhupesh.sharma@linaro.org>
 <21eaeea4-4f2e-5ce5-c75b-d74ded8e6e4c@linaro.org>
 <CAH=2NtzKGxzmCq2JTajxWoeRFR+mPnFY3YF5mn0tGt30T7SJoQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtzKGxzmCq2JTajxWoeRFR+mPnFY3YF5mn0tGt30T7SJoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 08:15, Bhupesh Sharma wrote:
> On Mon, 3 Apr 2023 at 11:06, Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org> wrote:
>>
>> On 4/2/23 13:05, Bhupesh Sharma wrote:
>>> Currently the compatible list available in 'qce' dt-bindings does not
>>> support SM8150 and IPQ4019 SoCs directly which may lead to potential
>>> 'dtbs_check' error(s).
>>>
>>> Fix the same.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>   Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>> index e375bd981300..90ddf98a6df9 100644
>>> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>> @@ -24,6 +24,12 @@ properties:
>>>           deprecated: true
>>>           description: Kept only for ABI backward compatibility
>>>
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,ipq4019-qce
>>> +              - qcom,sm8150-qce
>>> +          - const: qcom,qce
>>> +
>>>         - items:
>>>             - enum:
>>>                 - qcom,ipq6018-qce
>>
>> Two commit tags given for v2 are missing.
> 
> Cannot get your comment. Please be more descriptive.

https://lore.kernel.org/linux-arm-msm/333081a2-6b31-3fca-1a95-4273b5a46fb7@linaro.org/

Konrad
> 
> Thanks,
> Bhupesh
