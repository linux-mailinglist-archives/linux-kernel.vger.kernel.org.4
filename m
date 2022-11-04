Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45E61986E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKDNrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiKDNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:47:48 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08F2F664
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:47:45 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o8so3202600qvw.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CM7N46suxjlkNYhX9NO4Ul3ikAd8Rqs9FVmxwGAUjTo=;
        b=Lsg9EiySkerNQ8AIhUxxP3jKQBEMlVQj/ClzJkwgQbruf4Dl+KPoYEqo+a4fsHWo/e
         ATJoivLfCbI/0J1brbVayBQBWzr913NspfeAmBvmu46LKpU6Jtutlv7olOlq+43cUp+j
         OwJA0rxDljKtR43cyqm2Q3REHnGCYNeWlhy6H+3Gb5TeFX6idbTr4tzhW8u2uom6eSuy
         C8Pyeat3SmnUjAo4kNsvedcJ1ZgXDa9UMwG7EXqITUjpv42fCn9GocKh2epQBRZBikDK
         YSfvmRAK4iK9XM6KQP7M+I4Gyq+0B7OFfxdXxzPjtlB4iMyTrpMBDKVqrDXYO54PjZm1
         ZLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CM7N46suxjlkNYhX9NO4Ul3ikAd8Rqs9FVmxwGAUjTo=;
        b=ZGivo+1t2yIdVsUwkHKdbsXU1saB8nK06aPH6fwz+pFyRbW6csXFrjSk0+N1ZGHInU
         XXhDWdLJ+PrE+x1pfsyZ4749p3KiD1jjH4Uxk5X8geOsi9g7izAhQLQP1bdMv1+NFnRt
         VMohp63wNA/Pih1u8BxKhbQZX6h7fV+uZH4F64bHiHwxxqCAt2EkHHfH7sPYnmUQJHuQ
         7l0iJGC+AAD7SXK7XRYlyvpV2PbDPHhSOm5AHeXlTRjPXIOtHwNTnxZDpJT5W8sLqona
         qpatg5RZZ+cfl6QYsgEP32EKF3ddgmsl13KHtkthx2N9jBDsACHPfmrT+CJl8vJa4j2X
         KLaA==
X-Gm-Message-State: ACrzQf1jWacPnwjy/6CyNXjkOwfuCjsoCK8+jwnT6v0ZWVrAY+yzVk+O
        pBviGweS/I1oYnF6amTUofNypQ==
X-Google-Smtp-Source: AMsMyM77AReF/wBx0e6gFLt/5xpjtSZ5rKtqgb9PYOOUDM7YkHUM9Wbi3IQYP/3CMGCV3p95uw2Vwg==
X-Received: by 2002:a05:6214:4119:b0:4b1:af7a:7f67 with SMTP id kc25-20020a056214411900b004b1af7a7f67mr299221qvb.67.1667569664302;
        Fri, 04 Nov 2022 06:47:44 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b006bb366779a4sm2931211qkb.6.2022.11.04.06.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:47:43 -0700 (PDT)
Message-ID: <fa4e1af2-8b6c-b7cd-d20d-eacb17ff51ae@linaro.org>
Date:   Fri, 4 Nov 2022 09:47:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/6] iommu/exynos: Rearrange the platform driver code
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
 <20221103195154.21495-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-6-semen.protsenko@linaro.org>
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
> Move the platform_driver code to the bottom of the driver, as it's a
> canonical form for that. No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Fixed checkpatch style suggestion with "--strict" flag
> 
>  drivers/iommu/exynos-iommu.c | 361 +++++++++++++++++------------------


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

