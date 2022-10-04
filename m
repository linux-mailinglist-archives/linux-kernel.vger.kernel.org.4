Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082EC5F3CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJDGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:55:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C82CE20
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:55:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bs18so12662948ljb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zhHds6t7Vj2FDDurokeQYOjyq3ixp4u5MQEpu4pX2fo=;
        b=jqU8ttcDaBtmie0K269Urd3CH8YJ7NXFekdMHkTc2TeN75GnwJt5MmzKPlO9WLL47H
         I7NSu3iT54Qym5w7mY3O9HXPmv1d0QooYq6/itirOiGpqZVaX4jyigKaYDVMdLwpwpnT
         3ng9QbG0UoWbis1inKt5gej06nJZJHdn+zkC44X+bhHTuCZWvmuOVjQsgBvgUHgCKFaK
         fdZeBYW8grP6awCdmGIn/Ox4rG8SfxPfM5OEAi8yVCBlFCTOfnxnms5wBETyeB9vCx0w
         c7QePxmaK9bKMt5FmrSCrgsPX1TBCPZZyFaQj4QfvAGCCnKOKY3sFmqDsJPS7FiZR3Dy
         TkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zhHds6t7Vj2FDDurokeQYOjyq3ixp4u5MQEpu4pX2fo=;
        b=EOn7+EmNTvsPc8pCChE/R4nioqecbQXcOADoFB7WhInQ6I0ntLeX7wJ2KHWGr6Koqk
         tAUnQWavHNbyRwbQriTJzJxsy9s538TVIUeDZw1xLsf9HwaMy+NbAwPIEMf/fm+Iz7ok
         t6HBfQ07tdfuUKnVLLilVHT/kmr9brBgHlTk4SrfopK4xqSg84NzZV788tmCuH7AMOgF
         ddokAPz9xRlR7inFlb6SDEry1Sbfqt5tCGJzz+aCM3vWISkIJVcH7poTB30qwcvUCUkR
         XKAcdCYkIvjgh1Db/6GU3zj09JAZT565Jx/Y6DhO3wuZfgkdTTaYF6Nddd+TiM9zFt+s
         DCSg==
X-Gm-Message-State: ACrzQf2kN5xxkhX5RRkDv1Yf0hVb0bhjG904y0yv5f4qBKLk+1ZLX0S+
        kCUAckdv0dobgY5cKbezzPR+fg==
X-Google-Smtp-Source: AMsMyM5UcCi5dSdpAFBr/Bo/JWakaU2nYEVHh4ZqL6y4akCm2leA7Ow6PmtEqp5ck2DJA+3U5upVww==
X-Received: by 2002:a05:651c:232:b0:26d:b4b3:a78e with SMTP id z18-20020a05651c023200b0026db4b3a78emr8120186ljn.38.1664866526886;
        Mon, 03 Oct 2022 23:55:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y9-20020a05651c106900b00261df847ab0sm1142746ljm.21.2022.10.03.23.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 23:55:26 -0700 (PDT)
Message-ID: <f612098f-e7e1-b3b3-a738-cabccec43bf2@linaro.org>
Date:   Tue, 4 Oct 2022 08:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock
 bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-2-quic_molvera@quicinc.com>
 <37926f0f-e176-929e-939a-cd43a031e224@linaro.org>
 <bb241d46-6f90-8604-e79d-30a1f3527ce4@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bb241d46-6f90-8604-e79d-30a1f3527ce4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 20:47, Melody Olvera wrote:

>>> +    items:
>>> +      - description: Board XO source
>>> +      - description: Sleep clock source
>>> +      - description: PCIE 0 Pipe clock source (Optional clock)
>> Skip "Optional clock"
>>
>>> +      - description: PCIE 0 Phy Auxiliary clock source (Optional clock)
>>> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
>>> +    minItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: bi_tcxo
>>> +      - const: sleep_clk
>>> +      - const: pcie_0_pipe_clk # Optional clock
>> Skip "Optional clock"
> 
> Will remove all optional clock instances.

Not the instances of clocks, just the wording, comment. Whether clock is
optional is quite visible from minItems: 2.

Best regards,
Krzysztof

