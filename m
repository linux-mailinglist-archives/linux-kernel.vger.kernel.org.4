Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5D67AD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjAYJIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjAYJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:08:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25A42BC6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:08:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id rl14so42454362ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2XUBr6mewmiPBl5OYmyWzaQUcYCO2uD+Ydn8zp2onA=;
        b=dfDHbfiAnoSY9UbqNuN45Goe/Zk1oIL6lTucUIO0BPvTShJwK4iGo++KJ4vXkJoQHY
         ub8wN3UIpqhFUdiTP8DFpM5QDqZEMADkM2xDnBPok8+RP7qCFAu1gVthdUHc/MggLYtp
         +1JH8To8J5XAPsmKOwBf6zUjhgykyLR8bzDoQAsoqpwMPMKwvmiN2YUzLeN+tNz0uZMl
         y0QG6hJ4NYRPd5nBVJ/J7LKD7R7XeoJKS37m7fO69D6XoktLaGs+L1CN26mNz+ml7N2f
         1k/EXbdaaH2y+Fhppbe/UX3TOt3hLHocIbnvx+Ug7d2apsORBRiyj3RLpdmiNLP2QCM1
         JYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2XUBr6mewmiPBl5OYmyWzaQUcYCO2uD+Ydn8zp2onA=;
        b=gmnVCOoThB9NJkv6Za4lzVM+c4ijzO7XH5fifUQSk2uuYzQ1xkojTDmTaQsAUdQ4g3
         KOYdablPHWT4iRje8b9pCQ8ZIHwtqU5AFf65tkhN0bER7kpStZ4Alj4GG6fQqDuncbCl
         VyOpLn7i+lcrOVMncc6L6dF0EqD4W4SPzoOmeboVqNA+5S1qpkQszx97rS99dUcxsSV4
         DePzK8uMJj009CNHyMFBpkzQSgY52s7RbCjg/wogn2W9Yb4nqnG7Z25uAN94khlx999j
         w0u0siRnWRLhvenxRC8NH1qCFWSwo+3RZ0EUQwSbfeIJSRaKzT4M7CE+ZtONWq2nyI0R
         Ibww==
X-Gm-Message-State: AFqh2kp34v4JEO66E9HgQzHHWvX7xKD+Ld7Txt+c9bGEihHuPaqVrn4Z
        QF0CQX2yLDkIMhIWWwovxp7rhgiyGpaxYVWM
X-Google-Smtp-Source: AMrXdXtJTelrDG6WoMCRrLpPH3bLCjHiaAD120Ec90X/hWOH2EdlYwNi6AG0QZdXTunVVqc9t5S2Gw==
X-Received: by 2002:a17:906:c409:b0:863:73ee:bb67 with SMTP id u9-20020a170906c40900b0086373eebb67mr32523218ejz.73.1674637684157;
        Wed, 25 Jan 2023 01:08:04 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id lr26-20020a170906fb9a00b008566b807d8asm2073673ejb.73.2023.01.25.01.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:08:03 -0800 (PST)
Message-ID: <13b0be51-b36e-4e91-aa70-ded7a6d0914d@linaro.org>
Date:   Wed, 25 Jan 2023 11:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] soc: qcom: rpmpd: Expand #defines into structs
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
 <20230125032728.611640-3-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230125032728.611640-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 05:27, Konrad Dybcio wrote:
> Expand preprocessor macros into human-readable structs for easier
> reference.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/soc/qcom/rpmpd.c | 839 +++++++++++++++++++++++++++++++++------
>   1 file changed, 722 insertions(+), 117 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

