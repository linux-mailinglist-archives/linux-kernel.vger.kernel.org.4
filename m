Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7666777A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjALOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbjALOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:43:05 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197B544D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:32:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy8so45097081ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6uMjJS/3NnDxO/SMA/w1sCCelcrWohvr5VsLfwhgYU=;
        b=mA7vp0A3H9QLTwxyxBiSUUJrToUQsdD3hA4dGO+UWGtE2Qz/yTR9suwEI+4Pnf8Bk/
         BSqv+CJKZj4FSkX1ttLb+Bg8f7fw6qbTJawcj5/af+TbuK5U5Lwcg1xfvEpKw6NoRxjK
         GWTZbkLsEVGcO7K4hN0jyhU89xsbhAN5LCd2piTvzt497Wf6NC+7/6xab+9iyKsq6ZMz
         /DorbILM7fePxjSwd23rhthjDEdZfflfpgMO6pNqjx1+51W1dA+X8Z8D24G8kKdIfLw8
         /eWcW7F6D9yDiRroZanlU5vgywk3XoLM8ifoW5kxZmTTnUfm3DEP9kuHFD/mzeKakBcK
         rTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6uMjJS/3NnDxO/SMA/w1sCCelcrWohvr5VsLfwhgYU=;
        b=n6ad+hvVJ7dXzBQJi10PwmGEicghyZ3RxsW9EyHXfaS9DquRgQ0FIUMd8lV9vzstLF
         FAmm43AisdmBaoaNJbvyYowAuVzNWc1ImpKjziHvMtSILYSeds5fNFmASpVV2p9QC27L
         vFpzPyVQjCk7+LN6+RmH/WiuKAoELlr2UeNK4BXqrOFaDX328Cq8AXUxqbLbe6/Uu5Le
         /KXIDhpLH8Fa1KbXSYdOwv2fAEpieJ5ClmpdQovYOoZFcyRuHLwiz87ZCLxnF4Yi8N+V
         ZhTsKYqAY2tXXjns+pO2/pr1lI8Ul40c+is60uDzuYKTj/WiCXOmY33MwyyMZ3ZA4ljV
         cJbw==
X-Gm-Message-State: AFqh2kqXDJ8Pol9R1A6F0ZPWBUZ1jugv+Usg21icfxZAREXe/Cysd7BH
        /XZ+rn8JuXWf1F/wv5r0Efwmyg==
X-Google-Smtp-Source: AMrXdXsqW8Cd/27xRzj7BYpHe/IRGl8aYcmOsGdFJkLK0wcL6QXh4jaHkK6atMgaLVH69Eft9ugnag==
X-Received: by 2002:a17:906:e11a:b0:84d:13ac:2fd4 with SMTP id gj26-20020a170906e11a00b0084d13ac2fd4mr22014886ejb.17.1673533947444;
        Thu, 12 Jan 2023 06:32:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m24-20020a1709066d1800b0084d4b8f5889sm4623834ejr.102.2023.01.12.06.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:32:26 -0800 (PST)
Message-ID: <a6823408-a7c0-9e27-45e5-50305aedb8db@linaro.org>
Date:   Thu, 12 Jan 2023 15:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM8550
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
 <20230112130542.1399921-2-abel.vesa@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112130542.1399921-2-abel.vesa@linaro.org>
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

On 12/01/2023 14:05, Abel Vesa wrote:
> Document the QMP UFS PHY compatible for SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

