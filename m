Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692CC6F6AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjEDMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEDMDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:03:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8876B5FC5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:03:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f7a0818aeso59027366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683201799; x=1685793799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+Flag063oKB8Q1wi7qSq3Ulfch+IJh7NyCjAcrM3ZE=;
        b=IYSagRNF//SQQg3BUrc4S0KxF4KoLFjA33rsTrtPcO+JqKa0apRPWl3U/wTAQGSPab
         EMIlYccEyXfAq/FZbXhwWuNSi9fTJA9Mvk9gQXY3XKjy+jJyqiAgA4hdAzjo7YwIYV9A
         kLY7Gb5r0+74CruZqUJR7vCI7ztmSbAPfO5C5oDy9r/TPJX7gxQx/7lFewrjHkxU/2iD
         FJmcWSSM9eMxEfD9id6y3uUHPpxJJ9rfw9l9k8ONvWbnLsu9CXahoFDQHWwz84eFGUG6
         l4hoPL76xLEX1cchsBjY6o/dy2dFCUZUy67fDdvDV7VXOHgksXeEf/g5VnVW6OcaOHct
         luCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201799; x=1685793799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+Flag063oKB8Q1wi7qSq3Ulfch+IJh7NyCjAcrM3ZE=;
        b=bGvuQIA+1AvpB88Qs6dybwQHBNBNzoFObvH7kzCK5FJcDw9pr1ipO6qKFw/z+rG8s9
         Hxr7dOaW9Ii9kXeIGahL70YgcrzSCOsQd8CITcvjkSWNryr5BSohrXR9v76APJnSM75V
         sQcedqri13BEiDx8M07ZkkaeuUbZNzswH1y2yI0WSDDpAfXCUX6fl7O3lTwV6WK+RIxf
         Dk2+YnaQWwA0gwbCeqoTZDKN0qy0Yxppgd2SzqTSYOdN73XBXcZRNylJsjpygX5AxzHy
         noWg5znxRqd0Y3niQUHhj05og0QTK2bCeuRvLJdmeIvf9ooZJkqHonrPo6iod72wgw/0
         4U4Q==
X-Gm-Message-State: AC+VfDx1O5bblgoIwyMq9l4dbkUpHig3uBTiAEfCVsv8DV9zFkY05J5i
        D8XT9T3JW76hx3mQKM7Se+8jkA==
X-Google-Smtp-Source: ACHHUZ47YNIr6sZk/XYPHNt6yECSYNBOnFaK5lc1XKM9RfUQ+Fa5l3+EvXb6aEqviIAPoQw+tOeQvQ==
X-Received: by 2002:a17:907:268c:b0:92b:3c78:91fa with SMTP id bn12-20020a170907268c00b0092b3c7891famr5405677ejc.28.1683201798867;
        Thu, 04 May 2023 05:03:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id oz15-20020a1709077d8f00b0095850aef138sm15707511ejc.6.2023.05.04.05.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:03:18 -0700 (PDT)
Message-ID: <659a9637-f82c-054b-99a8-dc25416c8e13@linaro.org>
Date:   Thu, 4 May 2023 14:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 02/18] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-3-git-send-email-quic_mojha@quicinc.com>
 <fe94ed5c-c444-436d-720a-c96538c1026d@linaro.org>
 <e69862cc-4185-a7a2-07b2-15e331c4678a@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e69862cc-4185-a7a2-07b2-15e331c4678a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 13:58, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 5:08 PM, Krzysztof Kozlowski wrote:
>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>> Move minidump specific data types and macros to a separate internal
>>> header(qcom_minidump.h) so that it can be shared among different
>>> Qualcomm drivers.
>>
>> No, this is not internal header. You moved it to global header.
>>
>> There is no reason driver internals should be exposed to other unrelated
>> subsystems.
>>
>>>
>>> There is no change in functional behavior after this.
>>
>> It is. You made all these internal symbols available to others.
>>
>>>
>>
>> This comes without justification why other drivers needs to access
>> private and internal data. It does not look correct design. NAK.
> 
> Thanks for catching outdated commit text, will fix the commit with
> more descriptive reasoning.
> 
> It has to be global so that co-processor minidump and apss minidump can
> share data structure and they are lying in different directory.
> 

Then you should not share all the internals of memory layout but only
few pieces necessary to talk with minidump driver. The minidump driver
should organize everything how it wants.

Best regards,
Krzysztof

