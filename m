Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B856A1256
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBWVyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBWVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:54:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FD3D092;
        Thu, 23 Feb 2023 13:54:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j3so8132394wms.2;
        Thu, 23 Feb 2023 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cnf188iR/tvAsm2WYE+b4Ycz9c+bAZHE51WtPBLYK6Q=;
        b=MhW4haD4Lhbbin77nq10waiTDTz/XAwM3yIxnPpqoG6rxtyRhy7aaDuoOehGwWAl41
         8U/V5TSuHWNpvL/kz9e/A4V/6AXYmulmKZamzTNukbdVmHsh2xy1WnYBZ8XojDQrHi4G
         graY2OIRAUGPdNh/K2Cm3AAo6pFqTrPOaf21wrS+G0NV3CJV9WkzBWuDrpu6RVVrysWM
         KC1i2VA+2a/Y0O80EUjVeXUtw8jrl6ztXX5NJVphir4GSh/H85IOFVu3OQi4I7cO6Qos
         dyPWvckd1fBTTMNUSuljpIIZyBymCuL5dlLTieCpbf2hB5NzE6Uvo8nM3O3RMo4K+Pq8
         brmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnf188iR/tvAsm2WYE+b4Ycz9c+bAZHE51WtPBLYK6Q=;
        b=fv8aZelsvMHE4KsOzGb+gBHzdJIY5Q34McnCSpx3WhX6ToKAG1dlHtL/7k5cS+ICL8
         +VAo5VoJxQyBiSCVLLYwJPVMQm6SMllYroFGs7mhmXxro0qAQanQnDf9NoJTpdAdBDXS
         tN7Dp1z9Wvdeom+vV/IciRg+1UIUYPQbwSE/C0/apk9OLrgae3lJlCZhsiyr/kYlhs8p
         JQYa/mv9LwPNjiSKkjAV0yhFkasXvagjVb3bQsASikmOIJJq1Ckj97V0FN+P1tWzxUpS
         4VzmxZ93M5/c4JbLclwddF758rsU/94ihnhDdjKzmZMktHvKpTtSWvYGRBX3bQJvjdPW
         ELCw==
X-Gm-Message-State: AO0yUKVhx3VMiRFEl8nYBSCRlSFP00Nn019i/0B+c7cYUuTddGIge+Pt
        BgyJ4g8rVYdWFG+Uv1n+Od2QBwaRDZh2jpZzbq4=
X-Google-Smtp-Source: AK7set/Y607YByKtpt2CfjK1Grnqn9NwL8hFS+0E7zqzm/O5s4grTI4xHe+wh1+ct/hTKg5jMqICYlZ57I+vdf/+Ml4=
X-Received: by 2002:a05:600c:1c89:b0:3e2:669:f04e with SMTP id
 k9-20020a05600c1c8900b003e20669f04emr589797wms.2.1677189246968; Thu, 23 Feb
 2023 13:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20230215010914.104754-1-frattaroli.nicolas@gmail.com>
 <CAMdYzYrZvHLFdhn_qYadYbDDnnC+16pkM_kWXiU16u_6XNHEMg@mail.gmail.com> <5650057.DvuYhMxLoT@archbox>
In-Reply-To: <5650057.DvuYhMxLoT@archbox>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 23 Feb 2023 16:53:53 -0500
Message-ID: <CAMdYzYrQRmOu_Q5n0t=TV2EZE9jh1OKqy5h5nnRt4NO+QDixJQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Always enable sd regulator on
 SOQuartz CM4IO
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:53 AM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> On Thursday, 23 February 2023 01:29:39 CET Peter Geis wrote:
> > On Tue, Feb 14, 2023 at 8:09 PM Nicolas Frattaroli
> >
> > <frattaroli.nicolas@gmail.com> wrote:
> > > The 3.3V line coming from the SDMMC regulator is required for USB
> > > on the CM4IO board. Without it, the USB mux (U13 in the CM4IO
> > > schematic[1]) that's used likely remains unpowered, and no USB
> > > devices show up.
> > >
> > > The consequence of this was the behaviour of an inserted SD card
> > > allowing USB to work, while pulling it out turned off all USB
> > > devices.
> > >
> > > [1]: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
> >
> > I disagree with this. According to the datasheet u13 and half a dozen
> > other devices are powered by 3.3v sourced from the SOM. sdmmc_pwr
> > triggers SD_PWR_ON which serves only to provide an enable signal to
> > u18, the regulator that powers the sdmmc slot from the same 3.3v. If
> > you are having problems with USB working, you likely have something
> > else going wrong here.
> >
> > Very Respectfully,
> > Peter Geis
>
> Hello,
>
> I don't see how else the observed behaviour would be triggered.
> As far as I can tell, the sdmmc_pwr regulator is the name of the
> 3.3V regulator on the SOM, which is what powers the 3.3V on the
> USB mux chip.
>
> Do you have an alternate explanation for why this patch works?

If you have the new variant of the SoQuartz, that pin is no longer
sdmmc power and now feeds nEXTRST. As the variant I built this device
tree from was not the final production version and is only operated by
a few individuals (such as myself) you should probably just adjust
this to the production variant.

On the production variant the sdmmc power pin is pulled high to 3.3v
and cannot be controlled, which lead to the issues observed with the
prototype model a baseboard.

Very Respectfully,
Peter Geis

>
> Kind regards,
> Nicolas Frattaroli
>
> >
> > > Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
> > > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > ---
> > >
> > >  arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts index
> > > 263ce40770dd..88a61fa8a95c 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > > @@ -135,6 +135,12 @@ &sdmmc0 {
> > >
> > >  };
> > >
> > >  &sdmmc_pwr {
> > >
> > > +       /*
> > > +        * USB also needs this regulator to work on this board, so just
> > > enable +        * it unconditionally.
> > > +        */
> > > +       regulator-always-on;
> > > +       regulator-boot-on;
> > >
> > >         regulator-min-microvolt = <3300000>;
> > >         regulator-max-microvolt = <3300000>;
> > >         status = "okay";
> > >
> > > --
> > > 2.39.1
>
>
>
>
