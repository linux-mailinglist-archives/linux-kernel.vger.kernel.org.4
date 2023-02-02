Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947EB687894
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjBBJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBBJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:17:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62503113D3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:16:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r2so1047596wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvHlDGw4irnssVhbw0IalCi3fA0fsXpCWhZ4mnpzH60=;
        b=TFCKlvYtWUU9umJzvz9AYvmnmKTT0DFSV6ozTprD84RyFJjaCawM9BYraUosbPcy4t
         M47PubftZ3cYoMpWp7DSrVHhuX1xFUnYtamDAjH7B/13jWJFMFmRRN1mhno1XGFng+Sl
         govr0Jqtg2bir9Uzb9KtYYJGLZE37cf0qVnSHVJ2SMmg46VlhZ82Vy97o5MtXDM+uDVO
         27CDv2njD5+vuIv09o1QszTiiAgX2I9PbOdHHWHFaWOnQ94yRru1hCIjT3Rj2w5X5AYf
         qjLs6u6XE2v0MZjfCkWqwVlgeG+Ug/4FdxcuAg4sfHM9WQ9wvRjq55mk3y90oELs6fr5
         O1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvHlDGw4irnssVhbw0IalCi3fA0fsXpCWhZ4mnpzH60=;
        b=CSB8OWepxV7vy6+D1lcCodkMxdlXJrWkU5YheiYGrHyaVco9QDoQbSzEWdPMGftI1o
         OvenE5ML6QHZ2UVw5AaiV7w97gtG3Y2PCMuBz/RUr78wFhxqkx2+XokRKQt83HY1Wd4F
         wMySof5lEMIw5D7W9EHmd5PPnyuN5qmYM81SAjf0UVRCVf8QNnR34tNKe3tJ7YNTO0W6
         8oIDq3rfVCbAz3acDfs7xT+F6VUPKVZWDdzshaGKyt5iw3eH0Mzx8j5I/8bytFM/5Gr4
         dB47afJ5YSEc7+wjcQAOoupA82cFpP0apmeUp2vx1yZhdNIxnTXe/ZPp6hGVO4nPY4TS
         CWjw==
X-Gm-Message-State: AO0yUKVu6ooOYqO02mNj09Fn1InpJK02CUbyMD8o+CGW18rmAhZj/Pz5
        1EfV6Bl7Kj8H1MyIwLGj9j8Png==
X-Google-Smtp-Source: AK7set/+EqP4dyKLpaMG9SUDtAYB0Mt7m8a16V4hCg9x/nwshS0ThvkFQWJXSIZNOPmORGaxCBYYDA==
X-Received: by 2002:adf:c60b:0:b0:2bd:c1de:a33f with SMTP id n11-20020adfc60b000000b002bdc1dea33fmr4621326wrg.19.1675329407966;
        Thu, 02 Feb 2023 01:16:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ay22-20020a5d6f16000000b002c3bec91679sm1490438wrb.110.2023.02.02.01.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:16:47 -0800 (PST)
Message-ID: <70343fad-351d-7c7c-7563-254d60b79558@linaro.org>
Date:   Thu, 2 Feb 2023 10:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH] arm64: defconfig: enable drivers required by the
 Qualcomm SA8775P platform
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230202085958.11055-1-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202085958.11055-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 09:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the pinctrl, GCC clock and interconnect drivers in order to allow
> booting SA8775P boards. The drivers need to be built-in for QUPv3 and
> subsequently UART console to work.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

