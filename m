Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A06F71CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjEDSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEDSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:17:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793625FD9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:17:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so6422115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683224245; x=1685816245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=af9GcgFX/WrAwyrN5Pm/dlbY9v6jxEsxMAwF1mQThbU=;
        b=eA6F8Kt23w8sPb+T3BfTaGb1EsbmWZWbmIhNJKw3Eo7a2YWzb6UDCe3EOwsQOx+4gT
         uSr7Q/1CuShPtUT3YKYzViZ8/BwbS46fyyFz6VvswyOX5aDYF/AL0AhNk/qLhUW2zRTk
         7LdGkauNVpODFkymNeTowu5LFZygtkwTFhCVlPT5RVq+8n1ghn+xPvRtM39lPtK+WmQa
         +xoKQA6MmueI24i7sI7xEVU074a4ychc0QvwKOBFdY+5L2MD11XLWxE7OGCOCk/pA8Z3
         4u2F7ctM/96bvZ+9qZbv9QdH0LDa8I29EbAlFxpUpxW0M6zGtyUxJIcE1SAsAUHl0m/C
         hxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224245; x=1685816245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af9GcgFX/WrAwyrN5Pm/dlbY9v6jxEsxMAwF1mQThbU=;
        b=aG7t2rFy40o4DpPe0xDW9e0u9Tnq1y73DUyZsvfWfgkzYjY6KpZ9wpwMbuU+LJfhuW
         GzeoS9X/79hn1/VtiUKpdu+Q9rDK+liPckVM6MyWNdZ5x8ssDNKtpAseM4NG9c6isdTW
         6XM+NftDyoBdfj/imoFm255KCDHhEYh+j/szhOMvMJU4XvZ/LSAu8IeU40cRHI4P4NFA
         V4gtKXahsG0JpgRNpe0SwD7RREyAFW1rEG6al48zfLLjVhEfaucoPV6ZFFVSttWJOVTZ
         R5DEafP58zz9yJdPdqeconXpQo570A0P8D8GHBVd604ieX+dxk43ptPpxXrwr69NuVug
         tBhg==
X-Gm-Message-State: AC+VfDz/7m1ISsC+dWiKISKMC0NYbJ65BPzJzaMWDTx5C6pUOtZ2/ypv
        ZRXMWi9ndofhC4IrLi26JRz2SA==
X-Google-Smtp-Source: ACHHUZ7HNojQ9qBf9UqD9aO1exlZbJ/tuFvyD+yYUXXB+vMf61YPUYepha7/n2bHFo64K/wWm+QzLA==
X-Received: by 2002:adf:db8a:0:b0:306:b3f9:e2c9 with SMTP id u10-20020adfdb8a000000b00306b3f9e2c9mr2468592wri.6.1683224244857;
        Thu, 04 May 2023 11:17:24 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id q20-20020a1ce914000000b003edc4788fa0sm5617959wmc.2.2023.05.04.11.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:17:24 -0700 (PDT)
Message-ID: <09c9545c-9808-6815-5b20-1276ba136ef8@linaro.org>
Date:   Thu, 4 May 2023 19:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <NO2MhqhxQqjQ33CVOtaXXxo2iBfl6Ugz1lE5oJAl-mjUyrRu4l9vCBWV8AVJZoCrVF0Cw0j49t44Bn5yEAv3mA==@protonmail.internalid>
 <bd3350e3b0b02669cffa4bdaf9a0a1d8ae9072d1.1681742910.git.quic_schowdhu@quicinc.com>
 <9da030c6-6a9f-6766-7120-94aaa8fcd8ab@linaro.org>
 <3ef818c8-1ee4-5bee-6b37-20658b2e4637@linaro.org>
 <77c4ba62-1566-993b-ec33-0da2fa9936ec@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <77c4ba62-1566-993b-ec33-0da2fa9936ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2023 17:26, Dmitry Baryshkov wrote:
> On 04/05/2023 09:26, Krzysztof Kozlowski wrote:
>> On 04/05/2023 00:10, Caleb Connolly wrote:
>>>
>>>
>>> On 17/04/2023 16:08, Souradeep Chowdhury wrote:
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - enum:
>>>> +              - qcom,sm8450-bootstats
>>>
>>> This region isn't exclusive to sm8450, it exists also on sdm845 and
>>> presumably other platforms. Is there any need for an SoC specific
>>> compatible?
>>
>> Yes.
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>
>> Also see many discussions on LKML about this.

Ah, thanks both for the clarification and apologies for the confusion.
My main concern is that this binding and the associated driver work just
fine on sdm845 with no additional changes. Is it acceptable then to use
the qcom,sm8450-bootstats compatible there? If not, then for someone to
enable this driver on sdm845 would require not just a patch to add the
DT node, but also a patch to dt-bindings to add a compatible AND a patch
to the driver to use it.

Based on Dmitry's response on the driver patch [1], perhaps adding the
catch-all "qcom,imem-bootstats" compatible to the driver would be
suitable. If there are SoC specific parts in the future then match data
or gating with of_device_is_compatible() can be used with the SoC
specific compatible. This is how the qcom_stats driver handles things,
would this be an OK solution for everyone?

> 
> After taking another glance at the parent device (IMEM), I start to
> think that we should not be defining the device at all. The imem has the
> SoC name in it. So I think there should be a proper driver for IMEM.
> Then it will instantiate the ABL stats platform device depending on the
> SoC compat. Also this would allow us to rewrite qcom_pil_info_init() in
> a way to query IMEM instead of poking into DT directly.

+1 for handling this automagically in driver code, I'd be happy to look
into this in the future.

[1]
https://lore.kernel.org/linux-arm-msm/35ac64ab-512d-1425-7a1b-6e8d3806c8a8@linaro.org/
> 

-- 
Kind Regards,
Caleb (they/them)
