Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2668568D286
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjBGJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBGJTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:19:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8981F491;
        Tue,  7 Feb 2023 01:19:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19887660206D;
        Tue,  7 Feb 2023 09:19:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675761569;
        bh=e8Qbiy3FLGBXCTtjU1xYNBFtYCGotU30DjCg6KnlbPc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i3muvc0fi156lot201IdTBZqn4ICyWuIycz8wwpeaIvtskpN4RBMNrvMbGNLBZMXv
         mXYNFRR2S1zPnVKZTMxokjRZTeBiuLxQTE/QFfWlCw4YtT97AaYbGb/rJvpw9WVdIH
         6JlRnyZllS9E/EtHAZ6iJCZzqmOzkBldGUfq5ph2oMAHwQWDDdlPV/RsuZuguAjqTR
         HKMATBor5Drl+cO3uNkUY7g2R/RjB5AP7L6l3bbOEb53eXQ9vu+Nr0fgrUk/P79oC/
         NFDTB+ieEr087PhbFkyAlssTbBgJNAz88RdkX+hoefrtPKNkXBHXlcrU4E4x/VMeRz
         Mo33XTXZW1ZEA==
Message-ID: <ea5b8fd0-579e-12e1-d9ca-775b6db30f69@collabora.com>
Date:   Tue, 7 Feb 2023 10:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 00/45] MediaTek clocks: full module build and cleanups
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
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
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <847332fb-5f10-a8dd-4203-a1906973d0ff@collabora.com>
 <CAGXv+5GUaWzoPZuO3ZUX60exZeg2S=91u-i1bGOraV1AcWP9Og@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GUaWzoPZuO3ZUX60exZeg2S=91u-i1bGOraV1AcWP9Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/02/23 10:04, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:38 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 06/02/23 16:28, AngeloGioacchino Del Regno ha scritto:
>>> This is part 2 of the "MediaTek clocks cleanups and improvements" series,
>>> which was already picked.
>>>
>>> If reading this full cover letter is too boring for you, here's a short
>>> summary of the changes of this series:
>>>    - Added mtk_clk_pdev_probe() for mtk-mmsys probed clocks;
>>>    - Added divider clock support to common probe mechanism;
>>>    - Various cleanups here and there;
>>>    - Converted most clock drivers to platform_driver;
>>>    - MediaTek clocks can now be built as modules.
>>>
>>> NOTE: Applies on top of [1].
>>>
>>>
> 
> Something broke on MT8183 Juniper, though I'm not sure what. It ended up
> crashing in mtk-cpufreq in a badly written error path. Once that was fixed
> it was endlessly looping through deferred probe. Seems like mtk-cpufreq
> was not able to get all its resources.
> 

I would be silly to expect everything to go alright in v1, wouldn't I? :-)
I'll recheck and try to understand what went wrong here.

Thanks!

