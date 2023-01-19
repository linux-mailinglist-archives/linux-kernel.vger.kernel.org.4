Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4C3673FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjASR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:27:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797649002;
        Thu, 19 Jan 2023 09:27:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q8so2097345wmo.5;
        Thu, 19 Jan 2023 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5y/E0y/zCyC6ZcSFXDPmaGDVbN4bDkeMBtZup2uQow=;
        b=Q+/HYM8e41V4GuvCTiY3gvtW+mNK48qnHVtjyPOCSrW1VRNpm1nkmi3Z8HEiZKKs8p
         FBYjy8y0ctk2n+NViAtJXKaW5wuJIw0tAYg6E98HwJs2JQWp0t8MJjFSckeG7opqdAn/
         RyGYr8GY/8tNtzpJNOsn1U1RfSd58FgCYVZVvxb7MwQ9YcTEI+WvirSjOyONQOfM6x73
         TVpHhhymWpoSjYXXhSq32Qq07iQ2OQJUKv/8SB2mqS7Y24OdlAqFirr1KjYs5uLAqYKy
         lVmZdLHhm9YaFMpofVONGlzUDIrBL8iSW8gGdcagx5JZGt//yC0wdVvY5n+l+3OrDwrI
         Gj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5y/E0y/zCyC6ZcSFXDPmaGDVbN4bDkeMBtZup2uQow=;
        b=IxX+UCzyP1pRf4S+7xmeP8eika4zWYyXYF3fXTmSMmzHZ/C1gjZyShovI77l6wx6LV
         EVm3AE3akspQhF1NQ0lSk4moifWVPuP0fX29eFJ+34BlUk70hJecI5ZoibZU3U+2z4mm
         WzUH0wnxwKAq6hUk9fsTS/mTYof1q+NBJtUFqEbXjNbF54rU1Ncm2GJ9s0dvKIXwJCkn
         8anuEIVtSGfPeYQ8TVf2DNnxKtAAKaEtoBcCP0ZAxOZMy1mRdxZ0XXrq1efREQt0UI+f
         q2NMN+9aD2AxetwPEeOfBXVr/e+vEr8RIcy94OQcqMzv49oeJJwbFk0nZBDzcEt4V2kF
         NASg==
X-Gm-Message-State: AFqh2kpJb5e2f6dPsqDZto9ruRSaaFMnjVHauNWML5FPrQggxL6iIBWJ
        hxXMPTSMXYvdaVw0Gl5GtjU=
X-Google-Smtp-Source: AMrXdXswYjyd5jQSxUgYzCkHUVW7m22GFDjuiW/FJIbMs0QSTwSVWbfqCuMsYVX1xk4H7r6DwDcRhw==
X-Received: by 2002:a05:600c:3d8d:b0:3d2:bca5:10a2 with SMTP id bi13-20020a05600c3d8d00b003d2bca510a2mr10965006wmb.22.1674149227654;
        Thu, 19 Jan 2023 09:27:07 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5784755wmq.19.2023.01.19.09.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:27:07 -0800 (PST)
Message-ID: <fe4eddeb-2aea-64e3-ddbd-50e4f0661476@gmail.com>
Date:   Thu, 19 Jan 2023 18:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 0/6] Add MediaTek MT6357 PMIC support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
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

Given the ACK in the series I took the bindings and driver through v6.2-next/soc 
and the DTS changes through v6.2-next/dts64

Thanks!

