Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B006199AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiKDOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiKDOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:25:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67A0121201
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:22:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z6so3102307qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXkBy+trkrWOlZtLqm564V0uy+2HFI4j+r/iT2yiLlc=;
        b=zfz7gY3ffcCXJoSi8A/p+vWnFFG5aWbXFVkzuNn6qn1MDG5pRi198QF8STFL3pBjno
         WHISlYOxF4aFifA4hca0kKu0dR6geffq5sL0Q2dC6MPJQfrdqB6D5uqVQocaYfvC6JnC
         yR+JJ2ywuWywBMUaYF60L4QM8TEk2ZynYXvZD/0N8u57VadeIAQJKlhgXzFp7t/UZdx2
         J4CJBHvKcSAztinASfwjJUnvjIZaqr3ixw1R0ty4gmJcMjXkplErwnVEKziqmL1U32rC
         zBNjv0a0YQv8UL0i1lL+a3Q6uUtW8/xX5G+j5ieKQh4YzlYlx3+WbXvScnU/yYS43dB9
         fOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXkBy+trkrWOlZtLqm564V0uy+2HFI4j+r/iT2yiLlc=;
        b=JI3rTWXEDVcTCfOZFF5tvrFLrM8GDMl8TIkCjddDg/YBXyi8DbNzF/h7xOSII6xK8C
         QI8v3GkACSbn2zSZ1HTrC5FQfOCPlPLjmBE5e3e/N9eAgzBp42dk5A/px/76XNiMJy+u
         /t4dRke8XQbSsiNADAcx/ZY6UabJHHWitvhlyCMTTfN3hlZLAJiB7BbIFDDWg/CuAV29
         gb19iGLG6mErpnElcHOW+GjRYZ+yi0/70bgxUWsDo/miWokiL4fhY4F8rLMxowYwFi12
         C/HXkt6vg5Bwvv0WRf+u5Clp8x9bRSTrIVww1NITe/RY2O4LhbEvL7z7ck05t1yXl8uz
         KY7g==
X-Gm-Message-State: ACrzQf3+rKpfpbMnIkAhwhQ8DdbPq3UHjqZbEH0ZU+KqZbYot6WVSn50
        5WwgViesMhIy+cnhfhl+F/Ik5w==
X-Google-Smtp-Source: AMsMyM4mKrG/+yKfPvy98FJW7XZQYfh2fWEMP+LsawnjU6qI2G2KveaM25XMxiaZUH0rwNID2x2n6Q==
X-Received: by 2002:ac8:584a:0:b0:39c:e0dd:1c9e with SMTP id h10-20020ac8584a000000b0039ce0dd1c9emr29427721qth.659.1667571773801;
        Fri, 04 Nov 2022 07:22:53 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id ez12-20020a05622a4c8c00b0039492d503cdsm2518835qtb.51.2022.11.04.07.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:22:53 -0700 (PDT)
Message-ID: <18f5bcaa-2a41-b2b0-44a2-273728c52cfb@linaro.org>
Date:   Fri, 4 Nov 2022 10:22:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
 <20221104133506.131316-3-angelogioacchino.delregno@collabora.com>
 <cf1a15c5-a16b-2d23-8f6c-b3892c141c34@linaro.org>
 <3af810a7-0490-da36-f263-e74cd3553c84@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3af810a7-0490-da36-f263-e74cd3553c84@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 10:18, AngeloGioacchino Del Regno wrote:
> Il 04/11/22 15:04, Krzysztof Kozlowski ha scritto:
>> On 04/11/2022 09:35, AngeloGioacchino Del Regno wrote:
>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>
>>> The Ramp Controller is used to program the sequence ID for pulse
>>> swallowing, enable sequence and linking sequence IDs for the CPU
>>> cores on some Qualcomm SoCs.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>> ---
>>>   drivers/soc/qcom/Kconfig           |   9 +
>>>   drivers/soc/qcom/Makefile          |   1 +
>>>   drivers/soc/qcom/ramp_controller.c | 330 +++++++++++++++++++++++++++++
>>>   3 files changed, 340 insertions(+)
>>>   create mode 100644 drivers/soc/qcom/ramp_controller.c
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index 024e420f1bb7..1e681f98bad4 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -95,6 +95,15 @@ config QCOM_QMI_HELPERS
>>>   	tristate
>>>   	depends on NET
>>>   
>>> +config QCOM_RAMP_CTRL
>>> +	tristate "Qualcomm Ramp Controller driver"
>>> +	depends on ARCH_QCOM
>>
>> I propose:
>> depends on ARCH_QCOM && ARM || COMPILE_TEST
>>
>> I don't think it is used on ARM64 SoCs, so let's make life of distros
>> easier.
> 
> Forgot to reply to this one: MSM8956 and MSM8976 are ARM64 SoCs :-)

Yeah, indeed, I meant the other way around, so && ARM&64 :)

Best regards,
Krzysztof

