Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95EE5C009D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIUPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiIUPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:00:55 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B325E9C;
        Wed, 21 Sep 2022 08:00:53 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 129so7010184vsi.10;
        Wed, 21 Sep 2022 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OP5Fjw4o5jNGU56WDWB7V3CVUo8Nn8eJY8XXiZvxx8A=;
        b=TSnyYblDDCHJIWtpLeruUkU70UH0kTfZQCokzKy3X26WpNbcYxuXbchlVbN31AhRtC
         CE53SvpINJjP7uBVePiEgzGm7zNkHWXt+Du8s3i2/lCR45dqjkdHEh0CUJlaSykThUXx
         8dfi22PzGMobV2QoRfhKe/HpAkOSzJC/RMSeX8NtnNvtJczr1VjGzHhM9yUxhCaPC+m2
         OxcMC+76RvbBM15ZqQ42thWVeiJYk2Ab16OvJEeLM+IunsL2sxfm50Oi+S3vLS2xhH3E
         PDlVTaYyt1/7kR+5r7ooKib6VdcuU7WQJ3cj65OkIfPu9MH8E7SdIZ9K3cHJ+DnBhZQv
         oSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OP5Fjw4o5jNGU56WDWB7V3CVUo8Nn8eJY8XXiZvxx8A=;
        b=bhI8sXjNN/mhompk4m3PFbM+dWxK6ePrg2aI1cF6mfKYalBTBbvkkVAESEX0+S4Zxv
         rdBOiSZ/X2brVhoKGf1SG5HuSmE1XfvDeOROcDSSFTl+YejKprByY2ovtS+ZaKLAeOLc
         wzwe3qc49X8dEDIQq/4ck56lF5NvTuSmscH2FEW+NRsuh0VSpap+2r+ctmqGtqRxbJHR
         SA8e/CBMYnbj7a2a5n5FIC6Fr0jPl+nB8wx2Ho0zZI5TV/+Lhp6+uIz/6oWSCWg+3Zmq
         7DZwN0reFBodhRsxTTMbYTuizYcN3VOIDG25IkW6RJOoCjbm1MHwcFZu6pmmKIblY9u5
         +lWQ==
X-Gm-Message-State: ACrzQf2TQqpxKycpLwF4S84iXhzlKjJzF19NIDxkPH2TfhjCRD3dXAwe
        GyEvezrdT2IYxi/rVOhkVBLXfgkS5AzAEPn2D0I=
X-Google-Smtp-Source: AMsMyM6fjM1Dw/VY49wyiGaEB2wL21u2b4OALdo4oJMeYiqbHOkDV7iVXnwHCszbkoyqFQsYOxjC6B1KQMfY/LeGUS0=
X-Received: by 2002:a67:be16:0:b0:398:c2e4:e01f with SMTP id
 x22-20020a67be16000000b00398c2e4e01fmr10228593vsq.33.1663772452669; Wed, 21
 Sep 2022 08:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
 <YyoDZNZX2ggSuaFE@rowland.harvard.edu>
In-Reply-To: <YyoDZNZX2ggSuaFE@rowland.harvard.edu>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 21 Sep 2022 23:00:41 +0800
Message-ID: <CAB7eexKT341KugNjfEKKVzFNoDJcECh5Ni2mpKSTyp7MqYjAsA@mail.gmail.com>
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

Thanks for your reply!
I applied this patch in v5.19 and the reproducer just attached
a composite device with network and mass storage functions.
The output of the kernel is as follows:

