Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040B762F681
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiKRNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiKRNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:44:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3C781BD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:44:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so8291028lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/+ARMgwEUQ2ZjYV3x5LOp06hHU3gkx8nkJq53hd/AM=;
        b=HlwyumjJY6+N19ORY47MsA/NLZCIyBuMelPwTJumpvD3CdeEeKejWMop+phGbN/lnH
         u8ThZeUmpT4qySPgX5osxpPz+SjA0M/sdfJSg8BXMfjv1kXxqhJej+hebhZKpnKS1wze
         2nxS4pNyZMjCQHnIfdDiBRdHt+a229wdH75J8klEou9kw1B0MPNedyje1utE/Jan8dcv
         KQ0xUoRpqAhhJ2u4SopjWisKs9uJUFWSZKo9VXNcsAkY9ipoFfgiVTkBUVft8f9XuwJk
         G2hPXoSe0eqGTZuNgXtPgnZ9bQDkbk6tWyD+CZj/AJi/3Fmq+bheBc1W6mtS/a2Ft2aS
         /mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/+ARMgwEUQ2ZjYV3x5LOp06hHU3gkx8nkJq53hd/AM=;
        b=p1lAYmprDp5nkgbnnoPWuLpZ/jPgPVlJolaR7KcvyzgAsFb3aTyGPY7fHwqdSciku/
         iQ6w9yk7JdPkGFsQncyCgXEF6OmZxo0KWWwO/vKU1Dcraz0MuUnkDD/toSA1Xo7OOz86
         zJlUQOqG+XhSGYxxGxGBbgTBnEWOpwCxmXe5i/i9Bx9jg0iRgtRGrVTCAskWrxmCYnWg
         +jS2O6YyL5pN0zmde4rXBsp+tTKjcGR7elNNmMZNVMAhOnbNWZ0EQbX7CcIr5UQMptPu
         6Xw3jNbX4Rswvdcc/PqBSmtZvI972L7huNAxArda7xCRJtov8c4/g4bJdJ56qlthLZH7
         Js9w==
X-Gm-Message-State: ANoB5pnAn7IixG9LIlINLGpchlPApLaiDapAC2rwYKTH3ipcF9TsLmKe
        KB1R4hqV8Hiqase4TWa/VJdddC3rwKdXgXvs
X-Google-Smtp-Source: AA0mqf6UKHbjNVtOSotxDXFXi3D4LOpnccqG9/UpcyupKhuED0gX1s7yvo6ndRD72UxCkRYF3S16Sg==
X-Received: by 2002:ac2:598f:0:b0:4a2:2515:dc59 with SMTP id w15-20020ac2598f000000b004a22515dc59mr2307605lfn.283.1668779077549;
        Fri, 18 Nov 2022 05:44:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g2-20020a2eb5c2000000b0025ebaef9570sm658800ljn.40.2022.11.18.05.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:44:37 -0800 (PST)
Message-ID: <93fbbe8f-05d7-aa85-5f40-2d15a1b97c01@linaro.org>
Date:   Fri, 18 Nov 2022 14:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/Five SoC
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 18/11/2022 14:38, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The WDT block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-wdt" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

