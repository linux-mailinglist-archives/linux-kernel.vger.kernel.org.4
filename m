Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B4669A78A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBQIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBQIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:55:09 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B15DE1F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v11so10345035edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms/iLQOf6WZ9kdAbvZ5kczj2Q3S8/Va+SZXQUp0aFpI=;
        b=kyzKIEWzCOJNIjmoYP09ulmEIikLSDcsMAPktcU/zWhA8o+CjPafc5vCUetue3nzNw
         yZJajUL3OKiOn4cPunKJmdk6bY8dn/9B/wqP/ak4CccyAwha4eEfTZIFRto1eQHfZR5T
         hbmWXWAAUNSa2k987EgtNHckC0Uk5yEaGLndg17UBttAMDoSLQZN0Z3NpEbY6U+6qyiS
         RQ9cuKe0Nys02eKGay+6fVitO/IfdcfyZJeKiqELcsQW6jUD5c03QeweZNTK3qNNvjby
         QRbDy/hBo5yJT8Lo5l6ouL05JQEk4g3y03z2phQE7necbjVx6yWeXzvgZDGkjwwiuMLj
         Ok1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms/iLQOf6WZ9kdAbvZ5kczj2Q3S8/Va+SZXQUp0aFpI=;
        b=DAsZWFpgvg8j/6KVeLaieEZMwTwH99qq8MBWMVB4afTcXFcEtziufKK3nV6w9uIYDg
         Gih+g/t466JuwncZc9lP4HpCNWNI5hs1GvBpDWwFy9olsXw8e1t+xFESkQBm1wcENH+z
         YPID35q2zUAU37Z/yrpHJ+e2e3rUjE7pQ/xzN3OfqBhd0yGY4+21euW0u130v+dh0m6K
         sBOjWEnYFYSlIfmfE5qIpp1CxJUyQDX12/2RSWULKIqAetKDk0TpFl4jqJqsSZwOwG9G
         WP3zmmdZGPpjCVuNNltbarQrQT3kisgqybXVTyLY1k62mV2KFw0Q9DewzHIXwkWvuJ0k
         g6/w==
X-Gm-Message-State: AO0yUKWtbnwwyTWFZNyyFO01qzhdGDCdVGfCqVrprEqOmKBvXgUODFrl
        YZyMxTRnRo8N+ALVvigso2MQipLItMYCLodH
X-Google-Smtp-Source: AK7set+IEv2TbISTklidgD6uq9zlJmbOrq7lhiGovewXGe1Rb+O6Stn+ccGdmM+r+kEvUce/0FYZYg==
X-Received: by 2002:a05:6402:784:b0:4ab:4411:2f71 with SMTP id d4-20020a056402078400b004ab44112f71mr156745edy.37.1676624102715;
        Fri, 17 Feb 2023 00:55:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a36-20020a509ea7000000b004a7e9ec2087sm1964054edf.76.2023.02.17.00.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:55:02 -0800 (PST)
Message-ID: <2d2290c3-e4ac-aee3-f2cf-496c6d29a188@linaro.org>
Date:   Fri, 17 Feb 2023 09:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 15:56, Konrad Dybcio wrote:
> Document the Adreno SMMU present on SM8350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

