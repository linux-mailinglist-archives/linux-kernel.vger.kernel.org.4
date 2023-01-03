Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595B65BD43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjACJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjACJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:36:34 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE1C259
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:36:33 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id p30so25545860vsr.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2J2aTNhc8Fk+2QZu9B/DP3Bn+7R4y8GRLvltu/3lVbw=;
        b=A5Zr2HT5mmyAp05QRJwAfVvnRBy65SHP+jupcFVWUT3FKrjLw1TpBJrXi5uhMZQq2R
         e1Pno+FyNk66ZStSqsyz8L1zf5GHQuyP/tBoj0haHLKX6AwdIamttqpqQG3TxHKXrNOR
         aDU+nLR7YBek0BvA/ibeZoZmQf4JWkzpB5yJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J2aTNhc8Fk+2QZu9B/DP3Bn+7R4y8GRLvltu/3lVbw=;
        b=nsTUh9zb9nZJeJEM1yk65Av8qVwEcmRXQr3xLUc0evmmr2kXPwZVFPY2IKlOxCpCYP
         xA/OqWc65d/OnWoTEZWfJfqq/ibfVLBS0QpyPcvaek/WMfxN27l+Rd7i2rLoactUlfoE
         9KAgdJRA4k4GJx++hAs2kDsWOYAQA4bEUMMgpt1XTzAX+qk1kAa6UOXV3TKVcojWRuI9
         JGoQpaAx1iUVSQHcYKMSKVMeZt/UwBRtzCn2UidyNfLLigoh2Sc1XTmT0Yw7wI2yupJI
         P2Y3C6vjE/Dq44Q+RLfmgzXyzDeIu5ih79hOHRUV9fgkQOOmBLuPS4AbaQYRNObOjcDV
         kMDw==
X-Gm-Message-State: AFqh2kqBY+1zq9oGe+r74BpZE+vs+ySM7Wn5HUcFvn5PtS4YmKEGCf7w
        AA3KjnYo2FaEaM06AAxOtz80ZnkR18SjXJndVooK9A==
X-Google-Smtp-Source: AMrXdXsjYNpn4DO5afgWKbBL3BZLMSMIQCd2hnTZosLQcX2by+boAHEHDPWQ1FXpr2KldsK58GYEH3IVdxFGAqoYF5U=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr3971152vsv.9.1672738592218; Tue, 03 Jan
 2023 01:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 3 Jan 2023 17:36:21 +0800
Message-ID: <CAGXv+5GekZUSe34DxiKzdnPr-GDsmJBfAgkS1RjrN-xdeXMN6g@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] MediaTek clocks cleanups and improvements
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
>
> Changes in v2:
>  - Moved dt-bindings CLK_DUMMY to clk-mtk.h instead
>
>
> This series performs cleanups and improvements on MediaTek clock
> drivers, greatly reducing code duplication (hence also reducing
> kernel size).
>
> There would be a lot to say about it, but summarizing:
>
> * Propagates struct device where possible in order to introduce the
>   possibility of using Runtime PM on clock drivers as needed,
>   possibly enhancing reliability of some platforms (obviously, this
>   will do nothing unless power-domains are added to devicetree);
>
> * Cleans up some duplicated clock(s) registration attempt(s): on
>   some platforms the 26M fixed factor clock is registered early,
>   but then upon platform_driver probe, an attempt to re-register
>   that clock was performed;
>
> * Removes some early clock registration where possible, moving
>   everything to platform_driver clock probe;
>
> * Breaks down the big MT8173 clock driver in multiple ones, as it's
>   already done with the others, cleans it up and adds possibility
>   possibility to compile non-boot-critical clock drivers (for 8173)
>   as modules;
>
> * Extends the common mtk_clk_simple_probe() function to be able to
>   register multiple MediaTek clock types;
>
> * Removes duplicated [...]_probe functions from multiple MediaTek SoC
>   clock drivers, migrating almost everything to the common functions
>   mtk_clk_simple_probe();
>
> * Adds a .remove() callback, pointing to the common mtk_clk_simple_remove()
>   function to all clock drivers that were migrated to the common probe;
>
> * Some more spare cleanups here and there.
>
> All of this was manually tested on various Chromebooks (with different MTK
> SoCs) and no regression was detected.
>
> Cheers!
>
> AngeloGioacchino Del Regno (23):
>   clk: mediatek: mt8192: Correctly unregister and free clocks on failure
>   clk: mediatek: mt8192: Propagate struct device for gate clocks
>   clk: mediatek: clk-gate: Propagate struct device with
>     mtk_clk_register_gates()
>   clk: mediatek: cpumux: Propagate struct device where possible
>   clk: mediatek: clk-mtk: Propagate struct device for composites
>   clk: mediatek: clk-mux: Propagate struct device for mtk-mux
>   clk: mediatek: clk-mtk: Add dummy clock ops
>   clk: mediatek: mt8173: Migrate to platform driver and common probe
>   clk: mediatek: mt8173: Remove mtk_clk_enable_critical()
>   clk: mediatek: mt8173: Break down clock drivers and allow module build
>   clk: mediatek: Switch to mtk_clk_simple_probe() where possible
>   clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
>   clk: mediatek: mt8173: Migrate pericfg/topckgen to
>     mtk_clk_simple_probe()
>   clk: mediatek: clk-mt8192: Move CLK_TOP_CSW_F26M_D2 in top_divs
>   clk: mediatek: mt8192: Join top_adj_divs and top_muxes
>   clk: mediatek: mt8186: Join top_adj_div and top_muxes
>   clk: mediatek: clk-mt8183: Join top_aud_muxes and top_aud_divs
>   clk: mediatek: clk-mtk: Register MFG notifier in
>     mtk_clk_simple_probe()
>   clk: mediatek: clk-mt8192: Migrate topckgen to mtk_clk_simple_probe()
>   clk: mediatek: clk-mt8186-topckgen: Migrate to mtk_clk_simple_probe()
>   clk: mediatek: clk-mt6795-topckgen: Migrate to mtk_clk_simple_probe()
>   clk: mediatek: clk-mt7986-topckgen: Properly keep some clocks enabled
>   clk: mediatek: clk-mt7986-topckgen: Migrate to mtk_clk_simple_probe()

Boot tested on MT8183 and MT8192 (which needs CLK_OPS_PARENT_ENABLE fix
I just sent), so for the whole series:

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
