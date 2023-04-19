Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BD6E8213
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjDSTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjDSTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:46:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FC524B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:46:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xi5so967146ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681933567; x=1684525567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnojFPy5RTEqRDct+HdyhHqsL+VmjmztLl0PLEw/hhE=;
        b=G4zRGoAv5Q40HURFW1PVwlBZ9n4aW/FztTLI1kq2TGWD8hxZfrOWbxWWdGVK/M43P8
         thq3OUWBRBj96Lr3teS+Ff5xZyY1Upc6N3MZyR1pS/b55gPjOTpzakRwYlsNC3/yq5EA
         RHo/wLpe4p3E9hnHIrrZJ4aRvFGhR5cgf5YQE0CpeMYCXkOuQr1I6cHAHt4JiKxOaK0R
         R10vbzugJdEKL2z+VRQizWV+1wvzOVAn4iNB775qbJ8nthn+Y3q573B4hYsk4mugUdYi
         ZkEBAymhzRybR+EZQwBQ1WCXGtAEB3maTu2+mJ/HP3KmXpk+UmnjzfschH8xAYRfyaCa
         CkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933567; x=1684525567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnojFPy5RTEqRDct+HdyhHqsL+VmjmztLl0PLEw/hhE=;
        b=kD5XOyRW+KCk5YgChgCfvSd7wQG1NDB34xbsvBytm/YnkkdfMAzneaO/nlN/QL833i
         pAhcyWmve6IxJtGEn0XBSWZQs3ncona6rhFDyEpUqpZ2vbo7qOUWFdGiABACrZLLxLw5
         VNoIqMkkr+PEpAqIimepy2KNVD3GFWd3lw8BKRe0j2J8Yu2SglNs+oAMO8sYzhmS+tyr
         D8j+Xs3vyJIwmRnGEmEbSHRPGbPDRCWxZE2BfXFf7oD9bFWf65J4kmgxl7Le+xY+YuZn
         bWpL6luDuoEWuhpiwb6mgo11fYDzHpJdKb6ik7EL65SluvcWc/qrjuvh5zyDwgzz38Uw
         GtRA==
X-Gm-Message-State: AAQBX9c/srq7SoCuLm8liSeCLVUAZSuZzhBCRy/zZmJx3UXAgPhWOvtU
        B8OtvFNobbxYg2oPZ+Aa0BePww==
X-Google-Smtp-Source: AKy350a48tYBtw6AgdUuQuyA2+jKVWfuCW1oUOTTZQ6v9GJcRr/W2CyIfEVv6HZSYkFNR7wDckiLUg==
X-Received: by 2002:a17:906:71c5:b0:94e:e5fe:b54f with SMTP id i5-20020a17090671c500b0094ee5feb54fmr18322784ejk.23.1681933567148;
        Wed, 19 Apr 2023 12:46:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906779800b0094edbe5c7ddsm8366821ejm.38.2023.04.19.12.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 12:46:06 -0700 (PDT)
Message-ID: <689e05e5-5c1f-9417-b2be-988c6a6d4c5a@linaro.org>
Date:   Wed, 19 Apr 2023 21:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419035646.43702-2-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 05:56, Changhuang Liang wrote:
> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
> rx/tx power switch, and it don't need the properties of reg and
> interrupts.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml       | 15 +++++++++++++--
>  include/dt-bindings/power/starfive,jh7110-pmu.h   |  3 +++

I have impression I just reviewed your v2... Apply the comments,
reviews/acks etc from that email.

Best regards,
Krzysztof

