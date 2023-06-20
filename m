Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAA7364D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjFTHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjFTHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:36:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA792114
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:35:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988b204ce5fso236445666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687246517; x=1689838517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6fqHgVGTvAGEge4slHeahAPuPVrMwSOfozTjAKGa0Y=;
        b=Yji/pgBZN7d++Sid+HcEIidtRXT0Fb6QIzrEUFmRX0qd74h2FSoWudHPjf9s+ifBS8
         wZnxIn6zEZ+niUv1s+WCDxAUGGAPRO0/7Y7waFkw8X4NnMJbzXfd+5E1xz+tFItjrp+v
         ZO9+rKbq7ZViNuWPDClur+ZoZZTiE/xPNjKdwPi/FY1k5xKQIp6rkEqULJMmxY+SHtb+
         gF5Ppj3fyddf++DUjfRttZyFAP4f24EUniMk4WdlpPP5nkvRio2tZOgJ2Zh/7Baf7bf5
         IxUV+UkqxYIm29rq/BOa8aoxzWBUVe1liiKSC2umDeOEZV6bEAw13TixXZCaaMBnQdfu
         QX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687246517; x=1689838517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6fqHgVGTvAGEge4slHeahAPuPVrMwSOfozTjAKGa0Y=;
        b=bkSJWPQqQJ0TdD5Vfen49VUyZkTLiklR8Kaw1JRDIoVOZ2j6yk9TSPn/2BKdc+Tf4x
         9CSkdtHkmwNt7l50uho/2is2lj15oc8iMEOmb+j0LXRKnExDjRDA1VCpoFBYwuwMsBdy
         iPRpiiGpGtY/oG/jWE4aMh8FzLamvpVcn1WNqSrP1XFUDtDgxlqyxv228B8qIBdtqVSA
         JnIJVkEjuA4ePsq2LIEbsJjswzLqQ5LbJhCXUWOjrwP60DF4kQR2B+iyiDW0vRkJ1h2X
         uMwIssZQEcWJk2iI7AYPvb3Gx3jPSYjvIvPLEetox1Ks5zwKUB2dD2346n4/xZqDSJF3
         48jQ==
X-Gm-Message-State: AC+VfDxUBsY1E4F69ewBztPshEWgBsYGZQHKPTkKj+1UOnmyxOwQcVQD
        kPN4KOb5EifglGqW34sSClGytw==
X-Google-Smtp-Source: ACHHUZ6IGq0LH6ffc+9WenmwXXDz0VXornUzZFY4Y2O4BUaSbVbU6In+6roCGuExwy1p2OlGDdY8Xw==
X-Received: by 2002:a17:907:7ea6:b0:988:dfdc:5a33 with SMTP id qb38-20020a1709077ea600b00988dfdc5a33mr2947774ejc.64.1687246517174;
        Tue, 20 Jun 2023 00:35:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906125700b0098733a40bb7sm851867eja.155.2023.06.20.00.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 00:35:16 -0700 (PDT)
Message-ID: <2e762290-46f1-0f0c-48b1-b399812f9ac1@linaro.org>
Date:   Tue, 20 Jun 2023 09:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: New binding for
 Meson-C3 SoCs
To:     Huqiang Qin <huqiang.qin@amlogic.com>, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230620070849.2059451-1-huqiang.qin@amlogic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620070849.2059451-1-huqiang.qin@amlogic.com>
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

On 20/06/2023 09:08, Huqiang Qin wrote:
> Update dt-binding document for GPIO interrupt controller of Meson-C3 SoCs
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> index bde63f8f090e..fdea0488a98c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> @@ -19,6 +19,7 @@ Required properties:
>      "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
>      "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
>      "amlogic,meson-s4-gpio-intc" for S4 SoCs (S802X2, S905Y4, S805X2G, S905W2)
> +    "amlogic,meson-c3-gpio-intc" for C3 SoCs (C308L, C302X)

Where is the user?

If there is going to be resend/new version:
A nit, subject: drop second/last, redundant "New binding for". The
"dt-bindings" prefix is already stating that these are bindings.
"Add Meson C3 SoC interrupt controller"

Best regards,
Krzysztof

