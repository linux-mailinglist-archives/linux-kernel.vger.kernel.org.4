Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034A74C6C8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGIRii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGIRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:38:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23EFC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:38:34 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so59401861fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688924313; x=1691516313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKdFK7UFqnvYacu1+A6rrJuMR3ECAGc1EkArluB3bgk=;
        b=EIkf7oR5mHW9ET9xqLGWmH4Ta4buPeq5JYwnaGxV7KgwHJhjiZAAn+pwWuKxkK85er
         FHdhAaPDbMalggKP+KMlk2RZeNPqNfSdPHxXe7wGgQjX7+aEWFxH2Yi8mYkh0G7Uz8vf
         GaF5eP91LxL2tP0QIV4ylOgkaw/q8hietq+8CT2P3ofhn9Q8DDgPBA+TGNcjdWm4eoa2
         ZOuKYZ0V+IbiqZ0S9eBkUstRhJfMMuGgZPtnhfI2j8fHE3ErWA8S9kel41lJGl3d5Pgb
         t6JSpp4glxoK1C2ESCIMLEliDRw+HAkoWo12C/LvTKHWZFv9rmegd8+77qRq6dHcXXoj
         +NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688924313; x=1691516313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKdFK7UFqnvYacu1+A6rrJuMR3ECAGc1EkArluB3bgk=;
        b=kAEO+q676dcdgZNEm4LU/2yHnbFSfrfFT3R7E9mK2o1qZa9QKtKVTTPL8wu8e942yE
         gPkyasByd9G+Ysm1SOB4KDr8Hf/tAlBi8qfC4ZHu3NRWkQ2IXWWWRK/0AsKxJTzXD1jq
         flcN7BhyoZYBRxhp+NEY68Z6tP/XsZ2ioHxVlC0Rcx4xLXnS5MprM+3A9uwKRchlg+u0
         I4gmtmFpl1vGJgOseXgR8AWQL7O5oIorcMWgIH+m5kH5lvkirZQgFn8+hr+V4Jz300ic
         QSvMUZflpzDIfUhKD+73Xg0j9cLzFyYmXGnwQOXZPC7AZGKRSZSEQrAHchsbLo/so2SN
         XiwQ==
X-Gm-Message-State: ABy/qLaQYJPTrpbcSiTWmCJmISeciPP8mczYtqJhC2bjQ1lUVa3aB+gH
        OTpzCWlPyCsX+I/3x1ZcDkkPpg==
X-Google-Smtp-Source: APBJJlHNb+8tglQs8vHY4lZ2CClvauiq1wbcrsR8u43ZfraYF4Na+06BhXn1BYHVWuszx3GTUShS9A==
X-Received: by 2002:a2e:b166:0:b0:2b7:117:e54 with SMTP id a6-20020a2eb166000000b002b701170e54mr8428516ljm.4.1688924312739;
        Sun, 09 Jul 2023 10:38:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b009894b476310sm5014978ejr.163.2023.07.09.10.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:38:32 -0700 (PDT)
Message-ID: <3b417e21-1726-a026-cd53-e68cc49b56fc@linaro.org>
Date:   Sun, 9 Jul 2023 19:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/11] iio: adc: qcom-spmi-adc5: remove support for ADC7
 compatible string
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-6-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-6-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> Now that usage of "ADC7" name has been replaced with usage of "ADC5
> Gen2" name everywhere, remove the "qcom,spmi-adc7" compatible string.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 4 ----

Your patchset is not bisectable. Neither this patch nor cover letter
marked this. This is not correct and will lead to broken kernels.

Even if not considering bisectability, this basically breaks the ABI
without any explanation and rationale.

Breaking ABI just because you want to rename something, is not the way
to go, so NAK. Sorry.

Best regards,
Krzysztof

