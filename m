Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B754733F62
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFQIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFQIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:04:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52B1A4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:04:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9829a5ae978so232868766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686989050; x=1689581050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JskatFucMmAeLdfnFCEkpDxKlTgR0k+Wi7MQ3LzyqlE=;
        b=olYtqBvXhj2eKwZADpIRHO8dazWhRSBP/tCJtpoDYyDDVmhEDF0TB+NvCPLMGD4WHV
         7nvMuE66b4sIY5fkHjfyVyDw/sUoN7iUcwOPjQLHXUeiB5abyGuMZE69eZ7NKiFZCiT1
         XPHSFGYUkCNherRbPgj83LB77/wHo0Gc8G151opIYyhPNBp8VpNM0ISAf/4NYk7rX6/o
         Q80TEGfTdXJU1J4Ez9wqFGMIBNI7uVT9N6SG8jCGL7zjG2HsHjR5BcI8havwN1vUSLJg
         abiAh1Cgosi89RPA+CAQAIlynRtS2tFYFMvq0ReWWtBbidr13hRBc7gLQyB26Vu73/fq
         x2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989050; x=1689581050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JskatFucMmAeLdfnFCEkpDxKlTgR0k+Wi7MQ3LzyqlE=;
        b=TeV1Wp/0ZblH0aKqR7oXUMrwhJPLFrwTvhjZklgGptT4/fuz+mo955wukuUourqCvy
         yJAlgwNvhSLSczR26ewCXBFizS12qAW/+8/heEfkywtasaZbnqawEHwe+/g2bwQcJ9zi
         R/lDfqT1kGJSLWTRk5WmBVG99chEjc3/q79iG4PksVZ1dWXvITMoHSBpHZ5RFBhN19SQ
         7sUFqSzZ7CCuId1szCBj3pg0zHRbhwS1n4joMMkIyrUy5VnOflT90kLRdoaBrZpbVtmF
         3qmRbus5+QP4pENd7k2Gs/kd7f7b9p+XW7+C/LTn01HIfyoIn8byrEmm9LNOlWXWKAqe
         awmg==
X-Gm-Message-State: AC+VfDzo+qAGFA0E3841gY9XzWBNuN6Dgjp/TAa/DPEq3n8tH+QXH7QT
        u7yWXhSJ2N6NecAHhk8w/4RiPQ==
X-Google-Smtp-Source: ACHHUZ7kZqKBEMLNLGBMJ8yGHStlrG8Dg/LXVr7TO3CkwsYIX8auZF1/tEu6GqnbYv+WO0MdC2nQ6A==
X-Received: by 2002:a17:907:3188:b0:966:5a6c:752d with SMTP id xe8-20020a170907318800b009665a6c752dmr4045542ejb.20.1686989050183;
        Sat, 17 Jun 2023 01:04:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090655c800b009828bc469a4sm3813170ejp.103.2023.06.17.01.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:04:09 -0700 (PDT)
Message-ID: <fd07ea29-0b9d-4955-0f1b-2879c8b3442f@linaro.org>
Date:   Sat, 17 Jun 2023 10:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2
 compatible
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
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
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
 <20230615092001.1213132-2-yann.gautier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615092001.1213132-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 11:19, Yann Gautier wrote:
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
> +        items:
> +          - const: st,stm32mp25-sdmmc2

Except what's said, this looks like can be part of previous entry via enum.

Best regards,
Krzysztof

