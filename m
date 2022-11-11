Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A7625F38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiKKQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKKQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:15:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F74DEE8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:15:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so2382496wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+g7U9kSnqY5Btf1Uczn6Yzb9ePFiuOCe7hrx3U2q9eg=;
        b=dXV1z/nLCtHcsGAbmd4/sx14M+hs3Ax/nNV5scN6gizbeIVexySlOyS5zUoS3OPt/p
         o+zw1LKg3h2Q6D5yNE/TV7M1kr/AEnFQwoIl9pu0WrtUbTRqnMs5IAQfkSYZP8cINSSB
         uORi5kmGGzyosszvsx/vS+4dd+HrBMnNxkwCR3yPzStI/daNQ2eWf7IvtB4dCGcWJNBR
         LPyfGjOKIHeBUjFyiC+HdZspFxlmUEcdVi2AVVNwIx2NWWEr9B16FyGLKPiiJUZHBU9e
         9p7Lb46FAK2V8ddFLF+FXU7BuouHtvHiH2pe/7nA6jS/yjN2c09MZ7lFM5XqOJxIsfwe
         6Mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g7U9kSnqY5Btf1Uczn6Yzb9ePFiuOCe7hrx3U2q9eg=;
        b=sF8z2sNcgmR7VyrEFgLxG+/UGETn4ch91tmLZ6vJMyk+6Fpp+5vsCs5RRw4j5wCOgm
         uneEi8Y04W2T30WHNI16BUMOohDhbcTJduCTj4RtbGU/TMFpYnqu/370o5zoZyujSWd6
         SaPDaaSd+LeXLTQXmsvs1CF/nD4jDuqb5PUUmPizpu+odijMRBehAXmawv1mVWXLDpQc
         9YddvlPOMXm4mJ0qpUgifMZAj7o5SVkjR9J+V8DBCbe6mrxM49ITeiSgYvZMmnIXUjyX
         SSKuFrjadta8h0elDgSOtZR7Q1vv0IMitTjeUz3czLtjHi+MDqDXk2hS+eWX4MNXyAq6
         lITw==
X-Gm-Message-State: ANoB5pkSkffoZXoGYStQE9YlDFlvr++ajxwIFlkDup4U+b8U/q/+PMyF
        Y6U3v2a3k3HgjY2+zvkr8jd7nQ==
X-Google-Smtp-Source: AA0mqf4GeNbz9JHTSJP5g9TLotxo4pCO0oLfJto+zxfuG6Q4IekcenT2awtAK2VZVBbh8+rY2WluwQ==
X-Received: by 2002:a5d:5913:0:b0:236:e0d:9ad with SMTP id v19-20020a5d5913000000b002360e0d09admr1751304wrd.692.1668183330925;
        Fri, 11 Nov 2022 08:15:30 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j5-20020a5d5645000000b0022da3977ec5sm2183279wrw.113.2022.11.11.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 08:15:30 -0800 (PST)
Message-ID: <06da072c-8cf0-8181-3c32-4592fe41f9c2@linaro.org>
Date:   Fri, 11 Nov 2022 16:15:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 00/10] ASoC: dt-bindings: Rework Qualcomm APR/GPR Sound
 nodes for SM8450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
> Adding sound support for Qualcomm SM8450 SoC (and later for SC8280XP) brought
> some changes to APR/GPR services bindings.  These bindings are part of
> qcom,apr.yaml:
> 
>    apr-or-gpr-device-node <- qcom,apr.yaml
>      apr-gpr-service@[0-9] <- qcom,apr.yaml
>        service-specific-components <- /schemas/sound/qcom,q6*.yaml
> 
> The schema for services (apr-gpr-service@[0-9]) already grows considerably and
> is still quite not specific.  It allows several incorrect combinations, like
> adding a clock-controller to a APM device.  Restricting it would complicate the
> schema even more.  Bringing new support for sound on Qualcomm SM8450 and
> SC8280XP SoC would grow it as well.

Why would this grow? All the dsp services are static and they will not 
change per SoC unless there is a total firmware change in DSP.

> 
> Refactor the bindings before extending them for Qualcomm SM8450 SoC.

I dont understand this bit, what is SoC audio support to do with DSP 
bindings. DSP bindings should be totally independent of this.
> 

--srini

> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (10):
>    ASoC: dt-bindings: qcom,apr: Add GLINK channel name for SM8450
>    ASoC: dt-bindings: qcom,apr: Split services to shared schema
>    ASoC: dt-bindings: qcom,q6afe: Split to separate schema
>    ASoC: dt-bindings: qcom,q6apm: Split to separate schema
>    ASoC: dt-bindings: qcom,q6adm: Split to separate schema
>    ASoC: dt-bindings: qcom,q6asm: Split to separate schema
>    ASoC: dt-bindings: qcom,q6prm: Split to separate schema
>    ASoC: dt-bindings: qcom,q6core: Split to separate schema
>    ASoC: dt-bindings: qcom,q6apm-lpass-dais: Split to separate schema
>    ASoC: dt-bindings: qcom,q6apm: Add SM8450 bedais node
> 
>   .../bindings/soc/qcom/qcom,apr-services.yaml  |  54 ++++++++
>   .../bindings/soc/qcom/qcom,apr.yaml           | 119 ++----------------
>   .../bindings/sound/qcom,q6adm-routing.yaml    |  22 +---
>   .../devicetree/bindings/sound/qcom,q6adm.yaml |  51 ++++++++
>   .../devicetree/bindings/sound/qcom,q6afe.yaml |  69 ++++++++++
>   .../bindings/sound/qcom,q6apm-dai.yaml        |  19 +--
>   .../bindings/sound/qcom,q6apm-lpass-dais.yaml |  32 +++++
>   .../devicetree/bindings/sound/qcom,q6apm.yaml |  67 ++++++++++
>   .../bindings/sound/qcom,q6asm-dais.yaml       |  48 +++----
>   .../devicetree/bindings/sound/qcom,q6asm.yaml |  68 ++++++++++
>   .../bindings/sound/qcom,q6core.yaml           |  39 ++++++
>   .../sound/qcom,q6dsp-lpass-clocks.yaml        |  40 +-----
>   .../sound/qcom,q6dsp-lpass-ports.yaml         |  57 ++-------
>   .../devicetree/bindings/sound/qcom,q6prm.yaml |  50 ++++++++
>   MAINTAINERS                                   |   2 +-
>   15 files changed, 477 insertions(+), 260 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.yaml
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
> 
