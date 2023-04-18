Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E355E6E693E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjDRQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDRQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:20:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F44C678
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id vc20so19706596ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681834787; x=1684426787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZB3of5nwzmdnHO4GEgYjYDmRaGa0m+b36yS3CIvEJQ=;
        b=QpMngbEiGVZF0XZTmI6+TLl5AjJ8gUT9SUW4BuazUb6FBKKxEZEn6imFv9pxIQWRti
         imv9R4dOmONMg1eay7z6kg+vJT8OE4KNYgqF/ClzkG20YuDnPoufxqM8Wx7yBd8T+8T/
         D7GLBwd7ueqfvfokaaPV8WT/+REVECvNVCR1waX7eeeQxMytofeoA1Hms6M1MQikNw+K
         Dlnrxe8kYNN8hSEjX7Cq36u09qoFJZ8uqctRHzgnr5ZZSVqD7sWS5iBAfW4tGpdnEMeJ
         LZ9cgJKtd3jizs3OZf8J8HmYk++8jB2cxQfBQE8dnkpe5imBA1O6u3gCnOGfRGX/Wa8W
         SycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834787; x=1684426787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZB3of5nwzmdnHO4GEgYjYDmRaGa0m+b36yS3CIvEJQ=;
        b=a1vLcISPDWPq+/sPYKLydnGRnIwlKaiDw8IN08pxJBnN1onbcpB7bNDKuZYa85aiaB
         It0B0yYfB+7CtYG1SqpONQhNiddVoZteGGJ6c5RQq6YOsTboOGHkHT5CRLviIPlCH5Od
         CM5arzXMOSbM5QAD36jmMOQ+t/pPNBDDSJcNcPXAVI5s5NvH1U21J26XKHvojDE6IYyw
         Nft7hWk8NtnDP/CtER+XNXxYVcBbXITIDot0g+30+cXwl2nkdj4ntUF9dKOIfG3LyxhJ
         mCJC0mvrODJvCweDQgT7KAwq+KMDAkhKWtwEypnEOyzjd1Xv+gkN2zlt7BxOBWUnwn7R
         3QIg==
X-Gm-Message-State: AAQBX9du45dtR53+uZecm8u6iQhBkOPTiFJ8DQf9brWUz4itQGAd4D06
        /YuFS2wAQmZfoo+ytIlyZQM4Dw==
X-Google-Smtp-Source: AKy350aiZFhGitVDEerbV9PnSTaboFy4MuHQj/BaI+bPDBGfN+fxdgSfFOtqdnMeV1evU8B1s7GsGA==
X-Received: by 2002:a17:906:3844:b0:94e:e0b7:96d6 with SMTP id w4-20020a170906384400b0094ee0b796d6mr11862141ejc.14.1681834786931;
        Tue, 18 Apr 2023 09:19:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090681c500b0094f7092c231sm3392246ejx.6.2023.04.18.09.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:19:46 -0700 (PDT)
Message-ID: <992e4e50-f074-6f2b-22f9-fc39e76c8eb1@linaro.org>
Date:   Tue, 18 Apr 2023 18:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: qcom: Add RPM Master stats
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
 <20230405-topic-master_stats-v4-1-4217362fcc79@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v4-1-4217362fcc79@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 19:37, Konrad Dybcio wrote:
> The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
> statistics. They let one assess which core is actively preventing the
> system from entering a true low-power mode.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

