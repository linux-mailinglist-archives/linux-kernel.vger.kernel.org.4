Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491F68B7C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBFIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:54:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05712857;
        Mon,  6 Feb 2023 00:54:23 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ml19so32240408ejb.0;
        Mon, 06 Feb 2023 00:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5K/+n4xNab3o/nLIaDh95b6yAKziU1tvSQuqOiWt3OA=;
        b=dP4sWNbjALMahOPsT5Tb6lcwugvRxESmf1F9vvxJGnwe/GzhB5k3TKlb92QjsvsrV9
         qrKyvnw0hxxKB6biqnP3OIfOoCNKPS+H7YCEnyd+ggtbWFdSxvhwVyuYmz4Ur4UAcw38
         bHLBcZxdAedA3nnBjQnHpR20jQ9ikXOdur5+NVlvbQeVedMApXVzeQG4eDaedEONOp2m
         uJ+EBdybvGARjhnURMBe9nm/HDLcPhTHRpSgk8KKoHE7EGFEIIv0ukaklDWn4BEMV4uT
         Wp4/2lsoYD0Hgv4toHUJpxH+V2DcTmygpfGTMtRJnulvMGFChGcAcsFGpqLEPipYEfUE
         +0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K/+n4xNab3o/nLIaDh95b6yAKziU1tvSQuqOiWt3OA=;
        b=Bdf7snvPFK7nJUuN7kntdofC6iZ1uvNsd71NAft6yW2nczLg1ha2oqfl0LobzjLnc3
         DmQe+wx/SiR4nEd+/McA31XvGWGTKDZJjPMiS6nHgcnxF72EwbT5RsTAyK+J2kYW7qnD
         bv+VwpJ860ZHZ3dMD1Rhl8z/foWD9KgE8LyLcIgFKTD1vUG2TtGMR3qLAuqEHwJzSZhh
         xYKboa5Pe9O8ekvhNrfDK1dSEhgFboZPjRdMvyBpcNqeKmVNTHHf9wRvWIvpKB3AZVmj
         +8eyWCzO6tmksEHqSq+TPFv4/74Iyc8wL7LB8v7bXhB2YEXS0bQUfeQHm8wBmPHeF9cu
         l/Hg==
X-Gm-Message-State: AO0yUKVaX53W1pguMQ9qfzd05b6ehao98RBllTgspqn1SggpCAZJda8K
        nXT1OT9Yxs3GF7cvjAwGe1KbBt7GjpdBDQwtmZ0=
X-Google-Smtp-Source: AK7set8/28B3/8TsdW+DdIKZXThf8UCw64vcxMlprv1Xh/pwk5jbYFTq6/2hdfjxW8972wHzuE0vBS1Pvf46HpmWdx0=
X-Received: by 2002:a17:906:6d0d:b0:87e:94bb:8174 with SMTP id
 m13-20020a1709066d0d00b0087e94bb8174mr5738984ejr.249.1675673662383; Mon, 06
 Feb 2023 00:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20230205210751.3842103-1-airlied@gmail.com> <CAOkhzLWSJsDK9Gm-AzeUw7fCpkjDg7d9GuDWyF-6hDr5UZ4DZg@mail.gmail.com>
 <CAPM=9tyaCUmA2bNP1YA1B=cFZP=nKPhQoWR7UwBD2Nfj8ZTODA@mail.gmail.com>
 <CAOkhzLVLbOEp4QnJynxV3cgiqOV5Rm=+dMgexiRmyDs-bRCTPg@mail.gmail.com>
 <CAPM=9tx0D54oQ6QmjF_NxnBBxbLzhXxi5uH2p6fLWfg2L3xPFw@mail.gmail.com>
 <CAOkhzLUspmZjC0x6nJoHyc9nijqZu7BOWc8vsqHSRbQhVzd=Gw@mail.gmail.com> <CAMwc25q9LO0N45DAV6HeONVsWBbOxxYCkSV12Yhr3PVorrr4dg@mail.gmail.com>
