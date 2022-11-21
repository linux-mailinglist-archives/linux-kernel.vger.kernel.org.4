Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70959632187
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKUMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKUMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:03:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE113DF9;
        Mon, 21 Nov 2022 04:03:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d1so7399456wrs.12;
        Mon, 21 Nov 2022 04:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XQKcVJbCKdPNL3r284+FMGZ1NmD17SxEaB1YH/7mOI=;
        b=HS4vlJyCkWEfvsMOQSvAWS+nanJLMMyJYUkeOp9QiSi5pcTW25aPdUB4POvsIUg42S
         U2pw9eI2yOW3OJ0EDFEnKkYe3whh+ZB3hEdVMCoOg7gB+HkjsWWlcaNmC4emBztTdWMH
         Fs6yFRbnD1oeutuPcrsEa0gQeC41VuSb9lMiuBe4qH8iwnCnvVYXik3aOtGdKGEnpqyC
         HIma+9c42zoh9IyN7ATszGdxjlHsMqod7Vw/BIX9D8eKrL+h4xO3ucJqEYSPGaVubbV3
         3EHcHVkaTf57RWC20Zz/AeNtQGoX6LFcmsgVkxHBMIAg8c+oiXqsYk0I3Nvo2c9Z+/H9
         mlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XQKcVJbCKdPNL3r284+FMGZ1NmD17SxEaB1YH/7mOI=;
        b=voeVrHUmMK0HbOtThIwleYod0S+JDW74smH+cDkRkqxzY5AfThF4H8px9tCKMOglHk
         PM1rCY3YNGRAAxzhu2tI7vBPfAFrIRD8f1wt8Y5G0djiV9XO4BMPZuRs68BNnKXAvID3
         qqghvxt+7UpepKzNTDyNtUvAMOYhJFsnemAFoHB+Bfa3Fyvg8zClyqrQJsrRjZYQuoLU
         QvclnWaT0D3j+OBnEiUyUEymu1haWSMveKQCA6jEoap5S1XruSYspvyzqxFi4AyK15M+
         UDBLWdnRySAEHCA/HLob7GBbIbGei4z5+TE6HjKxOEZLwpStaNJWMNa4kA1eh0Hv+IiP
         OM4g==
X-Gm-Message-State: ANoB5pmQEFHdrX7kVy9BHNdrwUQmHqFDHcRPk6YwwRKJY7Vl2pzWI9Sa
        E4OiA88c/OlMOO8PF2jASrg=
X-Google-Smtp-Source: AA0mqf47dsNMrYKK7mFgXn4kWq2UQ8QtuBdL10SrDfVoUPuHM0hhxm2Q3t5E/IRwQgQzWf+z0J0ydQ==
X-Received: by 2002:a05:6000:1181:b0:22e:53c0:ead8 with SMTP id g1-20020a056000118100b0022e53c0ead8mr10898826wrx.210.1669032210282;
        Mon, 21 Nov 2022 04:03:30 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z2-20020a1c4c02000000b003cfe1376f68sm13335036wmf.9.2022.11.21.04.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:03:28 -0800 (PST)
Message-ID: <89ceb49a-edfc-2d55-ebf5-cc5ff6d2d52f@gmail.com>
Date:   Mon, 21 Nov 2022 13:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/8] ARM64 MediaTek devicetree fixes - Part 1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sam.shih@mediatek.com, hanks.chen@mediatek.com,
        weiyi.lu@mediatek.com, zhiyong.tao@mediatek.com,
        andrew-sh.cheng@mediatek.com, viresh.kumar@linaro.org,
        chunfeng.yun@mediatek.com, fparent@baylibre.com,
        mars.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
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



On 13/10/2022 17:22, AngeloGioacchino Del Regno wrote:
> This series fixes devicetree warnings for some MediaTek DTs.
> 
> Since there's a lot to be done and since not all fixes are trivial,
> I decided to do this in more than one step, as to ease work for
> reviewers, maintainers and for .. me.
> This being part 1 means that there's more to come... a bit later :-)
> 
> AngeloGioacchino Del Regno (8):
>    arm64: dts: mt7896a: Fix unit_address_vs_reg warning for oscillator
>    arm64: dts: mt6779: Fix devicetree build warnings
>    arm64: dts: mt2712e: Fix unit_address_vs_reg warning for oscillators
>    arm64: dts: mt2712e: Fix unit address for pinctrl node
>    arm64: dts: mt2712-evb: Fix vproc fixed regulators unit names
>    arm64: dts: mt2712-evb: Fix usb vbus regulators unit names
>    arm64: dts: mediatek: pumpkin-common: Fix devicetree warnings
>    arm64: dts: mediatek: mt6797: Fix 26M oscillator unit name
> 

Whole series applied, thanks!


>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts   | 12 +++++-----
>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi     | 22 +++++++++----------
>   arch/arm64/boot/dts/mediatek/mt6779.dtsi      |  8 +++----
>   arch/arm64/boot/dts/mediatek/mt6797.dtsi      |  2 +-
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  2 +-
>   .../boot/dts/mediatek/pumpkin-common.dtsi     |  6 ++---
>   6 files changed, 26 insertions(+), 26 deletions(-)
> 
