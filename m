Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A771A2AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjFAP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjFAP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:28:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219871722
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:27:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so1595655a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685633243; x=1688225243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=diFbsdZV2bNyGNHCVW2LsRJs05sLUshqi74Gn2Boo7g=;
        b=u07uR3oga0LW8RARkWrzk6zEKBC4+QlgbedEutna1tZnh5VL90CbXFUpDt5W/Vvq7J
         SMbFyUiFBVxxIO7EsteZp48OtJ3d8cvmroQolz4wLP3k7+//vvIYnojUlnN7rC3/xElz
         RNdL+axV0Hj+xRV7lKq06aXo7FMdh6luL5eiNEsy+7PK60JwLQS3YVUh7UfnEPbkLAK7
         IjKChpes5vMGLhmwIbLsT8z7wTs/p1J+uMPfPH69RzDCpRCr+yEPnq0Oi7xyBxsolbY1
         qgwEs3MWqCvwfdY4vdCgXjpGS1cf0lymOOdG11R5/YAczEthV/Kq/sPXP+UL2ruosfie
         1eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633243; x=1688225243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diFbsdZV2bNyGNHCVW2LsRJs05sLUshqi74Gn2Boo7g=;
        b=aTo6CABL9zLF9Vt1sG8aogbT0uMVbbOMOm9d/O6XIby9AtGt5LfI/RwbKBnrpr1chz
         H64TKV+CcMV0FsuiSojzOnNOZ8rJUrf+lZyMCZFyDRAvdRQKNmzKSNpJ+/NLJHy2Mmbq
         d46CNuO++oC0h/iwH8IBKEbfYQf4BaD1eq1g4CU11ZZoC+RC+2u13vKi0R8o9rSMUFP/
         8vNjia9BH6r39d5wMvagajTWZmP1wwL9zzUQtq2yPNwlVVxtCYdKTWGTCArhq9DEGb90
         ZadyQ/NaTl3N4vU2UE45FGzxP6zkD+gJex+3yViq/iDmO3uJ4fh02PPbPzsCP40eTakm
         iYKQ==
X-Gm-Message-State: AC+VfDxA8nq/9vclNRkYVq24Rb79X85B7rLevtAIqWC0IRCyRuAy0RPl
        MpNqBTQsYaE6fIIqRwEQx2LpTg==
X-Google-Smtp-Source: ACHHUZ6aNXo+ri1QDqhXiTolmEsw5DZDKU2sR6eWV9FGSQBXUTBeQun4e6I97sKz0YhBvlqq1csNzA==
X-Received: by 2002:a05:6402:1219:b0:514:994c:2982 with SMTP id c25-20020a056402121900b00514994c2982mr127674edw.40.1685633243229;
        Thu, 01 Jun 2023 08:27:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id k12-20020a056402048c00b00514c4350243sm2263947edv.56.2023.06.01.08.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:27:22 -0700 (PDT)
Message-ID: <3613f6ed-f8ad-a62c-6c0d-932bca7956dd@linaro.org>
Date:   Thu, 1 Jun 2023 17:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/15] arm64: dts: qcom: sc8180x: Add interconnects and
 lmh
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-8-vkoul@kernel.org>
 <7d4089df-e572-4d3b-6fb7-061d69479dce@linaro.org> <ZHhF7zbPYyqdfURV@matsya>
 <20230601132717.yslaigqg4lprkniv@ripper>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601132717.yslaigqg4lprkniv@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 15:27, Bjorn Andersson wrote:
> On Thu, Jun 01, 2023 at 12:47:03PM +0530, Vinod Koul wrote:
>> On 31-05-23, 10:26, Krzysztof Kozlowski wrote:
>>> On 30/05/2023 18:24, Vinod Koul wrote:
>>>> This add interconnect nodes and add LMH to sc8180x SoC dtsi
>>>>
>>>> Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>> ---
>>>
>>> I don't understand why this was split. We talked on IRC many times on
>>> this - artificial splits are not "release early, release often". Your
>>> previous patchset was correct in that approach, but why this is separate
>>> patch?
>>
>> Coz the patch was big to review. This is usual Linux approach to break a
>> change into smaller chunks for review!
>>
> 
> We break patches into small, logical units so that it's easy to follow
> the thought through each step in the process of introducing a change.

For example splitting interconnects which are essential part of several
IP blocks is not making it easy. One patch introduces incomplete block
which is then fixed (completed) in next patch.

> 
> This is not the same thing as splitting one logical change into multiple
> smaller patches to keep the line count of each patch down. This just
> forces the reviewer to jump between emails to get the full picture of
> the logical change.

Reviewer has to jump here to see full picture of UART or some other IP
block.

Best regards,
Krzysztof

