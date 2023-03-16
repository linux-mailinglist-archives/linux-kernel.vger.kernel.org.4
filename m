Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7F6BD94C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCPTeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCPTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:34:20 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294B31BAFA;
        Thu, 16 Mar 2023 12:34:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5445009c26bso51759737b3.8;
        Thu, 16 Mar 2023 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678995258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz+plsvs+wTdga/JBWc6/XyFN4c4GI8S5LTfQzEwttA=;
        b=S/w1Ed9l0L1eySHhJ2ujfhYJMYQKGeXw6CjeLajB5Di1bIq5gjZ7Ll+lwGFjE9qxDa
         Zgbv+6NgwjQPBvM0IiULm/TOAcPnohjB5sqElvJAnypl69DPjUR2ek7A7gDdps2M9+XY
         ut2VXN7Nu4KwWYlVudwOLZbpQmVfZ5aV2r5PtgqTKQ+JmMkHZcBt6vxcPcGslvaBR8uU
         q7cyUmJ7ZnGeCuNMxomJ61/wLat2/OgSmCNF8NtraduAgpCwwrY3BYh3cPuEsR3Xlu73
         cjBgP4HzL7oDDviHK0wzRCC0lSjOxuft4IogOdMAOAla0L5xg50xCMycsEIBmmghx91q
         gB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz+plsvs+wTdga/JBWc6/XyFN4c4GI8S5LTfQzEwttA=;
        b=O/YnWA4h8OipSUY28QVzRm+ETTHtJaJWGWn/OoRqidA0v3zwzyyA9/10DVQYaNh+82
         suu6ExEvf20EjPwiIGIe5P8bvnaeuYEL8nZSrpVl78LX7n/SkshqR472TP2qrTmkFpyX
         MrpWnV33bAAvf09avkn5NtPaB0kVIfWNDNPDtB6PJr7q2M45n14isDjTwjJQRRPF1yuX
         5uUYSlnoYM6o35TpAAmRYEPfawWOUppwdXF3DEiQmJ0emyKqcBbQa0YdIvnd1qQXM3VU
         dSAfe1PO/OxvY9pFwLP8OsnIHb+Pu51X5iim5d2dyF0/LwCiazeHRFTel8fpvRoXGp8A
         18QA==
X-Gm-Message-State: AO0yUKVKeoqG2Xpmre7tenet1fluAIDWxtVGDb7cDx9hCsUP/j28Y8Is
        KVHZYOgkEKdDpSRwobFmddVgies+uFV+h57SS/A=
X-Google-Smtp-Source: AK7set+bKSaA0eoNinTrPRsNekI0+TkZqONlO/lwSTDmy0Y5WNx6kdfI4IinZy8/qUFqAHRU4gVulfPf0p0r9hBmLYg=
X-Received: by 2002:a81:aa03:0:b0:541:6763:3ce1 with SMTP id
 i3-20020a81aa03000000b0054167633ce1mr2862600ywh.2.1678995258241; Thu, 16 Mar
 2023 12:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230316180701.783785-1-noltari@gmail.com> <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
 <CAKR-sGcuKoDyZSmprbFPHoHdKjk9N=q1SDLE0+qTVuXmuF=saA@mail.gmail.com> <cf868119-31e4-480e-6ebc-531f0686f664@gmail.com>
