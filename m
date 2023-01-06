Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2523660082
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAFMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjAFMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:49:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB5745B1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:49:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1019503wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DO3ss9Dxqnrg5MvW6N1eul9RwSLXHqf4f+h75Y9LOxE=;
        b=wF24k/X5dbbv9O8LRTSjhRregtsxFsfuL6+g+J/ZBO5lrWh0SYF/GQUzeaUlgN+ogf
         UDOtV+kW8RbyxskON0mUFfpze+JtBbEP2Rm/t1s+yudy5c/WDH44j5rg59PcPdrwOP0Z
         RETX184gJTlEv23iLzkSbkST1Qbksu5ENvtFNsCVYZvjjKNmq4wNBGHtIfXkL1jkpxz/
         x2IZEcF/KCKlTEbuNyyAzvKqPzZvFY69S2Tx0eAhY/KsAl6sKG27nmQddUTCnARrndsY
         f5viLt9YNkC+79IOpGC0b4e8f90Ex+Rp2ZO1qqmFiIXGnVhNndJyGQJcQiBMgXyd0VYe
         fq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DO3ss9Dxqnrg5MvW6N1eul9RwSLXHqf4f+h75Y9LOxE=;
        b=mcGWGbJhnE0qYwbKOrSjTttlfFgYSJfPI+sriXmXj659uGBC86sXoVP5zHE8zU8h0R
         aGrC6w6pHnl8GEnGwXU3ukO6npDIWqEhlS5uhgb/1Hv0vg24ws1Q3zQ1KdveXc+JRc3l
         48dRF8Bp61OyTtu33H4DsQH9Za7Ejbais1gMYJSKhQ2JSvgGTXLbyOgJmHSybynmz9Tf
         KMFtc9qdbP5X081OoRhVewsmqX+4qSZSXLJpH9xN0akWzmd8+pI42JMX2eqLQp0bzTSL
         cibnmPRNqFs68KohRCtP9l8US3lJQTpLkVs9z8oJAaMky51inkBzFkOSSQNzNBv9Kdgc
         228A==
X-Gm-Message-State: AFqh2kqKACgThUAm5Da4YXJeGrdNnCj9zfQVnPksiyMwg5IImt4agiz4
        l3slTt5/GZGzbFAJNmRnubxTcB/0rpOBK0yK
X-Google-Smtp-Source: AMrXdXvMLnrgddQhDBKssheqmPV5+Li9wci3CYhgJqif8fxltIi1QAatQ5huVkgmTKnGbfsCCT+Acg==
X-Received: by 2002:a05:600c:4b1d:b0:3d3:3deb:d916 with SMTP id i29-20020a05600c4b1d00b003d33debd916mr39779693wmp.4.1673009352686;
        Fri, 06 Jan 2023 04:49:12 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm1542292wmc.34.2023.01.06.04.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:49:11 -0800 (PST)
Message-ID: <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org>
Date:   Fri, 6 Jan 2023 13:49:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
 <20230105151740.29436-2-sinthu.raja@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105151740.29436-2-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 16:17, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> AM68 Starter Kit is a low cost, small form factor board designed for
> TI's AM68 SoC which is optimized to provide best in class performance
> for industrial applications and add binding for the same.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>

What happened here?

Best regards,
Krzysztof

