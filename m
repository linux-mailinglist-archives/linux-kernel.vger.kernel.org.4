Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BB67EAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjA0QSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjA0QSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:18:53 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0547C658
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:18:51 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id w15so4163205qvs.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpbM6dulHZ17ZJk7sIXX1zvUQ+2CFayGo452JEZsUgA=;
        b=sei4Ur3/qhUD7eRtizMwsp9T6XeunKIuHWi7/1xW5YiSHAAZjfGiFrjmNroi5Enj8P
         0NXdDYvUlkxkZFSZ8QC7MWX3UVc/1D/PRzdEIy1zPa+ac+P8OcshmPccSYKmoPj+8upz
         bF1cYyx+wYqWTI3M2ZRA5rjQB3IvJhBtMjBcFST1UKVHNS5ge2jDw381/jn/TPNUG8Ig
         Utt08poel4blMMcW/0fHg3xTtshN+h7KVP6YlUQEUfgC7IHcdXOtmL/qzdXFI1Oxa/+4
         qPu9X7fftgdEcwoRI/zPhtWiwy4+hJQS7bTws88fySVHeWezQCCBy0QU30+wduA64yFS
         uaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpbM6dulHZ17ZJk7sIXX1zvUQ+2CFayGo452JEZsUgA=;
        b=BMyiIdDvfIU9FIdOwjKvOQ0A1hXZCNBtkfevLNgAMksrtGATTreuJBUOYVCi8dRXB7
         IOnVGs01N7zvBLRz7crSCa3w6hWTmg2CRc6kAkf8qaSXtbZIAvdEYFe1+eTJHBOhxid0
         urkcKZCECRtnUJwguViTKGr8C6qSoSpWwpDebcZIKvHJPev77oghhdKENJm0dog2gfIg
         o4yAng9S2YGcpx2Mi7jMLz4eJ11N5m3LlUJtUE97r8ICkfLn5CNCiPTXLePc6cjRf/81
         RA3/M1RQikYlpK4r6/ZyRPQxri1pODPKE6C3uf8GObche58eBOMAxJsqx0blQWaNTf7E
         vTxw==
X-Gm-Message-State: AFqh2kod0y9Fl8QR/bzajAVIF4fIRqs+6zmo/mRPi43eiOTZGKVB3nKD
        lYHVu43g3C2HcFxHx4vb03T5TcSqHvhGTYl0k3wNDQ==
X-Google-Smtp-Source: AMrXdXvLZ3tb9o4k4+Rdt+X24aNNL4DoFTd5UeyiqztwmluRV4eW2iDC4NLWecpVdMZnnv+GzK2PKeAqcPJnnUgMp0M=
X-Received: by 2002:a05:6214:5c42:b0:534:1fd4:72ec with SMTP id
 lz2-20020a0562145c4200b005341fd472ecmr2080182qvb.65.1674836331103; Fri, 27
 Jan 2023 08:18:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Jan 2023 11:18:50 -0500
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v5-0-cfb0e5ad29b2@baylibre.com>
In-Reply-To: <20220919-v5-0-cfb0e5ad29b2@baylibre.com>
MIME-Version: 1.0
Date:   Fri, 27 Jan 2023 11:18:50 -0500
Message-ID: <CABnWg9u02duwaM3zWAdM9ZLw03Z53j0aCSWYXWpz=WM8zm-Ynw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add MT8195 HDMI phy support
To:     CK Hu <ck.hu@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mac.shen@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, stuart.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 16:55, Guillaume Ranquet <granquet@baylibre.com> wrote:
>Add support for HDMI phy on MT8195.
>

Please disregard this, as I meant to send v6 and not a new v5...
link to the actual v6 is here:
https://lore.kernel.org/linux-mediatek/20220919-v6-0-2f641c422cb6@baylibre.com/

Sorry for spamming your inboxes,
Guillaume.

>This is split from the previous v3 to contain only the phy related
>changes to the HDMI support for mt8195 as suggested by Vinod.
>
>This is based on top of next-20221121
>
>To: Chunfeng Yun <chunfeng.yun@mediatek.com>
>To: Kishon Vijay Abraham I <kishon@ti.com>
>To: Vinod Koul <vkoul@kernel.org>
>To: Rob Herring <robh+dt@kernel.org>
>To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>To: Matthias Brugger <matthias.bgg@gmail.com>
>To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>To: Philipp Zabel <p.zabel@pengutronix.de>
>To: David Airlie <airlied@gmail.com>
>To: Daniel Vetter <daniel@ffwll.ch>
>To: CK Hu <ck.hu@mediatek.com>
>To: Jitao shi <jitao.shi@mediatek.com>
>Cc: linux-arm-kernel@lists.infradead.org
>Cc: linux-mediatek@lists.infradead.org
>Cc: linux-phy@lists.infradead.org
>Cc: devicetree@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>Cc: mac.shen@mediatek.com
>CC: stuart.lee@mediatek.com
>Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>---
>Changes in v5:
>- Adapt clock bit ratio when TMDS is over 340M
>- Used sized integers for register read/writes
>- Removed useless comments
>- Shortened function names
>- Link to v4: https://lore.kernel.org/r/20220919-v4-0-bdc21e1307e9@baylibre.com
>
>Changes in v4:
>- Dedicated series for HDMI phy support (without the drm/ related
>  changes)
>- Removed useless variable initializations in phy driver
>- Link to v3: https://lore.kernel.org/r/20220919-v3-0-a803f2660127@baylibre.com
>
>Changes in v3:
>- phy: Grouped register and bit definition together to add clarity
>- dt-bindings: Addressed comments
>- Link to v2: https://lore.kernel.org/r/20220919-v2-0-8419dcf4f09d@baylibre.com
>
>Changes in v2:
>- Removed syscon requirement from the hdmi node
>- Use as much as possible bit FIELD_PREP/FIELD_GET macros across all the
>  patches
>- Make cec optional dynamically instead of hardcoded with a flag
>- Renamed hdmi variants to v1 (legacy) and v2 (mt8195) while waiting for
>  a better name
>- Rework hdmi v2 code to use a connector (same as v1)
>- Remove "magic" 0x43 addr special handling in hdmi ddc code
>- Link to v1: https://lore.kernel.org/r/20220919-v1-0-4844816c9808@baylibre.com
>
>---
>Guillaume Ranquet (3):
>      dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
>      phy: phy-mtk-hdmi: Add generic phy configure callback
>      phy: mediatek: add support for phy-mtk-hdmi-mt8195
>
> .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |   1 +
> drivers/phy/mediatek/Makefile                      |   1 +
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         | 523 +++++++++++++++++++++
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h         | 111 +++++
> drivers/phy/mediatek/phy-mtk-hdmi.c                |  15 +
> drivers/phy/mediatek/phy-mtk-hdmi.h                |   3 +
> 6 files changed, 654 insertions(+)
>---
>base-commit: e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49
>change-id: 20220919-hdmi_mtk
>
>Best regards,
>--
>Guillaume Ranquet <granquet@baylibre.com>
