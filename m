Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECE6E3B11
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDPSKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDPSKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:10:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F962122
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:10:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f32588c13so51385066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681668613; x=1684260613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo9vwDAIQGWd+ZBgWogqeSzYCOSuwuz4YdLXaQda4hk=;
        b=oo/jGAthzIYHD9CeJNKGhp4vfFFhrsxkzAj1QZp2gwQ1B01ATFLNxFCGe1892EehrH
         XDK8LUfmRXSlyBXRach6rloo2FNbY9m3dYgxIXwHG/5nNm9UCSNAcK6PMrKvs2ezUL+1
         uznSFP4iNYkZ9Gd5qHACFzVgJN1s/bVZYnKv08jcGcDAD+OGXH3c6Ko4t4+07F/oh+CP
         Q/RumCJjaCzq3rdq5BlYHibK65gjUtrz7C5RH9K2HVEdquvEZR55kB96EsJ7ZHrOUDQm
         vDi/2cBrSmhL/6qh+zP1u7SibPet6IMy71FDUK2yj92S4LpwBQUJ9lh+X1R/FX11Nl4k
         Mwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668613; x=1684260613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo9vwDAIQGWd+ZBgWogqeSzYCOSuwuz4YdLXaQda4hk=;
        b=l8UK19YCtrqSCBXrOjEMiyzBBWRxn0EcXUoGnvG+H6X2lHtBEmkMcMkESigrjy1XHI
         Vyrm/Wt+G2HYhtcM5BI/1Aak/WLKU11jS2uA/ufAaTbzI/EEVe+rBM6ZXwmxrFaURV7u
         lM7KSswrhm1xyIaPrXEee6bRENUQNGdiGWbXZS8O4uNfM2284eUiaavzgHiMkOrPhNCO
         fqO64qMPWjd/pWSuQCxOaJNb20GuPx13h5YHz5fUDB6vWdQNu+NKL3m8H/UXWtSL22qF
         OXFteVfalZ9wWYDuB6V244q7marV+twKcUs0tx1/ODPu/hsmfIIGZcpCZ+1MQNBdi3ou
         XgFw==
X-Gm-Message-State: AAQBX9eWIpqKbQS2rO7+w+PW61fLFTb2ZqkvZ3JBZvYTdsI67vtqRlcR
        H168y7EX4LtSY7xd9yRLsNlFMA==
X-Google-Smtp-Source: AKy350awJUSJApohEW9Y2HjTY0hDK7meag+QYuc/qIbodh49giYK5YHhG9LMgMx3rmjwQW6KlxBkWw==
X-Received: by 2002:a05:6402:1154:b0:506:83f7:157b with SMTP id g20-20020a056402115400b0050683f7157bmr8288181edw.10.1681668613362;
        Sun, 16 Apr 2023 11:10:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id a7-20020a50ff07000000b00504a356b149sm4706745edu.25.2023.04.16.11.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:10:13 -0700 (PDT)
Message-ID: <185485e5-fa17-dcd2-2354-cdf29d556a53@linaro.org>
Date:   Sun, 16 Apr 2023 20:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/12] ARM: dts: Re-introduce Exynos4212 DTSI
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-11-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-11-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 15:34, Artur Weber wrote:
> The DTSI file was originally dropped in commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), as there were
> no boards using it.

Revert the commit instead, with necessary changes to the files if needed.

Best regards,
Krzysztof

