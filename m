Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59F6A18F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBXJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBXJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:42:06 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FD54A34
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:42:04 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id x14so20628149vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hup0iftcL4w1rRk5wtFimO6PxuW6uWdJ0jF6+XpUdR4=;
        b=ILlbVCTYVbpnbi+jGGAGx3PaoBWbhKoVb6P+oj/K1qHYViVWJaIetHfDytZ27sv5ta
         vbT1LgpOKrk1fogvyMOL2rd/aQi/sc4z2bOcGAXaAbNnwvVddJ97/I3KDSt8O0VZJeyV
         AWxdSUQjjBnxOZ60ohawiP8oRX2MBClGagJiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hup0iftcL4w1rRk5wtFimO6PxuW6uWdJ0jF6+XpUdR4=;
        b=flF4c4wjZFXwhgU4wl1OGkhTt5y7t/VdL5rhjcqiNSZd8m176qW3xHnfkr+MqOIN0/
         Rlaeogw5idaUv8TKtITxzcFba3fstHr3zkYUZvpxhJYTwpUUNkQK84m5reCJRmZs7vq6
         zpp6L0ifJOmsfHoUfbsFau/bhK44jY7HB7SV0pCn10NXhPDtLRadNzaEIZWVoDjFH5ha
         le5EEwXLfg/qHiV6r+AfhqN72hnD96f25V7f0x8erIO0AQ6z3I8jRgFlfVv8Ytcme1J+
         F45KWXSPnJlxFwxK0MBuxnhxliPm5K6ngYQpKqkveiVACXJVIehx4I76A9ElZrCDP1m2
         IFRQ==
X-Gm-Message-State: AO0yUKVqJ70AILjCzpdNgOETYZCn2CK/mEnWtTYrI8aPSoc+6JT9+Dsr
        AEMOcGzmvy1LhRNC964OsOXwhScf6TsmpM9cP6Qwiw==
X-Google-Smtp-Source: AK7set9DUpz0pEONX2reqzfDYEcSwsr+i/Um3XAlW3+tABX0lBa5XkMywVbJR0HhqBPXZ89dHJNKXj2sT8/vLVhiVck=
X-Received: by 2002:a67:d21c:0:b0:402:999f:51dd with SMTP id
 y28-20020a67d21c000000b00402999f51ddmr2176299vsi.3.1677231723939; Fri, 24 Feb
 2023 01:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:41:52 +0800
Message-ID: <CAGXv+5HvQugnQjJbdqOuQKeqpFgJOvtzzwhVD9FL2CKgxxJYQQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Enable GPU with DVFS support on MediaTek SoCs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v2:
>  - Changed MT8186 to use only two power domains for the GPU.
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
> [1]: https://lore.kernel.org/lkml/20230223133440.80941-1-angelogioacchino=
.delregno@collabora.com/
>
> Alyssa Rosenzweig (2):
>   arm64: dts: mediatek: mt8192: Add GPU nodes
>   arm64: dts: mediatek: mt8192-asurada: Enable GPU
>
> AngeloGioacchino Del Regno (13):
>   arm64: dts: mediatek: mt8183-kukui: Couple VGPU and VSRAM_GPU
>     regulators
>   arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu
>     constraints
>   arm64: dts: mediatek: mt8183: Remove second opp-microvolt entries from
>     gpu table
>   arm64: dts: mt8183-pumpkin: Couple VGPU and VSRAM_GPU regulators
>   arm64: dts: mediatek: mt8183-evb: Couple VGPU and VSRAM_GPU regulators
>   arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU
>     compatible
>   arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
>   arm64: dts: mediatek: mt8192-asurada: Assign sram supply to MFG1 pd
>   arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER
>     regulators
>   arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
>   arm64: dts: mt8195: Add panfrost node for Mali-G57 Valhall Natt GPU
>   arm64: dts: mediatek: mt8195-cherry: Enable Mali-G57 GPU
>   arm64: dts: mediatek: mt8186: Add GPU node
>
> N=C3=ADcolas F. R. A. Prado (1):
>   arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183 Juniper, MT8192 Hayato, MT8195 Tomato, MT8186 not-yet-upstreamed
device.
