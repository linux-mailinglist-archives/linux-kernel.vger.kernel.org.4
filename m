Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72014629F93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiKOQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKOQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:50:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8096302;
        Tue, 15 Nov 2022 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668531009;
        bh=8KBr+dIwP/E3nNmJhfiOtBZ1JSdlPyiU8UUhwKa1DSs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qOrFoIcZd8TjeDnJMhYqAJrSVirE4ig1f8tkGTZeV7s4nLlfwNpLhrPKgB2tIa5F+
         KUnSgPvx67kWVZF3ykn/VtwSVYpTsYm/bZ8ZcvW49J74zNcJSn1eMrM0+FudsjbimW
         6Bm2WtmBrvPoorwfiAh1W+AZ6wUt49YxlvJjcMufpCiCPCq7cGx00khkPR9hzPlncb
         u1XJ33Wb1RjbwJlJfQO2svUSzaG+2A+UkRy8a7WFj6eMssVWz9rveTXm6TTkWbmbLJ
         T9CcN6PcMZBApL3InbW75d98eBRUEYDB8OTnXvbGsrZZPikw5ByBeElqsi9SdiLVmA
         4Lem90/JQuFLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.186] ([217.61.148.186]) by web-mail.gmx.net
 (3c-app-gmx-bs03.server.lan [172.19.170.52]) (via HTTP); Tue, 15 Nov 2022
 17:50:09 +0100
MIME-Version: 1.0
Message-ID: <trinity-8aa3b798-0819-43e6-beef-f04dd821b664-1668531009359@3c-app-gmx-bs03>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [RFC v3 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor
 overlays
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 15 Nov 2022 17:50:09 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <5ece2b19-cbc7-5ecf-c29a-8f0258f260f4@gmail.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-12-linux@fw-web.de>
 <5ece2b19-cbc7-5ecf-c29a-8f0258f260f4@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:SQl+29+ImbUvKrSPHRXSWUbo2yuDKo4wgq4m9hI8/KdxHmt0dogqarVIDiBshOyUXu6KS
 PVlVkWH6vY85K4YqnQXo2XT5Y3b3MLWUsTTXAZorsBUMVCfJGv80gM0vdUzA0G5wNbhWH8S4RFa3
 xNHO8TVrsCFDhdGCQoxzMGA9MIpgblcJWWK4IlpLN9li2e6seCu5fLwYVwfsyt/rCa1h9F5IV5mM
 AXdg15jEhGJ512Ne6Wrw5i2PpexmhPHrvzieQbd397gnvz5L6868jlRWij68CNycqRrNZQZUCCxG
 TQ=
UI-OutboundReport: notjunk:1;M01:P0:mgoznSFtpkg=;qZru3duK4QSUWnNUEd/j4FW8s7z
 edoRdzgUFm8wr6wNkYtomyHg/m60LnXYJ9/xoSmPYjER8U9qCMkmt7m8v88O6AEQ60V0dWyet
 NA/YlkLL5w7n19/QqKBg9cZ887F4/1SLyfH3yXKviNTGcCFfmlQgr3LEozE7otAmJPSJci30i
 facc5D63urBbv1cs68BxsfcGWr8dVF/vvSev1C35090PUJ5+Kao25OppMqGJi6MmUJosAv8O9
 wNx87WAjjRQjI8QLkVBb0xinAvihij2RQoVwzdQtY/5Uhs1gQDmTOqHpvLQ0kYhCy3vtvTeDz
 xapdJzZ4phJ0J4THheYYlGUJ2MYlZ5WXoXbe7EFP2XHoaAMbNEmvBz4mRljHepi+YzQhQnR3h
 6aogZwbh1y8MIX7kcDLwZyosJTZ9efJZqvXrErB0TZLPNrzNRRZUCOIPv4MCPAH+dv/fCHsog
 239+fAv9FoYTdZm9McbJWIm2Kv7llKTTM2ltWKP39I7rwZNOmaiGx55NQJal+pGgmwFbIBxtb
 Jw5KGSTWH1oyBjqlL4DRpbnVHZqH9tjXn8z9JuPW6u/h9enb9KRidp4v88qHoa23XmB5p3mCI
 ru9Xt+h+yQ92jX2ZCbZ5CN6VmZyW/IWFQYQDe2jxXj6TLfnGkFeXaKgvlHQQ0QmZS6fIfP48j
 HymSdaiiSBmZGOMvVjjMPVIRfvsuR/z+85052gIfx7FXvUWBFCF36Ihb3g0eYPndYDWIML4wG
 ZHigqdfpk6W2+frrOqmOHHtlUIHzv2/xl1VLgctEuVpEmTZ8wQjLDyzug08VCfQlGWnObOM8F
 /QWuP/yKK/9ZUg/9ziLUnvDw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


> Gesendet: Freitag, 11. November 2022 um 10:16 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> An: "Frank Wunderlich" <linux@fw-web.de>, linux-mediatek@lists.infradead=
.org, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof=
.kozlowski+dt@linaro.org>
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, linux-arm-kernel@lists=
.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> Betreff: Re: [RFC v3 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor over=
lays
>
> Rob, Krzysztof,
>
> On 06/11/2022 09:50, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add devicetree overlays for using nand and nor on BPI-R3.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
> >   .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts | 53 +++++++++++++++
> >   .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  | 67 +++++++++++++++++=
++
> >   3 files changed, 122 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi=
-r3-nand.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi=
-r3-nor.dts
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/d=
ts/mediatek/Makefile
> > index e8902f2cc58f..d42208c4090d 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
>
> Do we allow the inclusion of overlays in the kernel?
> I don't think so. I see there are some dtbos for some freescale platform=
s, but I
> wasn't aware that we support that. I thought it is all about dtsi includ=
es.
>
> @frank In any case we would need to apply these overlays to some base bo=
ard to
> create a valis dtb.

yes of course, the "base board" is either the sd or the emmc fdt i added 1=
 patch before.
This way it allows all 4 combinations (sd+nand, sd+nor, emmc+nand, emmc+no=
r).

as i pointed in v4 of this Patch there is a commit in robs tree allow buil=
ding dt overlays
from dtso-files...

"kbuild: Allow DTB overlays to built from .dtso named source files"
    https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/=
?h=3Ddt/next&id=3D363547d2191cbc32ca954ba75d72908712398ff2

maybe this is the right way to go (rename my current dts to dtso)?

> Regards,
> Matthias

regards Frank
