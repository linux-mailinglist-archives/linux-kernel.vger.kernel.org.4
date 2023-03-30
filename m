Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C926CFD56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjC3Hub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjC3HuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:50:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15714EC9;
        Thu, 30 Mar 2023 00:49:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso2854071wmo.1;
        Thu, 30 Mar 2023 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680162596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2Yj8+6rac+oWtMSroVgtG8FgK+CLOna3xmgumj6lLs=;
        b=f2aLCGR7bb9A9uz3r7WTbcr3IrYLXykt4K5wi/HIYtzguQUGHO7BXbCkFYITS+R6No
         5kykc3yYu8om7nagnDucLMGmIZsLjFb3BM2lzYwcJYO3x++ACHXqwb82MyGFVMd0MTBl
         ToHAVkw2M8cu1s1ikQtSX/QeG1gVHGAJ7V6rTNXM5YbnaYmQktumpf4RsrN/XvF8iaYw
         OZtVH0eosvc+UxUYKhwqI9tZjXiPHmfxien//MijaIVACdd3xri+BYrdWSaq1d8BaHCt
         9sIHRLEMTjcmCt00GmbEoTIDmDtpr3hzkQeBdq9cW8ufwu+TMKseXUtxWYYKiLBTB3UY
         8Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Yj8+6rac+oWtMSroVgtG8FgK+CLOna3xmgumj6lLs=;
        b=7AKPBkx6SVmr1DXsqP6I7CIiFrh7kOeY2ggS1lEg43aS0doKsyGAgoN1BooKeFeB4O
         4nr7quNN8bSxtgV8NZArrA95Z6gI9ZALnYqzMtnQlbnnBH8c9/bv93jm8C+ORr5NjiR7
         wgBPhHrSyywU/n4f9+BfIFyOyX3EyB2mnSojT+EU0pjUZAEGci4hP3NjP4hcxQmw5nAr
         xtRqCM1DB31ztyGCryEO2+PvWMKMulDNAFSvg1rrrjIVBC3ibZ39xkPYJFeqSJpsrEXA
         2GyNzaQzoZly5i6VL9AJufRbRfeS/xPwwJ1teBmIob37XYB4pPGxlcB5ELBw0Q5zvmYP
         zoVg==
X-Gm-Message-State: AO0yUKV3jbbehJpZNbx8kwPedCf6oD5hi+v3+yoXeyp1AUnf2JanuAgu
        XMFPOkozXneoCBj4ci3tEN0=
X-Google-Smtp-Source: AK7set9m9jZdEwstgP9yAGFN+jesF4c75G/nHeFfXao4ibkEeJTHOxAAVg569Wtjq47hrkctGNg0Iw==
X-Received: by 2002:a05:600c:282:b0:3ed:b094:3c93 with SMTP id 2-20020a05600c028200b003edb0943c93mr16795513wmk.23.1680162595935;
        Thu, 30 Mar 2023 00:49:55 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bcbd3000000b003ef684c5e32sm4759483wmi.48.2023.03.30.00.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:49:54 -0700 (PDT)
Message-ID: <c0aecb1a-eb84-bc59-4ba1-1af9cf88e72e@gmail.com>
Date:   Thu, 30 Mar 2023 09:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2023 10:55, AngeloGioacchino Del Regno wrote:
> Changes in v4:
>   - Added a fix for MT8192 Vgpu voltage constraints
>   - Changed constraints for MT8192 VSRAM-GPU to reflect the maximum
>     achievable voltage as per the actual vsram-vgpu relation constraint
> 
> Changes in v3:
>   - Changed MT8186 compatibles for new bindings
>   - Added min/max voltage overrides for vgpu/vsram_gpu on
>     mt8183-pumpkin and evb as suggested by Chen-Yu
>   - Cosmetic fixes for "arm64: dts: mediatek: mt8192: Add GPU nodes"
> 
> Changes in v2:
>   - Changed MT8186 to use only two power domains for the GPU.
> 
> We finally have working GPU DVFS on MediaTek SoCs.
> On Panfrost.
> For real.
> ...and the best part is that it's going upstream.
> 
> In order to get GPU DVFS working, it was necessary to satisfy a
> specific constraint (which is different, depending on the SoC)
> between two regulators: GPU VCORE and GPU SRAM.
> This was done through adding the mtk-regulator-coupler driver,
> which transparently manages the voltage relation between these
> two vregs, hence completely eliminating the need to manage these
> regulators in the Panfrost driver; this solves the long standing
> issue with devfreq+opp tables not supporting managing voltages
> for two regulators per opp entry out of the box, due to which
> we never got GPU DVFS on those SoCs, often locking them out to
> a low GPU frequency.
> 
> This changes. Right now!
> 
> Tested on MT8192, MT8195 Chromebooks.
> 

Applied, thanks!

> This series depends on [1].
> 
> [1]: https://lore.kernel.org/lkml/20230228102704.708150-1-angelogioacchino.delregno@collabora.com/
> 
> Alyssa Rosenzweig (2):
>    arm64: dts: mediatek: mt8192: Add GPU nodes
>    arm64: dts: mediatek: mt8192-asurada: Enable GPU
> 
> AngeloGioacchino Del Regno (16):
>    arm64: dts: mediatek: mt8183-kukui: Couple VGPU and VSRAM_GPU
>      regulators
>    arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu
>      constraints
>    arm64: dts: mediatek: mt8183: Remove second opp-microvolt entries from
>      gpu table
>    arm64: dts: mt8183-pumpkin: Couple VGPU and VSRAM_GPU regulators
>    arm64: dts: mediatek: mt8183-evb: Couple VGPU and VSRAM_GPU regulators
>    arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU
>      compatible
>    arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
>    arm64: dts: mediatek: mt8192-asurada: Assign sram supply to MFG1 pd
>    arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for Vgpu
>    arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER
>      regulators
>    arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
>    arm64: dts: mt8195: Add panfrost node for Mali-G57 Valhall Natt GPU
>    arm64: dts: mediatek: mt8195-cherry: Enable Mali-G57 GPU
>    arm64: dts: mediatek: mt8186: Add GPU node
>    arm64: dts: mediatek: mt8183-pumpkin: Override vgpu/vsram_gpu
>      constraints
>    arm64: dts: mediatek: mt8183-evb: Override vgpu/vsram_gpu constraints
> 
> Nícolas F. R. A. Prado (1):
>    arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply
> 
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  17 ++-
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  17 ++-
>   .../boot/dts/mediatek/mt8183-pumpkin.dts      |  17 ++-
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  34 ++---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  17 +++
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     |  24 +++-
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 116 +++++++++++++++++-
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  95 +++++++++++++-
>   9 files changed, 315 insertions(+), 27 deletions(-)
> 
