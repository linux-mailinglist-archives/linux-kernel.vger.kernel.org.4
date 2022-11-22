Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B2633EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiKVOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiKVOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:20:02 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF8490A1;
        Tue, 22 Nov 2022 06:19:59 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13bd2aea61bso17450087fac.0;
        Tue, 22 Nov 2022 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olwZKFl2athJn9nMwix536ApeQ4JpegKpzu1195Yuqc=;
        b=E4E645lRvjqpHR6BM1KSr9GlSJHjaANcQD1JcsXwhCwSMLJYvno5IOd0QP9UxuZylL
         xwriYhCRZ/pAmoJJ3Ee76dmvoTllOj2GcK3+EC0oxoMw+wleinUeDxyNr0CU4k1dwod0
         3BOkrhqK4fPdAf85bl+NAnMm25b2P/RZSKF4JcdLVsm/LxI4qlYYYAZIl11iCMlppvvY
         s6ADax9Hdc6LvubQWZ1ExYwlo0yvPgY+TW+1p6wB9jhVkyPMPo2OFDSvMaSJrq3jddzi
         7yyDtjk1i1seK0uzIUh20QIF5OtfYwasJty3hKB8W51pM21RDT4dHrs/+WXzxXpxr5VI
         8GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olwZKFl2athJn9nMwix536ApeQ4JpegKpzu1195Yuqc=;
        b=o3kcKHPA9VbGy+EBuExKwuXTtY3kzTw+cbLBTjbygYwjSEaz+YxAunO+ljabWP9Htm
         koRft5T3vm0V32OftioSWBkbbGtGhNLnKOM91SAk6X2NdbEA7+Zzc7HdHdAHT8ppIDfS
         PHkixBY5fIYfQD8ly8DdsksOCnsMxiVrv9fXnhvl9MAdPYoIkOBHuV9NJFubb9nHmHJ0
         vx6CfLFrhi0vFygsOrhN6UjZD+9qD7hCI97uHlSxKVYyeJUAz21YbDUyhiP2IkpdqcsM
         dkQQDJ9+cyMzcCa5MnztVv8q8X9v55MWreCbESQ9dnX570h3seXoTXr1qDfllaluTIon
         wccA==
X-Gm-Message-State: ANoB5ploypmMT6/sCCbjtSNGoo/hjG7utM/O73bFzTfq2mRuTxVfNreG
        qC0umdy9p6p/e7ZUJLyWvYke4GnlFUw6mz5Z5ewbTzOf4fk=
X-Google-Smtp-Source: AA0mqf4Tjfo5YsLTERtRVJPp6OcUhHkLMdtZx0ItZ1HKzJH4z9rYUOhVjY6tAzCFhefbIqLBBmHxI4jLk6WR/WdLgPM=
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr3235958oab.35.1669126798955; Tue, 22
 Nov 2022 06:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-2-linux.amoon@gmail.com>
 <bdcd2071-8f56-b829-7e78-3fc9efec09fc@wolfvision.net> <CANAwSgQkwXb0KE+1856egmUyTx_pmr9hq6nk8-0YoMQJdBoDvQ@mail.gmail.com>
 <CAMdYzYp6GPO_mz=ctR7Pgs1iwtNjR0a6_0K492Fy=i55T9DMnQ@mail.gmail.com>
In-Reply-To: <CAMdYzYp6GPO_mz=ctR7Pgs1iwtNjR0a6_0K492Fy=i55T9DMnQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 22 Nov 2022 19:49:42 +0530
Message-ID: <CANAwSgQnSPGQFwtNHBBmxngOxHeUKYVA2pWOfqKMCx85bYGn9g@mail.gmail.com>
Subject: Re: [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A SBC.
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
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

Hi Peter / Michael

On Fri, 18 Nov 2022 at 23:43, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Fri, Nov 18, 2022 at 4:35 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Michael,
> >
> > On Fri, 18 Nov 2022 at 12:33, Michael Riesch
> > <michael.riesch@wolfvision.net> wrote:
> > >
> > > Hi Anand,
> > >
> > > On 11/16/22 21:01, Anand Moon wrote:
> > > > On rk356x ethernet phy support reduced media independent interface (RMII)
> > > > and reduced gigabit media independent interface (RGMII).
> > > > So set the phy mode to rgmii to support clock delay, also
> > > > add TX and RX delay for phy-mode.
> > >
> > > Based on this commit message I still don't understand what you are
> > > actually trying to fix here. If you encounter network problems/stability
> > > issues, please let me know what test triggers the faulty behavior.
> > > Please describe the problem you are facing in detail here or in the
> > > cover letter.
> > >
> >
> > Ok, Ethernet does not work on my Radxa 3A see boot logs.
> >
> > [0] https://gist.github.com/moonlinux/bb56c787031226fbb9f69121564e76a2
> >
> > Please find this updated commit message.
> >
> > As per the schematic and datasheet PHY mode is RGMII
> > Use 2ns clock delay to RXC for RXD and TXC for TXD latching.
>
> rgmii-id mode does exactly this in the phy (your realtek chip). By
> setting the mode to rgmii, you're telling the phy that delays are set
> elsewhere, either in hardware or in the controller. You're then
> handling them in the controller. While the delays aren't documented in
> the TRM, I've long suspected that the defaults of 0x30 and 0x10 equate
> to the standard 2ns delay. So you're setting the delays much higher
> than the default means you need to add *more* than the standard 2ns
> delay for your device to work.
>

TX and RX clock delay might have been updated for
     ID: 0x30, Synopsys ID: 0x51  DWMAC4/5

As per the schematic [0]
https://dl.radxa.com/rock3/docs/hw/3a/rock3a_v1.3_sch.pdf
   Pull-up for additional 2ns delay to RXC for data latching
   Pull-up for additional 2ns delay to TXC for data latching

As per the datasheet [1]
https://dl.radxa.com/rock3/docs/hw/datasheet/RTL8211F-CG-Datasheet.pdf
TXDLY   RGMII            Transmit Clock Timing Control.
    1: Add 2ns delay to RXC for RXD latching (via 4.7k-ohm to DVDD_RG)
    0: No delay (via 4.7k-ohm to GND)
RXDLY RGMII Receive Clock Timing Control.
    1: Add 2ns delay to RXC for RXD latching (via 4.7k-ohm to DVDD_RG)
    0: No delay (via 4.7k-ohm to GND)

tx_delay and rx_delay might be suitable for old DWMAC
hence it does not apply to this new Ethernet controller.
I have tested with remove these from the dts and
adding the following as this is required for rgmii mode.
       rx-internal-delay-ps = <2000>;
       tx-internal-delay-ps = <2000>;

I don't mind setting the defaults of 0x30 and 0x10 to equate
to the standard 2ns delay. but it does not have any effect
on the current ethernet controller.

> This is why I've been asking if you have tested these. You need to set
> each value and find the lowest and highest possible values that work,
> then take the median value between those two.
>

Yes, I have tested with and without those values.

Thanks
-Anand
> >
> > > > Fix the following warning
> > > >
> > > > [    7.365215] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
> > > > [    7.365219] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
> > > > [    7.365224] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
> > > > [    7.365228] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10
> > >
> > > If the only purpose of this patch is to get rid of this warnings, it may
> >
> > No, the intent is to fix the PHY mode to RGMII and fix the delay.
> > [ 7.066357] rk_gmac-dwmac fe010000.ethernet: init for RGMII_ID
> >
> > > make sense to set them to dev_dbg as Peter pointed out.
> > >
> > Ok, will update this in the next version.
> >
> > > Best regards,
> > > Michael
> > >
> > Thanks
> > -Anand
