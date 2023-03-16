Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74B6BD88F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCPTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCPTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:05:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF17B61A2;
        Thu, 16 Mar 2023 12:05:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-541a05e4124so50932487b3.1;
        Thu, 16 Mar 2023 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678993502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuyknMvK5V+CI6DL3PUJ12Wt1esd6FJ5jCcVSEGJreg=;
        b=fP5BSWSLDDmGEOr/jNM6hTZ/vcsMsTgr+kBPsNT9XUFUY5SeYd/jB3hcl5lAixXw6B
         Z0zMvBKjBCQ3R1Bl5B42WOMHUm1DZQrs7Cav2YAd0gDKvTyNBQkE/48G+viI4Db/XJgj
         J0CjwdhNefpv9bjuMLvPSupRhCmAawdQqPvMswKgtQK2WRhpmkZhNB6M2t+Fj8J7KZ45
         4dXepWlZ/AM48uDtAyw+H7E5vEAyIfHeed6XplrCMTpr/OBIBKtCOiPiejO9ZLEZ0swc
         YASDWBN98AgmOlI0Cp+9QDLc3iFcJFukCSySV8tmHDX7t7JqSg9Top6HIsMKR9JDbXd4
         Wjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuyknMvK5V+CI6DL3PUJ12Wt1esd6FJ5jCcVSEGJreg=;
        b=P4RvXSUWT8/Z9LzQoWeWXjtaLmGRdmPCK89eA9bE/FttqoyFgvWU6BdUr/BXE8LSg8
         P84QH14tp/aGCgFupcKpOnVq6CemTXCmA/4kJP9Orggjp83Ek4AyPqXzkj5AJtzrHfZ2
         vC7oC1kGn1JQ/GbPIIVQd6lUnWUQ5B/fHbufqyCkjwq68WgGrybf+66QhdnbItaNG6kj
         YGvU1VwQlUDcgqXTdJk82vc72GCc/QevYhLdm/TT65EF6Yybb1wxx6FgOiRLxVutmv73
         LfVilBlggKY6iA488T0fvxq1CjQJ+4XFsExK70dY+dB6kGQrXca2p3p+14ZWDNd1RbWd
         k7OA==
X-Gm-Message-State: AO0yUKWhL6TdMAJI1MQ9Q5FkpSLzqkfEXdTRaAyc/KOkZ+GS7lhHETtJ
        g25+g/Ox73s9SIPQ6myYzblHdwY4dpxBY1H1Bo4=
X-Google-Smtp-Source: AK7set+/PKWbW0wVZ49bnFrcsTy1LnVP9Qsyjf+l+2Uypcw4MuR1jPwWWVT2tjcsFNK9Gr/x2fL5YBMx0HOJgAqsBzo=
X-Received: by 2002:a81:b3c8:0:b0:544:b7ff:b0db with SMTP id
 r191-20020a81b3c8000000b00544b7ffb0dbmr881924ywh.2.1678993501933; Thu, 16 Mar
 2023 12:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230316180701.783785-1-noltari@gmail.com> <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
In-Reply-To: <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Thu, 16 Mar 2023 20:04:51 +0100
Message-ID: <CAKR-sGcuKoDyZSmprbFPHoHdKjk9N=q1SDLE0+qTVuXmuF=saA@mail.gmail.com>
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

El jue, 16 mar 2023 a las 19:13, Florian Fainelli
(<f.fainelli@gmail.com>) escribi=C3=B3:
>
> On 3/16/23 11:07, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > It's safe to show MMIO address.
> >
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>
> This is going to be the kernel virtual address, and while on MIPS it is
> easy to resolve to the physical address because these platforms map
> registers through KSEG0/1, on other platforms like ARM/ARM64 the kernel
> virtual addresses are pretty meaningless unless what you want to debug
> is how ioremap() mapped the address.
>
> I would rather do the following change:
>
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c
> b/drivers/irqchip/irq-bcm6345-l1.c
> index 1bd0621c4ce2..832957d363a4 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -261,6 +261,8 @@ static int __init bcm6345_l1_init_one(struct
> device_node *dn,
>          if (!cpu->map_base)
>                  return -ENOMEM;
>
> +       request_mem_region(res.start, sz, res.name);
> +
>          for (i =3D 0; i < n_words; i++) {
>                  cpu->enable_cache[i] =3D 0;
>                  __raw_writel(0, cpu->map_base + reg_enable(intc, i));
>
> such that this shows up in /proc/iomem. WDYT?

I tried doing it that way, but it still shows (ptrval):
[    0.000000] irq_bcm6345_l1: registered BCM6345 L1 intc (IRQs: 32)
[    0.000000] irq_bcm6345_l1:   CPU0 at MMIO 0x(ptrval) (irq =3D 2)

I checked /proc/iomem and it's shown:
root@OpenWrt:/# cat /proc/iomem
00000000-03ffffff : System RAM
  00010000-0068e96f : Kernel code
  0068e970-008834ff : Kernel data
  01610000-016458e7 : Kernel bss
08000000-0800ffff : BCM6348 PCI IO space
1e000000-1fffffff : 1e000000.nor nor@1e000000
30000000-37ffffff : pci@fffe1000
  30000000-3000ffff : 0000:00:01.0
    30000000-3000ffff : ath9k
fffe0004-fffe0007 : fffe0004.clock-controller clock-controller@fffe0004
fffe000c-fffe0013 : interrupt-controller@fffe000c
fffe0034-fffe0037 : fffe0034.reset-controller reset-controller@fffe0034
fffe005c-fffe0067 : fffe005c.watchdog watchdog@fffe005c
fffe0100-fffe0117 : fffe0100.serial serial@fffe0100
fffe1000-fffe11ff : fffe1000.pci pci
fffe1300-fffe13ff : fffe1300.usb usb@fffe1300
fffe1400-fffe14ff : fffe1400.usb usb@fffe1400
fffe1500-fffe1537 : fffe1500.usb-phy usb-phy@fffe1500

Any idea why this could be hapenning?

>
> > ---
> >   drivers/irqchip/irq-bcm6345-l1.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm=
6345-l1.c
> > index 6899e37810a8..55a2d9b31597 100644
> > --- a/drivers/irqchip/irq-bcm6345-l1.c
> > +++ b/drivers/irqchip/irq-bcm6345-l1.c
> > @@ -335,7 +335,7 @@ static int __init bcm6345_l1_of_init(struct device_=
node *dn,
> >       for_each_cpu(idx, &intc->cpumask) {
> >               struct bcm6345_l1_cpu *cpu =3D intc->cpus[idx];
> >
> > -             pr_info("  CPU%u at MMIO 0x%p (irq =3D %d)\n", idx,
> > +             pr_info("  CPU%u at MMIO 0x%px (irq =3D %d)\n", idx,
> >                               cpu->map_base, cpu->parent_irq);
> >       }
> >
>
> --
> Florian
>

=C3=81lvaro
