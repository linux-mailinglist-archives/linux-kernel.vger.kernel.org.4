Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AD6A0295
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjBWFx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBWFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:53:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E2F1A679;
        Wed, 22 Feb 2023 21:53:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j3so5643559wms.2;
        Wed, 22 Feb 2023 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIE7hufsSbKuNwaFsaytTS8k6a2M1BYo5pYvgxLxqXE=;
        b=I16GTOw4FM/vGX4+wCwDrLko7pcHTbGCtFJg8HBHe6UK5qOYL3PbXWr9IQNp0zauD3
         WqYzVw4MLNEq5ppf/N1YGhdTGJZS6Upcpg0jGc9W/eWgvESX/o2p7qomB0BUct+8ktRl
         7KL7lMzdlO7HGWQgbDD5sV2cf4tPR/eqB09irVAQ7u83RGvFhwQ1dHocuZLDO+HQogAq
         i10HhXcYnLA5zqSs6JRg0fXy6oujq8roOj2lsgqejpeG/wX57AKxOpPKJomPlwhhRPzX
         zieb9918GkfN5aNWQAaMymO2WDGQ+4RPztTDJ0fM5gJnaGaSZoLsJonzuVIQrROQ7oR2
         j65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIE7hufsSbKuNwaFsaytTS8k6a2M1BYo5pYvgxLxqXE=;
        b=qKfA/+aDoOXar619LnEFjKBIfZClCHOoCP7XCOIv6BATvb4ggOIEsekjtNawuYkc3N
         UrGNhQGH2pzZ+/EcfZCSTa/Z6BAdloKCr5KIzRiwVIl2i5eCiijc9H/N8wxsAvhN3fQa
         f5O+CyXFlCWaXYA3qQqCwfOFKVG73W27uevaYbx5jIaF5RyiRFKDsQqC7sYHc9naey+x
         iw8b6KgG9lBoXVQqP2ZHJf/gPeWjAztFOAyHXajC15q9VmxJWk65apPCtja8vtkkT0CY
         erLhiDDfKXZcCewyNpExa0yeNhd8fCfrl8ZVppIlZuCs03uI2j5BwqvCi6kWTobqYkQU
         r2pQ==
X-Gm-Message-State: AO0yUKUmLUmLKnRXyKPJ2lw6oKI4wScy+SmAtsrPRATDfJxQrp53mwk6
        abtY7Ms5VMzWesGr9rzMmJQ=
X-Google-Smtp-Source: AK7set/AKL3By9kKMpvCotw3uE4y086FOyp2pYHkH2A/CxhsuP3GBnXDtH2yipsiGG8Mh3hm+IZCwA==
X-Received: by 2002:a05:600c:2e94:b0:3e0:6c4:6a38 with SMTP id p20-20020a05600c2e9400b003e006c46a38mr2149186wmn.33.1677131603059;
        Wed, 22 Feb 2023 21:53:23 -0800 (PST)
Received: from archbox.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003e209186c07sm10039640wml.19.2023.02.22.21.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 21:53:22 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Always enable sd regulator on SOQuartz
 CM4IO
Date:   Thu, 23 Feb 2023 06:53:21 +0100
Message-ID: <5650057.DvuYhMxLoT@archbox>
In-Reply-To: <CAMdYzYrZvHLFdhn_qYadYbDDnnC+16pkM_kWXiU16u_6XNHEMg@mail.gmail.com>
References: <20230215010914.104754-1-frattaroli.nicolas@gmail.com>
 <CAMdYzYrZvHLFdhn_qYadYbDDnnC+16pkM_kWXiU16u_6XNHEMg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 23 February 2023 01:29:39 CET Peter Geis wrote:
> On Tue, Feb 14, 2023 at 8:09 PM Nicolas Frattaroli
> 
> <frattaroli.nicolas@gmail.com> wrote:
> > The 3.3V line coming from the SDMMC regulator is required for USB
> > on the CM4IO board. Without it, the USB mux (U13 in the CM4IO
> > schematic[1]) that's used likely remains unpowered, and no USB
> > devices show up.
> > 
> > The consequence of this was the behaviour of an inserted SD card
> > allowing USB to work, while pulling it out turned off all USB
> > devices.
> > 
> > [1]: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
> 
> I disagree with this. According to the datasheet u13 and half a dozen
> other devices are powered by 3.3v sourced from the SOM. sdmmc_pwr
> triggers SD_PWR_ON which serves only to provide an enable signal to
> u18, the regulator that powers the sdmmc slot from the same 3.3v. If
> you are having problems with USB working, you likely have something
> else going wrong here.
> 
> Very Respectfully,
> Peter Geis

Hello,

I don't see how else the observed behaviour would be triggered.
As far as I can tell, the sdmmc_pwr regulator is the name of the
3.3V regulator on the SOM, which is what powers the 3.3V on the
USB mux chip.

Do you have an alternate explanation for why this patch works?

Kind regards,
Nicolas Frattaroli

> 
> > Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts index
> > 263ce40770dd..88a61fa8a95c 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > @@ -135,6 +135,12 @@ &sdmmc0 {
> > 
> >  };
> >  
> >  &sdmmc_pwr {
> > 
> > +       /*
> > +        * USB also needs this regulator to work on this board, so just
> > enable +        * it unconditionally.
> > +        */
> > +       regulator-always-on;
> > +       regulator-boot-on;
> > 
> >         regulator-min-microvolt = <3300000>;
> >         regulator-max-microvolt = <3300000>;
> >         status = "okay";
> > 
> > --
> > 2.39.1




