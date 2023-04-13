Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF76E1304
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDMRB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDMRBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:01:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B95AF2E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:01:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id xi5so39075951ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681405264; x=1683997264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2I7f6+b1d7q1PIy6xXtPKz6lCWDPvlktKccZ+S4StVg=;
        b=IKmO4rWu5HqsVVgMPwPpgbjSsGBF/9UpUrwWMs9v0EPCmCYXNojh6fT8xp/mZpjADC
         EqqB8kQF49skZBxirGhsWEBsuP4xRxZ5OFi48eaOdTwQcImypsL29/OAfOAuBi//5w8o
         hASp5weEhDikUOYevrzgbBaFc2Kx9e4sL7BEwrxbxn2/bSweX7CNhA3HwLT6CL2RYuIo
         3py+I0IR5fjCkTt9AL6oHFKHFPzhmaloK8LMmPC8Z3g/sOvdlZzefYeiV7XLMXLrJOWM
         3Xzm0OzRUnQfR9PvLM5ekEsfpWc6lr5QoOSPzkt7pth2JdUOKN2jSO+NT6vWqs26Q6UY
         +Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405264; x=1683997264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I7f6+b1d7q1PIy6xXtPKz6lCWDPvlktKccZ+S4StVg=;
        b=TVYrqXLrRXsdal+B0Q6nD0af8RU7N3ORdEgtWzw9UcCPoCCG3C1jG6xoYMPX2FcfWL
         kcyvsxWMX0D+KIbii9hnQJomwDNZJEnhphN8N7xaOTSn2SVMXYmwTetWq4gx/4ad+h0C
         c0n/4W37VPeZGFHPPvQ5Lk08HpDpF+hfG62hPvXYZq3OelqzjIAP0SUpjYEBVGuDu60P
         URTz8tcq/SXBF8jQ30qTWBEq+E3D6CoTDU9NEL5Punq8syj4fCWwNbipI3oyXbpnGuaq
         jiANNcLySYGAK21fnzBz4hJvDjWwfkhml/UD3lNKuc9k/l1yQxVPIftQTdpEwGp25Gsi
         Ouxg==
X-Gm-Message-State: AAQBX9fSl5D8R7vS96Wh1iD5FvhT1Ukc4F/XeDyK133WmWWs+gxjiH73
        HCxB1VdY7vE+/9Eyra9/u8cF2A==
X-Google-Smtp-Source: AKy350brnjZyrb2x0XPKOK+sVpzQRZjovcvXctZNLeXLCoFmecoYfyMQEzE1G3jyGfJsCQ8HJBUw/Q==
X-Received: by 2002:a17:906:3495:b0:94a:7696:4188 with SMTP id g21-20020a170906349500b0094a76964188mr2874679ejb.74.1681405264354;
        Thu, 13 Apr 2023 10:01:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id qx16-20020a170906fcd000b0094cafa4fb8bsm1216143ejb.124.2023.04.13.10.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 10:01:03 -0700 (PDT)
Message-ID: <e759426e-6c2c-91fa-99d7-712339624adb@linaro.org>
Date:   Thu, 13 Apr 2023 19:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 06/12] dt-bindings: arm: Add initial bindings for
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
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-7-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412053824.106-7-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 07:38, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
> the initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>  .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>  .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>  rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
>  rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)

I don't think you fixed the failure it was reported. Your changelog also
does not mention it.

Fix all comments and reports given. Path(s) in maintainers is/are broken.



Best regards,
Krzysztof

