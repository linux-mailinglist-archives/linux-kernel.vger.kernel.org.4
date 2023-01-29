Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86668004A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjA2Qqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjA2Qqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:46:32 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F331F4B1;
        Sun, 29 Jan 2023 08:46:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bk15so25729125ejb.9;
        Sun, 29 Jan 2023 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipNjMFDOfKGLfHyf1k1golbZwgkTbBlkE21IcQ2tRhA=;
        b=VcHpTdvwYeHSTBsKcMyw2IEfeHunmpFTD2YNYqRYPLipJVOB7zx3eTgVIhUksxZRMo
         2FRszn+Y5hqHpyu8wseSQwwoAjiAvNoVAOMl/kYhtes3kukIb4wuYziLLj/xyzPOqodr
         2i+ERpDojAzPmsLUqLtkDnE8WbMcNKT4mHkntLmGn24SdksMbWyjykLYx9x/k9VI3F0P
         ZWd1QSkP51uARWtsU/QzuaC+EdGFihX/EKbJLC9lj6lhdM67BcxGyjVd43qzFuGvzVv/
         0wADUw516+XebBZ0PalVS/kSG49S0fLEYV2JRs8e4DT1354pZTxxSJmlajCM5taVc3/g
         uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipNjMFDOfKGLfHyf1k1golbZwgkTbBlkE21IcQ2tRhA=;
        b=IRHwsHxSpazUOsB1JaZjXSHoJ23McOTXUwBXCPu6JnGsl8uP7eBG6KGcget1oAakkm
         RQdv/TgIoKEnmZzLpr3y8fjh+GXtu6eB5SncUNhCivCQcKLBHfgDuzAb8lBxBq0cSVTG
         mLY3FqxCnwsvGCpvoZyHmms/u6ClJgiSNClID7q9XZ8SqeWSSsVsXsu0csSSpJX7xkRH
         yI+gm2dO/bvnpXaonnRGxu7vC3Et54vh+O0nSLReSlXvOAJkaCsoEQMy6zDEYpR92hWK
         LBCfSOrL4Ucw2n/NXjVnXzN74Ow4cJMNXJ7S+sfAyPcW9mA49kODmgfi63xlZr3S9WDH
         wiFw==
X-Gm-Message-State: AO0yUKUhY1WPbAyU0H2gxREiAA3LmZlTC/lqeg/RPVMYqbXVXmkuWqU2
        /9TO+i2pTS1uJvKJlt7pvAw=
X-Google-Smtp-Source: AK7set+cwaONDsO3l+ywOz/puIRUQg/y26+a+XYSIK4D93xEzD6pcdqrQ/2iZVHU282pyKUw53oiGg==
X-Received: by 2002:a17:907:2a94:b0:882:123d:eed with SMTP id fl20-20020a1709072a9400b00882123d0eedmr4605902ejc.51.1675010790032;
        Sun, 29 Jan 2023 08:46:30 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id kk4-20020a170907766400b0087943d525e1sm4695080ejc.215.2023.01.29.08.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 08:46:29 -0800 (PST)
Message-ID: <0a3ed159-1714-8982-6ca6-5e70bf1b7418@gmail.com>
Date:   Sun, 29 Jan 2023 17:46:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v16 2/2] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Content-Language: en-US
To:     ChiaEn Wu <chiaen@richtek.com>, pavel@ucw.cz, lee@kernel.org,
        matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com
Cc:     peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>
References: <cover.1673886245.git.chiaen_wu@richtek.com>
 <7a6ac0051789831a7a53c2f3b66010fc0f1e5395.1673886245.git.chiaen_wu@richtek.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <7a6ac0051789831a7a53c2f3b66010fc0f1e5395.1673886245.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiaEn,

On 1/17/23 09:53, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
> 
> Add support for the MT6370 Flash LED driver. Flash LED in MT6370
> has 2 channels and support torch/strobe mode.
> 
> Co-developed-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
