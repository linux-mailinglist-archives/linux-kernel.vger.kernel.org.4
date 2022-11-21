Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC326321D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKUMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:23:34 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F120742EC;
        Mon, 21 Nov 2022 04:23:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g12so19563075wrs.10;
        Mon, 21 Nov 2022 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBKSjgXVgAfyfSqv9ig9DK6qGbLQNmXs5urv4GT2+6g=;
        b=J/Sca2kE3k5m8yIPrthxBcgITbLLG/8fmqa+LA7QMXbI3xbGYNuiQ8wezyHS8SRJ7y
         m0FJWSaizHVPINK67Iqnp9USQHwkmnTErBmMh/dtMJ2Zm8xVgGsrgVqj9AzdcZk2rPRQ
         57SA2APFmDLlPnG85/TuAQgD7w9f6Oy2A/ZyVy7NM0z81I6vfnzD8P4DoO1LrAflXOV5
         zjYF3StwNPKyVeZpOKjqVUsrciTuhbZ/R9X/Bw0AsnukZk5N63hQkJGDxbICD6zxCE+S
         i10kr389LXJmLOVdSzaxs6avmgo3P4ubLhf+pzVJdVu5crjI9pfrK+Icy1wNf01iVX1L
         5Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBKSjgXVgAfyfSqv9ig9DK6qGbLQNmXs5urv4GT2+6g=;
        b=gyUhD89nZUXGE5z6tzeC87039ypfeZi8OTA4A30nNjyc6jA+AbjH8D4irJQUnegcgL
         ciB4tLRXye8gLX66F/+YGjKWEq7KMhpIv4Ux6z/kqN9nl1/uazt6Oyu1bjSlHbHqouN7
         nGtP20txh3PKNqRP9gETwcoOZBk6+S+HINdXhp+GvZzOYEzdwinqgn9hD9/wyQxfvTFP
         pc+6xBzkMXbCK2b7h3NLIJJkgT6bWAPUmSkvkCOu+Q2V030acvBuUGxqgpdZH/IFDORz
         PlHVVr9hgQdeKLE8qd9HFHy/VBVORFNUvUzUTydaUPS8uuB87OoaRE7Y4PKVqmZNEROe
         f+rw==
X-Gm-Message-State: ANoB5pkdujs0fIU4nrmWYNwiNQP2ewZpuMFSSXKADkE1Cp33gNIsEasz
        iMbd7oy7lCwv9sY8yZgc4n5umwIEY1o=
X-Google-Smtp-Source: AA0mqf72QBRoDc3I5EhLZJT0doyO5vmLUZc7y7AAQ15N7BcLk2YreywlR/36zKH4kUDk33W90Z9CDg==
X-Received: by 2002:adf:cd91:0:b0:230:1a1:ac8 with SMTP id q17-20020adfcd91000000b0023001a10ac8mr11180849wrj.530.1669033412004;
        Mon, 21 Nov 2022 04:23:32 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cf75f56105sm17076739wmq.41.2022.11.21.04.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:23:30 -0800 (PST)
Message-ID: <9aebaf57-e461-b71f-a707-8edbfe8f97be@gmail.com>
Date:   Mon, 21 Nov 2022 13:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/6] MT6795 Devicetrees and Sony Xperia M5
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hsinyi@chromium.org, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, sam.shih@mediatek.com, andrew@lunn.ch,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2022 11:54, AngeloGioacchino Del Regno wrote:
> This series brings some more support for the MT6795 SoC, as it
> adds support for basic clock controllers (and resets) and all
> of the mtk-sd mmc controllers.
> 
> While at it, since now it's possible to get the "first signs of
> life" out of a MT6795 smartphone platform, add a basic devicetree
> for the Sony Xperia M5 (codename "Holly") device as to start
> preparing the ground for a gradual bringup.
> 
> This series depends on [1] my mt6795 clocks series.
> 
> P.S.: Thumbs up for the first MediaTek-powered ARM64 smartphone
>        going upstream! :-) :-) :-)
> 
> Changes in v2:
>   - Rebased over next-20221026
>   - Removed "mediatek,mt8173-mmc" from mmc compatible strings
>   - Added clock and reset dt-bindings headers inclusions
> 
> AngeloGioacchino Del Regno (6):
>    arm64: dts: mediatek: mt6795: Add topckgen, infra, peri clocks/resets
>    arm64: dts: mediatek: mt6795: Replace UART dummy clocks with pericfg
>    arm64: dts: mediatek: mt6795: Add support for APDMA and wire up UART
>      DMAs
>    arm64: dts: mediatek: mt6795: Add support for eMMC/SD/SDIO controllers
>    dt-bindings: arm: mediatek: Add compatible for MT6795 Sony Xperia M5
>    arm64: dts: mediatek: Add support for MT6795 Sony Xperia M5 smartphone
> 

Whole series applied, thanks!

>   .../devicetree/bindings/arm/mediatek.yaml     |   1 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>   .../dts/mediatek/mt6795-sony-xperia-m5.dts    |  88 ++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi      | 109 +++++++++++++++++-
>   4 files changed, 195 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> 
