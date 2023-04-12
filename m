Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433D6DF410
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjDLLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDLLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:45:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5E61A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:45:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sg7so39442891ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681299944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mK5o4f66OfGomkrggIIJazu8fU+1x4ruUmLe4IBoRDI=;
        b=qJJU2xie8Tn8kBs4aO4ykWnx0ohS5FVYmu6ju8vvvgWCf6K5imcYpFZyW0N2LE1jmC
         kP0kwKjnXLWUw3/bFBPTQjlQIVuxc1NNiotOCrLzMEveoSjRIAXhZOJ+pxgJyUfm2Iuo
         raNYWM7MAC2MXfnlpRVaT5xMYoobHL1JYY2HCeMGYwvA+zk2v9R+heiKRkz6g7jj0Hrm
         hNLmU4b1/kJWoPgzPyLVeltpB9g3zHk/eczdmMkm5VXEYA0p9otTzw3fYNzD+fNMUhcI
         enTcdbKJ8CTdum3grN2hAXq6YBuqOVpTt6MNBigFVjkCFPt6MQFFSO7CVC5sUFcQMmbA
         YXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681299944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK5o4f66OfGomkrggIIJazu8fU+1x4ruUmLe4IBoRDI=;
        b=dDn0YHv4tSIacMLG3FLOTFedg07d9kFO1BSt8XFwOKauExHoy3Bk8GnyOf8JI/uk3w
         aiTU9tL6YPk3XQbDzlUeksisk4kBPZXLdpOvkSVFkFSuYshtq2J2gYaU/iacg7Y/0zQ0
         4gi/5qqSPntpcbzEHvPnEgh4+GvTSSk75gYfZc4/NhHpCNWb1h9J+e9Mt5b3bLUg6hRd
         q+j2sFOsOnDzhAyEUNszDyOWgK4pMKKopziexDYepJ5uvvn9o1GcejpVT2u2XsBdwa8u
         KwtfKtPRERZukX3H3swZVsnMVkl+WLo1UWOmeGyTZesXG81huGySNil7axBZsKgopq66
         3RtA==
X-Gm-Message-State: AAQBX9dUStaRKWlBFzmzXtPsM+fBE/r9Yjf7s1bji33ZV0srRB2wfiu9
        tEb+kmuO+Ay3gYK7WiZcOZ085g==
X-Google-Smtp-Source: AKy350aTTC4VgxxllCbi8sJCVEIivgVbCLmsk2H7q+VgRHkvR7TZC73Rm1X1GoCi4YeJzDhj41P97g==
X-Received: by 2002:a17:906:dc8b:b0:947:92c9:6aa4 with SMTP id cs11-20020a170906dc8b00b0094792c96aa4mr2520183ejc.4.1681299944528;
        Wed, 12 Apr 2023 04:45:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id ta22-20020a1709078c1600b0094e7bb22860sm127586ejc.50.2023.04.12.04.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:45:44 -0700 (PDT)
Message-ID: <583f6149-f022-55a9-6d26-e9bc69e6dfc1@linaro.org>
Date:   Wed, 12 Apr 2023 13:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/40] dt-bindings: pinctrl: qcom,ipq5332-tlmm: simplify
 with unevaluatedProperties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org>
 <574d3aa5-21f4-014a-8cc7-7549df59ff3c@linaro.org>
 <20230411173550.GA3408186-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411173550.GA3408186-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 19:35, Rob Herring wrote:
> On Fri, Apr 07, 2023 at 08:54:43PM +0200, Krzysztof Kozlowski wrote:
>> On 07/04/2023 20:45, Krzysztof Kozlowski wrote:
>>> All Qualcomm SoC Top Level Mode Multiplexer pin controllers have similar
>>> capabilities regarding pin properties, thus we can just accept entire
>>> set provided by qcom,tlmm-common.yaml schema.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> Linus,
>>
>> If you prefer I can send all these to you in a pull after getting some acks.
>>
>>
>> Rob,
>>
>> Feel free to ack once for all of them.
> 
> There's no cover letter to ack them all (and b4 to pick up), but I guess 
> that's your own problem in this case. For the series:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> IMO, this should just be 1 patch. It's 1 change for 1 platform family 
> for 1 subsystem. There's just no point when it's all the same people 
> that will review it and apply it.

My previous patches of approximately this size were bouncing from the
lists, so I wanted to avoid this. Also, some of the bindings actually
have different maintainers.

Best regards,
Krzysztof

