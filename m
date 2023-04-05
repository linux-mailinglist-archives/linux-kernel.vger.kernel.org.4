Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A26D7EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbjDEOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbjDEOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:10:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA010D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:10:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-93e2e037121so52032666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680703811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvOmlxoGAylOqENinxxMBNZ8lZyC7DLu4QtEeQBzNi0=;
        b=Z9d2Ho39EqDixvyHrB4Oayp71nncorFT2DdIMDrooT+tZFKUIn7zqTBoBqQgjA03Xp
         Mdnt0zJU3JOt7GP4BD3jAk1eqXMnba88O1q7zW7n+Mj3wpE6PV1xKBkzbV08yEqFt2Zw
         xqdDtoqFIHIhwXH3awiRVTW6gAay6uYQhw5g6yZa7i4Xm2jZs/YF2QVUpO+FRbMRQOq4
         xfuNxxeQCb/ky9C76uPFWVwzsFQdc4xgfP8+wS1PwwMhzscOziaUZxrHXtnHSPI2w0G2
         ul85AlLR54Kt653fJP+1FP/+zQ4pNKTKpiGYSujKvLkqzvj1O+5FR8L3MCmO3aFq067T
         RMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvOmlxoGAylOqENinxxMBNZ8lZyC7DLu4QtEeQBzNi0=;
        b=PsdK82nXp1GR5GoMGt2Nooecc0I0NOFisUS0nsaV3G/Qmb/V63rba9voSArVeT5Vg0
         gwN6fmNPukLM+4cOtcEWLzsHBk/KJ2jQOEHDBoByp2stQr8tClyb0rD3YWlvOnKaNIBm
         AbepyUhTMtBz3AEWmle/INzBHRg2eVZkflB0JExULbxVRG1vnpnF5eRh9B1r9MrlX8Lq
         uJe6CHn55Jyp7AKMHa5kp/DWJJbf4t6Ih6odhE2GLTKtFoAciaYnZC7QGzHhixY5rWeb
         8YNgvPRowY/zs05NuaYpuqg0WdtR5h/y1IaQOIoMaJHaUJhBD9PL52kWey1I1thZyJZY
         Th8A==
X-Gm-Message-State: AAQBX9ce037+dHEiVYzvYYaCYdROdzUNIlVqRJ9srLs1/ZMzHFIecE65
        A4moNg+v3z0sC46Yw9GBGbTu/WJKyPH/Sd7jYTw=
X-Google-Smtp-Source: AKy350bPt+a6akiscCfaBtuARWL+zW+RxvYzPMCy9YTVESVskv4UXHoarulp4PV3qE2JWGmZK3MHzQ==
X-Received: by 2002:aa7:cf0e:0:b0:4ea:a9b0:a511 with SMTP id a14-20020aa7cf0e000000b004eaa9b0a511mr1235685edy.37.1680703811436;
        Wed, 05 Apr 2023 07:10:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id c30-20020a50d65e000000b004af70c546dasm7361330edj.87.2023.04.05.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 07:10:11 -0700 (PDT)
Message-ID: <748c4391-1c8c-8fc2-cef9-6091512c77ef@linaro.org>
Date:   Wed, 5 Apr 2023 16:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] dt-bindings: iio: dac: add mcp4822
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
 <20230405140114.99011-4-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405140114.99011-4-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 16:01, Nicolas Frattaroli wrote:
> The MCP4801, MCP4802, MCP4811, MCP4812, MCP4821, and MCP4822 are
> SPI digital-to-analog converters by Microchip, which have an
> internal voltage reference, in contrast to the MCP49xx series
> of DACs which use an external voltage reference.
> 
> Thus, these need a separate binding, as to not overcomplicate
> the mcp4922 binding.

The difference is just one property which is very easy to handle - one
allOf:if:then: with
    vref-supply: false

Are there any other differences?

Best regards,
Krzysztof

