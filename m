Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D426D0275
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjC3LF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjC3LFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:05:25 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F629139
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:05:24 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id s23so13481334uae.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680174323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBDBg0HH1y2Gx5yNNGEH03tfCHf1/oZeA1OHg/lrfwY=;
        b=AGTDkYKmFIkU7h3W8pUDAThR19VjWhlbEZrEPvdb2Yx2vCg94ZjAqrG6KdUMC8h8K9
         maVYRHf3bch+/BMgpjdex5tmMlxiaHr9BpXNIAMOOceA02T9oM2ZGmhDxqSEzYWNVdql
         UsNbJGx8nES0tVzze1xqgvpmHa7rthlXUKm+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680174323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBDBg0HH1y2Gx5yNNGEH03tfCHf1/oZeA1OHg/lrfwY=;
        b=ttgwKfeaWghPyHJxb2cSErx6RX2rKFARxlZf5t8sIV1TMKOxx+qQk5154PpYHZmK6o
         gf52icQjF371flbltNyu5/2PhYY36HnY6CqImOXKgSICDvnwHIwsv0autCBTmlIK6O7z
         f62r2UtHDj6Ta5GN9LAxQ1cyDqXK/ilvIuQkEqqjdzaH/630/EahQtbJohC56KU7ZxmK
         +sw4z5/axEI6NGWmOIlfkAocJWkF44lrT17guGYC+5jhW06qUgxNkgZ/U1l+EkyZt7ji
         i7wpqbLqOVoKK9tgT6nZewFE2m/QiqxgSVutqWd/zKPoHQ8Lg/FcgoTRH4M6TSvEP+V1
         p5AA==
X-Gm-Message-State: AAQBX9cy9d2QbO84fruJSfP1/Jh/IvNCZvLaZ1vKZ0O8n6ttIrFmdMoz
        nuxHw5a7YYUVOwLxr8jPFRXAduCfcv9i+6zZtwpOXw==
X-Google-Smtp-Source: AKy350bewD4+8aznFs09qngdmj+I714IP108YtnCD/KyMgmvOAvShWr4aIllQZPLnAcwidqQtErpuKM8c+DotdjwoF4=
X-Received: by 2002:ab0:2019:0:b0:765:8f29:d679 with SMTP id
 v25-20020ab02019000000b007658f29d679mr3245687uak.1.1680174323569; Thu, 30 Mar
 2023 04:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230321121859.2355-1-nancy.lin@mediatek.com> <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
 <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
 <97a5f383-38f5-e8ea-e1d8-489b690e4521@collabora.com> <CAAOTY_9_vn-m2jTaaHkFDV+v2-LeaAxtCLNNnOxZq5Httb-TAQ@mail.gmail.com>
In-Reply-To: <CAAOTY_9_vn-m2jTaaHkFDV+v2-LeaAxtCLNNnOxZq5Httb-TAQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 30 Mar 2023 19:05:12 +0800
Message-ID: <CAGXv+5FJCuG_zHnaKZ=baNzKAWKLEe3jZnghNAxuGv7i7L6e7Q@mail.gmail.com>
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, singo.chang@mediatek.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        clang-built-linux@googlegroups.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:17=E2=80=AFPM Chun-Kuang Hu <chunkuang.hu@kernel=
.org> wrote:
>
> Hi, Angelo:
>
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=
=96=BC
> 2023=E5=B9=B43=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884=
:38=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Il 24/03/23 00:25, Chun-Kuang Hu ha scritto:
> > > Hi, Angelo:
> > >
> > > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =
=E6=96=BC
> > > 2023=E5=B9=B43=E6=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=
=884:58=E5=AF=AB=E9=81=93=EF=BC=9A
> > >>
> > >> Il 21/03/23 13:18, Nancy.Lin ha scritto:
> > >>> The hardware path of vdosys1 with DPTx output need to go through by=
 several modules, such as, OVL_ADAPTOR and MERGE.
> > >>>
> > >>> Add DRM and these modules support by the patches below:
> > >>>
> > >>
> > >> I've tested v30 again on MT8173, MT8192 and MT8195 based Chromebooks=
.
> > >> Green light from me.
> > >
> > > I'm curious about how you build code and test on Chromebooks. Do you
> > > build in cros environment or pure linux
> > > (https://archlinuxarm.org/platforms/armv8/mediatek/acer-chromebook-r1=
3).
> > > I've a MT8183 based Chromebook (HP 11a) and I've tried to run a
> > > upstream kernel on it. cros is too heavy for me and I doubt I could
> > > use it. I've tried the pure linux and could boot up with console, but
> > > display does not work. If you use the pure linux environment, could
> > > you share how it works?
> > >
> >
> > I haven't tested MT8183 (I don't actually have any 8183 machine in my h=
ands)... but
> > yes, I can share my test environment.
> >
> > I have one MicroSD that I use either in the MicroSD slot of the target =
machine, or
> > in a USB reader; this *single* system is what I boot on *all* Chromeboo=
ks that I
> > have: one kernel, multiple devicetrees, same Debian-based userspace.
> >
> > What we have to prepare this bootable media can be found at [1], but be=
ware that
> > it currently uses an outdated kernel, so, what I have locally is a syml=
ink to my
> > kernel tree.
> > You can change/add/remove the devicetree blobs that will get added to t=
he image
> > by modifying `chromebook-setup.sh`; before tampering with kernel tree s=
ymlink,
> > please run that script for the first time, as it will download a cross-=
compiler,
> > a kernel tree (that you will replace for sure) and the (very old) Debia=
n rootfs
> > that you can update with `apt-get dist-upgrade` after booting the Chrom=
ebook.
> >
> > If you want to check about possible kernel configuration differences, w=
hat I use
> > is at [2], so that you can compare.
>
> Thanks for the information, I would try to compare the kernel config firs=
t.

Hi CK,

Would you consider adding your repo to linux-next? That would let everyone
do integration testing, especially automated ones, earlier, before you send
your PRs to drm maintainers.

You can do so by sending an email to Stephen Rothwell to do so.


ChenYu

> >
> > [1]: https://gitlab.collabora.com/google/chromebooks/-/tree/mtk-av1
> > [2]:
> > https://gitlab.collabora.com/google/chromeos-kernel/-/blob/mt8195-track=
ing-master-rolling/arch/arm64/configs/defconfig
> >
> > Regards,
> > Angelo