In-Reply-To: <cf868119-31e4-480e-6ebc-531f0686f664@gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Thu, 16 Mar 2023 20:34:07 +0100
Message-ID: <CAKR-sGdkQeyvSNouVTZPXsSKP8Dzh+DM8YxXf-93K4orqKrifA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/bcm-6345-l1: show MMIO address
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        tglx@linutronix.de, maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 16 mar 2023 a las 20:10, Florian Fainelli
(<f.fainelli@gmail.com>) escribi=C3=B3:
>
> On 3/16/23 12:04, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > El jue, 16 mar 2023 a las 19:13, Florian Fainelli
> > (<f.fainelli@gmail.com>) escribi=C3=B3:
> >>
> >> On 3/16/23 11:07, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> >>> It's safe to show MMIO address.
> >>>
> >>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> >>
> >> This is going to be the kernel virtual address, and while on MIPS it i=
s
> >> easy to resolve to the physical address because these platforms map
> >> registers through KSEG0/1, on other platforms like ARM/ARM64 the kerne=
l
> >> virtual addresses are pretty meaningless unless what you want to debug
> >> is how ioremap() mapped the address.
> >>
> >> I would rather do the following change:
> >>
> >> diff --git a/drivers/irqchip/irq-bcm6345-l1.c
> >> b/drivers/irqchip/irq-bcm6345-l1.c
> >> index 1bd0621c4ce2..832957d363a4 100644
> >> --- a/drivers/irqchip/irq-bcm6345-l1.c
> >> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> >> @@ -261,6 +261,8 @@ static int __init bcm6345_l1_init_one(struct
> >> device_node *dn,
> >>           if (!cpu->map_base)
> >>                   return -ENOMEM;
> >>
> >> +       request_mem_region(res.start, sz, res.name);
> >> +
> >>           for (i =3D 0; i < n_words; i++) {
> >>                   cpu->enable_cache[i] =3D 0;
> >>                   __raw_writel(0, cpu->map_base + reg_enable(intc, i))=
;
> >>
> >> such that this shows up in /proc/iomem. WDYT?
> >
> > I tried doing it that way, but it still shows (ptrval):
> > [    0.000000] irq_bcm6345_l1: registered BCM6345 L1 intc (IRQs: 32)
> > [    0.000000] irq_bcm6345_l1:   CPU0 at MMIO 0x(ptrval) (irq =3D 2)
>
> Well yes, if you don't remove the pr_info() you are still going to be
> printing it, and because map_base is the return of ioremap() which is a
> kernel virtual address, it is still hashed, also see Marc's message that
> came in. I guess I should have been way more explicit and also provide a
> tentative patch that also took out the pr_info().

Ah, sorry for that, I didn't get your point...
However, I'd rather keep the pr_info, so I just removed the MMIO address in=
 v2.

>
> >
> > I checked /proc/iomem and it's shown:
> > root@OpenWrt:/# cat /proc/iomem
> > 00000000-03ffffff : System RAM
> >    00010000-0068e96f : Kernel code
> >    0068e970-008834ff : Kernel data
> >    01610000-016458e7 : Kernel bss
> > 08000000-0800ffff : BCM6348 PCI IO space
> > 1e000000-1fffffff : 1e000000.nor nor@1e000000
> > 30000000-37ffffff : pci@fffe1000
> >    30000000-3000ffff : 0000:00:01.0
> >      30000000-3000ffff : ath9k
> > fffe0004-fffe0007 : fffe0004.clock-controller clock-controller@fffe0004
> > fffe000c-fffe0013 : interrupt-controller@fffe000c
> > fffe0034-fffe0037 : fffe0034.reset-controller reset-controller@fffe0034
> > fffe005c-fffe0067 : fffe005c.watchdog watchdog@fffe005c
> > fffe0100-fffe0117 : fffe0100.serial serial@fffe0100
> > fffe1000-fffe11ff : fffe1000.pci pci
> > fffe1300-fffe13ff : fffe1300.usb usb@fffe1300
> > fffe1400-fffe14ff : fffe1400.usb usb@fffe1400
> > fffe1500-fffe1537 : fffe1500.usb-phy usb-phy@fffe1500
> >
> > Any idea why this could be hapenning?
>
> We now have the desired resource listed using its physical address:
>
> fffe000c-fffe0013 : interrupt-controller@fffe000c
>
> There could be a variety of improvements to how request_mem_region() is
> called if you want to provide a break down of each resource on a per-CPU
> basis.
> --
> Florian
>

=C3=81lvaro
