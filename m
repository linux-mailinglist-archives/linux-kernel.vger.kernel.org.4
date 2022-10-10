Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7B5F9E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiJJMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiJJMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:04:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478261B2B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:04:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l8so6719038wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=anupc4X0yEkslqWKC62ceahK3G1bRO/6awTx/DjrXFY=;
        b=XNtx65jOCrdtHOvpAYPzGEIcsToZ4E+YRQ+lQ3tLDOQVnAjXzokwPSIV8KHt3qrQ5A
         xwgc3UHA4CJewkbWylvogz2sTkeGXeImQTKW4Mbcw9iLxfQHkMUDIzxWx7Tft0CjC4Si
         TYbZ9dtRJ1F2Z0Y+bfq5WdW1+otL8ZFbsBOibPag9I7tjHQN3Jb7mJy6umHqsCLlnG3F
         7r1DUoZW1Nz/ZgQ8dPk7lbHj4vkfysJe7ZuWcQbMdDYxsevfZz/Na6uWVdTBQjIsKtVP
         MHFE6smnhcoWlE4DBg9KaGikefc/unMT13qTaE3jpepbPnd5Krdqt+rwo1i6JgpapflS
         uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anupc4X0yEkslqWKC62ceahK3G1bRO/6awTx/DjrXFY=;
        b=Yw0cuwrHwQU3AnF2TSo1eCmSG87Hf7WmokREaRpRH1/KxkJa1tdzbGRQoKnhbhGJ0P
         YtTLibfIP4zcKdKA8nTYpI67vrdtm1evWIGZUhhvlRhxnGOi+0WKxB30OpVyHUsoyJjZ
         uVRqIPNlHmXyyEUcMwTixZ1IQVnCCMJK7OMJgmzwDHZA1QywuxpaduJTCxtisos6w3lz
         GymaelagrMGDtxUxkrCY/0mRFu8f/sfH05wkZcs3xgQ1E4Vm4FP0boBZeTGBIHm+NJB5
         Qa+UxXYk4krreIC+6m3D/+bgWE1+xoIbyi7Upv5rjDhUROnZ2TY3cSXyEydzG6gTAgl4
         rogg==
X-Gm-Message-State: ACrzQf38PfFdp4a1hjQCgqFyCRTbTxxxHg/UASQQBVg50QWF43WIGlxv
        6Zg5ia6sKKOQOARgCdoIbpZFWw==
X-Google-Smtp-Source: AMsMyM5WhmkC9zQn6K5Zcxtc7sS4mTlFVp3bIYMUmhkCnJPdtTGjGloyPN9n0NLIBomMJYMAAlkMcQ==
X-Received: by 2002:a05:600c:198d:b0:3b4:a62c:a085 with SMTP id t13-20020a05600c198d00b003b4a62ca085mr18698587wmq.140.1665403441074;
        Mon, 10 Oct 2022 05:04:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1d81:c6ce:69e8:c0? ([2a01:e0a:982:cbb0:1d81:c6ce:69e8:c0])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe589000000b0022e6178bd84sm8711022wrm.8.2022.10.10.05.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 05:04:00 -0700 (PDT)
Message-ID: <6cc7ef4b-8c11-96ad-76dd-77a4e2de3d2b@linaro.org>
Date:   Mon, 10 Oct 2022 14:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: sdm845-db845c: correct SPI2 pins
 drive strength
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Xilin Wu <wuxilin123@gmail.com>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20221010114417.29859-1-krzysztof.kozlowski@linaro.org>
 <20221010114417.29859-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221010114417.29859-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 13:44, Krzysztof Kozlowski wrote:
> The pin configuration (done with generic pin controller helpers and
> as expressed by bindings) requires children nodes with either:
> 1. "pins" property and the actual configuration,
> 2. another set of nodes with above point.
> 
> The qup_spi2_default pin configuration uses alreaady the second method
> with a "pinmux" child, so configure drive-strength similarly in
> "pinconf".  Otherwise the PIN drive strength would not be applied.
> 
> Fixes: 8d23a0040475 ("arm64: dts: qcom: db845c: add Low speed expansion i2c and spi nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not tested on hardware.
> 
> Changes since v1:
> 1. Put it under pinconf instead of pinmux, as suggested by Doug.
> ---

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
