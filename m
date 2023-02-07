Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4163568D36C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBGKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBGKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:00:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD710A98
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:59:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bk16so12948123wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gyxo1SYfYxqaPFoqXEgYr/ocAyDp0P/Afe4B05MrX2g=;
        b=KzUsPTYWPFHfbLnnGsjoPYvqAu0p4zXIIyFAyQZ7lM/tW0/LideTaa5ZkrAqRI26GH
         GH1/SBpFezyNWMSdg0lcwdwBVPj9PnB44iaNkrCU7HZCAq9KD04+1zceZS7NpkGGbg5T
         49lDY1s6A0TjFPNDmGQq3I8kZhT7cNTRMoRuv71V4amdrb9f+B3BzVizxeTPLmKtG2Zk
         jqREe0/ffmG2XeH67rlJtXrgkVKC5mpgXrVq+Z/e5bDcacOGtwetl10GLbVqdBLhq0ht
         q2pi2euEWKbuBZWSHy8sQrTKfWZGmjJGO3dBXzAsJbE0A31Ga4sjM23sNyL3m/hdDFW4
         BtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyxo1SYfYxqaPFoqXEgYr/ocAyDp0P/Afe4B05MrX2g=;
        b=z9vamvyRUYHcP5QHtC31wlpWdy2nTkFDYzWxgOGvvyyydEkfGTIW5FCHgSJbfDKEgB
         rwCn1/ILiv3gM6T+gG+5VSVMU1+uER+OUAAq6vak0/4YqTsYALPgKPZMK0wBxvyQ9NsS
         WCI3sGZzGncpeN5VTQH06vfSqkA7ILEGM+JGzIrbbG7J206+sNLMqARm+buoBkxybgzC
         35cD/OGJLDMBhIA4p6mVIPVr5iP0u9lbMyQUWuClqLR8WgDfoAxQZmOj11/rwEvA4/7n
         svJpSkAEDv40/Hzqd2u+1D8vJ0/Ay9icXxKqgKp5Z9RM7Hfzi3gZcPgBZRQdc7Sv9CDw
         Ba4g==
X-Gm-Message-State: AO0yUKV2xSdLyxy14q5halh6j+jw65AZBQ2DsBaYzOvox2TzboYBV6PH
        6xYvaeqasF9H0oq7t0ynbj159A==
X-Google-Smtp-Source: AK7set9AGUr02MY4TirPrz8+iYHIBelGFh4xaIZhKWPYG47xjHnOe3bmka69hBvzuOpVUsCNtFRL7Q==
X-Received: by 2002:a5d:4a0d:0:b0:2c3:ea81:64bf with SMTP id m13-20020a5d4a0d000000b002c3ea8164bfmr1877549wrq.56.1675763959917;
        Tue, 07 Feb 2023 01:59:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600002ab00b002bfb5ebf8cfsm11408275wry.21.2023.02.07.01.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 01:59:19 -0800 (PST)
Message-ID: <9f0e05ee-de21-c234-7c8e-e6105e98c0ac@linaro.org>
Date:   Tue, 7 Feb 2023 10:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/5] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert
 to DT schema
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
 <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 10:08, Krzysztof Kozlowski wrote:
> Convert Qualcomm G-Link RPM edge binding to DT schema.  Move it to
> remoteproc as it better suits the purpose - communication channel with
> remote processor.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../remoteproc/qcom,glink-rpm-edge.yaml       | 92 ++++++++++++++++++
>  .../bindings/soc/qcom/qcom,glink.txt          | 94 -------------------
>  2 files changed, 92 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt

This is expected to trigger warning in other bindings, being fixed here:
https://lore.kernel.org/linux-arm-msm/20230207095639.36537-1-krzysztof.kozlowski@linaro.org/T/#u

Best regards,
Krzysztof

