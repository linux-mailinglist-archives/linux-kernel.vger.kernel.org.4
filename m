Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB86C7401
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCWXZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCWXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028486192;
        Thu, 23 Mar 2023 16:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F30A62813;
        Thu, 23 Mar 2023 23:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB38C433A0;
        Thu, 23 Mar 2023 23:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679613929;
        bh=4Ynyp+S9BGcwrttvmGqGTVkG9UhEwnTOcUptS58xcI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sP5/ZKwa6Umt3kpD6VyvTT5hdhT4RW6gecV7Vz2a8Hqr43gxXegzTHsSG5bZ9cdS1
         8Avk7eaLemhg9arURoRRBA8xH9YAqtLRirB6sKeIbzqU569YuKIxSQNopXfhWXA93M
         xwHTc6ZmxBioqxLf+5QehjpHEsX/GHIz5BVJzJ9DiqDmbA536QVV0L+vgDIFnigRRw
         /xyEykUNJEsxMwS1fm6oouxJ8JjxYeh0DWK6Jsbe7jU6dNh/jnebq0EBKIgCJ3XsPB
         K5diqlp12n+NkBvuzopEMNswpJcG15XKO0TxntF8XtSmAOFKL96GMhndDAyr37wOKs
         JP6U6VbrV9z9w==
Received: by mail-lf1-f44.google.com with SMTP id j11so29821693lfg.13;
        Thu, 23 Mar 2023 16:25:28 -0700 (PDT)
X-Gm-Message-State: AAQBX9eJgtBubHIlj3i3OgOIzeuOTV59cRmYkhRuV0XPZZoBdMf5vkoZ
        j2Z8/We1N/xRSDKYwypCzZ2RDxRklPUkBm3NXw==
X-Google-Smtp-Source: AKy350bWHhQk1T3i2SqgUwf/TTiR6ou0itybGLCJUXytufGSnho4rPHLFcQzemcdLX6NIoPVcTsCovZ4emivLFiFZb4=
X-Received: by 2002:ac2:5639:0:b0:4dd:9931:c555 with SMTP id
 b25-20020ac25639000000b004dd9931c555mr273032lff.0.1679613926916; Thu, 23 Mar
 2023 16:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230321121859.2355-1-nancy.lin@mediatek.com> <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
In-Reply-To: <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 24 Mar 2023 07:25:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
Message-ID: <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
2023=E5=B9=B43=E6=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:5=
8=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 21/03/23 13:18, Nancy.Lin ha scritto:
> > The hardware path of vdosys1 with DPTx output need to go through by sev=
eral modules, such as, OVL_ADAPTOR and MERGE.
> >
> > Add DRM and these modules support by the patches below:
> >
>
> I've tested v30 again on MT8173, MT8192 and MT8195 based Chromebooks.
> Green light from me.

I'm curious about how you build code and test on Chromebooks. Do you
build in cros environment or pure linux
(https://archlinuxarm.org/platforms/armv8/mediatek/acer-chromebook-r13).
I've a MT8183 based Chromebook (HP 11a) and I've tried to run a
upstream kernel on it. cros is too heavy for me and I doubt I could
use it. I've tried the pure linux and could boot up with console, but
display does not work. If you use the pure linux environment, could
you share how it works?

Regards,
Chun-Kuang.

>
> Chun-Kuang, can you please pick it?
>
> Thanks!
> Angelo
>
