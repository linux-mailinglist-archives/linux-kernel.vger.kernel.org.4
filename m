Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C56A05D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjBWKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjBWKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:15:44 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D3A3588
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:15:41 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id f23so14135678vsa.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVrmhpIhfXy3UeuiMvhWtzlXyLF71Bh8N6i0HHEh++k=;
        b=Vy+v7B1L/N1iP4TtkYyhKLOX54+Ab8N3nCHjI6ZMfn6WL58RNwjgJMG3fvpDZcTnTm
         8RkJ8/AE7csCDyL35SzdfqW11Yx5JO0WCBDPM/YmObEAsuPtd06cgFhO7ZKMYk5g5tfR
         JIbWLjZswOE/2RfD7dOmER6IEZrmokRAkAkOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVrmhpIhfXy3UeuiMvhWtzlXyLF71Bh8N6i0HHEh++k=;
        b=UOo9+o6nCsYLJkgP8ps+XuOFNqG5EM6nkuglcsLIMvW/mySzA2NRJnbggD4sQsPnf+
         3w77qeo6urAW5Mz65oxnFxr23HYYZ1Iwdt+z0tZh5KxQ0aP8X4j0WKAAAT+OLJizQeWc
         NJ4848H/v9JFBQeyNSKAWckKOUDVgUv+PNTyED1VRwDyxtYqh9F2WkuQcyH6XavyGAGL
         D+pKIAgecREk2uElw6Z3yxrEDNqlgsj3tDw/cSQ39I7F+cBGl0bS54cbhDKyakxbdTEe
         34m4vd6RKnQE8DB2VGTD2yzvm01KNyHeDtqPeJv/FDSEHCYuJfiyz0zQ4PcAxFV//nrM
         Vm0A==
X-Gm-Message-State: AO0yUKUBh1E0FcyfQOchPVHF1IYW3FLd5ZvGsd+G5BkL9yikBxeRwiyq
        ovReKkh/7hBoLKlOa63cXmrTKbpF0HMTi2OCGDNHsj53sI7wdQ==
X-Google-Smtp-Source: AK7set8MyCeyTUK6IdQ4DvBm7Map5jOAl0KfiFtNYDeLA/IdqwjM0ZzHDxJ7NMFAseTCuHWrBKcEHKCr19wduN2lrLc=
X-Received: by 2002:a05:6102:31a9:b0:415:48dd:e0b9 with SMTP id
 d9-20020a05610231a900b0041548dde0b9mr210695vsh.3.1677147339682; Thu, 23 Feb
 2023 02:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 23 Feb 2023 18:15:28 +0800
