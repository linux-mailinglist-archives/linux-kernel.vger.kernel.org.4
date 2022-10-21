Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F6607E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJUSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJUSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:14:55 -0400
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F553A41
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:14:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 9F10F9C072B;
        Fri, 21 Oct 2022 14:14:49 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WyTzShlkMgrY; Fri, 21 Oct 2022 14:14:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 5CD369C077C;
        Fri, 21 Oct 2022 14:14:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5CD369C077C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1666376088; bh=zxwxgDcYDPhPyS7uRme5ueOQ6RpkIqNVMjD1LjfSAak=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=CRCgcJAR91qSC9exWQcSw/3seyuw07KKkTlyLZCL1CkcU4y3vT9U8iVv0jmFVMxrU
         ep6p70eJtIICKoPmbny6nhwHI54Glr76kdqs8HEy50LQ4I9Ed7AXTYCPiodMF4MKnN
         W3GyH8peoTnIbE1GycW6f/5eyh+1BbwsgOqV8GX/qBetlsporCVCYK/vbiijyXTaPF
         feyj6+0QFf1itpX97zD947fe8KAetCnGEZARY8p7nYcFlMELbD9nMqZ+GdocUqj7rA
         CT0IjlQZFVcoWBTCCExpqqC+DL3NWJPnnXU/TB0yQoEAT5lFi8+QBs4RXtEOj33Xzp
         ZmLsS7lLWJdlw==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AONFZZYLEjdn; Fri, 21 Oct 2022 14:14:48 -0400 (EDT)
Received: from barbarian.mtl.sfl (barbarian.mtl.sfl [192.168.49.172])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 368C09C072B;
        Fri, 21 Oct 2022 14:14:48 -0400 (EDT)
Message-ID: <118f1bcc4583612423aa0dca0421c4eea3cd648d.camel@savoirfairelinux.com>
Subject: Re: [PATCH v2] irqchip: add TS7800v1 fpga based controller driver
From:   firas ashkar <firas.ashkar@savoirfairelinux.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     alex@digriz.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 21 Oct 2022 14:14:48 -0400
In-Reply-To: <86zgdpdrj3.wl-maz@kernel.org>
References: <20221020141351.14829-1-firas.ashkar@savoirfairelinux.com>
         <861qr1fs55.wl-maz@kernel.org>
         <7b2ac9ae5f18e5272e52478c73da53a76cf9f2a2.camel@savoirfairelinux.com>
         <86zgdpdrj3.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 18:18 +0100, Marc Zyngier wrote:
> On Fri, 21 Oct 2022 17:19:02 +0100,
> firas ashkar <firas.ashkar@savoirfairelinux.com> wrote:
> >=20
> > On Fri, 2022-10-21 at 10:22 +0100, Marc Zyngier wrote:
> > > On Thu, 20 Oct 2022 15:13:51 +0100,
> > > Firas Ashkar <firas.ashkar@savoirfairelinux.com> wrote:
> > > >=20
> > > > 1. add TS-7800v1 fpga based irq controller driver, and
> > > > 2. add related memory and irq resources
> > > >=20
> > > > By default only mapped FPGA interrupts will be
> > > > chained/multiplexed,
> > > > these
> > > > chained interrupts will then be available to other device
> > > > drivers
> > > > to
> > > > request via the corresponding Linux IRQs.
> > > >=20
> > > > $ cat /proc/cpuinfo
> > > > processor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 0
> > > > model name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: Feroceon rev 0 (v5l=
)
> > > > BogoMIPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 333.33
> > > > Features=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: swp half =
thumb fastmult edsp
> > > > CPU implementer=C2=A0: 0x41
> > > > CPU architecture: 5TEJ
> > > > CPU variant=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 0x0
> > > > CPU part=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 0x926
> > > > CPU revision=C2=A0=C2=A0=C2=A0=C2=A0: 0
> > > >=20
> > > > Hardware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: Technolog=
ic Systems TS-78xx SBC
> > > > Revision=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 0000
> > > > Serial=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0:=
 0000000000000000
