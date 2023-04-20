Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B586E9B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjDTSOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDTSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:14:19 -0400
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F43A88
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1682014459; x=1713550459;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=79JZ1qAUMj74S4vtYkiWAHFaJpvNq+/BvXOjD8KVs9Q=;
  b=UrwVP+13PtACvfHB3bG+wtdibLKH3OF+WpFbkS66alLsxnEsSe6QVqfH
   PN6slEIqrSIdJavmmsSJGaLpVm0y77YV8n4LY4xxdgO7yVVfWWMGb3nEE
   1EMOIZemqMANtfUu9p6y5+gMLKFac17dhhTpP7AzrWg8LIjiF/CKcGXSO
   ijcCMKSDAotY0ztA8MJGLxEx2x/QJRctJWRdevFgjYRt3keO+KwUNASlJ
   sdM3FxU6s6IBIyG9OqsF/6i5VTY58fkVx/19ZArA58MxM09Wqn6CiPhoE
   tc3+EQ0q6bUwkl4SRBXOOzlqoUuvwVx2w2gVXeOOlfCXwlInwlsARQrOH
   w==;
Received: from mail-wm1-f69.google.com ([209.85.128.69])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2023 11:14:18 -0700
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f09b608285so3533465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1682014455; x=1684606455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zoh9pDOCC4j4Hix+3gCXWVwjTru62KcX/tiREVIZHqM=;
        b=ap/xHYoQHs5URJuEagPQs3GrVM1cojbDATba7591kOmeHpwB/ZomsYg/3s/2BRMmAx
         FTtOFTR/i3H/cC32FgLVHZSMwiJ5rJDfEhGJ+gjo5FGj0dOIATJpftrWIzppT7eRDL2s
         BEtboSEQQb40mc6yAbt3/Ow2wDyo24cZJYTuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014455; x=1684606455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zoh9pDOCC4j4Hix+3gCXWVwjTru62KcX/tiREVIZHqM=;
        b=FaK6O5zXq28O/T+FNXgoFDLwQLWU+tba0aspLDGVmd5cac+vtqJaVePx8PXDUiWYA7
         7g2nMBjq+OuP4FSoX5UlIONGdLpchvtuW9k6uUcOIKvmt4AboE3R5xMiM+Jh6e8fw8jv
         xTqEH7o6WoNo2LRgky/7Czw1a6vmrT4beJfhHpIlIsJ8LnR+R2IMOZCOQ3h/Q26VAS20
         WOf7WHQmr8rUYOviHKvz+lQKmz7nN1c9T+KlZbEfhdylyeJWJu0IBzjqpZ/Da6AmmeSC
         Xq7A03SgUXiHGbowjZfrXS0u41NfXblRAwuWCOfH8kWtgsTGT1uFSmKBXOwy+KIIajHi
         Umjw==
X-Gm-Message-State: AAQBX9cbsf1T6sOrygT7LY/e1GpFyDool3VKEqpjNhFSBptUOWqBS5IZ
        8eVDJKFtOPUS343q5H8HVna3oDwbqE0y6AwS18ZvL+14qMyv+3oAHSi3efMb2FbpQq34MqwQpIO
        9WgFX+Hk3orlmMjNr6HzpdgBaXXlgrv4ogD/MvdWUxF1BkFHLPMh5
X-Received: by 2002:a5d:4d06:0:b0:2e5:d4f4:c43b with SMTP id z6-20020a5d4d06000000b002e5d4f4c43bmr2135447wrt.55.1682014455357;
        Thu, 20 Apr 2023 11:14:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350bjMEn8mTBrM4XBI0Hr4pmayMt8MRCBDNv/WV/6weTMr0N6o8ABfndJycYj2gF1L50oyOih62bdISX69ZmrlTk=
X-Received: by 2002:a5d:4d06:0:b0:2e5:d4f4:c43b with SMTP id
 z6-20020a5d4d06000000b002e5d4f4c43bmr2135437wrt.55.1682014455063; Thu, 20 Apr
 2023 11:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
 <687864524.118195.1681799447034.JavaMail.zimbra@nod.at> <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
 <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com> <977347543.226888.1682011999468.JavaMail.zimbra@nod.at>
In-Reply-To: <977347543.226888.1682011999468.JavaMail.zimbra@nod.at>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Thu, 20 Apr 2023 11:14:04 -0700
Message-ID: <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
To:     Richard Weinberger <richard@nod.at>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:33=E2=80=AFAM Richard Weinberger <richard@nod.at=
> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > The kernel is in qemu. We find that the `mtd` is from
> > `mtd =3D get_mtd_device(NULL, req.mtd_num);` in function `ctrl_cdev_ioc=
tl`.
> > And we are still trying to figure out what MTD is.
>
> Can you please share the qemu command line?
>

qemu-system-x86_64 -m 2G -smp 2 -kernel
/home/test/Workspace/SyzGen/linux-distro/linux-6.2-debug/arch/x86/boot/bzIm=
age
-append =E2=80=9Cconsole=3DttyS0 root=3D/dev/sda net.ifnames=3D0=E2=80=9D -=
hda
/home/test/Workspace/SyzGen/linux-distro/image/stretch.img -chardev
socket,id=3DSOCKSYZ,server=3Don,nowait,host=3Dlocalhost,port=3D54640 -mon
chardev=3DSOCKSYZ,mode=3Dcontrol -device virtio-rng-pci -device
e1000,netdev=3Dnet0 -netdev
user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:11760-:22 -display non=
e
-serial stdio -cpu host,migratable=3Doff -no-reboot -name VM -snapshot
-enable-kvm

> Within Linux you can query /proc/mtd or /sys/class/mtd/
> to get infos about the MTD in question.
>

Thanks for the hints. We find that this is a =E2=80=9Cmtdram test device=E2=
=80=9D.

root@syzkaller:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00020000 00001000 =E2=80=9Cmtdram test device=E2=80=9D

> Thanks,
> //richard
>
