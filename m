Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85F669DEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjBUL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjBUL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:26:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC34624488
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:26:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so16213125edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHbKR2m+ywXpCXnZM0exqgvtcPw2O6ABggPWu9BvoN4=;
        b=R9+walYXq2Y7zxrm+gnrtxKExw8KYaNL7+C4BwJDnbYDDjPma+voio4V7IMVLXdiRm
         msWk6RRgDsA2bI2SCd0H2bB0uG35IvH0WaHmTpxlIJP7bHrOQN2vx6/Z/XnNv8X79rN4
         ZYCjJJO853MVKF7i8uIzEI19GNlB7DSWsVJn7xjcB3cd/I5dJFQYL152BUZoDqCAmHTR
         kwUrnihYMiXFooHccoQErA/l/rDhn5x/hLQ6x8u4pQlM9ECV0WgyHAQZO0D67z1XbEwG
         409hqVjpwmtzCZv/0OYP2Gh1uBDPS5hzFrgX1de6FTBgB88T76olZTyhZnIqsn/1CaLT
         DxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHbKR2m+ywXpCXnZM0exqgvtcPw2O6ABggPWu9BvoN4=;
        b=bRFjkdj7dMsRwI2pbTlZ6xMQs62onMYs0OTVfNmRH4LG5xDXj8cAAbOzuuF66yY/4c
         8b2A/5gefuh+8Tcca9T51nIOXnA73orFkvw48JtXcoBWaGUQjR8sC0AZ885gUlifdQ6K
         ZFB3+pYzCzwxptu4W0A8ZXOaSzdSlYJkiUs2N3tG4Cd3QbifnVnM0nLMdsbSCTxY6FLZ
         iAWaNeSr4PmOWLfLejevy8Krx7ksG5UoC5EChVi9r+gewPhcqriujibsXDsqqWrb27zJ
         NOQgNlxH0CjlF0aqiLG175cNUEoWdTDU2+ziY/bzRfJqSFw71OGOXXRx99WgofHOzBcx
         FF8A==
X-Gm-Message-State: AO0yUKWYXRoZ8Mdsj89ap0SmpBwBeboWYcDrHnqKRR6DVdxeShO2Mn42
        +PMlIhJtQ5m0ckIM9HvJC9ibaA==
X-Google-Smtp-Source: AK7set/hoEeKJdNyqDj9X+vez8ZgBQcuREJn5JynOD5+WGwCyXxjQ19wOr8kdZ1bzXKag3dBWsvrHA==
X-Received: by 2002:a17:906:1c56:b0:877:ef84:c7de with SMTP id l22-20020a1709061c5600b00877ef84c7demr11356772ejg.61.1676978791367;
        Tue, 21 Feb 2023 03:26:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id wq12-20020a170907064c00b008b17ed98d05sm5975803ejb.120.2023.02.21.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:26:31 -0800 (PST)
Message-ID: <3fb23e7c-aad2-bec1-01e5-299c9b515d6f@linaro.org>
Date:   Tue, 21 Feb 2023 12:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 04/11] dt-bindings: clock: Add StarFive JH7110
 Image-Signal-Process clock and reset generator
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-5-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221083323.302471-5-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 09:33, Xingyu Wu wrote:
> Add bindings for the Image-Signal-Process clock and reset
> generator (ISPCRG) on the JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

