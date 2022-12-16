Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D564EB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiLPMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiLPMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:39:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFF4B982;
        Fri, 16 Dec 2022 04:39:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w15so2339834wrl.9;
        Fri, 16 Dec 2022 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C1t7Qhw/4Y/cukYlXL7QXYS7VSdfs0nLzx2PMLsJKc=;
        b=FWlOPhXmYQIcPI01pZmsrS90gM78wa1c7zAhnU7K4ckWoyxWCz/PG2DUXkon6ww3Dk
         Njwe/v/XAIX18vJuwZxeJT0OOXe4gVS5e8ZcL1HHSBktsBO+AloCjabNe1RE3liQnx9S
         FTOmIGO5MV8tlwtU9ZnP/u5teQbNvAs9Jk0Q7wvworT+0vLCs6NeG93Uj8UBuZGO+Vg4
         F6NawSUF2FTrO8DGv7xyjRnMZqnE33rCTzdcX3KCc7Mv7gP1ljwMuHQCC6OyDzJy5WnK
         RrBs1AI2D9B5uLMdeCEzRvVJ54q9CR53BWEmERsonL4C2kqB/IpSmK1prrWDD0MrGH7D
         FNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1C1t7Qhw/4Y/cukYlXL7QXYS7VSdfs0nLzx2PMLsJKc=;
        b=uh/cHel4srJIU1/rZZok+djJ87nT8dgxO1aCAEv3E7353/M/HTSONaux+mNUAhM3SJ
         KT2A55jRX36I2Ni806FIETnW/lZMrk/sVj5QMBDgG6ziAVFLR0kG6wHxsF15lH4YTT2M
         ZznmJe+yx1BWEhOvr0NC8d5bYhnjtRFWyi4zCT9UpubXbJbQj95YekWf9bc5aO13SQn5
         Z8R01blz3PU9FXFzU4zxVml3QiuPvLfN7Xz+Xi/cOqS+PXkS4M6gz/kQwZxO1A4//GgF
         C9yecRhb2AU3wr0F1WBiWWg7WU0iVZDVTI5js1AILIIzCF4gs8PjILLAlB6hPStUAXXI
         rfYg==
X-Gm-Message-State: ANoB5pk+i22eOKlJlSOKOwfPTXeoULKsONBahCslyZ4kELFOX7Utaumj
        aFhMm+TDKHjq7bapdzWWFBA=
X-Google-Smtp-Source: AA0mqf4pMaLKkzaoevxB+rOSsPa++2dY506eWmzPr35JFyeRLluIAvbS+LVqLNgYdPE8mCAYon0LPg==
X-Received: by 2002:adf:de06:0:b0:242:1277:925b with SMTP id b6-20020adfde06000000b002421277925bmr20332500wrm.59.1671194358648;
        Fri, 16 Dec 2022 04:39:18 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m2-20020a5d4a02000000b0022ae0965a8asm2193502wrq.24.2022.12.16.04.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:39:17 -0800 (PST)
Message-ID: <83aee145-17dc-45fe-dde5-324602dde0f9@gmail.com>
Date:   Fri, 16 Dec 2022 13:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 0/6] Add first version mt8188 vdosys0 driver
Content-Language: en-US
To:     "nathan.lu" <nathan.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, lancelot.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221206020046.11333-1-nathan.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221206020046.11333-1-nathan.lu@mediatek.com>
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

Applied patches 2,3,4,5
The rest will go through the DRM driver tree.

Thanks!

On 06/12/2022 03:00, nathan.lu wrote:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> This patch is to add first version mt8188 vdosys0 driver
> Modify and add new files include:
> 1. bindings documents
> 2. mtk mmsys
> 3. mtk mutex
> 4. mtk drm driver
> 
> Change in V4:
> - based on [1]
> [1] Change mmsys compatible for mt8195 mediatek-drm
>      - https://patchwork.kernel.org/project/linux-mediatek/list/?series=699386
> - Modify mediatek,mmsys.yaml, move mt8188-vdosys0 to ****mmsys
> - Modify mt8188_mmsysy.h DSI mux setting
> 
> Change in V3:
> - based on [1]
> [1] Change mmsys compatible for mt8195 mediatek-drm
>      - https://patchwork.kernel.org/project/linux-mediatek/list/?series=699386
> - Modify mediatek,mmsys.yaml mt8188-mmsys name to mt8188-vdosys0
> - Modify mtk-mmsys.c compatible name to mt8188-vdosys0
> - Add DSI mutex in mtk-mutex.c
> - Modify mtk_drm_drv.c mt8188-mmsysy name to mt8188-vdosys0
> 
> 
> Change in V2:
> - based on [2] and [3]
> [2] Add MediaTek SoC(vdosys1) support for mt8195
>      - https://patchwork.kernel.org/project/linux-mediatek/list/?series=658416
> [3] Add MediaTek SoC DRM (vdosys1) support for mt8195
>      - https://patchwork.kernel.org/project/linux-mediatek/list/?series=665269
> - Seperate bindings doucment into mmsys/mutex/display 3 parts
> - Remove redundent char in mediatek,gamma.yaml
> - Add another mediatek,mt8188-disp-rdma in mediatek,rdma.yaml
> - Remove io_start variable setting in mtk_drm_drv.c and mtk_mmsys.c
> 
> Nathan Lu (6):
>    dt-bindings: mediatek: modify VDOSYS0 display device tree
>      Documentations for MT8188
>    dt-bindings: mediatek: modify VDOSYS0 mmsys device tree Documentations
>      for MT8188
>    dt-bindings: mediatek: modify VDOSYS0 mutex device tree Documentations
>      for MT8188
>    soc: mediatek: add mtk-mmsys support for mt8188 vdosys0
>    soc: mediatek: add mtk-mutex support for mt8188 vdosys0
>    drm/mediatek: add mediatek-drm of vdosys0 support for mt8188
> 
>   .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
>   .../display/mediatek/mediatek,aal.yaml        |   1 +
>   .../display/mediatek/mediatek,ccorr.yaml      |   1 +
>   .../display/mediatek/mediatek,color.yaml      |   1 +
>   .../display/mediatek/mediatek,dither.yaml     |   1 +
>   .../display/mediatek/mediatek,gamma.yaml      |   1 +
>   .../display/mediatek/mediatek,ovl.yaml        |   1 +
>   .../display/mediatek/mediatek,postmask.yaml   |   1 +
>   .../display/mediatek/mediatek,rdma.yaml       |   4 +
>   .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  21 +++
>   drivers/soc/mediatek/mt8188-mmsys.h           | 149 ++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c              |  11 ++
>   drivers/soc/mediatek/mtk-mutex.c              |  53 +++++++
>   14 files changed, 247 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt8188-mmsys.h
> 
