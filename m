Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A936E586E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDRFQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDRFQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:16:53 -0400
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040E34C37
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1681795011; x=1713331011;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:content-transfer-encoding;
  bh=3yyHcgAuucnuqHYQK8xkrlrcU3xWVsVJyHrX3MFNYBA=;
  b=tpoiTlxvIEqXNn9Yd0heyBvi+MtV/qRl1316AeiNvyTSiqrT0GO5+raj
   HtYgvPG8xv1aVdHrPmXwMR4A/oPqv3M/++rNp3m27MF8K3RJRO/obE/pF
   EqPGDDRRrOQl/QdoTg+WAg6kGAzFgwvNA92xm6CFoP8t34v+ZxvVzJxQB
   a2cqIF/EqMdClYuA3wI+jPNKOkD2+MXxEPq85upMTgDyWaPoB3Z+MbTAj
   5QlYvkAasK4gHV4R8Hq93ydFOjmUl1H7vB1uaSlOEFyShkpTClLSTnAtN
   H5QPQIkMkO56f+k5RlkVtcmp6hB2Z7flgzCNTz6OZI5W28pku8oxPRkcy
   A==;
Received: from mail-wm1-f72.google.com ([209.85.128.72])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 22:16:25 -0700
Received: by mail-wm1-f72.google.com with SMTP id g6-20020a05600c310600b003ee69edec16so15546075wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1681794982; x=1684386982;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSo88ekM07RpY57SnW2OeV+llcfiOK6+PQ1WVcWB5mU=;
        b=O6yVjiqSTvxO9RIvQh6PQwKSHxZPHLnWfl+HVAjC47pxvB8cBwFtB+aKyrWkJy5EZ+
         r4gLAo+5Y1JVwr/vcdoKHir5/QshecfcYs1DezxfvkMQTO7JfkFXK8H58TEPZhhxQo95
         QrP7Q3lsqMloKV2Lz9iTjTnUbuiER0Qc2QCzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681794982; x=1684386982;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSo88ekM07RpY57SnW2OeV+llcfiOK6+PQ1WVcWB5mU=;
        b=eqgYZGAr/rjChmbz1Uf8nqq7rHr1E5YZkz7hYhzMzGYOozcxQbaLmDx4hoVPymb0jx
         HiM8UwJKcHG1bKxXrzBLrf2Qet2jkrOvLSaiXXYFMJFQU7QTplDkHOD+zxJVVtcZZ7VT
         nzW0paZKexEi4crpohN0okGHAXGuHWt9ybSx/SzW3K1iZKKST9TOuwlt43MsUZh0XjDj
         Z29REzxixZH735uXF1iT5OSnYeOUl3lUAsD/nx5sxFH0qEaHEb4w+x2OQg2GA6wGfKjx
         8iq70eLlxQrJveowxZMad2nAjM6afhktVoOouqInFiIIefU6ov0U1pYbqMye3CHccIER
         Zjgg==
X-Gm-Message-State: AAQBX9dZWvAShpy7vqjUVLaNBreVeGm/i+koQWLLX5GgYV1BsICE74qI
        w51TqRk2pWcKAAFdolSJBhkPENunDgE1yhP/fZ+7XHJN4mpt21Q3iok6vTvPJSIHEMmdqbmaZPR
        HASWyDvJzO/NiXa4JzioHWDQM7/05DqPkPTGQbSzhVuLNvJT6OMSVarI=
X-Received: by 2002:a1c:790f:0:b0:3f1:72e3:576b with SMTP id l15-20020a1c790f000000b003f172e3576bmr5229403wme.26.1681794982481;
        Mon, 17 Apr 2023 22:16:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWZe1zBlHke4mh2KAXg8vUbFFdDjWhxdbVMNV7R/dH26YSV26ZkpSPPdng1sFF33WSMQm3cBwZ/xUJ4wH9WFo=
X-Received: by 2002:a1c:790f:0:b0:3f1:72e3:576b with SMTP id
 l15-20020a1c790f000000b003f172e3576bmr5229387wme.26.1681794982164; Mon, 17
 Apr 2023 22:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
In-Reply-To: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 17 Apr 2023 22:16:11 -0700
Message-ID: <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
To:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry that there is a mistake for the full report.
It should be https://gist.github.com/ZHYfeng/ae66bf8167bc341d3753af00e9902b=
1a

On Mon, Apr 17, 2023 at 10:10=E2=80=AFPM Yu Hao <yhao016@ucr.edu> wrote:
>
> Hello,
>
> We found the following issue using syzkaller on Linux v6.2.0.
> The full report:
> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
>
> The brief report is below:
>
> ubi: mtd0 is already attached to ubi0
> ubi7: attaching mtd147
> divide error: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 20023 Comm: syz-executor.0 Not tainted 6.2.0 #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:mtd_div_by_eb include/linux/mtd/mtd.h:580 [inline]
> RIP: 0010:io_init drivers/mtd/ubi/build.c:620 [inline]
> RIP: 0010:ubi_attach_mtd_dev+0x77f/0x2fe0 drivers/mtd/ubi/build.c:955
> Code: fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38
> d0 7c 08 84 d2 0f 85 1f 25 00 00 41 8b 4c 24 10 48 89 d8 31 d2 <48> f7
> f1 48 89 c3 e8 b6 f3 1b fc 48 8d 85 40 17 00 00 48 89 c2 48
> RSP: 0018:ffffc9000be0fd30 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff888047a49d40 RDI: 0000000000000002
> RBP: ffff888024e1c000 R08: 0000000000000016 R09: fffff520017c1f47
> R10: ffffc9000be0fa37 R11: fffff520017c1f46 R12: ffff88806545a000
> R13: 0000000000000000 R14: ffff88806545a010 R15: 0000000000000007
> FS:  00007fd45e85c700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f64aeef53a4 CR3: 000000004f39a000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  ctrl_cdev_ioctl+0x303/0x3a0 drivers/mtd/ubi/cdev.c:1043
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x198/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd45d6902fd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd45e85bc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fd45d7bbf60 RCX: 00007fd45d6902fd
> RDX: 0000000020000000 RSI: 0000000040186f40 RDI: 0000000000000005
> RBP: 00007fd45d6fec89 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff676814bf R14: 00007fff67681670 R15: 00007fd45e85bdc0
>  </TASK>
