Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB56CD466
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjC2IU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjC2IUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:20:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7949E0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:19:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c9so8669682lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UBlMMuDB8t3puZJG73DjV36iE47zlqn+c0B/SfjDhw=;
        b=G9AYEWaOjKIg6s/VF8xl+wi5BXbejFA1wMNYnuWR6LYWP2jV9TrGp+hSMVUVckUH99
         qM7VN0ZMxxvnuLxWFcZGHAgtBTMnTWe7NAKgO937dzW/f2vJKs8zFWNmY+ZAR7cwG2oT
         TLaCXrMspF6W4X+g76DNxGkwkFdsMG68NOtmURFCIO1g34MUc8L7OUMwr2LXtTrwHDvS
         HPJK1DaDJ+XE/72stQBRMl0uUQrsXGlYZinO/RLyxjaTi9g/KG4XuzBgMWOgkNcq57ej
         7w4E7/22PudZEwmgrVLmx0rHQfMFAO9bY1+Loo6WSzwPPkfQsVw2GTefhZUiHsRnXFJ/
         YUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UBlMMuDB8t3puZJG73DjV36iE47zlqn+c0B/SfjDhw=;
        b=VMn4RTt/GHUuWf3sh5XdxDGMeRNUVy+PLamD4amj5K26aOta8dj8lzRaPM2Ufqa/2n
         Vhywpr67micYpNHRyVecF1skKd8bFAurYRX1pi2LZvjK7qkdoJDX9ujUu7pGOObgWP8z
         KgNwq4mDC/wMhHXRAYzuoPFqqzozk338ReSxPCfmzzYxp3Pit8URnv43OTbZYcvQ1ONi
         UBlpKe2f6P5kjCHsgdIddYvV5Rn4w5tO95dKHYqHpT5gQ1IfKW0PxnKWwMozQAOl60O9
         5h5a0ZNeK1LhwuKBfoRxXCKzqwNCizRG2nqePwkh0KIVHz+GOsmL7OBzVQgh0aBCJoYG
         BSSg==
X-Gm-Message-State: AAQBX9eCnmAgt5qu9jjO/LPcV6IwMCNa8IvOoXZ4uKFGaV+Sp0DMNEGk
        Ad0PWgSEu95YdIRWOgQ2deU/zzejK9st0JU9N8jB7Q==
X-Google-Smtp-Source: AKy350YN45EncbSPLMyiEe8R1YjUtQTmdEeX00K1ppGIfM9FlVJoRpKWUea2C8VrTuvp/91Z/fzx6A==
X-Received: by 2002:a19:ae02:0:b0:4ea:129c:528 with SMTP id f2-20020a19ae02000000b004ea129c0528mr5438921lfc.56.1680077965939;
        Wed, 29 Mar 2023 01:19:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m18-20020a195212000000b004e95f53adc7sm5387208lfb.27.2023.03.29.01.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:19:25 -0700 (PDT)
Message-ID: <ba59626b-454b-f7d9-fe51-6e588c1ed40e@linaro.org>
Date:   Wed, 29 Mar 2023 10:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328021912.177301-7-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 04:19, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Rename the bindings/arm/npcm directory as nuvoton.
> Add binding for ARMv8 based Nuvotn SoCs and platform boards.

Typo: Nucotn?

> Add initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++

Anyway robot pointed to issues here...


Best regards,
Krzysztof

