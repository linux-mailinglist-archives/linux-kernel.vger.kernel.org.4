Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBE62F5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiKRN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiKRN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:26:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE485A23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:26:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l14so9301740wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e5MiF9TMHxw5V5hyXlLxWTx5c5LNTg+L6bdroac28KQ=;
        b=tXf7R2BbLdciR0aWHCW1fcHe8ymozuqrc0GToPKat0J6HPiGqJXpeTNjP8EZo7cAe5
         ghQt0EqEWMd9qkLjwYOnHmFc0kbNN+kfPUxJHNCIdbdWB0uvnyEh8xkWZhiQ4DDxjT3A
         ur1Aswxlx+ThA6gWcFoCN+/Den71gN3VX41Yrt0RgRVFE9XznpJzx0Zuvw85Mm103JzQ
         yNUMhdt63vJif5OdEI5gsbkC6CKUjsYVWwa20xF+0WESaKVjQUiZYlJIWopmce8LAwWh
         /YhIMyzDF2gZ4VnM9LqOgGKdRieJ+pairfYiDNYjRhkRKU8Mv4GgIY2o3egiR3sWW3g6
         V23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5MiF9TMHxw5V5hyXlLxWTx5c5LNTg+L6bdroac28KQ=;
        b=mzNHwS8PwdQ8INn2EYCAaVQDKAwHLp9fojUyx/DKwBNhzh/Y7kMKO6DNJPegTtL4Fg
         ik95VW3Ob0Q0cytNRxUvxhL6tzXEe+lPYNM9V1BZJFZHOsUAvq6T81zjfMwnxTmG93ZQ
         OXvJZ0MkoDHnyQq6xonCbAyFQRIbsMnhnJ1Btz6zkNbNQwZ8oWDttQFiHXBO6Oxab2vy
         fSjIbWRdJTO5CGWMzahjZO5uTyWJRlhyUsslbuUDtTZckuIGW+K+83uGQs2mrsu1eY8W
         5fA2ZPOxnpnwdedP1UAh04fnh/ZpvCzEHKEKQnpDgJZ/OKVzbIO6meuF98onlT5xF3yh
         eM1Q==
X-Gm-Message-State: ANoB5plfKUgGKAGsVEKHOt1YRrx2Q9v/C7QdTcQ+YoKmMeVgo55/Tbgn
        kNo7PSaF3uOl66ZckavMk9QMGw==
X-Google-Smtp-Source: AA0mqf4kDgGIKWcnXZDZaS3yoafhs9FZKkJ73tJd4mzLPQeKB2/wrtXUa5UWiLDIZJgyTQVdB0iEUQ==
X-Received: by 2002:a5d:6b08:0:b0:236:4b06:bbb1 with SMTP id v8-20020a5d6b08000000b002364b06bbb1mr4280526wrw.303.1668777995737;
        Fri, 18 Nov 2022 05:26:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f7cc:460c:56ae:45a? ([2a01:e0a:982:cbb0:f7cc:460c:56ae:45a])
        by smtp.gmail.com with ESMTPSA id s18-20020adfdb12000000b00241727795c4sm4356779wri.63.2022.11.18.05.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:26:35 -0800 (PST)
Message-ID: <3cd03d3e-b521-8050-b8fa-a521310f1e5b@linaro.org>
Date:   Fri, 18 Nov 2022 14:26:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: reserved-memory: document Qualcomm
 MPSS DSM memory
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
 <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-1-f7c65d6f0e55@linaro.org>
 <0e8ed125-beba-8f74-b3aa-728e9dc5a09d@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <0e8ed125-beba-8f74-b3aa-728e9dc5a09d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 18/11/2022 11:46, Krzysztof Kozlowski wrote:
> On 18/11/2022 09:53, Neil Armstrong wrote:
>> Document the Qualcomm Modem Processing SubSystem DSM shared memory.
>>
>> This memory zone is shared between the APPS and the MPSS subsystem,
>> and must be configured during the whole lifetime of the system.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../reserved-memory/qcom,mpss-dsm-mem.yaml         | 37 ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
>> new file mode 100644
>> index 000000000000..226d0dfc422c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reserved-memory/qcom,mpss-dsm-mem.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Modem Processing SubSystem DSM Memory
>> +
> 
> Discussion in v1 is still going. Memory region is not a device.

Nowhere is was affirmed this was a device.

> 
> Best regards,
> Krzysztof
> 

