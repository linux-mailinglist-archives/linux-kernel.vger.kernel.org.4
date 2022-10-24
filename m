Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E686460AE14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJXOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiJXOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:47:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AED2A94A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:24:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l9so3479192qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIH8d020vJsZXeA6OtBEw1ARZo2qpDkXEQ6A4Z/BQSk=;
        b=OCJVcFFk7dXUPUe82Y6WcdBM+VBWVkGE4ykyVlCiukYTiQWlLuraOEgeDFEIsOjxuY
         TJbeYDtjHT+P750hCyPl4GWws3YXGAExAfGZsNpUeJ6l9lgIRtrsS7wM4pQ+VkFi+PkM
         ox7goYA6FwQCUhLBZNGGQSN9RuCM1sJk5ZhB55ddAV/r5l84SKjLzXzWHux18Ajk/A3z
         sejfOdhCOCQ7yUdRT+5CUOMKUmsKgFnn4ri4TAi4xHlhiAij9Q2/HAdEcjEhBgUJtxbL
         agPWwRy9EJ6Xou+2XjMjN6to8a7XnLxHwSJ7sDiKbxRWjX9g1Xul5z+3DSOSKkBBV9JB
         9eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIH8d020vJsZXeA6OtBEw1ARZo2qpDkXEQ6A4Z/BQSk=;
        b=dhXlSclDIUUWyORzmsPnKaitx2o7ezbqMQyAEBylxneEXpEl4e+Grg/8G3vwatEKeD
         PwcBpW76c/R+Wjg37/CctpZj2/MUGVGOjMYrBsxT7m/JTC/j1q//GhShXdkkP/XpwfX2
         xov0MLky2eWkFWkD8Kqna7WPeIP4mXnjDtIjwYB03VrCl6xFPKS7qFLIBFuVxIVQhUkV
         oHoLZqTDiR9sDX0umUNE6jqRNT3q1h2gcOsBmr+lu8C0zCfqllnclaYMjZTlhrFd73TX
         J78XBplHeIUSn4+KRY7okv2ZLC3CStOfdN8lUjXn7BY5r+0uMAQJhwW7qFkeYBT1TqLl
         c9Ww==
X-Gm-Message-State: ACrzQf11TlO6FClp3Rv19kXS5bUAKUNjxZ3tv+uDGiUfdH4w5V/Us8mW
        CW5CBuagGngU87xrCyP393Tdi6IEz/TZMg==
X-Google-Smtp-Source: AMsMyM4+/30AoIzk584XVjXvlJkY+m/v86UxCWwOYU2S/mnzhukbIyDuIsRHU/iydt8j5m9mdlM+2A==
X-Received: by 2002:a05:620a:24d5:b0:6ee:d4bb:e5ba with SMTP id m21-20020a05620a24d500b006eed4bbe5bamr22547434qkn.457.1666614422216;
        Mon, 24 Oct 2022 05:27:02 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d4-20020ac81184000000b00359961365f1sm12535392qtj.68.2022.10.24.05.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:27:01 -0700 (PDT)
Message-ID: <ae0b04b8-c7b9-0110-0ff8-d36cd832e0f2@linaro.org>
Date:   Mon, 24 Oct 2022 08:27:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 04/21] ARM: s3c: remove adc.c
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-4-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-4-arnd@kernel.org>
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

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver could not be enabled on s3c64xx for a long time
> because of the ARCH_MULTIPLATFORM dependency, so remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

