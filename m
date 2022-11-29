Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27163BB99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiK2IaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiK2I3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:29:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE159850
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:28:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so1076934wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UsdFpV0/mKDiXztrE9lqloezboDBtAsqnTTRBiOVtQ8=;
        b=Lt2YZeLSZM3s91FD+Cb0iXVLAQ7owCjKjUS3Ae1jNlIFM57h8NDDsrdMoGpW7NxjJa
         Rm8jNQBM0CsA5pty/Bg3BlqfgA0EMOOWKsjso8ekNmvzv7Y0S1J7erclbRbZEQqinaT/
         gVVrh8W8ZYGjPrjoky8mP++kBkSABMYMc3U2fuidvKGXyp9Tx1Ow6wAxnq5iJZHZdM3r
         TJi8XcPA8zVgd5aDMCWieNA/HklwLLcgdUsOqu0tEx/W7DQhuBfkJxGdC5NUWn069GFM
         PfUnT7ajbkDUVv3REcjyLLjLpbC0M1uQMnE2XKM8PA7RuGDz2TTlUlC6ntyIxYIzP1KA
         kZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsdFpV0/mKDiXztrE9lqloezboDBtAsqnTTRBiOVtQ8=;
        b=YeGBeItK+UxOuVrx85ry/RAv8CNp3FcKGZUIJjZan4IiHqGx5Zr4NBCT0qYOarrWYQ
         usBdy+WqMqub3TFkUgfiFrU57Uc8J9hNc4OC7qJgwDWa+GXb8OaQagQ8rahqMvPYhaZo
         OoeFD5JnYxJcrPHwC8xpnTBV5yYgS7AYF9oLjg1DZVrt3u8XXPM0Xk91FcPc4c0+nfoL
         SAin2l1GKEj7Bk9ZI9BNe3oi0EitndzszCdNwB92YYreupmV15ry6xGkjySKzFGlLvpk
         fgYKzS4p5x3390APXl8ZmcmFEINaA0KkHGq9+bmDM3ixMURvwppHCv+tUZIiVwhmD7xM
         R9Ow==
X-Gm-Message-State: ANoB5pk6TE10zIqOdEaTwZ0KuqBnVZfbTdd+7MaSXRCATHs6POZhHwco
        F1znuuJFi0sWY6Mq7wM/rVxJG6ZWboc6AVb6
X-Google-Smtp-Source: AA0mqf5Z0ZWZ9WQn5gBf/30EXFOX91ieTBWgfiEIeO5U9aZafcjJQFiEzNfLFKEoKitug8Bt471FDA==
X-Received: by 2002:a5d:68cc:0:b0:242:1c1a:37e6 with SMTP id p12-20020a5d68cc000000b002421c1a37e6mr4279056wrw.549.1669710526889;
        Tue, 29 Nov 2022 00:28:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2? ([2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2])
        by smtp.gmail.com with ESMTPSA id h18-20020adff4d2000000b00242269c8b8esm83142wrp.25.2022.11.29.00.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:28:46 -0800 (PST)
Message-ID: <301cfc50-5452-7e71-559e-2586f89464d6@linaro.org>
Date:   Tue, 29 Nov 2022 09:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] soc: qcom: Add support for Qualcomm Modem
 Processing SubSystem DSM memory
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 09:53, Neil Armstrong wrote:
> The Qualcomm SM8550 SoC Modem Processing SubSystem requires that a memory
> region named DSM should be shared with the Application Processor SubSystem.
> 
> This adds bindings for this MPSS DSM memory and driver implementation to
> share this memory region with the Modem Processing SubSystem.
> 
> The MPSS DSM memory must be shared between the APPS SubSystem and the MPSS
> SubSystems, for the whole lifetime of the system.
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@somainline.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> Changes in v2:
> - Fixed the bindings
> - Added some precision on the MPSS DSM in commit messages
> - Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org
> 
> ---
> Neil Armstrong (2):
>        dt-bindings: reserved-memory: document Qualcomm MPSS DSM memory
>        soc: qcom: add MDSS DSM memory driver
> 
>   .../reserved-memory/qcom,mpss-dsm-mem.yaml         | 37 +++++++++
>   drivers/of/platform.c                              |  1 +
>   drivers/soc/qcom/Kconfig                           | 10 +++
>   drivers/soc/qcom/Makefile                          |  1 +
>   drivers/soc/qcom/mpss_dsm_mem.c                    | 95 ++++++++++++++++++++++
>   5 files changed, 144 insertions(+)
> ---
> base-commit: 999e0145579c0e04174044a39257a4d96ee30020
> change-id: 20221114-narmstrong-sm8550-upstream-mpss_dsm-21c438c65f9b
> 
> Best regards,

After discussions on https://lore.kernel.org/all/20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org/,
handling of this memory zone will be integrated into the remoteproc PAS changes.

Neil
