Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86568B743
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBFIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjBFIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:24:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B371C336
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:24:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg26so8070468wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZLQCq+nVanEGUZHEHPFij+4GYTZ/HIIAk0rbLcKruk=;
        b=BgGaXQDEqFjNF7NIqCQRLQ+teOXcRzqfsHkXN+KCr9A4tu2+7Wfs+gX8mO+iTC7bKz
         yFAkbp8rThk+HBnbaaNx0H2kZqXkc2HNELzOCYB80DlrtQjufjN1DYrAFeplje54AMcv
         2lCUCnH/t3x8zF+Yhg6FuuJT0qrw4rhnk80mY/ye9N14l4WFIvuxWBHa/56FV+iZZfhk
         qLGCUp9ftxNTS39BpugnOUII7IJHJMHSvQnWm+dPBAvRjNKrf7Pp2A0WszgPy2eZMpbp
         pikKRw+AP3JUAzIo1eMUlIwCV4qyKBonriIy528artSjuKYj+2/UVtJre2OFxrZ9WkNF
         y7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZLQCq+nVanEGUZHEHPFij+4GYTZ/HIIAk0rbLcKruk=;
        b=ECQiALCAADnTE+1nVQiiX5Hynd06S0Yl9rGYq7NnVOt0GwZoZJ6m8Lps7zXE1h/Jli
         NqJj8sHpOw41Jg0cNz3pz8axF3t3YL/2SRWK8f1XzfmPZAR0AuuxNfCZDOCyrsggzUgW
         fU2dhsbU5XYa+TpK/Fwm/8sUI+o5nzXoJpWzeExqfkEztu+S5rfCrvbTatm5cNGGeiYc
         EBWXvYdcs/LCjevXedCx7PQNH6FGKdcgUdqYzDoY4YKrhTDc37E+u1At756h+Sc1DqBW
         ZBf4slOEGpNRumW58WeKBETqP8n5djQCe233fjXPJFQ3qlhbdtjU5BD8/YbwiP5A7kJs
         B/Sg==
X-Gm-Message-State: AO0yUKXzj6Wd/0+ofKCtwQxup0kOHbMr1PBr9uRB7JMSvMB0P/Ib801l
        0HjoV3SChaHUeBW7/AJIyJ1dBQ==
X-Google-Smtp-Source: AK7set+GccWdUOimHp+4/+II9WaJKS296ZSKX3ASBxQlVMhvtqvXSjR/o3RJyIxbHLmrF4zEEYzAGw==
X-Received: by 2002:a05:600c:3591:b0:3dc:5362:134a with SMTP id p17-20020a05600c359100b003dc5362134amr18197732wmq.9.1675671866653;
        Mon, 06 Feb 2023 00:24:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003daf681d05dsm11071562wmq.26.2023.02.06.00.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 00:24:26 -0800 (PST)
Message-ID: <4ca2d7b5-0041-ba01-0e25-27051233362a@linaro.org>
Date:   Mon, 6 Feb 2023 09:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next v3 2/2] dt-bindings: net: micrel-ksz90x1.txt:
 Update for lan8841
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michael@walle.cc
References: <20230206082302.958826-1-horatiu.vultur@microchip.com>
 <20230206082302.958826-3-horatiu.vultur@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206082302.958826-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 09:23, Horatiu Vultur wrote:
> The lan8841 has the same bindings as ksz9131, so just reuse the entire
> section of ksz9131.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/micrel-ksz90x1.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> index df9e844dd6bc6..2681168777a1e 100644
> --- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> +++ b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> @@ -158,6 +158,7 @@ KSZ9031:
>          no link will be established.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

