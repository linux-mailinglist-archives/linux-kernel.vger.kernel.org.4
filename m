Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411A763F169
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiLANRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLANRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:17:40 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98374958C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:17:39 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id r8so1833619ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj5jLfcl/TleK/jyR5GjEQ/vCFrxs7vu0/jWUhzk7hg=;
        b=pJO4lzpoUQ//8p0gzjVyR7jn5l2RNbS51IJpUzJ2PN8dgdGtzdvry4Z+gcXBNedJ1W
         K5vf9nwLbR7xSHnqxkZrSBuqX/16TGqxe6aVkdbtwA3Mw024KwtobnPFX5iOMiQwg9kt
         HEj7eOx80a9BIxlJeqtz04UQnnSgqWOwUzEX4bwGz2RfvhcZH+IRPFLE/jlma2bmFl2B
         lCU8Bcm1GkBVPGYIOHHYtgi6EkFrRzO0e8l4BnaKf9JKCf2c3KpnEihiPUbhsyNI0Cix
         aZSGTBrxCTQAxs5ek4s8H/fqAwMZWpnl+K7eso9khNN/i/euV4782wUAIhVavvCfkWbQ
         L1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj5jLfcl/TleK/jyR5GjEQ/vCFrxs7vu0/jWUhzk7hg=;
        b=ZcHPSIhj1WHywKf8reRYHfoSO8dVj4plGcVg969eVigRCI/b+CdNp12CFJv97CqFjp
         giV6FNdlJo5JYYjRBBdEkaCoW0HAUu2yIq6AIrwDS05ZTKCIgj64vIJo/ZtP+vMJQfHw
         cT8HDwjsM1jePDQ2S4gC87tu/+b2nV64XPYwfT1dTINTtgDgscS2IysMQB4xS812SIFG
         YTRPee8eGS9waMw3zNG4xSfE9+bOn4nxwHACcxoZBEKL2rBcN1Up+dDuoMFhmORRCf6V
         VRBW3/ntJahvxr5iaaQMSeCBxcIjyxuENpGpkPvRZaBjql6bEYJbZyP0r6xwNR64l86O
         wKfA==
X-Gm-Message-State: ANoB5pkdcgoRL5pwwvpv5bN1EYzvUpWzkwkWtddK2BCnZjNVkf3Gwksh
        OkBEUOItZiTiEG7JVkgbygvuDg==
X-Google-Smtp-Source: AA0mqf5jftLRflWRJ9gzjPfBtLmiKax+CH+MiAuyYkqFcM2CcLJBzf79oA9VFqvfZDNJwzvi1L+drg==
X-Received: by 2002:a2e:95c4:0:b0:277:3dd2:beca with SMTP id y4-20020a2e95c4000000b002773dd2becamr22544875ljh.485.1669900657842;
        Thu, 01 Dec 2022 05:17:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512360100b00498fe38ea0fsm645663lfs.174.2022.12.01.05.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:17:37 -0800 (PST)
Message-ID: <6f5ef197-057f-400e-d4e0-649ed5becd38@linaro.org>
Date:   Thu, 1 Dec 2022 14:17:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 14:15, Krzysztof Kozlowski wrote:
> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
>  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
>  3 files changed, 61 insertions(+), 67 deletions(-)

Note to myself:

Use subject prefixes matching the subsystem (git log --oneline -- ...).

Best regards,
Krzysztof

