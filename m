Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB076B0B53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjCHOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjCHOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:34:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A69A43471
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:34:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s11so66581110edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678286087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sr9+Tr2n8Mmt58h0Z1F/3/sRtkDaHU1uY4sWcQnY2kw=;
        b=D3jvffyWRbATIx1tWCrE5xoyQZcZC8E9+8+nWdoUdAuP8/yur58qwkkJ3rCeayNSwB
         x/sD2F27qa/cR9KujFQR2RB/7vd2KvvYtj1pokUp7oYxOmJXEcVUfDf4WF8I3ers35XA
         ZAdrxDDlx6ewJPB8Ix38VSDwW2HTMSraR9ikJ4OhFmGJOd6cJkytJnFo2gGGzelljLW3
         q8oUh/LCduRqu0u59rQjO0j4MlAw1JdkoxG9W9Z8EcSRv6KiSP0tvsC5oE9ulsgwydxH
         s9sOzU4BLRQFnksGP1sltQa+GJkbMxOoWNCLNwOqk+K+QIr2q0Gs8i24/uqZksWxemMm
         Zfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr9+Tr2n8Mmt58h0Z1F/3/sRtkDaHU1uY4sWcQnY2kw=;
        b=C/Y++G5jneyvWxYCqt8BGbOXNBC4y9nkCUaSWLpck755+VMxGlcFH5JPyiFANbJCit
         TpjMbQ5gh9F2DNnm05seAmoq1h7atKeZIzBrAX3LLGqrCQ0+9MbLaPDMuyeUb7axUt7a
         2rsXss2vu7sQ9a923TTZG8TJzOFJ/jJf2jRJOZnNOIEg25rfFJaKRJD704LrVihJbcrz
         DNPviW2UVeVEOc34GpXVyASeF6V0scv78QzmI2hrmxUeMeDemEXvP9AiZq8mW6h8pc4F
         gnnIsodgyPSq+D2EX6uIdTocn8XVDpZu1Z1e03Ibn0UEcsRX9+T58RICjdlHE2Z6418s
         2m4Q==
X-Gm-Message-State: AO0yUKUopxaiamE0baoV1TjPR5RfWAGHw1fLaNFYtzl/aoCGFQyBn6Zu
        JtJGuHbtHXAjwXMvFrm9nPg3/Q==
X-Google-Smtp-Source: AK7set9jEeIVuUFx7pZKgIdZdftTYm6ZL2N8ApryA/j4etXuJ0VT+nxTTGZBOYPeCwyCC43ushGqag==
X-Received: by 2002:a17:907:8a06:b0:889:ed81:dff7 with SMTP id sc6-20020a1709078a0600b00889ed81dff7mr23174446ejc.9.1678286087563;
        Wed, 08 Mar 2023 06:34:47 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id i24-20020a50d758000000b004ad15d5ef08sm8388372edj.58.2023.03.08.06.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:34:47 -0800 (PST)
Message-ID: <1a837bec-8658-3200-edff-76809de3fae6@linaro.org>
Date:   Wed, 8 Mar 2023 15:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 17/25] arm64: dts: colibri-imx8x: eval: Add spi-to-can
Content-Language: en-US
To:     dev@pschenker.ch, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-18-dev@pschenker.ch>
 <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
 <3730a506119804b5740854c74d1558010ce37b47.camel@pschenker.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3730a506119804b5740854c74d1558010ce37b47.camel@pschenker.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 14:43, Philippe Schenker wrote:
>>> +       mcp2515: can@0 {
>>> +               compatible = "microchip,mcp2515";
>>> +               reg = <0>;
>>> +               interrupt-parent = <&lsio_gpio3>;
>>> +               interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
>>> +               pinctrl-0 = <&pinctrl_can_int>;
>>> +               pinctrl-names = "default";
>>> +               clocks = <&clk16m>;
>>
>> You just sorted all nodes in previous patches and add something
>> unsorted? What is then the style of order? Random name?
> 
> My logic behind this one is
> 
> 1. compatible property
> 2. reg property
> 3. standard properties 
>    - first interrupt
>    - then pinctrl
> 4. specific properties
>    - again alphabetically: clocks, spi-max-frequency

clocks and spi-max-frequency are standard properties.

BTW, what is a specific property?

Best regards,
Krzysztof