> > > > $
> > > >=20
> > > > $ cat /proc/interrupts
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0
> > > > =C2=A0 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 902=C2=A0 orion=
_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 orion_tick
> > > > =C2=A0 4:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 795=C2=A0 orion=
_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 ttyS0
> > > > =C2=A013:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0 orion_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 ehci=
_hcd:usb2
> > > > =C2=A018:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0 orion_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 ehci=
_hcd:usb1
> > > > =C2=A022:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 69=C2=A0 =
orion_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 eth0
> > > > =C2=A023:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 171=C2=A0 orion=
_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 orion-mdio
> > > > =C2=A029:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0 orion_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 mv_c=
rypto
> > > > =C2=A031:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
=C2=A0 orion_irq=C2=A0=C2=A0=C2=A0=C2=A0 Level=C2=A0=C2=A0=C2=A0=C2=A0 mv_x=
or.0
> > > > =C2=A065:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
=C2=A0 ts7800-irqc=C2=A0=C2=A0 0 Edge=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ts-dmac=
-cpupci
> > > > Err:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > $
> > > >=20
> > > > $ uname -a
> > > > Linux ts-7800 6.1.0-rc1 #2 PREEMPT Mon Oct 17 11:19:12 EDT 2022
> > > > armv5tel
> > > > =C2=A0GNU/Linux
> > > > $
> > > >=20
> > > > Signed-off-by: Firas Ashkar <firas.ashkar@savoirfairelinux.com>
> > > > ---
> > > >=20
> > > > Notes:
> > > > =C2=A0=C2=A0=C2=A0 Changes in V2
> > > > =C2=A0=C2=A0=C2=A0 * limit the commit message
> > >=20
> > > Well, there is still a lot of work to do. Most of this commit
> > > message
> > > could be reduced to a single paragraph:
> > >=20
> > > "Add support for FooBar IRQ controller usually found on Zorglub
> > > platform."
> > >=20
> > > The rest is plain obvious.
> > nack, commit message is fine as is!
>=20
> Allow me to be the judge of that.
>=20
> > >=20
> > > > =C2=A0=C2=A0=C2=A0 * format comments in source code
> > > > =C2=A0=C2=A0=C2=A0 * use raw spin locks to protect mask/unmask ops
> > > > =C2=A0=C2=A0=C2=A0 * use 'handle_edge_irq' and 'irq_ack' logic
> > > > =C2=A0=C2=A0=C2=A0 * remove 'irq_domain_xlate_onecell'
> > > > =C2=A0=C2=A0=C2=A0 * remove unnecessary status flags
> > > > =C2=A0=C2=A0=C2=A0 * use 'builtin_platform_driver' helper routine
> > > >=20
> > > > :100644 100644 2f4fe3ca5c1a ed8378893208 M=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0arch/arm/mach-
> > > > orion5x/ts78xx-fpga.h
> > > > :100644 100644 af810e7ccd79 d319a68b7160 M=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0arch/arm/mach-
> > > > orion5x/ts78xx-setup.c
> > > > :100644 100644 7ef9f5e696d3 d184fb435c5d
> > > > M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/irqchip/Kconfig
> > > > :100644 100644 87b49a10962c b022eece2042
> > > > M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/irqchip/Makefile
> > > > :000000 100644 000000000000 e975607fa4d5
> > > > A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/irqchip/irq-ts7800.c
> > > > =C2=A0arch/arm/mach-orion5x/ts78xx-fpga.h=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0arch/arm/mach-orion5x/ts78xx-setup.c |=C2=A0 55 +++++
> > > > =C2=A0drivers/irqchip/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +
> > > > =C2=A0drivers/irqchip/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0drivers/irqchip/irq-ts7800.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 347
> > > > +++++++++++++++++++++++++++
> > > > =C2=A05 files changed, 416 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h
> > > > b/arch/arm/mach-
> > > > orion5x/ts78xx-fpga.h
> > > > index 2f4fe3ca5c1a..ed8378893208 100644
> > > > --- a/arch/arm/mach-orion5x/ts78xx-fpga.h
> > > > +++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
> > > > @@ -32,6 +32,7 @@ struct fpga_devices {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fpga_device=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ts_rtc;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fpga_device=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ts_nand;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fpga_device=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ts_rng;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fpga_device=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ts_irqc;
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0struct ts78xx_fpga_data {
> > > > diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c
> > > > b/arch/arm/mach-
> > > > orion5x/ts78xx-setup.c
> > > > index af810e7ccd79..d319a68b7160 100644
> > > > --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> > > > +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> > > > @@ -322,6 +322,49 @@ static void ts78xx_ts_rng_unload(void)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0platform_device_del=
(&ts78xx_ts_rng_device);
> > > > =C2=A0}
> > > > =C2=A0
> > > > +/*************************************************************
> > > > ****
> > > > ************
> > > > + * fpga irq controller
> > > > +
> > > > ***************************************************************
> > > > ****
> > > > *********/
> > >=20
> > > [...]
> > >=20
> > > Sorry, but I have to ask: what part of "we're not taking any
> > > additional non-DT changes to these obsolete setups" did I fail to
> > > accurately communicate?
> > >=20
> > > Until this board is entirely converted to DT, I'm not taking any
> > > irqchip changes other than the most obvious bug fixes.
> > as long as this board is present in the kernel in its current
> > legacy
> > form, this is a valid patch!
>=20
> No. There is a cut of point. Code that we would taken 10 years ago
> isn't necessarily valid anymore. We want to improve the kernel as a
> whole, and not keep it in the past.
>=20
> >=20
> > >=20
> > > [...]
> > >=20
> > > > +static void ts7800_irq_mask(struct irq_data *d)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ts7800_irq_data *=
data =3D
> > > > irq_data_get_irq_chip_data(d);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 fpga_mask_reg =3D re=
adl(data->base + IRQ_MASK_REG);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 mask_bits =3D 1 << d=
->hwirq;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long flags;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0raw_spin_lock_irqsave(&d=
ata->lock, flags);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(fpga_mask_reg & ~=
mask_bits, data->base +
> > > > IRQ_MASK_REG);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(fpga_mask_reg & ~=
mask_bits, data->bridge +
> > > > IRQ_MASK_REG);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0raw_spin_unlock_irqresto=
re(&data->lock, flags);
> > >=20
> > > OMFG. What do you expect this protects? Same question applies to
> > > all
> > > the instances where you take this pointless lock.
> > don't jump now
> > the locks added as per your previous comment, quoting:
> > "I know your HW is UP, but seeing these RMW sequences without a
> > lock
> > makes me jump."
> > On this single CPU based arch TS78xx, locks are waste of cpu
> > cycles,
> > also note that IRQs/preemption are/is already off in this context
> >=20
> > maybe you meant adding locks as to promote general correct coding ?
>=20
> Let me spell it out for you: RMW means Read-Modify-Write. Putting a
> lock around a *write only* serves zero purpose. It is just overhead,
> and it is incorrect.
>=20
> >=20
> > or maybe it was like this previous nonsense comment, quoting :
> > "We don't remove interrupt controllers. What happens if someone
> > still
> > had a mapping?"
>=20
> And I stand by it.
>=20
> >=20
> >=20
> > >=20
> > > [...]
> > >=20
> > > > +static void ts7800_ic_chained_handle_irq(struct irq_desc
> > > > *desc)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ts7800_irq_data *=
data =3D
> > > > irq_desc_get_handler_data(desc);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct irq_chip *chip =
=3D irq_desc_get_chip(desc);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 mask_bits =3D readl(=
data->base + IRQ_MASK_REG);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 status =3D readl(dat=
a->bridge);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chained_irq_enter(chip, =
desc);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(status =3D=
=3D 0)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0handle_bad_irq(desc);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0unsigned int bit =3D __ffs(status);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0int irq =3D irq_find_mapping(data->domain, bit);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (irq && (mask_bits & BIT(bit)))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gen=
eric_handle_irq(irq);
> > >=20
> > > Again, this is not appropriate. I've pointed you to the right API
> > > in
> > > my previous review of this patch.
> > 'generic_handle_domain_irq' causing some issues
>=20
> Which issue?
# insmod /tmp/virt-dma.ko=20
# insmod /tmp/ts-dmac.ko=20
generic_handle_domain_irq failed, error -22
irq 2, desc: a285c39f, depth: 0, count: 0, unhandled: 0
->handle_irq():  e7046ee9, ts7800_ic_chained_handle_irq+0x0/0x1ec
[irq_ts7800]
->irq_data.chip(): 70d81143, 0xc14db44c
->action(): f799c8dd
->action->handler(): dcf07981, bad_chained_irq+0x0/0x64
     IRQ_LEVEL set
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
  IRQ_NOTHREAD set
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
irq 2, desc: a285c39f, depth: 0, count: 0, unhandled: 0
->handle_irq():  e7046ee9, ts7800_ic_chained_handle_irq+0x0/0x1ec
[irq_ts7800]
->irq_data.chip(): 70d81143, 0xc14db44c
->action(): f799c8dd
->action->handler(): dcf07981, bad_chained_irq+0x0/0x64
     IRQ_LEVEL set
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
  IRQ_NOTHREAD set
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
irq 2, desc: a285c39f, depth: 0, count: 0, unhandled: 0
->handle_irq():  e7046ee9, ts7800_ic_chained_handle_irq+0x0/0x1ec
[irq_ts7800]
->irq_data.chip(): 70d81143, 0xc14db44c
->action(): f799c8dd
->action->handler(): dcf07981, bad_chained_irq+0x0/0x64
     IRQ_LEVEL set
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
  IRQ_NOTHREAD set
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
irq 2, desc: a285c39f, depth: 0, count: 0, unhandled: 0
->handle_irq():  e7046ee9, ts7800_ic_chained_handle_irq+0x0/0x1ec
[irq_ts7800]
->irq_data.chip(): 70d81143, 0xc14db44c
->action(): f799c8dd
->action->handler(): dcf07981, bad_chained_irq+0x0/0x64
     IRQ_LEVEL set
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
  IRQ_NOTHREAD set
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
irq 2, desc: a285c39f, depth: 0, count: 0, unhandled: 0
->handle_irq():  e7046ee9, ts7800_ic_chained_handle_irq+0x0/0x1ec
[irq_ts7800]
->irq_data.chip(): 70d81143, 0xc14db44c
->action(): f799c8dd
->action->handler(): dcf07981, bad_chained_irq+0x0/0x64
     IRQ_LEVEL set
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
  IRQ_NOTHREAD set
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
generic_handle_domain_irq failed, error -22
unexpected IRQ trap at vector 02
...
>=20
> > >=20
> > > [...]
> > >=20
> > > > +static struct platform_driver ts7800_ic_driver =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0 =3D ts7800_=
ic_probe,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove =3D ts7800_ic_re=
move,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.id_table=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D ts7800v1_ic_ids,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.name =3D DRIVER_NAME,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > > +};
> > > > +builtin_platform_driver(ts7800_ic_driver);
> > >=20
> > > Again, this isn't appropriate either, and I pointed it out last
> > > time. We have specific helpers for irqchip, and using them isn't
> > > optional. But of course, you'll need to move to DT for that.
> > >=20
> > > Anyway, this is the last time I review this patch until you
> > > convert
> > > the corresponding platform to DT.
> > no problems, though have to note this is not constructive!
>=20
> I've pointed out a bunch of issues, and provided advise on how you
> can
> fix them. That's constructive. A non constructive approach would be
> to
> just ignore your patch. If that's what you prefer, please say so.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M.
>=20
