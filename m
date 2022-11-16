Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5A62BCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiKPMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiKPMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:01:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC4C45EF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:54:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z24so21528260ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qu18t2owTI6Gu3mppKuZjgeHfzPOjrYfqxjnbu+3xk=;
        b=PYMjBAbZ8CPsc0wU1Uq05ykCBH0Ougzr9SJcOr+RsoLvk2Pvb+n1ZNCvFj6VzAIvnQ
         Nf20RbMCWvTdxFjA8k2G3bpen4lzsq/+KX+/zjhYSdbnlasgbcJaMB5BPozRG/teCo92
         Y3O8Lv3I6GicmoAIA0KkEISvtzYHMKsXNxgO/Gr5w1qrUBi11Mkvo+Ewpmnwe372wV/P
         RySCHNqJp0Ab5V3msnvJbokSBEEwXdmlgBShLRM5jB/mlfX0MOz/TGLNC9opsh3VM5vx
         HowdG2KmGdxST+7YRwv+LGLFawWN6Fl+jNcHLo+H3n9jxX4X2R9W4ho62sPP8dymUS5k
         kMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qu18t2owTI6Gu3mppKuZjgeHfzPOjrYfqxjnbu+3xk=;
        b=tLyisFVNTjYmKA3DzsWAwI7W7Dyh0543HvH1fEQRGltx2p0mX7noQG3wMVmRKjOL1+
         ySKsb3kH2XjxCeX7joprEr54o4tAP3au4O4y21AuLg8PJZLl4HlBdP0OL1rfDAtN8smr
         zEyAL1aRweVajTsArnLN4Is6nPMhjfq2MN3kLc2EpsbpTLmZoyC1lKqMIH4b5yhxRMNW
         yAySYe7/ePnuRiz0RTjcv6j/DdT/lZC5anQhNj6+nFZorJxDUj0sVzI0N02EukEN8E2n
         z8NOyFmQzYrUnASAVZz89hJYC52XRd9CnvsOX9Ty3Cx+9+fPDoGo4Q7RGgDdtQ6+M229
         Ln0w==
X-Gm-Message-State: ANoB5pleQyXtR0Ole/CQav6XM2gr8PTfabO+RZXDyb5uP3xJ8tcEkBw4
        sVATMf8GknTJmKpetRXq5UoLeQ==
X-Google-Smtp-Source: AA0mqf4Q0LoJ/MHQVTvoVlRTtGmUX1DOh+IlCKJyN9EqlcWKtpou/6fhq8P1gKb7J5VQVa0gzSCK7Q==
X-Received: by 2002:a2e:9788:0:b0:277:dba:2f65 with SMTP id y8-20020a2e9788000000b002770dba2f65mr7785483lji.201.1668599652592;
        Wed, 16 Nov 2022 03:54:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d16-20020ac24c90000000b004949a8df775sm2569508lfl.33.2022.11.16.03.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:54:12 -0800 (PST)
Message-ID: <51f5ee2c-bf25-71ab-594d-2da18a44d3b6@linaro.org>
Date:   Wed, 16 Nov 2022 12:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] dt-bindings: qcom-qce: document sm8550 compatible
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
 <20221114-narmstrong-sm8550-upstream-qce-v1-3-31b489d5690a@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-qce-v1-3-31b489d5690a@linaro.org>
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

On 16/11/2022 11:23, Neil Armstrong wrote:
> This documents the compatible used for QCE on SM8550.
> 

So we have a dedicated compatible... This should be squashed with
previous one, added allOf:if:then making clocks optional only for this
platform (assuming that my understanding of "enable=exclusive control"
is correct).

Best regards,
Krzysztof

