Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF6E633B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiKVLSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiKVLRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:17:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB65BD4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:14:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a29so23018396lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7krN4uy7fa8HUDKlhqCJ4hwJZ4t6GGuL11gxMNP/ox0=;
        b=eDX8wyN9iywDWFI4bs2pCUkJPg9fMQDuvjWaulmtbp1aSQyL4v1hpyEEKR1iSQY9jN
         3lbSL/U5xBEuduSw5UsSSqWftmxQtq4CIKBCzibrhP7OPSysudSisZAuvZ4Sq6f5SHqA
         8l1MMUQsAiXjJHs7M1ywMMGHimv3id8r8Gah4ZLed7RbVGHTegfMeh36vqScGU7OZs6d
         p/Y9hoYGeirzGP0qRqBFLgPgMA782rLw7xXYksbWrJ6X9poyC2KIhp1/k0rrfCvCHJUC
         oIxbGiZtbzMH/TQeVHCW+iFpVRZWy3KNF0MOfz70LOAOk2k7v6eNHL8+OKkdBpenazgg
         5T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7krN4uy7fa8HUDKlhqCJ4hwJZ4t6GGuL11gxMNP/ox0=;
        b=wDboXX2F3AIk5Hs+3qqW0dTwfMERzYtpxmBH5jBfFq96WDXKNw05SNik55y4U2j8w0
         T2NCNiw6LZ5CApNEbkgXQ6CzNSuxnw96jMe9hze0Lf/0fM70+PNkc2y84P1SAQIgrqdV
         RneQbmOOubGRUr3iCT4/SWEjXvGwgck9asICxgzYczc15IfdA6XZIXEwOzjtR+U2qWCY
         ZnB3VLgRDroz1UIAWY2dxVcK6nlm+FYuXAv/6BsGPRQyhWSc2gJCM99vCAFlsgeGL9gr
         23zomkzMHx7Ne0IT51VOdGxNAXK9E5uWy2fZMZc8U9jN4CrUPNPuXql511wicGDzTsVt
         zRfQ==
X-Gm-Message-State: ANoB5pkuHfSX1QtGOSbfc+P/Q4ruP71HFLrpobprGppas0lstGudwCdC
        qtq90d1czmDnDRwmYM+qQtde7A==
X-Google-Smtp-Source: AA0mqf4YkGqkbdC3XOsKdSexzQv4WLY6zkV1+rwyB+dCfUbFQnUKTNmpzj4dNQeYKkJE/wgptNTxiA==
X-Received: by 2002:a05:6512:34c5:b0:4b4:c866:676d with SMTP id w5-20020a05651234c500b004b4c866676dmr4522673lfr.163.1669115676614;
        Tue, 22 Nov 2022 03:14:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004b40c2fccfdsm2456447lfc.59.2022.11.22.03.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 03:14:35 -0800 (PST)
Message-ID: <cf5422a7-351a-6780-ff7f-e20bc81f94c7@linaro.org>
Date:   Tue, 22 Nov 2022 12:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch V2] memory: tegra: Remove clients SID override programming
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221122053103.17895-1-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122053103.17895-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 06:31, Ashish Mhetre wrote:
> On newer Tegra releases, early boot SID override programming and SID
> override programming during resume is handled by bootloader.
> Also, SID override is programmed on-demand during probe_finalize() call
> of IOMMU which is done in tegra186_mc_client_sid_override() in this same
> file. This function does it more correctly by checking if write is
> permitted on SID override register. It also checks if SID override
> register is already written with correct value and skips re-writing it
> in that case.
> Hence, removing the SID override programming of all clients.
> 
> Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")

I could not get from commit msg what is the bug being fixed. You just
said "more correctly", but usually things are either correct or not.
What are visible effects of the bug?

Otherwise it sounds more like optimization or a bit better approach, but
not a bugfix.

Best regards,
Krzysztof

