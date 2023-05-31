Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41AB7175EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjEaEuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEaEt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:49:57 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A7E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:49:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f81396e435so23485301cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685508595; x=1688100595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIhKyHH3M7cbke7yuigX6jBzwG52Hnh4pfVGqCJbh2E=;
        b=HdOhh3avnmm0A0X2CKBtkWj8n2mTjkJRDj54EC/L41Z3fBgA9z+7gs5CQheZrYp+o/
         HVmBUDma0iAod0p7zCGEMYvaBp4y0h/cMXXqxw9sYKFjL4/OCDrVIkmAJQ6hNqRynki4
         i76WOp31bxaF+BNXRXsitsveSOZcPHGqnEs4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685508595; x=1688100595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIhKyHH3M7cbke7yuigX6jBzwG52Hnh4pfVGqCJbh2E=;
        b=iXhlmXCiSChcytFNWFUpdZ+PF/u8ctdY1tZGzVTeTAwUva+Ixs0B5yOb3aP+XmxJd7
         x8bYnisDAKUdIEY+QluUEBbwnNBnVNaoUQHjAUUVrJk6luOGrZduLlyBl3Bf7DwMj0Ak
         LMSUeG5cSlHW5acTbiC7nTOwjIftkRQxfBYy7QHJiX1AGpR23QVIef3KJ7tkAsPZW1zU
         gRGULU99GbxYBaPqy3UQifWCF0N1OWvSofjeFs393+9NsLTYzadWtCNKFBbHybRCP8Be
         nXj/S/qDwfoP+7nlzX5++dmlPPJJsUQTtRXxQL+BHduOatBvtV9b+RzQRwW5OLrIxsUT
         UsOA==
X-Gm-Message-State: AC+VfDwrhkmrBFD0I3kiuCIGXPCaFSqG+7WJniEuS0HWfNv8YoPiLnX0
        tYxRE1bICadRsAzroc8IGcz1REUu8nbh+i4GJRFeqQ==
X-Google-Smtp-Source: ACHHUZ59KzB24IVnct48XOmbgp0HaBygejoFOdaodm4dgQC79KaZmYJr8htlEBsi9gDXYnmpG1Slgn3o9UH1CCtdjvo=
X-Received: by 2002:ac8:5c43:0:b0:3f6:a760:2487 with SMTP id
 j3-20020ac85c43000000b003f6a7602487mr119062qtj.59.1685508594852; Tue, 30 May
 2023 21:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230530195132.2286163-1-bero@baylibre.com>
In-Reply-To: <20230530195132.2286163-1-bero@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 31 May 2023 12:49:43 +0800
Message-ID: <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        nfraprado@collabora.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:51=E2=80=AFAM Bernhard Rosenkr=C3=A4nzer <bero@ba=
ylibre.com> wrote:
>
> From: Balsam CHIHI <bchihi@baylibre.com>
>
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTe=
k MT8192 SoC.
> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> and update the documentation that describes the Calibration Data Offsets.
>
> Changelog:
>     v4 :
>         - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
>           room for SVS support, pointed out by
>           AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
>
>     v3 :
>         - Rebased :
>             base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>         - Fix issues in v2 pointed out by N=C3=ADcolas F. R. A. Prado <nf=
raprado@collabora.com>:
>           Use filtered mode to make sure threshold interrupts are trigger=
ed,

I'm seeing sensor readout (either through sysfs/thermal/<x>/temp or hwmon)
fail frequently on MT8192. If I run `sensors` (lm-sensors), at least a coup=
le
of the LVTS sensors would be N/A. Not sure if this is related to this chang=
e.


ChenYu

>           protocol documentation, cosmetics
>         - I (bero@baylibre.com) will be taking care of this patchset
>           from now on, since Balsam has left BayLibre. Thanks for
>           getting it almost ready, Balsam!
>
>     v2 :
>         - Based on top of thermal/linux-next :
>             base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
>         - Squash "add thermal zones and thermal nodes" and
>             "add temperature mitigation threshold" commits together to fo=
rm
>             "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal =
zones" commit.
>         - Add Suspend and Resume support to LVTS Driver.
>         - Update Calibration Data documentation.
>         - Fix calibration data offsets for mt8192
>             (Thanks to "Chen-Yu Tsai" and "N=C3=ADcolas F. R. A. Prado").
>         https://lore.kernel.org/all/20230425133052.199767-1-bchihi@baylib=
re.com/
>         Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
>     v1 :
>         - The initial series "Add LVTS support for mt8192" :
>             "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@b=
aylibre.com/".
>
> Balsam CHIHI (5):
>   dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
>     for mt8192
>   thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
>   thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
>   arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
>   thermal/drivers/mediatek/lvts_thermal: Update calibration data
>     documentation
>
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
>  drivers/thermal/mediatek/lvts_thermal.c       | 160 +++++-
>  .../thermal/mediatek,lvts-thermal.h           |  19 +
>  3 files changed, 631 insertions(+), 2 deletions(-)
>
> base-commit: 8c33787278ca8db73ad7d23f932c8c39b9f6e543
> --
> 2.41.0.rc2
>
