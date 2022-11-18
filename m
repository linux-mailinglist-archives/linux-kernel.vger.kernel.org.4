Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847EE62EEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiKRILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKRILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:11:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A258C090
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:11:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r12so7022155lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uk8Hyaw66Lh0EQoKmCbXZrgTZOcFS461ofb/wQEqSx8=;
        b=i9lzQ84vQdwIOiaSFmVmnsJRHuG13nZQ1WygheFMDsknEb4b9vHQduR/I8K3PR3Llc
         IH6BMH8o9niHuqLrRVHjH2+hrxCTYimUBQDVBqdWCh1bDTVHkdRUdXmKvTRSxGHmkQp4
         H1Ro3OoFGGNPMyMEhG40gKc8YhZVdubcgMFfh9ant2yl6FRx2tmZ0LTii8K6bodDcRAe
         n5MY/rv0Aj3muiIZldG0BeNcSeJLY6waKcuSt4/kGzg73XThUbUKUQzQTPRWE0rQPc8t
         apotQ1HSrN0Aw90D9wxvkujVE5ejqRgx+T/dN73dbl71+ixFowAtn2d8LRvfQjwOIL1X
         /Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk8Hyaw66Lh0EQoKmCbXZrgTZOcFS461ofb/wQEqSx8=;
        b=Og9qLxDo/08Fpq3qf86ZSA8YPXyrWLCNH4OpToYR7SZ7ISlCv6SzXlCvxgJOiKl+sH
         7iKafJQiFtJelWagYAhFyyKdqbgOr/HN8QN6Ce1RYGFy+M6sKu6eMnbRm7JaWDL2RDL7
         VSzJbgSaX9Qzr/u61XvKmrJIld5kadMGl9PK8gpmQ6Jwl4WRdHmxPfwGmN5Ln2dEbsfj
         GZ1QO+ETgnCKsaVRk5gEMyXLDGwsLtbGTrRU7vf6wCdub+R2hu17jJylk1qxneBz5h/e
         RfwaftPpa6NfIGFid0y0xMB1zt/pjlqmEpt6J9sxuiGsxBa3EGV+qORVfHG15Mh1D2Bc
         qs+A==
X-Gm-Message-State: ANoB5pkZHvUNGOL6sSTtACGnEhYPirPcOrlThpj/EBBHAJDwCis8+K+Z
        d3qOHoTrKx327NA4tTGbv5ArRw==
X-Google-Smtp-Source: AA0mqf57339cwoKXz4hVlcWCZW0RLOxxlTPkrDIxtkcvmTjXjBK9/UBKacKshoAppkr1WSCamHUK+A==
X-Received: by 2002:a05:6512:689:b0:494:78cc:f153 with SMTP id t9-20020a056512068900b0049478ccf153mr1931155lfe.644.1668759076198;
        Fri, 18 Nov 2022 00:11:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f24-20020a193818000000b00492ceda336fsm555057lfa.278.2022.11.18.00.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:11:15 -0800 (PST)
Message-ID: <66005714-ce1e-1968-ae5a-881ddac756d8@linaro.org>
Date:   Fri, 18 Nov 2022 09:11:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: input: cyttsp5: document vddio-supply
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
 <20221117190507.87535-2-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117190507.87535-2-linmengbo0689@protonmail.com>
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

On 17/11/2022 20:05, Lin, Meng-Bo wrote:
> The Samsung touchscreen controllers are often used with external pull-up

Samsung or Cypress?

> for the interrupt line and the I2C lines, so we might need to enable
> a regulator to bring the lines into usable state. Otherwise, this might
> cause spurious interrupts and reading from I2C will fail.
> 
> Document support for a "vddio-supply" that is enabled by the cyttsp5
> driver so that the regulator gets enabled when needed.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

