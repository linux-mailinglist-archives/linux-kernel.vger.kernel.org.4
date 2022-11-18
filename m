Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897A62FF54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKRVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKRVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:24:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB793CCE;
        Fri, 18 Nov 2022 13:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DA56271A;
        Fri, 18 Nov 2022 21:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFD1C433D7;
        Fri, 18 Nov 2022 21:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668806638;
        bh=mtZwhXDF+3XRcueQS8GYk6YH7EKVzSJYMCs2J1Z9w3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UVFQhAZqjkOPybZV3BjmP/iJkMwmr9Lxh0+VR7QSw3/urHqQsWdMq2Rv7RdzsiX9m
         +L33+3ggJZIy93hnHyXZJGm6SQsEaRO5gLPM3IoqcS44rBZUyz60+yS49Ec3N728yf
         oOFZlciWKy/Obldz0p/lby3+IgHP781G53t/Zmyrj+VvfNIQcXyNco8jGBg6BQf+fw
         96vyJzDAG5KvORkuZAPrT94bFCEPoPuJy10/g5HUBzbc+sQt/OjavPnC2hcXZF+6Gn
         scLP0yKZxzi01EWTWFpq50uqMbYrBDp+YMEtpLknZdaTLcKgVzSGmaiyv0p7xhp30j
         eg7oBw1yYcrDw==
Received: by mail-lf1-f50.google.com with SMTP id bp15so10193415lfb.13;
        Fri, 18 Nov 2022 13:23:58 -0800 (PST)
X-Gm-Message-State: ANoB5plEEP+wB/Uj9uzVg2h0C30PRQfhNHGkXlNhSvM/vpm4E39DaOYi
        jKAVBXwrsJ2avjKAi+MSZgh18/CEyrVu1ru5FA==
X-Google-Smtp-Source: AA0mqf7ABgqeOepd4ak9gVR8kmoWpiHBAjzq5UkfrGYgfyqi7atqrFjpIs7BhnC8Tf0F/GS6aAb0ind9WjfasW4imEE=
X-Received: by 2002:a05:6512:1291:b0:4af:eabf:3c57 with SMTP id
 u17-20020a056512129100b004afeabf3c57mr2774151lfs.449.1668806636064; Fri, 18
 Nov 2022 13:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20221106085034.12582-1-linux@fw-web.de> <20221106085034.12582-12-linux@fw-web.de>
 <5ece2b19-cbc7-5ecf-c29a-8f0258f260f4@gmail.com>
In-Reply-To: <5ece2b19-cbc7-5ecf-c29a-8f0258f260f4@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Nov 2022 15:23:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzM9y4pbN9UQpNENm9fB7-jGcch6n4w98eBuidL9rNsw@mail.gmail.com>
Message-ID: <CAL_JsqJzM9y4pbN9UQpNENm9fB7-jGcch6n4w98eBuidL9rNsw@mail.gmail.com>
Subject: Re: [RFC v3 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 3:16 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> Rob, Krzysztof,
>
> On 06/11/2022 09:50, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add devicetree overlays for using nand and nor on BPI-R3.

Overlays are necessary because ...?

> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
> >   .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts | 53 +++++++++++++++
> >   .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  | 67 +++++++++++++++++++
> >   3 files changed, 122 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index e8902f2cc58f..d42208c4090d 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
>
> Do we allow the inclusion of overlays in the kernel?
> I don't think so. I see there are some dtbos for some freescale platforms, but I
> wasn't aware that we support that. I thought it is all about dtsi includes.

Yes, we do.

> @frank In any case we would need to apply these overlays to some base board to
> create a valis dtb.

Indeed. The build system supports this and it's a requirement (though
not easily enforced) that overlays apply to something. It works much
like how kbuild combines multiple .o files into a module.

Please rename to .dtso though. I copied you all on the PR I just sent.

Rob
