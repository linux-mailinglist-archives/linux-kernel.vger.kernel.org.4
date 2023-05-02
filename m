Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD86F43B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjEBMWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEBMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:22:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28349F0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:22:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3062d764455so1482181f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683030146; x=1685622146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx4CtFX9QxyVfk/q3EEN11kGuSB1DWR9fWIlov2TAkU=;
        b=1WWbgGlysQzIaLwC2UzSNHkkmgcvAvwA9Hiy9w17z5oE9XrjkKB9OuxVqL3L9damxD
         tAkj+sI8O+kiGEBfw0XhSp44ZQianpCGDkb3DakG116pRMUejON2+bmiB0w5RXNmFDR7
         HwNMOi6XA3M+ZehLDUqSrLQw1FrjDMnIlHSZLCfeuRXKeiIfnRCcvc1IBjUes+8CzCe1
         6jO4L+w8JQqes7ddeDH19bgDUJtdQnm9E/lg7d0X8ARa5wioN4Ud3/Pgf3PuPQ+KrDiA
         Dbv9KPdZXFT38QINmWTFJay5u4F1j15tki6/SszDigq5Rc3zrtoDHkBtA+D2QcOjvYD5
         pVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683030146; x=1685622146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nx4CtFX9QxyVfk/q3EEN11kGuSB1DWR9fWIlov2TAkU=;
        b=TcagaLUCvZUxeNOqqbCU+k5/iIgnffVwMjiZK4DxiPHS6ikQGtw+0Mj2K8BzvCPFzk
         Xrg2aolOZ9OwTvZ3e/XCMoilwyBSJPtryr6lM9bB5HQDg4m/QFNretfoM35oi2HMX3P/
         gtlduZXzqCbvM3co76LVouprXbtB2zZ76wTvUcDoVV17tsRu8CTETAf+jCHjjmb59gXB
         1k46dB7QpWaFtXJi9pvTQTfiQ+l5cOy0PD+4293dG05aoykgbIa8cmmJiDFwW2au0Kfy
         3pM4YueiXiUJMq/ye2lpy1WC0St2/8DWw/2hpla6UNPu6kCMw+M8MQDkyXEIM0uhxWZ1
         Xe+g==
X-Gm-Message-State: AC+VfDzxnLuwScJ26yEP555w5F6FqmC+CvIVSYtHZf6CuVkxHMc2iWK5
        TQYHU5wKl/9gIrx2OyEpuSsOQc7koskKEaRTqwY6zw==
X-Google-Smtp-Source: ACHHUZ7gL7v2p9lIQ9ZYhZIRIXsEdQKGPPd4p1XkwAS5t5RnwYfSKbGo75GmV0zdqESpeLFdljuN3hFCqrQ4p1mIJQc=
X-Received: by 2002:adf:e3c5:0:b0:2cf:ee9d:ce2f with SMTP id
 k5-20020adfe3c5000000b002cfee9dce2fmr11808712wrm.19.1683030146536; Tue, 02
 May 2023 05:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <202304301606.Cgp113Ha-lkp@intel.com>
In-Reply-To: <202304301606.Cgp113Ha-lkp@intel.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 2 May 2023 14:22:15 +0200
Message-ID: <CAHVXubg_PO2uab5ucLjhsFwDEnT+ov_G17ND7dtAosHxHJ8xjQ@mail.gmail.com>
Subject: Re: riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local'
 from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.rel.ro.local'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 10:30=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   825a0714d2b3883d4f8ff64f6933fb73ee3f1834
> commit: 26e7aacb83dfd04330673c5c9ac336560da52bb3 riscv: Allow to downgrad=
e paging mode from the command line
> date:   4 days ago
> config: riscv-randconfig-r005-20230430 (https://download.01.org/0day-ci/a=
rchive/20230430/202304301606.Cgp113Ha-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D26e7aacb83dfd04330673c5c9ac336560da52bb3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 26e7aacb83dfd04330673c5c9ac336560da52bb3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Driscv olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304301606.Cgp113Ha-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' fr=
om `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.=
rel.ro.local'
> >> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `a=
rch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_ind=
ex'
> >> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' fr=
om `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.=
rel.ro.local'
> >> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `a=
rch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_ind=
ex'
> >> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' fr=
om `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.=
rel.ro.local'
> >> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `a=
rch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_ind=
ex'
> >> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' fr=
om `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.=
rel.ro.local'
> >> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `a=
rch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_ind=
ex'

I thought I had caught all the orphan sections introduced with
kernel/pi, which is not the case: I have a fix that I'm testing.

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
