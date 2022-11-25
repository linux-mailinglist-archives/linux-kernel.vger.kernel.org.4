Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465256384FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKYIIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiKYIIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:08:42 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F4BC38
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:08:41 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a15so4310786ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVlCLe2tXgcxDZw2iHBi8mQJtJf06p17wSgoJwP9yCI=;
        b=b0rqCCntnPYmzh4xiAK5+t7TvqatYDlK5GGfyrAhtm5MWWxo65kZljLnnCwsSoK2zE
         5rth6sky+e/nuyd74pNSPHoBDmMcAw+LDxcZeGdfyRRXI6Tez/Yr7ydIRYe3V4wu2SxX
         RrsITuetuI0PUktGT+b+kdfUYR7RBpEV9USLBoXDkG8s/Ce3tFLsK3LMooiVIwqZbhnr
         y2mcmc1KkPxi4uJ1KQ2B3eFc1hAIDqw5uk1/POC7ZLTN6P7ONIfjJvV6ehV12B1823hU
         y8rEgHBzLUuZPc7gFwDtwAKcFjkQBBp+G+0hV3bD1c0CSdTDo93KOK2uT3XGAy1+f2wl
         tTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVlCLe2tXgcxDZw2iHBi8mQJtJf06p17wSgoJwP9yCI=;
        b=VPkzp1vwVsDlBA4hPef8sOdcV/rQEPZnQlux/4AOfZZIYEe3H3BXa0DhBEn5GF061j
         N1qBhI431FwuzlhhJsdU6/A5FR3UA2PGRKS3jrM0sfEMdbA0EKPO8U59mU2YzWVSOkPl
         w11RcFlr/SL2xFWFr5v+9nMNzJpWupO6DJsjOreoqR23WOSgBEBt/eGcIY0gNMUiJQT0
         JsSxkVgkSFilwxKKLid///EAt0+fXVz8tuq/dpnsfeK8uwfd6LlgHSLEJYHIoFPOPzXy
         Ok0ZMYYkLaHC7XrvGKWY2/gVn+5KNdDcPkp9wPqsvpg/GMsWqjo6JybhapzemolcPcHd
         YESg==
X-Gm-Message-State: ANoB5pnpNOySgqFxPRScXk4EG4n4MobkIpzgngZ0sefNecWsjtWus0K3
        8o8wJ6idUplVkRaGydJ9T8/erg==
X-Google-Smtp-Source: AA0mqf4y8TOeAe22Hly1N/5VF497j2qebbP5U6K9IzUV3wi6yhM4Y5Q/UDCICzJx1Gc2dtU+2Velwg==
X-Received: by 2002:a2e:824d:0:b0:276:9855:fe8d with SMTP id j13-20020a2e824d000000b002769855fe8dmr11305912ljh.506.1669363719936;
        Fri, 25 Nov 2022 00:08:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o13-20020a056512052d00b004b48cc444ccsm430343lfc.100.2022.11.25.00.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:08:39 -0800 (PST)
Message-ID: <a8fe2f63-ca99-9aea-e4cc-325208b021e8@linaro.org>
Date:   Fri, 25 Nov 2022 09:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/4] regulator: dt-bindings: Add Allwinner D1 system
 LDOs
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20221125040112.18160-1-samuel@sholland.org>
 <20221125040112.18160-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125040112.18160-2-samuel@sholland.org>
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

On 25/11/2022 05:01, Samuel Holland wrote:
> The Allwinner D1 SoC contains two pairs of in-package LDOs. The pair of
> "system" LDOs is for general purpose use. LDOA generally powers the
> board's 1.8 V rail. LDOB powers the in-package DRAM, where applicable.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

