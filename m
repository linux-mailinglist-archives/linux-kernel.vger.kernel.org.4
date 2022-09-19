Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2058C5BCA20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiISK6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiISK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:57:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5524E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:54:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y5so3324568wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=CZ0mR94UcNRwzJdy6hZjjG35nbIA/4JhGrEA4EFuTvY=;
        b=DLCjWrOxPK2f0H+PbIL9nC2iE3mBY22Iiel1lj9cZnn1YoEQm+GUYgb23lrrFzLc34
         6S7agCUYOOeBPwINyQEiCtqbA/wvlSTE83H3tWV8svQgcoEc97hHl4TawHPlg9tV1qt4
         ZzNDmcTy5yP6Rc6/SnkxvX8WuHD+dYs8OsiC3WeivEVoTW+M28ZfdP7ErucQBcSXjKxe
         o/H8IF96QnvlAgc4fylaRtVOiyBNDvvOAyeqYLx62YBmCHuB0duIpHc0FpfnmkuIXZn1
         2Xh8xZlTSb+GRsqN1Aye5FmpBliaWQXf88eBcICfgCN+7e383GhnoiIn3usiyfHGoykE
         NpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=CZ0mR94UcNRwzJdy6hZjjG35nbIA/4JhGrEA4EFuTvY=;
        b=UbXSgz9AC4BFWbo7WQEPncCKcEKMLAvB8EtJNQ7sz+X/A/pW/sRTpg/61oscg8tv0Z
         VCrV+Nsxgmfp6nuNZ1XU7/Y4dkFtnrDB4KNimHw4++C3zad1KoYSfH/Hf5j1tlLIxf/m
         +gDYi2svHNVQhzZ6XGQTeXqhM2zzpFMbRo4l2TqVM6HRy++byrnfUt8RVO1fm/PlvrFg
         Ii8DBFgewLLlkmLR8cBTZWdTQT654zlxu2soQx6QJPwIu0WHRaFLclNzK4xLYmjAJUVO
         FyueDPGuHxy24z1BJ/eoggzoD/rfo6edzvL1tK5XOPyNnKljVH63HZfop0syHtxfb2qZ
         qiow==
X-Gm-Message-State: ACrzQf3d/Vijo3C10XqTP2p1Zm9fJuLQTVDh1j1sDsU0JeRRrKitQvz1
        jKrfmv0TvNU/1KCKbZnHTDc=
X-Google-Smtp-Source: AMsMyM5WuGQb/dpvWM/Fp5nw736lQDHyZXjbWoCTvKziJ9HtGOMU/N7SWgQ9nPxpblcVQHg1Zwn72g==
X-Received: by 2002:a05:6000:1788:b0:22b:2ce:c6ae with SMTP id e8-20020a056000178800b0022b02cec6aemr1630868wrg.236.1663584875960;
        Mon, 19 Sep 2022 03:54:35 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003a845fa1edfsm21646289wms.3.2022.09.19.03.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:54:34 -0700 (PDT)
Message-ID: <498fe3e5-a237-121a-d500-fbb0994906cb@gmail.com>
Date:   Mon, 19 Sep 2022 12:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jean Delvare <jdelvare@suse.de>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Sen Chu <sen.chu@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        xinlei.lee@mediatek.com
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: [GIT PULL] ARM: soc: MediaTek related SoC diver updates for v6.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

Hopefully not too late, see below the MediaTek updates for v6.1.

The most important updates are support for the PMIC wrapper on MT8183. MT6795 
got support for the display mutex part and MT8186 for the MDP3 mutex.

Best regards,
Matthias

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/ 
tags/v6.0-next-soc

for you to fetch changes up to b404cb45990bf24d41c29fe856aafb0746a7b81f:

   soc: mediatek: Add mmsys func to adapt to dpi output for MT8186 (2022-09-15 
23:50:28 +0200)

----------------------------------------------------------------
pmic-wrapper:
- add support for mt8188

SVS:
- several driver cleanups

power-domain:
- several cleanups of the dt-bindings and driver

mutex:
- add support to mt6795 disp mutex
- add support for mt8186 mdp3 mutex

----------------------------------------------------------------
Allen-KH Cheng (2):
       dt-bindings: soc: mediatek: Add mdp3 mutex support for mt8186
       soc: mediatek: mutex: Add mt8186 mutex mod settings for mdp3

AngeloGioacchino Del Regno (8):
       soc: mediatek: mtk-svs: Switch to platform_get_irq()
       soc: mediatek: mtk-svs: Remove hardcoded irqflags
       soc: mediatek: mtk-svs: Drop of_match_ptr() for of_match_table
       soc: mediatek: mtk-svs: Use devm variant for dev_pm_opp_of_add_table()
       soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array read
       soc: mediatek: mtk-svs: Use bitfield access macros where possible
       dt-bindings: soc: mediatek: Add display mutex support for MT6795
       soc: mediatek: mutex: Add support for MT6795 Helio X10 display mutex

Christophe JAILLET (1):
       soc: mediatek: pm-domains: Simplify some error message

Jean Delvare (1):
       soc: mediatek: Let PMIC Wrapper and SCPSYS depend on OF

Nícolas F. R. A. Prado (1):
       soc: mediatek: mtk-svs: Explicitly include bitfield header

Sen Chu (1):
       dt-bindings: soc: mediatek: pwrap: add compatible for mt8188

Tinghan Shen (3):
       dt-bindings: power: mediatek: Refine multiple level power domain nodes
       dt-bindings: power: mediatek: Support naming power controller node with 
unit address
       dt-bindings: power: mediatek: Update maintainer list

Xinlei Lee (1):
       soc: mediatek: Add mmsys func to adapt to dpi output for MT8186

  .../bindings/power/mediatek,power-controller.yaml  | 135 ++--------
  .../bindings/soc/mediatek/mediatek,mutex.yaml      |   2 +
  .../devicetree/bindings/soc/mediatek/pwrap.txt     |   1 +
  drivers/soc/mediatek/Kconfig                       |   2 +
  drivers/soc/mediatek/mt8186-mmsys.h                |   6 +
  drivers/soc/mediatek/mtk-mmsys.c                   |  20 ++
  drivers/soc/mediatek/mtk-mutex.c                   |  44 ++++
  drivers/soc/mediatek/mtk-pm-domains.c              |   6 +-
  drivers/soc/mediatek/mtk-pmic-wrap.c               |   2 +-
  drivers/soc/mediatek/mtk-scpsys.c                  |   2 +-
  drivers/soc/mediatek/mtk-svs.c                     | 284 +++++++++++++--------
  include/linux/soc/mediatek/mtk-mmsys.h             |   2 +
  include/linux/soc/mediatek/mtk-mutex.h             |   2 +
  13 files changed, 274 insertions(+), 234 deletions(-)
