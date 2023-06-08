Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D503F728108
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjFHNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjFHNSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:18:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EED210C;
        Thu,  8 Jun 2023 06:18:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b2439e9004so2693645ad.3;
        Thu, 08 Jun 2023 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686230294; x=1688822294;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D7t/IcsLb1sT149B6ebMikIHDMKdt1t6KHWtlJh10/o=;
        b=K4GWIYXT3UU+cMQQ9MmBi0hMM0SFVFnM2dt0AhYzqQABRQdYWtL79TlQGkIPQz1jS4
         j55JKWZeEMYrCfaH0CB8RQ4z0/XvIjIbQw9FiHIi7qRO7VgKAU8XSSVRO50Le2wUROBy
         hYx/mbWxDd4z4XSFH1+weJ6o3Bf3DpMs3zuPZdEXLf0ugnP4e2nFAFemUqcGc1CfBZ9H
         POQRpHfPq75yAiPFGsOCS/CN+kzmaTuAXs/BqMdfn6LCKHXq5GeH09gv4X8E8/kRDclF
         yOoVOoMoM0da32wBUR44aUNaE2gGyfmbgDJwWHq9632pppxAtP2vwHnkJ5zZhcqrC/ng
         nZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230294; x=1688822294;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7t/IcsLb1sT149B6ebMikIHDMKdt1t6KHWtlJh10/o=;
        b=Y4RXF2/rhEMuJm2PFmAjFQuvL7KIhYNy0M92nIrHyJhRbbGmhv5fKatXnBVI3BXhcD
         MZWjUwt1xnNo1XNfZ1b0uCkZOanDH+B3vij6Tqt8WAsf7BBaCpg1Uj0adl3hVanqRCUw
         MxWHK6afDKdNTcU9hv66VSimGyWsVXhqEsBVmZbM0eQBRlOHU4x+KK6NX6Hcpq2OoPHr
         pkgXyxu2ZxELPJX1LtTkPjh7H+0Vi8Ns6shvbjeUdfslxhY8QmzfXrRzH/Y+Kg2+uihz
         +Q+J7dRRswvLOVTa/Hrw5PUFCfDR1ZVPZ1nVd50FiSOjyjLe/EvJsP0ow0Sspd3zSwhq
         HIMQ==
X-Gm-Message-State: AC+VfDxjjvMTLfqpc3s1eiTd8Gtrsq35aI8J9R96TgZ3Rna5gopFHln9
        89uTySC9cHOFmQsL8e0MRck=
X-Google-Smtp-Source: ACHHUZ5M/cI7gc7yzFDF3kqFxm4rWeaJQMCH5IYlgrLd2Urk2wIeKfwBQ3qpgm5c0VI/CYCFNUAMfg==
X-Received: by 2002:a17:903:1207:b0:1b0:ec0:7d01 with SMTP id l7-20020a170903120700b001b00ec07d01mr4863322plh.35.1686230294140;
        Thu, 08 Jun 2023 06:18:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b001ac741dfd29sm1387520plr.295.2023.06.08.06.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:18:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f76f89a0-7773-6f64-c890-293093d4aba3@roeck-us.net>
Date:   Thu, 8 Jun 2023 06:18:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-3-billy_tsai@aspeedtech.com>
 <c1c485b0-b68b-4db7-4b67-5d59f1ecb84e@roeck-us.net>
 <SG2PR06MB3365E360F3FCDE639F3D2D1E8B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <SG2PR06MB3365E360F3FCDE639F3D2D1E8B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 23:21, Billy Tsai wrote:
>          > The code says:
> 
>          > In Aspeed AST2600 SoC features 16 TACH controllers, with each
> 
>          > controller capable of supporting up to 1 input.
> 
>          > which is a bit different. I guess there are no examples anymore,
> 
>          > but I'd really like to see how this looks like in the devicetree file,
> 
>          > and how the driver is supposed to distinguish/select the 16 inputs.
> 
> Hi Roeck,
> 
> The node in the devicetree file will looks like following:
> 
> tach0: tach0@1e610008 {
> 
>          compatible = "aspeed,ast2600-tach";
> 
>          reg = <0x1e610008 0x8>;
> 
>          #address-cells = <1>;
> 
>          #size-cells = <0>;
> 
>          pinctrl-names = "default";
> 
>          pinctrl-0 = <&pinctrl_tach0_default>;
> 
>          clocks = <&syscon ASPEED_CLK_AHB>;
> 
>          resets = <&syscon ASPEED_RESET_PWM>;
> 
>          status = "disabled";
> 
> };
> 

Neither reg nor pinctrl is mentioned in the bindings. Maybe that is not needed nowadays,
but I find it confusing.

Either case, it is highly unusual that there would be 16 instances of this device
instead of one. Why is this done ? It doesn't really make sense to me.

Guenter

