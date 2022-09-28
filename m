Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1291C5EDE96
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiI1OQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI1OQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:16:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA862A8C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:16:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i26so20564026lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CbzFSxJkM1Scz7I3rjC3ZF0jcJs5LYZVzMElwREpYZU=;
        b=OLUgtvoVpmT65VJruvf4qFV8n58qZbD9+3hPgSDX6L2a/doi2j5Ur5Z/xMBi/3Dl0K
         4QKSg9LPVATngQWBjGMyHo5FfnQRkfcXumQOJmONyRFR3qUtCRqiN+l7r7SzcxBPoYuw
         UqBe9b2SOlgAIcRYWCJtE0oD+9xrw5yfCRVFn4rVYFJjudycAG/mK3j5XbxWKc6y88yq
         AhF3gcNzDxJh/1YFvP6fc3l1PzrmK5cdyQV1uq2maU9yAP1HnFvH44TMcjELhzmygPDC
         QSxOMisI2mOYosCz33fTvhBk8n50bQFskdrQyjIsUWoZbZMfD4sOkV1ZBnhr+buh0HJt
         AgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CbzFSxJkM1Scz7I3rjC3ZF0jcJs5LYZVzMElwREpYZU=;
        b=mOIdQNLMCXkeCjUbR7ZPzmdE0+kbUxmT4S9mVjsQu1miu0LwBwhHwV727HhbDNJqaZ
         JuOA93acPG7OVofmuZPiJ5mwHxIKFmH+OKptXS7XI72JVFdWy0TMg1CkdyzDkv4Bvezl
         48r0GYBjKDrCSQ0lDFcq2kD/Y4rqGBW8SpMVjzy2WwoUbBl4WCcScp41o2/YMjtLdort
         zk8UY/T8BfKjDCCG/t3nef5Z566RMmsvZc/YK2Ll6GnOvIwgUDqoBPpJ9J+TO7rS6Bhw
         kXNcOfbqvTpz3D1r4byamvMWt5wA1RrwbI4KWoKnXpVj3j6FKHokZYhprOvQwqNotDcu
         kcXw==
X-Gm-Message-State: ACrzQf1TpgHM9jywVOdaTDMk11MYHkKE75/xpspirqnv3QLwt9tYt9K3
        kyjol6LhRJ1foD86uluShnk8OA==
X-Google-Smtp-Source: AMsMyM6FhI84bKm5oQLgQrMOGz+oGA/Q8YtV23VYxHJ1LIZc9+Sz5Cc8gcl9Vq+dUxMIpQ/gksiN6A==
X-Received: by 2002:a05:6512:3b0b:b0:49a:d44b:428 with SMTP id f11-20020a0565123b0b00b0049ad44b0428mr14325599lfv.0.1664374565421;
        Wed, 28 Sep 2022 07:16:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u20-20020ac25194000000b00498fd423cc3sm481496lfi.295.2022.09.28.07.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:16:04 -0700 (PDT)
Message-ID: <dcdd6a86-e486-e535-543e-3789ef8d81ce@linaro.org>
Date:   Wed, 28 Sep 2022 16:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: msm8916-samsung-j5-common: Add
 initial common device tree
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "Lin, Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
 <20220928121717.102402-1-linmengbo0689@protonmail.com>
 <20220928123816.104641-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928123816.104641-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 14:39, Lin, Meng-Bo wrote:
> The smartphones below are using the MSM8916 SoC,
> which are released in 2015-2016:
> 
> Samsung Galaxy J5 2015 (SM-J500*)
> Samsung Galaxy J5 2016 (SM-J510*)
> Samsung Galaxy J3 2016
> - SM-J3109/SM-J320Y/SM-J320YZ
> - SM-J320N0/SM-J320ZN
> - SM-J320P/SM-J320R4/SM-J320V/SM-S320VL

No need to repeat it in every commit.

> 
> Add a common device tree for with initial support for:
> 
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART (on USB connector via the SM5703 MUIC)
> - WCNSS (WiFi/BT)
> - Regulators
> 
> The three devices (some varints of J3, all other variants of J5 released
> in 2015 and J5X released in 2016) are very similar, with some differences
> in display and GPIO pins. The common parts are shared in
> msm8916-samsung-j5-common.dtsi to reduce duplication.

The same.

> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  ...6-samsung-j5.dts => msm8916-samsung-j5-common.dtsi} | 10 ++--------

Thanks for using proper format options. However your patch is not
bisectable - kernel is broken here.


Best regards,
Krzysztof

