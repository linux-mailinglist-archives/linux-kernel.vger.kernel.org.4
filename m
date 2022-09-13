Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8385B7821
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiIMRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiIMRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:37:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656FB7B7B4;
        Tue, 13 Sep 2022 09:28:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b5so21638606wrr.5;
        Tue, 13 Sep 2022 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=feABSJN9jpizOdnxJqE+tP/2w15qPXg0lbOz999CO18=;
        b=XGKT34MSDxeBpVcSFtMIZtXOTkr3LqymTjtxWqRpgA1FnKflx9nfgU24xXIxJbPTan
         KTDSeo0I+gKbLPN/iPMwbWBWVk2SDsRXvzFRXePtDNmixbNf8Yt30dvvIKpgoA0aBvxq
         UNT4uQer7wSvzhu/WQoLab3MtzMaJ1wDvQf1HVX9xoS+C62K+xbZALou004TJTbh1my/
         uUhcDwm7DJUhqcWdPJpee8miIyQiawJdSUSEf/hAHbcBAjAR+JGb/2sagjislWbyuiW4
         /ikSpmAldYljm6CohArw06FXMDdMWGgD1cjGbU8oLSOOX78Zaqe5nSc/FcZUBKZUZRDS
         UGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=feABSJN9jpizOdnxJqE+tP/2w15qPXg0lbOz999CO18=;
        b=TXidOLmDWY2NI3nKv/WALOTrqgmQxyEuNmwmSNqaekjLUliGxgktCLBSrTaGvAh7KI
         mDC6JGHH1crn2u1DqXtOPU6fvNuk0QWgxl6q3jWlfSxI5gd7xxsA093UhJwqR9RhrdMc
         FP14NJ8+9YcrNk7n5HPSRV+RAnv7xW/wqeX13DBPQtl5cZpjBN+nUuiU2CMFY86AoLwq
         dJaa6nnYCNJRXotKQkjrbwQneuARkVO5tVF7vdwZrqmU3I8oa+3b8Oxa2GP8OfJc5mHZ
         kNdYAy8cMMDJDuTn2A5+/wkr0uisgh6gVf5Y9Lo97/Qmfv7B0iuDO7WOKkbn1K/9Y9Gk
         aTgg==
X-Gm-Message-State: ACgBeo3bN3lCTHNhvwmB6PDPQztjsiacG9wp1mJ2SkS30TuApOle7CJx
        Eu1x94NfvM+kLQIqCiy1UMjx9Ubv6Ro=
X-Google-Smtp-Source: AA6agR6l4NvWXOFt/iyhGaqbS5S4G5XjDHsBhqS+mN041t/T9rGzhMiNbnnD9Lmg/uKdn4P+PReJMg==
X-Received: by 2002:a5d:6dac:0:b0:227:41e9:e00d with SMTP id u12-20020a5d6dac000000b0022741e9e00dmr18356009wrs.643.1663086534923;
        Tue, 13 Sep 2022 09:28:54 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d60ce000000b0022862fd933asm10853505wrt.96.2022.09.13.09.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 09:28:53 -0700 (PDT)
Message-ID: <d9f08c83-6742-ed89-3963-f518f33e4df7@gmail.com>
Date:   Tue, 13 Sep 2022 18:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/7] MT8195 Acer Tomato - devicetrees Part 2
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org
References: <20220902081156.38526-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220902081156.38526-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2022 10:11, AngeloGioacchino Del Regno wrote:
> This series enables more functionality on the MT8195 Tomato Chromebooks,
> bringing it to an almost usable state.
> 
> With this series, the device is able to boot from the MicroSD card
> and is able to communicate with the EC for various functions,
> including the enablement of the Chromebook's keyboard, battery
> charging, fuel gauge and other standard ChromeOS EC functionality.
> 
> This also enables the Audio DSP, codec and sound card and adds support
> for the regulators found on the SPMI bus.
> 

Whole series applied.

Thanks!

> What's missing (coming in the next part)?
> 
> * Format:    feature  (location)
> *
> * MediaTek vcodec enc/dec (mt8195.dtsi only)
> * PCI-Express WiFi card (mt8195 and mt8195-cherry)
> * VDOSYS1 (mt8195.dtsi and mediatek-drm/mmsys drivers)
> * DP/eDP outputs for external/internal display (mt8195 and mt8195-cherry)
> * LVTS Thermal Sensors (mt8195.dtsi, driver is missing)
> * GPU support (comes later, clocks implementation is in the works)
> * Audio/ADSP support (waiting on SOF OF commits)
> 
> Changes in v3:
>   - Commonized pin definitions for secondary SD/MMC controller
>   - Added firmware-name for SCP
>   - Changed keyboard backlight to google,cros-kbd-led-backlight
> 
> AngeloGioacchino Del Regno (7):
>    arm64: dts: mediatek: cherry: Enable the System Companion Processor
>    arm64: dts: mediatek: cherry: Wire up the ChromeOS Embedded Controller
>    arm64: dts: mediatek: cherry: Add Google Security Chip (GSC) TPM
>    arm64: dts: mediatek: cherry: Add keyboard mapping for the top row
>    arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
>    arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
>    arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus
> 
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 256 ++++++++++++++++++
>   1 file changed, 256 insertions(+)
> 
