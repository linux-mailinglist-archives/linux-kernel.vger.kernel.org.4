Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681536377BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKXLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKXLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:34:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9138B12E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:34:46 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u2so1692621ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/RFwEGuR78ga6A8No+0+FWED3HfOqZwgwrM9a/6eaU=;
        b=ug9JzISkSPoKkDvuCLvaZQvVolwBg+L1KEO86bspPo7ZC3xY8MCixqRcj5xWRGvjTT
         WPXbtvaKdTry4UafgN4iCNweG+5neNVPdohuYlz95sWjtbZthOJR2P+IbH8mswtsfLTH
         DQ87hzNk08u6nf2wHGIKQ98i+iYb+e8qYHpkZmqh99qJQh10cHQsaYnmOgkJIPoesKrt
         7FoWdrj8o2+jAia/8xugZuTWYY4i8KZhTP8R5mhMZF6vidKvWLkU0lYi+U0t9ZHwMKtX
         vrzhgHWjNrn9Rc7PFQme89/WbhJmuLiBq9ZN8dTJqkwaJVMf9McLtM5mpGx4xnwcEpd2
         yuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/RFwEGuR78ga6A8No+0+FWED3HfOqZwgwrM9a/6eaU=;
        b=frjaaJZ08CBgwGIJgTOIKUkWGKrDLS8qsC3i9yM/HELEm+y1Xi9UPDpvxm+QIDvLH+
         BglGmaQbe72ZZ2KG+Z1TQ6OFOAHl96VdaUd90aqxkLMMP52Aimtcj82JcxGHCZ5Nsu6A
         gAgIklgs+titDp5QM3bdCjWGI0AaiGaVloPLJIQSdRRytNr9tTepsQXsoT8DDVO4kKsL
         hUTbwJDUjDc4BnWIYvrKlbB6NvZxV5t7gFH/4Xw1iaGOVJFJNfI6g8fQzuDoMtY3Cm1W
         N5aNxoko750LWSfQ/T74Gfe6hiGsSR958cAX1OiOXP4buarmeEQCcDCi+ygJ9HNmPVBa
         ALng==
X-Gm-Message-State: ANoB5plOUN4s+EOUF5QCsMs7z7iilPrOzo/Uz0S0ldOSbXyweS3XwoPQ
        g9pMf2B7fOpe44KP7BZki3BpHozKgJuliFey
X-Google-Smtp-Source: AA0mqf4rmYkk3455tjXUIfT3vZxQDg6BfnTJ5RdJR4IFJ3TDTq8hzgnQPEctELIlMUuWbHWfI0P7lA==
X-Received: by 2002:a05:651c:902:b0:26d:e3ae:886a with SMTP id e2-20020a05651c090200b0026de3ae886amr5065796ljq.531.1669289684685;
        Thu, 24 Nov 2022 03:34:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j7-20020a056512344700b004b4f2a30e6csm102398lfr.0.2022.11.24.03.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:34:44 -0800 (PST)
Message-ID: <2a27c32d-b013-e914-62ae-393af3987716@linaro.org>
Date:   Thu, 24 Nov 2022 12:34:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [Patch V2] memory: tegra: Remove clients SID override programming
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221122053103.17895-1-amhetre@nvidia.com>
 <cf5422a7-351a-6780-ff7f-e20bc81f94c7@linaro.org>
 <df879efe-cbae-603a-1d1c-1ac63ac9c12a@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df879efe-cbae-603a-1d1c-1ac63ac9c12a@nvidia.com>
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

On 24/11/2022 11:20, Ashish Mhetre wrote:
> 
> On 11/22/2022 4:44 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 22/11/2022 06:31, Ashish Mhetre wrote:
>>> On newer Tegra releases, early boot SID override programming and SID
>>> override programming during resume is handled by bootloader.
>>> Also, SID override is programmed on-demand during probe_finalize() call
>>> of IOMMU which is done in tegra186_mc_client_sid_override() in this same
>>> file. This function does it more correctly by checking if write is
>>> permitted on SID override register. It also checks if SID override
>>> register is already written with correct value and skips re-writing it
>>> in that case.
>>> Hence, removing the SID override programming of all clients.
>>>
>>> Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
>> I could not get from commit msg what is the bug being fixed. You just
>> said "more correctly", but usually things are either correct or not.
>> What are visible effects of the bug?
>>
>> Otherwise it sounds more like optimization or a bit better approach, but
>> not a bugfix.
>>
>> Best regards,
>> Krzysztof
> 
> Thanks for the review. In the function tegra186_mc_program_sid() which is
> getting removed, SID override register of all clients is written without
> checking if secure firmware has allowed write on it or not. If write is
> disabled by secure firmware then it can lead to errors coming from secure
> firmware and hang in kernel boot. So, that's a possible bug.

Please add it to commit msg, because it justifies Fixes tag and probably
backport.

> Also, it's an optimization over current approach because it saves time by
> removing re-writing of these SID override registers as in new Tegra releases
> SID override of all clients is programmed by bootloader. So, MC driver don't
> need to program them again.

Best regards,
Krzysztof

