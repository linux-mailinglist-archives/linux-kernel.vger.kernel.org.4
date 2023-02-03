Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE26891C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBCINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBCINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:13:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26685953E1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:12:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so5441187wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC0G1L6NjMoqGQD1cOuly4Kpy7+rsQRjwMtomVmlm3o=;
        b=xD72h3qJGE8pRy1Boa9QLWM3iuOgPxAFkfdvyEux2CoizMWlA590ACWFNz/K80PAZZ
         Sw9YIc8ZAA1bUthZam/m+Eeba5+E4myAXIVrE36mqP39bF1Jtw29mQ66qEQcqv2bp4p1
         6cKoRzu44Alj6AZi966ZhxHIRuzmQr6hAewC1bIN7jeDZt8wONW5oMbHQOv7kLq7Wu3C
         vKcF47She/EjkhgaNzgvU1femR9xaJmeLCSiYnyS9GUb1AJZeNYGNwbtReeChHHP+li1
         MoZjkm10tpOCl2Ou35pP15Vg/cufTOjE9R35Zt9fxU2S0cN4KfeNZivCAHPUfpfCZNOh
         uN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC0G1L6NjMoqGQD1cOuly4Kpy7+rsQRjwMtomVmlm3o=;
        b=eWEsmcM9kL2ny79pW55vwFbJGiNHWwySsE3XXHfel2EO7whaxsum1OKfFwp4Ah+j3Y
         BGLbWe8QC3zzpxOMxw0LwNK43XRFiWeLF2kvBg1d9ejd8s1smd1IQEJi0JMVvswNlK7q
         WmYKZBLmTJyoVYLk6pPxj+zLepQXcvU1xu2zop9r8jedAgmKEPUNxXBKo/CebIV5E5MR
         9KbS+mH+OW5oee1tINONTw9rOMMS0H99HYBpwTNDI8ZeFIV7+Ydpq2s/6NAjpqLQ9uDy
         lCL5FMi/ij77DlNRIVbl3pXlH5wtRLu0uJdZPfXsmYV7qVnW9U1BACaAVZ2YoG2xxkU0
         gLzg==
X-Gm-Message-State: AO0yUKXzACuESHSN8KAPxyabUPvOYGkH+rHU0sB0wyXDxh/s0fH20PHz
        I5bFetMP3kTf54Dt9n/h3Fm8GQ==
X-Google-Smtp-Source: AK7set+phGji+2ms+lZQhTPHJqeuo6ybtY3qprxpSEW2BSt4H6ct/ep5PFnZxnSNGDJ5ocOKtPFVtA==
X-Received: by 2002:a05:600c:1e13:b0:3d9:f836:3728 with SMTP id ay19-20020a05600c1e1300b003d9f8363728mr9020715wmb.11.1675411940532;
        Fri, 03 Feb 2023 00:12:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003daffc2ecdesm6983987wmc.13.2023.02.03.00.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 00:12:19 -0800 (PST)
Message-ID: <70f6e477-86e2-5d71-49be-3c96265c82be@linaro.org>
Date:   Fri, 3 Feb 2023 09:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 7/8] dt-bindings: arm: at91: Add info on sam9x60
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
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-8-durai.manickamkr@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203034833.451461-8-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 04:48, Durai Manickam KR wrote:
> Adding the sam9x60 curiosity board from Microchip into the atmel AT91 board
> description yaml file.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

