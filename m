Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C985269F078
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjBVIjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:39:36 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068701CAC0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:39:35 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id o6so8006354vsq.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dmszevi2SksTWD2ubcICrn01x9b0o7eFEQpxMDnqSAk=;
        b=em4VVRc2okwRN3SQHzajqxgirZ/Imo8edo1OC+ktYXzjmKrRYasm0n9PVupus++Icp
         6GWdGZIKZNg7GzwyuGcWREv+Elvk8JiNhCCcTFJT6BuqxpoYHSEcaUfRSk6rBbUy3NYb
         ThcqWvbcTjsO7bJAETYYb5RiVmz0OWMt4SqkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmszevi2SksTWD2ubcICrn01x9b0o7eFEQpxMDnqSAk=;
        b=SMsZrWtHwocivw5o+1eylamc9/egnwUqBWGDiSDawZISG8LRFfmjzaZ5+Tn21oUZcq
         HgLDeEpwOiupAyPcXGdbIlihOMYHpAznZBAj391REAeXSepzDpfrJSx+8Ih/IPzUzxwg
         b0GLLwLtSbsBzYJoN8oX/RseaObUkgFhE/fdRr4BHzagNLTVgKVLJdqTBS7t33AOcIxv
         Atx2spE1sXIKwEc68T0Kc9uVHPSHXta1mtELKpE8iPBtuJSIB1i3CFuRjfFvecycdMz/
         xJkkoTkJkv/hZTf6Ch/byGn+hoHM649c29zTo3d3q33XhfdJQ5EuCIA2nxQuUnj4prsx
         x2+w==
X-Gm-Message-State: AO0yUKU2srlasezRcHhI7Nj3ICiw9vYCRYs27mjXZ+AzpO0EEY595zy6
        YAzR4C49JIyg3+lYi3UR8jixoBvbT9cgT/AVgzO4rw==
X-Google-Smtp-Source: AK7set82JgoEJwmJ5PvwiX+SnPjQIuZJcVlZYYzuz1but6a8Se983ORppZPhV01+jbcYZHkfkMc5ZWYwUsQab1btvKQ=
X-Received: by 2002:a05:6102:570b:b0:3fc:58d:f90f with SMTP id
 dg11-20020a056102570b00b003fc058df90fmr1572193vsb.60.1677055174148; Wed, 22
 Feb 2023 00:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <Y/XKhg+wultVbEWW@google.com>
In-Reply-To: <Y/XKhg+wultVbEWW@google.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 16:39:23 +0800
Message-ID: <CAGXv+5GV2BuQW+XDBzpiWwXDBi0zbjA4dF3_rD62y+B_qK_xOg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Panfrost: Improve and add MediaTek SoCs support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 3:55 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Tue, Feb 21, 2023 at 04:37:30PM +0100, AngeloGioacchino Del Regno wrote:
> > Changes in v2:
> >  - Add power-domain-names commit from Chen-Yu to the series
> >  - Kept sram-supply in base schema, overridden for non-MediaTek
> >  - Added Reviewed-by tags from Steven Price to the driver commits
> >    (as released in reply to v1's cover letter - thanks!)
> >
> > This series adds support for new MediaTek SoCs (MT8186/MT8192/MT8195)
> > and improves MT8183 support: since the mtk-regulator-coupler driver
> > was picked, it is now useless for Panfrost to look for, and manage,
> > two regulators (GPU Vcore and GPU SRAM) on MediaTek;
> >
> > The aforementioned driver will take care of keeping the voltage
> > relation (/constraints) of the two regulators on its own when a
> > voltage change request is sent to the Vcore, solving the old time
> > issue with not working DVFS on Panfrost+MediaTek (due to devfreq
> > supporting only single regulator).
> >
> > In the specific case of MT8183, in order to not break the ABI, it
> > was necessary to add a new compatible for enabling DVFS.
> >
> > Alyssa Rosenzweig (3):
> >   drm/panfrost: Increase MAX_PM_DOMAINS to 5
> >   drm/panfrost: Add the MT8192 GPU ID
> >   drm/panfrost: Add mediatek,mt8192-mali compatible
> >
> > AngeloGioacchino Del Regno (6):
> >   dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains
> >     variation
> >   dt-bindings: gpu: mali-bifrost: Allow up to 5 power domains for MT8192
> >   dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
> >   dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
> >   dt-bindings: gpu: mali-bifrost: Add a compatible for MediaTek MT8186
> >   drm/panfrost: Add new compatible for Mali on the MT8183 SoC
> >
> > Chen-Yu Tsai (1):
> >   dt-bindings: gpu: mali-bifrost: Add power-domain-names to base schema
> >
> >  .../bindings/gpu/arm,mali-bifrost.yaml        | 67 ++++++++++++++++++-
> >  drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
> >  drivers/gpu/drm/panfrost/panfrost_drv.c       | 28 ++++++++
> >  drivers/gpu/drm/panfrost/panfrost_gpu.c       |  8 +++
> >  4 files changed, 101 insertions(+), 4 deletions(-)
>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> on MT8183, MT8186, MT8192, MT8195 with glmark2.

Note: the MT8186 was tested with incorrect bindings with one extra power
domain, but that doesn't affect functionality.
