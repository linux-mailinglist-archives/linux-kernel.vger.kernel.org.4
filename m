Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36873619C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKDPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKDPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:48:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143FDFDF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:48:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x13so3450073qvn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dX0qOxdXp7cLT23QrYhqGLe+jJ28qbVowgKPPL8RXA=;
        b=CK4Lrv5YGb05eowI2JEr+yVsJX/Zrxtf3FfjCmo5XKXaIja/4IlsG46r8SCl7uVulI
         sefu0j41mhINaDArZ7A/IKt4j9s+IBRkuVdnm1jh00QVfO4MUUrJYb37QERgMZE/gjme
         Xao7HiTyBaMUYbNQ2oYxAdC491K6LYdBznLgHBXkaZi9x1MEySDC3j/wNZXPm/NbeZIa
         HanPjOCZ+Pbxwh+AR0m/E89oaIpWUFjOHx0hFtRR0g0etqnFBspiK1uj58DY/qQYbZr+
         ux+Ao8hc06Kv+i8OkAltajxjKIkxngQ4OI2FgV2DIbzRszBwuPuH7HUeGbeCMhuG3dcR
         Ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dX0qOxdXp7cLT23QrYhqGLe+jJ28qbVowgKPPL8RXA=;
        b=PNo7kEwvEzAubpTSqY9WBncXvXDM667AY5udnt2ZKlMxW9W+UqLMhEvFkhvWAb9mnQ
         IrxUQuw1DtidP/TS6ck/f55LYibHlcuo7NWGevbK9b2eXIG1wn+wnBQhhatUZ7zryb+O
         dzUfet9P8BllYFcbICy9++U97H9TGA6JRAyvdKmj8QjFsE4b1v9KHejg/oTnQEDj+fbW
         M46Giy2GJKu2WLdO49aZj+NLb1pkH2JfQQsPKUKrhoouNGZUWbsMg+bAjUz+I/3AI53G
         kwBleqf+aHqFAnnO08PqZTT/ey9wpcE5w9vW+kbtg7PZnP2KSqWEOMCguGxbw2T50eLu
         2vfQ==
X-Gm-Message-State: ACrzQf3OOBn6eQ6qf29+skDKRPvhZ2Kyah3GJGaK11cPKCcTW89UjZRp
        ZfXk+1naHEtPnYUAJU0yY6Oa+Q==
X-Google-Smtp-Source: AMsMyM6cuSu/k90Bmo3Izk1r3J2Rq8GdzcYNFtdYhXEW1AFFmae+EICDVfB91Hh8ksmn9UUnNBRwvA==
X-Received: by 2002:a05:6214:2b0b:b0:4bc:27a3:f43f with SMTP id jx11-20020a0562142b0b00b004bc27a3f43fmr12663301qvb.8.1667576902204;
        Fri, 04 Nov 2022 08:48:22 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006bba46e5eeasm3127113qkl.37.2022.11.04.08.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:48:21 -0700 (PDT)
Message-ID: <a72c0e60-732f-3486-722e-851f21ebe640@linaro.org>
Date:   Fri, 4 Nov 2022 11:48:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/8] memory: tegra: Add API for retrieving carveout
 bounds
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920081203.3237744-1-cyndis@kapsi.fi>
 <20220920081203.3237744-2-cyndis@kapsi.fi> <Y1aP7kDi8cJUTcGN@orome>
 <ee3073ba-d621-8b02-c986-3cf44cfbba96@nvidia.com>
 <b9b20abc-d37f-f74a-a416-2e210bf944c4@linaro.org>
 <3a783b8d-4970-663f-816a-15aad5a66a48@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3a783b8d-4970-663f-816a-15aad5a66a48@nvidia.com>
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

On 04/11/2022 11:46, Jon Hunter wrote:
> 
> On 04/11/2022 15:35, Krzysztof Kozlowski wrote:
>> On 04/11/2022 11:33, Jon Hunter wrote:
>>> Hi Thierry, Krzysztof,
>>>
>>> On 24/10/2022 14:15, Thierry Reding wrote:
>>>> On Tue, Sep 20, 2022 at 11:11:56AM +0300, Mikko Perttunen wrote:
>>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>
>>>>> On Tegra234 NVDEC firmware is loaded from a secure carveout, where it
>>>>> has been loaded by a bootloader. When booting NVDEC, we need to tell it
>>>>> the address of this firmware, which we can determine by checking the
>>>>> starting address of the carveout. As such, add an MC API to query the
>>>>> bounds of carveouts, and add related information on Tegra234.
>>>>>
>>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>>> ---
>>>>> v2:
>>>>> - Add check for 64-bit phys_addr_t. In practice phys_addr_t
>>>>>     is always 64 bits where this runs, but it avoids warnings in
>>>>>     compile test.
>>>>> ---
>>>>>    drivers/memory/tegra/mc.c       | 25 +++++++++++++++++++++++++
>>>>>    drivers/memory/tegra/tegra234.c |  5 +++++
>>>>>    include/soc/tegra/mc.h          | 11 +++++++++++
>>>>>    3 files changed, 41 insertions(+)
>>>>
>>>> Krzysztof,
>>>>
>>>> I've applied this to the same tree as the patch that uses it for now.
>>>> Let me know if you want me to put this on a separate stable branch for
>>>> you to pull in.
>>>
>>> Any update on this?
>>
>> What kind of update do you expect?
> 
> Ha! I guess I should be more explicit :-)
> 
> Well, I would like to see this change in -next and so I was hoping that 
> you would respond to the above to indicate how you would like to pull 
> this in.

The change will be in next via Thierry. I do not have to pull this in.

The maintainer which applies patches is responsible for:
1. Having his tree in linux-next,
2. Sending the patches to upstream maintainer (e.g. arm-soc, Linus)
later in pull request.

There is no job for me here, if I agree with Thierry. There would be a
job if I needed a separate stable branch, but that I did not decide
yet... Do you think I need to pull it? If so, why?

Best regards,
Krzysztof

