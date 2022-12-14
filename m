Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEA64C4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiLNIUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiLNIT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:19:27 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FF646A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:18:57 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id n1so5896562ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qauwXllkZd1HwBEvIO1AtYxdLngESLIvJDuIkKTViw=;
        b=vw4SW63aI6kZLoMTi7D+Zh13z7pKz54d6uW1ODY6MLADskCUr4Ut/7WbMqC8tJWbn9
         eZ9hAxf6V2CLl4Wj/vDo4iZ3KKDl/aKQQ76Tpqq4bolfudTjs9Uz0N5PjNZk5iKFsGUp
         d8f1tYpfJKZwB94f/iCnYjG2nECfDGaSps5i+WGBRJRbzDXB27mxk/GOt+gVejuHHuTb
         78LD9QUuMF2lQXyOLA6LBce5m7vwpR9M6cqrFOfJQRTXXXMJkYnukCBVef9mpDO/FCJA
         cEZFvUvG3Bi/zvl7h8FF2/+KBbPIjwWynkYUPV+BuRdTxODMq8ZyiKh4ch3YLcDZ1KRa
         +Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qauwXllkZd1HwBEvIO1AtYxdLngESLIvJDuIkKTViw=;
        b=jyYfIqKAqcKtTgF4ldqH6Rj9B3vg1LhswHZjJJONFBDxk/QXshXSRh/jfEeclFY3zt
         2RkRjrZ07jnFPAnaEJ3UjzD3qyeJqY2Bgh1PeBerlotualFYqeJ4RcqsC1U3o9le8Sjd
         K27L9yJtAK5qh2OZaz6w54+BowRtzFdND3C8tU5mG0x++YOH3pPbK1KHLeJIRouRA3o7
         wbSmP14wXrLFR+cl9YgjkIquhE13SewP34Mv895weJtqhPMH/BmwUaymI9tjfxyB8qam
         hiNlNB2umpKYaev5tutnl4lhfWeJmfR37NI4Ee54XW2UbwCzoj8BT4NRfqFEuaMnT+kn
         k44A==
X-Gm-Message-State: ANoB5pn1sW80Wb0buTqjQ7NXz4HPVpkyk0/UJZQbFAOVE9gVBxzYEDIn
        LR9RMrpTuJylNLH5DfGr21ofLw==
X-Google-Smtp-Source: AA0mqf4dKoFn+eg3b0tgWknclf0VPQlTSKSA6KN646N5BUlaKeQvEYhIV3pr+6scbCZibjRc1/KTpQ==
X-Received: by 2002:a05:651c:1a14:b0:27c:66d0:de55 with SMTP id by20-20020a05651c1a1400b0027c66d0de55mr899105ljb.12.1671005935484;
        Wed, 14 Dec 2022 00:18:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e7a13000000b0026fbac7468bsm508112ljc.103.2022.12.14.00.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 00:18:55 -0800 (PST)
Message-ID: <35a5380c-46f3-6fd4-60ef-e2820b16c707@linaro.org>
Date:   Wed, 14 Dec 2022 09:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: add QCOM SM6350 camera clock
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213152617.296426-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213152617.296426-1-konrad.dybcio@linaro.org>
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

On 13/12/2022 16:26, Konrad Dybcio wrote:
> Add device tree bindings for camera clock controller for
> Qualcomm Technology Inc's SM6350 SoC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