[ 1545.764824][   T29] kauditd_printk_skb: 10 callbacks suppressed
[ 1557.637709][ T7391] cgroup: Unknown subsys name 'net'
[ 1557.641365][ T7391] cgroup: Unknown subsys name 'rlimit'
[ 1557.684875][   T29] audit: type=1800 audit(1663769132.086:80):
pid=7416 uid=0 auid=0 ses=2 subj==unconfined op=collect_data
cause=failed comm="executor.0" name="UDC" dev="co0
[ 1558.186936][   T29] audit: type=1800 audit(1663769132.586:81):
pid=7416 uid=0 auid=0 ses=2 subj==unconfined op=collect_data
cause=failed comm="executor.0" name="UDC" dev="co0
[ 1558.188217][   T29] audit: type=1800 audit(1663769132.586:82):
pid=7416 uid=0 auid=0 ses=2 subj==unconfined op=collect_data
cause=failed comm="executor.0" name="UDC" dev="co0
[ 1558.193766][ T7416] using random self ethernet address
[ 1558.193959][ T7416] using random host ethernet address
[ 1558.194319][ T7416] Mass Storage Function, version: 2009/09/11
[ 1558.194535][ T7416] LUN: removable file: (no medium)
[ 1558.201875][ T7416] usb0: HOST MAC 0e:a1:b6:f7:1a:97
[ 1558.202118][ T7416] usb0: MAC ce:6c:9e:d1:14:db
[ 1558.468458][   T24] usb 2-1: new high-speed USB device number 2
using dummy_hcd
[ 1558.828060][   T24] usb 2-1: Dual-Role OTG device on HNP port
[ 1558.848060][   T24] usb 2-1: New USB device found, idVendor=03f0,
idProduct=0107, bcdDevice= 2.00
[ 1558.848620][   T24] usb 2-1: New USB device strings: Mfr=1,
Product=2, SerialNumber=3
[ 1558.849102][   T24] usb 2-1: Product: Bar Gadget
[ 1558.849407][   T24] usb 2-1: Manufacturer: Foo Inc.
[ 1558.849722][   T24] usb 2-1: SerialNumber: 12345678
[ 1558.868398][ T7423] configfs-gadget gadget.1: Enable bulk in
[ 1558.868675][ T7423] configfs-gadget gadget.1: Enable bulk out
[ 1558.868957][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
[ 1558.952998][   T24] cdc_eem 2-1:1.0 usb1: register 'cdc_eem' at
usb-dummy_hcd.1-1, CDC EEM Device, 72:47:e4:74:0b:8e
[ 1558.968402][   T24] usb-storage 2-1:1.1: USB Mass Storage device detected
[ 1558.976267][   T24] scsi host2: usb-storage 2-1:1.1
[ 1560.028547][ T7470] cdc_eem 2-1:1.0 usb1: unregister 'cdc_eem'
usb-dummy_hcd.1-1, CDC EEM Device
[ 1560.078980][ T7470] configfs-gadget gadget.1: Bulk out complete
ffff8881279f0b00
[ 1560.080226][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
[ 1560.080617][ T7470] configfs-gadget gadget.1: Disable bulk in B
[ 1560.080820][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
[ 1560.081456][ T7470] configfs-gadget gadget.1: Disable bulk out B
[ 1560.081950][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
[ 1560.083056][ T7423] ------------[ cut here ]------------
[ 1560.083386][ T7423] WARNING: CPU: 0 PID: 7423 at
drivers/usb/gadget/udc/core.c:283 usb_ep_queue+0x9b/0x3b0
[ 1560.083968][ T7423] Modules linked in:
[ 1560.084163][ T7423] CPU: 0 PID: 7423 Comm: file-storage Not tainted
5.19.0+ #15
[ 1560.084522][ T7423] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[ 1560.085169][ T7423] RIP: 0010:usb_ep_queue+0x9b/0x3b0
[ 1560.085512][ T7423] Code: 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 db
02 00 00 44 0f b6 6b 35 31 ff 44 89 ee e8 af 41 b2 fb 45 84 ed 74 0e
e8 55 46 b2 fb <0f> 0b bd 94 ff ff ff eb0
[ 1560.086782][ T7423] RSP: 0018:ffffc900043efd00 EFLAGS: 00010293
[ 1560.087104][ T7423] RAX: 0000000000000000 RBX: ffff888110abc2c0
RCX: 0000000000000000
[ 1560.087600][ T7423] RDX: ffff88807e9f3800 RSI: ffffffff85c6d79b
RDI: 0000000000000001
[ 1560.088798][ T7423] RBP: 0000000000000cc0 R08: 0000000000000001
R09: 0000000000000000
[ 1560.089461][ T7423] R10: 0000000000000007 R11: 0000000000000000
R12: ffff88811c2bcf10
[ 1560.090090][ T7423] R13: 0000000000000007 R14: ffff88812505e000
R15: dffffc0000000000
[ 1560.090721][ T7423] FS:  0000000000000000(0000)
GS:ffff888128c00000(0000) knlGS:0000000000000000
[ 1560.091455][ T7423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1560.091982][ T7423] CR2: 00007f2fbc03f0c8 CR3: 000000011ee22000
CR4: 00000000000006f0
[ 1560.092632][ T7423] Call Trace:
[ 1560.092914][ T7423]  <TASK>
[ 1560.093153][ T7423]  start_transfer+0x24/0x14f
[ 1560.093523][ T7423]  start_out_transfer.part.0+0xf1/0x13d
[ 1560.093987][ T7423]  fsg_main_thread+0x385/0x1460
[ 1560.094395][ T7423]  ? __kthread_parkme+0xc4/0x210
[ 1560.094810][ T7423]  ? reacquire_held_locks+0x4b0/0x4b0
[ 1560.095241][ T7423]  ? do_set_interface.isra.0+0x530/0x530
[ 1560.095713][ T7423]  ? __kthread_parkme+0x14e/0x210
[ 1560.096136][ T7423]  ? do_set_interface.isra.0+0x530/0x530
[ 1560.096590][ T7423]  kthread+0x2e0/0x390
[ 1560.096929][ T7423]  ? kthread_complete_and_exit+0x40/0x40
[ 1560.097404][ T7423]  ret_from_fork+0x1f/0x30
[ 1560.097786][ T7423]  </TASK>
[ 1560.098792][ T7423] Kernel panic - not syncing: panic_on_warn set ...
[ 1560.099342][ T7423] CPU: 0 PID: 7423 Comm: file-storage Not tainted
5.19.0+ #15
[ 1560.099938][ T7423] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[ 1560.100752][ T7423] Call Trace:
[ 1560.101031][ T7423]  <TASK>
[ 1560.101275][ T7423]  dump_stack_lvl+0xfc/0x174
[ 1560.101660][ T7423]  panic+0x2cf/0x61f
[ 1560.101990][ T7423]  ? panic_print_sys_info.part.0+0x10b/0x10b
[ 1560.102522][ T7423]  ? __warn.cold+0xcd/0x2cc
[ 1560.102910][ T7423]  ? usb_ep_queue+0x9b/0x3b0
[ 1560.103301][ T7423]  __warn.cold+0xde/0x2cc
[ 1560.103661][ T7423]  ? usb_ep_queue+0x9b/0x3b0
[ 1560.104044][ T7423]  report_bug+0x1b7/0x240
[ 1560.104425][ T7423]  handle_bug+0x3c/0x60
[ 1560.104762][ T7423]  exc_invalid_op+0x13/0x40
[ 1560.105129][ T7423]  asm_exc_invalid_op+0x16/0x20
[ 1560.105525][ T7423] RIP: 0010:usb_ep_queue+0x9b/0x3b0
[ 1560.105951][ T7423] Code: 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 db
02 00 00 44 0f b6 6b 35 31 ff 44 89 ee e8 af 41 b2 fb 45 84 ed 74 0e
e8 55 46 b2 fb <0f> 0b bd 94 ff ff ff eb0
[ 1560.107487][ T7423] RSP: 0018:ffffc900043efd00 EFLAGS: 00010293
[ 1560.107978][ T7423] RAX: 0000000000000000 RBX: ffff888110abc2c0
RCX: 0000000000000000
[ 1560.108633][ T7423] RDX: ffff88807e9f3800 RSI: ffffffff85c6d79b
RDI: 0000000000000001
[ 1560.109247][ T7423] RBP: 0000000000000cc0 R08: 0000000000000001
R09: 0000000000000000
[ 1560.109896][ T7423] R10: 0000000000000007 R11: 0000000000000000
R12: ffff88811c2bcf10
[ 1560.110538][ T7423] R13: 0000000000000007 R14: ffff88812505e000
R15: dffffc0000000000
[ 1560.111167][ T7423]  ? usb_ep_queue+0x9b/0x3b0
[ 1560.111551][ T7423]  start_transfer+0x24/0x14f
[ 1560.111940][ T7423]  start_out_transfer.part.0+0xf1/0x13d
[ 1560.112406][ T7423]  fsg_main_thread+0x385/0x1460
[ 1560.112800][ T7423]  ? __kthread_parkme+0xc4/0x210
[ 1560.113045][ T7423]  ? reacquire_held_locks+0x4b0/0x4b0
[ 1560.113303][ T7423]  ? do_set_interface.isra.0+0x530/0x530
[ 1560.113586][ T7423]  ? __kthread_parkme+0x14e/0x210
[ 1560.113834][ T7423]  ? do_set_interface.isra.0+0x530/0x530
[ 1560.114103][ T7423]  kthread+0x2e0/0x390
[ 1560.114301][ T7423]  ? kthread_complete_and_exit+0x40/0x40
[ 1560.114587][ T7423]  ret_from_fork+0x1f/0x30
[ 1560.114813][ T7423]  </TASK>
[ 1560.115078][ T7423] Kernel Offset: disabled
[ 1560.115319][ T7423] Rebooting in 86400 seconds..

On Wed, Sep 21, 2022 at 2:16 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Aug 11, 2022 at 10:12:04AM +0800, Rondreis wrote:
> > Hello,
> >
> > When fuzzing the Linux kernel driver 5.19.0-rc4-00208-g69cb6c6556ad,
> > the following crash was triggered.
> >
> > HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
> > git tree: upstream
> >
> > kernel config: https://pastebin.com/KecL2gaG
> > C reproducer: https://pastebin.com/wLDJ9cnP
> > console output: https://pastebin.com/t0r8EwTw
> >
> > Basically, in the c reproducer, we use the gadget module to emulate
> > the process of attaching a usb device (vendor id: 0xbaf, product id:
> > 0x121, with function: midi and ms_null).
> > To reproduce this crash, we utilize a third-party library to emulate
> > the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> > Just clone this repository, make install it, and compile the c
> > reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
> > trick.
> >
> > It seems that an error state in struct usb_ep trigger such kernel warning.
> >
> > The crash report is as follow:
> >
> > ```
> > ------------[ cut here ]------------
> > ------------[ cut here ]------------
> > WARNING: CPU: 3 PID: 3442 at drivers/usb/gadget/udc/core.c:283
> > usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
> > Modules linked in:
> > CPU: 3 PID: 3442 Comm: file-storage Not tainted
> > 5.19.0-rc4-00208-g69cb6c6556ad #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
> > Code: 46 05 0f 92 c3 31 ff 89 de e8 f1 e9 49 fd 84 db 0f 85 16 01 00
> > 00 e8 c4 e8 49 fd 44 89 e0 5b 5d 41 5c 41 5d c3 e8 b5 e8 49 fd <0f> 0b
> > 41 bc 94 ff ff ff e9 73 ff ff ff e8 a3 e8 49 fd 65 8b 1d cc
> > RSP: 0018:ffffc9000490fd00 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff888110e0d580
> > RDX: 0000000000000000 RSI: ffff888110e0d580 RDI: 0000000000000002
> > RBP: ffff88810ae84158 R08: ffffffff83fb31eb R09: 0000000000000000
> > R10: 0000000000000001 R11: ffffed10221c1ab0 R12: 0000000000000cc0
> > R13: ffff888111843f10 R14: ffff888111843f10 R15: ffff88811084e000
> > FS: 0000000000000000(0000) GS:ffff88811a980000(0000) knlGS:0000000000000000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f841985e020 CR3: 000000010d19a000 CR4: 0000000000350ee0
> > Call Trace:
> > <TASK>
> > start_transfer.isra.0+0x26/0x100
> > drivers/usb/gadget/function/f_mass_storage.c:527
> > start_out_transfer.isra.0+0xf0/0x1b0
> > drivers/usb/gadget/function/f_mass_storage.c:560
> > get_next_command drivers/usb/gadget/function/f_mass_storage.c:2249 [inline]
> > fsg_main_thread+0x377/0x6fc0 drivers/usb/gadget/function/f_mass_storage.c:2572
> > kthread+0x2ef/0x3a0 kernel/kthread.c:376
> > ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> > </TASK>
>
> Can you please try to recreate this bug after applying the diagnostic
> patch below?  I'd like to see what output it produces in the kernel log.
>
> Alan Stern
>
>
> Index: usb-devel/drivers/usb/gadget/function/f_mass_storage.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/gadget/function/f_mass_storage.c
> +++ usb-devel/drivers/usb/gadget/function/f_mass_storage.c
> @@ -415,6 +415,7 @@ static void bulk_in_complete(struct usb_
>         struct fsg_common       *common = ep->driver_data;
>         struct fsg_buffhd       *bh = req->context;
>
> +       dev_info(&common->gadget->dev, "Bulk in complete %p\n", bh);
>         if (req->status || req->actual != req->length)
>                 DBG(common, "%s --> %d, %u/%u\n", __func__,
>                     req->status, req->actual, req->length);
> @@ -431,6 +432,7 @@ static void bulk_out_complete(struct usb
>         struct fsg_common       *common = ep->driver_data;
>         struct fsg_buffhd       *bh = req->context;
>
> +       dev_info(&common->gadget->dev, "Bulk out complete %p\n", bh);
>         dump_msg(common, "bulk-out", req->buf, req->actual);
>         if (req->status || req->actual != bh->bulk_out_intended_length)
>                 DBG(common, "%s --> %d, %u/%u\n", __func__,
> @@ -547,6 +549,7 @@ static bool start_in_transfer(struct fsg
>         if (!fsg_is_set(common))
>                 return false;
>         bh->state = BUF_STATE_SENDING;
> +       dev_info(&common->gadget->dev, "Bulk in start %p\n", bh);
>         if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
>                 bh->state = BUF_STATE_EMPTY;
>         return true;
> @@ -557,6 +560,7 @@ static bool start_out_transfer(struct fs
>         if (!fsg_is_set(common))
>                 return false;
>         bh->state = BUF_STATE_RECEIVING;
> +       dev_info(&common->gadget->dev, "Bulk out start %p\n", bh);
>         if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
>                 bh->state = BUF_STATE_FULL;
>         return true;
> @@ -2310,10 +2314,12 @@ reset:
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
>                 }
> @@ -2333,6 +2339,7 @@ reset:
>         rc = config_ep_by_speed(common->gadget, &(fsg->function), fsg->bulk_in);
>         if (rc)
>                 goto reset;
> +       dev_info(&fsg->gadget->dev, "Enable bulk in\n");
>         rc = usb_ep_enable(fsg->bulk_in);
>         if (rc)
>                 goto reset;
> @@ -2343,6 +2350,7 @@ reset:
>                                 fsg->bulk_out);
>         if (rc)
>                 goto reset;
> +       dev_info(&fsg->gadget->dev, "Enable bulk out\n");
>         rc = usb_ep_enable(fsg->bulk_out);
>         if (rc)
>                 goto reset;
> @@ -2392,10 +2400,12 @@ static void fsg_disable(struct usb_funct
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
>         }
>
