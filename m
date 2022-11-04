Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708CB61986A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiKDNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKDNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:47:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F52F67C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:47:18 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e15so3040252qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7WseZRfMElBir/cLk2JQliiFaWR+DdJpgj5HlfNINc=;
        b=aInlDUycJ9stGOQ6sNTM+uIgV0KRZL7s6M68oHhc/YoM9U5BqzyAomesP/Sj+Wr/22
         WollcOSLAbZi9hbxHsy/rqLH5BoWyJAaQS+mOTHxTT+H0FdBPjME44F8W+xGcIk4dDfk
         8rpm2zHbs//JwMzcDr2FPThODj+A9Fu1o1SGwenIoq4rjZRsee6JzUbjX3mXjkDiZdIW
         vILgo8knX1lCe15B2REdpPTOtMDOghaPl81hC+v4xj6t3mK/DAVrnUsiI7sUdr77NiIs
         GLmPW1pYtKJ8zpb5d2dHVpzELbhKLgLGPB/9bGHF2fEc6kw4PTKUr1J40pjPgugMjXol
         Zf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7WseZRfMElBir/cLk2JQliiFaWR+DdJpgj5HlfNINc=;
        b=vFHjQEYQNRxe2/wcM8sbQGSuAwptbFD4YF50elUM2oNbYoFJ3CwB8xAcXGep0bDCGU
         2YtyU9t0BT82NrYFoU2wBfzm/SLyQKxOttx1RPxRSDmudPhyiEkRZMSV5Jzy1nKsX0q0
         pNkmsMhBT9ejFnhLJcdGCfTPr068SYv/EZgcgiXfYjcKcSvfLxCkYPULAV1ac3lP2dHA
         euy+d8ynwj2gnQaXzjfKrlDX4/P9wG+lucNh9Hw3LWa8pwKWj1YwkElCV/9tVkS3o9DA
         Ls+lvgnM3C5fv8QFDGtlL28TtYCJEHgDG7zaYOOMTJUj7YcISzek9cC/UMT1FNP/E4XG
         3LpA==
X-Gm-Message-State: ACrzQf3fUvypAAFVuO2Y6az3/Ktn4lmjuy/7RAwA67z8FwCASgXl2t96
        7KcUECjBej+ojZ/npW64UxN5ZQ==
X-Google-Smtp-Source: AMsMyM5D2EICh2JE91+aDvxWc6mBwjjHQuWq2+0QafbSqJU3b4BRMSKagNhRlqnN+mXAfVcHcXLJaA==
X-Received: by 2002:ac8:7457:0:b0:3a5:4193:e722 with SMTP id h23-20020ac87457000000b003a54193e722mr13997029qtr.415.1667569637708;
        Fri, 04 Nov 2022 06:47:17 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b006f7ee901674sm2986683qkb.2.2022.11.04.06.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:47:17 -0700 (PDT)
Message-ID: <39aac9a0-a2cb-af98-8274-93ff0a7da095@linaro.org>
Date:   Fri, 4 Nov 2022 09:47:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/6] iommu/exynos: Implement shutdown driver method
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
 <20221103195154.21495-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-5-semen.protsenko@linaro.org>
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

On 03/11/2022 15:51, Sam Protsenko wrote:
> While remove method shouldn't be implemented, as it can't be done
> reliably, the shutdown method can be useful for performing a kexec.
> That was inspired by other IOMMU drivers, see commit 1a4e90f25b2c
> ("iommu/rockchip: Perform a reset on shutdown") for example.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

