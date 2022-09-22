Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2145E5DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIVIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiIVIjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:39:20 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8DB40F1;
        Thu, 22 Sep 2022 01:39:17 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id c3so9496511vsc.6;
        Thu, 22 Sep 2022 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5ZdxV8Brjj/Suv2/cofeSh9Hz3MiY7b81keNWiqU8jg=;
        b=gXw/DcDXcNKxF9c688lJpyRoRqU22AVsqSG9cthEpO/dx2E2SOyTceffeCoIfZ2mXB
         yha4sBW9lTiZ3ltYfsv6E/jdfwKU6+oyRu2TNRnXp62QRZ8otO+x+y6qLWofCfguW5sW
         lTi51/ReP52wbwLIKGe4eUz/09jMtUgrXPM5g0fc5jv3iNY5wsQHvqB2qDMWj4aCVLEs
         /ArR3V+3OiFObyu8maeKFevZeU8FsMBvD6d7sEbyAJXXJkOu0fSybhx0BrfrL4l5pWYw
         GPUapZnGt/LgGE7ZOMcRGoh9pPlJctdkmtVCVPcG337Iq0d31CxLERIxofrKa8ZJCiIg
         dPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5ZdxV8Brjj/Suv2/cofeSh9Hz3MiY7b81keNWiqU8jg=;
        b=IJzYDaty2282Ww55VcQApPpE654IhkKFZFANLV/rNpiGmYnEC9jMAGFETsylZ4hfZt
         fAcQnj3Mll677mkI73nhVFujncWnkXUJ1pynwUzYF7dBxMfQCcQ/FogvJMiXC950apez
         W3wm1KwVhJ8KWY3XZDboJ/JarThRGKhHZSSDis9+tANGt6gdDfi3kOT5t8+bS9TddLVh
         FO6PKg0612uMOLvvxuHmxD4HxNHCPFEl8Z40Ch1QzBjWG351Zu+mnq3gGV/YTP5Zx7FP
         AHzEnyb/fq46J4LqggFaSirZ+A0+QERs7EMUEUZyCgNlos8H9EPHw1dGqOMARtllHUhE
         HOgg==
X-Gm-Message-State: ACrzQf0M6p94Jt/0vviFZbkdhTQxXp+oaxByUW+9y0WsRk1stQne+4PM
        JaBkAyBIRmTxJky0KEh6EcCAy5lrycFPpOdewoI=
X-Google-Smtp-Source: AMsMyM6FA9t/VIYmOCi6QH3RWG/d9t8B52UtHahMVyx6TK8TBGvlHNuNCVbdQq4MBDKpHmn1/t34U85VwlV3z39vXeI=
X-Received: by 2002:a67:be16:0:b0:398:c2e4:e01f with SMTP id
 x22-20020a67be16000000b00398c2e4e01fmr679762vsq.33.1663835956410; Thu, 22 Sep
 2022 01:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
 <YyoDZNZX2ggSuaFE@rowland.harvard.edu> <CAB7eexKT341KugNjfEKKVzFNoDJcECh5Ni2mpKSTyp7MqYjAsA@mail.gmail.com>
 <Yys1UHJ/+XoKyR6Y@rowland.harvard.edu>
In-Reply-To: <Yys1UHJ/+XoKyR6Y@rowland.harvard.edu>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 22 Sep 2022 16:39:04 +0800
Message-ID: <CAB7eexJQbrp-ZWben6bVt7SVwYRu1cqPxQHunmsZqT0AjQH-vg@mail.gmail.com>
Subject: Re: kernel v5.19 warn in usb_ep_queue
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, andriy.shevchenko@linux.intel.com,
        jakobkoschel@gmail.com, quic_wcheng@quicinc.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I patched it again, and the output is:

