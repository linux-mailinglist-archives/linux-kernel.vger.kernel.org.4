Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460D60D4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJYTds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJYTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:33:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16EADED35
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:33:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f8so8903142qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlQ1cRCD9fKmzJ3+TI4hUp5O0g7efZTefHgpU8Oatwc=;
        b=e2iE+ZZIuDxbexuvQ3MNI0S0a57hqso6u8T4ICq4sHJumjN2p01uWKF7HEq3yHwJfW
         /a48UX69qaN8StNxOyG9OAbj+/A/ypTwuzhJ17Zl89heJqDYLq+81a/1u698AKlpfimV
         MdEEbpauwKZQtc6hc4OC4eyZCFcNOLNj8IoHdSFwHeFNzw3X/wAH4JKTek3/snbr1gt0
         YmTcc9H3Z+i091+UL9YFv8DXrFra4EdDY0x9ygksuOfoCsxSBvqTmSRfAv61cEdzJFqN
         D/BcxkxmY64NJsE796MlftoLI8krdo/p/kZ1emheOrt6K8PD5vfpnckHWChm3CiNqXOJ
         a80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlQ1cRCD9fKmzJ3+TI4hUp5O0g7efZTefHgpU8Oatwc=;
        b=rORMTchEd+glatp/GU7Tr9OODzBQvK/kdP4EkmO42O6JW7A8XA5qM8sojLFSxuxOKt
         LeCT66QSsJ55pnj+8UO0thzw9i55a+p3585tU1utQ48QmBFTBUrpARKq53rFU9qkK8eY
         BxXMNcSrZM2VkjcF2fqCOiihg3YUg8AeNbwjqHwCFqXTKQG4Tkq4NwLhs8h8RD3G8B+N
         n4EgcIDsRzuYcQCUKmSSd+t/J6SDQGNNk05u/+2MLTuo/pzxZbuC/KrYkFgPwR1wT+Bh
         90+bbPOs/UZhaSAMFxcUnkfjSukpztbfHCwxGwOssuR5zSczrYUNTXU4p3CsSK00Icrg
         hB5A==
X-Gm-Message-State: ACrzQf2nF2hXIIqVI303QAxF3EMqb+7AmP4gp+zWmxJeqeC7ONICOTs3
        +FlIPWIrMzg0CW2g+lc58FuT0g==
X-Google-Smtp-Source: AMsMyM73hVc1EX6lix0TOkq2k3vnCuy+Cme12+Qh5B9TkdSfJAb3HbTfFdnbboOdn1GwfPCMbotNJA==
X-Received: by 2002:a05:620a:2057:b0:6e6:f4d:980b with SMTP id d23-20020a05620a205700b006e60f4d980bmr27862052qka.544.1666726420885;
        Tue, 25 Oct 2022 12:33:40 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006cdd0939ffbsm2556783qkb.86.2022.10.25.12.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:33:39 -0700 (PDT)
Message-ID: <0b6dd763-365d-6f35-59cb-18c599b73d3a@linaro.org>
Date:   Tue, 25 Oct 2022 15:33:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
 <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
 <DM4PR84MB19275D8DB8B27CE0D1A05AA588319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <7c9e943a-4806-6339-cee1-9156e7792111@linaro.org>
 <DM4PR84MB192759035B110DE54EA9B63688319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR84MB192759035B110DE54EA9B63688319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 15:26, Hawkins, Nick wrote:
> 
>> I don't know exactly what type of devices you represent in that plreg, but in general the fan device would be the respective plreg. The same with other pieces like hwmon, power supply.
> We were primarily representing the registers that translate to the CPLD input/outputs from our platforms as well as handling the interrupts associated with those inputs/outputs.

So basically each register (or set of registers) is a device? How is it
different than any other multi-functional device? Why do you want to
model it differently?

> When you say "would be the respective plreg" do you mean that each device/controller would need to perform the actions plreg does individually? In that case how should we get information for that register/memory region and interrupts from the dts? Could it be something like this:
> 
> plreg: plreg@d1000000 {
>       compatible = "hpe,gxp-plreg";
>       reg = <0xd1000000 0xFF>;
>       interrupts = <26>;
>       interrupt-parent = <&vic0>;
> };
> 
> fanctrl: fanctrl@c1000c00 {
>       compatible = "hpe,gxp-fan-ctrl";
>       reg = <0xc1000c00 0x200>;
>       plreg_handle = <&plreg>;
> };
> 

No, rather these are one node.

You insist to represent this all as programmable logic, but why? CPLD,
FPGA, ASIC, dedicated IC - all are just implementations and for us
what's matter are the interfaces, inputs and outputs.

Best regards,
Krzysztof

