Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19386A7DC9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCBJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCBJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:36:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594A15C96;
        Thu,  2 Mar 2023 01:36:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j2so15834854wrh.9;
        Thu, 02 Mar 2023 01:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677749779;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwotgqIloMzONTq30JRRScBiGhbpTJ7y9dF3roP3jSw=;
        b=W2kO4E6+jzJftiTzk82HJ8DCHC5py2yVoF/dmuN2riWSN4fvxpCVBTFWewt7+Kfcv8
         xDn3O2zLDmvIjpoHzyvvHcw04cV04rqy7UXiWDk/nCBrYslKd6MqjLHiHlDNx2SkAmys
         FBBss1RsF8AzaxOTpequgnWUv1GDJl/K6h0EcjrL9MrR8d8TJnFvxgawKUX/4ZkAgqIu
         AdYcpSMmpr8CJDXUdBwyzi/NYIbxLiDdCxI5RPb64YNmNRrYaHCMv7RhjoC6BcT7pYIC
         kZ5vQlBkXY6Nrh1SZp9kPk1PNZ9WAkyo7lSZ6VhdinOP3+6cwYoVbovZPFmK3P/m4yhZ
         e2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677749779;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwotgqIloMzONTq30JRRScBiGhbpTJ7y9dF3roP3jSw=;
        b=0lF3mCySWqWdjzsEKUnEOIv1sF80E5mBaUmpPNfrIalVKYMasbpjAUrBLD0MP2A8SN
         ci7OohSYk2j5pt92nMT6XvZmmytXjoF4df9aBvCsfr2Tui894KBRD+kn9iCqKLnwrTPO
         IGq/T9x3TjDFNivtuzEa52q3gcIQLLCjLz+z04hCWRq/F3VSEYCN64+dJEDeqjeCp5fP
         fBQo+jGQvyqzGn30Uy1yA3nnGGDbchzKlz/V5FEVm3gFfm2naGIn94n5tMuqgKwxwKIr
         VXd3BPC6IeN91le+cHGKjHK6CY1jrBPgZdnKKEUPxZFQeZ1Ca55bDSlS/a1CjkEW5Imo
         0ncQ==
X-Gm-Message-State: AO0yUKXHKjWZxCkJFyrlRpd1ViCzeH/m2DHZSAgRrde7fnK6q/TaZncs
        v3ryNVEdfsnWiXvvD9uLYZ2cIlZ3mlXxgA==
X-Google-Smtp-Source: AK7set+UFPK2DJPNQSgoPOs8icPPSpDHiZkmVqQ3dyDTUnQHUukDDBzTOjU6nyCbDZtW5WADxWPpkQ==
X-Received: by 2002:adf:f4cb:0:b0:2bf:d940:29b6 with SMTP id h11-20020adff4cb000000b002bfd94029b6mr7770316wrp.54.1677749778575;
        Thu, 02 Mar 2023 01:36:18 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b002c53cc7504csm15177622wru.78.2023.03.02.01.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:36:18 -0800 (PST)
Message-ID: <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com>
Date:   Thu, 2 Mar 2023 10:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series looks good but from my understanding has a dependency on:
[PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support 
(https://lore.kernel.org/linux-mediatek/20230228102610.707605-1-angelogioacchino.delregno@collabora.com/)

Did I get that right?

Regards,
Matthias

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
