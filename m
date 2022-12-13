Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F864B5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiLMNQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiLMNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:16:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B081F9C1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:16:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so4838218lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nk7V67NqkfhxlcRmYR5VUsDrUp2sRqPhIHzRz51wY0o=;
        b=AlOOTh8Qy6Ibe6LMNjR2UIBnCLOjDuBZCV7ZQG5MhgayawVo4/L7jvh4xWcw/yLhFS
         zQCq6NTiF3gKL8yq+rvcx+nRnHXT9y0GHN2C5bCbybTdvRtQbE+vuKDaDVNyoGNxwGuy
         3xcZuXJGeCv6NI0YycsK+1kIFVLCFnRTZ8goT5AjiYdJ9rHxSn93fwaA4YXrXsnBInzk
         YDEleSAONkGMx/I5M2vs95nuXpKX/9Ijguyj8twG6jNJN76yyYuNt2hTtWVSR5/rQ/qP
         Z60uqtGcm9V6PqKdzn/SYw2UVm4v7LR/mh5mcqkdrUwkohSxhOLJDYK9I9/ZtHOYmVJP
         gbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nk7V67NqkfhxlcRmYR5VUsDrUp2sRqPhIHzRz51wY0o=;
        b=BTfqmh2luFntiK259vKpXDDjIwkN/sX4kTor0Cmts/xOFxFoaG0gP9z/yLs7ORK4rr
         1Hhycs2Bm12fyFyInIoclCTBx+m41Un2VqgujCykEklugyvkOMoSthjrIX3Ax5A4VU34
         +l+FTMbh88VQiwGxij+R6YVv+rYCYYSC3hmwzUHwbHKnmUZ/LKwSui7Rb7UXr+5LFbwQ
         9oAMJf3yIA4ceYRnz6RGFN6ze7W87cR7MMjibW25/PcsVfozjnq97btASHFbomI4bjTD
         PDAKvxOCekV9y1hWeoN32inz5SjIsJKCOBBrYmJWVfw3vxJmuFPvqbPveGuA8GKR/RKw
         RWOQ==
X-Gm-Message-State: ANoB5pmBpMVSrS9mSurjngurhgA5ELDFjDSepZA+sObyhG7sP7jZxrlM
        TxMojSh/iYbvqpvO+RyM3+jKGA==
X-Google-Smtp-Source: AA0mqf7nh1NXqJ9pwWgyNupyDLA6nwnbddNcBVje5w5zxZJmUktBr88K+LRM5LiMhEU6xzNg3Vp1kg==
X-Received: by 2002:a05:6512:12c3:b0:4b4:bec4:9d5e with SMTP id p3-20020a05651212c300b004b4bec49d5emr7202453lfg.8.1670937400157;
        Tue, 13 Dec 2022 05:16:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s25-20020a195e19000000b004b55cebdbd7sm365311lfb.120.2022.12.13.05.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 05:16:39 -0800 (PST)
Message-ID: <3958f93a-474f-b18d-385a-3ed163558c84@linaro.org>
Date:   Tue, 13 Dec 2022 14:16:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/7] dt-bindings: nvmem: Add compatible for SM8150
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
 <20221213002423.259039-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213002423.259039-2-konrad.dybcio@linaro.org>
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

On 13/12/2022 01:24, Konrad Dybcio wrote:
> Docuemnt the QFPROM on SM8150.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

