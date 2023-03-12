Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812266B6555
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCLLSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCLLSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:18:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C7CDFA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:18:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so37907228edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678619884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G853ILuu+sQv9a+0BB1tR04csQhtS3EQP3WsfLsCtaM=;
        b=r6+3H18NaXCoJwmD1kOtzMr1pR5aWEHs8IGXEWpspHhQONeRwM2EbmME0NynGLzXWV
         k5bOVKy64/Id15Ff1jOwjS4BfWxTip4OOoZ6sQ9FS+ahXLuBWDMRtHbeMN8CgHxbcelN
         sD0IecGS+/Og3LLSXKbch/wsDwrxWXxNiq+FUDQG9+YuvRI2O/RWpkPcghK/sfNdrXrj
         8wlOC/Ofscfjyi91VtMo4z/5Dc6f7B+f4Kp+ChqtVqisx0uij7/8D9u/JOySBQoyueW9
         9SV0PXX1WgTr/XHwKhFc3+l7memXUrV8p5nVoORoWFDQL23If0uoN11xDxSdUwVq+jEZ
         YtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678619884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G853ILuu+sQv9a+0BB1tR04csQhtS3EQP3WsfLsCtaM=;
        b=Dmmn/TBMdq+PJ9zISYz4cdfO4Enrk1tV8aSCZ1XP2kLEZ4vKqh/pzRaMHeM8RV73Zf
         1crW6qq1mkg6pTgpqKVc4SE7WGrcCIZjrqKVoP5hlkaIaoCyhyhfqbh/nYMRgB19oZbN
         i9e9TvrckE2n+hcO/TcOYx73Zoac4EhsZn//P772+AuduvigTdTpq8pV5gQKhrTLopOA
         DiTNnrGebVNpFi/OYv2b9mIKhfz8Vi31Bk1HMgCR2bXaYbV3ZqbaX78sIcEGciVoFqqt
         +XcP6B7FWVrDacaqxohmHzcHyoWECuqs6hBXDiLGaeR9j9e+pe82VXXZoWIIhTkAd5kS
         DVqA==
X-Gm-Message-State: AO0yUKV5fGTW4kSuShCQld89fQSKe0LbdQAq2GpAd1rw72Dif297ao3A
        zZgkx+OdM7HI5MMkuqTAvV9iPQ==
X-Google-Smtp-Source: AK7set8V5euDVs9uhpdcYEjJ1CaThkXS/gSQkFc3mYuSUaaEMAByufxtLmQWsUvS2DZz/7M4EwaPHw==
X-Received: by 2002:a17:907:2beb:b0:921:5cce:6599 with SMTP id gv43-20020a1709072beb00b009215cce6599mr3483259ejc.41.1678619884602;
        Sun, 12 Mar 2023 04:18:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709062da200b008cf377e8795sm2106315eji.199.2023.03.12.04.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:18:04 -0700 (PDT)
Message-ID: <85921a58-59f1-ab35-d3bf-3a6174e6121a@linaro.org>
Date:   Sun, 12 Mar 2023 12:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM7150
Content-Language: en-US
To:     Danila Tikhonov <danila@jiaxyga.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davidwronek@gmail.com
References: <20230311231733.141806-1-danila@jiaxyga.com>
 <20230311231733.141806-2-danila@jiaxyga.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311231733.141806-2-danila@jiaxyga.com>
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

On 12/03/2023 00:17, Danila Tikhonov wrote:
> From: David Wronek <davidwronek@gmail.com>
> 
> Document the QMP UFS PHY compatible for SM7150.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