[   53.871222][ T6507] cgroup: Unknown subsys name 'net'
[   53.874463][ T6507] cgroup: Unknown subsys name 'rlimit'
[   54.426894][   T28] audit: type=1800 audit(1663835481.621:4):
pid=6532 uid=0 auid=0 ses=2 subj==unconfined op=collect_data
cause=failed comm="syz-executor.0" name="UDC" dev="configfs" ino=30794
res=0 errno=0
[   54.435086][ T6532] using random self ethernet address
[   54.435402][ T6532] using random host ethernet address
[   54.436060][ T6532] Mass Storage Function, version: 2009/09/11
[   54.436437][ T6532] LUN: removable file: (no medium)
[   54.444557][ T6532] usb0: HOST MAC 1a:89:f1:74:ef:df
[   54.444853][ T6532] usb0: MAC 5e:3b:64:0f:0b:ed
[   54.721631][   T24] usb 2-1: new high-speed USB device number 2
using dummy_hcd
[   55.131602][   T24] usb 2-1: Dual-Role OTG device on HNP port
[   55.151589][   T24] usb 2-1: New USB device found, idVendor=03f0,
idProduct=0107, bcdDevice= 2.00
[   55.151919][   T24] usb 2-1: New USB device strings: Mfr=1,
Product=2, SerialNumber=3
[   55.152199][   T24] usb 2-1: Product: Bar Gadget
[   55.152374][   T24] usb 2-1: Manufacturer: Foo Inc.
[   55.152557][   T24] usb 2-1: SerialNumber: 12345678
[   55.171998][    C1] configfs-gadget gadget.1: Raise exception 3
ffff88811b9ba000
[   55.172604][ T6539] configfs-gadget gadget.1: Enable bulk in
[   55.172884][ T6539] configfs-gadget gadget.1: Enable bulk out
[   55.173179][ T6539] configfs-gadget gadget.1: Bulk out start ffff888115fd7c80
[   55.173506][ T6539] CPU: 0 PID: 6539 Comm: file-storage Not tainted
5.19.0+ #16
[   55.173834][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[   55.174193][ T6539] Call Trace:
[   55.174316][ T6539]  <TASK>
[   55.174425][ T6539]  dump_stack_lvl+0xfc/0x174
[   55.174602][ T6539]  start_out_transfer.part.0+0x7c/0x142
[   55.174813][ T6539]  fsg_main_thread+0x375/0x1450
[   55.175004][ T6539]  ? __kthread_parkme+0xc4/0x210
[   55.175191][ T6539]  ? reacquire_held_locks+0x4b0/0x4b0
[   55.175392][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   55.175606][ T6539]  ? __kthread_parkme+0x14e/0x210
[   55.175797][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   55.176005][ T6539]  kthread+0x2e0/0x390
[   55.176156][ T6539]  ? kthread_complete_and_exit+0x40/0x40
[   55.176363][ T6539]  ret_from_fork+0x1f/0x30
[   55.176537][ T6539]  </TASK>
[   55.253779][   T24] cdc_eem 2-1:1.0 usb1: register 'cdc_eem' at
usb-dummy_hcd.1-1, CDC EEM Device, c2:07:46:1b:bf:4a
[   55.271856][   T24] usb-storage 2-1:1.1: USB Mass Storage device detected
[   55.278904][   T24] scsi host2: usb-storage 2-1:1.1
[   56.352122][ T6584] cdc_eem 2-1:1.0 usb1: unregister 'cdc_eem'
usb-dummy_hcd.1-1, CDC EEM Device
[   56.412714][ T6584] configfs-gadget gadget.1: Bulk out complete
ffff888115fd7c80
[   56.413545][ T6539] configfs-gadget gadget.1: Bulk out start ffff888115fd7c80
[   56.413787][ T6584] configfs-gadget gadget.1: Disable bulk in B
[   56.413988][ T6539] CPU: 1 PID: 6539 Comm: file-storage Not tainted
5.19.0+ #16
[   56.414336][ T6584] configfs-gadget gadget.1: Disable bulk out B
[   56.414647][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[   56.414908][ T6584] configfs-gadget gadget.1: Disable bulk out B finished
[   56.415348][ T6539] Call Trace:
[   56.415352][ T6539]  <TASK>
[   56.415827][ T6584] configfs-gadget gadget.1: Raise exception 3
0000000000000000
[   56.415969][ T6539]  dump_stack_lvl+0xfc/0x174
[   56.416735][ T6539]  start_out_transfer.part.0+0x7c/0x142
[   56.416989][ T6539]  fsg_main_thread+0x375/0x1450
[   56.417256][ T6539]  ? __kthread_parkme+0xc4/0x210
[   56.417560][ T6539]  ? reacquire_held_locks+0x4b0/0x4b0
[   56.417885][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   56.418231][ T6539]  ? __kthread_parkme+0x14e/0x210
[   56.418576][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   56.418919][ T6539]  kthread+0x2e0/0x390
[   56.419172][ T6539]  ? kthread_complete_and_exit+0x40/0x40
[   56.419515][ T6539]  ret_from_fork+0x1f/0x30
[   56.419804][ T6539]  </TASK>
[   56.420255][ T6539] ------------[ cut here ]------------
[   56.420496][ T6539] WARNING: CPU: 1 PID: 6539 at
drivers/usb/gadget/udc/core.c:283 usb_ep_queue+0x9b/0x3b0
[   56.420923][ T6539] Modules linked in:
[   56.421102][ T6539] CPU: 1 PID: 6539 Comm: file-storage Not tainted
5.19.0+ #16
[   56.421429][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[   56.431805][ T6539] RIP: 0010:usb_ep_queue+0x9b/0x3b0
[   56.432129][ T6539] Code: 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 db
02 00 00 44 0f b6 6b 35 31 ff 44 89 ee e8 af 41 b2 fb 45 84 ed 74 0e
e8 55 46 b2 fb <0f> 0b bd 94 ff ff ff eb 55 e8 47 46 b2 fb 48 8d 7b 10
0
[   56.433208][ T6539] RSP: 0018:ffffc900047afd08 EFLAGS: 00010293
[   56.433560][ T6539] RAX: 0000000000000000 RBX: ffff8881107d82c0
RCX: 0000000000000000
[   56.434009][ T6539] RDX: ffff8881196d1c00 RSI: ffffffff85c6d79b
RDI: 0000000000000001
[   56.434452][ T6539] RBP: 0000000000000cc0 R08: 0000000000000001
R09: 0000000000000000
[   56.434898][ T6539] R10: 0000000000000007 R11: 0000000000000000
R12: ffff888113c6a210
[   56.435350][ T6539] R13: 0000000000000007 R14: ffff8881197c9000
R15: dffffc0000000000
[   56.435796][ T6539] FS:  0000000000000000(0000)
GS:ffff888128c00000(0000) knlGS:0000000000000000
[   56.436296][ T6539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.436666][ T6539] CR2: 00005611a32a2d30 CR3: 000000011b5aa000
CR4: 00000000000006f0
[   56.437111][ T6539] Call Trace:
[   56.437305][ T6539]  <TASK>
[   56.437479][ T6539]  start_transfer+0x24/0x14f
[   56.437752][ T6539]  start_out_transfer.part.0+0xf6/0x142
[   56.438076][ T6539]  fsg_main_thread+0x375/0x1450
[   56.438370][ T6539]  ? __kthread_parkme+0xc4/0x210
[   56.438660][ T6539]  ? reacquire_held_locks+0x4b0/0x4b0
[   56.438973][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   56.439306][ T6539]  ? __kthread_parkme+0x14e/0x210
[   56.439604][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   56.439932][ T6539]  kthread+0x2e0/0x390
[   56.440171][ T6539]  ? kthread_complete_and_exit+0x40/0x40
[   56.440497][ T6539]  ret_from_fork+0x1f/0x30
[   56.440767][ T6539]  </TASK>
[   56.440949][ T6539] Kernel panic - not syncing: panic_on_warn set ...
[   56.441321][ T6539] CPU: 0 PID: 6539 Comm: file-storage Not tainted
5.19.0+ #16
[   56.441751][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[   56.442322][ T6539] Call Trace:
[   56.442515][ T6539]  <TASK>
[   56.442687][ T6539]  dump_stack_lvl+0xfc/0x174
[   56.442959][ T6539]  panic+0x2cf/0x61f
[   56.443194][ T6539]  ? panic_print_sys_info.part.0+0x10b/0x10b
[   56.443545][ T6539]  ? __warn.cold+0xcd/0x2cc
[   56.443812][ T6539]  ? usb_ep_queue+0x9b/0x3b0
[   56.444085][ T6539]  __warn.cold+0xde/0x2cc
[   56.444341][ T6539]  ? usb_ep_queue+0x9b/0x3b0
[   56.444612][ T6539]  report_bug+0x1b7/0x240
[   56.444870][ T6539]  handle_bug+0x3c/0x60
[   56.445119][ T6539]  exc_invalid_op+0x13/0x40
[   56.445386][ T6539]  asm_exc_invalid_op+0x16/0x20
[   56.445671][ T6539] RIP: 0010:usb_ep_queue+0x9b/0x3b0
[   56.445971][ T6539] Code: 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 db
02 00 00 44 0f b6 6b 35 31 ff 44 89 ee e8 af 41 b2 fb 45 84 ed 74 0e
e8 55 46 b2 fb <0f> 0b bd 94 ff ff ff eb 55 e8 47 46 b2 fb 48 8d 7b 10
0
[   56.447050][ T6539] RSP: 0018:ffffc900047afd08 EFLAGS: 00010293
[   56.447400][ T6539] RAX: 0000000000000000 RBX: ffff8881107d82c0
RCX: 0000000000000000
[   56.447849][ T6539] RDX: ffff8881196d1c00 RSI: ffffffff85c6d79b
RDI: 0000000000000001
[   56.448301][ T6539] RBP: 0000000000000cc0 R08: 0000000000000001
R09: 0000000000000000
[   56.448752][ T6539] R10: 0000000000000007 R11: 0000000000000000
R12: ffff888113c6a210
[   56.449196][ T6539] R13: 0000000000000007 R14: ffff8881197c9000
R15: dffffc0000000000
[   56.449648][ T6539]  ? usb_ep_queue+0x9b/0x3b0
[   56.449921][ T6539]  ? usb_ep_queue+0x9b/0x3b0
[   56.450193][ T6539]  start_transfer+0x24/0x14f
[   56.450468][ T6539]  start_out_transfer.part.0+0xf6/0x142
[   56.450795][ T6539]  fsg_main_thread+0x375/0x1450
[   56.451082][ T6539]  ? __kthread_parkme+0xc4/0x210
[   56.451376][ T6539]  ? reacquire_held_locks+0x4b0/0x4b0
[   56.451693][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   56.452024][ T6539]  ? __kthread_parkme+0x14e/0x210
[   56.452324][ T6539]  ? do_set_interface.isra.0+0x530/0x530
[   56.452649][ T6539]  kthread+0x2e0/0x390
[   56.452890][ T6539]  ? kthread_complete_and_exit+0x40/0x40
[   56.453216][ T6539]  ret_from_fork+0x1f/0x30
[   56.453489][ T6539]  </TASK>
[   56.453826][ T6539] Kernel Offset: disabled
[   56.454117][ T6539] Rebooting in 86400 seconds..


On Thu, Sep 22, 2022 at 12:01 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Sep 21, 2022 at 11:00:41PM +0800, Rondreis wrote:
> > Thanks for your reply!
> > I applied this patch in v5.19 and the reproducer just attached
> > a composite device with network and mass storage functions.
> > The output of the kernel is as follows:
>
> > [ 1558.868398][ T7423] configfs-gadget gadget.1: Enable bulk in
> > [ 1558.868675][ T7423] configfs-gadget gadget.1: Enable bulk out
> > [ 1558.868957][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> > [ 1558.952998][   T24] cdc_eem 2-1:1.0 usb1: register 'cdc_eem' at
> > usb-dummy_hcd.1-1, CDC EEM Device, 72:47:e4:74:0b:8e
> > [ 1558.968402][   T24] usb-storage 2-1:1.1: USB Mass Storage device detected
> > [ 1558.976267][   T24] scsi host2: usb-storage 2-1:1.1
> > [ 1560.028547][ T7470] cdc_eem 2-1:1.0 usb1: unregister 'cdc_eem'
> > usb-dummy_hcd.1-1, CDC EEM Device
> > [ 1560.078980][ T7470] configfs-gadget gadget.1: Bulk out complete
> > ffff8881279f0b00
> > [ 1560.080226][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> > [ 1560.080617][ T7470] configfs-gadget gadget.1: Disable bulk in B
> > [ 1560.080820][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> > [ 1560.081456][ T7470] configfs-gadget gadget.1: Disable bulk out B
> > [ 1560.081950][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> > [ 1560.083056][ T7423] ------------[ cut here ]------------
> > [ 1560.083386][ T7423] WARNING: CPU: 0 PID: 7423 at
> > drivers/usb/gadget/udc/core.c:283 usb_ep_queue+0x9b/0x3b0
>
> Okay, that's not what I expected.  Can you try the same thing with
> updated patch below?
>
> Alan Stern
>
>
> Index: usb-devel/drivers/usb/gadget/function/f_mass_storage.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/gadget/function/f_mass_storage.c
> +++ usb-devel/drivers/usb/gadget/function/f_mass_storage.c
> @@ -367,6 +367,7 @@ static void __raise_exception(struct fsg
>  {
>         unsigned long           flags;
>
> +       dev_info(&common->gadget->dev, "Raise exception %d %p\n", new_state, arg);
>         /*
>          * Do nothing if a higher-priority exception is already in progress.
>          * If a lower-or-equal priority exception is in progress, preempt it
> @@ -415,6 +416,7 @@ static void bulk_in_complete(struct usb_
>         struct fsg_common       *common = ep->driver_data;
>         struct fsg_buffhd       *bh = req->context;
>
> +       dev_info(&common->gadget->dev, "Bulk in complete %p\n", bh);
>         if (req->status || req->actual != req->length)
>                 DBG(common, "%s --> %d, %u/%u\n", __func__,
>                     req->status, req->actual, req->length);
> @@ -431,6 +433,7 @@ static void bulk_out_complete(struct usb
>         struct fsg_common       *common = ep->driver_data;
>         struct fsg_buffhd       *bh = req->context;
>
> +       dev_info(&common->gadget->dev, "Bulk out complete %p\n", bh);
>         dump_msg(common, "bulk-out", req->buf, req->actual);
>         if (req->status || req->actual != bh->bulk_out_intended_length)
>                 DBG(common, "%s --> %d, %u/%u\n", __func__,
> @@ -547,6 +550,7 @@ static bool start_in_transfer(struct fsg
>         if (!fsg_is_set(common))
>                 return false;
>         bh->state = BUF_STATE_SENDING;
> +       dev_info(&common->gadget->dev, "Bulk in start %p\n", bh);
>         if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
>                 bh->state = BUF_STATE_EMPTY;
>         return true;
> @@ -557,6 +561,8 @@ static bool start_out_transfer(struct fs
>         if (!fsg_is_set(common))
>                 return false;
>         bh->state = BUF_STATE_RECEIVING;
> +       dev_info(&common->gadget->dev, "Bulk out start %p\n", bh);
> +       dump_stack();
>         if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
>                 bh->state = BUF_STATE_FULL;
>         return true;
> @@ -2310,12 +2316,15 @@ reset:
>
>                 /* Disable the endpoints */
>                 if (fsg->bulk_in_enabled) {
> +                       dev_info(&fsg->gadget->dev, "Disable bulk in A\n");
>                         usb_ep_disable(fsg->bulk_in);
>                         fsg->bulk_in_enabled = 0;
>                 }
>                 if (fsg->bulk_out_enabled) {
> +                       dev_info(&fsg->gadget->dev, "Disable bulk out A\n");
>                         usb_ep_disable(fsg->bulk_out);
>                         fsg->bulk_out_enabled = 0;
> +                       dev_info(&fsg->gadget->dev, "Disable bulk out A finished\n");
>                 }
>
>                 common->fsg = NULL;
> @@ -2333,6 +2342,7 @@ reset:
>         rc = config_ep_by_speed(common->gadget, &(fsg->function), fsg->bulk_in);
>         if (rc)
>                 goto reset;
> +       dev_info(&fsg->gadget->dev, "Enable bulk in\n");
>         rc = usb_ep_enable(fsg->bulk_in);
>         if (rc)
>                 goto reset;
> @@ -2343,6 +2353,7 @@ reset:
>                                 fsg->bulk_out);
>         if (rc)
>                 goto reset;
> +       dev_info(&fsg->gadget->dev, "Enable bulk out\n");
>         rc = usb_ep_enable(fsg->bulk_out);
>         if (rc)
>                 goto reset;
> @@ -2392,12 +2403,15 @@ static void fsg_disable(struct usb_funct
>
>         /* Disable the endpoints */
>         if (fsg->bulk_in_enabled) {
> +               dev_info(&fsg->gadget->dev, "Disable bulk in B\n");
>                 usb_ep_disable(fsg->bulk_in);
>                 fsg->bulk_in_enabled = 0;
>         }
>         if (fsg->bulk_out_enabled) {
> +               dev_info(&fsg->gadget->dev, "Disable bulk out B\n");
>                 usb_ep_disable(fsg->bulk_out);
>                 fsg->bulk_out_enabled = 0;
> +               dev_info(&fsg->gadget->dev, "Disable bulk out B finished\n");
>         }
>
>         __raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
>
