Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4D616C40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKBSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKBSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:33:42 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3919E2EF5A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:33:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z30so12326610qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q92riiS7ubzxoWF6UuL2jfQgGcw0qGoG//c8sRPlZ6Q=;
        b=kGcLjV7SmNNbbGA/s5728760o5U/Yl+OT//qiK+lbm1ZFISPUnYEn8Gi1sB78euRC8
         vszdivvxXScOtJ1ZFruWtROVGOoHJ0As/vBBHiwRZrQyUCENP770io+HaedrF9VMiZvP
         uq0YYkkB1g/zE4DSaz1E9mNmI/Fwubaj7oVYqEZl7yr1Mlxqv+DGVt6lv9auwZEKlWZ0
         BshgmtK3Ko3qg950J6/jr+hJWnQWCCpfZfB5xf8R1w36/bh7O/Xa979/DozoS7RwRcxT
         /XgllTzxF0MZNp2G5hkr+JhWfDvtdGmmV2WUgtYtYfyx6WDXOrYQeqnWs7Cg9SKMUO/V
         Zp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q92riiS7ubzxoWF6UuL2jfQgGcw0qGoG//c8sRPlZ6Q=;
        b=h+MtV92IZLdGADjSbK5T6lGf13h7P1cwwl3+nqKaK9ZxHdLQ5ocBP2f9IZhkoGjO6x
         gI0V9C1s7r14gMPFfKKUoDLMK9RzT8ubezoFlhg4Lj81Xg3ST1JKmMUmfrq67aUzMRZr
         8XvgnZ9wgHK+KyJEczeSWcwQVE2IYTx8gJ4sWMpbHj2El09ozSd47jr++ptKHU5fgEsu
         j7naDOk+8+u4tLOdRHymjS3KB8zFf9Oq+c86FqF/RSpkwLALZfAkE6mvKx5+LFveOxO7
         ulUvwGy+KEpOzciXMDRk8HkSGZW1JxccHbNOze2X0PRRzC3mHorcohzaSD3LpxideqUi
         YGkw==
X-Gm-Message-State: ACrzQf1CL4A0aCZGbe+HRC3JoXblelIFxnQbtPCB5moy1trnME3rnvg8
        W58lIU/RMA09Vz6tdDMKFIklCg==
X-Google-Smtp-Source: AMsMyM6n+O//qDHsWRWUhV8NoPCYi8OjtMbiw8u1VyQm+AKGMgDct3y60PhFqUC4AGL9jpSTDfaFcQ==
X-Received: by 2002:a05:620a:ecd:b0:6fa:2bb0:7d86 with SMTP id x13-20020a05620a0ecd00b006fa2bb07d86mr12957581qkm.296.1667414020390;
        Wed, 02 Nov 2022 11:33:40 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id cm8-20020a05622a250800b003a530a32f67sm3506976qtb.65.2022.11.02.11.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:33:39 -0700 (PDT)
Message-ID: <9619c472-4fad-c71c-591c-12f5ef7e0a79@linaro.org>
Date:   Wed, 2 Nov 2022 14:33:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double
 compatibles
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221031182456.952648-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221031182456.952648-1-luca@z3ntu.xyz>
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

On 31/10/2022 14:24, Luca Weiss wrote:
> As in other bindings, let's use specific compatibles together with the
> fallback compatible. Adjust the bindings for it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> * New patch

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

