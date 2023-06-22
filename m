Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DAA739722
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFVGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFVGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:00:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C810F6;
        Wed, 21 Jun 2023 23:00:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so475901a12.1;
        Wed, 21 Jun 2023 23:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687413651; x=1690005651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7gKgsjsMfyVBNiMs1mpv7rOGyaAfvold3DdqGyoiUw=;
        b=oV958KePJ/IPsbb+byG0qYD+PDYiicQmtVEdUUzBAQHs2VctwWkD+nKLHWywItYnkm
         RWIaYl0Dz904fpo1i4eICLECcjMCeKvrdB3k/XUQg/XKqDFm2cbtGsDVw17o9ZDCe971
         IO/6evJMqmXZqUZizfqhkFeYpApoookctFeKcpTzLG3J7XuTasWyiXwgQCHO2oO9+4qU
         wSKol3AQTg8lFaWLSjh7FNdYrE8omfojXyAKW8B2yoQTqExsPNG3Wj+umzjGGrkM8OT9
         qIi8VZnCegX8jbS9krjjm0vgzyVOJxCu8/brz862GF/zmKPF3DB81piKzVDqmJoSBH41
         9n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687413651; x=1690005651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7gKgsjsMfyVBNiMs1mpv7rOGyaAfvold3DdqGyoiUw=;
        b=K125XvnUyHUnQ0eSMpyzhv+T3lfCLY6tA3tCm3DlL0/9TjWcWfQZHKHa9wOeKyxEjD
         K6mw40Y5pLkFU1sDPPEWW0z280cKw0f5vTfeoKTOoigQilwsuf55dqZumt1N1agAZcqo
         JwXVV4LaBKY8DNRFSNrhkcHyZstHtfqHIXGbzcPrdmBoRHyimqVMe9v6SdMkmQm8pK/K
         EiQvZvTQ6Oj9XMJOY+H45QSN+AxaEXQjHCwpe6mB9mPcLQQ7FkEuxoiP0sBUC4fl9fzb
         UqNKb72RRTfQUPOERvLy01dLCWSQ2cgxGxLucQKxYgZ3QKq6bGa85+z9SSyLwm7XcXNv
         BBmg==
X-Gm-Message-State: AC+VfDyuEwe9W3BlpMsYSqveZbxOsms0nXOOilDCROCoDPWiFacBPfol
        jKZ1e4vEf/V3S1JFBQfc3+U=
X-Google-Smtp-Source: ACHHUZ7rqspLzMrzlNYZB3IJsbjLl9nW9TLTOgUKMyQX87x4nCpqdyO8277XbaxzLxIOiSzSRFLjdQ==
X-Received: by 2002:a17:906:58cd:b0:989:d9d:d90a with SMTP id e13-20020a17090658cd00b009890d9dd90amr8276054ejs.34.1687413650935;
        Wed, 21 Jun 2023 23:00:50 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id u15-20020a17090626cf00b0098882200623sm4040904ejc.82.2023.06.21.23.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 23:00:50 -0700 (PDT)
Message-ID: <1521fc62-1c8d-ff74-fa52-2acc8dab4c19@gmail.com>
Date:   Thu, 22 Jun 2023 08:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: phy: brcm,brcmstb-usb-phy: Fix error in
 "compatible" conditional schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230621230958.3815818-1-robh@kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230621230958.3815818-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 01:09, Rob Herring wrote:
> The conditional if/then schema has an error as the "enum" values have
> "const" in them. Drop the "const".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Oops, it's my mistake.

Fixes: 46b616c1574d ("dt-bindings: phy: brcm, brcmstb-usb-phy: add BCM4908 binding")

Acked-by: Rafał Miłecki <rafal@milecki.pl>

Thanks!


> ---
>   .../devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml         | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> index 43a4b880534c..580fbe37b37f 100644
> --- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> @@ -115,8 +115,8 @@ allOf:
>           compatible:
>             contains:
>               enum:
> -              - const: brcm,bcm4908-usb-phy
> -              - const: brcm,brcmstb-usb-phy
> +              - brcm,bcm4908-usb-phy
> +              - brcm,brcmstb-usb-phy
>       then:
>         properties:
>           reg:

