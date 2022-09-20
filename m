Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610C5BE0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiITIsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiITIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:48:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD63E77D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:48:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso1760571pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z0CIYBJ59VmXnMF6RrKkrGfbMLVUY9u6d9zW/w1YKxo=;
        b=stBcYq0P2qVspyhXBudCWuspwYMnLkloEBnRu8iZ9njhsuEMVyBWG2fkR4PHagZDC5
         jBRA/os+bhGrQ04IvNzfb3LoFCptK4WY2kXICFr1hrlGDZ5ZbEDND0i2M2r/K+hRnvSY
         qUdo72zMXsdohLzgSusZQlOwsKYHwkmAzIYEMUxWoUtBs3PkLtjR0saDQ94exHT/BEnd
         ehgACbwfl8w6MHCwR0TOR8BEcBxzauCd5A4+Rirw8IwLF7oQVtr6n+/Hq+Nl3atD+AWU
         wq9OCsmAQ1KVXb8tCspn6hi7/25HWmeUhWx11WcK4mT8O4SSTxjEZXdbmQXWOH2OkqMO
         926Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z0CIYBJ59VmXnMF6RrKkrGfbMLVUY9u6d9zW/w1YKxo=;
        b=xDsDpljF0lBi0oJyvt57/dVPI5cYO7UkUn/Ak5IEs4rSckOpQQDWleSSicwZVMbw0t
         z/y2Lf1XwTepXAGPLUp/+J4hOj6jTT5XH+j84lgy1EzXx+0wBpBTg6lPKyx1pvp8RV8H
         Gb83ZiQ/HNyAKhYCe2oiLMHb5zKQU9q83edn7R7oyN0PzCbijyU1fM0hjt++qDwaMdbJ
         Kl70kpoGupCnEAnCfGvkgKq6Gdb12WXu1tWXJENqnrn4SLiP710CXPV2vBld8GbD7acl
         zcUdor5J4NnVzRqeIVpZ2VSxxnIsOfGMCYUEfNL+V8U64uEz87mk2QCTq+igZFrfYXyX
         Pr4Q==
X-Gm-Message-State: ACrzQf1TELByqhMtuzyrv6Op/djpx1HUeKkwpVaPRCx07Vgm3a6lf7WI
        8wHlL+n5F/U6r+CiSaebtHrqeA==
X-Google-Smtp-Source: AMsMyM7hdUJkdrTz4X/rM3IM3DquC6pUyCuxVg3nCWn2zWTFvFTXxao5FHWqy4n/oFtApFlunAGQ0g==
X-Received: by 2002:a17:90b:38cb:b0:200:aaa6:6428 with SMTP id nn11-20020a17090b38cb00b00200aaa66428mr2768505pjb.47.1663663689720;
        Tue, 20 Sep 2022 01:48:09 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c61:6535:ca5f:67d1:670d:e188? ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b0016be834d54asm824491plh.306.2022.09.20.01.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:48:08 -0700 (PDT)
Message-ID: <dfe1bc9e-2ab9-d2dd-7daa-dddb8d66fd77@linaro.org>
Date:   Tue, 20 Sep 2022 14:18:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml &
 related changes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Jordan Crouse <jorcrous@amazon.com>
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
 <36bd1c19-8fbd-0903-704d-447117b2007a@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <36bd1c19-8fbd-0903-704d-447117b2007a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/22 12:58 PM, Krzysztof Kozlowski wrote:
> On 20/09/2022 00:08, Bhupesh Sharma wrote:
> 
> (...)
> 
> 
>>
>> Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
>> The qce block supports hardware accelerated algorithms for encryption
>> and authentication. It also provides support for aes, des, 3des
>> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
>> authentication algorithms.
>>
>> Note that this patchset is dependent on the dt-bindings patchset (see [1]) sent to devicetree list.
>>
>> [1]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/
> 
> If it is dependent on the bindings only, keep them together. However I
> don't think this is the only dependency. You add here several
> compatibles which are not supported.


Please go through the cover letter where I mentioned that:
   'As per Bjorn's suggestion on irc, broke down the patchset into 4
   separate patchsets, one each for the following areas to allow easier
   review and handling from the respective maintainer(s):
         'arm-msm', 'crypto', 'dma' and 'devicetree'
   This patchset is directed for the 'devicetree' tree / area.'

Basically now the patchset which had around 23 patches in v5 will send 
out as 4 separate patchsets one each for 'arm-msm', 'crypto', 'dma' and 
'devicetree' trees.

So when all the respective subsets are picked up, all the compatibles 
are in place.

Thanks,
Bhupesh
