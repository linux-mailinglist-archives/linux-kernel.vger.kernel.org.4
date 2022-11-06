Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA76A61E19D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiKFKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKFKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:31:56 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595765CC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:31:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so13086178lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UftRfa3QhbhyOprZ4+CKBvpNeumWx+igfcF1C3LmJVY=;
        b=Cvz8oLk4SsKXl5F+x9SW5YnyuwhaCtODAZY8kY84ih56i/IaZBTk+/TG4s5Fr1czXq
         UTiyKE8+r3H8sHGKEQPEB8udLqyQxToLFdqc7tUwP8aepAWxcBb/dVjVwADphi/G4dfj
         WgsDzyhOFtYHH3BcJDDs3rrIfbOQ3nFI7y3Dqoa6M8Zdi7jqvEqAWjy2d6KPOlgK8B7B
         V4A23ysd4SUGk8NapRan7eMVe4Myk1gABP42bO7+mFEW6uEy86IRBkyGpLtAFThBlzLj
         PGy85Q1jejG7rSbuoaIy6ICzizVgqwopAPj+LDxj/WJOvx+ap39mUfZPhs8B1J5P+hzV
         SUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UftRfa3QhbhyOprZ4+CKBvpNeumWx+igfcF1C3LmJVY=;
        b=utBo+SxghVDStOs0QgKBOFzn/pROSOKPWih3S5RLHnZPrTPg8Lpd1f06BsM32piyrZ
         PH3F9YrpIvOCrNzxbbVMsqK+Mf9C6KOHfAKFgRjlzxRNri+Oe/dhT5Ewr1Vb2APqsI9B
         GbfJze5Lucc7K2axXgvcR0rL9VNItQGTLvZpfelG4qgamLKuhYIpclkY4Cg/tLtMofh2
         gTMLsG1fikwmSf4dJ7dnv58PXXJdKO7Fm10vN8t1oxJArjLZU7840jpNEuYN2c3PIuPo
         RTSVIkiII7Hlv8tHctr1wcth5CMwXbmYRicxAJb3sXWz8vPMEWUNLFfDKpLUY8B3Txi2
         atoQ==
X-Gm-Message-State: ACrzQf3MBRG+eu7GiYLKp0rjx+3jqJRflsGG4BQeEDIr3qfLVQXINDGq
        eu5q9DaL8NrqBOqTqO0UyjH38g==
X-Google-Smtp-Source: AMsMyM5Kk+BtTV9IVoS24c7DgzHU0Q1H9UcqS7YflJrIjKfsemJoIFMHy5TXVVNpn0CEwRONBMC+bQ==
X-Received: by 2002:a05:6512:503:b0:4af:1cbe:1ac6 with SMTP id o3-20020a056512050300b004af1cbe1ac6mr15096844lfb.651.1667730713799;
        Sun, 06 Nov 2022 02:31:53 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id x41-20020a056512132900b004ae394b6a6fsm633564lfu.246.2022.11.06.02.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 02:31:53 -0800 (PST)
Message-ID: <7f7f94a8-0547-032a-3fd5-4e0899813d6c@linaro.org>
Date:   Sun, 6 Nov 2022 11:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom: Add missing cache related
 properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104162429.1981729-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104162429.1981729-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 17:24, Rob Herring wrote:
> The examples' cache nodes are incomplete as 'cache-unified' and
> 'cache-level' are required cache properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

