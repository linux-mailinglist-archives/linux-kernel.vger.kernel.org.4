Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D4658AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiL2Iqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiL2Iqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:46:39 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCC1147F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:46:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bt23so10014645lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00JBJmBBiBVV/0bx3FG8bOjOr7Fe2FO016Rg6RwMTyA=;
        b=OHDKnWDlr4rdofCxcy9mYZ1WJwSzWBQgYbEyFkdnLkXivVwKpIvsEJZayqCTMEq7sT
         k2X5KQyuZ7yCPvcLd6KoI7XDFrKQZXcb4npzm6ryg4QOPKKXoECuj/72FPEOXc26T2UX
         U3gqO3DdFxJjTNTHK9Ac+h7wYQQ5oni1NDeROmDHT4+E39GJP+M9OYna4aD82cT1R977
         q3y/UsvsAzhvV0KH+zpoaco1S4d64fKe1MPtWQJhb6l/Sf9d55fXeWZH/Ue5IE1Us/K6
         JNBIrc9ix/SpgDowBRGPp6Q20iTqmqfhrexOeIPF6cKfiS0DCB+wOg2VnU8+toylFMJT
         oSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00JBJmBBiBVV/0bx3FG8bOjOr7Fe2FO016Rg6RwMTyA=;
        b=JX9RDa3EMo12Y0/dofQKAx388MHvkU4lG+AmjBn3+/nsi4ZSV6VV15etmGpL3zx97I
         B5ks1PXeVg1Yg83Lw4cWnp5ENDMuJ2FgNsQPf6vaYigHAi8x9JiFbxkcUq9dxqbhSk2T
         A6lQbN4VVKnNsklyQ6tdP0P2gpoXXMQwyh+VwNxDA+eprwPmNdeAE6VObe7LH7E1tku4
         cCQeVrDIgCxiMy4niS4aeNWdSSieKTvb2rGJaW5yGm7XIfXunSvCQInZfpAlrJMm3NBE
         3nfAlyuc8wQDDi8EWxGSU1q/yOjSiLKugtKbNHdqRXsojaOTIjm2AYzcvw2LmtozCqzg
         euyg==
X-Gm-Message-State: AFqh2kohTzLEnwjcMuMO0PWkysab5OCKAhQvk+/Bcb+kAUju2veVyyRo
        +RVcy39Ll/IvY15TENcJ5aOcVA==
X-Google-Smtp-Source: AMrXdXuDtZLYWJ1O1/6oOKr2ktf6+/ZBpd7g4CJ6Z4Rsk8pzJAsC89j6hBEXcq05OZLzKeZlxTTZrg==
X-Received: by 2002:a05:6512:220a:b0:4b4:b667:4b1d with SMTP id h10-20020a056512220a00b004b4b6674b1dmr9041214lfu.27.1672303593720;
        Thu, 29 Dec 2022 00:46:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p16-20020ac24ed0000000b004b4f3c0d9f8sm2980668lfr.283.2022.12.29.00.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:46:33 -0800 (PST)
Message-ID: <170665b6-161a-6dd0-6ceb-199277c0ce2f@linaro.org>
Date:   Thu, 29 Dec 2022 09:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/9] dt-bindings: interrupt-controller: irqc-rzg2l:
 Drop RZG2L_NMI macro
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221000242.340202-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 01:02, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> NMI interrupt is not an external interrupt as compared to IRQ0-7 and
> TINT0-31 on RZ/G2L SoC, so there is no need for RZG2L_NMI macro.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1 -> v2


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

