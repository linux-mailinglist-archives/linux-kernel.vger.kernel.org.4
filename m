Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5235BBB45
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIRDSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIRDRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:17:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E258286F5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC20B80E4B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CECDC43140
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663471070;
        bh=qb00ImaXysZJpvsHrO2c88a7Ds3dOjpngNqFrczjjDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hr03nYXFeceAHqZ7u2VGyT81QKhjeSwZRNCObxkGdX9jD3isSngUsiQl5UcFBS8gN
         y8RF4zWKYuZYJnmjgoTSzSyW3xw8p8M9VqadfqWChJcOY2TzS9u8vXsYJo+yM4wrAd
         CjawLOZ/BPCd5PV5zRmR6iRSQrN+lWn21I43pM1IEymhBZw5EVBFX0hdCxlCkg3aUw
         CON7xaXVf89B/jgtrahFQyCxY1zAfiGvx2S62fjVGwb6VY43rM6aOgqFCoynME0qI+
         MK7SOCETpDcBVQ/qxoqGEvrCOzbWR/osrWOQMWT+2Y/zYMwZEYnMYJW4EIMnGDvSly
         c2jim1coxXuaQ==
Received: by mail-ot1-f42.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so12224929otu.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:17:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf19+k/CznWw28THb6zZdDuA7WBEIKNPLyWjttMzNKUVrSbRuxat
        upyAe7fNsv6/K518wwb4qblCeuq7g9YIkSRUmA==
X-Google-Smtp-Source: AMsMyM58ezG8msguUMeAH2Le2boc4pMXZ12Yr7cvpd704aw17iSXBXWn9Gr0znIRuo886rusNYTI49u//14DleuHyj8=
X-Received: by 2002:a05:6830:6999:b0:61d:26f8:94c1 with SMTP id
 cy25-20020a056830699900b0061d26f894c1mr5435523otb.278.1663471069381; Sat, 17
 Sep 2022 20:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
In-Reply-To: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 18 Sep 2022 11:17:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY__g=s_ACd+zTJZT1HBbrLo-JpHbrwLsy1zKjxbM5c21uA@mail.gmail.com>
Message-ID: <CAAOTY__g=s_ACd+zTJZT1HBbrLo-JpHbrwLsy1zKjxbM5c21uA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Refactor MediaTek DP drivers
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jitao Shi <jitao.shi@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>, liangxu.xu@mediatek.com,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmitry:

My tree has no mtk-dp driver yet. Would you like to pick this series?

Regards,
Chun-Kuang.

Bo-Chen Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E6=99=9A=E4=B8=8A9:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> For this series, we do some clean-up and fix a build warning.
> This series is based on linux-next-20220915.
>
> Changes for v2:
> 1. Update commit message in "drm/mediatek: dp: Reduce indentation in mtk_=
dp_bdg_detect()".
> 2. Add fix tag for "drm/mediatek: dp: Fix warning in mtk_dp_video_mute()"=
.
>
> Bo-Chen Chen (3):
>   drm/mediatek: dp: Reduce indentation in mtk_dp_bdg_detect()
>   drm/mediatek: dp: Remove unused register definitions
>   drm/mediatek: dp: Fix warning in mtk_dp_video_mute()
>
>  drivers/gpu/drm/mediatek/mtk_dp.c     | 70 ++++++++++++++-------------
>  drivers/gpu/drm/mediatek/mtk_dp_reg.h |  6 ---
>  2 files changed, 36 insertions(+), 40 deletions(-)
>
> --
> 2.18.0
>
