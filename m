Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B036FF7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjEKQ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbjEKQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:58:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD7F2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:58:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso15778091a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683824286; x=1686416286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAcKqyDIPEwD/PLGMdGJdczQtEbvNxxD9j8N9ECA2bQ=;
        b=v4rZxJGZIaKRbrkBAziJH/KFqQckrf3f3Ic/dMJ/DjgfE7Y+h9TzHqpVBFigbkkppG
         F+ohsIE1tkrBM9jlIMIelZliNydwg7Jj0wryChw1ekNUmW7oB8ZurTuictbIEyDCUdkA
         HD+1+kVMqBJS1odtI6rcwqRUclE3ORkjQiXtON9Sp5ROGUYWEfB0rLl+bteVQLJKBga2
         LfhVj9s9Tq+wGWR5p6l86XRXxW8hdJOT/3PkRKwaLKlfBnq6rLGJzDB0hoc009iJcbKx
         aEadFGUChT9KZ1G1yZ24dvj5mfic7eXDOKTJcXujCRmFesDQQAYcMirL6/akr567MJQD
         w36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824286; x=1686416286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAcKqyDIPEwD/PLGMdGJdczQtEbvNxxD9j8N9ECA2bQ=;
        b=HSHdXpR9uModNq4IGoZCMsf5Xya6S4z2S4TLKWEMxYab0PEEwKmVK6zdNn06p8mNRw
         WLOBXnIdK5hVnxlEKHOooGrdb4P+/eDbo9eGSFrVSKnaerUmPuGRKFZuiMdb7XKqxrLz
         8zBIW1SbGzeUM5yggM8OpIuEg+yX/qZHBrM8IoqjX94CCDOAWkwY2oSQduF6omXKgnF3
         dVICpCBJiRaFBdMq+a91Qmu4oCA0GDtU8DHVVvbTJO2GT0opR1xIach2RoQHCYBWYC7P
         LNZv8r1JOFiY7qsG9etfS6dlmH7iV8IYcXIIp2he9nEgF+f4xZP7zP1IrsRMhS0IoC9a
         clWA==
X-Gm-Message-State: AC+VfDwPz/Mk+PsJu4PN5YeqbWEDNiGpy97sZVSAy3c/aILcYpVG8Vhv
        7iVaEIlnHM0cSCW1X7WfOy6lYQ==
X-Google-Smtp-Source: ACHHUZ7hToPLX0AsmAcSxWkOwsPyrnw++so30WZbs8XuIhISNX2QOBPGEpUv7l4RODb/XcZia+2qJg==
X-Received: by 2002:aa7:df11:0:b0:505:4f7:8a50 with SMTP id c17-20020aa7df11000000b0050504f78a50mr16120093edy.5.1683824285844;
        Thu, 11 May 2023 09:58:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id y24-20020aa7ccd8000000b0050da1edb2e4sm3084718edt.31.2023.05.11.09.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 09:58:05 -0700 (PDT)
Message-ID: <7dcd3828-c4ad-bd03-b18e-a6ae4ac5bd50@linaro.org>
Date:   Thu, 11 May 2023 18:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/6] dt-bindings: memory-region property for
 tegra186-bpmp
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
 <20230510142248.183629-6-pdeschrijver@nvidia.com>
 <cdba4bb0-551b-a3b2-9329-139d6cda71be@linaro.org>
 <ZFyhqXhzOUKYUafA@44189d9-lcedt>
 <5d01e717-39f1-798b-dda8-022b8430dc7d@linaro.org>
 <ZFzEFRBKMcUgrILn@44189d9-lcedt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZFzEFRBKMcUgrILn@44189d9-lcedt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 12:31, Peter De Schrijver wrote:
> On Thu, May 11, 2023 at 11:03:24AM +0200, Krzysztof Kozlowski wrote:
>> On 11/05/2023 10:04, Peter De Schrijver wrote:
>>> On Wed, May 10, 2023 at 05:01:55PM +0200, Krzysztof Kozlowski wrote:
>>>> On 10/05/2023 16:22, Peter De Schrijver wrote:
>>>>> Add memory-region property to the tegra186-bpmp binding to support
>>>>> DRAM MRQ GSCs.
>>>>>
>>>>> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
>>>>> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
>>>>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>>> ---
>>>>
>>>> Also no changelog. Since I do not see improvements after Thierry
>>>> comments I assume you send the same.
>>>>
>>>
>>> The changelog is in the cover letter. I will send it to you next
>>> iteration.
>>
>> I got only few patches, rest is missing including changelog. Thus it is
>> the same as it did not exist.
>>
> 
> Do you want all of them? Some people seem to object to that so I didn't
> send them to all people.

If you do not send entire patchset to everyone, then cover letter should
reach everyone.

Best regards,
Krzysztof

