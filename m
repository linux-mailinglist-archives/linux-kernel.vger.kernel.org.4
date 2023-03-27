Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79016CA8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjC0PRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjC0PRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C6199;
        Mon, 27 Mar 2023 08:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 679AEB81616;
        Mon, 27 Mar 2023 15:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7CEC4339B;
        Mon, 27 Mar 2023 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679930240;
        bh=WxXjXDVt250Dzp30WluOUfbIb760o1vY2QBgR+3iufI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DgSCKdzHtd3A8JummnAbCF0GnDlwtgZE6oSuVEtby2k6dFHawi07+eYzwPhFI/zPn
         1IqdQXp31wiy/gxtYX6xIXwHsgB7dDWGbPo6yynzdtMX0Vzh+sZ7ApcD4v6Hrd7yJM
         xTrafTzK5Qq9V8l3zkkyJ+yxFjRh4x26wz388XcMmrfyf1YhaCvtQo9lmQT6pcvAcA
         bMYMFdx1Gz2tsb/AYwR47c26nxs8JIX5KkB8g9NdHo8PqeB5MQ2sLpGsRviMSYsdYc
         EOg4Jv1ldxV8sUCYxJzAt8ZpOKQIeoGcrTIh8+8rqmOATAeYbhPniEhhLGy8a0zYPU
         3q5KeUrdBoIzg==
Received: by mail-lj1-f177.google.com with SMTP id a21so2236083ljq.10;
        Mon, 27 Mar 2023 08:17:20 -0700 (PDT)
X-Gm-Message-State: AAQBX9eKZiCt8jkD65xvwQRbwQzJaPlvkKpdZCmq38zpKkFuoJIO5YKM
        JpMFjo0tDRA5eqN6dJ+cNglT4X2mBkK/mytx/Q==
X-Google-Smtp-Source: AKy350ZJD8lXrATp34gVJQNtWOp95oG2v0KcgMEyjZm8N9VS0wqsbCWLENkFgqU2pL5ANEjL4W1+rI8dl98MGCb+WEw=
X-Received: by 2002:a2e:a304:0:b0:2a1:627a:70bb with SMTP id
 l4-20020a2ea304000000b002a1627a70bbmr3582823lje.10.1679930238193; Mon, 27 Mar
 2023 08:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230321121859.2355-1-nancy.lin@mediatek.com> <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
 <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com> <97a5f383-38f5-e8ea-e1d8-489b690e4521@collabora.com>
In-Reply-To: <97a5f383-38f5-e8ea-e1d8-489b690e4521@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 27 Mar 2023 23:17:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9_vn-m2jTaaHkFDV+v2-LeaAxtCLNNnOxZq5Httb-TAQ@mail.gmail.com>
Message-ID: <CAAOTY_9_vn-m2jTaaHkFDV+v2-LeaAxtCLNNnOxZq5Httb-TAQ@mail.gmail.com>
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        CK Hu <ck.hu@mediatek.com>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2023=E5=B9=B43=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:3=
8=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 24/03/23 00:25, Chun-Kuang Hu ha scritto:
> > Hi, Angelo:
> >
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =
=E6=96=BC
> > 2023=E5=B9=B43=E6=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=
=884:58=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Il 21/03/23 13:18, Nancy.Lin ha scritto:
> >>> The hardware path of vdosys1 with DPTx output need to go through by s=
everal modules, such as, OVL_ADAPTOR and MERGE.
> >>>
> >>> Add DRM and these modules support by the patches below:
> >>>
> >>
> >> I've tested v30 again on MT8173, MT8192 and MT8195 based Chromebooks.
> >> Green light from me.
> >
> > I'm curious about how you build code and test on Chromebooks. Do you
> > build in cros environment or pure linux
> > (https://archlinuxarm.org/platforms/armv8/mediatek/acer-chromebook-r13)=
.
> > I've a MT8183 based Chromebook (HP 11a) and I've tried to run a
> > upstream kernel on it. cros is too heavy for me and I doubt I could
> > use it. I've tried the pure linux and could boot up with console, but
> > display does not work. If you use the pure linux environment, could
> > you share how it works?
> >
>
> I haven't tested MT8183 (I don't actually have any 8183 machine in my han=
ds)... but
> yes, I can share my test environment.
>
> I have one MicroSD that I use either in the MicroSD slot of the target ma=
chine, or
> in a USB reader; this *single* system is what I boot on *all* Chromebooks=
 that I
> have: one kernel, multiple devicetrees, same Debian-based userspace.
>
> What we have to prepare this bootable media can be found at [1], but bewa=
re that
> it currently uses an outdated kernel, so, what I have locally is a symlin=
k to my
> kernel tree.
> You can change/add/remove the devicetree blobs that will get added to the=
 image
> by modifying `chromebook-setup.sh`; before tampering with kernel tree sym=
link,
> please run that script for the first time, as it will download a cross-co=
mpiler,
> a kernel tree (that you will replace for sure) and the (very old) Debian =
rootfs
> that you can update with `apt-get dist-upgrade` after booting the Chromeb=
ook.
>
> If you want to check about possible kernel configuration differences, wha=
t I use
> is at [2], so that you can compare.

Thanks for the information, I would try to compare the kernel config first.

>
> [1]: https://gitlab.collabora.com/google/chromebooks/-/tree/mtk-av1
> [2]:
> https://gitlab.collabora.com/google/chromeos-kernel/-/blob/mt8195-trackin=
g-master-rolling/arch/arm64/configs/defconfig
>
> Regards,
> Angelo
