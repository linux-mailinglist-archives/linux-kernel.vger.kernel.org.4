Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA51611427
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJ1OLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJ1OLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:11:33 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE07C77E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:11:31 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 1so5241106vsx.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y3HZ5Z9INEvVnaiLMEUEyf9U1obNrEmBr92qQo5xahU=;
        b=SoGeBPNWzaqQCc5k34nTFJIwSs305Ct6GYvm/zsEcEG5+QTtqsbtgS+rYAFrjp0g1k
         JFvpMkBEAvnF36rsj4Fb59LRXZeev8+hD4YiS5UmM7hGRCnUOLKvJDCJJYxdwVPwIGz8
         A1nUEhBygVgSNB2P8WoiLqz7kdznQ67OfpJWdkzDUD28TY2k6UuQwim88c76+SS+1Bw8
         jNodqYuX9eSPNeG5cK/lCTKduEMeG7LadSBV7PVJ22cHTff+6dr7XbMVVHbLNzw7kkSD
         SBAvhJQVxDbEMGiwbsjAZEWnZkf5W4lCEYFctOTCxa2RmP+rQQduavK/Jf1yPO6VW+Mg
         76ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3HZ5Z9INEvVnaiLMEUEyf9U1obNrEmBr92qQo5xahU=;
        b=Q1CefC93AIn2jijsWr8GOJgS0yt4lRWVJlpgdb9uzMyNxkso+VV3Q6RFiydhpXv8u3
         rfMb6uAI9pcjG7q5vXubpBsst1kBzmLc6V+jN9RpXGrJjY308Rtt5ShlaX90wt6HOey2
         VX7LIVziGrj3qb8OOydkbdMCo7JHjEfucQfv2RGSCWP1vJDHSAc9cqQlCVnFPepsPx8d
         z9z6Bx9PPWB1i43iN+Ov9PXGlxS2FR1jltOHj/LeYJlD/OMHpW8xP8rkT0N21W2Ax+Bb
         IEmwBEqpEjFGHdxeh6kDfEzSPGgPZI0PlMfYbpVZi15Kbgda5DLxTcanhQgs5ZHZb/wO
         vqcg==
X-Gm-Message-State: ACrzQf0SWsAKF52y0XnwmYQntbCS8RGWlXdHRAtQ/q8YTw9WW4Yfo39P
        1SAGwEY38TcRuj6DUH7l6BdclWGa9U39xX+IEfYy0TZ95OfNiw==
X-Google-Smtp-Source: AMsMyM7i114jK4Bk8IrUka1yCuvK51e803UUSbSvSK6ZHcyqNTDxFQ/zT/LtP7m0AR3Bgy6LnwUNT2Wf7TzK90lVJb8=
X-Received: by 2002:a67:efc4:0:b0:3ac:412e:a545 with SMTP id
 s4-20020a67efc4000000b003ac412ea545mr923061vsp.69.1666966290722; Fri, 28 Oct
 2022 07:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <Y1PydJnbL/9CRFFn@sol.ermione.com> <CA+pv=HNmYsh_y1+so_p=MNePNyV-A-FQ-iX2ivvSWDuyYcPnSQ@mail.gmail.com>
In-Reply-To: <CA+pv=HNmYsh_y1+so_p=MNePNyV-A-FQ-iX2ivvSWDuyYcPnSQ@mail.gmail.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Fri, 28 Oct 2022 10:11:19 -0400
Message-ID: <CAJs+hrFTfpJ6X3Q4QGzjEZmeGxP9xaG-M-VTnBgm2fu8giUB8Q@mail.gmail.com>
Subject: Re: mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     Andrea Baldoni <erm25d019@ermione.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you Slade for sharing the v3 link with Andrea. The v1 patch had
a mistake in it, hopefully the v3 works for you, let me know if you
run into any issues.

Best,
Patrick

On Sat, Oct 22, 2022 at 10:09 PM Slade Watkins <srw@sladewatkins.net> wrote:
>
> On Sat, Oct 22, 2022 at 8:36 PM Andrea Baldoni <erm25d019@ermione.com> wrote:
> >
> > Hello.
> > I am not subscribed to the list so please CC to my address.
> >
> > I recently bought a new ASUS Laptop E210KA-GJ059WS with
> >
> > 00:1a.0 SD Host controller: Intel Corporation Device 4dc4 (rev 01) (prog-if 01)
> >         Subsystem: ASUSTeK Computer Inc. Device 1842
> >         Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 7
> >         Memory at 6001129000 (64-bit, non-prefetchable) [size=4K]
> >         Capabilities: [80] Power Management version 3
> >         Capabilities: [90] Vendor Specific Information: Len=14 <?>
> >         Kernel driver in use: sdhci-pci
> >
> > I tried to install Linux (vanilla kernel 5.19.4) and found that the internal
> > 128GB eMMC SSD was unuseable, unable to make a filesystem on it, dmesg shown
> >
> > mmc0: running CQE recovery
> > and
> > mmc0: cqhci: timeout for tag 0
> > followed by register dump
> >
> > (unfortunately I don't have the exact log now).
> >
> > I found the patch to drivers/mmc/host/sdhci-pci-core.c posted by
> > Patrick Thompson date Thu, 13 Oct 2022 17:00:17 -0400, and applied it,
> > but the only way to make the eMMC work was to disable
> > CQE in its entirety by commenting
>
> This one I assume?[1]
>
> >
> > slot->host->mmc->caps2 |= MMC_CAP2_CQE;
> > and
> > slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> >
> > If someone would like me to do any targeted test to be able to solve the
> > issue better, I will be happy to do it.
> >
> > At the moment I am also searching how to get the touchpad to work, I would
> > appreciate any hint and/or a contact with someone who has experience on
> > this.
> >
> > I think the relevant device should be this one, but it doesn't show in
> > /proc/bus/input/devices.
> >
> > P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/ASUE1409:00
> > E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/ASUE1409:00
> > E: ID_VENDOR_FROM_DATABASE=Asuscom Network Inc
> > E: MODALIAS=acpi:ASUE1409:PNP0C50:
> > E: SUBSYSTEM=acpi
> > E: USEC_INITIALIZED=10378637
> >
> > Thank you.
> >
> > Best regards,
> > Andrea Baldoni
>
> Also looping in +acpi and mmc lists, +Patrick Thompson here.
>
> [1] https://lore.kernel.org/linux-mmc/20221013210017.3751025-1-ptf@google.com/
>
> Best,
> -srw
