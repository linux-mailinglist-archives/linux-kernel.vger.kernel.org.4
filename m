Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FCD68B778
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBFIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:38:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD17F15C9F;
        Mon,  6 Feb 2023 00:38:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a10so3752164edu.9;
        Mon, 06 Feb 2023 00:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWfHL0H4RcGc/9vwZFDc3pqRoIpAUQtt5uy5sPb3mDw=;
        b=DnRIKTlE62K58fmrH1s6BsP0H0kJ5mFYpenpK3aZ57FGsR7XJTDSFgrRS/ntpgsoyQ
         eR7Y0YDb/L752cOfHPabI1FWqqGHRFCyq38CNdJxCjp57dGYEyyfJ1g4IUyuxv5HZOB7
         kmjbRdzUtWTicncNmVV07sQFKl3rLSqOkE4RRe8H23Y0O3DqQhq/Rwud4cKShp0mLfJ4
         GF+l/fq5m1/jl6zGRE1lIPiPLnL3qC/gmoqZMKemBF/HkRDE7RRtUXjdM8XmE+a5N4tD
         1NiNWwcY6FNu8ebG+r3pIxwX36MrwHIl04YiydYhyiF4wwHIban0ZbwL9U8Iao1s92GU
         99dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWfHL0H4RcGc/9vwZFDc3pqRoIpAUQtt5uy5sPb3mDw=;
        b=V4nSPjBDynX+WkeE21naV7dEXXJ0i/h6M99XvvqjeYBYSndVtnWLMg3jYgfRrViBYk
         XUbQwcQ6uz2iNX8oIETR3LlRcv2SrJDqPb3p+Soc2v0FJNOeoz2S+lgWyo9OBoUEb/13
         WHNB0c7ONOusUj/V3wRUcwro2801RsvvEyDPTO3CWyY6szE5ennubXoDvPmK+jP9a5VY
         qrdHyxiB9USgwdsqWKmey4Z4Iv/Hw6zuz4fvTLuS6WAjCWz7zdQHiOcWOBiVbvPYquAY
         rRLizrG37rzYpUZtKOAl5GSUPCi9A10zw97bQ0gruRnv68CNr+PPGKljGHt+j9SDC0wC
         kHYg==
X-Gm-Message-State: AO0yUKVQS53VeGqUCHcce16j4KGU+N+8rnDstc83zIMUeUu2Aj7mU2uz
        JrfA7Z4/0z+YPpdw1E9YdUdHyGw2r+WOcVilNyo=
X-Google-Smtp-Source: AK7set8tTfKfH+/2a9vka/r/NJsmTdNVUW1FPAzY3/4oY2J+N/iK41rmYLXwp865+kvJXM3KnAvGEZwx3tku0o8y2Gc=
X-Received: by 2002:a50:935a:0:b0:4aa:a503:7354 with SMTP id
 n26-20020a50935a000000b004aaa5037354mr1591526eda.49.1675672688930; Mon, 06
 Feb 2023 00:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20230205210751.3842103-1-airlied@gmail.com> <CAOkhzLWSJsDK9Gm-AzeUw7fCpkjDg7d9GuDWyF-6hDr5UZ4DZg@mail.gmail.com>
 <CAPM=9tyaCUmA2bNP1YA1B=cFZP=nKPhQoWR7UwBD2Nfj8ZTODA@mail.gmail.com>
 <CAOkhzLVLbOEp4QnJynxV3cgiqOV5Rm=+dMgexiRmyDs-bRCTPg@mail.gmail.com> <CAPM=9tx0D54oQ6QmjF_NxnBBxbLzhXxi5uH2p6fLWfg2L3xPFw@mail.gmail.com>
In-Reply-To: <CAPM=9tx0D54oQ6QmjF_NxnBBxbLzhXxi5uH2p6fLWfg2L3xPFw@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Mon, 6 Feb 2023 09:37:57 +0100
Message-ID: <CAOkhzLUspmZjC0x6nJoHyc9nijqZu7BOWc8vsqHSRbQhVzd=Gw@mail.gmail.com>
Subject: Re: [PATCH] nvidiafb: detect the hardware support before removing console.
To:     Dave Airlie <airlied@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
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

Dear Dave

