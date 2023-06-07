Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375D072628F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbjFGOTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjFGOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:18:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F191BCC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:18:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977d0ee1736so601507366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686147535; x=1688739535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9R9FL/kljP7klYQURPomPx32pq9iiN+AHVHdTIo1X/s=;
        b=fjACrGO21URflJlUAbeGX1qOr2fFE0jdLZsq/aQFNnF+WnVlp04CPLXgzqjLCtOQ9f
         Anbh8coNHzOBSvcZ2KuvKOHUxu4W9ES9YOd88jFFRcrDlMlg9kivGBXY046dLOD/2YoZ
         fRVwpI4VcqiMFsc/T0yoUx1JuuUmL0YLWBuTGCD2r0pdStQXXVmHKQjG6C2ZDmdu3Ion
         Y/AOx/oIL9DI7kpFySWe/Q+2JmJTBld3MLlIatEocbQQtT3v5wTMqlUV6VIUGif94+jk
         0V4N9qBbQwkqMIAQcB8gVSdMqb/G6OypXD6IWUGefRty3fiz2tWAPlfoEVA3JfxgfCLA
         EJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147535; x=1688739535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9R9FL/kljP7klYQURPomPx32pq9iiN+AHVHdTIo1X/s=;
        b=cwH6P4JSBeaAyJw2M54mjPP32Rx2V2do8zgbhP/JaNgHSoERwyY0GiuGehpMFP71Hf
         8WTIqyKHp6G8e/l6jNFIVcU8HY9QXDd+d0QEnvMPX2yabJpyzQbXsqDMjCLOIDEoY+Jf
         cCdc7j3lNHC29dIvoRzkAmZWjN6gS5tEVE73LKj2Iwf0aqvFgJ2gMdLYhFl2k5oH/7Rp
         3NKRW7dA6rgiYKqysDf4bBb2OAGiG03ekO9tO/yJVJQmjAcyvYi35yFVPAssWQFqb4ck
         A5UZ7OwNCzapATDGHtXRWdU3zrmiYxYEYxYf9I2lx1svuorim611PJ2bcognfUoMu7Dw
         Bndg==
X-Gm-Message-State: AC+VfDwGW0LqTz7090nLPnSNgjXYDHsqAVmcsqY+Y7+kTwPLAjUOGT2j
        7t6edhu6JtzvCl7hKlEgaj6+cw==
X-Google-Smtp-Source: ACHHUZ7MDAz2vD1GVVLqNKd4NcRyBJmnecqHSyLjSQ4ZfNlU3ZTlLib05w5lFnYcfKTzbxBcgHEHUQ==
X-Received: by 2002:a17:907:7baa:b0:94a:74c9:3611 with SMTP id ne42-20020a1709077baa00b0094a74c93611mr6019245ejc.35.1686147534854;
        Wed, 07 Jun 2023 07:18:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m26-20020a17090607da00b00977d6723bd6sm4311564ejc.195.2023.06.07.07.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:18:54 -0700 (PDT)
Message-ID: <17971357-523c-f907-13a9-8f7abce90c24@linaro.org>
Date:   Wed, 7 Jun 2023 16:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607131936.382406-3-tomm.merciai@gmail.com>
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

On 07/06/2023 15:19, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
> 
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v1:
>  - Fixed build error as suggested by RHerring bot
> 
> Changes since v2:
>  - Fixed License as suggested by KKozlowski/CDooley
>  - Removed rotation property as suggested by CDooley/LPinchart
>  - Fixed example node name as suggested by CDooley
>  - Fixed title as suggested by LPinchart
>  - Fixed compatible name as suggested by LPinchart
>  - Removed clock as suggested by LPinchart
>  - Removed gpios not as suggested by LPinchart
>  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
>  - Fixed vendor prefix, unit append as suggested by KKozlowski
>  - Fixed data-lanes
>  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
>  - Dropped status into example  as suggested by KKozlowski
>  - Added vcc-ext-in supply as suggested by LPinchart
>  - Dropped pinctrl into example as suggested by LPinchart
> 
> Changes since v3:
>  - Fixed vcc-ext-in-supply description as suggested by LPinchart
>  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
>  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
>  - Collected Reviewed-by tag from LPinchart

You still did not test it before sending. Four versions of which none
were tested :(

Best regards,
Krzysztof

