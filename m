Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB176B5D9B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCKQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCKQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:00:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA41F2090
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:00:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j11so32474608edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678550424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBMbxaDpVx3TfaO783vsAGs5TveZ/8Yt54IKh+0DiEk=;
        b=VitN/wrBrIOmh8Tl+EmJKf9TJJd1nc08BOudi2mQF2PPqNHBg3gqxzfM4tDQQp6XWa
         xdRUgdNEuAwIPvOCvowBoCFU3KAZcxJ2LOwDRai/80whe47/JJRqXuRyZGiaEo4odIi3
         bqz1ANYW+Nt2MOfhlnwhwZl6ZydHEyxnIRncmJ2RpHzGWGD2nESk7x8ZTbjCOThaWMyn
         XVG9BMabHipHGB+W5SNbIwK267HZy/tyiTrDaLbjX5ZXGh4emdaHX9mT/3c/Axrmh5J5
         Eo6PA/EvrN9Ynpiq8LmKIV0F9VNlIZX0cv1fl0CYC3nv9xtaPWqSDDRXqZZln8d3mRXk
         adjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678550424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBMbxaDpVx3TfaO783vsAGs5TveZ/8Yt54IKh+0DiEk=;
        b=ymewoqh1aAJnj50tvCw86OAaDkEQhQYegFhL0+toTR6b+MJYaruONsMh/7OhGcw3lQ
         qlj2XCzWPa60fvs258BvGA7KNUg6FYARULp01x9k78K+ApESfyUJtymv5DxduAVq7lm1
         5X4beNB1DNFCxisOOUhRZ2lky2hdy10DlRQRAjFazUb29zMBBchdXSHsBAh/ImCCkgsI
         NAovDUQcvEcAiVyAsmv9CciT8nQLrTDn47Vy1wFg1MDOAyahEbhjjAbncNCIVgD8woXS
         WPx/8RYvx7DEcftHi0VyUflOlg9DUbfFZBm4iB1LxjPOhkGy5fBx/bhIRQYjAy6CgiBm
         Wlww==
X-Gm-Message-State: AO0yUKXtoiOeIPwgRjP701v6h017L2HJeIhD5TlIkS1cVvx34vwVxg//
        c2kW4geC1YNGqtYRDs2qfJA/KQ==
X-Google-Smtp-Source: AK7set9G4KtMXYdRcjs6ZsXcBJ0uVk/Tbs6J8XeC+KP3T872bugZUO6tYjkiZ4Puz3c7+tcY+FxwwA==
X-Received: by 2002:a17:906:49b:b0:8b2:e93:3f59 with SMTP id f27-20020a170906049b00b008b20e933f59mr5117554eja.31.1678550423717;
        Sat, 11 Mar 2023 08:00:23 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906841200b009222a7192b4sm573232ejx.30.2023.03.11.08.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 08:00:23 -0800 (PST)
Message-ID: <9b6fbb54-705d-3e3a-b7e7-ec62297929cb@linaro.org>
Date:   Sat, 11 Mar 2023 17:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for BeaglePlay
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
References: <20230311111022.23717-1-nm@ti.com>
 <20230311111022.23717-2-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111022.23717-2-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 12:10, Nishanth Menon wrote:
> From: Robert Nelson <robertcnelson@gmail.com>
> 
> This board is based on ti,am625

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> https://beagleplay.org/
> https://git.beagleboard.org/beagleplay/beagleplay
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

Your chain order is not correct. If Robert is the author, his SoB is first.

> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)

Best regards,
Krzysztof

