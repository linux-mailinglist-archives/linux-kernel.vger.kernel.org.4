Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4465F7126A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbjEZMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjEZMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:30:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE110CA
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:30:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-309553c5417so611063f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685104187; x=1687696187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DgLeFcVKugZ1jHV952TG/acpJ3CYaYDRk+S+7y1opI=;
        b=JJvTXawYK+2eKFBee5z6PBwWI5k4qXYQepgb/dOh40ONIfiNE4vQ9C5JZS9sngNYhg
         jKAqABQKcPpFCxaSTHzNRTJh1NZA9QyRaeOZY1W6wo0FCJG+12yEHnJk2NO1DgadbHko
         SXSrT3LLSZujHZOb4HyIWpS8gGRib7Sl7sEBd71FdNT6s4mX2O4QpiCkFVa9qXC//z3n
         BL3r0fgeLMCTZ3qonHJ6AOvpUyATULG7xQO2b3uScW7N2yIporOw7/OnSPXyTG6/vxE6
         ky7koh3XPDV1LI+z3hdqe8uaxn4vkoTeZ6obSssLU6VS6sfAL7NtZTRBfKYS3+fqa4Eq
         /IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685104187; x=1687696187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DgLeFcVKugZ1jHV952TG/acpJ3CYaYDRk+S+7y1opI=;
        b=WLxDQXrCq3CsGRnZrnHYaT5gw2ORtAHqBfQCc5f+30jUCQv2BSyECbPpjR07768nSk
         eZXGa1s6zyHx3PbrZ8U7NsJKkGMpZlbjLnUqKh4Lbu4IX4zdAo31TD3dLLKDQ89Yp5ak
         dKV+b9d9yaJFL/e5VG+NRcfa+LnugkGjTo9FnugqBj62NjZz+YFLNS++ETJAwPGiUyeI
         v4ujISP5hM6Au6xc5DCJHte7MuukSt/9rkIOcUbUpuwaPEACn4bvZ2wRyjPHTyAWtsZ5
         imdzC623c5Zk+SELE9lQ4E95TobQkRvDi3wI8MLl3RNH5s/zGP6u9nKVLDEogpJhMwlz
         cxqw==
X-Gm-Message-State: AC+VfDz9n52SpySxO9/hXraPNv7qu+hIqfNCvcftcn1CwLYsDmiX+rM0
        arDAtaiJccsUg63aackEy43k5Q==
X-Google-Smtp-Source: ACHHUZ4Yzdh1OVvZfHTDfTPDF27Lm7PQ6wRYFT/sfIDkuo8DGhJzYx6iAQS1jK8kdTtAXhGTfBVkdw==
X-Received: by 2002:adf:f307:0:b0:30a:c89c:c338 with SMTP id i7-20020adff307000000b0030ac89cc338mr1348537wro.50.1685104186834;
        Fri, 26 May 2023 05:29:46 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5483000000b00307c46f4f08sm2325314wrv.79.2023.05.26.05.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 05:29:46 -0700 (PDT)
Message-ID: <546876ba-970d-5cd5-648e-723698ca74fd@linaro.org>
Date:   Fri, 26 May 2023 13:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 1/6] dt-bindings: clock: qcom: Add SM8550 camera clock
 controller
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-2-quic_jkona@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230525172142.9039-2-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 18:21, Jagadeesh Kona wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8550 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since V1:
>   - Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550
> 
>   .../bindings/clock/qcom,sm8450-camcc.yaml     |   8 +-
>   include/dt-bindings/clock/qcom,sm8550-camcc.h | 187 ++++++++++++++++++
>   2 files changed, 193 insertions(+), 2 deletions(-)
>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index 87ae74166807..8dbc9004202f 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -13,11 +13,15 @@ description: |
>     Qualcomm camera clock control module provides the clocks, resets and power
>     domains on SM8450.
>   
> -  See also:: include/dt-bindings/clock/qcom,sm8450-camcc.h
> +  See also::
> +    include/dt-bindings/clock/qcom,sm8450-camcc.h
> +    include/dt-bindings/clock/qcom,sm8550-camcc.h
>   
>   properties:
>     compatible:
> -    const: qcom,sm8450-camcc
> +    enum:
> +      - qcom,sm8450-camcc
> +      - qcom,sm8550-camcc

Hmm,

So looking at Documentation/devicetree/bindings/clock/*camcc*.yaml we 
seem to be repeating yaml over and over again with no substantial 
difference between one description and another.

You've picked at the thread here by adding sm8550 into sm8450.

I think sm8250, sm8450, sm8550, sc7280 and ... probably sm6350 should 
live in the one yaml description 
Documentation/devicetree/bindings/clock/qcom,camcc.yaml

sm6350 looks a bit sparse/incomplete to me so perhaps leave that out. 
The others sc7280, sm8250, sm8450 and sm8550 can/should all be moved 
into the same yaml file with a list of compatibles.

---
bod