Message-ID: <CAGXv+5EA9Ed2tyg2f3TSeXYdZOZ8a=VztaOc_UTFK2dEsENjJQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/54] MediaTek clocks: full module build and cleanups
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 5:25 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v5:
>  - Fixed typo in MODULE_DEVICE_TABLE() for clk-mt8195-vpp0/vpp1
>
> Changes in v4:
>  - Rebased over clk-next branch as of 21/02/2023
>  - MT8135: Squashed removal of __initconst annotation with conversion
>    to platform drivers as suggested by Chen-Yu
>  - MT8135: Added mention of the introduction of the dummy clock in
>    the commit description of patch [54/54]
>  - Fixed Kconfig ordering issue for MT8195 IMGSYS dependant option
>
> Changes in v3:
>  - Added conversion to simple_probe for MT8135 clocks
>  - Reordered added Kconfig options for MT8195, MT8186
>  - Additional config options for MT8195, MT8186 are now default
>    enabled if parent COMMON_CLK_MT81{95,86} is enabled
>  - Added .remove() callback to MT2712 and MT7622 apmixedsys drivers
>    to avoid resource leakage on unbind/removal
>  - Dropped unwanted and useless change on mt7629-eth.c
>
> Changes in v2:
>  - Fixed issues on MT8183 (thanks Chen-Yu!)
>  - Changed builtin_platform_driver() -> module_platform_driver() for
>    MT8167 vdecsys clocks (as that was a mistake!)
>  - Some patches were split, some others were reordered
>  - Summarized: applied changes from Chen-Yu's review
>
> This is part 2 of the "MediaTek clocks cleanups and improvements" series,
> which was already picked.
>
> If reading this full cover letter is too boring for you, here's a short
> summary of the changes of this series:
>  - Added mtk_clk_pdev_probe() for mtk-mmsys probed clocks;
>  - Added divider clock support to common probe mechanism;
>  - Various cleanups here and there;
>  - Converted most clock drivers to platform_driver;
>  - MediaTek clocks can now be built as modules.
>
> NOTE: Applies on top of [1] and [2].
>
>
> Full blurb:
>
> This huge series adds more cleanups on top, reducing size and adding more
> commonization for clock drivers probe/remove, which also includes a new
> common probe mechanism for multimedia clock drivers that are usually
> probed by mtk-mmsys instead of a dt clock node: thanks to this, it was
> finally possible to convert almost all clock drivers to the common probe
> mechanism, which *finally again* makes us able to build all these drivers
> as modules!
>
> Since this looked like being *the* way forward, I went on converting some
> more drivers away from OF_CLK_DECLARE_DRIVER to full platform_driver(s),
> allowing for more (actually, almost all!) drivers to be built as modules.
>
> While at it, I also added some more consistency in macros usage by
> removing all of the duplicated full macro declaration for MediaTek gate
> clocks and replacing all of those with using the GATE_MTK macro instead,
> producing a nice reduction in amount of lines per file but, more
> importantly, improving readability and eventual future batch changes.
>
> This amount of commonization will also, in my opinion, greatly improve
> the review process for new clock drivers, as they will be mostly just a
> list of clocks and won't contain much new code, as it's all going to be
> handled in the common places, which also reduces chances to see new clock
> driver related bugs emerging on one SoC or the other.
>
> Since I don't own devices with all of the supported MediaTek SoCs, I
> could not test some of the conversions on real hardware... but I am
> confident that this will work as the drivers are *very* similar on a
> per-generation basis.
>
> This series was build-tested for all (both module and built-in build)
> and was manually tested on MT6795, MT8173, MT8192, MT8195.
>
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=719067
> [2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20230207014800.7619-2-moudy.ho@mediatek.com/
>
> AngeloGioacchino Del Regno (54):
>   clk: mediatek: clk-mtk: Switch to device_get_match_data()
>   clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
>   clk: mediatek: Migrate to mtk_clk_pdev_probe() for multimedia clocks
>   clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
>   clk: mediatek: mt2712: Migrate topckgen/mcucfg to
>     mtk_clk_simple_probe()
>   clk: mediatek: mt2712: Compress clock arrays entries to 90 columns
>   clk: mediatek: mt2712: Add error handling to
>     clk_mt2712_apmixed_probe()
>   clk: mediatek: mt2712: Move apmixedsys clock driver to its own file
>   clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module
>     build
>   clk: mediatek: mt2712: Change to use module_platform_driver macro
>   clk: mediatek: mt8365: Move apmixedsys clock driver to its own file
>   clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks
>   clk: mediatek: mt8365: Join top_misc_mux_gates and top_misc_muxes
>     arrays
>   clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
>   clk: mediatek: mt8167: Compress GATE_TOPx macros
>   clk: mediatek: mt8167: Move apmixedsys as platform_driver in new file
>   clk: mediatek: mt8167: Remove __initconst annotation from arrays
>   clk: mediatek: mt8167: Convert to mtk_clk_simple_{probe,remove}()
>   clk: mediatek: mt8183: Move apmixedsys clock driver to its own file
>   clk: mediatek: mt8183: Compress clocks arrays entries where possible
>   clk: mediatek: mt8183: Convert all remaining clocks to common probe
>   clk: mediatek: Consistently use GATE_MTK() macro
>   clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag
>   clk: mediatek: mt7622: Move apmixedsys clock driver to its own file
>   clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module
>     build
>   clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c
>   clk: mediatek: mt7622: Convert to platform driver and simple probe
>   clk: mediatek: mt8516: Move apmixedsys clock driver to its own file
>   clk: mediatek: mt8516: Convert to platform driver and simple probe
>   clk: mediatek: mt8516: Allow building clock drivers as modules
>   clk: mediatek: Propagate struct device with
>     mtk_clk_register_dividers()
>   clk: mediatek: mt7986-apmixed: Use PLL_AO flag to set critical clock
>   clk: mediatek: mt7986-infracfg: Migrate to common probe mechanism
>   clk: mediatek: mt7986-eth: Migrate to common probe mechanism
>   clk: mediatek: mt8186-mcu: Migrate to common probe mechanism
>   clk: mediatek: Switch to module_platform_driver() where possible
>   clk: mediatek: Add MODULE_LICENSE() where missing
>   clk: mediatek: mt2712: Change Kconfig options to allow module build
>   clk: mediatek: Split MT8195 clock drivers and allow module build
>   clk: mediatek: Allow building MT8192 non-critical clocks as modules
>   clk: mediatek: Allow MT7622 clocks to be built as modules
>   clk: mediatek: Allow all MT8167 clocks to be built as modules
>   clk: mediatek: Allow all MT8183 clocks to be built as modules
>   clk: mediatek: Allow building most MT6765 clock drivers as modules
>   clk: mediatek: Allow building most MT6797 clock drivers as modules
>   clk: mediatek: Split configuration options for MT8186 clock drivers
>   clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
>   clk: mediatek: Kconfig: Allow module build for core mt8192 clocks
>   clk: mediatek: Add MODULE_DEVICE_TABLE() where appropriate
>   clk: mediatek: mt8135: Move apmixedsys to its own file
>   clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag
>   clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and
>     module
>   clk: mediatek: mt8135: Join root_clk_alias and top_divs arrays
>   clk: mediatek: mt8135: Convert to simple probe and enable module build

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183, MT8192, MT8195. Unfortunately on MT8186 the patch series causes
the kernel to freeze during boot. I need to build a verbose kernel to figure
it out.

ChenYu
