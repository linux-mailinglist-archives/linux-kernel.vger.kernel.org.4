Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C207A6E12EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDMQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDMQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:58:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392565AE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:58:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dm2so39181441ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681405086; x=1683997086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOvW4mc+Adn5JNUnhy7fUIfCKucKwegcOVM7PDNewLA=;
        b=AZBDp3T+IHGru7JMWkdCyaz3OWKW510Y4b9D1dv2ghoo37qwxzu8jc1tdVKMuGsfUN
         HcX/eMomIWlqJdThCe+/BSunvvzL1/mIS8W4Iivq7JIjyUmPeD682Bj+mBLRz+li8XgT
         O+uRU6LTRIiK1ZHJLqMgUgGPA/VKbQxYc6T33KsXjHl3Xp6QZk6qGYNEpqyEyQy8tkbL
         e0krGeXVq6WTEA/OQRQlbH/7JT1tcqOhNLmqNAGHaZmrDSeNMysZGiZLfgC5Uly7EA9a
         H6kgSQ39hiGUnKTNmTjbNfdhnVoOcCLWYBW9SwUt6rTc3cTAtFVjXH+4Slqo8goNd+xW
         CgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405086; x=1683997086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOvW4mc+Adn5JNUnhy7fUIfCKucKwegcOVM7PDNewLA=;
        b=AtIh9eX/AMBo833k5Zal8XklBl+/2DAP3krSbXJbAU7AAeXB59iHo5McovriJh0sFJ
         9IYz5WlgfX/CMJgyaEPt9wYBAWsq6xY6qauWimvbQsosHrozPfU6j5Qkfd2LH6ae8yvu
         qaYOMgh8rDUfuRxqRz0se8zTbjUW+jUSPQh5cSg0014I5L3X+eJtzJdZV84FD54PvNlt
         JxundQGlpDXEoXbI9zNdzvZ6FkOCjfKEMjC6+ix1fBfEu5VaQcSkDnu+0au2KFqCLZKr
         HlFiDDHBt/S7ZN7FMkXeW2nOIspgmes50d9dlA1Oed3C1xHLN3eMubbESSAlMpBcP/FG
         9vEg==
X-Gm-Message-State: AAQBX9dDa5z3X1+PPFrR6fG9szIDhKrbGx4VWtcmIEP6FI+C8b5jPLwr
        GFLrTQweWadbArtlfUb+OFYISw==
X-Google-Smtp-Source: AKy350bHD7VKurQrDdawyURsqGsSO5MZnMsQ0rEB82XLdb+FGtNO429BOBRc3muudH40tLgcU3ypdw==
X-Received: by 2002:a17:906:2009:b0:94a:4cba:3302 with SMTP id 9-20020a170906200900b0094a4cba3302mr3326808ejo.64.1681405086326;
        Thu, 13 Apr 2023 09:58:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id tg4-20020a1709078dc400b0094ea3a32694sm1139944ejc.190.2023.04.13.09.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 09:58:05 -0700 (PDT)
Message-ID: <874a1e5c-f82e-68d7-3617-042deb928071@linaro.org>
Date:   Thu, 13 Apr 2023 18:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1
 reset control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-5-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412053824.106-5-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 07:38, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the reset controller and reset references in the dts.
> Add documentation to describe nuvoton ma35d1 reset driver.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

