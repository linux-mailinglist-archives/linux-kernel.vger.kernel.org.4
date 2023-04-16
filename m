Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7358A6E3B05
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDPSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDPSI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:08:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05481BC9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:08:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dx24so14495660ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681668536; x=1684260536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxB9zxzWLE5n5MSYnySx6Z8ocqYMh1ED0/HN+v6ZZWs=;
        b=YbLI0sQ9bbw3+6CBqR/PcHUlMDJpNITpQ40dX93qLp4ZAurcmDYr05rb5MOKUNzucA
         SDoIqpTACjxY4HIdIlfUWRNPkYNCHuloErydK6uCKPtOeBPFzzeaLMSYNyx2okCXsnIR
         sF8yZ+SP6RSUvT7i4K8WZTNdEnhl4oxlIGa0BPviPceC1GjoqgI18vysk1VRBusULlpF
         unqFYmKb7VxFLGsvQPwuQd2Goa+uRADPxRdYX8aBgAgLd5MYXayqKIUXIZq3AxtaIEeo
         WtNHzPLKPQ0vOPXxY1jRCqZbQtkOc0rX3qVLxBA42AGqI+/lWnojEr4xtK+/U8IJDmrL
         IRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668536; x=1684260536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB9zxzWLE5n5MSYnySx6Z8ocqYMh1ED0/HN+v6ZZWs=;
        b=JNU1SqmFI9YvZ7pe9/Ri8UztfCYdB1Np5dxDmfF4bMIkBep9kIyx9OQl6JF9rhnkm9
         FGc61gT+MuBHU4FM0799AifzwGAd9pNtQrFTiKK8fdyD0HzG2oENNo0D9Z/PIsRSV+It
         ZspcdI3JF9AKonfc0JZBIcYEWu5OLcRWf4KcqQfjfdGVoqGSKeIrrVFSY9+8q0G+5NLD
         r54wksfjGZsm2It7Halw3Vxyr/Y0xIBUHe+p9YML9guXoolbQieyQ3+M3LKmC0yMUHD9
         3pgZjYOPotcnpRYtm4gvBnHOsgOPOdyoi/wKmp6EEIk+H/ZPu17cnPzf50OpB9yRPNBf
         D/rg==
X-Gm-Message-State: AAQBX9f452nQsF/uMMHy9cOOt9L5MRSk24a3BhFxxaakji+obX190IKs
        g2552s7q99SyWPW/RX/r78DaGw==
X-Google-Smtp-Source: AKy350YqQnlZ2zVfjEKsAm/m6no/T65ytxxsJ+qKSxgm1A9nbbbXmXwrfibKAVj9yboN2+/Dg1+1KQ==
X-Received: by 2002:a17:906:e282:b0:94a:9470:577e with SMTP id gg2-20020a170906e28200b0094a9470577emr4625964ejb.44.1681668536102;
        Sun, 16 Apr 2023 11:08:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id sc22-20020a1709078a1600b0094f75d6e974sm386565ejc.42.2023.04.16.11.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:08:55 -0700 (PDT)
Message-ID: <4fbf6436-406a-9158-08f3-7319fbb8c034@linaro.org>
Date:   Sun, 16 Apr 2023 20:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/12] ARM: dts: Move common Exynos4x12 definitions to
 exynos4x12.dtsi
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
 <20230416133422.1949-10-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-10-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 15:34, Artur Weber wrote:
> In preparation for the re-introduction of the Exynos4212, move
> their shared definitions to a separate file. Rename the pinctrl
> definitions accordingly, and adapt the Exynos4412 DTSI to these
> changes.

This should be actually revert of the commit you are referencing in all
other patches. Why is it not?

> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi             | 645 +----------------
>  ...2-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} |   4 +-
>  arch/arm/boot/dts/exynos4x12.dtsi             | 665 ++++++++++++++++++

Copy should be detected. Play with -M/-B/-C arguments to format-patch.

Best regards,
Krzysztof