> ChenYu
> 
>> ...and of course I forgot to paste the link.
>>
>> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=719067
>>
>> Cheers,
>> Angelo
>>
>>
>>> Full blurb:
>>>
>>> This huge series adds more cleanups on top, reducing size and adding more
>>> commonization for clock drivers probe/remove, which also includes a new
>>> common probe mechanism for multimedia clock drivers that are usually
>>> probed by mtk-mmsys instead of a dt clock node: thanks to this, it was
>>> finally possible to convert almost all clock drivers to the common probe
>>> mechanism, which *finally again* makes us able to build all these drivers
>>> as modules!
>>>
>>> Since this looked like being *the* way forward, I went on converting some
>>> more drivers away from OF_CLK_DECLARE_DRIVER to full platform_driver(s),
>>> allowing for more (actually, almost all!) drivers to be built as modules.
>>>
>>> While at it, I also added some more consistency in macros usage by
>>> removing all of the duplicated full macro declaration for MediaTek gate
>>> clocks and replacing all of those with using the GATE_MTK macro instead,
>>> producing a nice reduction in amount of lines per file but, more
>>> importantly, improving readability and eventual future batch changes.
>>>
>>> This amount of commonization will also, in my opinion, greatly improve
>>> the review process for new clock drivers, as they will be mostly just a
>>> list of clocks and won't contain much new code, as it's all going to be
>>> handled in the common places, which also reduces chances to see new clock
>>> driver related bugs emerging on one SoC or the other.
>>>
>>> Since I don't own devices with all of the supported MediaTek SoCs, I
>>> could not test some of the conversions on real hardware... but I am
>>> confident that this will work as the drivers are *very* similar on a
>>> per-generation basis.
>>>
>>> This series was build-tested for all (both module and built-in build)
>>> and was manually tested on MT6795, MT8173, MT8192, MT8195.
>>>
>>> AngeloGioacchino Del Regno (45):
>>>     clk: mediatek: clk-mtk: Switch to device_get_match_data()
>>>     clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
>>>     clk: mediatek: Migrate to mtk_clk_pdev_probe() for multimedia clocks
>>>     clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
>>>     clk: mediatek: mt2712: Migrate topckgen/mcucfg to
>>>       mtk_clk_simple_probe()
>>>     clk: mediatek: mt2712: Compress clock arrays entries to 90 columns
>>>     clk: mediatek: mt2712: Add error handling to
>>>       clk_mt2712_apmixed_probe()
>>>     clk: mediatek: mt2712: Move apmixedsys clock driver to its own file
>>>     clk: mediatek: mt2712: Change to use module_platform_driver macro
>>>     clk: mediatek: mt2712: Change Kconfig options to allow module build
>>>     clk: mediatek: mt8365: Move apmixedsys clock driver to its own file
>>>     clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
>>>     clk: mediatek: mt8167: Compress GATE_TOPx macros
>>>     clk: mediatek: mt8167: Move apmixedsys as platform_driver in new file
>>>     clk: mediatek: mt8167: Remove __initconst annotation from arrays
>>>     clk: mediatek: mt8167: Convert to mtk_clk_simple_{probe,remove}()
>>>     clk: mediatek: mt8183: Move apmixedsys clock driver to its own file
>>>     clk: mediatek: mt8183: Compress clocks arrays entries where possible
>>>     clk: mediatek: mt8183: Convert all remaining clocks to common probe
>>>     clk: mediatek: Consistently use GATE_MTK() macro
>>>     clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag
>>>     clk: mediatek: mt7622: Move apmixedsys clock driver to its own file
>>>     clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c
>>>     clk: mediatek: mt7622: Convert to platform driver and simple probe
>>>     clk: mediatek: mt8516: Move apmixedsys clock driver to its own file
>>>     clk: mediatek: mt8516: Convert to platform driver and simple probe
>>>     clk: mediatek: mt8516: Allow building clock drivers as modules
>>>     clk: mediatek: Propagate struct device with
>>>       mtk_clk_register_dividers()
>>>     clk: mediatek: mt7986-apmixed: Use PLL_AO flag to set critical clock
>>>     clk: mediatek: mt7986-infracfg: Migrate to common probe mechanism
>>>     clk: mediatek: mt7986-eth: Migrate to common probe mechanism
>>>     clk: mediatek: mt8186-mcu: Migrate to common probe mechanism
>>>     clk: mediatek: Switch to module_platform_driver() where possible
>>>     clk: mediatek: Add MODULE_LICENSE() where missing
>>>     clk: mediatek: Split MT8195 clock drivers and allow module build
>>>     clk: mediatek: Allow building MT8192 non-critical clocks as modules
>>>     clk: mediatek: Allow MT7622 clocks to be built as modules
>>>     clk: mediatek: Allow all MT8167 clocks to be built as modules
>>>     clk: mediatek: Allow all MT8183 clocks to be built as modules
>>>     clk: mediatek: Allow building most MT6765 clock drivers as modules
>>>     clk: mediatek: Allow building most MT6797 clock drivers as modules
>>>     clk: mediatek: Split configuration options for MT8186 clock drivers
>>>     clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
>>>     clk: mediatek: Kconfig: Allow module build for core mt8192 clocks
>>>     clk: mediatek: Add MODULE_DEVICE_TABLE() where appropriate
>>>
>>>    drivers/clk/mediatek/Kconfig                  |  282 +++--
>>>    drivers/clk/mediatek/Makefile                 |   53 +-
>>>    drivers/clk/mediatek/clk-mt2701-aud.c         |   49 +-
>>>    drivers/clk/mediatek/clk-mt2701-bdp.c         |   27 +-
>>>    drivers/clk/mediatek/clk-mt2701-eth.c         |   16 +-
>>>    drivers/clk/mediatek/clk-mt2701-g3d.c         |   16 +-
>>>    drivers/clk/mediatek/clk-mt2701-hif.c         |   16 +-
>>>    drivers/clk/mediatek/clk-mt2701-img.c         |   15 +-
>>>    drivers/clk/mediatek/clk-mt2701-mm.c          |   56 +-
>>>    drivers/clk/mediatek/clk-mt2701-vdec.c        |   27 +-
>>>    drivers/clk/mediatek/clk-mt2701.c             |   48 +-
>>>    drivers/clk/mediatek/clk-mt2712-apmixedsys.c  |  154 +++
>>>    drivers/clk/mediatek/clk-mt2712-bdp.c         |   16 +-
>>>    drivers/clk/mediatek/clk-mt2712-img.c         |   15 +-
>>>    drivers/clk/mediatek/clk-mt2712-jpgdec.c      |   16 +-
>>>    drivers/clk/mediatek/clk-mt2712-mfg.c         |   15 +-
>>>    drivers/clk/mediatek/clk-mt2712-mm.c          |   66 +-
>>>    drivers/clk/mediatek/clk-mt2712-vdec.c        |   27 +-
>>>    drivers/clk/mediatek/clk-mt2712-venc.c        |   16 +-
>>>    drivers/clk/mediatek/clk-mt2712.c             | 1016 +++++------------
>>>    drivers/clk/mediatek/clk-mt6765-audio.c       |   27 +-
>>>    drivers/clk/mediatek/clk-mt6765-cam.c         |   16 +-
>>>    drivers/clk/mediatek/clk-mt6765-img.c         |   15 +-
>>>    drivers/clk/mediatek/clk-mt6765-mipi0a.c      |   16 +-
>>>    drivers/clk/mediatek/clk-mt6765-mm.c          |   15 +-
>>>    drivers/clk/mediatek/clk-mt6765-vcodec.c      |   16 +-
>>>    drivers/clk/mediatek/clk-mt6765.c             |   90 +-
>>>    drivers/clk/mediatek/clk-mt6779-aud.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt6779-cam.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt6779-img.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt6779-ipe.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt6779-mfg.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt6779-mm.c          |   25 +-
>>>    drivers/clk/mediatek/clk-mt6779-vdec.c        |    1 +
>>>    drivers/clk/mediatek/clk-mt6779-venc.c        |    1 +
>>>    drivers/clk/mediatek/clk-mt6779.c             |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-apmixedsys.c  |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-infracfg.c    |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-mfg.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-mm.c          |   56 +-
>>>    drivers/clk/mediatek/clk-mt6795-pericfg.c     |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-topckgen.c    |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-vdecsys.c     |    1 +
>>>    drivers/clk/mediatek/clk-mt6795-vencsys.c     |    1 +
>>>    drivers/clk/mediatek/clk-mt6797-img.c         |   15 +-
>>>    drivers/clk/mediatek/clk-mt6797-mm.c          |   56 +-
>>>    drivers/clk/mediatek/clk-mt6797-vdec.c        |   27 +-
>>>    drivers/clk/mediatek/clk-mt6797-venc.c        |   16 +-
>>>    drivers/clk/mediatek/clk-mt6797.c             |   47 +-
>>>    drivers/clk/mediatek/clk-mt7622-apmixedsys.c  |  138 +++
>>>    drivers/clk/mediatek/clk-mt7622-aud.c         |   49 +-
>>>    drivers/clk/mediatek/clk-mt7622-eth.c         |   27 +-
>>>    drivers/clk/mediatek/clk-mt7622-hif.c         |   27 +-
>>>    drivers/clk/mediatek/clk-mt7622-infracfg.c    |  129 +++
>>>    drivers/clk/mediatek/clk-mt7622.c             |  375 +-----
>>>    drivers/clk/mediatek/clk-mt7629-eth.c         |   25 +-
>>>    drivers/clk/mediatek/clk-mt7629-hif.c         |   27 +-
>>>    drivers/clk/mediatek/clk-mt7629.c             |   46 +-
>>>    drivers/clk/mediatek/clk-mt7981-apmixed.c     |    2 +
>>>    drivers/clk/mediatek/clk-mt7981-eth.c         |    3 +-
>>>    drivers/clk/mediatek/clk-mt7981-infracfg.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt7981-topckgen.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt7986-apmixed.c     |    8 +-
>>>    drivers/clk/mediatek/clk-mt7986-eth.c         |  115 +-
>>>    drivers/clk/mediatek/clk-mt7986-infracfg.c    |   93 +-
>>>    drivers/clk/mediatek/clk-mt7986-topckgen.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8135.c             |   31 +-
>>>    drivers/clk/mediatek/clk-mt8167-apmixedsys.c  |  145 +++
>>>    drivers/clk/mediatek/clk-mt8167-aud.c         |   47 +-
>>>    drivers/clk/mediatek/clk-mt8167-img.c         |   50 +-
>>>    drivers/clk/mediatek/clk-mt8167-mfgcfg.c      |   50 +-
>>>    drivers/clk/mediatek/clk-mt8167-mm.c          |   69 +-
>>>    drivers/clk/mediatek/clk-mt8167-vdec.c        |   59 +-
>>>    drivers/clk/mediatek/clk-mt8167.c             |  390 ++-----
>>>    drivers/clk/mediatek/clk-mt8173-apmixedsys.c  |    1 +
>>>    drivers/clk/mediatek/clk-mt8173-img.c         |    1 +
>>>    drivers/clk/mediatek/clk-mt8173-infracfg.c    |    1 +
>>>    drivers/clk/mediatek/clk-mt8173-mm.c          |   82 +-
>>>    drivers/clk/mediatek/clk-mt8173-pericfg.c     |    1 +
>>>    drivers/clk/mediatek/clk-mt8173-topckgen.c    |    1 +
>>>    drivers/clk/mediatek/clk-mt8173-vdecsys.c     |    1 +
>>>    drivers/clk/mediatek/clk-mt8173-vencsys.c     |    1 +
>>>    drivers/clk/mediatek/clk-mt8183-apmixedsys.c  |  194 ++++
>>>    drivers/clk/mediatek/clk-mt8183-audio.c       |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-cam.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-img.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-ipu0.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-ipu1.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-ipu_adl.c     |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-ipu_conn.c    |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-mfgcfg.c      |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-mm.c          |   29 +-
>>>    drivers/clk/mediatek/clk-mt8183-vdec.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183-venc.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8183.c             |  747 +++---------
>>>    drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-cam.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-img.c         |    4 +-
>>>    .../clk/mediatek/clk-mt8186-imp_iic_wrap.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-infra_ao.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-ipe.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-mcu.c         |   69 +-
>>>    drivers/clk/mediatek/clk-mt8186-mdp.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-mfg.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-mm.c          |   59 +-
>>>    drivers/clk/mediatek/clk-mt8186-topckgen.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-vdec.c        |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-venc.c        |    4 +-
>>>    drivers/clk/mediatek/clk-mt8186-wpe.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8192-apmixedsys.c  |  215 ++++
>>>    drivers/clk/mediatek/clk-mt8192-aud.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-cam.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-img.c         |    5 +-
>>>    .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-ipe.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-mdp.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-mfg.c         |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-mm.c          |   34 +-
>>>    drivers/clk/mediatek/clk-mt8192-msdc.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-vdec.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192-venc.c        |    5 +-
>>>    drivers/clk/mediatek/clk-mt8192.c             |  223 +---
>>>    drivers/clk/mediatek/clk-mt8195-apmixedsys.c  |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-apusys_pll.c  |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-cam.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-ccu.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-img.c         |    4 +-
>>>    .../clk/mediatek/clk-mt8195-imp_iic_wrap.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-infra_ao.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-ipe.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-mfg.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-peri_ao.c     |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-scp_adsp.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-topckgen.c    |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-vdec.c        |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-vdo0.c        |   59 +-
>>>    drivers/clk/mediatek/clk-mt8195-vdo1.c        |   61 +-
>>>    drivers/clk/mediatek/clk-mt8195-venc.c        |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-vpp0.c        |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-vpp1.c        |    4 +-
>>>    drivers/clk/mediatek/clk-mt8195-wpe.c         |    4 +-
>>>    drivers/clk/mediatek/clk-mt8365-apmixedsys.c  |  166 +++
>>>    drivers/clk/mediatek/clk-mt8365-apu.c         |    3 +-
>>>    drivers/clk/mediatek/clk-mt8365-cam.c         |    3 +-
>>>    drivers/clk/mediatek/clk-mt8365-mfg.c         |    3 +-
>>>    drivers/clk/mediatek/clk-mt8365-mm.c          |   42 +-
>>>    drivers/clk/mediatek/clk-mt8365-vdec.c        |    3 +-
>>>    drivers/clk/mediatek/clk-mt8365-venc.c        |    3 +-
>>>    drivers/clk/mediatek/clk-mt8365.c             |  605 ++--------
>>>    drivers/clk/mediatek/clk-mt8516-apmixedsys.c  |  122 ++
>>>    drivers/clk/mediatek/clk-mt8516-aud.c         |   47 +-
>>>    drivers/clk/mediatek/clk-mt8516.c             |  246 +---
>>>    drivers/clk/mediatek/clk-mtk.c                |   82 +-
>>>    drivers/clk/mediatek/clk-mtk.h                |    7 +-
>>>    155 files changed, 3292 insertions(+), 4355 deletions(-)
>>>    create mode 100644 drivers/clk/mediatek/clk-mt2712-apmixedsys.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt7622-apmixedsys.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt7622-infracfg.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt8167-apmixedsys.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt8183-apmixedsys.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt8192-apmixedsys.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt8365-apmixedsys.c
>>>    create mode 100644 drivers/clk/mediatek/clk-mt8516-apmixedsys.c
>>>

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

