Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3168EA72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBHJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBHJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:03:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C30D1CAF9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:03:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r2so16002695wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNO05S5fEnwEDlCd8SuWqieT8IWig32rfB4rKatfeYc=;
        b=hLAzW13lNas29EFppeU3uJwQwbMAppolBPjP/eYCNXFn9n3qgX7/tA3rsGvUqxU/LW
         P+h7XLo4XNkWz1HXcIv38fDTieRLLtpfU1i9kn5i2HCy/NVTNKUXyVumPykpt3Jio0E3
         bTLbrPuK6SuFYJml2oYA4SQwEsNcg1+8T5zIZBO7zqBqN242mMzen/L0aJS2S18muj7a
         1DD+6inhDH9aPTnf93J4H0PIU1i2FKG1XStkprZNqksmB6xS5hQd8jZJQbrMLSiJSR+1
         17TO7ltTIKSZ6jFQpM+Su7EHi+yVi052v1L6HfUwPNpSFoyBZ3JYVgiXOwmoe3GwuP9e
         KDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNO05S5fEnwEDlCd8SuWqieT8IWig32rfB4rKatfeYc=;
        b=MEe95qCJJgZjVP2zDDF3rWt19FYypp0W+ZN8HjDBr8Z3vPub2u7Iqnd+eb9iwklw00
         ZEim6FlwKnJjP3qhX7MbaSLzF3Ns5b5thZiCKj6AWpB74eeFgByMP7yWfQUWFepuwGY/
         nkymq8ejIlZYjCX2jPWIE92JFIcARajvlc6yqUe9RO49CbGGLNRkBiFKTo0vKpZRwdSJ
         0EdGWL+ozyN8JoJ0/ps7yD/A0d9lermANJVhLmt7vx3MOLG7mGM9b1LcGpcEJFX1ick6
         0jk1DxMOISEqnou2B3QaUxFeb7304bIK0TEwyjrqi2Ci+GxuVvoMGYnDy4tR1CYujl/K
         Q3Sg==
X-Gm-Message-State: AO0yUKWotNldzNGFLe3vRLow8Tz2mRIBJ1kBt8qkIddXd7UR5MOMZZHj
        cDSjpok2vtTWH2U5GmBlt5wp6Q==
X-Google-Smtp-Source: AK7set9X29yi0PJgoLwkU0q/W2EkfbkArMiu+EWXYrori579HP9kPJrRrwpKBGSJHyDWPzuAGpb/rw==
X-Received: by 2002:a5d:6b89:0:b0:2bf:d940:29bb with SMTP id n9-20020a5d6b89000000b002bfd94029bbmr5808873wrx.6.1675846996763;
        Wed, 08 Feb 2023 01:03:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4d82000000b002c3ef7e74bdsm5257952wru.73.2023.02.08.01.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:03:16 -0800 (PST)
Message-ID: <eda179e1-4cd1-0d1b-4e27-2fe92e959cf2@linaro.org>
Date:   Wed, 8 Feb 2023 10:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam-dma: add optional memory
 interconnect properties
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
 <a188a52e-6327-f0ea-a54e-a23b88bca82f@linaro.org>
 <a8112f61-f8d3-c1e0-9549-a9036a7e7894@linaro.org>
 <88c31e71-55b6-a20d-1fcf-07804eace54b@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <88c31e71-55b6-a20d-1fcf-07804eace54b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 16:27, Dmitry Baryshkov wrote:
> On 07/02/2023 15:35, Neil Armstrong wrote:
>> On 07/02/2023 11:32, Dmitry Baryshkov wrote:
>>> On 07/02/2023 12:03, Neil Armstrong wrote:
>>>> Recents SoCs like the SM8450 or SM8550 requires memory interconnect
>>>> in order to have functional DMA.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>
>>> I suspect this will not work without a change for a driver.
>>>
>>
>> I had the impression single interconnect entries would be taken in account
>> by the platform core, but it doesn't seem to be the case, anyway I can;t 
>> find
>> any code doing that.
> 
> Probably you mixed interconnects and power-domains here.
> 

The driver change was submitted some time ago:
https://lore.kernel.org/all/20210505213731.538612-10-bhupesh.sharma@linaro.org/

There is already DTS user of it and we expect driver to be resubmitted
at some point.

What I don't really get is that crypto driver sets bandwidth for
interconnects, not the BAM. Why BAM needs interconnect? Usually you do
not need to initialize some middle paths. Getting the final interconnect
path (e.g. crypto-memory) is enough, because it includes everything in
between.

Maybe my review tag was a bit premature...

Best regards,
Krzysztof

