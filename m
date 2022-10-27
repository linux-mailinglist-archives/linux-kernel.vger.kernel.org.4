Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857576104F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiJ0V7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiJ0V7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:59:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925F26E2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:59:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id w10so2738556qvr.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7ugP0tq/kTqwapqa/g5RjNpPzZRDaE9uddOPhLuISc=;
        b=o7sW47GHzXAoiD2j6H6QFu/7GUf/pA0/oDdbcm6+sZ9bOmjpAo/qB24B0IowZvt9P+
         uEs+wbUUSlkmnLlVdNkn65fxdk5zBa5isbU+FAL+wpT+pO1YhGTdX2/pgOan1gvHNCPl
         9qVN6T8ALdciWQ3Oo6k2+p55TKJ4AkaLgvxO0mveT+TCFzB/fAyxkViEbfJuupiToNIT
         NQQWZo2QRbvY79zCmS+btF6flLLVtGFS+nGdVlM9nxoJw0C4oyKnyiBlDa+GMxDYAbRT
         Yl7yiRraviHFOwYRsvBF8ogkgaSuOEtsuk8P1O7ywuqYPLFqDn6QWUmaDLBhaxsQL30e
         +N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7ugP0tq/kTqwapqa/g5RjNpPzZRDaE9uddOPhLuISc=;
        b=gl7vCIa2n+MWsncX8SK0SM+htYoWZtU+kR1Qlkp5yb0SslfsJgKASlamw1Dj05/85K
         mCD3nAmXXjG9u+52oD9JF6L1Fb1KOKtOQyLZIa+znLc2fFoiUZwcyIhdAvrc9/heweOq
         bLdMA7tD4p66c2pDqwiRxbewELxO3pgAfWVSihjneZVsXYyHqBDhtclWMeZzF4pKfQVY
         IO+EvRHBvGahkrx398o4PxmFsfgwfgXkG2RZ4R4t8VJ0+L7EvZSrr5yCZW3QbTtxPjhf
         pgL8TFW1mPmp7Tbn8can6DdHEvyqVSPax3a2MPeTT73PC0D+qFgEwqxTPj/7bgbi5TTC
         kwFw==
X-Gm-Message-State: ACrzQf1yKqhnRjkvbTVuum655BTGXXDpUZvQ49Gq7lblbSfoet2pWJwe
        1PW8kfA9c3ahk4XVmHM+N5jxMw==
X-Google-Smtp-Source: AMsMyM4FZ19Rf+aeDh57uIFiQqlt84X/FMAN2OviCklU/tLpK688yp4VPjiM2ZG3IyKbfArb+7ea7Q==
X-Received: by 2002:a05:6214:20a7:b0:4bb:9359:8368 with SMTP id 7-20020a05621420a700b004bb93598368mr10237414qvd.122.1666907971077;
        Thu, 27 Oct 2022 14:59:31 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id k10-20020a05620a414a00b006be8713f742sm1794489qko.38.2022.10.27.14.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:59:30 -0700 (PDT)
Message-ID: <2c8c4642-8aee-3da3-7698-5e08b4c5894d@linaro.org>
Date:   Thu, 27 Oct 2022 17:59:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clock bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-2-quic_molvera@quicinc.com>
 <e5009a33-1f71-1fe3-3a06-98bba031fdf0@linaro.org>
 <20221027182449.366AEC433D6@smtp.kernel.org>
 <cb9a2732-0904-4a2b-61a5-a6d65cad58ae@linaro.org>
 <a5e8c70a-3358-513b-c8a5-7a7903f6ea42@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a5e8c70a-3358-513b-c8a5-7a7903f6ea42@quicinc.com>
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

On 27/10/2022 17:28, Melody Olvera wrote:

>>>>> +      - description: Board XO source
>>>>> +      - description: Sleep clock source
>>>>> +      - description: PCIE 0 Pipe clock source
>>>>> +      - description: PCIE 0 Phy Auxiliary clock source
>>>>> +      - description: USB3 Phy wrapper pipe clock source
>>>>> +    minItems: 2
>>>> Why the clocks are optional?
>>> They should not be optional. They're always there.
>> Just to be sure - I refer to last three clocks here as indicated by
>> minItems:2.
>>
>> DTS does not define them, so something here is not complete or correct.
>>
> DT is incomplete; I don't have that in my current patchset. Will add later when PCIE and
> USB nodes are complete.

Bindings should be complete as much as possible, therefore please define
in the DTS stub clocks (fixed clocks) to fill these with a TODO notes.

Best regards,
Krzysztof

