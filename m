Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BE6C63C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCWJfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCWJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:34:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F0BBA5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:32:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so83706946edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679563968;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZogtvrXaNwTidOIkPJ/8jmVqxsQ9HglDhZmrmgyFRQ=;
        b=PWNd90e7fJXEslhfhM6mECNRZo41fCJNrFwRrrUyvsJg3NGm2xFU5kHjMmkSmpzp7v
         z0nH2hjt040zmtbivxOacWL3+CHPYp2zP/61z1BjavCk7YW/2jSNVlLRP3Hb5aGVWA+w
         5yZx9GWSJKG9i8kpLelTxSR7/k5Bk4VhQjLYsFJJG9FJdti8bdACDB8j0ah5c2BuYXr/
         Krf87t9yd77IMQ5nXpyTn7OYEi/tCcJwqYMKWY0ejga2uRyq9jhRZA0fQKhzxyth+fK9
         q1EasQ/v78ARrL5n5keBid2vdt2ItjaZpHqw/4w01fAZrwvB74GHpDhn8u0oIaRePeK4
         3+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679563968;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZogtvrXaNwTidOIkPJ/8jmVqxsQ9HglDhZmrmgyFRQ=;
        b=HJ9POzWQumztQrHqq7SD7YU4kXl2OlTtrMrsPdesg3TljTT87fmqEeUVZJKoBLsS/O
         qWcg58rvVPdfSjfwMHfvbZFZ6vGJt1hjtJP8kODtkeLBwj2dm067BlA6B2F1xsrd/hVn
         pr7KbAE6NW0xDiZ/ETPUd+ZmJeqE9tDRNWzzj7C/56PnAt6IKvjSlDaiugr1bSlfpDr6
         fuQF7T+JAh+ThcVKGC9EPQMFslB0OVOG+Te2nhcXQwOZJ5FNQTtv+fhOoC4k8cC4mfyw
         ga59Iy3rZ4D4J59LKDOBbndYSl3s2/HFxX7DZ5UVntakXdE7S5Kkk7nzZIBEMcSurUqm
         tHgg==
X-Gm-Message-State: AO0yUKUblPKhevK/Sa2Xhndf5h1LjH92U09Vv1qhixMTOxcGOtIsTAcl
        rWQeBijrRrkqhwn+fde51V30QA==
X-Google-Smtp-Source: AK7set+P1YDtfuKP4vfpQpVfliLYu2bTMGsTOCFGe9rXsTcXD/+XuZH3yoUef7cS4E5ZCG5bLUE4LQ==
X-Received: by 2002:a17:906:28c9:b0:934:8043:ebf8 with SMTP id p9-20020a17090628c900b009348043ebf8mr9791732ejd.26.1679563968160;
        Thu, 23 Mar 2023 02:32:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906310c00b00926d614b890sm8293679ejx.204.2023.03.23.02.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:32:47 -0700 (PDT)
Message-ID: <5fc6d563-9870-f615-5216-94b911162cd1@linaro.org>
Date:   Thu, 23 Mar 2023 10:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: qcom: document MI01.6 board
 based on IPQ5332 family
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230323093120.20558-1-quic_kathirav@quicinc.com>
 <20230323093120.20558-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323093120.20558-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 10:31, Kathiravan T wrote:
> Document the MI01.6 (Reference Design Platform 468) board based on IPQ5332
> family of SoCs.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

