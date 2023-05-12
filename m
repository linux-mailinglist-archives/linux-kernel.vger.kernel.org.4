Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36157000C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjELGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjELGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:43:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB1100CE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:43:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so86506699a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683873781; x=1686465781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxaww5zmIlvtVxVSyDwsEPWDNKsPXLLp30SmAY8x+tI=;
        b=v76HLMB+iUDchEOB/JUCXSudGB1dASEFT6tZLgwOlmcJlEVZVq7OzDn8PBXeWWUuK1
         /Qqj2db3Kcorl25h7dZ3jtOSTANJF1XY5f4emxKXBUJzjCkgO74cl9eEg3YOO5WEddgu
         yTAh3tr449q8LyhWEGurK5fgvDeD/wu5rmQebocm6FkcyaY3MmXLIWaOVbz+tsAQKQIa
         DjrcLMVNban+gVIdbf8Xtj6jE6AME9e7VoXlK6sROUKjZ84jz6MaHCQkPrRPdSLbEWNb
         LgKg7xV9bhQVMd2t6FfsQo+AFXjkMXkF6tjGdY4UF8tIMLLPyGxhSTtrmupun763cv0H
         NHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683873781; x=1686465781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxaww5zmIlvtVxVSyDwsEPWDNKsPXLLp30SmAY8x+tI=;
        b=Iw4LDOQXj39CxsfG/zV+RKIEXb07JZ0+Smp3fTqVRPIiZvuplVg3pslLkuy1ZbcFhY
         4ZUs3eFu2e62M9bhWrkZAZwIKHdnO8F7RE5SjQV4BB7W36d4RYp4PPrRJ8vBJzZUssrK
         TxKpCDB25PYdbg8Kf4eqexg+7oMtjt7iLJGcu0UIKrt0qv1MeoTxjMQoSDywDeufLd5Q
         unzJ8bDILosnZBCbnkKA3PQrJ6j3lSSPjBTixGCuHrlUq0JLHEfcriTaOCVDtgvRODeg
         MbBWB5+4QukzIoln37ivcmEIlj9NkJob5zyNS+FXQFdzDCU7yvHNt03Xc4/goneG8dop
         E8zw==
X-Gm-Message-State: AC+VfDzTCc2hkQrSFeqaOMT3u9V3cEk2v072SK3Mc/DPGrznKZXDjUST
        74Q09G2B6HFzk5zXP7o2d0Dxi1qZ46MmDba8F2o=
X-Google-Smtp-Source: ACHHUZ6ycHmiH4XHsToL/LEgPN6t/OUnkCcU6vYaCxpgd1NvktvGmuFGtF2cwcE56gEu9X5lk8gU/A==
X-Received: by 2002:a17:907:1c25:b0:969:9c0c:4c97 with SMTP id nc37-20020a1709071c2500b009699c0c4c97mr12717759ejc.1.1683873780685;
        Thu, 11 May 2023 23:43:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906265300b0096595cc0810sm5044912ejc.72.2023.05.11.23.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:43:00 -0700 (PDT)
Message-ID: <ec21f9fe-7417-1865-bb9f-6e18584ca1a0@linaro.org>
Date:   Fri, 12 May 2023 08:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/6] dt-bindings: Add support for DRAM MRQ GSCs
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-5-pdeschrijver@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511132048.1122075-5-pdeschrijver@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 15:20, Peter De Schrijver wrote:
> Add bindings for DRAM MRQ GSC support.
> 
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---

Same comments as before:
1. Missing subject prefix, so:
Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

2. I don't get why you decided to send changelog to different address -
it takes some time to find it - and to skip other maintainers...

Best regards,
Krzysztof

