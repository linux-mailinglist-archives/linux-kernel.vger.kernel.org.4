Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63C65ED681
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiI1Hlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiI1HkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:40:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C8118DFB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:38:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so528956wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=xiARuWAg2rwJGD02NJWCXkkHU+x2u7jt6RB3f7mjNI8=;
        b=J4yxgQU/KJA1qfjTsjetbFC3QZHcI3o4O63k+XgDHIf6VbBeJ7fh+ozScm+tK/yHON
         REYmfHeuiL4Hw6MF9bNIrzQLjP35adl9ESiRds6jiQo/mTsgf9NtNwECgizIkAY+Qmz2
         PxB0NNo2TYlowDcyTJtNluVlPF92dvG374qAd4sLf7jvzqtLLcZVTnR9iqrnEyTZRNbx
         nf433GCvlJ8a9+p7LpwDlL/+qf4Ytp9hPnaj/In+97mpNQW8ksFyxmWC8l7radZfvthw
         Gqgbmkw6mC+MlIK0oWqr9bVRJ2QcQgX9VLxAzB5lsGGGvt38DNy3980Tyoc2GuzfFAwG
         czVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xiARuWAg2rwJGD02NJWCXkkHU+x2u7jt6RB3f7mjNI8=;
        b=qB0nn61KYJ5ByJ3DJmpS+AY9N5CvzUOkyIcOP76O+pvgiyZazi94bCJgxhE0bMB5z2
         P+mHwe4mIxFnyCTeZ+FbX4BbksiNslL7FWi4uwAKYFQUNh2nIbrxEcxBNPm9f+8W48fp
         5pkcKEtgJ6ONnq+6G2uw/EvW87EEt/9D5flX6XesCR5OTu7ubGB0i2qR2C9h4sZJg4lo
         lyiZ7VTNUE3ct80Q2Hterz3o7+pmla9SjfrWJb8smpfpNDBHIBsulrdQCa5ZN5WIVXVe
         /OxNVkEOmlIAAMFhkFOFBVq8DbM5BLJ7Y5x8qNzS1CYDf+aHbXgF6ijW+kLbqRrtNx6u
         k1nA==
X-Gm-Message-State: ACrzQf3qWi7YnSOOFUuCYz92MMW+ZTHkVEfCvjwBbmxm6pSj/Vnn7o07
        z/1SD/BktWfGjbPnfjx1mAltOw==
X-Google-Smtp-Source: AMsMyM575WLZUTuIyP2HF+Ngz+Pt5QjkqHCYZ1Nq3x9hvPIdPHDdpgjpB2rOOhgwicPDqskh2KaPfg==
X-Received: by 2002:a05:600c:216:b0:3b4:874c:61e6 with SMTP id 22-20020a05600c021600b003b4874c61e6mr5761451wmi.116.1664350704819;
        Wed, 28 Sep 2022 00:38:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4481000000b0022ae401e9e0sm3437426wrq.78.2022.09.28.00.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:38:24 -0700 (PDT)
Message-ID: <21030438-e2ec-2da3-7700-1dea0f78d3f1@linaro.org>
Date:   Wed, 28 Sep 2022 09:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/12] arm64: dts: qcom: sc7280: align LPASS pin
 configuration with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
 <20220927153429.55365-3-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220927153429.55365-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 27/09/2022 17:34, Krzysztof Kozlowski wrote:
> DT schema expects LPASS pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 32 ++++++++++++++--------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
