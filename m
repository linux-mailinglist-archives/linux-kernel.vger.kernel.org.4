Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DC6D1704
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCaFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCaFvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:51:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9654191EF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:51:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u10so20281126plz.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680241866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wX9/b7koIVPz6VnT95PUdHIzgzzQOmwNZn3upcoGcM=;
        b=ouJnCVvWDTIuHk5+ky5sRCb9UzZky9FYdBWqIo/dXeTvVjmKeXup/t2CIE/eiTF7wY
         7AFoOK70v9A/RdAo1iXqrm2QU10nsE7DMJHPHWvtgLJg/rCx8rPKlE2kNG1NY/8oxTya
         cGaO9+SGlXQljrIreVfESptzGZymLsggMHdQS9jnqjyx/I1cn8WXz/TEKBOjXkNk4TgS
         LB5nfPGtrDMO09nGSHLQxTRdzW8DgiHMZrypo5yRpeD6H9pRQ3UKLlRpz/kEymZEeki4
         BdNpBwwsW7r180orMk+Scd0x1ndiqlcbZXm0oDt1c2ryJ6evt+OGo9Du3eeaZsaw8JuU
         H9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680241866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wX9/b7koIVPz6VnT95PUdHIzgzzQOmwNZn3upcoGcM=;
        b=nDfhmW4VPsBB7zfv5oWxAHBFUGN/nBuK//VHNC2ry8dY+qRYfebftr599KLRvL5N5/
         4vnB1mPDzw92JFJeV0UlKVCCByhnIUC33ba36aScEMpRkMUvpD2RhOTz/qidnALQXRiV
         21KTm8KXEXidZVbqxVJP+127mL79sSefI9+ge7NeWjXUYyenGjCU6Q75iKcHvuqKZDsJ
         x2EX74usfp45NZyyuP6VtX3V/hlhuuFfR68kdUDGk6JWp1h2Ty9k82BM/0DYKmnrzq7M
         CQUwADjtI0oVoa8/Gg12mU/Ix21qXNpjKU+3sd+KI6V21rBDwsL3P3YX2lW0gB/mu4FU
         6vTw==
X-Gm-Message-State: AAQBX9d1jux4i/Q8c4VzMB8zgGf94M+f0R1pvD8RuZ7569fmAwlZ2Hxv
        rUBK2NNrxLZFfKI6XGlEwYMNjA==
X-Google-Smtp-Source: AKy350aqRh+PmTtUV5puA137+wYF6fx6R0Q7X3XUjKPNnmlARj9hDJUETxF3KaJb4P5VbZuRuO5Lug==
X-Received: by 2002:a17:90b:2241:b0:23f:1159:c0db with SMTP id hk1-20020a17090b224100b0023f1159c0dbmr28889786pjb.26.1680241866335;
        Thu, 30 Mar 2023 22:51:06 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c5e:53ce:1f39:30a5:d20f:f205? ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id d26-20020a630e1a000000b0050bcf117643sm756372pgl.17.2023.03.30.22.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 22:51:05 -0700 (PDT)
Message-ID: <eb4919bf-a016-fba6-1976-5d45feb40eb4@linaro.org>
Date:   Fri, 31 Mar 2023 11:21:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 3/9] dt-bindings: qcom-qce: Fix compatibles
 combinations for SM8150 and IPQ4019 SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
 <20230328092815.292665-4-bhupesh.sharma@linaro.org>
 <edb749aa-9ae5-81b2-77b9-416810c5cca7@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <edb749aa-9ae5-81b2-77b9-416810c5cca7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 1:45 PM, Krzysztof Kozlowski wrote:
> On 28/03/2023 11:28, Bhupesh Sharma wrote:
>> Currently the compatible list available in 'qce' dt-bindings does not
>> support SM8150 and IPQ4019 SoCs directly, leading to following
>> 'dtbs_check' error:
>>
>>   arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb:
>>    crypto@1dfa000: compatible: 'oneOf' conditional failed, one must be fixed:
>> 	['qcom,sm8150-qce', 'qcom,qce'] is too long
>> 	['qcom,sm8150-qce', 'qcom,qce'] is too short
> 
> There is no such change in the files. Document only warnings which are
> real - happening.

Sure, will fix it in v4.

Thanks
