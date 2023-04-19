Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB926E80C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjDSSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjDSSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:00:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655475FD5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:00:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so858831a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681927222; x=1684519222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2I2Wa/X6Ddr2CE5rQy/YNbr0tj1O7f8j69D9Dt8gE8A=;
        b=KgWFma0xE4JrAty0GXMD93VqdwMMQIlJ/WTBKlcDPSiu2gr2ApC/KBIL5x5MzOoOaT
         zuk+E+XH70UbzTgeMvkyYHBjzgsDbJXH6f9KskUTlEVotUPiy/51lmikd0CA2zw4KfxA
         blhu0oGCRtDvKCEo1CJMEszRr7mdLRfVGIPPBgwtgj40ThdEz3hVE6CxZIzKvrxylG05
         c/it9ENcHlXEJJMnjc8CVl1b1stylRltWTKg1RDZq4ulfnC2KUukSwv2iaDI6tPGNgDg
         HBlNwZxjNbwPVIqvQz1Fxu3hSDF7ONd+61B7zLtnj+RDOdGDHDplqBILRkCOQG+iLpHo
         fRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927222; x=1684519222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I2Wa/X6Ddr2CE5rQy/YNbr0tj1O7f8j69D9Dt8gE8A=;
        b=MyYRva69T4G6HW13W/PSXE5fqW2lEPpMvT1dYYYRls1//xXLIpMDBRl8nTAZkEUnQb
         7VWvb/32VSP45a+lsiUN2rnYrF4hBLd4IuVIVI1ORjhz6S6jdXh7Ona3DL6EaVxRgfUC
         iiFP0L6DTw8mDaPze/hb9bqFiwPXzou15UScs6wpFaduWzALC61ZHH5WZXjV0dlbuGdT
         hENU/pf4feCw4TGEQwnnD1b6S4yDLwI3l1N75oK+OVKAc2iNl9Wl6zzMQzTfi3bNd5Ft
         THf0DX/gU2N3cRlYZC5VMjzMSBXJ9vBC1kc13w9tSJPwC5FPegGw4HbpP19lGrrLFZZJ
         kiCg==
X-Gm-Message-State: AAQBX9fKUvEPDANoMNrhgmXjaXyPp2AyPWkZoNi54ZqPxdjhGTB1TJw2
        9EC0dDkvisGmes1aWyhSZ5W4Vg==
X-Google-Smtp-Source: AKy350a42tEOCE3He5e94ySjqTXikL5UDReEMgplEfXFidB0B095T+B4soS12NaB+U7/9uOpgw8fEg==
X-Received: by 2002:aa7:dbd5:0:b0:504:9e79:e86f with SMTP id v21-20020aa7dbd5000000b005049e79e86fmr3031031edt.18.1681927221879;
        Wed, 19 Apr 2023 11:00:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id m20-20020a50ef14000000b00501d39f1d2dsm8260610eds.41.2023.04.19.11.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:00:21 -0700 (PDT)
Message-ID: <d655a748-4022-8d77-2f40-83bace7394b2@linaro.org>
Date:   Wed, 19 Apr 2023 20:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230419034833.43243-1-changhuang.liang@starfivetech.com>
 <20230419034833.43243-2-changhuang.liang@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419034833.43243-2-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 05:48, Changhuang Liang wrote:
> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
> rx/tx power switch, and it don't need the properties of reg and
> interrupts.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml       | 15 +++++++++++++

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

