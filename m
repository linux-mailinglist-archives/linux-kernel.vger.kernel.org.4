Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01141714A32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjE2NWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjE2NWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:22:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C090;
        Mon, 29 May 2023 06:22:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30aef0b8837so419500f8f.1;
        Mon, 29 May 2023 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685366526; x=1687958526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZSX2B86+4oQRhjx3g08Gt14tGkbdzK+lGEnVXLTkdc=;
        b=oONmEDR2TU2FLPnSVcEROc8TGbkrHGad5u+kkghRFrT2thM/TKhti4bB/YpJK7okfy
         Wv9eGNDmKQ++SYRdIvtwVWf8soymTBK+ohrS84gyrKz7aGnmuJsWrLG9E+3s9HwmlF5v
         WNVh23hchUVMStnltiEfliqou0pWs/L+Z9UXIqvNDfJ3RD1Kqki9U6mEvPl8C5ttnq+J
         mazKbQfP1VgcvLRX1OGfaUTYbGp3xyQJYlsc6mU+q3l/XOuR200KDk0n/kyl2oc6v//D
         IYCdFrsB93ToVX4vqng74BUV2+OuNkjWw57IEcKGZwllfbfrIGw1dBJiboJRIaLVEVU+
         rpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366526; x=1687958526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZSX2B86+4oQRhjx3g08Gt14tGkbdzK+lGEnVXLTkdc=;
        b=DMdmuql1fjdEaY9Tb8QOd/Go2zYnO7828erpig5eJq/Yjl1E+LL7n9hkxWsc7VAVkQ
         l3Iz+H5xSo8TP71r4aGKFEU+Mic31bc+f0B+XZ9+1TZnlI9sKu9YV5qbsiGc26Dce9j2
         xTa1E2lVPhuRbk/J2YE+NsxrLSQHNVEuK6UpUBLrObMBsDq5no7vuUnpay23NKu2NUbU
         QMevK4mkKGtMgTvpAfeUq1rPWEMvyzTHkXcqKCDQonpIlaE3guNsoggHn7XAaMeJfggP
         oarJ7oiZ5bBh1ymAm3tBTAj3DHm2N4FmZZC+B63H6plDcEX1lJp++gigTKPNSo6px+4g
         MrIw==
X-Gm-Message-State: AC+VfDz6y+39tNeB0+Dg9bx9sM9ylsrovtzgkOmKPGxLK9Q3O6Ze58JG
        Zl/ljNCfV8H6BH1eArSB+O4=
X-Google-Smtp-Source: ACHHUZ6wJFuLqYcgSNLENNMNWpAmZGG8JMk8aK7sAYhNJ9gR3qtQtUJhGCjgB1qP7LdIXFLhVft2BQ==
X-Received: by 2002:a5d:42d0:0:b0:309:4176:702 with SMTP id t16-20020a5d42d0000000b0030941760702mr7825166wrr.37.1685366526272;
        Mon, 29 May 2023 06:22:06 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d46ce000000b0030ae93bd196sm4288530wrs.21.2023.05.29.06.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:22:05 -0700 (PDT)
Message-ID: <81193660-ee37-2fdf-6668-13f1e2649a1e@gmail.com>
Date:   Mon, 29 May 2023 15:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 00/10] Improve the MT8365 SoC and EVK board support
Content-Language: en-US, ca-ES, es-ES
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/2023 10:33, Alexandre Mergnat wrote:
> This commits are based on the Fabien Parent <fparent@baylibre.com> work.
> 
> The purpose of this series is to add the following HWs / IPs support for
> the mt8365-evk board:
> - Watchdog
> - Power Management Integrated Circuit "PMIC" wrapper
> - MT6357 PMIC
> - MultiMediaCard "MMC" & Secure Digital "SD" controller
> - USB controller
> - Ethernet MAC controller
> 
> Add CPU Freq & IDLE support for this board.
> 
> All previous dependancies are merged and released into the v6.4-rc1.
> 
> === Build:
> 
> To test this serie, cherry-pick this serie, and build it using the arm64
> defconfig.
> 
> Regards,
> Alex
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> Changes in v8:
> - Change vqmmc-supply of mmc1 node.
> - Remove all always-on regulators from the board devicetree.
> - Link to v7: https://lore.kernel.org/r/20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com
> 
> Changes in v7:
> - Rebase to the kernel v6.4-rc1.
> - Remove "dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365" because
>    it was applied.
> - Link to v6: https://lore.kernel.org/r/20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com
> 
> Changes in v6:
> - Add commit message for the arm64 defconfig changes
> - Fix the mail list
> - Link to v5: https://lore.kernel.org/r/20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com
> 
> Changes in v5:
> - Add patches to build the MT6357 regulator driver and MTK PMIC keys by default
> - Remove "dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength property"
>    patch from this serie and add it to the pinctrl serie [3]
> - Link to v4: https://lore.kernel.org/r/20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com
> 
> Changes in v4:
> - Remove v3 applied patch from the serie:
>    - arm64: dts: mediatek: add ethernet support for mt8365 SoC
>    - arm64: dts: mediatek: add mmc support for mt8365 SoC
>    - arm64: dts: mediatek: add mt6357 device-tree
>    - arm64: dts: mediatek: add pwrap support to mt8365 SoC
>    - arm64: dts: mediatek: Increase the size BL31 reserved memory
> - Drop "arm64: dts: mediatek: fix systimer properties" which is done [1]
> - Fix style, typo and re-order properties.
> - Use interrupts-extended for the PMIC node.
> - Link to v3: https://lore.kernel.org/r/20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com
> 
> Changes in v3:
> - Remove v2 applied patch from the serie:
>    - dt-bindings: mmc: mediatek,mtk-sd: add mt8365
> - Add trailers and simply resend.
> - Link to v2: https://lore.kernel.org/r/20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com
> 
> ---
> Alexandre Mergnat (9):
>        arm64: defconfig: enable MT6357 regulator
>        arm64: defconfig: enable Mediatek PMIC key
>        arm64: dts: mediatek: add watchdog support for mt8365 SoC
>        arm64: dts: mediatek: add mt6357 PMIC support for mt8365-evk
>        arm64: dts: mediatek: add mmc support for mt8365-evk
>        arm64: dts: mediatek: add usb controller support for mt8365-evk
>        arm64: dts: mediatek: add ethernet support for mt8365-evk
>        arm64: dts: mediatek: add OPP support for mt8365 SoC
>        arm64: dts: mediatek: add cpufreq support for mt8365-evk
> 
> Amjad Ouled-Ameur (1):
>        arm64: dts: mediatek: Add CPU Idle support
> 
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 235 ++++++++++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 142 +++++++++++++++++
>   arch/arm64/configs/defconfig                |   2 +
>   3 files changed, 379 insertions(+)
> ---
> base-commit: d2b7e0f7ff8e0b21e4c8d0ae6dfa38786fe44b35
> change-id: 20230203-evk-board-support-d5b7a839ed7b
> 
> Best regards,

Whole series applied, thanks!
