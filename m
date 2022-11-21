Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA400631CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiKUJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKUJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:16:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D43C82238
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:16:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so17907778lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSoATgDuYJCqtLZiLkcjWQyfmNIFo6/9riVTZW34g5w=;
        b=rAalcdX25X8ReiUQmHE2xSXDrSBaAkr05elOax1nJ5I/vp06bNjV2DeNVqcnz7nUqm
         1nIHqe7s9PKUnhptdn2SWztCjI9xGLCWTd8DQbaz7MGJUWOp12GNkruiddO5OI4DTnFw
         dM8CSVsg+fC2S4xU0ahLHyU5uIpTvtVALT2gmWtRMIfDoU6JNP8wOpQM0wnPV7HBjvxT
         TtaBeLoZ4P9FLRBL+PCFkh9UluHAiGUv5UTiz76NtMHzS2ck1gvT4gp5f5b0A5QN+zc1
         g4ShR4zmeP4pRhVuWRGp5Ok15mAxThVLb6jQIsaMNJB+OlFe78eintRBInDI1J/H3+Tt
         eIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSoATgDuYJCqtLZiLkcjWQyfmNIFo6/9riVTZW34g5w=;
        b=z7nzV58vg57tv1js6mapvShcSyoUv48vH7DJT2sRYl1eu7M1zzEcp0oKmLZkBn0lRi
         gWEgeZ0WFZea/t8eG2X15gL8DRCoeYXodyepNw48jzo8ajcxzor7y9Rr9t6N7w/e+PEr
         k0Zg6rFGKjGvdVjC/wU77rXsmi2OmVLUTHgAk5uKzkK6UFkFkzqmRoHhYY1K5+gCzxOt
         PHa7r+IjEXgSat/1WcN5LM1yicP2R3Qwtfmx2bXMbjxo58U+GW+OX2Af47X0dsL2B9Au
         0J/TwkY+X2O3EpsSFcbLsKqqhqxjjaqnqsmRGBe5uWZ6OpyoNIfLloV629spETBfPkpU
         gYaQ==
X-Gm-Message-State: ANoB5pkq+tMHRHKlF2gaD9tHnQg/Yj/RrirK3IWAJc7KrlWNq7TdkLz3
        EGKeCt/nDXW1Jrz3XSJXojJb7ZYs84MirrTZ
X-Google-Smtp-Source: AA0mqf4tJuu7MHZlbhe0PtUwIGaug0aZqs8YNtHWfbLHkZoN9X/eeMgGWLdR3F+bF5F0gfdh8DYoBg==
X-Received: by 2002:ac2:5e26:0:b0:4b1:4602:3f9 with SMTP id o6-20020ac25e26000000b004b1460203f9mr5878010lfg.80.1669022208899;
        Mon, 21 Nov 2022 01:16:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t9-20020a056512030900b004a05837103csm1933808lfp.196.2022.11.21.01.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:16:48 -0800 (PST)
Message-ID: <491869c6-ef79-891c-93f2-1b7e0e4c8c5a@linaro.org>
Date:   Mon, 21 Nov 2022 10:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/5] dt-bindings: qcom: Document bindings for new
 msm8916-gplus-fl8005a device
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221119202316.93142-1-linmengbo0689@protonmail.com>
 <20221119202629.93505-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221119202629.93505-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 21:27, Lin, Meng-Bo wrote:
> Document the new gplus,fl8005a device tree bindings used in its
> device tree.
> 

Subject: drop second, redundant "bindings".
Just "Add GPlus FL8005A phone/tablet/car/thingy"


> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Best regards,
Krzysztof

