Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA334677807
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAWJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAWJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:59:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41323306
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:59:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso8100320wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtTLJQUHERlGTA1ecjP4ZAB6KPAk/7NPYqYgWuT3Suw=;
        b=qxRb667FT8O0NQhgeJ5a4fDl242loKNLzX78YKu7cjtJIjcjYHMUzIz584ad53Q5hI
         bOsyDw8+lkqNVQrw/O0oEVLcIz9OtXayoL6/6l695GMdLIOhXAKDg9iEH8BlQLN83I99
         miTOO3xCyNBTjscQ3cktsmky2lyQ44RzX1XxlZRXIB3r+ZTcdmRFmBdujfwsjVU9smFp
         IxGkQqQF1c7RqbEGtA6R75ZTzInores6UmsJtH7UwrLCZpa5TRJ3lOWrLhmfnU/sv0M7
         fGqg7JG/0oAghdTBOIuPdBg1XaSdVE93v0tQD7nrPvN/vNZvdzudY/qus+UJDjAcoCg/
         LM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtTLJQUHERlGTA1ecjP4ZAB6KPAk/7NPYqYgWuT3Suw=;
        b=dd4NbzypNVU9hI44SuxXNoMakgt+TBLW7fAVTtNaeWveKOTWdjv0aD6p/WXES0uYTb
         EqGGg0V3L4FeyseggWoGjhPGGItROJaWem87oBlSIUi4vH6JpmOIF/wvHIKGIrg1M3R7
         7fEpgQiOYgKZxYb7eXD+C9ZAVUYC5TCADi0z8V1eCgeJBaWAWyIYXYAeGlyTqZHYVVlx
         YE1CW1uHfyT1FpV7F99tArFB3H1A/1/jkOyyjnE0uwoJcHWhmzzqr3B2WDKY2QkSzwzs
         2AoIgNsSLsUdoeolb/Hr0wNfi1DodbEt8Tx15SsVJLXoDMiGKFmzlKdJ4JYDjpWtjoKT
         8Mqg==
X-Gm-Message-State: AFqh2koHbvWNB+lm45b8sA0xk0+GpPeravAmsvEx/SrwRoifOmxGfekL
        tdexZzmqISlEHGix7OTEhbPu2g==
X-Google-Smtp-Source: AMrXdXsGbgUE3umL1U3RniV7/odixrkxY9sW262BHvRmFLtF52S8OAEs3s/oFW819rxhIhuG1QTQ5g==
X-Received: by 2002:a05:600c:a15:b0:3db:18a0:310f with SMTP id z21-20020a05600c0a1500b003db18a0310fmr17735845wmp.33.1674467945322;
        Mon, 23 Jan 2023 01:59:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm11183305wms.35.2023.01.23.01.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:59:04 -0800 (PST)
Message-ID: <703ad169-fb10-651c-96fe-22d2eae959b6@linaro.org>
Date:   Mon, 23 Jan 2023 10:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 0/2] Add support for Samsung Galaxy S5 (Exynos)
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
References: <20230121201926.46990-1-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121201926.46990-1-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 21:19, Markuss Broks wrote:
> Samsung Galaxy S5 (Exynos) is a mobile phone released in 2014.
> It has an Exynos5422 platform. This version of Galaxy S5 is only
> capable of 3G communication using the Intel modem, while the
> LTE version of the device (klte) has a Qualcomm Snapdragon SoC.
> 
> Currently, internal eMMC, USB, regulators on a PMIC, and touchscreen
> are enabled in the device-tree.
> 
> It also has the following peripherals:
> 
> - 5" 1080p S6E3FA2 DSI display,
> - Cypress StreetFighter touch buttons,
> - Broadcom BCM4354 wireless connectivity module,
> - Intel XMM6360 3G modem,
> - STM32F401 serving as a sensor hub,
> - Validify Solutions VFS61 series fingerprint sensor,
> - Lattice ICE401M FPGA as an IRDA controller,
> - Maxim MAX86900 heart rate sensor,
> - NXP PN547 NFC controller,
> - Wolfson WM5110 Audio DSP,
> - Broadcom BCM4753 GPS radio,
> - Maxim MAX77804 PMIC,
> - Silicon Image SII8240 MHL controller,
> - TI LP5562 LED driver
> 
> Cc: Mark Brown <broonie@kernel.org>
> 
> v1 -> v2:
> - use better subject prefixes
> - rename Galaxy S5 (Exynos) to Galaxy S5 (SM-G900H)
> - align the compatibles and clock output names
> - reorder the includes
> - generic node name for regulator-tsp-vdd-en
> - GPIO flag for regulator
> - rename all the regulators, leaving the voltage values only where
>   it makes sense (e.g. on 3V3 and 1V8 supplies for the HRM)

I got two v2 patchsets from you. No clue which one is correct. Please
send v3 if there were differences. Otherwise please annotate somehow...

Best regards,
Krzysztof

