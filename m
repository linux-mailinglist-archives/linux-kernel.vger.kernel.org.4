Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9E5ED715
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiI1IEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiI1IEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:04:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4446B1F0CEF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:04:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so19200459lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ff2Af8wnvNaIb1kySsnmT6w66901VaPZOtaBt+Ba+mM=;
        b=tkDy8FSZCKEACGMbv7TNH3//AgxXuPUehbKo2oEdC7czFQIZsXiR0OB1yGPI1xu7iO
         OlEPCc8H12dHF5AZSpen+fhrCznTwgX8IoguDH4u2HC2YfJbjvIoIMDkCS3uHG0WDzA0
         zkTLALGvnpX2M94zwy8EI+y9LO6tURmyHfkaYVKFaSKtlgucTUY1BjKAKP+sjHHKDWW0
         gE0xTbfihCHSKDf7hS1x4AmewrY6VcTKQQHg9oVE5mtp6CMI3naJ0Cg4CIyUSpoOWMzG
         6AnKbvvMmTXVAj/I9wopPRdTsTzuU9aLm4XsFxReQvz7ymq+ct9fkjpi9AniUWRBr92l
         1MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ff2Af8wnvNaIb1kySsnmT6w66901VaPZOtaBt+Ba+mM=;
        b=6KNOIa1edaf6BskoUkLTm1P8K1G+NCBj2hpNLqY/q7ijnxolL65+3LX9KZfuOSSbNd
         FBlpuzq9Xcoid5wQJTFyc15ypoRRbZ2DEHwRpeSlNHZXApAs9YDb8F/rR4LKG05B1WDV
         P4Vy1dVmpDux4zSypLdxz07z6BPUII0rKhEEtDBbwCXfhfo9GJh6vJ29OUqPpqIAOvFD
         twNVpUFZBRa8WK1oawtHvgy7keBH7OxOUayKTrZWryNlZ1eMYG8uzoxcl4+dyMiQp3YN
         G8Ap+UE1JxwkV9AXBTkDxTp+X+VEBk3SNcBanpmRpWBcNi03ju1cRS9yy1O9hM/9n07D
         4K8w==
X-Gm-Message-State: ACrzQf04ANcPAsPdnlrKFFaLAyIDar/XJUKFHT9DGkLrTD6HxAAq9ul5
        wW9/vRagJeAXY/h8tRVwNa6YeA==
X-Google-Smtp-Source: AMsMyM5rommvOYkkGtKyw4ykIU1WW2BqQpPqHrUuLl3CWZJ+QMgMkInkDSaF57srd731r7uRyEUUYw==
X-Received: by 2002:a05:6512:12c8:b0:49b:8005:1d9d with SMTP id p8-20020a05651212c800b0049b80051d9dmr13437045lfg.489.1664352240358;
        Wed, 28 Sep 2022 01:04:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512344f00b00499f9aaa9desm400083lfr.179.2022.09.28.01.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:03:59 -0700 (PDT)
Message-ID: <9cf8e03a-9ae1-8af9-f786-95931aa3fedb@linaro.org>
Date:   Wed, 28 Sep 2022 10:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: cp01-c1: use "okay" instead of "ok"
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927201415.1265191-1-robimarko@gmail.com>
 <20220927201415.1265191-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927201415.1265191-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 22:14, Robert Marko wrote:
> Use "okay" instead of "ok" in USB nodes as "ok" is deprecated.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

