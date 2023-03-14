Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27466B8DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCNInY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCNInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:43:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02D27C9EF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:43:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x13so11476008edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678783396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92MwtSwPGSC0xtheTxnGf3j9jdTI96ljx0ZviUFHG1I=;
        b=oyQ4dMvk2UK11GA1WdnLBvMyOHcESeY2TG2Mmo7ok3Q9m+xGNXdYROfuQAKcVbAeop
         Ypje+0WERfKpYGPxleCN9OtJzftIVgKUBc5JIb13qfCZFPI/NYFqwKGlUZjN71SIoatX
         pGOlFeNXz5MQm2TqOl1c1YiZ8U8SrKN3HN0Xa/iRIHXnfGJXKrDUlcEvNKufmwbFp6G/
         Y1kKx9sjvYjV70mOO8H6g71hlUpPZyhRnjSjmCE92X/8U0Engwihxc/Dh2nNK26HXorc
         5P+2J/pqtcku5I82Ocxod6uh8zsexw+ZjZSwQdKEF2K8rbJhwNtdYR2Ty8ObFhOiKZxy
         0oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678783396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92MwtSwPGSC0xtheTxnGf3j9jdTI96ljx0ZviUFHG1I=;
        b=NC1dozeK9zvp74eYISopqjgNLe7TNkBUQ5a+YLv5wfHXQEskkuqHDcy2LmisFeNAXQ
         XekgvrtwZy9QXK0WrrfVQicveHvxRmpz1G3VBbI8Z2TGWIJIGBRBPNwDa+rwve4MZjt5
         BuP/KLg80aWsntvEcGSeqTcC53cOIpI0Y4dYT9gt0ZsHiXlPioUxPPdqt72L28IQcAoW
         ETDmMEmr7Yw0FP/Ck030J4BaoAzgRA3HwRd8UawOZKIkKr1gJeyFoxgI1fzRiexu7Cd2
         VyyjLMFo7UjcpzI8qRYdOdYZ8d/Xf+1gYPRycr5jECoMVnHAxB2GmLnUFbviddQv/cp4
         xrnQ==
X-Gm-Message-State: AO0yUKVPt9b+81ct24WktnSkSdBdAShVQsF3k5sAPlamj9dEQdJ9MDHQ
        G5DCZ8L7gT2TrIDXc3mvVh0Gsg==
X-Google-Smtp-Source: AK7set901qm2G8O222Nxqy1a/eOE1oERM7/AJ9yV62Vn5yPr980uV5IcS9c7byN3Xdxgf4K2Fu+Tuw==
X-Received: by 2002:aa7:df83:0:b0:4fc:812a:ec25 with SMTP id b3-20020aa7df83000000b004fc812aec25mr5962025edy.16.1678783396420;
        Tue, 14 Mar 2023 01:43:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id q11-20020a5085cb000000b004bd6e3ed196sm632505edh.86.2023.03.14.01.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:43:16 -0700 (PDT)
Message-ID: <c45df83a-a6ac-16bd-1872-64fd0794b421@linaro.org>
Date:   Tue, 14 Mar 2023 09:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-3-dipenp@nvidia.com>
 <f6d9c84a-1c75-d9b4-59ed-39d6c5b310a9@linaro.org>
 <b4195142-6cfe-df3c-6edf-0c40b64ad02a@nvidia.com>
 <6c5045d9-4f4a-5018-3f3f-7746b08ab2b5@linaro.org>
 <fad52df6-38e8-ba8a-117a-8514e09af0ee@nvidia.com>
Content-Language: en-US
In-Reply-To: <fad52df6-38e8-ba8a-117a-8514e09af0ee@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 22:49, Dipen Patel wrote:
> On 3/13/23 10:55 AM, Krzysztof Kozlowski wrote:
>> On 13/03/2023 18:05, Dipen Patel wrote:
>>> On 3/12/23 8:47 AM, Krzysztof Kozlowski wrote:
>>>> On 10/03/2023 20:06, Dipen Patel wrote:
>>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>>> bindings. In addition, it addresses review comments from the
>>>>> previous review round as follows:
>>>>> - Removes nvidia,slices property. This was not necessary as it
>>>>> is a constant value and can be hardcoded inside the driver code.
>>>>> - Adds nvidia,gpio-controller property. This simplifies how GTE driver
>>>>> retrieves GPIO controller instance, see below explanation.
>>>>>
>>>>> Without this property code would look like:
>>>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>>>> 				   tegra_get_gpiochip_from_name);
>>>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>>>> 				   tegra_get_gpiochip_from_name);
>>>>> else
>>>>> 	return -ENODEV;
>>>>>
>>>>> This means for every future addition of the compatible string, if else
>>>>> condition statements have to be expanded.
>>>>>
>>>>> With the property:
>>>>> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
>>>>> ....
>>>>> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
>>>>>
>>>>> We haven't technically started making use of these bindings, so
>>>>> backwards-compatibility shouldn't be an issue yet.
>>>>
>>>> Unfortunately, I don't understand this statement. The
>>>> nvidia,tegra194-gte-aon with removed property is in a released kernel
>>>> v6.2. What does it mean "technically"? It's a released kernel thus it is
>>>> a released ABI.
>>>
>>> There is no active user of that driver, so even if it breaks 6.2, it is fine
>>> as there is no one to complain about it.
>>
>> How do you know? It's a released kernel, thus how can you ask millions
>> of people if they use it or not?
> 
> Please help me understand, if I am targeting these set of changes for the kernel
> 6.4, wouldn't all the patches land on v6.4 at the same time no matter the tree it

No, that's not how we do things. Changes *must be bisectable* and *DTS
always* goes to separate branch, so how do you ensure this in your
current flow? I don't see it. The patch #4 should break the bisectability.

> will go from? Also, if user is at v6.2, how this will break as at that version, it
> will have the old bindings and old driver, right?

Bindings define ABI. You defined them like this in v6.2 thus someone is
using them:
1. In other systems, bootloaders, firmwares, SW.
2. via DTS written for v6.2 ABI. Newer kernel should not break existing
DTS and we do not talk about in-kernel DTS, just like we do not talk
about in-kernel user-space applications when using same argument for
their compatibility.


Best regards,
Krzysztof

