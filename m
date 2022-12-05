Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CAD642963
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiLEN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiLEN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:28:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E9D139
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:28:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 1so4917425lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PwSI9VpSC/SnPqRCsbFXKJqXLt4ZCxc6QuP46DNYcMY=;
        b=WVnAq+lZ2HiSrilXWp2Ul3M6gr5yHOz1Yq8pokBcsMHzLha9GSfvDl78s3x9BXjGYd
         DiPU8Z/mZrbGo/txLqzd8Yo5AgXsi81ZBFVsfGrvTdS61NfzgfHcNekhTv6cQzXiAf50
         JO6bE1EbcOPjOBXD/EbOW/KGRmtqJ5Dbaw7uLrIfCttC339iHa64yCzp4xAA7U1UYmSU
         T0+oJbEA33Hy64hHoUrEVGWD7gTjJVeDYzaX1xwuHQVodJRgslnUJh5uaLa2iSli3mYP
         IQwXnaIP8VPynZqTAhTvOy961TRRWE9WzObJ6ykn4c75RJqJKuBoUxrHXNc7LfESqEQ0
         tTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwSI9VpSC/SnPqRCsbFXKJqXLt4ZCxc6QuP46DNYcMY=;
        b=FC/kopx1sOD4zIrbgBypAorzCNUr5ERiP36UlurskR/a2Iuz0eSHRq68HYDUYDF1rK
         jVkgfh2lCAmQPoy9FUBlDPNgese5UyLlrS4a2VGOc5O4q1y8LJmDyfOiQrEaf7tiws8i
         eKn+EF+a7mirdcMa/X96fsG8nT0s83pHd6dpOALjpojQ3jBEvcZr12X7/a1+KZ55VB8W
         Wn9ZJDwiH6jXXE0eyRazTY5LTZXcFMK9cBY4LDFfl0j07+MqCqHc3QSmN5XXuNHWsKyJ
         VicssfrhFqAMG8DZjhkfHwYvYwYosQM7zEDZfucoGKuB+yY3T7oOcDQeZD4XAvtOaufG
         5oYg==
X-Gm-Message-State: ANoB5pkFik7aXVbShk+U8LUir3EeT/E8ANwGIcwrSJx1M5b1G/QBrStC
        Rv8YMVD41zVlhLlhNW0qQKpTc4zc9gmJg94B+5o=
X-Google-Smtp-Source: AA0mqf47eVeP3XuAAV0TjUHuoggvWzWVGid4sHibX3LLyBqIrfuIWHZOpQLOPwzwcboLQEHLMq0lKw==
X-Received: by 2002:a05:6512:3187:b0:4b3:ec7a:6752 with SMTP id i7-20020a056512318700b004b3ec7a6752mr26025043lfe.79.1670246919654;
        Mon, 05 Dec 2022 05:28:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b004b5284a92f9sm2129447lfo.208.2022.12.05.05.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 05:28:39 -0800 (PST)
Message-ID: <f2d7a6f0-2816-2bf3-efbb-015b43bbb686@linaro.org>
Date:   Mon, 5 Dec 2022 14:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: xenon: Add compatible string for
 AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205105931.410686-2-vadym.kochan@plvision.eu>
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

On 05/12/2022 11:59, Vadym Kochan wrote:
> AC5 SoC has Xenon SDHCI IP, but with a limitation of maximum
> 2G DMA address range.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v3:
>    #1 Put compatible string in alphabetical order in the yaml file
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

