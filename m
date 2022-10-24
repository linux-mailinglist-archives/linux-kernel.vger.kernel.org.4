Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDCF60BC97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiJXV4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiJXV40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:56:26 -0400
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EEDCA8A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:10:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 144799C07BF;
        Mon, 24 Oct 2022 16:09:05 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OpTaWb50MDGL; Mon, 24 Oct 2022 16:09:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id ED8A19C07E1;
        Mon, 24 Oct 2022 16:09:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ED8A19C07E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1666642144; bh=MooevM5k1QaJH855gc/sVQp6uKg48ZE4+o7I8k6nD8Y=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=aJVbBe+xQTGotKiXxQIHhsHaxR83ACIZi27uNiAH0J7+iHW6C4pp0lJIdOfIhkfaf
         luyZvM5YKj8XZ7TjKdEmqLjXygQWbuRDg4a1o+zJ+b4ButYc5gFek4UhiJ254Pg4JQ
         OrpUIsRa9qjT53KoyeBoy/GBWCV9wyhp90snswttB4xMceErKK+psH8xCwSnAJrvLi
         VSVDqnaViXpqxaVClwl5qJF0zRB4gAzQeGeVOazfoVEPGc6tfRA7+K3lzAq3p/T18+
         9qF0/uNWyGjfOX0hxrJNyI37pDA+0/php3Go3PeI8C9r5MVGurooSUW9wApuMJfbz4
         xkVmULhSfun2w==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8-NJ-oLqZRjj; Mon, 24 Oct 2022 16:09:03 -0400 (EDT)
Received: from [192.168.49.172] (unknown [192.168.51.254])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C15349C07BF;
        Mon, 24 Oct 2022 16:09:03 -0400 (EDT)
Message-ID: <b188c952e9fd682fb3dedf82c56194543ae112e1.camel@savoirfairelinux.com>
Subject: Re: [PATCH v2] irqchip: add TS7800v1 fpga based controller driver
From:   firas ashkar <firas.ashkar@savoirfairelinux.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     alex@digriz.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 24 Oct 2022 16:08:59 -0400
In-Reply-To: <87fsfggone.wl-maz@kernel.org>
References: <20221020141351.14829-1-firas.ashkar@savoirfairelinux.com>
         <861qr1fs55.wl-maz@kernel.org>
         <7b2ac9ae5f18e5272e52478c73da53a76cf9f2a2.camel@savoirfairelinux.com>
         <86zgdpdrj3.wl-maz@kernel.org>
         <118f1bcc4583612423aa0dca0421c4eea3cd648d.camel@savoirfairelinux.com>
         <87fsfggone.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=20
Firas Ashkar
Developpeur Syst=C3=A8me Embarqu=C3=A9

savoirfairelinux.com | Montr=C3=A9al, Qu=C3=A9bec

T=C3=A9l.: +1 514 276 5468 ext. 118


On Sat, 2022-10-22 at 11:04 +0100, Marc Zyngier wrote:
> On Fri, 21 Oct 2022 19:14:48 +0100,
> firas ashkar <firas.ashkar@savoirfairelinux.com> wrote:
> > > > > > +static void ts7800_ic_chained_handle_irq(struct irq_desc
> > > > > > *desc)
> > > > > > +{
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ts7800_irq_da=
ta *data =3D
> > > > > > irq_desc_get_handler_data(desc);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct irq_chip *chi=
p =3D irq_desc_get_chip(desc);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 mask_bits =3D re=
adl(data->base + IRQ_MASK_REG);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 status =3D readl=
(data->bridge);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chained_irq_enter(ch=
ip, desc);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(status =
=3D=3D 0)) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0handle_bad_irq(desc);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int bit =3D __ffs(status);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int irq =3D irq_find_mapping(data->domain,
> > > > > > bit);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (irq && (mask_bits & BIT(bit)))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0generic_handle_irq(irq);
> > > > >=20
> > > > > Again, this is not appropriate. I've pointed you to the right
> > > > > API
> > > > > in
> > > > > my previous review of this patch.
> > > > 'generic_handle_domain_irq' causing some issues
> > >=20
> > > Which issue?
> > # insmod /tmp/virt-dma.ko=20
> > # insmod /tmp/ts-dmac.ko=20
> > generic_handle_domain_irq failed, error -22
> > irq 2, desc: a285c39f, depth: 0, count: 0, unhandled: 0
> > ->handle_irq():=C2=A0 e7046ee9, ts7800_ic_chained_handle_irq+0x0/0x1ec
> > [irq_ts7800]
> > ->irq_data.chip(): 70d81143, 0xc14db44c
> > ->action(): f799c8dd
> > ->action->handler(): dcf07981, bad_chained_irq+0x0/0x64
> > =C2=A0=C2=A0=C2=A0=C2=A0 IRQ_LEVEL set
> > =C2=A0=C2=A0 IRQ_NOPROBE set
> > =C2=A0IRQ_NOREQUEST set
> > =C2=A0 IRQ_NOTHREAD set
> > unexpected IRQ trap at vector 02
> > generic_handle_domain_irq failed, error -22
>=20
> [...]
>=20
> News flash, your code is buggy. How about you debug it? The domain
> name you use definitely indicates that you "know how" to do it...
Ack=20
1. using domain hwirq as in=C2=A0
'generic_handle_domain_irq(data->domain, domain_hwirq);', and
2. changing the irq ack callback a bit=20
fixed the issue

# cat /proc/interrupts=20
           CPU0      =20
  1:    7730781  orion_irq     Level     orion_tick
  4:       2706  orion_irq     Level     ttyS0
 13:          0  orion_irq     Level     ehci_hcd:usb2
 18:          0  orion_irq     Level     ehci_hcd:usb1
 22:     101488  orion_irq     Level     eth0
 23:       5075  orion_irq     Level     orion-mdio
 29:          0  orion_irq     Level     mv_crypto
 31:          2  orion_irq     Level     mv_xor.0
 65:     292763  ts7800-irqc   0 Edge      ts-dmac-cpupci
 66:     292760  ts7800-irqc   1 Edge      ts-dmac-fpga
Err:          0
# uname -a
Linux ts-7800 6.1.0-rc1 #6 PREEMPT Fri Oct 21 11:25:55 EDT 2022
armv5tel GNU/Linux
# lsmod
Module                  Size  Used by    Not tainted
ts7800v1_sdmmc         36893  0=20
ts_dmac                17970  1=20
virt_dma                3716  1 ts_dmac
irq_ts7800              4035  0 [permanent]
#

ty
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M.
>=20