In-Reply-To: <CAMwc25q9LO0N45DAV6HeONVsWBbOxxYCkSV12Yhr3PVorrr4dg@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Mon, 6 Feb 2023 09:54:11 +0100
Message-ID: <CAOkhzLXMFwO9hYcwrr9O7xoVs_kprfv4DG8fiNyOsWNLF_VS9g@mail.gmail.com>
Subject: Re: [PATCH] nvidiafb: detect the hardware support before removing console.
To:     David Airlie <airlied@redhat.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 6, 2023 at 9:40 AM David Airlie <airlied@redhat.com> wrote:
>
> On Mon, Feb 6, 2023 at 6:38 PM Zeno Davatz <zdavatz@gmail.com> wrote:
> >
> > Dear Dave
> >
> > On Mon, Feb 6, 2023 at 9:10 AM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Mon, 6 Feb 2023 at 18:01, Zeno Davatz <zdavatz@gmail.com> wrote:
> > > >
> > > > Dear Dave
> > > >
> > > > On Mon, Feb 6, 2023 at 8:54 AM Dave Airlie <airlied@gmail.com> wrote:
> > > > >
> > > > > On Mon, 6 Feb 2023 at 17:52, Zeno Davatz <zdavatz@gmail.com> wrote:
> > > > > >
> > > > > > Dear Dave
> > > > > >
> > > > > > Thank you for your patch.
> > > > > >
> > > > > > On Sun, Feb 5, 2023 at 10:07 PM Dave Airlie <airlied@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Dave Airlie <airlied@redhat.com>
> > > > > > >
> > > > > > > This driver removed the console, but hasn't yet decided if it could
> > > > > > > take over the console yet. Instead of doing that, probe the hw for
> > > > > > > support and then remove the console afterwards.
> > > > > > >
> > > > > > > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > > > > > > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > > > > > Reported-by: Zeno Davatz <zdavatz@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/video/fbdev/nvidia/nvidia.c | 81 +++++++++++++++--------------
> > > > > > >  1 file changed, 42 insertions(+), 39 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
> > > > > > > index 1960916098d4..e60a276b4855 100644
> > > > > > > --- a/drivers/video/fbdev/nvidia/nvidia.c
> > > > > > > +++ b/drivers/video/fbdev/nvidia/nvidia.c
> > > > > > > @@ -1197,17 +1197,17 @@ static int nvidia_set_fbinfo(struct fb_info *info)
> > > > > > >         return nvidiafb_check_var(&info->var, info);
> > > > > > >  }
> > > > > > >
> > > > > > > -static u32 nvidia_get_chipset(struct fb_info *info)
> > > > > > > +static u32 nvidia_get_chipset(struct pci_dev *pci_dev,
> > > > > > > +                             volatile u32 __iomem *REGS)
> > > > > > >  {
> > > > > > > -       struct nvidia_par *par = info->par;
> > > > > > > -       u32 id = (par->pci_dev->vendor << 16) | par->pci_dev->device;
> > > > > > > +       u32 id = (pci_dev->vendor << 16) | pci_dev->device;
> > > > > > >
> > > > > > >         printk(KERN_INFO PFX "Device ID: %x \n", id);
> > > > > > >
> > > > > > >         if ((id & 0xfff0) == 0x00f0 ||
> > > > > > >             (id & 0xfff0) == 0x02e0) {
> > > > > > >                 /* pci-e */
> > > > > > > -               id = NV_RD32(par->REGS, 0x1800);
> > > > > > > +               id = NV_RD32(REGS, 0x1800);
> > > > > > >
> > > > > > >                 if ((id & 0x0000ffff) == 0x000010DE)
> > > > > > >                         id = 0x10DE0000 | (id >> 16);
> > > > > > > @@ -1220,12 +1220,11 @@ static u32 nvidia_get_chipset(struct fb_info *info)
> > > > > > >         return id;
> > > > > > >  }
> > > > > > >
> > > > > > > -static u32 nvidia_get_arch(struct fb_info *info)
> > > > > > > +static u32 nvidia_get_arch(u32 Chipset)
> > > > > > >  {
> > > > > > > -       struct nvidia_par *par = info->par;
> > > > > > >         u32 arch = 0;
> > > > > > >
> > > > > > > -       switch (par->Chipset & 0x0ff0) {
> > > > > > > +       switch (Chipset & 0x0ff0) {
> > > > > > >         case 0x0100:            /* GeForce 256 */
> > > > > > >         case 0x0110:            /* GeForce2 MX */
> > > > > > >         case 0x0150:            /* GeForce2 */
> > > > > > > @@ -1278,16 +1277,44 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > > > >         struct fb_info *info;
> > > > > > >         unsigned short cmd;
> > > > > > >         int ret;
> > > > > > > +       volatile u32 __iomem *REGS;
> > > > > > > +       int Chipset;
> > > > > > > +       u32 Architecture;
> > > > > > >
> > > > > > >         NVTRACE_ENTER();
> > > > > > >         assert(pd != NULL);
> > > > > > >
> > > > > > > +       if (pci_enable_device(pd)) {
> > > > > > > +               printk(KERN_ERR PFX "cannot enable PCI device\n");
> > > > > > > +               return -ENODEV;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       /* enable IO and mem if not already done */
> > > > > > > +       pci_read_config_word(pd, PCI_COMMAND, &cmd);
> > > > > > > +       cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> > > > > > > +       pci_write_config_word(pd, PCI_COMMAND, cmd);
> > > > > > > +
> > > > > > > +       nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
> > > > > > > +       nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
> > > > > > > +
> > > > > > > +       REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
> > > > > > > +       if (!REGS) {
> > > > > > > +               printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
> > > > > > > +               return -ENODEV;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       Chipset = nvidia_get_chipset(pd, REGS);
> > > > > > > +       Architecture = nvidia_get_arch(Chipset);
> > > > > > > +       if (Architecture == 0) {
> > > > > > > +               printk(KERN_ERR PFX "unknown NV_ARCH\n");
> > > > > > > +               goto err_out;
> > > > > > > +       }
> > > > > > > +
> > > > > > >         ret = aperture_remove_conflicting_pci_devices(pd, "nvidiafb");
> > > > > > >         if (ret)
> > > > > > > -               return ret;
> > > > > > > +               goto err_out;
> > > > > > >
> > > > > > >         info = framebuffer_alloc(sizeof(struct nvidia_par), &pd->dev);
> > > > > > > -
> > > > > > >         if (!info)
> > > > > > >                 goto err_out;
> > > > > > >
> > > > > > > @@ -1298,11 +1325,6 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > > > >         if (info->pixmap.addr == NULL)
> > > > > > >                 goto err_out_kfree;
> > > > > > >
> > > > > > > -       if (pci_enable_device(pd)) {
> > > > > > > -               printk(KERN_ERR PFX "cannot enable PCI device\n");
> > > > > > > -               goto err_out_enable;
> > > > > > > -       }
> > > > > > > -
> > > > > > >         if (pci_request_regions(pd, "nvidiafb")) {
> > > > > > >                 printk(KERN_ERR PFX "cannot request PCI regions\n");
> > > > > > >                 goto err_out_enable;
> > > > > > > @@ -1318,34 +1340,17 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > > > >         par->paneltweak = paneltweak;
> > > > > > >         par->reverse_i2c = reverse_i2c;
> > > > > > >
> > > > > > > -       /* enable IO and mem if not already done */
> > > > > > > -       pci_read_config_word(pd, PCI_COMMAND, &cmd);
> > > > > > > -       cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> > > > > > > -       pci_write_config_word(pd, PCI_COMMAND, cmd);
> > > > > > > -
> > > > > > > -       nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
> > > > > > >         nvidiafb_fix.smem_start = pci_resource_start(pd, 1);
> > > > > > > -       nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
> > > > > > > -
> > > > > > > -       par->REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
> > > > > > >
> > > > > > > -       if (!par->REGS) {
> > > > > > > -               printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
> > > > > > > -               goto err_out_free_base0;
> > > > > > > -       }
> > > > > > > +       par->REGS = REGS;
> > > > > > >
> > > > > > > -       par->Chipset = nvidia_get_chipset(info);
> > > > > > > -       par->Architecture = nvidia_get_arch(info);
> > > > > > > -
> > > > > > > -       if (par->Architecture == 0) {
> > > > > > > -               printk(KERN_ERR PFX "unknown NV_ARCH\n");
> > > > > > > -               goto err_out_arch;
> > > > > > > -       }
> > > > > > > +       par->Chipset = Chipset;
> > > > > > > +       par->Architecture = Architecture;
> > > > > > >
> > > > > > >         sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
> > > > > > >
> > > > > > >         if (NVCommonSetup(info))
> > > > > > > -               goto err_out_arch;
> > > > > > > +               goto err_out_free_base0;
> > > > > > >
> > > > > > >         par->FbAddress = nvidiafb_fix.smem_start;
> > > > > > >         par->FbMapSize = par->RamAmountKBytes * 1024;
> > > > > > > @@ -1401,7 +1406,6 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > > > >                 goto err_out_iounmap_fb;
> > > > > > >         }
> > > > > > >
> > > > > > > -
> > > > > > >         printk(KERN_INFO PFX
> > > > > > >                "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
> > > > > > >                info->fix.id,
> > > > > > > @@ -1415,15 +1419,14 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
> > > > > > >  err_out_free_base1:
> > > > > > >         fb_destroy_modedb(info->monspecs.modedb);
> > > > > > >         nvidia_delete_i2c_busses(par);
> > > > > > > -err_out_arch:
> > > > > > > -       iounmap(par->REGS);
> > > > > > > - err_out_free_base0:
> > > > > > > +err_out_free_base0:
> > > > > > >         pci_release_regions(pd);
> > > > > > >  err_out_enable:
> > > > > > >         kfree(info->pixmap.addr);
> > > > > > >  err_out_kfree:
> > > > > > >         framebuffer_release(info);
> > > > > > >  err_out:
> > > > > > > +       iounmap(REGS);
> > > > > > >         return -ENODEV;
> > > > > > >  }
> > > > > > >
> > > > > > > --
> > > > > > > 2.38.1
> > > > > >
> > > > > > This patch fails for me.
> > > > >
> > > > > I've based the patch on 6.2-rc7, please make sure to not have the
> > > > > previous revert committed, this is to replace that patch.
> > > >
> > > > Can you guide me through the steps please?
> > > >
> > > > I done:
> > > >
> > > > 1. cd /usr/src/linux
> > > > 2. sudo git pull
> > > > 3. then I applied your patch.
> > > >
> > > > Am I doing something wrong?
> > >
> > > What is your top of tree commit? (git log)
> > >
> > > have you got any commits on top?
> > >
> > > git reset --hard origin/master should reset your tree to Linus top.
> >
> > 1. git log shows "d2d11f342b179f1894a901f143ec7c008caba43e"
> > 2. No, no patches on top.
> > 3. I am doing the following steps:
> > /usr/src/linux> sudo git reset --hard origin/master
> > Passwort:
> > HEAD ist jetzt bei d2d11f342b17 Merge branch 'fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> > /usr/src/linux> sudo patch -p1 < /tmp/patch
> > patching file drivers/video/fbdev/nvidia/nvidia.c
> > Hunk #1 FAILED at 1197.
> > Hunk #2 FAILED at 1220.
> > Hunk #3 FAILED at 1278.
> > Hunk #4 FAILED at 1298.
> > Hunk #5 FAILED at 1318.
> > Hunk #6 FAILED at 1401.
> > Hunk #7 FAILED at 1415.
> > 7 out of 7 hunks FAILED -- saving rejects to file
> > drivers/video/fbdev/nvidia/nvidia.c.rej
> >
> Are you pulling the patch from email? I guess your email service or
> something is mangling it.
>
> I've attached it to see if that helps.

Thank you! This patch works and I am booting perfectly well now!

~/.backup> uname -a
Linux zenogentoo 6.2.0-rc7-00002-gd2d11f342b17-dirty #144 SMP
PREEMPT_DYNAMIC Mon Feb  6 09:42:58 CET 2023 x86_64 Intel(R) Core(TM)
i7 CPU 960 @ 3.20GHz GenuineIntel GNU/Linux

Please let me know if the patch makes it into mainline for the 6.2 release ;).

Best
Zeno
