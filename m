Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2766B6B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjCLUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjCLUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:50:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2D303D4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:50:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so40944144edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkPNb2h9ArxyU/K1V2NNDmtwj5NEkbm3Va91EQpsjgU=;
        b=bmgaDqwgUuUIauluRHOaPr/8//i484hXAcyOmhixJh4yEdJZijqWG+Hv+ZQw00HOb+
         fnwLtNkVd1UvEAW5Hj+7IU7EEp65Yv474KHYqYgAI4a5JwDAGrwPFFiYGt8Ba5aGbzL2
         VkuTGrSbffLY3o+VV/nBGYdIeslfu0qgKhxXF282qyLQJdIDcrI5Km+aRhA1PDi0vr9X
         IJAt9dn9g3hs0RVQ2ZmtF8em28QcHQn9x+3HuRHwwsvfPMnXW8r2vFmd3DSiEVstAee0
         FQ7KWjHoriYa9oBEnWOI6PW3CGUnqzKBP3KZNGvYy7n0w7upyyGljpUJ/BS/QZ5YYxqO
         r3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkPNb2h9ArxyU/K1V2NNDmtwj5NEkbm3Va91EQpsjgU=;
        b=dLFG1HcGBE47rHzjQKsspys92GEVJ0GhDeyRYx3Tm+34PFQghsGTzCqr7SKRvIsGSQ
         EvDzB2DE5dRl9WUeqwJTy+zoPTiFY3Y06bmPTk2T77sbLxCJAKV+ujyl3Hg+BYPd2z1H
         0xFMyM0R8RPOdTc4xgEmUELic0ZkdJHkKDuzd7nDj/IRJVwuVcQ8G1pzE0luN5eUG/tN
         X9olOcvfyqg9rUr1tmQYKWSMqxpaTrxnuFhEHQ/iFjeESN85QCIUuA/qcWWvsZRuHs6k
         mOhhjHfdVjJWYAcbUGPiPLdVo1iU3U8qFat7T1ViDsrsOODfHw/ZVqq53bx3YOS239bo
         TqOg==
X-Gm-Message-State: AO0yUKUBkNFheLynEZM24wAXjyZ9W2iQCd3TLysnD/HUgYi0JNkbALPP
        f3Z009xcNOT5jSVqHGPZOKO4TQ==
X-Google-Smtp-Source: AK7set+GX2o0RWXwvGCvnmDrfO1MgqS0aAq/BKRTPPcz0J9IHu4JSbqVTz/77Wirbd0QqPPLXiUK3A==
X-Received: by 2002:a17:907:6d08:b0:887:dea8:b029 with SMTP id sa8-20020a1709076d0800b00887dea8b029mr37794991ejc.1.1678654203108;
        Sun, 12 Mar 2023 13:50:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id sa41-20020a1709076d2900b00909f7f28ed7sm2627406ejc.16.2023.03.12.13.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:50:02 -0700 (PDT)
Message-ID: <e924121c-4d3c-a200-cd7e-9d07deff80de@linaro.org>
Date:   Sun, 12 Mar 2023 21:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add Yiming LTE dongle
 uz801-v3.0 (yiming-uz801v3)
Content-Language: en-US
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
References: <20230310143330.9485-1-forbidden405@foxmail.com>
 <tencent_61B4697855AD14BA2930AC7B21FFC75C4406@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_61B4697855AD14BA2930AC7B21FFC75C4406@qq.com>
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

On 10/03/2023 15:33, Yang Xiwen wrote:
> Add a compatible for Yiming LTE dongle uz801-v3.0
> 
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

