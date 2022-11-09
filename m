Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315E36228D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKIKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKIKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:46:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F72C16
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:46:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l12so13913503lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwAQ6guS6MOITC44avbuJ3Luw3qjDnQUj5CuUiGktTw=;
        b=DHmDJ6/yPWOuifggbLxD6k3IKL2hrF0yBHtLX1jVTTQX1wnjMEKWlSbF/x5N0usEOh
         fRESGG4j4nOsiDmdYw34P5xgo9UGAaTHsi1Lq1uE0yFtpIb0KQ6NaYY/GpxVbqI9uqHI
         TnM34xZfmmVILJ9hGzXTmcxE0EjPdl2wakmskG3v+65K4u7DrP9pXdGE6VBghUkoCElk
         xkRTcoxrrCqN23dMxvotVnCJl66NjkhSouGxkG3/BHcj8OpfG4wUNsRiO+h3RZV1JoMc
         zHYN6xI/5v2ZTG+Oje8ch9bHKVwKsinyq5q2wihiSu15IiGHUxTHzK9ZruCfZRxhH8m9
         ZxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwAQ6guS6MOITC44avbuJ3Luw3qjDnQUj5CuUiGktTw=;
        b=UUScQnIoc0kJE+iJGdRSsboEZ4lJK5dan1/7S1ZKjopKEPaU0kiJ51/ytZp0QJuS/h
         W9fhaUlvxmpqK8vFEMN/M5d9qBgnsw5xg/zMq/D0zOXIR6Wd1J3a9Hf6og7HnMzsXyEI
         0T2bIDw8jW2/mRH7vYGrixaiXQtFvxAh55XMoRH2t5OIdV6pY5LuSEP7tvBp1E4a7d3x
         VuhmtJvXJNxBKSDtpSsE3AKT1MyIpk2T7bdRYfexdaGh7Ny6CEx/I0LqzM6+ONzw1icG
         kc3qTbzpXMvmKoRqPDl6HXnC+dN3NUnKQROpgFTOgUL+66mzD3Wr4x8SqHvyr0u2nIFe
         L7PQ==
X-Gm-Message-State: ACrzQf2XuKNWd0FlrwER4iutZ2FXrz4IR0telNeb/iZ9y68ULu252N3Q
        CR2CIrXGKsTv7z5+bB3i9HfU+g==
X-Google-Smtp-Source: AMsMyM66kwjrQTlcx5FZHAu8b2bnqLdkGSsQi5sV3/i2yhnp8yegH7pAx8QdyWPa6+46JlboorHCgQ==
X-Received: by 2002:a05:6512:340f:b0:4a2:a946:613e with SMTP id i15-20020a056512340f00b004a2a946613emr22228230lfr.230.1667990772778;
        Wed, 09 Nov 2022 02:46:12 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id b20-20020a2eb914000000b00277041268absm2087152ljb.78.2022.11.09.02.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 02:46:12 -0800 (PST)
Message-ID: <28b6d936-790f-becb-0507-6b9dcf11e6fd@linaro.org>
Date:   Wed, 9 Nov 2022 11:46:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8916: convert to
 dtschema
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
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

On 09/11/2022 11:44, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8916 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8916-pinctrl.txt | 195 ------------------
>  .../pinctrl/qcom,msm8916-pinctrl.yaml         | 166 +++++++++++++++

Crap, I already did it... ignore. :(

Best regards,
Krzysztof

