Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149396D3C24
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDCDbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCDbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F9270F;
        Sun,  2 Apr 2023 20:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4F766143F;
        Mon,  3 Apr 2023 03:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD05C4339B;
        Mon,  3 Apr 2023 03:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680492670;
        bh=XFDJK+O6b4HFOKcAfQuQl4p4wuO9jnRvSF0HKVPNXU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EBroFlBh0WrZPTUY9gGFPwiazQ8rJqOdGs9OOSyDIbHaNW9O96+hKKrju6N6QCF2z
         QrQq3zXPsKwmUXkl5iYWQJIxFKVRgCyK6tXodZoRqiFpLikV3skwZhEQ+cVL3eaG8D
         A7MvEHopu0PIjEnID3ILp9ly/F2UopGpmMlGj44xZ2HyXw7NYcKd7rvpmQSyQLr3UP
         6nDzJT+lkinEi2v0e/V/WuOyt91zahDhRBJ536DPqTzjKvJkYnye9TetERuz6aCi9z
         dUOZaxyB8JVdvzOa8Mw6LNHs7FsuO+oBj4lZCeFCPSGGvvs05Hu3hedFP+hs99JF0G
         yoNO1CA6E1Zxg==
Received: by mail-lf1-f41.google.com with SMTP id q16so36207991lfe.10;
        Sun, 02 Apr 2023 20:31:10 -0700 (PDT)
X-Gm-Message-State: AAQBX9c2Cu6ypfGB0uWpN0nkBf0JDVCENw44H0VYHtDNiSWVpfh6nd/R
        jxdpTSWPO80Xdojq5u+uphzyjFI23hiCTOLihQ==
X-Google-Smtp-Source: AKy350b60je93Fp8ACgYD+IGmx2jUC2NXDaO2wPWl8QAhfUwxXgOh//lf4WQhYJln+d7xy3DKELl/d6gVGnR6WOBSc8=
X-Received: by 2002:a19:7419:0:b0:4d8:62e5:4f66 with SMTP id
 v25-20020a197419000000b004d862e54f66mr10062745lfe.7.1680492668344; Sun, 02
 Apr 2023 20:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230321121859.2355-1-nancy.lin@mediatek.com> <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
 <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
 <97a5f383-38f5-e8ea-e1d8-489b690e4521@collabora.com> <CAAOTY_9_vn-m2jTaaHkFDV+v2-LeaAxtCLNNnOxZq5Httb-TAQ@mail.gmail.com>
 <CAGXv+5FJCuG_zHnaKZ=baNzKAWKLEe3jZnghNAxuGv7i7L6e7Q@mail.gmail.com>
In-Reply-To: <CAGXv+5FJCuG_zHnaKZ=baNzKAWKLEe3jZnghNAxuGv7i7L6e7Q@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Apr 2023 11:30:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Dbtubah3ndj9+FeYDh7D42k6-BtHrYMNc=CP6GL6uFA@mail.gmail.com>
Message-ID: <CAAOTY_9Dbtubah3ndj9+FeYDh7D42k6-BtHrYMNc=CP6GL6uFA@mail.gmail.com>
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chen-yu:

Chen-Yu Tsai <wenst@chromium.org> =E6=96=BC 2023=E5=B9=B43=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Mar 27, 2023 at 11:17=E2=80=AFPM Chun-Kuang Hu <chunkuang.hu@kern=
el.org> wrote:
> >
> > Hi, Angelo:
> >
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =
=E6=96=BC
> > 2023=E5=B9=B43=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=
=884:38=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Il 24/03/23 00:25, Chun-Kuang Hu ha scritto:
> > > > Hi, Angelo:
> > > >
> > > > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
> =E6=96=BC
> > > > 2023=E5=B9=B43=E6=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=
=8D=884:58=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >>
> > > >> Il 21/03/23 13:18, Nancy.Lin ha scritto:
> > > >>> The hardware path of vdosys1 with DPTx output need to go through =
by several modules, such as, OVL_ADAPTOR and MERGE.
> > > >>>
> > > >>> Add DRM and these modules support by the patches below:
> > > >>>
> > > >>
> > > >> I've tested v30 again on MT8173, MT8192 and MT8195 based Chromeboo=
ks.
> > > >> Green light from me.
> > > >
> > > > I'm curious about how you build code and test on Chromebooks. Do yo=
u
> > > > build in cros environment or pure linux
> > > > (https://archlinuxarm.org/platforms/armv8/mediatek/acer-chromebook-=
r13).
> > > > I've a MT8183 based Chromebook (HP 11a) and I've tried to run a
> > > > upstream kernel on it. cros is too heavy for me and I doubt I could
> > > > use it. I've tried the pure linux and could boot up with console, b=
ut
> > > > display does not work. If you use the pure linux environment, could
> > > > you share how it works?
> > > >
> > >
> > > I haven't tested MT8183 (I don't actually have any 8183 machine in my=
 hands)... but
> > > yes, I can share my test environment.
> > >
> > > I have one MicroSD that I use either in the MicroSD slot of the targe=
t machine, or
> > > in a USB reader; this *single* system is what I boot on *all* Chromeb=
ooks that I
> > > have: one kernel, multiple devicetrees, same Debian-based userspace.
> > >
> > > What we have to prepare this bootable media can be found at [1], but =
beware that
> > > it currently uses an outdated kernel, so, what I have locally is a sy=
mlink to my
> > > kernel tree.
> > > You can change/add/remove the devicetree blobs that will get added to=
 the image
> > > by modifying `chromebook-setup.sh`; before tampering with kernel tree=
 symlink,
> > > please run that script for the first time, as it will download a cros=
s-compiler,
> > > a kernel tree (that you will replace for sure) and the (very old) Deb=
ian rootfs
> > > that you can update with `apt-get dist-upgrade` after booting the Chr=
omebook.
> > >
> > > If you want to check about possible kernel configuration differences,=
 what I use
> > > is at [2], so that you can compare.
> >
> > Thanks for the information, I would try to compare the kernel config fi=
rst.
>
> Hi CK,
>
> Would you consider adding your repo to linux-next? That would let everyon=
e
> do integration testing, especially automated ones, earlier, before you se=
nd
> your PRs to drm maintainers.
>
> You can do so by sending an email to Stephen Rothwell to do so.

I don't understand what this process is. Does it means that I directly
upstream patches into linux-next? I prefer that my patches go through
drm maintainers' tree. Does any document introduce this process?


Regards,
Chun-Kuang.

>
>
> ChenYu
>
> > >
> > > [1]: https://gitlab.collabora.com/google/chromebooks/-/tree/mtk-av1
> > > [2]:
> > > https://gitlab.collabora.com/google/chromeos-kernel/-/blob/mt8195-tra=
cking-master-rolling/arch/arm64/configs/defconfig
> > >
> > > Regards,
> > > Angelo
