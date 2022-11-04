Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5A619870
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiKDNs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiKDNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:48:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72E187
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:48:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c15so3020189qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FuYaSuLHVjl+nMg8LeVo9P+/juH9VZJxeneSMIJjk4=;
        b=joYPAYFh1lubtvMUJKKM50dbz1msMM8q6QwvCh2ZF8qS0opgo0aDoilvZiLd0a3/R1
         q+XwGT6OX+KHe1xusmSCp6gTs4xYQA3iGGoEEIY0UkiN+ieE4GRYCTtv+FnBqfoRVi0c
         YQPw25Ztp3XlRzsRxg8KU3lDJT/M/Kf8M7HFWqIDYieODHwA+Cw/DaLW/57Gbl6ExqAQ
         mKiOS7Q2xeuXxSWN81DDbNwRdZDSRSlKmkLvgyHWy0cxMoof5QOdaWl6Kdafr2HWF0/F
         UqVopqAQja7CW2NtZ/RxZ9Ca5JIN3df61F4SDrPqoCNbPF0Bz1UVnepxZI7GDU4hXSK5
         Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FuYaSuLHVjl+nMg8LeVo9P+/juH9VZJxeneSMIJjk4=;
        b=aYppn8ShDamicyU1EeDC/8d+F5g8FDTNd4z4UmtbxiQhhn5WVnybPWMMPlcH42IJ4e
         wTFovrvSe7nWJC30hGn3sElQBYbH5CFgvRmzFbtOBjE0tnphmuHenal/KR9iCFxv3rgc
         IS5vDRP0DyZ2ppmZPI8LaFlpHtgnVtHzmvsHym/KJb3RpJBV/zIvwyoJ8Z2/+Ry5vywI
         K2HeHCWn4e93it5omNL+Pdr6HmV871RzCrk6YPlxs7SCVautGY9NyVa3M7/HBcQouzhu
         hsD/vU881LLuh0313E4rj861g+MMzYDi5tDJkTqvDgDM5hIle2KY4bIi0fT3R2s6x8xO
         oHWA==
X-Gm-Message-State: ACrzQf0NYaiY058oXCNBWQ7x1BQwpQqwHs3bEHgJDCoNeTeFysoz1PB6
        gsgqJEOrO0427CG3cKLZdN12fQ==
X-Google-Smtp-Source: AMsMyM5GOMP8UcKyjRRp9D39ozG1zvgW3zu/OM7VYx623n8kqqwZBN0eCD4+ZfaJNF2wQG+kvUtNFQ==
X-Received: by 2002:a05:622a:1304:b0:3a5:f04:5fe7 with SMTP id v4-20020a05622a130400b003a50f045fe7mr29245810qtk.158.1667569701917;
        Fri, 04 Nov 2022 06:48:21 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id e13-20020ac8598d000000b003a57004313fsm466229qte.3.2022.11.04.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:48:21 -0700 (PDT)
Message-ID: <52abac38-b395-dddd-0c2d-886307b8e2d9@linaro.org>
Date:   Fri, 4 Nov 2022 09:48:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/6] media: platform: Use IS_ENABLED() to check
 EXYNOS_IOMMU in s5p_mfc
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
 <20221103195154.21495-7-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-7-semen.protsenko@linaro.org>
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
> Now that CONFIG_EXYNOS_IOMMU can be built as a module, it's not correct
> anymore to check whether it's enabled or not just with #ifdef. Use
> proper IS_ENABLED() macro to handle both built-in and module cases.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

