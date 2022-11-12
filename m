Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C06626909
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiKLLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiKLLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:15:49 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E41A077
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:15:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so11935123lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7iDZL/QujFwMm7jx3Nc9pgsghkA1TlulQ08yEkqzm8=;
        b=O5j4F8KvBvXnQcWiyN7RVK0RroFeorgsDjVrKrVXeUZOcpAjnN+wsAXy2M0KOHCfmZ
         PBmsef2Qi/rk6m5Tf++cB7UB7sxVdl4lDbOoeowFZqfsKqKPxph7goa8uDComO07W6do
         DWHv7anXSdF2yrPbtbX1R2+vgturKkLnOFxNRi2PdA8Mz3WL+bzyw13D3XLuE2iB2R97
         6h5Msyndh91We4UQrFePyCw9zCSb9B6oEfiZA+JBreXN9lIpcn0OOwK+s302MJTGKTzo
         n0/gY96mFJYCz9yx5EvT67zoZSxPrvdgfL86dvQ7cgbP1/pRHyON/uD/yCCOfliVxp6Z
         QZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7iDZL/QujFwMm7jx3Nc9pgsghkA1TlulQ08yEkqzm8=;
        b=enRpqBHfakQ5dQmt+VhJh/LnkIjCne8HpiM0SECJ+Mnc7dltHSoy8Ono9+nqHS7/Fx
         BrLKEsCaEdwT7YvOCH/a5BVskDrvJlgHCeZCo5AJ07b/FouXy1zE+TLKrfsvntp1d370
         WdHAkrSbzV5IvpRJu8hy/GkMbpUr0HigbXFczjw4kii3WAb+tsfjOs7BzntkZ9MV9p7x
         us/e7aizP6yd9D+VP5SciKLhEHXw1t+oyKDLx3vrDeRi+uPGRg7J0HsaqIw4NyT9oy0a
         G4g7ParQo5rABTWWV8Hapi9WO58RtJ7N49Ma28bQ409e1D6rBBAbw2EyUFA6lkVg4KBJ
         kIUA==
X-Gm-Message-State: ANoB5pmCSKMhewGOZP0ZiQiW55J+l8KbBqrbDWMBP9fUXgS+nb8RA7wg
        yXRxtiiov4kBoDOCJW3keqYLRg==
X-Google-Smtp-Source: AA0mqf7UnXUai6cU7HQ4E8RR2SFUUk5skG2m61T7Io4PUYpKkNCirRINVA1LiPCqs48Rz6A84/DriA==
X-Received: by 2002:a05:6512:130d:b0:4b4:c0c:8995 with SMTP id x13-20020a056512130d00b004b40c0c8995mr2229488lfu.326.1668251746795;
        Sat, 12 Nov 2022 03:15:46 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b004979db5aa5bsm825066lfg.223.2022.11.12.03.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 03:15:46 -0800 (PST)
Message-ID: <d0325483-2e8b-7a09-8c64-ebf30619e3c1@linaro.org>
Date:   Sat, 12 Nov 2022 14:15:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 06/14] phy: qcom-qmp-combo: generate pipe clock name
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-7-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111092457.10546-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 12:24, Johan Hovold wrote:
> In preparation for supporting devicetree bindings which do not use child
> nodes, generate also the USB3 pipe clock name based on the platform
> device name as is done for the DP clocks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

