Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33C613C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJaRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJaRlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:41:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C001513D69
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:41:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso677009wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/OpgeoeT7Af136IYQ4r3OQjgAT02ZBjfVXL9qn1o/M=;
        b=tmu37pv2M36Eh1MEouK9cr5G8V7M6XmhSKO/J7sGvSl8iw4IpEw76eWF0XlLhAKP3x
         ubv2Kh9NW9aL5WUN24AMRxFw1OHiqGznvWwlz3Rzut1N4+RXboLvtn7k0Ku27K9OhRPf
         MIPhzD5bpwUlAnYo7P4FaKPPWr9jg/R2Xf9oFQB8GRgFlhB6AufUXw16QwfLzA2Dz2L+
         k4xMV/H/xbV2sYxscsKFP0sTZfLFgAE/ZejVjlOTrc02Y9Ob+i/FnQIMlboBAUNbwRfO
         K0WRMMRuQQNtpzhlnCFHRH1mbK4gKDcSIIrwLVkufl6qzi+EADsq7c1FmkAR7umWTwxL
         VFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/OpgeoeT7Af136IYQ4r3OQjgAT02ZBjfVXL9qn1o/M=;
        b=breroSAgHntA5Y2SxRh6ktNkJMHuypN1+JdzhwxTWMIOGg5wV2OVv3LK/WSRqnfcDi
         HyFwSF5bKWBpTb6wJv22Ch5599m8QV4HmgLJLt75Plp6JhoyY8W/8Q6jxu4jXgJK7PE4
         X0i+qYwxCAeNliSalRttkJCb5fAw5oI7xLzRFLAA1KH228jXDfw9/AJHx54/Kvzxgj4Y
         KZGsMMZpZqdS22mLGkF1+l6wDlyVJrzb2FPDbDtfC4BAUZMk+f5NxiCRAzQxL3yqynou
         oK7Bp3dLqoh9ZBr/Gj+gnH6MnKsCjatC9gQmKIpJOOTV0T7VQ6CyIVAjtiIWsWATARC3
         291w==
X-Gm-Message-State: ACrzQf2x8gVCtiXN2Swkb7NYoFibds70tqevHQOmCfbBQ5Wd/sDC387L
        YlWGC12s50+F+k6Ps7jfFGCgV6X/2QZICQ==
X-Google-Smtp-Source: AMsMyM55+npV/D80DBdbhTDyJtLxU1fuAGuUKvpU07CgaqByW/XCNI4AmnNwV+McKAMVAwlNEKxViw==
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id u7-20020a7bc047000000b003b4adc71ecbmr8993665wmc.144.1667238068336;
        Mon, 31 Oct 2022 10:41:08 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a15-20020a5d53cf000000b0023682011c1dsm7767985wrw.104.2022.10.31.10.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:41:07 -0700 (PDT)
Message-ID: <d6f4731b-5383-22a6-ca4c-76aed6c20147@linaro.org>
Date:   Mon, 31 Oct 2022 17:41:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/3] nvmem: stm32: several minor improvements
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/10/2022 16:49, Patrick Delaunay wrote:
> 
> Several minor improvement for BSEC driver = nvmem stm32 romem
> - move STM32MP15_BSEC_NUM_LOWER in config, to prepare introduction
>    of next STM32MP products with more OTP
> - add warning when upper OTPs are updated to indicate possible ECC issue
>    for second update
> - add nvmem type attribute so userspace is able to know how the data is
>    stored in OTPs
> 
> Changes in v2:
>    - Add patch "move STM32MP15_BSEC_NUM_LOWER in config" in the serie,
>      solve dependency issue for "priv->lower" in patch "nvmem: stm32:
>      add warning when upper OTPs are updated"
> 
> Patrick Delaunay (3):
>    nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config
>    nvmem: stm32: add warning when upper OTPs are updated
>    nvmem: stm32: add nvmem type attribute
> 
Applied thanks,
--srini

>   drivers/nvmem/stm32-romem.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