On 02/01/2023 17:06, Alexandre Mergnat wrote:
> Hi,
> This patch series adds MFD, PMIC keys, and regulator support for MT6357.
> MT6357 is a MediaTek PMIC very similar to MT6358.
> 
> Currently, MTK bindings related to the PMICs are not converted yet (still .txt):
> 
> soc/mediatek/pwrap.txt (all PMIC parent)
>        |
>        V
> mfd/mt6397.txt (support lot of mt63XX PMIC)
>        +---------------+----------------+---...
>        V               V                V
> regulator/...      rtc/...          codec/...
> 
> 1) Convert pwrap to yaml is ok.
> 
> 2) For the PMIC bindings, there are two option:
> - Convert mt6397.txt to mediatek,mt6397.yaml and continue to support multiple
>    PMIC with only one file. IMO, the file will be hard to read because
>    the supported features aren't the same for each PMIC.
> 
> - Make a binding file for each PMIC ref:
>      - mfd/mediatek,mt6357.yaml
>      - mfd/mediatek,mt6358.yaml
>      - ...
> 
> 3) All PMIC daughter bindings (regulator, rtc, codec, led, ...) aren't fully
> converted yet. Refering to the two PMIC convertion options above:
> - To be clean, all daughter bindings should be converted. This is hard because
>    a good understanding of each device is requiered to write efficient bindings.
> - Only daughter bindings supported by the added PMIC should be converted, that
>    allows to do the task conversion step by step.
> 
> In the V4 of this serie, I chose the second option.
> 
> Regards,
> Alex
> 
> Changes in v8:
> - Remove the 2 applied patches (v6.2-rc1) from the serie.
>      - regulator: dt-bindings: Add binding schema for mt6357 regulators
>      - regulator: add mt6357 regulator
> - Rebase from v6.2-tmp/soc branch, got from kernel/git/matthias.bgg/linux.git
> - Link to v7: https://lore.kernel.org/r/20221005-mt6357-support-v7-0-477e60126749@baylibre.com
> 
> Changes in v7:
> - Drop mt6397 RTC schema conversion.
> - Integrate mt6357 RTC schema directly in mediatek,mt6357.yaml.
> - Fix unit address in mediatek,pwrap.yaml.
> - Link to v6: https://lore.kernel.org/r/20221005-mt6357-support-v6-0-4f589756befa@baylibre.com
> 
> Changes in v6:
> - Fix typo in documentations.
> - Remove mediatek,mt6397-rtc.yaml example.
> - Align pwrap convertion with the original .txt file.
> - Remove unecessary include in the mt6357-regulator driver.
> - Link to v5: https://lore.kernel.org/r/20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com
> 
> Changes in v5:
> - Add missing maintainers
> - Improve RTC binding by adding rtc.yaml ref and start-year property
> - Split the txt->yaml conversion in one commit and the addition of the
>    new mt6357-rtc compatible in another commit.
> - Improve PWRAP binding:
>    - clocks and clock-name have been refactored.
>    - reset-names is now properly dependent to resets.
>    - additionalProperties change from true to false.
>    - change example for a most recent and popular SoC.
>    - "allOf" part has been simplified.
> - Pass binding tests with the updated tools. Here the command:
>    "make DT_CHECKER_FLAGS=-m dt_binding_check"
> - Link to v4: https://lore.kernel.org/r/20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com
> 
> Changes in v4:
> - "dt-bindings: mfd: mt6397: add binding for MT6357" has been applied
>    by Lee Jones
> - All fixed regulator are now refering to fixed-regulator.yaml
> - vfe28 and vcamio18 regulators have been added
> - pwrap binding has been converted and mt8365 support has been added
> - mt6357 PMIC binding has been created
> - mt6397 RTC binding has been converted and mt6357 support has been added
> - Link to v3: https://lore.kernel.org/r/20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com
> 
> Changes in v3:
> - To be consistent with regulator/driver.h and helper.c, shift
>    variables have been removed and the mask values have been directly shifted.
> - Remove index tables and rework volt tables to use set/get helper functions.
> - Add comment to structure and function.
> - Fix Fabien Parent mail address.
> - Link to v2: https://lore.kernel.org/r/20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com
> 
> Changes in v2:
> - Rebase
> - Fix typo
> - Remove dependencies with https://lore.kernel.org/all/20220415153629.1817202-1-fparent@baylibre.com/
>    which is no longer relevant.
> 
> Previous versions:
> v1 - https://lore.kernel.org/all/20220531124959.202787-1-fparent@baylibre.com/
> 
> To: Lee Jones <lee@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> To: Chen Zhong <chen.zhong@mediatek.com>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Fabien Parent <fabien.parent@linaro.org>
> To: Alessandro Zummo <a.zummo@towertech.it>
> To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> To: Sean Wang <sean.wang@mediatek.com>
> To: Pavel Machek <pavel@ucw.cz>
> To: Tianping Fang <tianping.fang@mediatek.com>
> To: Flora Fu <flora.fu@mediatek.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: Fabien Parent <fparent@baylibre.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> ---
> Alexandre Mergnat (4):
>        dt-bindings: soc: mediatek: convert pwrap documentation
>        dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
>        arm64: dts: mt6358: change node names
>        arm64: dts: mt8173: change node name
> 
> Fabien Parent (2):
>        dt-bindings: input: mtk-pmic-keys: add binding for MT6357 PMIC
>        Input: mtk-pmic-keys: add MT6357 support
> 
>   .../bindings/input/mediatek,pmic-keys.yaml         |   1 +
>   .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
>   .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 111 ++++++++++++++++
>   Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
>   .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 147 +++++++++++++++++++++
>   .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
>   arch/arm64/boot/dts/mediatek/mt6358.dtsi           |   6 +-
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi       |   2 +-
>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   2 +-
>   drivers/input/keyboard/mtk-pmic-keys.c             |  17 +++
>   10 files changed, 283 insertions(+), 82 deletions(-)
> ---
> base-commit: e32caddfc737a96f6593754c2a08be6b8c1e0cec
> change-id: 20221005-mt6357-support-55308b82e33f
> 
> Best regards,
