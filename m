Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5177673142D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbjFOJh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbjFOJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:37:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BD63C3F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:36:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8d65ecdb8so17213135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686821787; x=1689413787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IBv0/BNAr0Oc9p1PBcHm79LmC19CaoKl/uwYX0mfdM=;
        b=oMAydC3g3GzZoWd8RfevpVHXJQmIHxjv1pjmzeWKGhi0njvyC3+sYZjQ77SExm40n4
         Uz+vS+uAmHPg4CjEhVlpynZX0uy95Zr4wa9HnbiAAyDBCeQY7vkdM+J3ejdHHXS2F3Wl
         cIap9p+2MRhwbaRkOgbXpTvaURfYKxf3P0avRrCudn8gwv7hLJP4h/cas+51fSmgpQr4
         wUj9EqN/QTpd+AOw5aj8mR+N7Mdub8P4RMHGL2SnktRzp5aJPIP4JVcjbfSeVc1K6I9Z
         GCxb0s0MHTB+itLnY/bq7LfGW5ReEJJbonnb8MSsABVnx+tGNgi6PKBsjF19VRqbwhYz
         4Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686821787; x=1689413787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IBv0/BNAr0Oc9p1PBcHm79LmC19CaoKl/uwYX0mfdM=;
        b=hAcUKkeCpGwnbaTKUp1JPsGYNHMmpm2H6Uq2NXCJWjMmLEUcVco54uxhfv7tK796xS
         sC3bf4vEGWPUzHqUxw7O/b0c3XvRh9GPrsJZ6oOXwxOl1nrNcIHGRDhWS4EeSYToiSvX
         VqtfYTNFhsHn2x6gKK+CMmu8ZsdRvVulKtMIdCUtwOMqeTdAavgoF9wBGXeFrg92luAy
         afi1LEJdtkVeBAylxF8xnlXPTFQuOdV6F1FnDx4E+VZ6o6ceuwjzFdecmtv/p9XYzFTx
         YKN9sBa0QtAI6fh1AXgDtxZwqnX3Qhx/E5cvup202hO8nzLmyuY7P1+D7qgXIQOJ880o
         mrjA==
X-Gm-Message-State: AC+VfDyYYFauB1mQE/tLGdftYiuhLhbt7eH1RO9aFPWskKTuOq0yIvDr
        nX0z/deTpwuih9CFsGEm+A2TUoE0xMEaFmABYFRPfQ==
X-Google-Smtp-Source: ACHHUZ5Xr4a7B00EWkX/6qAhyNdm3PQK9SIUx5ZG3WIhbI5ZmacB2V1ZhcUYFBbPqNrE0nUds9pBIlGHUQtHYlwe7/U=
X-Received: by 2002:a5d:4743:0:b0:307:8879:6cc1 with SMTP id
 o3-20020a5d4743000000b0030788796cc1mr12874701wrs.71.1686821786944; Thu, 15
 Jun 2023 02:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <202306151631.3uZmHI1c-lkp@intel.com>
In-Reply-To: <202306151631.3uZmHI1c-lkp@intel.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 15 Jun 2023 11:36:16 +0200
Message-ID: <CAHVXubjdcYmFTqbE8AdB6=grmnxSuSM+VtwoSLagT0wBd=ZeEg@mail.gmail.com>
Subject: Re: riscv64-linux-ld: section .init.pi.text LMA [000000000197e820,0000000001981733]
 overlaps section .data..percpu LMA [0000000001951000,0000000001b219d7]
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
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

On Thu, Jun 15, 2023 at 10:30=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   b6dad5178ceaf23f369c3711062ce1f2afc33644
> commit: 3b90b09af5be42491a8a74a549318cfa265b3029 riscv: Fix orphan sectio=
n warnings caused by kernel/pi
> date:   5 weeks ago
> config: riscv-randconfig-r004-20230615 (https://download.01.org/0day-ci/a=
rchive/20230615/202306151631.3uZmHI1c-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=3D1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D3b90b09af5be42491a8a74a549318cfa265b3029
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 3b90b09af5be42491a8a74a549318cfa265b3029
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.3.0 ~/bin/ma=
ke.cross W=3D1 O=3Dbuild_dir ARCH=3Driscv olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.3.0 ~/bin/ma=
ke.cross W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306151631.3uZmHI1c-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    riscv64-linux-ld: section .data LMA [0000000000261000,00000000007d98cf=
] overlaps section .text LMA [00000000000a7a50,000000000197e81f]
> >> riscv64-linux-ld: section .init.pi.text LMA [000000000197e820,00000000=
01981733] overlaps section .data..percpu LMA [0000000001951000,0000000001b2=
19d7]
> >> riscv64-linux-ld: section .init.pi.rodata.str1.8 VMA [ffffffff821f3ed0=
,ffffffff821f3f3a] overlaps section .data VMA [ffffffff82000000,ffffffff825=
788cf]

That's a XIP config, nothing to worry about.

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