On Mon, Feb 6, 2023 at 9:10 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Mon, 6 Feb 2023 at 18:01, Zeno Davatz <zdavatz@gmail.com> wrote:
> >
> > Dear Dave
> >
> > On Mon, Feb 6, 2023 at 8:54 AM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Mon, 6 Feb 2023 at 17:52, Zeno Davatz <zdavatz@gmail.com> wrote:
> > > >
> > > > Dear Dave
> > > >
> > > > Thank you for your patch.
> > > >
> > > > On Sun, Feb 5, 2023 at 10:07 PM Dave Airlie <airlied@gmail.com> wrote:
> > > > >
> > > > > From: Dave Airlie <airlied@redhat.com>
> > > > >
> > > > > This driver removed the console, but hasn't yet decided if it could
> > > > > take over the console yet. Instead of doing that, probe the hw for
> > > > > support and then remove the console afterwards.
> > > > >
> > > > > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > > > > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > > > Reported-by: Zeno Davatz <zdavatz@gmail.com>
> > > > > ---
> > > > >  drivers/video/fbdev/nvidia/nvidia.c | 81 +++++++++++++++--------------
> > > > >  1 file changed, 42 insertions(+), 39 deletions(-)
> > > > >
> > > > > diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
> > > > > index 1960916098d4..e60a276b4855 100644
> > > > > --- a/drivers/video/fbdev/nvidia/nvidia.c
> > > > > +++ b/drivers/video/fbdev/nvidia/nvidia.c
> > > > > @@ -1197,17 +1197,17 @@ static int nvidia_set_fbinfo(struct fb_info *info)
> > > > >         return nvidiafb_check_var(&info->var, info);
> > > > >  }
> > > > >
> > > > > -static u32 nvidia_get_chipset(struct fb_info *info)
> > > > > +static u32 nvidia_get_chipset(struct pci_dev *pci_dev,
> > > > > +                             volatile u32 __iomem *REGS)
> > > > >  {
> > > > > -       struct nvidia_par *par = info->par;
> > > > > -       u32 id = (par->pci_dev->vendor << 16) | par->pci_dev->device;
> > > > > +       u32 id = (pci_dev->vendor << 16) | pci_dev->device;
> > > > >
> > > > >         printk(KERN_INFO PFX "Device ID: %x \n", id);
> > > > >
> > > > >         if ((id & 0xfff0) == 0x00f0 ||
> > > > >             (id & 0xfff0) == 0x02e0) {
> > > > >                 /* pci-e */
> > > > > -               id = NV_RD32(par->REGS, 0x1800);
> > > > > +               id = NV_RD32(REGS, 0x1800);
> > > > >
> > > > >                 if ((id & 0x0000ffff) == 0x000010DE)
> > > > >                         id = 0x10DE0000 | (id >> 16);
> > > > > @@ -1220,12 +1220,11 @@ static u32 nvidia_get_chipset(struct fb_info *info)
> > > > >         return id;
> > > > >  }
> > > > >
> > > > > -static u32 nvidia_get_arch(struct fb_info *info)
> > > > > +static u32 nvidia_get_arch(u32 Chipset)
> > > > >  {
> > > > > -       struct nvidia_par *par = info->par;
> > > > >         u32 arch = 0;
> > > > >
> > > > > -       switch (par->Chipset & 0x0ff0) {
> > > > > +       switch (Chipset & 0x0ff0) {
> > > > >         case 0x0100:            /* GeForce 256 */
> > > > >         case 0x0110:            /* GeForce2 MX */
> > > > >         case 0x0150:            /* GeForce2 */
> > > > > @@ -1278,16 +1277,44 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > >         struct fb_info *info;
> > > > >         unsigned short cmd;
> > > > >         int ret;
> > > > > +       volatile u32 __iomem *REGS;
> > > > > +       int Chipset;
> > > > > +       u32 Architecture;
> > > > >
> > > > >         NVTRACE_ENTER();
> > > > >         assert(pd != NULL);
> > > > >
> > > > > +       if (pci_enable_device(pd)) {
> > > > > +               printk(KERN_ERR PFX "cannot enable PCI device\n");
> > > > > +               return -ENODEV;
> > > > > +       }
> > > > > +
> > > > > +       /* enable IO and mem if not already done */
> > > > > +       pci_read_config_word(pd, PCI_COMMAND, &cmd);
> > > > > +       cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> > > > > +       pci_write_config_word(pd, PCI_COMMAND, cmd);
> > > > > +
> > > > > +       nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
> > > > > +       nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
> > > > > +
> > > > > +       REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
> > > > > +       if (!REGS) {
> > > > > +               printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
> > > > > +               return -ENODEV;
> > > > > +       }
> > > > > +
> > > > > +       Chipset = nvidia_get_chipset(pd, REGS);
> > > > > +       Architecture = nvidia_get_arch(Chipset);
> > > > > +       if (Architecture == 0) {
> > > > > +               printk(KERN_ERR PFX "unknown NV_ARCH\n");
> > > > > +               goto err_out;
> > > > > +       }
> > > > > +
> > > > >         ret = aperture_remove_conflicting_pci_devices(pd, "nvidiafb");
> > > > >         if (ret)
> > > > > -               return ret;
> > > > > +               goto err_out;
> > > > >
> > > > >         info = framebuffer_alloc(sizeof(struct nvidia_par), &pd->dev);
> > > > > -
> > > > >         if (!info)
> > > > >                 goto err_out;
> > > > >
> > > > > @@ -1298,11 +1325,6 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > >         if (info->pixmap.addr == NULL)
> > > > >                 goto err_out_kfree;
> > > > >
> > > > > -       if (pci_enable_device(pd)) {
> > > > > -               printk(KERN_ERR PFX "cannot enable PCI device\n");
> > > > > -               goto err_out_enable;
> > > > > -       }
> > > > > -
> > > > >         if (pci_request_regions(pd, "nvidiafb")) {
> > > > >                 printk(KERN_ERR PFX "cannot request PCI regions\n");
> > > > >                 goto err_out_enable;
> > > > > @@ -1318,34 +1340,17 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > >         par->paneltweak = paneltweak;
> > > > >         par->reverse_i2c = reverse_i2c;
> > > > >
> > > > > -       /* enable IO and mem if not already done */
> > > > > -       pci_read_config_word(pd, PCI_COMMAND, &cmd);
> > > > > -       cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> > > > > -       pci_write_config_word(pd, PCI_COMMAND, cmd);
> > > > > -
> > > > > -       nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
> > > > >         nvidiafb_fix.smem_start = pci_resource_start(pd, 1);
> > > > > -       nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
> > > > > -
> > > > > -       par->REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
> > > > >
> > > > > -       if (!par->REGS) {
> > > > > -               printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
> > > > > -               goto err_out_free_base0;
> > > > > -       }
> > > > > +       par->REGS = REGS;
> > > > >
> > > > > -       par->Chipset = nvidia_get_chipset(info);
> > > > > -       par->Architecture = nvidia_get_arch(info);
> > > > > -
> > > > > -       if (par->Architecture == 0) {
> > > > > -               printk(KERN_ERR PFX "unknown NV_ARCH\n");
> > > > > -               goto err_out_arch;
> > > > > -       }
> > > > > +       par->Chipset = Chipset;
> > > > > +       par->Architecture = Architecture;
> > > > >
> > > > >         sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
> > > > >
> > > > >         if (NVCommonSetup(info))
> > > > > -               goto err_out_arch;
> > > > > +               goto err_out_free_base0;
> > > > >
> > > > >         par->FbAddress = nvidiafb_fix.smem_start;
> > > > >         par->FbMapSize = par->RamAmountKBytes * 1024;
> > > > > @@ -1401,7 +1406,6 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > >                 goto err_out_iounmap_fb;
> > > > >         }
> > > > >
> > > > > -
> > > > >         printk(KERN_INFO PFX
> > > > >                "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
> > > > >                info->fix.id,
> > > > > @@ -1415,15 +1419,14 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > >  err_out_free_base1:
> > > > >         fb_destroy_modedb(info->monspecs.modedb);
> > > > >         nvidia_delete_i2c_busses(par);
> > > > > -err_out_arch:
> > > > > -       iounmap(par->REGS);
> > > > > - err_out_free_base0:
> > > > > +err_out_free_base0:
> > > > >         pci_release_regions(pd);
> > > > >  err_out_enable:
> > > > >         kfree(info->pixmap.addr);
> > > > >  err_out_kfree:
> > > > >         framebuffer_release(info);
> > > > >  err_out:
> > > > > +       iounmap(REGS);
> > > > >         return -ENODEV;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.38.1
> > > >
> > > > This patch fails for me.
> > >
> > > I've based the patch on 6.2-rc7, please make sure to not have the
> > > previous revert committed, this is to replace that patch.
> >
> > Can you guide me through the steps please?
> >
> > I done:
> >
> > 1. cd /usr/src/linux
> > 2. sudo git pull
> > 3. then I applied your patch.
> >
> > Am I doing something wrong?
>
> What is your top of tree commit? (git log)
>
> have you got any commits on top?
>
> git reset --hard origin/master should reset your tree to Linus top.

1. git log shows "d2d11f342b179f1894a901f143ec7c008caba43e"
2. No, no patches on top.
3. I am doing the following steps:
/usr/src/linux> sudo git reset --hard origin/master
Passwort:
HEAD ist jetzt bei d2d11f342b17 Merge branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
/usr/src/linux> sudo patch -p1 < /tmp/patch
patching file drivers/video/fbdev/nvidia/nvidia.c
Hunk #1 FAILED at 1197.
Hunk #2 FAILED at 1220.
Hunk #3 FAILED at 1278.
Hunk #4 FAILED at 1298.
Hunk #5 FAILED at 1318.
Hunk #6 FAILED at 1401.
Hunk #7 FAILED at 1415.
7 out of 7 hunks FAILED -- saving rejects to file
drivers/video/fbdev/nvidia/nvidia.c.rej

Best
Zeno
