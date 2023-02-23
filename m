Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6576A0900
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjBWMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjBWMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:54:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7930515C6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:54:02 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id by8so5799138ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tv7QDdYDPJqXmqjJw8nCe8CHF4VqMek3OCZI+Cd4pb8=;
        b=mlkSqHje+JjGyigA/7BshOAuVHEMmL8HWy1geye4XeqZG/iSP4yO69uzft6MSr6hcV
         l6cIhPX8MtVOFGBJB0/HR2OpGVRwLapPHEWanx2+Xz+cHB/k8fwwQwNbZOCcBsTomduF
         YAhmBI2z+QXb2AY/IbAvT9l6EUVaznyzDP8gnxVlmb9tFS7loc3hwLIIFSViXSRtscIw
         wFHFsDqCaIhuxECo6A2tPWL+5Zq29FmPqJxpkh3neL68kkR5bV68hJ+XUBNtHdNlTIY5
         SadMipoGprsa0SnzZDHHphNyOndocFY+beezUFyzYWtXG5zPsKSlvtMm/AWUGkHvY2u0
         s5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv7QDdYDPJqXmqjJw8nCe8CHF4VqMek3OCZI+Cd4pb8=;
        b=uM4FZrJ4bZqN2NYoQB7ktbL22aRcZyZPbdyTisxXMfAzlGPk0kzy6qO75JkUMX2lpx
         ay9CQHV5KGKF+dKcdw215CP59wjsFTnkKD0FR75/dQ8gFGtH9Q7jKRyrmMPVUtvv0Htu
         I1g+28V0Mj4icnHleF6o0aBS5pq8s+uEaRPS2UdIsUjBcZ5VU3T9nMNSIQuCu2b5SfGq
         zZAI0C/qDYbo/WYw/ZBHoq4xYCwAiH+MDZjl8JAyeZZZ9hhxfjcpSSxnMSvXtwsHG2ko
         Eol+voDsOg2PFJ8CWMLkkXb36hgSIOONLkl/PuPnNET2yxRyJ2Hp8HwATCDbUfzeJ6b4
         tqEg==
X-Gm-Message-State: AO0yUKUQNIWRAt43uE+auxE+hhl4qlbYuEqbgH+aSrUYsyPsGeJN6WrX
        acMF3hID8yy6DAoobMB8m4aGUlj/vRnaeQlm
X-Google-Smtp-Source: AK7set9xO2qBcUzUqsQUijeCUxxeEVruJPasKZUluFH6lIi2vW4rnuaTgCabwWZjUD9HCKQiMUCOCw==
X-Received: by 2002:a2e:509:0:b0:293:4ba1:a78b with SMTP id 9-20020a2e0509000000b002934ba1a78bmr4813449ljf.25.1677156841121;
        Thu, 23 Feb 2023 04:54:01 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id b11-20020a05651c032b00b002934b8d115csm1161213ljp.51.2023.02.23.04.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 04:54:00 -0800 (PST)
Message-ID: <78f9f327-283d-c7f9-b54b-a54efd1d264b@linaro.org>
Date:   Thu, 23 Feb 2023 13:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-3-bryan.odonoghue@linaro.org>
 <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
 <f852bf35-6f29-a91a-00ab-9f7b2d709328@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f852bf35-6f29-a91a-00ab-9f7b2d709328@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2023 13:51, Bryan O'Donoghue wrote:
> On 22/02/2023 17:08, Konrad Dybcio wrote:
>>> +            interrupt-names = "wdog", "fatal", "ready",
>>> +                      "handover", "stop-ack";
>> This should be a vertical list
>>
>>> +
>>> +            clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>>> +                 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>>> +                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
>>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>> +            clock-names = "iface", "bus", "mem", "xo";
>> This could also be one
>>
> 
> Sorry what are you asking for here Konrad
> 
> clock-names = "iface",
>               "bus",
> 
> if so, why ?
Yep!

It's just easier to read.. you don't have to count the
nth entry in a single line. Maybe this specific example
is still easy for the human brain to quickly cross-reference,
longer lists or lists with longer entries than 3 or so are
confusing..

Konrad
