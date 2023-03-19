Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF8C6C00B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCSLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:06:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999D1A94E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:06:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b20so3519778edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679223975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBClyZjqzsvX4XcfHoxPbXuLX0hX3wAS1PzOKSKD6qY=;
        b=ceb14UefHIQse6qb+4nApgrCDxC15oK3YeIPm2+MmmsGD8IwI0epyP4s1DrZRVh4+z
         tDMNWO8qp2S/FF3ZEHUiYhrXpnGblatsi3NTCkdn2zlwft/GR2xbZZAmP5MKQilvO+YL
         iYMiFFzQZeMdlJBZEevViB0gbnkaXeorGwfdenxCnmIzAiu263JG/VKI5Ww2jCcSKYHS
         fOkJZBuu8JZE2tKdnGw15pq8s5nNQMcuHm+C6TEi+aJ+j3C0spIAt0wP4OQFrSNV6lV4
         atEKzpj+jSIZ35pcza41zU6NmuZ0H0qp/cakvd5pgYJJQXICgZlF4lekabXndN2ijX2H
         bGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679223975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBClyZjqzsvX4XcfHoxPbXuLX0hX3wAS1PzOKSKD6qY=;
        b=VpZoVL8KEfCNtR9fzfZ4pHGf+kd6woz1068fB6BL+9UFsE+cy/i8wnNGCMjB9bAk+Z
         /2FxM1RXOPbWdzyWNK2GPJYQ4u3nuIXR0nUvepmlwwfHxn5V/dipdD4vdzOi+FLy1L4U
         r8ewXdVm+nREU8ISXStHiai9vqXXewDQlnWg1/hp8oiTEvepEU8sKZMVtFMrsUMR8x6/
         edoe0fCPOciWzM7zTgMVZcJbzbfm7ItC/18VsQsSgOMh8K6+B98Uh9nQ1smJebfT7W1i
         uLliaJuYL6pFGB5HaAxLdQgnafJ65pW5dRZaYcdzpm2VAaZ+4ptZoms2pIaOhSiRaeWg
         i8rw==
X-Gm-Message-State: AO0yUKXneF8CFCuAjE22j9fUmZXW8Jseqvl9RFMSzXQEBLcSJl44ADt0
        TaElCk6nt3mLPUoAJUGalmZzGA==
X-Google-Smtp-Source: AK7set+09rHLmfBFB8O9udJ+850QNdD95CbOHTD0fZ1NophhDuk/Rlf/ZKLukSxggEy5xfDNzUMgfw==
X-Received: by 2002:a50:ff17:0:b0:4fa:b302:84d9 with SMTP id a23-20020a50ff17000000b004fab30284d9mr9364725edu.14.1679223975316;
        Sun, 19 Mar 2023 04:06:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id s29-20020a50d49d000000b004fc2a75c6b3sm3376851edi.23.2023.03.19.04.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:06:14 -0700 (PDT)
Message-ID: <87171ab8-9c6d-3978-6d34-4ae922361307@linaro.org>
Date:   Sun, 19 Mar 2023 12:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <fb4f60a7-011e-3745-cc40-631247735f2b@linaro.org>
 <c902606e-8a1b-6673-02c7-7beea5477795@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c902606e-8a1b-6673-02c7-7beea5477795@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 07:07, Jacky Huang wrote:
> 
>>
>>> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>>> +			      IRQ_TYPE_LEVEL_HIGH)>;
>>> +	};
>>> +
>>> +	uart0:serial@40700000 {
>>> +		compatible = "nuvoton,ma35d1-uart";
>>> +		reg = <0x0 0x40700000 0x0 0x100>;
>>> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>>> +		clocks = <&clk UART0_GATE>;
>>> +		status = "okay";
>> Why? Drop the line... or convert it to disabled. Otherwise, why every
>> SoC has serial0 enabled? Is it used internally?
> 
> 
> uart0 is on all the way since this SoC booting from the MaskROM boot code,
> 
> load arm-trusted-firmware, load bootloader, and finally load linux  kernel.
> 
> uart0 is also the Linux console.

Are you sure? Maybe my board has UART0 disconnected.

Best regards,
Krzysztof

