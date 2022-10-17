Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26D601B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJQVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJQVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:44:28 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3927E815
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:35:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g11so8621146qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0raal7iq6Rw5yYtJhzJZvkw7Ubhx9PBhmhXAO/yGMLs=;
        b=Y8x38UQyElcPUdDlJf0O/38+LAhYLZtYlg91n51OW/GnLbq5EdKq0riLhU6mQ9ioQt
         XGmdks4ay8MB91XHUu1vY56t/VzUl9434k4cKSK+i8TfRZujZcMRu+Fvow3KvtjxoDZt
         Ay9B7ddpIwW3aqmlHk2dDwrFC+/2RT2jbF9WS0bVvS1e0JSDsTnSvfmQ8MM7CXmCs9aV
         +LjBo/SF/yFiNYGJtSs6HTdOs/P9QxvbHsimvwAAHROPjwtbbdwF+SnQRWQm3LbCA+qf
         gAUcvgyzcO3sWOgLp9f8V384xR1t2H3fotSFdzdK3x6v5ijs78KDN7OeU+nsAfKCcXJF
         zBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0raal7iq6Rw5yYtJhzJZvkw7Ubhx9PBhmhXAO/yGMLs=;
        b=7ajtyVm5RBMA40uo/R9FWo8vda1amuyhqHektmyLS0XrCZlyY+VaVPIYTQ2m859b8f
         AXXPjTtsNQb+mXUI4IGnbz58HDne5b8a8b1SsNZDXOj9f6KrEuT8Bw7/BErIGBl6Xk4T
         w/NvZpIACAbUcqL7cnHRDaLp3T5J18No+zAYRGuh7T37WUd7ahckTPyEWGNJR7tNDmCg
         ZuZxkdNqMbdpx2N9T7P/+0kBBYH3GumgRu67vBEVYrnp709pspyFjMwTss+DmFx4KLB+
         2f5LWfi2qYGkrnk/mJIJ79QHsGEYYVbfB80fDmqTGXCGhH2H2bI3/tKLK/t0KXkV2tJP
         Ojww==
X-Gm-Message-State: ACrzQf2OeZPw1ZPR6qxaU+yymMgnvtArvJswUNf0e05tTw5em8Z3QGno
        6f17B0vF1yeQTA+Mj1VGLCfU0A==
X-Google-Smtp-Source: AMsMyM5RPb6orLQyrTY7kb9P4RQASphIak5SXT0QThIvCdyMRlDV1xll88MIJqG7h8ToksOsgpTJIw==
X-Received: by 2002:ac8:7f84:0:b0:39c:c69f:68d9 with SMTP id z4-20020ac87f84000000b0039cc69f68d9mr10480408qtj.254.1666042534447;
        Mon, 17 Oct 2022 14:35:34 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a132600b006ee7923c187sm692413qkj.42.2022.10.17.14.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:35:33 -0700 (PDT)
Message-ID: <8bf0046c-51a9-8244-e355-78dd2725944b@linaro.org>
Date:   Mon, 17 Oct 2022 17:35:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/5] dt-bindings: dma: qcom: gpi: use sm6350 fallback
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-2-krzysztof.kozlowski@linaro.org>
 <Y00wWnkcLKaticjl@matsya>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y00wWnkcLKaticjl@matsya>
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

On 17/10/2022 06:37, Vinod Koul wrote:
> On 15-10-22, 10:04, Krzysztof Kozlowski wrote:
>> Several devices like SM6350, SM8150 and SC7280 are actually compatible,
>> so use one compatible fallback for all of them.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> index 750b40c32213..0c2894498845 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> @@ -20,12 +20,14 @@ properties:
>>    compatible:
>>      oneOf:
>>        - enum:
>> -          - qcom,sc7280-gpi-dma
>>            - qcom,sdm845-gpi-dma
>>            - qcom,sm6350-gpi-dma
>> -          - qcom,sm8350-gpi-dma
>> -          - qcom,sm8450-gpi-dma
>> -
>> +      - items:
>> +          - enum:
>> +              - qcom,sc7280-gpi-dma
>> +              - qcom,sm8350-gpi-dma
>> +              - qcom,sm8450-gpi-dma
>> +          - const: qcom,sm6350-gpi-dma
> 
> I think it makes sense but can we document this in binding as well that
> why people should use these two compatibles. I am fine with this being
> comments here..

It is kind of implied (and maybe obvious) from the bindings - a list of
two items, one enum and one fallback compatible.

We usually do not document such patterns in the bindings with comments
for that reason. If you insist, I can add it.

Best regards,
Krzysztof

