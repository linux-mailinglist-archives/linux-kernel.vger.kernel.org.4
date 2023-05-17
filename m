Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94387069A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjEQNVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjEQNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:21:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F696596
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:20:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so7470241fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329648; x=1686921648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ehNOHVJkggrK0SaUOOYHiCX3C3ML4esA8k2eVqxZzM=;
        b=F3t89XAqk/FSUiDRzyyIK/kIC97g87ZS8MYUNGXMZk+4NeKTnoQVJXPczjD7AnCxlw
         rV+ucXtji6cNqKqYyF14BhraI7CMUJe1uh/H+CC22l+CV7e3fvmbWkwxQxqlKo6CimBm
         PeVOvJcYAi3MORTJsv0Z4NsOXt8zRkqwgdNk9P1N8xC39Id/xUlcLHRHJw/KSSD2GoWb
         sfw1N1f4EM0UBZFPA1tzX+hKzoRsoH0hOk2qwBR5TZubrGLktG2JtqOqeztCDe/g15gM
         iiLPfuO3QnrWPNYX6NWm+g6y5lVI+6un/kV5uxwxdRNXsvr41YN2nc+WDaVGlHpKH2H5
         I5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329648; x=1686921648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ehNOHVJkggrK0SaUOOYHiCX3C3ML4esA8k2eVqxZzM=;
        b=PaoIuc0nVsnGkxS7nNPbk8D1Tc7eiCX5Jl7f+4e0Zv74PKp1IYGQWEKWfTO+9VBlAS
         +zK/fpzKmzvmSoOq+M2xOCI+V+xe7SfpUeAxmBou2H9nnaCn6M+wWFtYAG+pGCVBNxbM
         U+BFw4FsPCT1NEBgYxVnwNJwp5G87cM9wAz3XNRP1jJ7J6CFGSRvfZuVQtlfurvQ9NvD
         3g09fQ365UDOO3lZ9MQuTdDTOdNw0T7hrSwRFFZ/Mm7hBTUVzbYMs++XZ2pvh66I7N33
         MiOfA2pGp4TkImUQcaWliVF5uMwtu8KyE86bKtZq87wDZQi6XY6BuR4Ibk6b1oynfidc
         OAKA==
X-Gm-Message-State: AC+VfDzR3EcstShtBnFJMXcUt0H2kTI+eg92u8mD3yCbbHSFiGzfSuY1
        nuGFCeU7CTZ3CcyDROOIFl+HFvZJmLYaTaf+D1g=
X-Google-Smtp-Source: ACHHUZ4AIKk3Qd6kcFbMXUNKWSBpviIi0noAmat4pgn9AB3daV4BPBvPch6e5LInHQgct3+4T7eA3g==
X-Received: by 2002:a05:651c:1031:b0:2ae:e214:482f with SMTP id w17-20020a05651c103100b002aee214482fmr3339752ljm.52.1684329647839;
        Wed, 17 May 2023 06:20:47 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c93:874f:be7b:fb6c:26f9:307c? ([2a00:f41:c93:874f:be7b:fb6c:26f9:307c])
        by smtp.gmail.com with ESMTPSA id h22-20020a2eb0f6000000b002ad8bccceb2sm4125619ljl.57.2023.05.17.06.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:20:47 -0700 (PDT)
Message-ID: <8c494c69-b92f-5eb0-0151-04d787b405c5@linaro.org>
Date:   Wed, 17 May 2023 15:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: cache: qcom,llcc: Fix SM8550 description
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
 <20230517-topic-kailua-llcc-v1-1-d57bd860c43e@linaro.org>
 <20230517054428.GH4868@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230517054428.GH4868@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 07:44, Manivannan Sadhasivam wrote:
> On Wed, May 17, 2023 at 04:18:49AM +0200, Konrad Dybcio wrote:
>> SM8550 (LLCCv4.1) has 4 register regions, this was not described
>> between its addition and the restructurization that happened in
>> the commit referenced in the fixes tag.
>>
>> Fix it.
>>
>> Fixes: 43aa006e074c ("dt-bindings: arm: msm: Fix register regions used for LLCC banks")
> 
> I'm not sure if the Fixes tag should point to the patch adding SM8550 support or
> the restructuring patch.
Right.. I wanted to add *some* fixes tag (clearly a bugfix)
and decided this one (and the one in patch 2) were the least bad
options, as the cleanup landed after/parallel to 8550 introduction.

Konrad
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> But the change LGTM!
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> - Mani
> 
>> ---
>>  Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
>> index d8b91944180a..44892aa589fd 100644
>> --- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
>> +++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
>> @@ -129,6 +129,7 @@ allOf:
>>                - qcom,sm8250-llcc
>>                - qcom,sm8350-llcc
>>                - qcom,sm8450-llcc
>> +              - qcom,sm8550-llcc
>>      then:
>>        properties:
>>          reg:
>>
>> -- 
>> 2.40.1
>>
> 
