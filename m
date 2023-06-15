Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5C7319C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjFONVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbjFONU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:20:59 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA1270C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:20:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5703cb4bcb4so4854057b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686835250; x=1689427250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aX97xCToWV5//RvNXLNZC2c3J5Dbjde6RJhRL1H+eSE=;
        b=Z7Vt+tJ6ZXAT2LMJTiuoQ4nJjIelvhefnByDBbvXpt8TZcUd8RDeuFg7udKdaqRbAV
         coYNEisPjOGrp1ArWfKkeAS3dltxJqa+Tx6R5v5/Qvp28sHYnb8CRmoeUU9KzGP78y2k
         n5lY8y00Gbrvp9tbOl++/Gzhg2y1yzHKXLW/2vYk9TuxbAzc2FKUoCcgukT2W32nvTGc
         jP5iNG7m4UeqYq5dp4oLbAUfWWoTh/lnVvssrjTWwhP8hBHxlgJSktu+kllPHlxZRPNM
         tczsTr+tYWs81+5oGtdledEpN+aCpaUeem933gLMQYq3B5vY7kICltVUUKcq22ZR9nB5
         jF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686835250; x=1689427250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aX97xCToWV5//RvNXLNZC2c3J5Dbjde6RJhRL1H+eSE=;
        b=fLBvF4X3e/02qB2Zw7PJA2rO4rC7WmWi/Z1jt5nfvCrNCGV13oCDO7zCIPBsNXH40u
         4cSAJOYs7QxQ5wyTV7a8zKjicoCZKpLjA7faYWCmJJ/i8jA1HncclSd9xVcJ7CBbaQM5
         V6PzGhVmm7VckNEUqlryMwm8jFhfYj/lML8aCLxOjwArH2Iw5LvUjLjG0CyLBxLE9M05
         P013Y5ovlS1mwoXV4ZxHkDlGUHil53yAAXpZV2R3KJg1mY9IL8tVVicjtakpCt8matdo
         0RP0KzZWWh9go6B+W1npiLZ82pcBsPNqbUoeojZ6VBhdbufNL9riZFRYZn+pp1/BcAnK
         gZ4A==
X-Gm-Message-State: AC+VfDwY4aNrXtsUFkkZwWsHJo/bzaHFFxAW/bFDVp6M0xnvTkNJvvR8
        jO3B8lw2RITzk2tyIMIs4o/b7GYT8wDva6kSfHkflg==
X-Google-Smtp-Source: ACHHUZ7cc7qLuWFlmewZHndMeTGJ1lCp7+tWMjE+IKpjzV597WRvXEOfvUA5tnyK2rMjzUksHUpC1md88NP3KWhBAFU=
X-Received: by 2002:a81:a50d:0:b0:56d:278:fea0 with SMTP id
 u13-20020a81a50d000000b0056d0278fea0mr4849499ywg.7.1686835250160; Thu, 15 Jun
 2023 06:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230615092001.1213132-1-yann.gautier@foss.st.com> <20230615092001.1213132-2-yann.gautier@foss.st.com>
In-Reply-To: <20230615092001.1213132-2-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Jun 2023 15:20:14 +0200
Message-ID: <CAPDyKFqJsqmNzeRg8hj55yUEMSycOWsmKVKsMWk4Qu7Y8_dNzg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 at 11:20, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> For STM32MP25, we'll need to distinguish how is managed the delay block.
> This is done through a new comptible dedicated for this SoC, as the
> delay block registers are located in SYSCFG peripheral.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1c96da04f0e53..e47b3418b6c77 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -59,6 +59,12 @@ properties:
>            - const: st,stm32-sdmmc2
>            - const: arm,pl18x
>            - const: arm,primecell
> +      - description: Entry for STMicroelectronics variant of PL18x for
> +          STM32MP25. This dedicated compatible is used by bootloaders.

What does this last sentence mean? Can we drop it?

> +        items:
> +          - const: st,stm32mp25-sdmmc2
> +          - const: arm,pl18x
> +          - const: arm,primecell
>
>    clocks:
>      description: One or two clocks, the "apb_pclk" and the "MCLK"
> --
> 2.25.1
>

Kind regards
Uffe
