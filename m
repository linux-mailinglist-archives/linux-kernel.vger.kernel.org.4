Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A1704ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEPKek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjEPKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:34:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40255B98
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:34:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so25350841a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684233231; x=1686825231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/s/b8eaU43q5xbDT+IsLyN9R6gUY2onB35bWiqiQfVQ=;
        b=FVMvEJiPqhOQXhjXOb99WFShalGrKAuerHvbyeTpR2Z4/BzvjQwkO24qDPKoKmbrQx
         0r71drMY3DWM54icVAz8ygeowkiUqGp2ztytda6/chM9Jj7Rk4eNvojd6B6ZlJ+NY2eJ
         +aZoKwBszbw1XcxpIYehiuWjrX4HVKlAPBr4mKYSRiZlJ9skj+V4NTwp9NAEoBTqiIy0
         ujCexKgDeDCm9MRQTCHrK2m5lsknNwbnSHNeeT6dXVmUGQEhiVEEHdJhRKFFddmu/e9t
         RTV4raAUnkEFd0ecqc7JdyyS8XOimQxxLSr1FNPHKultErO4MwnKis0eGOEhlm2a8FIe
         /fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684233231; x=1686825231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/s/b8eaU43q5xbDT+IsLyN9R6gUY2onB35bWiqiQfVQ=;
        b=Q+NN/dRa6mVPmVQoyJ6GEfNYbuuUQWCS0QvAnafsdx0jSsg7pHoF6T7cdvW++uQ+Kw
         2Mh3505gUApiH9T3OFnXPGWwUAOgkW9uYHVxbipbjlKjzo7flMJ/9h4lH83JTqfvAEIv
         AsNf13R4lmfjqRBbhIIeLzw462NQ+4EJuOdwopP4IrEt/AwEDz+bNLYDdaBmZ6UbMdja
         ENlKMbZJ6Rx/jWGFXryKp/iyekw7eRjDAt4F+i31Bh2FdAHMS1WZLBSDAoa4hlsPpfPs
         KkKVuNmNj6DY+zKG9NNq0hkI8j13Bur0YDLv7m0F0/jmWrxwwFABB2MAOzlp1cUl8OzG
         lkrw==
X-Gm-Message-State: AC+VfDwNq+VonpRbPvO1Iihjm4ohMO956jKMcu0sbvD09XkKlYwO0ZC0
        OnqIy7rvi4me4exosC/qfM454w==
X-Google-Smtp-Source: ACHHUZ4E3loLNCVYpl/4ZNNE0tRB5XJnXmJHiqEn+7ptHeyKvrhzAdzam7JlqLZxnX2qqTeB7gnauA==
X-Received: by 2002:a50:ed0b:0:b0:50b:d83b:9c61 with SMTP id j11-20020a50ed0b000000b0050bd83b9c61mr27778560eds.32.1684233230993;
        Tue, 16 May 2023 03:33:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7c695000000b0050bdd7fafd8sm8262403edq.29.2023.05.16.03.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:33:50 -0700 (PDT)
Message-ID: <3af2f676-66fb-1c10-372f-4fcf6f7d733e@linaro.org>
Date:   Tue, 16 May 2023 12:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/5] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230417125844.400782-1-brgl@bgdev.pl>
 <20230417125844.400782-5-brgl@bgdev.pl>
 <CAMRc=MeWEs7AoZSNWS9bZO=_12U5944VBq0ixrY2rx2h2=OOfw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMRc=MeWEs7AoZSNWS9bZO=_12U5944VBq0ixrY2rx2h2=OOfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 12:07, Bartosz Golaszewski wrote:
> On Mon, Apr 17, 2023 at 2:58 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> The GPU SMMU will require the clocks property to be set so put the
>> relevant compatible into the adreno if-then block.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index ba677d401e24..53bed0160be8 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -79,6 +79,7 @@ properties:
>>        - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
>>          items:
>>            - enum:
>> +              - qcom,sa8775p-smmu-500
>>                - qcom,sc7280-smmu-500
>>                - qcom,sm6115-smmu-500
>>                - qcom,sm6125-smmu-500
>> @@ -331,7 +332,9 @@ allOf:
>>        properties:
>>          compatible:
>>            contains:
>> -            const: qcom,sc7280-smmu-500
>> +            enum:
>> +              - qcom,sa8775p-smmu-500
>> +              - qcom,sc7280-smmu-500
>>      then:
>>        properties:
>>          clock-names:
>> @@ -413,7 +416,6 @@ allOf:
>>                - nvidia,smmu-500
>>                - qcom,qcm2290-smmu-500
>>                - qcom,qdu1000-smmu-500
>> -              - qcom,sa8775p-smmu-500
>>                - qcom,sc7180-smmu-500
>>                - qcom,sc8180x-smmu-500
>>                - qcom,sc8280xp-smmu-500
>> --
>> 2.37.2
>>
> 
> Gentle ping for a review and a pick up. The DT patches that use this
> schema are in next now so check_dtbs will now fail.

I assume this is not for me, as you got my tag in v2, which I repeated
in v3.

Best regards,
Krzysztof

