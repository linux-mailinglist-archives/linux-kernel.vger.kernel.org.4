Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558D64B58C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiLMM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiLMM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:57:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C6F1D333
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:57:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so4709270lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+49QAMDzPVtrYnuNI/l48IEaXsnLhyGQdsKK+6eiGo=;
        b=XsGIeHyDxkRi7MCp5j1wygAIhEt/onzyyoKl1vqHj3J2W9kLg4r38nuLOhy7IlUE8N
         QrEOA1jKJpm/XMcF0hv5NSq7bR88pi0ZaNMVDXdiPJgc31W5IIdHOJC/pt1RIad2nfE8
         4T9boL3miIyyLclCez7JNgCaV2B2dYWMOgUjAoal9/5Tazp495IChiE2+zNslS7GHqSP
         McVUtjWsi71ThfVwrBjeyJuo5Iq7APSxnIwaiu0ntN3RkRUYMA9UDdzEC/Zj03bSbWAa
         uge6ZjZ+HDWCZrkswfUsOcY5M/Ev5XxW4EJU8GFED7mKJqDhRayJmr1OCqZImBpL/zC9
         Uueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+49QAMDzPVtrYnuNI/l48IEaXsnLhyGQdsKK+6eiGo=;
        b=S+TpfRzDa9r6SoYA+0gh5KA/YT0Nq+SndUi8X45hR5eXu6ULtGivjoOuh1cT8FDeZr
         0IS9f7oALl9FzKaoEQmLKVUB0Y5JONzSVRhhtCTWx5OuuzUJmmD/40LLv/O/3Kiur6kU
         HudVb/Qj2NOtRYnZ6dWQlOvAqM6/67COGVWsDTSehVX/2o4Xy1jiHn5gI3osbk6oUPSW
         79UgUjltg6Hd1HtAaOzUHHxiRYVE80413p4s6H2Y8FGWAOAjBXj0G/8bv9bwNhZ9uIru
         UW1E5OqY3kNNPqcMYoDD6ulhP8rsGmrbn9zjMwYCqNpdlak+Xk1Uyeo4XChrxvASdp7J
         oJ5g==
X-Gm-Message-State: ANoB5pnxzQenFD2LmbztcFWd3QkHRmcbHcO8+NdnYrD3qvC9Bg/BdY7N
        J9LKcyy9ZkCUoz6uGndNJslKKg==
X-Google-Smtp-Source: AA0mqf5EZjO7rMPMLfCaq148t3alQ/vkjPqZRkTeRQJdVfvfctPFRK0e1e39qX+TE2+vx/JJZqULgQ==
X-Received: by 2002:a05:6512:224b:b0:4a4:68b7:dedb with SMTP id i11-20020a056512224b00b004a468b7dedbmr6863325lfu.55.1670936254357;
        Tue, 13 Dec 2022 04:57:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u24-20020ac258d8000000b004b591c33b99sm365972lfo.13.2022.12.13.04.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 04:57:33 -0800 (PST)
Message-ID: <f1736be8-2089-7852-0848-0bef74a8f935@linaro.org>
Date:   Tue, 13 Dec 2022 13:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp-usb: Add SM6115 / SM4250
 USB3 PHY
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Cc:     shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org
References: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
 <20221213122843.454845-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213122843.454845-2-bhupesh.sharma@linaro.org>
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

On 13/12/2022 13:28, Bhupesh Sharma wrote:
> Add dt-bindings for USB3 PHY found on Qualcomm SM6115 / SM4250 SoC.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

