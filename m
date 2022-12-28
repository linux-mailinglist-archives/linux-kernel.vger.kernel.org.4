Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474826574E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiL1Joh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiL1JoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:44:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2CFD0E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:44:18 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bf43so22923756lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8sgj+IKc4I05d9aT4cvtlOhas91Jrmo6J+jmne0ERU=;
        b=s0uN4Phw3DQg+pdACh3pCeRLLXJ5pGTPZC8ULSK63nuce48eAw+ysgKoJjZJ7vSM3S
         f28sxk4EBzfsBEMqTrgIPFU582wqXVe1YgCpKqC36lohCqPUYaTVv99qamZmCEKA2jXq
         69PlSAA6JfsEtgnUr1XZT+jXo5ZtIYykn1VVSBd6TMBEl5hCFFfQ1b89jfIO96/1aejy
         OxRwprn0tkR9kbK7JNe1P9uAOJL0ZuflKB2JdJUtt3pJ8ZrqAtIW8PMPpSw7s7COkwIW
         b6B6yvs265guTCDc5gwU8CuIiC6LUSXYofN2WGTlhASUqlD1gk03Whhnl3B5o6ISkKYo
         vyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8sgj+IKc4I05d9aT4cvtlOhas91Jrmo6J+jmne0ERU=;
        b=zl8ms6prq9nOzkQi9fcJQEh0fjrhJGkgDUZ0mm9S5uxGozMkNcGgjyL1vJuHHjmgCM
         KR1ubzLlKLfoLIrRRblM+xMNAIqGjAwykwZEO++7TzH30l3IBth5hidh3xpKevt9s5zg
         nqJ9QMENdmPxQKnN5Ta/m70CZ/efiNW1YX0o0A7qfLQj6bPdQWIpwLPqWGm1nHQEo25R
         i0stjUcuq5oV7xPA83WumgwWphx3h7nxQ/OWoez1H1gm4bXzGAB4E1YHDhcPDE/sGn8t
         XLTLJ2nCibPXqH+t+/JZKWv7p69TwVYTny4Bs8ZjulC9h4qWcMejyZE4ellVTlNThmZ/
         UBEw==
X-Gm-Message-State: AFqh2koqvU7YdjTXBZE4sSi9wsNL/6JN9vkgCTO8Pt4LHOx7t/z49Rxx
        F9qh7Seyx0K7FIyzbX3YyXUppw==
X-Google-Smtp-Source: AMrXdXu0QEHxXnfaIym4DQqx5YERsx1GYvhvmz20U2/B+0J6IFc/uzEa4Azp7z/b4jIBY/wREnSMdQ==
X-Received: by 2002:ac2:528e:0:b0:4ca:fb55:860 with SMTP id q14-20020ac2528e000000b004cafb550860mr4280603lfm.44.1672220656502;
        Wed, 28 Dec 2022 01:44:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x3-20020a056512130300b004cb10601096sm621366lfu.136.2022.12.28.01.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 01:44:16 -0800 (PST)
Message-ID: <aafc1cb2-a6d9-d5b7-7a99-ba3436137e33@linaro.org>
Date:   Wed, 28 Dec 2022 10:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Add wifi alias for
 SC7280-idp
Content-Language: en-US
To:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mpubbise@quicinc.com
References: <20221228094104.356-1-quic_youghand@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228094104.356-1-quic_youghand@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 10:41, Youghandhar Chintala wrote:
> Currently, depth-charge Chrome OS bootloader code used in the SC7280
> SoC accesses the WiFi node using node names (wifi@<addr>). Since
> depth-charge Chrome OS bootloader is a common code that is used in
> SoCs having different WiFi chipsets, it is better if the depth-charge
> Chrome OS bootloader code accesses the WiFi node using a WiFi alias.
> The advantage of this method is that the depth-charge Chrome OS
> bootloader code need not be changed for every new WiFi chip.
> Therefore, add wifi alias entry for SC7280-idp device tree.
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> ---
> V3:
>  - Replaced bootloader with Depth-charge Chrome OS bootloader
>    in the commit message
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

