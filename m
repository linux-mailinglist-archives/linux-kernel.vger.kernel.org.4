Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6705A6D92DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjDFJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjDFJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:34:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEB330FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:34:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg19so273878edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680773696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XWRAt6cA6SWvqbl8+GjMBljD3TzI/XKbSiZBb0m1lg=;
        b=iUyJ5JxMxjo6Lg1MAgMik0OjXzDVAgWJV7/syYXpP5vTrklva+j9asejul9jhTZhG+
         ZOPQLyZaeB0HXgKH6On+ZbEY9sh3UVTalQ29xiPIm9XN7v5sQ3Vq2SUCI3J5JSRVk6vY
         tgPU2AoA7BnY5FjcoliLIu2OHBfnigjBAPyKR21VAljvHZfpZ95vqXcAGyRlnEyDd1gR
         Fx3dqe5oZ1DRMcOdTr6L3FlHOutZXOzlLDYeCUBqG6Yf9ChKpyF2p8KnESTq/lzgNxJs
         rGIlao0FsA3ZzU7h/vSpLq1rdcWZJDSL+n1nBCImoCSo93H4vFqwA/dGrtMT9FEN0fwh
         Qj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XWRAt6cA6SWvqbl8+GjMBljD3TzI/XKbSiZBb0m1lg=;
        b=hXWZweMbupmUsfTz7wqdddNhHLyTZc4wRbpc4jqAeHnnnKDFYT47FN5Nq4tPd1wamE
         eI6lcAYCf4nmyqdj6r/cnR47iU/LdFxGQmgqd7ZeXOFw0CFq6gF/Xw+GgOVyf1Te/6tb
         lb7TMNe34cRqhINopoVujetdkDlgJcd/UmRlPmd8kgV/rzcyfLon09Jdreui7it9zWLs
         Dv0l89f7rWkH3IF7PJZhHWtwg8Gr3Qh1JAzyLKRk2DQw65ASo9qMFXKnslmfcyA9cETx
         COc/KEHvYDeERYS0yGgZa76uqcGddu0yVEwkQ9EQANfp2QzswhU0PqbK6SScodRx59Gf
         rPUA==
X-Gm-Message-State: AAQBX9fb8tPXlfNqrlBwskbWPj9wBGdXlrMbeBdeHfxqT8RHvHSKLv7J
        eS5b/qKiKTcxMN2c8yB+U32I6ih1+3qK52YP7bg=
X-Google-Smtp-Source: AKy350a5Ns2ydsErA5vNRklEKPlI/iiw2rTSF2gMfY+fveUAraTypP6rpRRTkt51YdO1XzTRBVg0JA==
X-Received: by 2002:a17:906:3419:b0:93b:5f2:36c with SMTP id c25-20020a170906341900b0093b05f2036cmr5527876ejb.61.1680773696626;
        Thu, 06 Apr 2023 02:34:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709063a9500b009321cd80fdfsm566710ejd.158.2023.04.06.02.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:34:56 -0700 (PDT)
Message-ID: <f9728472-0dda-2fb2-1753-e9c039afa4c1@linaro.org>
Date:   Thu, 6 Apr 2023 11:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: msm: Add bindings for multi
 channel DDR in LLCC
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-3-quic_kbajaj@quicinc.com>
 <2b3e39b9-ea70-db9b-89f7-09054df363c3@linaro.org>
 <20230315134814.GA98488@thinkpad>
 <c8f3499f-d927-6657-c7c6-732ed2222525@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c8f3499f-d927-6657-c7c6-732ed2222525@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 11:19, Komal Bajaj wrote:
> 
>>>>   
>>>>     interrupts:
>>>>       maxItems: 1
>>>>   
>>>> +  multi-ch-bit-off:
>>>> +    items:
>>>> +      - description: Specifies the offset in bits into the multi_channel_register
>>>> +                     and the number of bits used to decide which LLCC configuration
>>>> +                     to use
>>> There are here few issues.
>>> First, I don't fully understand the property. What is an LLCC
>>> configuration? Like some fused values?
> 
> There are different configuration for LLCC based on the number of
> DDR channel it uses. Here, we are basically trying to get information
> about the same.
> 
>>>
>>> Second, don't make it a register specific, it will not scale easily to
>>> any new version of this interface. Although how this should look like
>>> depends on what is it.
> 
> LLCC driver can only get DDR channel information from the register.

And why would that exactly matter to DT? How does it solve my concern
that your approach does not scale?

Best regards,
Krzysztof

