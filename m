Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235E774EC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjGKLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjGKLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:11:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD0E98
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:11:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9926623e367so713063866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689073883; x=1691665883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBeMyaJZD4pyXVkZYPhLUFEDw7XuCD7f9zoNO04m7xw=;
        b=DC+PGR+sn/WXP2E6T2mQ6M6QwuS4rRMGVqbLID8ZJtgCTlmf8AyrAde3VZDk1SPH2a
         AR+TRyN5Xx0A584jQnvXD1GP+h4gCvC1s4KNb6dkHotkwVjV4sHlFaRxabNBe6E2iKcM
         5HS7k3LyXuJvkKkMsoYmMXeu+bcWGLNzhOQ3wOHhlBCReYlbb6fyy4koUpL4RHZnuxS5
         xt/LZFzFZIfebptTJzD00IftLwcP+bpFXueDtr+zpjTgSsaPYo4VocOb0/hBfR5ShD/C
         1qFckDu8hnreQo1mKOuVEfbyxvRDvenkpsoJpsIXVtZc3rUI69tRd9pzTohqqQaUM4FW
         UCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689073883; x=1691665883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBeMyaJZD4pyXVkZYPhLUFEDw7XuCD7f9zoNO04m7xw=;
        b=aMvTpwDwjesUH1B4Sc+npfzmrT5T6nkAR4D2PXeq48OMUrtHMoLgQVl2JLoMqkY4T7
         aSj7rWnjVCF0vhHBiSF8CNRRiwj/MYr/FVVTjCvsIxcnazKncmqXcs3daCZqTEMIi9i9
         VxJx8xqt+h0ZIfhB9S2bu54VfstbZXnmZ+iPkcMQHcVUjNnR+O4/4e/reBDsmw8ixivq
         0jyMdF7Jsze5ivzNlYmqfwrzfl6tfrOJneyj5EsX6XmQMpA8f9wLvkZuiFRYCWMZDAYn
         mTEPs3L2D66dtxSJHNT/HBrTnVM3yKoMf4Yrh/Ct0Nif8Uv77lnRdOA4Zx2zmenPwar7
         hfVw==
X-Gm-Message-State: ABy/qLbV/E+ZMG2WmPtc2d/pmjsX62mpl07gR0EmVOcE2y4x49QqT7L4
        WOjfvWUk+geAHz5JFEdeq9hsGQ==
X-Google-Smtp-Source: APBJJlHMx4wR3FrQCBEhvQ5A5dzfeMjgRGWYIW9Av0NfOrQsWz7FgMy4TFnQUJ7jsqXST1VFmqF+Cw==
X-Received: by 2002:a17:906:212:b0:991:fd87:c6fd with SMTP id 18-20020a170906021200b00991fd87c6fdmr13272072ejd.23.1689073883230;
        Tue, 11 Jul 2023 04:11:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qh11-20020a170906ecab00b0098df7d0e09asm989247ejb.205.2023.07.11.04.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:11:22 -0700 (PDT)
Message-ID: <156fc5ad-d236-1399-8714-e8b79c231ad8@linaro.org>
Date:   Tue, 11 Jul 2023 13:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC ID
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_anusha@quicinc.com, quic_saahtoma@quicinc.com
References: <20230710105419.1228966-1-quic_kathirav@quicinc.com>
 <20230710105419.1228966-2-quic_kathirav@quicinc.com>
 <d752e5e0-3c34-02ad-6768-42eb2c66e582@linaro.org>
 <55e55042-5189-15cb-5b0f-4c7f321a4f61@linaro.org>
 <a3262be5-be66-661c-1feb-d663a057c2b2@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a3262be5-be66-661c-1feb-d663a057c2b2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 13:02, Kathiravan T wrote:
> 
> On 7/10/2023 5:40 PM, Konrad Dybcio wrote:
>> On 10.07.2023 13:37, Krzysztof Kozlowski wrote:
>>> On 10/07/2023 12:54, Kathiravan T wrote:
>>>> IPQ5019 SoC is not available in production. Lets drop it.
>>>>
>>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>>> ---
>>>>   include/dt-bindings/arm/qcom,ids.h | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>>>> index bcbe9ee2cdaf..179dd56b2d95 100644
>>>> --- a/include/dt-bindings/arm/qcom,ids.h
>>>> +++ b/include/dt-bindings/arm/qcom,ids.h
>>>> @@ -250,7 +250,6 @@
>>>>   #define QCOM_ID_QRU1000			539
>>>>   #define QCOM_ID_QDU1000			545
>>>>   #define QCOM_ID_QDU1010			587
>>>> -#define QCOM_ID_IPQ5019			569
>>> What about users of this binding? What's the impact on them? When did
>>> the SoC become obsolete and unsupported by Qualcomm? Remember that
>>> ceasing a production does not mean that magically all users of a product
>>> disappear...
>> This + from my experience, SOCID entries are set in stone and freed
>> indices are never reclaimed
> 
> 
> This SKU is planned but never productized. That's why I removed it.

If you mean this was never produced, then yes, it can be removed and
your commit msg should be a bit more precise about it.

Best regards,
Krzysztof

