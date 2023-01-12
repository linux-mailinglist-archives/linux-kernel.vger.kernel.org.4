Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD2667137
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjALLtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjALLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:48:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A75D884
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:37:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v6so26384195edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Xqk0NOcl6A/RFI3G2LXyDXcDGXrHqiE2kwfvu0U/9o=;
        b=L9vRIjxKsMIL8c5d5j7/HZQ5mLZTx5Sv/m3XuLHluS6N+cxAtYM3RlNkxj7F0wBQBQ
         BRReM0R8f8NHB1oWZT7FK96Yybp9nNjsAAHOkLm+avzAK5bosTh6/yZ1qE2+Xt3aiK1T
         gsk3oCrBuOBNECOAYoE778prd4qN3xnnoknxAdO0pUG5mhZuN9OsMlQ2QBO1dzjzv8+c
         rro3VK2Iq3LuBjmM6wUP0Gsft6lRWTGUG2NukuIzQCB1iyI4knDgy+ydYMYbRwdiJIdD
         jIwZfhnO8t2laeQrVT/qsXuG6UenU0LIQ29T64FrXClJQ0InoZxAxX3GeTsJw8qMq5he
         +GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xqk0NOcl6A/RFI3G2LXyDXcDGXrHqiE2kwfvu0U/9o=;
        b=ghQsZgbn+8BVcoVimyS5wt3Cd++OJdBTX2M01p13WXsWqdlDkzrj1CmetvwXxADgUf
         s+bRAqV+G4FDrUjYH7d2x+shCAQgIIeMMriylIEbvcN0BSg/qfLscIzFfjgcUCwDTkyM
         B82Gb30B35qOcXQgrXoQ+7qVyhdm+fhaTxZY5A7FSRqdUcuz9rK8HejKHmrMUW+I3oeF
         +Lk4DjNife2EMrBQL/v+tbDz0MJWq8VQ9LMyXpmCZxyzTS5oLaiK09D+1TxT0YYV1BQw
         GhO3mCzPDqOqKQLMeVyAcj1HX9ofQyMnl8NDMyNJwkxi3MhE2Dp+FlUQVMS2InEPOw+g
         99og==
X-Gm-Message-State: AFqh2kpbZbsc9TnqBSJy4lIw0+RrUjlxMosHRVPeJd3CIjSeuZer7iZ1
        69XZq6QTXNLdV4t0bZS2al6WiA==
X-Google-Smtp-Source: AMrXdXtpjxltPF3O6b7QAIWvQ/ZxXjJG1nEsdgMLikuJQbu2xmqFxn6kt2Mpl/nH48pSzy8mU3k02w==
X-Received: by 2002:aa7:c046:0:b0:499:c343:30e5 with SMTP id k6-20020aa7c046000000b00499c34330e5mr8731515edo.3.1673523477033;
        Thu, 12 Jan 2023 03:37:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g19-20020a50ee13000000b0049b4711f4bdsm1146518eds.41.2023.01.12.03.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:37:56 -0800 (PST)
Message-ID: <870d5fc7-0533-7da2-ac31-4db02ffcc0ae@linaro.org>
Date:   Thu, 12 Jan 2023 12:37:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 7/8] dt-bindings: arm: at91: Add info on sam9x60
 curiosity
Content-Language: en-US
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, claudiu.beznea@microchip.com,
        cristian.birsan@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, davem@davemloft.net, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, Horatiu.Vultur@microchip.com,
        robh+dt@kernel.org, andrew@lunn.ch, michael@walle.cc,
        jerry.ray@microchip.com
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
 <20230112110208.97946-8-durai.manickamkr@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112110208.97946-8-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 12:02, Durai Manickam KR wrote:
> Adding the sam9x60 curiosity board from Microchip into the atmel AT91 board
> description yaml file.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

