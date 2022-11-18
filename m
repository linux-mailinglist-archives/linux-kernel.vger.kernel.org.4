Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8919862F6BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiKRODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiKRODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:03:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190A27B1A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:03:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id be13so8363842lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUxGDXOF5xYSjDRZWvXFS7yq+U+z+lzZT7cIMxCr3pE=;
        b=h9vFytU4nm3SDaAbfXezc7LzhSkIBsZzYEz5ETdbbBuoIxQVlrWtDgfdPULsTaowYU
         1Tr9H9+E/aVbFDu/yeEgquYwyebD86/NUpy6Yye+PvNPjQoa8mWG2V1SNsvgqOlwynRK
         uRUURnSRZvShogeqIzTFGdwWtVqFBLePOwwRnjmxoG64pbmo78xP0bwMmSoE/2ZodzfB
         nenVIqfSlISk3A7lOHYWUJP+HPc6SMaDQVUdX8r1MRsgk6kZc028SCbaVe+EMY1pJJYw
         Lt33kE+xHn9w1WSPM6xdjboiEIGZmYNZOeaTngq3DzVjxjRCEUshiaC9YMzWmvO/UW0u
         JPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUxGDXOF5xYSjDRZWvXFS7yq+U+z+lzZT7cIMxCr3pE=;
        b=6n93xRuDCGbJ7tbp3Pz6BDTEVNDicKJjDs+pIzYncAGwMSzSx5+TuGfd88ENRRHuGt
         H+/PPiljcG3cEwHb+CU3ns8Takn6x0e2cWxNMc6u/F9sf5lh9RLhcQfeFQuQxvyYLZmr
         nO4g4aOEAF2KQxFO+IlmkUyCKImFav2QCJ5tc/RJWkze9+OiNPagLMUvjoibAOkD3/lU
         VV0sHwLcXMbM3Le2tXD9DzNVpuOliMsquOt/1gbQFXDS4p6DQ3SOUFU1blcpqbvEVNWD
         s4XQXhALqH4jSVUSjFAu2KAB0IIy6LAVUic7n8BbcJy9hfol0RQ2zQH3z27ovCceFcvi
         7uVg==
X-Gm-Message-State: ANoB5pmbOx1AvmivlbvRGmk6739SRJB3H0EmBxHh5RZIrH0QjmQ4/mpQ
        FWZqf2pQWnZBYQyUaf+yU0/kDg==
X-Google-Smtp-Source: AA0mqf6JVFi5KuAWgUHvL/yiZ1qAdvnG7QM5UfiBcwC90Cx4VmMjybgiI181zGhQK5JJf87MUrJ7nA==
X-Received: by 2002:a05:6512:3122:b0:497:a17d:d848 with SMTP id p2-20020a056512312200b00497a17dd848mr2365223lfd.381.1668780223705;
        Fri, 18 Nov 2022 06:03:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v26-20020a056512049a00b0048b365176d9sm665585lfq.286.2022.11.18.06.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:03:43 -0800 (PST)
Message-ID: <7b3356a9-8f2b-49de-7ad3-b01c3279eac0@linaro.org>
Date:   Fri, 18 Nov 2022 15:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS
 DSM memory
Content-Language: en-US
To:     neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org>
 <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-1-158dc2bb6e96@linaro.org>
 <38fff21b-3e75-13f9-664e-a115bc527b67@linaro.org>
 <9aa23650-6ae1-3844-7cf3-6812dc023c11@linaro.org>
 <dfec6a0b-86c6-fb61-51f6-d1e400a6f5ef@linaro.org>
 <ad9d2e4f-1d60-15e7-dc2d-e7e32b0ec855@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ad9d2e4f-1d60-15e7-dc2d-e7e32b0ec855@linaro.org>
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

On 18/11/2022 14:30, neil.armstrong@linaro.org wrote:
> On 18/11/2022 11:45, Krzysztof Kozlowski wrote:
>> On 17/11/2022 10:47, Neil Armstrong wrote:
>>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: qcom,mpss-dsm-mem
>>>>
>>>> Why do we need dedicated binding and compatible for it instead of using
>>>> memory-region phandle in the device?
>>>
>>> So like rmtfs, this memory zone is shared between APPS and the MPSS subsystem.
>>>
>>> Like rmtfs it makes no sense to link it to the MPSS PAS, since it's only a launcher,
>>> it doesn't represent the MPSS subsystem.
>>
>> This also does not represent a device. Memory region is not a device, so
>> this is as well not correct representation of hardware.
> 
> I never used the term device so far, but a shared memory region with a platform
> specific process to share the region between subsystems.

Yes, but you create a device in patch #2 for this binding.

> 
>>
>>>
>>> In the PAS startup process, the resources are released from APPS once the MPSS subsystem
>>> is running, which is not the case with the MPSS DSM where it must be shared during the whole
>>> lifetime of the system.
>>
>> I don't think that PAS releases the region. I checked the
>> qcom_q6v5_pas.c and there is only ioremap. The device stays loaded thus
>> the memory stays mapped.
> Yes PAS does release the firmware region when the firmware is started,
> qcom_scm_pas_metadata_release() does that.

Indeed, I see it now.

> 
>>
>> We have already three of such "memory region devices" and we keep
>> growing it. It's not scalable.
> 
> If we want to properly describe this, we must then represent the MPSS subsystem
> and associate this memory region.

I don't see why. None of devices in your DTS reference this memory
region, so it is purely to keep it mapped for Modem, right? In such case
I still do not get why PAS/PIL, who starts and stops the remote
processor, could not prepare the memory and share it with modem.

The point is that this memory region is nothing special and does not
deserve its own compatible. We keep adding here compatibles to fulfill
some Linux implementation specifics, don't we?

Best regards,
Krzysztof

