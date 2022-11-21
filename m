Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19924631DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiKUKHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiKUKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:07:03 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F1A13D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:56 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id k19so13961208lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MD0eFnpKJSt9a7kOZXqLmHR3GAtqPJd5OPMTOmPwA30=;
        b=vVoPPdxOFaAVpdRcbXYrk8rOd8x25QQwVV1h134MCb3yS1sJz0i0j68YpDZ2gOkJTQ
         pFvVUO0/uPxV649hWr9ifqSk+PBMygXL3vGHSBvaA00qOGlfd3UhDBm2oVMchcFwgZS2
         kh/O2WXzSie5SsPXd5syvldRJmlq2XSRJuhv8UPfHKKhyXjZ4zbc33B821YNb/U7fe1l
         JDo5w7eJ/1J/P8AbAF72NZFL1AClFTyuHJn5p9ZjWUmQpXuAIJmLiNz2anp3bOdT/l4y
         NKifxgTMQwjnXQSHaMJyL/zvKGDr3S7VKOGr7XxLyH69SBFPDRtCdlqQzMVI/PK7VxkN
         5QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD0eFnpKJSt9a7kOZXqLmHR3GAtqPJd5OPMTOmPwA30=;
        b=qyMhNd7yPXfx6tbvclfwocD3AUwjGJUzHuU8kyBMLrXwcTeudhxckCnhHCAkJCIicR
         rdh8IXIMVye6JBIaXbjgSab3dRYRriKdR+3LRxHXP3mtRrDQ+rKnw6RP0cnbcluV/0AM
         FBuJHDwMayXSKtQ0g/vPUThAwaR4cYs7fWOVZ1fd8Az6kz4fVi36A304swJ8XKWi5Nkk
         +RoH7j8B7GFBTnPkuNY8E3dtNzRYG5zqIjFKxa4ijjLtrFl6/2e1lau65VaID0uf+9GF
         RgJwYhtAETwoB9OOW98C0UCRpkg9n654NAg0YfAE7ixzUoSa5AFUJStuggxeya+NakTU
         oXvQ==
X-Gm-Message-State: ANoB5plp5gR6bzmAw/shfkX+GNd+RRHoZHwO7Qdfb48bFd8OZ/GwcboV
        MR14ecNLP/nONTXwzTAHddQwZg==
X-Google-Smtp-Source: AA0mqf6sGd47yvKd+S/EeIhvTzzhdfEJwaWT6j8/BH9tvSSc9JQ5YGQ58u86ZR+VQv3r1DQtDDOUOA==
X-Received: by 2002:a2e:b891:0:b0:277:8df:88a7 with SMTP id r17-20020a2eb891000000b0027708df88a7mr5887159ljp.139.1669025214393;
        Mon, 21 Nov 2022 02:06:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s10-20020a05651c048a00b002770e6c620bsm1363368ljc.106.2022.11.21.02.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:06:54 -0800 (PST)
Message-ID: <daefd388-1bb8-448c-f18e-cf253737b3ea@linaro.org>
Date:   Mon, 21 Nov 2022 11:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] dt-bindings: interrupt-controller: sifive,plic: add
 OpenC906 compatible
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-4-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121041757.418645-4-uwu@icenowy.me>
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

On 21/11/2022 05:17, Icenowy Zheng wrote:
> T-Head OpenC906 is a open-source-licensed fixed-configuration of C906,
> which is now public and able to be integrated.
> 
> Add a compatible for the PLIC shipped as part of OpenC906, which should
> just be ordinary C9xx PLIC.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

