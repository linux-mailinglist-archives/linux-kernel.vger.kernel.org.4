Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5C6F2FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjEAJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjEAJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:50:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2C1B7
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:50:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so1648672a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682934651; x=1685526651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3qMWocL6/wpbuDG6gR5Wtg+ZCiwCsubf8C3G4b5aRI=;
        b=pezXIELbzEAcCjV+boWauNmc5FQspzcpLCEDI67YIbKjgfsjTRBKe0Wf1wNUHmk3nN
         aJoPy4O0HwPQBG4M/iEiPUcZl8mqheFvGGEJs5FgO/ikYVqByWbj9QFqdO4bG7jG8UtR
         RRNyIunTTrHFKdrMpfP7Nsiz+Skn7pFEk6SV3A+sbnvkWriC7e8QOxRNl3HwA99ta9ff
         /zV8wOJnyflarJDy9mG1Jo3lM7CSov/LGAnQNieTzTzr0o24xCgQubpfFWADbpQl7T68
         KlPoPIeZjUtFfecyoHnbbms6ha2I7OBuMR/O2SrjLbbYt7/8DboATrH913BBTLXgtI/Y
         lCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682934651; x=1685526651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3qMWocL6/wpbuDG6gR5Wtg+ZCiwCsubf8C3G4b5aRI=;
        b=fZW7rfJ34XfCbIH89QcNESZvRRfVfiVLsOjIddQnLA0vygqHPyRIobiphXyBvZaHSL
         tSZP6h5AvyJ0t/vWPCsj7GvuDNHAifRz3vf88IrRfwB3rpge5+eOHfQwalE78IHiy5ty
         8oqR7rkVsAdauFjbyEX1cWn9UAOD7Lf4Wl5I04KCSdiE3GF6EJWZjuBjCMk2KDlKBkZ4
         TJTLh+cjkimlBZUYXivEBDlTKm6uU390MdLZEvNQfn1CVY2zUaT7NFN0UtqhIPbAwJHH
         1ZSYonhUTGPcrc9Dr8eUF/8xPJ8PUXXsp+f8dZD+2fAqZnH41cfV9FcFVQ6frzivLUtX
         wK9g==
X-Gm-Message-State: AC+VfDxDr13n/jsmcqbBEgej4STtGa6tw0owlCYSCg03RgKvquO2BhCy
        f+Sh2m2/oaJ3RQf1Kq9wOWJ0UQ==
X-Google-Smtp-Source: ACHHUZ5aoCRJwdM01aHJAYJ6FZM0GaX+jTFGr55aLgScxrfNq6frPl2fubj4mP8pK+VDgPengBFaAA==
X-Received: by 2002:aa7:cd10:0:b0:506:b228:7aff with SMTP id b16-20020aa7cd10000000b00506b2287affmr5635208edw.23.1682934651694;
        Mon, 01 May 2023 02:50:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7d054000000b004fc01b0aa55sm12145335edo.4.2023.05.01.02.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 02:50:51 -0700 (PDT)
Message-ID: <2b79021d-3793-5f2d-8659-5d0d8fc78017@linaro.org>
Date:   Mon, 1 May 2023 11:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-6-ychuang570808@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230425102418.185783-6-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 12:24, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
> the initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>  .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>  .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml

I don't see any improvements here. Path in maintainers is still broken.

Best regards,
Krzysztof

