Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2766F6E3AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDPSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDPSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:06:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7C10FA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:06:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id xi5so58516140ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681668380; x=1684260380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zx4HOdq1glymmchauCaLCgaY7UhtC2caCXREOqnLcnE=;
        b=ddakFiPtPqcA6nXNg9qB79RhsTIQJkU2ZRVv3zqRn9m4GLf8VHwtPzmMb/HkqKx3TO
         QgtiFm9x04J54FEgP5o0dZC70R4QnPpum/vVl0or2d4pelkja8AIamHrNbqjP9V3Io59
         iDuQeYhw1d93IPJv5i+ZVKhpEu741aUYqv0AfrZUPXCD6Z6V1OfQa6rWRQcbyHM3I1CH
         QOj2GzhEXqk71OyChXdSPodkye+GFJSL6S1AEczvmNdgi8MpD8csdOPQ2YD2e3Vz+sG8
         x4sxuXBzS9H+50F62r+FTY7DPNuRD7OcS0ZksVCYZiv+ufVWN7x+CboTSbrmUbQvup1a
         dMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668380; x=1684260380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zx4HOdq1glymmchauCaLCgaY7UhtC2caCXREOqnLcnE=;
        b=fhygyoRNdb9PbUzqKoh00olfPwN5X4r5vpgul4+ffPjUW0rF48TOdzK/KJJzuFmUVx
         PjxQnk0BvpjvZRhE49Hs6jTNIY8ZAFkDEw2c02deMvWW70NJfeGtRh8KvgyRVVo0SIuY
         Vmm59iXXULzOojdUrTiuBvkbtl3dQracXduOxswbnbo9DL8giZPVxnvVyIFu5kUEBOwZ
         dZne9U9JC2p5QKtW7y7LSS1bg4KfMVYLE0tAEYPT0Ht4Q/wzqqSPx/5KeunOUBGnLXKQ
         G/DFvbpLsgCUa6iO5eS0stnMXGMrD8RHy8pxZ7WtD6jNA1wI+1FaMKIqlb+BHJgtZeJw
         9jrw==
X-Gm-Message-State: AAQBX9ePPCWwGG3F5ukJnaGoXUi2rAU1cQoCXV9qaXqPppg9cdeiP446
        mRL2Ij3NisALsqygLxpk1ht8Tw==
X-Google-Smtp-Source: AKy350as9Ry/0XZTLgutgv5F71m3xIEIuueZ6CB5ap8/e/hdGHn/MB6do5KVKLt/AnCFrHGfPkHrUQ==
X-Received: by 2002:a17:907:a424:b0:94f:6218:191f with SMTP id sg36-20020a170907a42400b0094f6218191fmr1809248ejc.52.1681668380277;
        Sun, 16 Apr 2023 11:06:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906739500b0094f7c1b6a94sm191773ejl.11.2023.04.16.11.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:06:19 -0700 (PDT)
Message-ID: <cedc7ebd-9852-9cef-7020-abfeb873b0a6@linaro.org>
Date:   Sun, 16 Apr 2023 20:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/12] Revert "phy: Remove SOC_EXYNOS4212 dep. from
 PHY_EXYNOS4X12_USB"
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
 <20230416133422.1949-9-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-9-aweber.kernel@gmail.com>
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
> The platform was originally dropped in commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), as there were
> no boards using it.
> 
> We will be adding a device that uses it, so add it back.
> 
> This reverts commit fee7e1d50c6e6da1d99035181ba5a5c88f5bb526.

As in all other commits, do not reference the DTS but the commit which
removed this part you are reverting.

Best regards,
Krzysztof

