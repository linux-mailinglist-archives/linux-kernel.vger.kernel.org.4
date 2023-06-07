Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22372692B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjFGStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjFGStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:49:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2ED1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:48:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-973f78329e3so1259943566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686163738; x=1688755738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dcinz4Do6XCJqn5XwIXIMVUlGePC0aOBOdBvUi6kdLw=;
        b=bfXcSg3kn+4GdMtsDqNEJZW4MJHFDMZ8aieK+DbyIay74cXxHQA7bZiqKq+FCPKxff
         OvipYXRDl4A4+HcdhZT/W6U/Sr9sTW5sn2uc+bOA2NpFsD5oip4jooiXu5r8Z2aQ4Afz
         V5Q9IKftt58iYfhRGtwAVNAhZ7me542bryZ0mFfxNKwRe1IC/R+ITAejnkesOHEqOoM9
         k4dtUTUaf71wTe2GaDRhZLV7Qn+W3ho8K23kgA5O4bRKTuAMySmbVwR8c9vf2sTCajNK
         yMc/tP6wd2kXDClqkM/BT2/RqObtXZ+oeoDXuSV7GbIpxJ1/KEXgvMqwxhqHUlQoydzY
         kJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163738; x=1688755738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dcinz4Do6XCJqn5XwIXIMVUlGePC0aOBOdBvUi6kdLw=;
        b=ZuR/tUzu+FZGKwX8Sc3toXx4HJuyql8KYqB7XmzkLsStDca35j00x4yW5eZZyMh2it
         UEAK+IDqby8F5SMlg7WPNdSDX+vSDgSOmtr5IN8Mb16hw+AaiJyGwbStPjAF47yAlc4Y
         c5yPRJD270ZaYetpW28cY7MhYF47YB/qetQo3yawgEXskuFYDF347BD/Lw53+0bqtbJd
         H1Izp5zk65DSJyzuOSBbRqxzUSyVcTJOF+IaOxAEk7SX8J2YDG7EFdRoMwZYUyLPphiW
         +QNX5YQ15KMkBV9yQwAQk/GasWmtZFIrMLbNtRYMDtEquEKeQ7oQgYymhuT/6FpwOFW4
         nDLA==
X-Gm-Message-State: AC+VfDyg3ntiJOMvhwdIewhNvnL9jRfgmTJXU+QBuESi7ebt9iTwDjN9
        jvWN27k1wLgjmSRUp/7ffRraSA==
X-Google-Smtp-Source: ACHHUZ7T8jA0UZN8Cs+lehRF26n5FdGaiEIBvkEKcP1rFRIEg8fCpognrs6b98qjf+uh3D3/Yki6TQ==
X-Received: by 2002:a17:907:2d08:b0:94e:116:8581 with SMTP id gs8-20020a1709072d0800b0094e01168581mr7665387ejc.5.1686163738005;
        Wed, 07 Jun 2023 11:48:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709060a5600b0096f6a131b9fsm7193130ejf.23.2023.06.07.11.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:48:57 -0700 (PDT)
Message-ID: <758c36be-5240-44a1-bebb-93d608a336ba@linaro.org>
Date:   Wed, 7 Jun 2023 20:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/2] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230607145026.2899547-1-AVKrasnov@sberdevices.ru>
 <20230607145026.2899547-2-AVKrasnov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607145026.2899547-2-AVKrasnov@sberdevices.ru>
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

On 07/06/2023 16:50, Arseniy Krasnov wrote:
> Add description of 'nand-rb' property. Use "Fixes" because this property
> must be supported since the beginning.
> 
> Fixes: fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---


>  .../devicetree/bindings/mtd/amlogic,meson-nand.yaml        | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 28fb9a7dd70f..54208a4191af 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -58,6 +58,12 @@ patternProperties:
>              meson-gxl-nfc 8, 16, 24, 30, 40, 50, 60
>              meson-axg-nfc 8
>  
> +      nand-rb:
> +        maxItems: 1
> +        items:
> +          minimum: 0

Drop minimum. It's uint.

> +          maximum: 0
> +

Best regards,
Krzysztof

