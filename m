Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3964B9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiLMQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiLMQ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:28:54 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0118BE0CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:28:52 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a19so3880459ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BKM1yaSpO2F/9rcLtvk3MSuZww5cNtsf6O19/BwS04=;
        b=Xlj8+HzZQhe0hQFpZHwzX+Vj3p44TM75spyT2wY0wbnV6cH/plThO93r9tGQAQk8/n
         7X/5tWX10Q80rCzQr6Z1YuJxt4YCj9EmeMnTV1Hve6ZiJTJ69yjJSMoAuRyLvL47H4Li
         4Zt+l/xIPqRKjymwjngGDdOf1ZPZj5oO69rqRFg6YP4XvUOVpSMOfjchT1TQjeO5q/OH
         QwN9MI54fEvxL/ZpK4NxIB/zmzGbHnNtUBcZsVOLJrO0yG6DbDvSgvp5E8T7b4TXE3n0
         jDsiVc/qAzjyxx5ZhXDb0BqY7Ah0M1sKIr2EaCdmTeUMuBi2tayVsCZMbZ126LXxeO5v
         6NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BKM1yaSpO2F/9rcLtvk3MSuZww5cNtsf6O19/BwS04=;
        b=aVp+KiFrQf06AC9BtkHX4gPvsaunnA4bFYqllemJzCh4hQAoOLjmDES9DCbtIBvVFu
         mLkIiC0i51hj73EiWz+FkIDgyzlN6pR/c9QG8aT0xoJMCnaD2XTLGpnqC0vjbFaQULr3
         xEY5WntjzU7hSzKwluLiRkneEgZGV2R22HYwDYqTLZiKt4hwbweGrxjGPfIXR4c6bwks
         IY+cGQvUJzts1Nn7sfsG2sweeF1AAycE1opn/pNTiRHe+rAkW0fUoLu/6mFsefXV3twO
         4fNfffkStIq2ox+6kTtL+GPkuPNwU6lyy5DhMIl4BJIlp4SqiYNZiV2fA5CK6PPSMaem
         tlLg==
X-Gm-Message-State: ANoB5pmZnWAwv6JbURZ/5sIAy+EFvsdaeGbMNCCyX+pBmKT+fAQa9Hcg
        qwSDz5Y9F7xFvemTBiU9/DuuaA==
X-Google-Smtp-Source: AA0mqf61+gF1k/RQV08fLGUxrudTr1ZvVVOsBo8VxsGZdBDLq+nmPkAk3HaCWd1y2LH8GBAX5qMLuQ==
X-Received: by 2002:a2e:87ca:0:b0:27b:502d:525c with SMTP id v10-20020a2e87ca000000b0027b502d525cmr2477548ljj.52.1670948931419;
        Tue, 13 Dec 2022 08:28:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b15-20020a2eb90f000000b002770f0a742bsm321463ljb.41.2022.12.13.08.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 08:28:51 -0800 (PST)
Message-ID: <cab9c51a-01cf-3b0a-cfb5-314fafa397c7@linaro.org>
Date:   Tue, 13 Dec 2022 17:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 02/13] dt-bindings: arm: msm: Fix register regions used
 for LLCC banks
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, stable@vger.kernel.org
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212123311.146261-3-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221212123311.146261-3-manivannan.sadhasivam@linaro.org>
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

On 12/12/2022 13:33, Manivannan Sadhasivam wrote:
> Register regions of the LLCC banks are located at separate addresses.
> Currently, the binding just lists the LLCC0 base address and specifies
> the size to cover all banks. This is not the correct approach since,
> there are holes and other registers located in between.
> 
> So let's specify the base address of each LLCC bank and get rid of
> reg-names property as it is not needed anymore. It should be noted that
> the bank count differs for each SoC, so that also needs to be taken into
> account in the binding.
> 
> Cc: <stable@vger.kernel.org> # 4.19
> Fixes: 7e5700ae64f6 ("dt-bindings: Documentation for qcom, llcc")

Also here there is no bug explained enough justifying backport of
bindings. Additionally, you effectively cannot backport bindings -
bindings from previous versions are still defining the ABI.

Best regards,
Krzysztof

