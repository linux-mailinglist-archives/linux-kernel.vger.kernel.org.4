Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AB746DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGDJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjGDJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:44:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99361723
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:43:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so6114922a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688463835; x=1691055835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jjVOyUTnAKMRHBkOAZFEZ2Gt/AchktqGDrwDJg3g/0=;
        b=WMnfo36Btbfm7d0ZlMf3SJM8X7nDp/s5XlMgIET7P+HRjpjlytc+l4t0U4hyXIc6+x
         Gq/K45vYX6Ib+pOG6NTFHwtHboFXecOitRXIHT9fLbn+KifrXzVXeoj9WPOtPpec7Pn1
         v4Wx9/tRn/1q2oAqdmyenxoo+yQydUrV/2jGrBUhcmeAGhAgKKQStcyg3ijkeuev5Ah6
         pgzUQ6o6/21yc/7cKq47qqR3mEFNwAdDOp2Qvllun3RaKnJdbi1219c0VW6rMu5Fq9M1
         Vq7m1lW0r9TfNqtSJrbe9cV//oa46CttOeWLHLAuKfiNhaiMMYPi8nUI6+79345jxXJR
         BjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688463835; x=1691055835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jjVOyUTnAKMRHBkOAZFEZ2Gt/AchktqGDrwDJg3g/0=;
        b=GdcMS2+PNenznHTqSjzlwTe0Evmkro6xb0jsAPolYKI7u5vH1lSXIX5BBo7b5EzZ2B
         EsV6i4vqaEUm4nbRk8syL5a+BI+IBkKN++HCJe1eC6U8I2VGqtLNVPsAqG9knshibV6d
         PGCrAhSwef8ihf2XNqVoD+3yzLdrQi6eE2ITb3fX/6vKkReEGyDiB0SXqHJtocdVEEO6
         gmcBlvwqe0gw2vDrfAHntwPW3to1G1BrPOI1N7ELsIEeVEX1kHnjA3k4RHAocAvMZDIi
         S/DtiyRTPpVTPOJ+tKlcLvmQxOIiXJj1j0Lv3+V8JoDNhzD6f8XPjkM7GmUIxF0ONdhy
         MgwQ==
X-Gm-Message-State: AC+VfDztzgzCrz4QUf9MLJR0nPdvw1fx7MHmrwV5SVomWzKofD2OrS0u
        6nu9iaV/vU0XdsWr8J4jxtwWZA==
X-Google-Smtp-Source: APBJJlH2BFfowyRuGkZg/4gGurh7iScSfZUSYvUlWG8KR6PQzOga/kTW3dcg5eZE/mRNoT1lrgm9rw==
X-Received: by 2002:a17:906:46cf:b0:98d:d26c:e13b with SMTP id k15-20020a17090646cf00b0098dd26ce13bmr9263223ejs.8.1688463835157;
        Tue, 04 Jul 2023 02:43:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b27-20020a170906195b00b00991e2b5a27dsm10457201eje.37.2023.07.04.02.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 02:43:54 -0700 (PDT)
Message-ID: <552d39ee-0fa0-94c0-89b9-245e39e8586d@linaro.org>
Date:   Tue, 4 Jul 2023 11:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: Add QSPI controller node for
 StarFive JH7110 SoC
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-4-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704090453.83980-4-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 11:04, William Qiu wrote:
> Add the quad spi controller node for the StarFive JH7110 SoC.
> 
> Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

...

> +		qspi: spi@13010000 {
> +			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
> +			reg = <0x0 0x13010000 0x0 0x10000>,
> +			      <0x0 0x21000000 0x0 0x400000>;
> +			interrupts = <25>;
> +			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
> +			clock-names = "ref", "ahb", "apb";
> +			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
> +				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
> +				 <&syscrg JH7110_SYSRST_QSPI_REF>;
> +			reset-names = "qspi", "qspi-ocp", "rstc_ref";
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;

Bus nodes are usually disabled by default and enabled when needed for
specific boards.

Best regards,
Krzysztof

