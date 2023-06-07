Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756377267B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjFGRqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjFGRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:46:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658D1FF5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:46:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e7d6945aso589042066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686159997; x=1688751997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IS4yO5/WmR+TVZNJffAGCPAsefusOsebYnq87EbR9d8=;
        b=PzyTuOtkeykTZ0E9oHoGoDsQ/p2Qa0UFZSSLm8W8vbcUh8U9lSgtO8y+UiTDleWhVd
         IC4emAy2C+or6ZDf5bIl5qXYFSSDMX9ag9oEClJbOap2JZLS3NHFtSjkYm6/zkBQc+uG
         pZJTUpiaMI7amxHQftTnaXbyaBCM4S1hIukTXP7XbEzajd6DNlcfQDVgRnP3P38tkKGg
         gzkbrDweJUUFvbTvnJvqlUfafu1M/feCxMzQLnLgbVf1s6jg8WgSo6ZRpmvYg+OByjt8
         7HekrhEqYX35nwdDI1p7WI1qKvWyRKHZ8NKQF3bpxA6SVImIm0MAJ8Ja4jK2YhuMOZ+M
         tsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159997; x=1688751997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IS4yO5/WmR+TVZNJffAGCPAsefusOsebYnq87EbR9d8=;
        b=Mca9L9c871ARNp0zMJGvxRjgCcGFGR4D1nnYB3vyyXC5PyopUCl20O0BjWH8t6360c
         SdLNWx6MARCBXjkuwWXiG4M8Gj2C688Wqe4DD2Z0Fspwrx+sgfIivkTzTVweqKUUvwcC
         t51TXIX3VcjlQJHObtpmfxkWt1W2BXkzCwk1AhMIAkM0uB+KBbRSKpycfWIzA7KhQbET
         4mLwzVChSQipSxCWKemPceKO3e1Tr1bG9BIiqCX94lUU8SE7l/qsFvsUu1Po+eygiSr1
         uRykGfAnWwZuOPfRYR4CsLApkb0QjKa4wYuhq7w1gm1hUutsRd1Z9jKrBnVN4w4p0+m4
         tkhQ==
X-Gm-Message-State: AC+VfDwkIRIeqlB2+oaz5D/UvjNsVehw8SsP0+ratJMcnP75N9mFNpO9
        ktczGNNdFXchPdpc+wFekhqElg==
X-Google-Smtp-Source: ACHHUZ6vACvk/Fp/owXZGI5nFgVQVKJgETLwe7WJ0NqCxrx8BOmb1qgAg2jht151GmXiO55T0EdEeg==
X-Received: by 2002:a17:907:1622:b0:968:2b4a:aba3 with SMTP id hb34-20020a170907162200b009682b4aaba3mr6198186ejc.5.1686159997582;
        Wed, 07 Jun 2023 10:46:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709060b4100b0096f6647b5e8sm7141037ejg.64.2023.06.07.10.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 10:46:37 -0700 (PDT)
Message-ID: <84508d22-2dcd-c49f-2424-37a717a49e1b@linaro.org>
Date:   Wed, 7 Jun 2023 19:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC net 2/2] nfc: nxp-nci: Fix i2c read on ThinkPad
 hardware
Content-Language: en-US
To:     Marco Giorgi <giorgi.marco.96@disroot.org>, netdev@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de, davem@davemloft.net,
        michael@walle.cc, kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20230607170009.9458-1-giorgi.marco.96@disroot.org>
 <20230607170009.9458-3-giorgi.marco.96@disroot.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607170009.9458-3-giorgi.marco.96@disroot.org>
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

On 07/06/2023 19:00, Marco Giorgi wrote:
> Read IRQ GPIO value and exit from IRQ if the device is not ready.

Why? What problem are you solving?

Why IRQ GPIO - whatever it is - means device is not ready for I2C transfer?

> 
> Signed-off-by: Marco Giorgi <giorgi.marco.96@disroot.org>
> ---
>  drivers/nfc/nxp-nci/i2c.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Best regards,
Krzysztof

