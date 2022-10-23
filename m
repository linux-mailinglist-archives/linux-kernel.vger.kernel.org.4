Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2CA609459
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJWPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:22:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A766E2F5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:22:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l28so4458702qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mINfRrv10YbsHL8f7bHkN2lhU+cugNCUGw70BIJKqT0=;
        b=EnDn8SmtuqPY0xKqaq/JpfPrX/R4fSxphhQYEK/soFXMmAzvSfBxnDEr0TQhK1MYRP
         9hB0eGS+m3v8et/fK+QpqNuSvNvZht7zNaORiTRsTxJqXOu5MQBMODnWqhMmd8EKosMV
         yiAgEt4uHzto37QjLzy89yU1pDem07xc04L9ubWCxsfNFecswCUymuh/7X7ASVmyH3Lp
         AtWZXcrHWOqrUlm6LHkoiEzaHR0Z3n4umTQGvJA6oUsC81AoiRx46d8eDBpVccUTHik6
         MTAusWduOdBB0DurFycHzFJ5A4znUCwHOyEJnq2C5HbP2V9JIElqqJdoyGOS1SL/37+K
         TY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mINfRrv10YbsHL8f7bHkN2lhU+cugNCUGw70BIJKqT0=;
        b=YovsI2Pwe3c4+kOC6GQnUAfHLHK+d65vkYqNluJU4f6oUY91KzAWTOhw6EU98SovkU
         qXZiap9uC4J96r2ukLmQAn6rgVBMur09od9B0Iso+XIpwUrwyWLAiRvtekOv5tH4CBjv
         jwHdKTRhDT1Q+jK6LDnkVMZKCSc4ZfH3RlJ+M6XbpPlrUBFUZjt3zw2ydeHBS7LJ/EEF
         Cj98UQNv4U7Mx82azNMHpglUBtRFi4Kc1XP3/e7wER4x3Zel0JGjTCbxeok3YIbywt4x
         e+l36No+xbb9Eo/qkT7XnCesMRznLzotynZ/ViV5c7WRKcRwQ9k24KyPBWWWhD0dUIBI
         G/Xg==
X-Gm-Message-State: ACrzQf3cF13DKasEZYIYtJEMF3y3PK1tVLNq4c/pVFpH3U272EM+Dsq7
        EgyfmpyXQ1J/PYnFJpYClnF8fA==
X-Google-Smtp-Source: AMsMyM5E5rQJzhPoo3LiOFHGgRAsT1+TNl2VLLZN+mbvskNNOzafo8Z7l0Kw1RdnqciMhhFUkufK6Q==
X-Received: by 2002:ac8:5808:0:b0:39d:d5cc:5fca with SMTP id g8-20020ac85808000000b0039dd5cc5fcamr10805578qtg.12.1666538549165;
        Sun, 23 Oct 2022 08:22:29 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a450600b006e8f8ca8287sm13275457qkp.120.2022.10.23.08.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 08:22:28 -0700 (PDT)
Message-ID: <8f9d6060-a280-8300-d6ef-d9fe40d4669a@linaro.org>
Date:   Sun, 23 Oct 2022 11:22:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 4/5] dt-bindings: ingenic,x1000-cgu: Add audio clocks
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
 <20221023145653.177234-5-aidanmacdonald.0x0@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221023145653.177234-5-aidanmacdonald.0x0@gmail.com>
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

On 23/10/2022 10:56, Aidan MacDonald wrote:
> Add bindings for audio-related clocks on the Ingenic X1000 SoC.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

