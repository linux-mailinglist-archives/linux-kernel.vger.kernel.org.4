Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21760C095
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiJYBK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiJYBIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:08:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD863378
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:18:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t25so7154247qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9iGP14d6f9I4D+kuqf6O3+s5e5qEr4YR9xj0lL2tQg=;
        b=OtcjS3mzg7rlOcJHjSoD4JAWkUpNIVr3uTqc4Vek0xgQC60nPy8J5iQ9eBp+2ScjNh
         mKkfAe/bj/e1y5HJwuzOnTHJhj6CICRZOx7YVwDPcDkw+hQJzDCNoZ7v7bB+4dsHoXbu
         WJRZjmeJumf1MwvDTeByrDcFZXKEqCU7GhdJTcAa6iNvoUAh1PILnE1ZlxLQS1Axvvm7
         bzqO6u8S2fc68LqbJ/TIQD/3OsnKbL4HEoosLrMqxLzAqFmmfxs42GcXhUM6mKpOEekx
         CkXUkK7+8ECU0HaUf0NJTQhbZ0OKcJcCRSvtBR3I1ALQLtAFluNsshqcPCT5vuDBzpGg
         jedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9iGP14d6f9I4D+kuqf6O3+s5e5qEr4YR9xj0lL2tQg=;
        b=0oi1DdbMKAUuavTqS+7SBklRI1w3xeq18qz3oHqKrOJWY4rDCpnQAKStvzbXkH3wDE
         98KXzc8hxJQKNwHzrYm+KTVX3rZULyUHiPdy2dmnNqTelueManThQYQtZ/wbXlyeFvji
         8Tfr5rzwlT6MQgQYgHg4wPlTCi9WDDiZ7oMGD4N4d04YvbZ8lQIgwsFNje4hcVRJMPgK
         tDrhmkjTZIffb2Eu0/+kTLxN4Roapz0YZEuY3Sbgbd/zvNr1AvwpF0w4uTZ/GcQ48mE1
         6B8Ap2w8mLb4XTynvSHl8sCMp8O9fjPhZ8ulKaEl/FusfX81ZxwZZs1IdY2pHIxR9XAV
         VBYA==
X-Gm-Message-State: ACrzQf14Hl5wOEbgwQTErVG5viEDmzC+xeAHqTMURdzRT0e+C0z+l/Kd
        r2ztp7O30XSzyITl5w1Qr12BZQ==
X-Google-Smtp-Source: AMsMyM78J92TaYTk4yJazk6RCGkFm9WubGdfdV2HbUM+i9DvZ7hX6waN9UYo9qf6oaenDl6vIy97bg==
X-Received: by 2002:ae9:e115:0:b0:6ee:bcbb:396 with SMTP id g21-20020ae9e115000000b006eebcbb0396mr25000114qkm.668.1666657099961;
        Mon, 24 Oct 2022 17:18:19 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a290800b006ce40fbb8f6sm1040395qkp.21.2022.10.24.17.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:18:19 -0700 (PDT)
Message-ID: <22a8f70d-a5ce-1f54-03d1-50874b7c99fa@linaro.org>
Date:   Mon, 24 Oct 2022 20:18:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dt-bindings: pinctrl: update uart/mmc bindings for MT7986
 SoC
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221024073634.6834-1-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024073634.6834-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 03:36, Frank Wunderlich wrote:
>            - if:
>                properties:
>                  function:
> @@ -221,8 +225,9 @@ patternProperties:
>              then:
>                properties:
>                  groups:
> -                  enum: [uart1_0, uart1_1, uart1_2, uart1_3_rx_tx,
> -                         uart1_3_cts_rts, uart2_0, uart2_1, uart0, uart1, uart2]
> +                  enum: [uart1_0, uart1_rx_tx, uart1_cts_rts, uart1_1, uart1_2_rx_tx, uart1_2_cts_rts,
> +                         uart1_3_rx_tx, uart1_3_cts_rts, uart2_0_rx_tx, uart2_0_cts_rts, uart2_1, uart0,
> +                         uart1, uart2]

Wrap it according to Linux coding style, so 80.

Best regards,
Krzysztof

