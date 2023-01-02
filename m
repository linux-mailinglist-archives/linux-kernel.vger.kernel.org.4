Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7962965AEB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjABJdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:33:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663002DEA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:33:39 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y25so40879968lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I7pG4FzR5B65zHV/J+dBn4KI4CUWo3OwuRAUggAxGo=;
        b=yjU3Jfn5+hNe5Kkv0n5/uOXoMe6Qc6Sedd7OIUaHWmQs8QCpbuLuxKM8AyTVaJGpvo
         8/Uew4hsDKzq5UVQvUF2VOiuD8RYwXBkKbOE1QZRpIAGTtgZ5ZPC6hALj8yP3SkIHTC5
         Ari1iPp1omIHagI8vJf/eDbqkIOoMQKgRNLSnKffdu/DtMCyEFi4Vhk5OP5LbxpFTnA9
         xR1Xt7aep6LsRRwEmi6LP66ZViYXdFC/wzWeo5apmRKBu11mbLzVsesxn+KiF+hNMEga
         ySxAuFq26SkT+AEGLoUU5YNaFAFHKfKrIqyhEkQ3ZmgwA444zmS0hj5+fFdbd/R2T0gE
         1CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I7pG4FzR5B65zHV/J+dBn4KI4CUWo3OwuRAUggAxGo=;
        b=64d3BNxRs8CDYtQ/tpv6zMPaPfoR8cDKuybqrDyvxBo3zXz7QZ3v2YQuEDBLaaa8bD
         EEaY+4nJWI3hx2w3+k4U8txid8HuJUHTgS/sAlT6xxO5zwYiim8Yom4TOGHM5WMOzJ9G
         9ugRPqisTaQ+DdNobCiEDkKcktZ1kyKUvKycsih4VcDCc2Srs/hfoUCF1t/HYGqwQOiB
         mF2e9zOHyyNbwH6R7CoGbP5VL1Mu2c6lqAq0SaTK8JSFMFVR4AZeh4cdSJiziN6X48sJ
         pMdATMS2lpWmN2ij7i+Ljffb31IoJGV1UpAWBSihyUHtOuHrOF8t01BPZfcDfm2D1qTd
         EBAg==
X-Gm-Message-State: AFqh2kq5YOUr7A2yr0mt94yrPi5I+OnAUpjjX970cR3j3Cwzsh8wGumV
        rNLhgi7N9M2YkowC3ItWC9ZrKA==
X-Google-Smtp-Source: AMrXdXt1qGmIko3mm73WYvaVkVl4JeeaENt+GB8PHv9FPsHn5lIxCkGSIqBEr4R4HlYLf5Von4tVVQ==
X-Received: by 2002:a05:6512:3c97:b0:4a5:42ba:d827 with SMTP id h23-20020a0565123c9700b004a542bad827mr12651876lfv.14.1672652017821;
        Mon, 02 Jan 2023 01:33:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b004b551cdfe13sm4408414lfo.279.2023.01.02.01.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 01:33:37 -0800 (PST)
Message-ID: <d664db86-309e-5c84-b170-ac04616dc131@linaro.org>
Date:   Mon, 2 Jan 2023 10:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: k3-dsp: update bindings
 for AM62A SoCs
To:     Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, devarsht@ti.com
References: <20221230132453.32022-1-hnagalla@ti.com>
 <20221230132453.32022-2-hnagalla@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230132453.32022-2-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 14:24, Hari Nagalla wrote:
> The TI AM62A SoCs have a C7xv DSP and Analytics engine for deep
> learning purposes. The DSP part is similar to the C71x DSP found on
> K3 J7 SoCs, but additional hardware accelerators and IP are added to
> the subsystem for deep learning.
> 
> Compatible info is updated to match AM62A SoCs.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

