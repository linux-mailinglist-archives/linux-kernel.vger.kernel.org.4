Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13B474C68A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGIRR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGIRR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:17:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0E129
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:17:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so1683047a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923041; x=1691515041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7imIfml5dDYKBfen+YuD1TuRXW1lkvNFnc3KUcJLps4=;
        b=l918Kz85vywpW18YhZfRklEFcOgWqbeh8XXNjxVH6h7aJRFnTM04jwfnuvfsU6Fns9
         pQM6rbRbUVMBuI/mYCcJGVbwvuCwBX+ot8M+iXoFHDKebWqcDtOLbD6TMmfWejjMxwz9
         iJiSUK3KJvwoU9A6ujfHSJmg8zgUcbUBNJtBDazY7gdmr0Wc9POH9RDAf6tXnCP/fIBq
         qh7nnWixUjtqhfs9GWIu53NwJThtDttpSGXYb7qGpCw+PTAtZYayMJInXxpZqA9m4taY
         kDkAr5TV0+olIE3VPdlnOYUEP70ixJf0Rltsp8zP/weIp+mQ+ApFVfBeUYglMtga4WcE
         kOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923041; x=1691515041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7imIfml5dDYKBfen+YuD1TuRXW1lkvNFnc3KUcJLps4=;
        b=geuCOXD3UVBrneatsRmerwqELCs4vTvWQC9v9fosYgBucXXSWQnVKNwR/cS1F28u0F
         2zQ/yLgfRSeD+H3kS6E4rmyy1HteKd8Pc1ocYC9Mctl/wj3BQPjGSjFFG8CPXuisFtcD
         jJnjoEMwqBI0MfsSbTCr1r0oRKMFPrFkyWBrahNBbVG6ld+RcTxdPDYpU3W8x1yPZkJh
         /SDOk8iSbNFyP+d4D6P3D5dUq6M3MXXv20FBOejrZTQJgR7q8jgrpkSBh4UTckIa5X5F
         78HN7D/aahcsjyF4bytQqgh6AhU7GpR3oRxt2qSLc1KxCJw/Mem/IQM8EsdoZi1GZ1xQ
         g8OQ==
X-Gm-Message-State: ABy/qLZni//ooO0uE87JBuAgaNkdjkdvKI15/qwv8Qz8OTVoYqBI72vd
        9mvAsC8/VJ4RD5/LSXpiVkjL8w==
X-Google-Smtp-Source: APBJJlFQ0RX8bsto/VZSh3JnW0Z5X8xoCpF2ycuVh7baxg1T7oyywW3hEpAQxiuHj+2Ect/JOmEyNA==
X-Received: by 2002:aa7:d287:0:b0:51c:dd99:a211 with SMTP id w7-20020aa7d287000000b0051cdd99a211mr8705245edq.27.1688923041327;
        Sun, 09 Jul 2023 10:17:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b009929ab17be0sm4968222eje.162.2023.07.09.10.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:17:20 -0700 (PDT)
Message-ID: <935c14fd-e87f-e89b-f641-7fb529bc7e50@linaro.org>
Date:   Sun, 9 Jul 2023 19:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/11] iio: adc: Update bindings for ADC7 name used on
 QCOM PMICs
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Luca Weiss <luca@z3ntu.xyz>,
        linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-2-quic_jprakash@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-2-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> The name used initially for this version of Qualcomm Technologies, Inc.
> PMIC ADC was ADC7, following the convention of calling the PMIC generation
> PMIC7. However, the names were later amended internally to ADC5 Gen2 and
> PMIC5 Gen2. In addition, the latest PMIC generation now is known as
> PMIC5 Gen3 with ADC5 Gen3 supported on it. With this addition, it makes more
> sense to correct the name for this version of ADCs to ADC5 Gen2 from ADC7.
> Since this affects ADC devices across some PMICs, update the names accordingly.
> 
> In order to avoid breaking the existing implementations of ADC7, add
> support for ADC5 Gen2 first now and remove the ADC7 support in a later
> patch.

I don't understand and I do not see it explained, why do you remove
ADC7. The patch is also doing way too many things at the same time...

> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 21 +++--
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 16 ++--
>  .../iio/qcom,spmi-adc5-gen2-pm8350.h          | 64 +++++++++++++
>  .../iio/qcom,spmi-adc5-gen2-pm8350b.h         | 89 +++++++++++++++++++
>  .../iio/qcom,spmi-adc5-gen2-pmk8350.h         | 47 ++++++++++
>  .../iio/qcom,spmi-adc5-gen2-pmr735a.h         | 29 ++++++
>  .../iio/qcom,spmi-adc5-gen2-pmr735b.h         | 28 ++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h      | 77 ++++++++++++++++

Bindings are always separate patches. If this is commit for bindings, then:

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.



Best regards,
Krzysztof

